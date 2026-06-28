---
title: "在弹出菜单中添加条目"
linkTitle: "在弹出菜单中添加条目"
date: 2025-06-27
weight: 10
description: >
  通过 iPopupMenuExtension 接口在 iTop 弹出菜单中添加自定义条目。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 的弹出菜单（"其他操作..."）中添加自定义菜单条目。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-menu-sample)。
{{% /pageinfo %}}

## 概述

从 iTop 2.0.0 开始，框架支持在所有弹出菜单中添加新的菜单项，包括列表上的"其他操作..."和"工具包"菜单、对象详情页的"其他操作..."菜单、"注销"菜单等。

**前置条件**：需要具备 PHP 和 JavaScript 开发能力。

## 实现 iPopupMenuExtension 接口

要添加新的弹出菜单项，需要提供一个实现 `iPopupMenuExtension` 接口的 PHP 类。将该类文件添加到模块的 `datamodel` 文件列表中，确保其被正确加载。

### 模块定义

在 `module.sample-add-menu.php` 中声明数据模型文件：

```php
<?php
// iTop module definition file
//

SetupWebPage::AddModule(
    __FILE__,
    'sample-add-menu/',
    array(
        // Identification
        'label' => 'Add Menu Sample',
        'category' => 'business',

        // Setup
        'dependencies' => array(),
        'mandatory' => false,
        'visible' => true,

        // Components
        'datamodel' => array(
            'main.sample-add-menu.php',
            'model.sample-add-menu.php'
        ),
        'webservice' => array(),
        'data.struct' => array(),
        'data.sample' => array(),

        // Documentation
        'doc.manual_setup' => '',
        'doc.more_information' => '',

        // Default settings
        'settings' => array(),
    )
);
```

### 实现菜单扩展类

创建 `main.sample-add-menu.php`：

```php
<?php
/**
 * Sample extension to show how adding menu items in iTop
 * This extension demonstrates three possible types of menu items:
 * - URL 链接到任意网页
 * - JavaScript 函数调用
 * - 分隔线（水平线）
 */
class AddMenuSampleExtension implements iPopupMenuExtension
{
    /**
     * Get the list of items to be added to a menu.
     *
     * This method is called by the framework for each menu.
     * The items will be inserted in the menu in the order of the returned array.
     * @param int $iMenuId The identifier of the type of menu, as listed by the constants MENU_xxx
     * @param mixed $param Depends on $iMenuId, see the constants defined above
     * @return object[] An array of ApplicationPopupMenuItem or an empty array if no action is to be added to the menu
     */
    public static function EnumItems($iMenuId, $param)
    {
        $aResult = array();
        switch($iMenuId) // 要添加菜单项的菜单类型
        {
            /**
             * 在列表的操作菜单中插入条目
             * $param 是包含对象列表的 DBObjectSet
             */
            case iPopupMenuExtension::MENU_OBJLIST_ACTIONS:
                // 添加触发自定义 JS 函数的菜单项
                $sModuleDir = basename(dirname(__FILE__));
                $sJSFileUrl = utils::GetAbsoluteUrlModulesRoot().$sModuleDir.'/js/sample.js';
                $iCount = $param->Count(); // 对象集中的对象数量
                $aResult[] = new JSPopupMenuItem('_Custom_JS_', 'Custom JS Function On List...', "MyCustomJSListFunction($iCount)", array($sJSFileUrl));
                break;

            /**
             * 在列表的工具包菜单中插入条目
             * $param 是包含对象列表的 DBObjectSet
             */
            case iPopupMenuExtension::MENU_OBJLIST_TOOLKIT:
                break;

            /**
             * 在对象详情页的操作菜单中插入条目
             * $param 是当前显示的对象实例（DBObject）
             */
            case iPopupMenuExtension::MENU_OBJDETAILS_ACTIONS:
                // 为任意对象添加 "Google this..." 菜单，在新标签页打开 Google 搜索
                $aResult[] = new URLPopupMenuItem('_Google_this_', 'Google this...', "http://www.google.com?q=".$param->GetName(), '_blank');

                // 仅对 Contact（Team 和 Person）添加额外菜单项
                if ($param instanceof Contact)
                {
                    // 添加分隔线（仅 iTop 2.0.1-beta 及以上版本支持）
                    $aResult[] = new SeparatorPopupMenuItem();

                    // 添加触发自定义 JS 函数的菜单项
                    $sModuleDir = basename(dirname(__FILE__));
                    $sJSFileUrl = utils::GetAbsoluteUrlModulesRoot().$sModuleDir.'/js/sample.js';
                    $aResult[] = new JSPopupMenuItem('_Custom_JS_', 'Custom JS Function...', "MyCustomJSFunction('".addslashes($param->GetName())."')", array($sJSFileUrl));
                }
                break;

            /**
             * 在仪表盘菜单中插入条目
             * $param 是当前显示的仪表盘实例
             */
            case iPopupMenuExtension::MENU_DASHBOARD_ACTIONS:
                break;

            /**
             * 在用户菜单（页面右上角）中插入条目
             * $param 为 null
             */
            case iPopupMenuExtension::MENU_USER_ACTIONS:
                break;
        }
        return $aResult;
    }
}
```

### 自定义 JavaScript 函数

在 `js/sample.js` 中实现自定义函数：

```javascript
// 从自定义菜单项调用的示例 JS 函数
function MyCustomJSFunction(sName)
{
    // 简单弹出提示框
    alert(sName);
}

// 从列表菜单项调用的示例 JS 函数
function MyCustomJSListFunction(iCount)
{
    alert('There are '+iCount+' element(s) in this list.');
}
```

## 菜单类型常量

| 常量 | 说明 | $param 类型 |
|------|------|------------|
| `MENU_OBJLIST_ACTIONS` | 列表的"其他操作..."菜单 | DBObjectSet |
| `MENU_OBJLIST_TOOLKIT` | 列表的"工具包"菜单 | DBObjectSet |
| `MENU_OBJDETAILS_ACTIONS` | 对象详情页的"其他操作..."菜单 | DBObject |
| `MENU_DASHBOARD_ACTIONS` | 仪表盘菜单 | Dashboard |
| `MENU_USER_ACTIONS` | 用户菜单（右上角） | null |

## 菜单项类型

| 类型 | 类 | 说明 |
|------|-----|------|
| URL 链接 | `URLPopupMenuItem` | 打开指定 URL，可设置 target |
| JS 函数 | `JSPopupMenuItem` | 调用 JavaScript 函数，可加载外部 JS 文件 |
| 分隔线 | `SeparatorPopupMenuItem` | 水平分隔线（iTop 2.0.1+） |

## 安装扩展

1. 将扩展压缩包解压到 iTop 根目录的 `extensions` 文件夹中（如不存在则创建）
2. 确保 Web 服务器对 `extensions` 文件夹中的所有文件具有读取权限
3. 移除配置文件（`conf/production/config-itop.php`）的只读属性
4. 访问 `http://<itop-root>/setup` 重新运行 iTop 安装向导
5. 在安装向导最后一步的扩展列表中勾选 "Add Menu Sample"

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-menu-sample)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-menu-sample>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-menu-sample.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
