---
title: "在控制台中高亮状态"
linkTitle: "在控制台中高亮状态"
date: 2025-06-27
weight: 90
description: >
    使用 CSS 和 HTML 标记在控制台和门户中根据状态值以不同颜色高亮显示工单状态。
---

{{% pageinfo %}}
本文档介绍如何使用 CSS 在控制台和门户中根据状态值以不同颜色高亮显示工单状态。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:markup)。
{{% /pageinfo %}}

## 在控制台中高亮

在本教程中，使用 HTML 标记，我们将展示如何在控制台中根据状态值以不同颜色高亮显示工单状态。

为此，需要编写一些 CSS 并将其嵌入到 iTop 扩展模块中。我们假设您熟悉 CSS 代码。以下是一个 CSS 示例，更改状态为 'closed'、'rejected' 和 'accepted' 时的显示：

```scss
/* 定义一些颜色 */
$status-default-color: #757575 !default;
$status-default-bg-color: #DEDEDE !default;
$status-accepted-color: #FFFFFF !default;
$status-accepted-bg-color: #2F855A !default;
$status-closed-color: #757575 !default;
$status-closed-bg-color: #DEDEDE !default;
 
/* 定义一组可复用的属性 */
%status-icon{
        margin-right: 0.5rem;
        content: "";
        font-family: "Font Awesome 5 Free";
        font-weight: bold;
}
 
/* 在任何对象详情屏幕中，如果存在名为 'status' 的枚举字段 */
.object-details{
        *[data-attribute-type="AttributeEnum"][data-attribute-code="status"]{
                .field_label{
                        vertical-align: baseline;
                }
                .field_value{   /* 修改值的显示 */
                        display: inline-block;
                        padding: 0.25rem 0.6rem;
                        color: $status-default-color;
                        background-color: $status-default-bg-color;
                        border-radius: .25rem;
                }
                /* 如果值为 'accepted'，使用某些颜色 */
                &[data-value-raw="accepted"]{
                        .field_value{
                                color: $status-accepted-color;
                                background-color: $status-accepted-bg-color;
                                /* 在标签前添加一个 font awesome 图标 */
                                &::before{
                                        @extend %status-icon;
                                        content: "\f4fc";  /* 字体代码 */
                                }
                        }
                }
                /* 如果值为 'rejected' 或 'closed'，使用其他颜色 */
                &[data-value-raw="rejected"],
                &[data-value-raw="closed"]{
                        .field_value{
                                color: $status-closed-color;
                                background-color: $status-closed-bg-color;
                                font-weight: bold;
                        }
                }
        }
}
```

### 通过主题加载 CSS

为确保 iTop 使用您的 CSS，需要将其添加到 iTop 主题中：

```xml
<branding>
   <themes>     
      <theme id="light-grey">
         <stylesheets>
            <stylesheet id="my-module" _delta="define">my-module/asset/css/console.scss</stylesheet>
         </stylesheets>
      </theme>
   </themes>
</branding>
```

当然，可以扩展此定义以覆盖状态的每个值。可以对任何枚举（不仅是状态）执行此操作。可以将其限制为工单类。

## 在门户中高亮

### 在 PHP 中加载 CSS

由于 iTop 2.7 中的主题在门户中不起作用，无法使用 XML 配置告诉 iTop 何时为门户上传 CSS。因此我们将使用另一种方式。

在 `main.my-module.php` 或模块的任何 `.php` 文件中。使用新的扩展逻辑，将其放在：

```
my-module/src/Hook/PortalUIExtension.php
```

以下是复制代码：

```php
<?php
 
use iPortalUIExtension;
use RequestStatusBeautifierPortal;
use Symfony\Component\DependencyInjection\Container;
use utils;
 
/* AbsractPortalUIExtension 实现了 iPortalUIExtension，但没有任何行为 */
class MyModulePortalUIExtension extends AbsractPortalUIExtension
{
    const MODULE_CODE = 'my-module';
 
    public function GetCSSFiles(Container $oContainer)
    {
        $sModuleCSSFolderRelPath = 'env-'.utils::GetCurrentEnvironment().'/my-module/asset/css/';
        $sModuleCSSFolderAbsPath = utils::GetAbsoluteModulePath(static::MODULE_CODE).'asset/css/';
        $sAdditionalSCSSFileRelPath = $sModuleCSSFolderRelPath.'portal-additional.scss';
        $sAdditionalSCSSFileAbsPath = $sModuleCSSFolderAbsPath.'portal-additional.scss';
 
        $aCSSFiles = array(
                utils::GetAbsoluteUrlModulesRoot().static::MODULE_CODE.'/asset/css/portal.scss',
        );
 
        // 检查额外的 CSS 是否已编译
        clearstatcache();
        if (!file_exists($sAdditionalSCSSFileAbsPath) && (is_writable($sModuleCSSFolderAbsPath)))
        {
            // 获取额外的 SCSS
            $sAdditionalSCSS = '@import "../'.$sModuleCSSFolderRelPath.'variables.scss";'."\n";
            $sAdditionalSCSS .= RequestStatusBeautifierPortal::GetAdditionalSCSS();
            file_put_contents($sAdditionalSCSSFileAbsPath, $sAdditionalSCSS);
 
            $aCSSFiles[] = utils::GetAbsoluteUrlAppRoot().utils::GetCSSFromSASS($sAdditionalSCSSFileRelPath);
        }
        return $aCSSFiles;
    }
}
```

可以几乎复制粘贴此代码，只需更改：

- 类名
- module_code
- `.scss` 文件的名称和路径

不要忘记在模型中添加此 Hook 文件名：

```php
SetupWebPage::AddModule(
        __FILE__, // 当前文件的路径，所有其他文件名相对于包含此文件的目录
        'my-module/1.0.0',
        array(
                'datamodel' => array(
                        'model.my-module.php',
                        'src/Hook/PortalUIExtension.php',
[...]
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:markup>

版本：3_2_0/customization/markup.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
