---
title: "计划用户请求"
linkTitle: "计划用户请求"
date: 2025-06-27
weight: 10
description: >
  计划用户请求。
---

{{% pageinfo %}}
本文档是[计划 TTO 开始](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay)教程的高级补充，探讨已识别局限性的解决方案。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay2)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已阅读[计划 TTO 开始](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay)教程

## 探讨的问题

本教程探讨以下问题：

- 为什么使用 `AfterInsert` 而不是 `iApplicationExtension`
- 如何在创建后、处于 `new` 或 `scheduled` 状态时处理计划日期的修改
- 如何防止其他转换被提议

## 问答

### 为什么自动切换到 "scheduled" 状态？

这种机制也用于[自动分派工单到团队](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)和[审批流程自动化](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。

您也可以将此转换作为用户选择提供，并在该转换上使 `planned_date` 字段必填。但如果与审批流程自动化结合使用，用户将无法为正在审批中的用户请求安排计划，除非在审批后安排。

### 创建带日期的用户请求后执行 Assign 操作导致 Fatal Error，如何避免？

扩展"自动分派工单到团队"和"审批流程自动化"会在控制台中隐藏可能导致失败的其他操作（如"Assign"、"Dispatch"、"Wait for approval"等）。

可以通过以下方式避免：

**方式一：重载 `DisplayBareProperties()`**

```php
function DisplayBareProperties(WebPage $oPage, $bEditMode=false, $sPrefix='', $aExtraParams=array())
{
    $aFieldsMap = parent::DisplayBareProperties($oPage, $bEditMode, $sPrefix, $aExtraParams);
    if ($bEditMode && $oObject->GetState()='new')
    {
        $oPage->add_ready_script(
<<<EOF
    $('button.action[name="next_action"]').hide();
EOF
        );
    }
    return $aFieldsMap;
}
```

**方式二：实现 `iApplicationUIExtension`（`OnDisplayProperties()`）**

```php
public function OnDisplayProperties($oObject, WebPage $oPage, $bEditMode = false)
{
   if ($bEditMode && $oObject instance of UserRequest && $oObject->GetState()='new')
   {
      $oPage->add_ready_script(
<<<EOF
    $('button.action[name="next_action"]').hide();
EOF
      );
   }
}
```

### 覆盖风险

定义 DBObject 可覆盖方法时，需注意标准 iTop 数据模型中可能已定义了相同方法。如果在 setup/toolkit 编译时添加 `_delta="define"` 的方法已存在，将会失败。此时可以使用 "redefine"，但必须镜像现有代码，否则会破坏 iTop 的当前行为。

标准数据模型中 `UserRequest` 类已定义的方法示例：

```php
public function ComputeValues()
{
    $this->Set('priority', $this->ComputePriority());
    return parent::ComputeValues();
}
public function DoCheckToWrite()
{
    parent::DoCheckToWrite();
    if (!$this->IsNew() && ($this->Get('parent_request_id') == $this->GetKey()))
    { $this->m_aCheckIssues[] = Dict::Format('Class:UserRequest/Error:CannotAssignParentRequestIdToSelf'); }
}
protected function OnInsert()
{
    $this->ComputeImpactedItems();
    $this->SetIfNull('last_update', time());
    $this->SetIfNull('start_date', time());
}
protected function OnUpdate()
{
    parent::OnUpdate();
    $aChanges = $this->ListChanges();
    if (array_key_exists('functionalcis_list', $aChanges))
       {  $this->UpdateImpactedItems();  }
    $this->Set('last_update', time());
    $this->UpdateChildRequestLog();
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay2>

版本：3_2_0/customization/add-activation-delay2.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
