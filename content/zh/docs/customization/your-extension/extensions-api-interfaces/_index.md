---
title: "Interfaces API"
linkTitle: "Interfaces API"
date: 2025-06-27
weight: 10
description: >
  Interfaces API。
---

{{% pageinfo %}}
本文档介绍 iTop 的扩展性接口，这是定制 iTop 行为的一种方式。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces)。
{{% /pageinfo %}}

## 概述

扩展性接口是定制 iTop 行为的一种方式。要了解其他方式，请查看[扩展性 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces)。

## 接口参考文档

有多个接口可用于扩展 iTop。每个接口对应一种特定类型的扩展。以下是一些示例：

| 接口 | 说明 |
|------|------|
| `iApplicationUIExtension` | 实现此接口以更改某些对象的 GUI 行为（显示详情或编辑对象时） |
| `iApplicationObjectExtension` | 在 CRUD 期间对对象执行特定操作的旧接口，已被事件处理取代 |
| `iPageUIBlockExtension` | 实现此接口以向任何 iTopWebPage 添加内容 |
| `iPortalUIExtension` | 实现此接口以向任何门户页面添加内容 |
| `iPopupMenuExtension` | 在控制台和门户中的 iTop 对象和列表上添加菜单项 |
| `iRestServiceProvider` | 向 REST API 添加动词 |

这些接口和抽象类定义在 `application/applicationextension.inc.php` 文件中。

参考文档：[扩展的 API 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces)

## iPopupMenuExtension 示例

假设我们有一个基于 Web 的应用程序，提供关于服务器可用性的高级报告。我们希望提供一个超链接，以便最终用户可以快速从 iTop 中的服务器详情跳转到监控应用程序中的相应报告。

一种可能的解决方案是在所有服务器的 "Actions" 弹出菜单中显示指向监控应用程序的超链接。

实现方式是实现 `iPopupMenuExtension` 接口：

```php
class MyPopupExtension implements iPopupMenuExtension
{
   public static function EnumItems($iMenuId, $param)
   {
      if ($iMenuId == self::MENU_OBJDETAILS_ACTIONS)
      {
         $oObject = $param;
         if ($oObject instanceof Server)
         {
             $sUID = 'MyPopupExtension-Monitoring'; 
             // 确保每个菜单项都有唯一的 "ID"
             $sLabel = 'Monthly report';
             $sURL = 'http://myapp/show_report?server_fqdn='.$oObject->Get('name');
             $sTarget = '_blank';
             $oMenuItem = new URLPopupMenuItem($sUID, $sLabel, $sURL, $sTarget);
             return array($oMenuItem);
         }
      }
      return array();
   }
}
```

`EnumItems` 方法将在多种情况下被 iTop 调用。显示对象详情时，`$params` 是目标对象。

由于我们的方法将对任何类型的对象调用，因此必须过滤掉不相关的对象类。

如您所见，同一个扩展可以处理多种类型的对象和多种类型的菜单（取决于 `$iMenuId` 和 `$param`）。

此插件的结果是在任何服务器的详情页面上添加一个额外的菜单条目。

## 其他示例

以下教程使用 iTop 接口 API：

- `iPopupMenuExtension`：[在"其他操作"弹出菜单中添加条目](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-menu-sample)
- `iPopupMenuExtension`：[在列表上添加操作](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-menu-sample)
- `iBackofficeStyleExtension`：[从活动面板中隐藏历史记录](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-history)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces>

版本：3_2_0/customization/extensions_api/interfaces.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
