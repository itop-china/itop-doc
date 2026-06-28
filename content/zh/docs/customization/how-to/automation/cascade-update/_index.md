---
title: "级联更新"
linkTitle: "级联更新"
date: 2025-06-27
weight: 10
description: >
  级联更新。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现 1:n 关系的计算字段，例如统计工单上所有工作订单的时间花费总和。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-update)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

在类 A 上定义一个"计算"字段，该字段依赖于类 B 对象上定义的数据。例如：

- 在工单上统计所有工作订单（1:n）的时间花费总和
- 在工单上统计手动添加的 CI（n:n）数量
- 在 FunctionalCI 上设置位置字段：PhysicalDevice 直接使用位置，Logical Device 基于运行其上的 PhysicalDevice 计算位置

需要支持：

- 能够搜索该"计算"字段
- 能够对该"计算"字段运行审计

## 简单策略

实现此类"计算"字段（聚合 1:n 关系中的任意字段或计数 n:n 关系）的通用策略：

- 为了能够查询，必须将其存储在数据库中，因此设为持久字段
- 为确保始终准确，需要识别何时必须重新计算并执行

### 在类 A 上

- 编写方法，基于其他字段/相关对象计算"计算"字段的值。某些情况下可直接用作 EVENT_DB_LINKS_CHANGED 的回调
- 在 EVENT_DB_SET_INITIAL_ATTRIBUTE_FLAGS 上的回调方法：指定"计算"字段在创建表单中隐藏
- 在 EVENT_DB_SET_ATTRIBUTE_FLAGS 上的回调方法：指定"计算"字段在修改时只读
- EVENT_DB_LINKS_CHANGED 的回调，计算字段值并设置到对象上
- 将 LinkedSet 或 LinkedSetIndirect 字段的 `with_php_computation` XML 标志强制为 "true"

远程类无需操作，因为我们使用了事件和 `with_php_computation` XML 标志。

## 用例：1:n 求和

统计工单上所有工作订单的时间花费总和。

- 首先需要在 WorkOrder 和 Ticket 类上添加 `time_spent` 整数字段
- 为确保 `Ticket::time_spent` 始终准确，需要识别何时重新计算：
  - 工单更新时
  - 工作订单创建时 → 重新计算其工单
  - 工作订单更新时 → 重新计算其原工单和新工单
  - 工作订单删除时 → 重新计算其原工单

### 在 Ticket 类上

#### 事件监听器

| 事件 | 回调方法 |
|------|----------|
| EVENT_DB_BEFORE_WRITE | BeforeWrite() |
| EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS | HideTimeSpent() |
| EVENT_DB_SET_ATTRIBUTES_FLAGS | MakeTimeSpentReadOnly() |
| EVENT_DB_LINKS_CHANGED | ComputeTimeSpent() |

#### 激活 DB_LINKS_CHANGED

```xml
<class id="Ticket" _delta="must_exist">
  <fields>
    <field id="workorders_list">
      <with_php_computation _delta="force">true</with_php_computation>
    </field>
  </fields>
</class>
```

#### 回调方法

```php
protected function ComputeTimeSpent(?Combodo\iTop\Service\Events\EventData $oEventData)
{
   $iSum = 0;
   $oWorkOrderSet = $this->Get('workorders_list');
   while($oWorkOrder = $oWorkOrderSet->Fetch()) {
        $iSum += $oWorkOrder->Get('time_spent');
   }
   $this->Set('time_spent', $iSum);
}
public function BeforeWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
  $aChanges = $this->ListChanges();
  if (array_key_exists('workorders_list', $aChanges)) {
      $this->ComputeTimeSpent(null);
  }
}
public function HideTimeSpent(Combodo\iTop\Service\Events\EventData $oEventData)
{   
    $this->ForceInitialAttributeFlags('time_spent', OPT_ATT_HIDDEN ); 
}
public function MakeTimeSpentReadOnly(Combodo\iTop\Service\Events\EventData $oEventData)
{   
    $this->ForceAttributeFlags('time_spent', OPT_ATT_READONLY); 
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-update>

2025/05/21 11:01 by127.0.0.1

版本：3_2_0/customization/cascade-update.txt · Last modified: 2025/05/21 11:01 by 127.0.0.1
