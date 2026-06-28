---
title: "丰富对象显示"
linkTitle: "丰富对象显示"
date: 2025-06-27
weight: 10
description: >
  通过 DisplayBareRelations 方法丰富对象详情页的显示。
---

{{% pageinfo %}}
本文档介绍如何通过 PHP 代码在对象详情页添加自定义内容、标签页和操作。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:display-bare-relation)。
{{% /pageinfo %}}

## 概述

通过重写 `DisplayBareRelations()` 方法，可以在对象详情页的关系标签页中添加自定义内容，如邮件链接、相关对象列表等。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 发送团队成员邮件

本示例在团队详情页的成员标签页中添加一个 `mailto` 链接，直接打开邮件客户端并将所有成员邮箱填入收件人字段。

```php
function DisplayBareRelations(WebPage $oPage, $bEditMode = false)
{
  // 必须调用父类方法，否则所有关系标签页都会丢失
  parent::DisplayBareRelations($oPage, $bEditMode);
  // 仅在只读模式下添加自定义内容
  if (!$bEditMode)
  {
    // 假设 Team 类有 'persons_list' 属性
    $oToNotify = $this->Get('persons_list');
    $aMailList = array();
    while ($oContact = $oToNotify->Fetch()) {
      $aMailList[] = $oContact->Get('email');
    }
    $sMailList = implode(', ', $aMailList);
    if ($sMailList != '')
    {
      // 通过标签名称查找特定标签页
      $sTabName = $oPage->FindTab('/^' . Dict::S('Class:Team/Attribute:persons_list') . '/');
      // 将该标签页设为当前标签页
      $oPage->SetCurrentTab($sTabName);
      // 在该标签页末尾添加超链接
      $sLink = "<br>&nbsp;<a href=\"mailto:?to={$sMailList}\">Open mailer</a>";
      $oPage->Add($sLink);
    }
  }
}
```

## 显示工单适用的已知错误

本示例在 UserRequest 详情页中添加一个标签页，显示与该工单相关的已知错误。已知错误与 UserRequest 没有直接的 LinkedSet 关系，但通过 FunctionalCI 可以间接关联。

```php
function DisplayBareRelations(WebPage $oPage, $bEditMode = false)
{
   // 必须调用父类方法，否则其他标签页不会显示
   parent::DisplayBareRelations($oPage, $bEditMode);
   // 仅在只读模式且 KnownError 类存在时
   if ((!$bEditMode) && (MetaModel::IsValidClass('KnownError')))
   {
      // 搜索与当前 UserRequest 相关的已知错误
      $iTicketID = $this->GetKey();
      // 使用 OQL 创建搜索定义
      $oSearch = DBObjectSearch::FromOQL("
         SELECT KnownError AS ke 
         JOIN lnkErrorToFunctionalCI AS l1 ON l1.error_id=ke.id 
         JOIN FunctionalCI AS ci ON l1.functionalci_id=ci.id 
         JOIN lnkFunctionalCIToTicket AS l2 ON l2.functionalci_id=ci.id 
         WHERE l2.ticket_id={$iTicketID}");
      // 获取已知错误对象集
      $oKnownErrorSet = new CMDBObjectSet($oSearch);
      $iNumberKE = $oKnownErrorSet->count();
      // 创建新标签页（可选择仅在存在已知错误时显示）
      if ($iNumberKE > 0)
      {
         $oPage->SetCurrentTab(Dict::S('Class:UserRequest:KnownErrorList') . " ({$iNumberKE})");
      }
      else {
         $oPage->SetCurrentTab(Dict::S('Class:UserRequest:KnownErrorList'));
      }
      // 创建列表模式的显示块
      $oBlock = new DisplayBlock($oKnownErrorSet->GetFilter(), 'list', false);
      $aExtraParam = array('menu' => true, 'display_limit' => false);
      $oBlock->Display($oPage, Dict::S('Class:UserRequest:KnownErrorList'), $aExtraParam);
   }
}
```

## 常见问题

**问题：对象显示不完整，关系标签页缺失？**

答案：请确保在方法中始终调用 `parent::DisplayBareRelations($oPage, $bEditMode);`。

**问题：标签页标题显示为 `Class:UserRequest:KnownErrorList`，如何修复？**

答案：需要为 `Class:UserRequest:KnownErrorList` 定义字典条目。

## 替代方案

除了重写 `DisplayBareRelations()` 方法，还可以使用：

- `iApplicationUIExtension` 接口的 `OnDisplayRelations()` 方法
- 添加新的操作菜单项

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:display-bare-relation)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:display-bare-relation>

版本：3_2_0/customization/display-bare-relation.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
