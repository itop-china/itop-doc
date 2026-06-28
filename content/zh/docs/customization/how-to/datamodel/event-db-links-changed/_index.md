---
title: "LinkedSet 相关值"
linkTitle: "LinkedSet 相关值"
date: 2025-06-27
weight: 40
description: >
    使用 EVENT_DB_LINKS_CHANGED 事件在 LinkedSet 内容变更时自动计算和更新宿主对象的依赖字段值。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 3.1+ 中处理 LinkedSet 相关值的计算与约束。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:event-db-links-changed)。
{{% /pageinfo %}}

## 场景

假设我们有一个 `Stock` 对象类，以及一个通过 1:n 关系与之关联的 `StockMove` 类：

- `Stock` 对象有可用商品数量
- 当有人要消耗库存中的某些商品时，创建一个带有所需数量的 `StockMove` 对象
- 如果所需数量超过库存中的可用商品，iTop 必须拒绝此消耗

**在 iTop 3.1 之前：** 可以在 `Stock` 类的 `OnUpdate` / `OnInsert` 中计算，但这假设没有其他方式可以在不编辑 `Stock` 对象的情况下创建/修改/删除 LinkedSet 中的对象。

**自 iTop 3.1 起：** 可以仅编辑关系，而宿主 `Stock` 对象处于只读模式，因此 `OnUpdate` / `OnInsert` 不会触发，计算值也不会更新。可以使用 `AttributeLinkedSet(Indirect)` XML 标签 `<edit_when>in_host_edition</edit_when>` 阻止在 `Stock` 对象只读时编辑 LinkedSet，但这不够用户友好。

下面介绍另一种替代方案。

## 计算 LinkedSet 依赖值

我们需要计算依赖于 `stockmoves_list` 这个 LinkedSet 属性的内容，并将其存储在 `Stock` 类上。

- 计算方法为 `ComputeAndUpdateStock()`，它计算并更新 `Stock` 字段 `remaining_quantity`
- `StockMove` 对象有一个指向 `MyClass` 的必填外部键，以及 `quantity` 和 `type`（表示是消耗还是补充库存）
- 我们希望无论 LinkedSet 内容以何种方式修改，该值始终保持最新
- `StockMove` 的创建、修改或删除都需要重新计算 `Stock` 的 `remaining_quantity`

实现步骤：

1. 在 LinkedSet 属性上标记 `<with_php_computation>true</with_php_computation>`
2. 监听 `EVENT_DB_LINKS_CHANGED` 事件并执行计算

```xml
<fields>
  <field id="stockmoves_list" xsi:type="AttributeLinkedSet">
    <ext_key_to_me>stock_id</ext_key_to_me>
    <linked_class>StockMove</linked_class>
    <tracking_level>none</tracking_level>
    <count_min/>
    <count_max/>
    <with_php_constraint>true</with_php_constraint>
    <with_php_computation>true</with_php_computation>
    <edit_mode>none</edit_mode>
  </field>
</fields>
<event_listeners>
  <event_listener id="OnLinksChanged" _delta="define">
    <event>EVENT_DB_LINKS_CHANGED</event>
    <callback>OnLinksChanged</callback>
    <rank>0</rank>
  </event_listener>
</event_listeners>
<methods>
```

```php
public function OnLinksChanged(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $this->ComputeAndUpdateStock();
    // $this->DBUpdate(); 在 $this 上不需要
    // 如果 ComputeAndUpdateStock() 修改了 $this，iTop 将自动执行 DBUpdate()
}
```

```php
protected function OnUpdate()
{
    $aChanges = $this->ListChanges();
 
    /* 不要在此计算，因为 EVENT_DB_LINKS_CHANGED 会被调用一次并执行计算
    if (array_key_exists('stockmoves_list', $aChanges)) {
        $this->ComputeAndUpdateStock();
    } */
}
```

## 阻止 LinkedSet 的无效变更

**目标：** 阻止导致库存为负值的 `StockMove` 创建/修改/删除。

当条件只能由宿主对象检查时，阻止对 `stockmoves_list` 的操作：

- 方法 `ComputeStock()` 计算库存的理论 "剩余数量"，但不更新 `remaining_quantity` 字段，仅用于检查
- 同样，`StockMove` 对象有指向 `MyClass` 的必填外部键、数量 `quantity` 和类型 `type`
- 我们希望阻止导致库存出现负值的 `StockMove` 创建/修改/删除

实现步骤：

1. 在 LinkedSet 上标记 `<with_php_constraint>true</with_php_constraint>`
2. 监听 `EVENT_DB_CHECK_TO_WRITE` 事件，在 LinkedSet 上检查条件，如需阻止则添加 Check Issue

```xml
<fields>
  <field id="stockmoves_list" xsi:type="AttributeLinkedSet">
    <ext_key_to_me>stock_id</ext_key_to_me>
    <linked_class>StockMove</linked_class>
    <tracking_level>none</tracking_level>
    <count_min/>
    <count_max/>
    <with_php_constraint>true</with_php_constraint>
    <with_php_computation>true</with_php_computation>
    <edit_mode>none</edit_mode>
  </field>
</fields>
<event_listeners>
  <event_listener id="CheckStockAvailability" _delta="define">
    <event>EVENT_DB_CHECK_TO_WRITE</event>
    <callback>CheckStockAvailability</callback>
    <rank>0</rank>
  </event_listener>
</event_listeners>
```

```php
public function CheckStockAvailability()
{
    // 如果所需数量在库存中不可用则停止
    // ComputeStock() 不修改 $this，仅计算
    if ($this->ComputeStock() < 0) {  
        // 添加 CheckIssue 将阻止链接对象的创建/修改或删除
        $this->AddCheckIssue(Dict::Format('Stock:Error:NotEnoughQuantityInStock'));
    }
}
```

## 其他用例

- 在机柜（Enclosure）中可以定义其总容量（U 大小）
- 机柜包含的设备也有 U 大小
- 一个设备只能位于单个机柜中
- 机柜上的 `devices_list` 是 LinkedSet 属性
- 可以使用上述方法阻止已安装设备的 U 大小总和超过机柜的 U 大小

## 局限性

假设在一个团队中，我们希望确保团队成员中男性和女性的数量 "相同，正负不超过两人"。

- 每次添加或删除成员时，规则会自动检查，当变更会破坏规则时阻止添加或删除
- 但可以通过更改某个团队成员的性别来绕过规则，因为此更改不会触发团队检查

> 如果删除一个人员，删除传播是否正确执行？如果团队引发了 CheckToWrite 问题，这是否会被阻止？

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:event-db-links-changed>

版本：3_2_0/customization/event-db-links-changed.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
