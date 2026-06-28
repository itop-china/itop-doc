---
title: "在列表上添加操作"
linkTitle: "在列表上添加操作"
date: 2025-06-27
weight: 10
description: >
  在对象列表上添加批量操作菜单。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 对象列表上添加自定义批量操作。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:bulk-edit-links)。
{{% /pageinfo %}}

## 概述

通过实现 `iPopupMenuExtension` 接口，可以在对象列表的"工具包"菜单中添加自定义批量操作。本文提供两个示例：批量编辑远程对象和批量编辑链接关系。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 批量编辑远程对象

本示例在 Problem 或 NormalChange 的 CI 关联列表上添加操作，直接打开批量修改界面，仅修改与该工单关联的 Application Solution。

```php
class AddModifyAllMenuPlugIn implements iPopupMenuExtension
{
   public static function EnumItems($iMenuId, $param) 
   {
      $aExtraMenus = array();
      if ($iMenuId ==  iPopupMenuExtension::MENU_OBJLIST_TOOLKIT && $param->GetFilter()->GetClass() === 'lnkFunctionalCIToTicket' ) {
         $oFilter = $param->GetFilter();
         $sClass = $oFilter->GetClass();
         $sOQL = $oFilter->ToOQL();
         if(str_contains($sOQL, "`Ticket`.`id` = :id")) {
            $oTicket = MetaModel::GetObject('Ticket',$oFilter->GetInternalParams()['id']);
            if(in_array(get_class($oTicket),['Problem','NormalChange'])) {
                if (UserRights::IsActionAllowed($sClass, UR_ACTION_BULK_MODIFY) != UR_ALLOWED_NO) {
                   $oApplicationQuery = DBSearch::FromOQL('SELECT ApplicationSolution');
                   $oApplicationQuery->AddCondition_ReferencedBy($param->GetFilter(), 'functionalci_id');
                   $aExtraMenus[] = new URLPopupMenuItem('ModifyAll::lnkFunctionalCIToTicket', 'Modify application solutions',
                      utils::GetAbsoluteUrlAppRoot()."pages/".cmdbAbstractObject::ComputeStandardUIPage($sClass)
                      ."?operation=select_for_modify_all&class=ApplicationSolution&filter=".urlencode('["'.$oApplicationQuery->ToOQL(true).'",{},[]]')
                   );
                }
            }
         }
      }
      return $aExtraMenus;
   }
}
```

## 批量编辑链接关系

如果您需要经常批量编辑 n:n 关系中的属性，而不想通过"运行查询"菜单执行以下操作：

```
SELECT lnkFunctionalCIToTicket WHERE ticket_id=:id
```

然后输入工单 ID 再批量修改结果链接，可以在 FunctionalCI 标签页上添加一个快速操作。

代码与上述示例非常相似，只需修改返回的类和过滤条件：

```php
             $oLnkQuery = DBSearch::FromOQL('SELECT lnkFunctionalCIToTicket');
                   $oLnkQuery->AddCondition('ticket_id', $oFilter->GetInternalParams()['id']);
                   $aExtraMenus[] = new URLPopupMenuItem('ModifyAll::lnkFunctionalCIToTicket', 'Bulk modify the Links',
                      utils::GetAbsoluteUrlAppRoot()."pages/".cmdbAbstractObject::ComputeStandardUIPage($sClass)
                      ."?operation=select_for_modify_all&class=lnkFunctionalCIToTicket&filter=".urlencode('["'.$oLnkQuery->ToOQL(true).'",{},[]]')
                   );
```

## 关键要点

- 使用 `MENU_OBJLIST_TOOLKIT` 在列表的工具包菜单中添加操作
- 通过 `$param->GetFilter()` 获取当前列表的过滤条件
- 使用 `AddCondition_ReferencedBy` 建立关联查询
- 使用 `cmdbAbstractObject::ComputeStandardUIPage` 生成标准 UI 页面 URL
- `operation=select_for_modify_all` 打开批量修改选择界面

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:bulk-edit-links)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:bulk-edit-links>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/bulk-edit-links.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
