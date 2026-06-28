---
title: "计算工单结束日期"
linkTitle: "计算工单结束日期"
date: 2025-06-27
weight: 10
description: >
  计算工单结束日期。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中自动计算工作订单（WorkOrder）的结束日期，即开始日期加固定延迟（如 2 小时）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:compute-field)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

自动计算工作订单的结束日期，为其开始日期加上固定的 2 小时延迟。

## 实现方式

- **使用 Designer**：需要具有 Designer PHP developer 权限
- **使用扩展**：需要已创建扩展

## 前提条件

默认情况下，WorkOrder 的结束日期是必填的。我们需要更改此逻辑，因为该数据将在保存后自动设置。

### 使用 Designer

在 Designer 中修改 `WorkOrder` 类的 `end_date` 字段，将 `is_null_allowed` 设为 `true`。

### 使用扩展

```xml
<class id="WorkOrder" _delta="must_exist">
  <fields>
    <field id="end_date">
      <is_null_allowed _delta="redefine">true</is_null_allowed>
    </field>
  </fields>
</class>
```

## 计算选项

计算无法通过 XML 完成，需要添加 PHP 方法。可以选择以下事件：

| 事件 | 可能的回调方法名 |
|------|----------------|
| 创建或更新前（EVENT_DB_BEFORE_WRITE） | `EvtBeforeWrite(Combodo\iTop\Service\Events\EventData $oEventData)` |
| 重新计算对象值（EVENT_DB_COMPUTE_VALUES） | `EvtComputeValues(Combodo\iTop\Service\Events\EventData $oEventData)` |

## 创建或更新前

### 回调方法

在创建或修改时，如果用户修改了开始日期，结束日期必须自动重新计算：

```php
public function EvtBeforeWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
   $oStartDate = new DateTime($this->Get('start_date'));
   $oEndDate = clone $oStartDate;
   $iDuration = 2*3600 ; // 2 小时（秒）
   $oEndDate->modify( '+'.$iDuration.' seconds');
   $this->Set('end_date',$oEndDate->Format(AttributeDateTime::GetInternalFormat()));
}
```

### 添加事件监听器

```xml
<class id="WorkOrder">
  <event_listeners>
    <event_listener id="EvtBeforeWrite" _delta="define">
      <event>EVENT_DB_BEFORE_WRITE</event>
      <rank>10</rank>
      <callback>EvtBeforeWrite</callback>
    </event_listener>
  </event_listeners>
</class>
```

## 重新计算对象值

另一个可用于计算字段的事件。逻辑与上述完全相同。

### 回调方法

```php
public function EvtComputeValues(Combodo\iTop\Service\Events\EventData $oEventData)
{
   $oStartDate = new DateTime($this->Get('start_date'));
   $oEndDate = clone $oStartDate;
   $iDuration = 2*3600 ; // 2 小时（秒）
   $oEndDate->modify( '+'.$iDuration.' seconds');
   $this->Set('end_date',$oEndDate->Format(AttributeDateTime::GetInternalFormat()));
}
```

### 添加事件监听器

```xml
<class id="WorkOrder">
  <event_listeners>
    <event_listener id="EvtComputeValues" _delta="define">
      <event>EVENT_DB_COMPUTE_VALUES</event>
      <rank>10</rank>
      <callback>EvtComputeValues</callback>
    </event_listener>
  </event_listeners>
</class>
```

## 设置字段只读

防止用户输入结束日期，因为上面已通过计算强制设置了其值。

### 回调方法

创建两个方法，分别控制创建表单和修改表单：

```php
public function evtSetInitialAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{   
  $this->ForceInitialAttributeFlags('end_date', OPT_ATT_READONLY); 
}
public function evtSetAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{   
  $this->ForceAttributeFlags('end_date', OPT_ATT_READONLY); 
}
```

### 添加事件监听器

```xml
<class id="WorkOrder">
  <event_listeners>
    <event_listener id="evtSetInitialFlags" _delta="define">
      <event>EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetInitialFlags</callback>
    </event_listener>
    <event_listener id="evtSetAttributeFlags" _delta="define">
      <event>EVENT_DB_SET_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetAttributeFlags</callback>
    </event_listener>
  </event_listeners>
</class>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:compute-field>

2025/05/16 15:23 by127.0.0.1

版本：3_2_0/customization/compute-field.txt · Last modified: 2025/05/16 15:23 by 127.0.0.1
