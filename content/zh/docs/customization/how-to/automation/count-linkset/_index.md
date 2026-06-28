---
title: "存储 1:n 关系计数"
linkTitle: "存储 1:n 关系计数"
date: 2025-06-27
weight: 10
description: >
  存储 1:n 关系计数。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中持久化存储 1:n 关系的计数，例如在工单上统计关联的工作订单数量。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:count-linkset)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

在对象 A 的详情中显示通过一对多关系（类 B 上的外键指向 A）链接到对象 A 的对象 B 的数量。

将介绍两种场景：

- 在 Ticket 上统计关联的 WorkOrders
- 在 User Request 上统计子请求数量（特殊情况：类 A 和类 B 是同一个类）

这些信息在单个工单/用户请求的详情中很容易查看，但无法快速检索所有具有超过 2 个工作订单/子请求的工单，或没有工作订单/子请求的工单。本教程解释如何解决此问题。

## 工单上的工作订单

需要：

- 在 `Ticket` 类上创建 `count_workorders_list` 字段，永久存储数量以便查询
- `Ticket` 上有 `workorders_list` 字段，提供当前工单下的子请求列表
- `WorkOrder` 上有 `ticket_id` 字段，提供需要更新工作订单计数的工单

确定何时重新计算：

- 工作订单单独创建、修改或删除时
- 工作订单列表与工单本身同时修改时

```xml
<fields>
  <field id="workorders_list" xsi:type="AttributeLinkedSet">
    <with_php_computation _delta="force">true</with_php_computation>
  </field>
  <field id="count_workorders" xsi:type="AttributeInteger" _delta="define">
    <sql>count_workorders</sql>
    <default_value>0</default_value>
    <is_null_allowed>false</is_null_allowed>
    <tracking_level>all</tracking_level>
  </field>
<fields>
<event_listeners>
  <event_listener id="EvtOnLinksChanged" _delta="define">
    <event>EVENT_DB_LINKS_CHANGED</event>
    <callback>OnLinksChanged</callback>
    <rank>0</rank>
  </event_listener>
  <event_listener id="EvtBeforeWrite" _delta="define">
    <event>EVENT_DB_BEFORE_WRITE</event>
    <callback>BeforeWrite</callback>
    <rank>0</rank>
  </event_listener>
</event_listeners>
<methods>
```

```php
public function OnLinksChanged(?Combodo\iTop\Service\Events\EventData $oEventData)
{   // 注意方法声明中的 ?，允许使用 null 作为参数
    $oSet = $this->Get('workorders_list');
    $this->Set('count_workorders', $oSet->count());
    // $this->DBUpdate(); 当 $this 被修改时无用，因为回调结束时自动调用
}
public function BeforeWrite(?Combodo\iTop\Service\Events\EventData $oEventData)
{
    $aChanges = $this->ListChanges();
    if (array_key_exists('workorders_list', $aChanges)) {
        $this->OnLinksChanged(null); // 没有 EventData 可提供，但此方法中未使用
    }
}
```

当 WorkOrder 对象单独创建、删除或修改（而非在其工单修改的上下文中）时，回调 `Ticket::OnLinksChanged()` 将自动调用。

## 子用户请求

此用例与上述非常相似。由于类 A 和 B 相同，之前的方法有所不同，现在已不再是问题。

需要：

- 在 `UserRequest` 类上创建 `count_related_request_list` 字段，永久存储子请求数量以便查询
- `UserRequest` 上有 `related_request_list` 字段，提供当前请求下的子请求列表
- `UserRequest` 上有 `parent_request_id` 字段，提供父请求

```xml
<fields>
  <field id="related_request_list" xsi:type="AttributeLinkedSet">
    <with_php_computation _delta="force">true</with_php_computation>
  </field>
  <field id="count_related_request" xsi:type="AttributeInteger" _delta="define">
    <sql>count_related_request</sql>
    <default_value>0</default_value>
    <is_null_allowed>false</is_null_allowed>
    <tracking_level>all</tracking_level>
  </field>
<fields>
<event_listeners>
  <event_listener id="EvtOnLinksChanged" _delta="define">
    <event>EVENT_DB_LINKS_CHANGED</event>
    <callback>OnLinksChanged</callback>
    <rank>0</rank>
  </event_listener>
  <event_listener id="EvtBeforeWrite" _delta="define">
    <event>EVENT_DB_BEFORE_WRITE</event>
    <callback>BeforeWrite</callback>
    <rank>0</rank>
  </event_listener>
</event_listeners>
<methods>
```

```php
public function BeforeWrite(?Combodo\iTop\Service\Events\EventData $oEventData)
{
    $aChanges = $this->ListChanges();
    if (array_key_exists('related_request_list', $aChanges)) {
        $this->OnLinksChanged(null);
        // 切勿在回调中调用 $this->DBUpdate();，无用且被忽略
    }
}
public function OnLinksChanged(?Combodo\iTop\Service\Events\EventData $oEventData)
{
    $oSet = $this->Get('related_request_list');
    $this->Set('count_related_request', $oSet->count());
    // 仅在更新的对象不是 $oEventData->Get('object') 时调用 ->DBUpdate() 才有用
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:count-linkset>

2025/05/19 18:31 by127.0.0.1

版本：3_2_0/customization/count-linkset.txt · Last modified: 2025/05/19 18:31 by 127.0.0.1
