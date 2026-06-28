---
title: "仅对子类强制字段必填"
linkTitle: "仅对子类强制字段必填"
date: 2025-06-27
weight: 80
description: >
    使用事件机制在子类上强制父类定义的字段必填，解决数据模型无法直接覆盖父类属性的限制。
---

{{% pageinfo %}}
本文档介绍如何仅在子类上强制字段必填。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-subclass)。
{{% /pageinfo %}}

## 目标

此用例是强制提供字段的一种方式。

### 数据中心设备必填

在此用例中，我们希望 `PhysicalDevice` 类上声明的 `location_id` 字段仅在 `DatacenterDevice` 上必填。总结如下：

- 在 DatacenterDevice 下的所有类上位置必须必填：NAS、网络设备、SAN 交换机、服务器、存储系统、磁带库
- 在所有其他 PhysicalDevice 子类上位置保持可选，例如手机

**注意：** 在标准数据模型中，`DatacenterDevice` 是 `PhysicalDevice` 的子类之一，`location_id` 在 PhysicalDevice 上是可选字段。

此情况比较棘手，因为 iTop 数据模型不允许在子类上覆盖父类定义的属性。`location_id` 字段在 `PhysicalDevice` 类上声明，而 `DatacenterDevice` 是 `PhysicalDevice` 的子类。

```xml
<class id="DatacenterDevice">
  <fields>
    <field id="location_id">
      <is_null_allowed _delta="redefine">false</is_null_allowed>
    </field>
  </fields>
</class>
```

为解决此用例，我们必须订阅 2 个事件：一个用于"创建表单"，一个用于"修改表单"。

```xml
<class id="Server" _delta="must_exist">
  <event_listeners>
    <event_listener id="evtSetCreationFlags" _delta="define">
      <event>EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetCreationFlags</callback>
    </event_listener>
    <event_listener id="evtSetModificationFlags" _delta="define">
      <event>EVENT_DB_SET_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetModificationFlags</callback>
    </event_listener>
  </event_listeners>
```

我们在创建时强制要求提供位置，并在修改时阻止移除位置。位置仍可在对象修改表单中更改。

```php
public function evtSetCreationFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{  // 注意：创建时调用的方法与修改时不同         
   $this->ForceInitialAttributeFlags('location_id', OPT_ATT_MANDATORY);
}
public function evtSetModificationFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{  // 注意：修改时调用的方法与创建时不同
   $this->ForceAttributeFlags('location_id', OPT_ATT_MANDATORY);
}
```

**迁移注意：** 在设置上没有可见效果，但不符合规范的对象不能再在控制台或门户中修改，直到提供了位置。创建一个审计规则来检索不符合此新约束的对象并修复它们。

### 仅服务器和网络设备

在此用例中，我们希望 `location_id` 字段仅对 Server 和 NetworkDevice 必填，而对 PhysicalDevice 的其他子类不是必填。

解决方案与上述情况类似，只需在 `PhysicalDevice` 类上声明上述方法，并在每个 `Server` 和 `NetworkDevice` 类上订阅事件。

```php
public function evtSetCreationFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{          
   $this->ForceInitialAttributeFlags('location_id', OPT_ATT_MANDATORY);
}
public function evtSetModificationFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{
   $this->ForceAttributeFlags('location_id', OPT_ATT_MANDATORY);
}
```

```xml
<class id="Server">
  <event_listeners>
    <event_listener id="evtSetCreationFlags" _delta="define">
      <event>EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetCreationFlags</callback>
    </event_listener>
    <event_listener id="evtSetModificationFlags" _delta="define">
      <event>EVENT_DB_SET_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetModificationFlags</callback>
    </event_listener>
  </event_listeners>
</class>
<class id="NetworkDevice">
  <event_listeners>
    <event_listener id="evtSetCreationFlags" _delta="define">
      <event>EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetCreationFlags</callback>
    </event_listener>
    <event_listener id="evtSetModificationFlags" _delta="define">
      <event>EVENT_DB_SET_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetModificationFlags</callback>
    </event_listener>
  </event_listeners>
</class>
```

### 所有数据中心设备，但磁带库除外

此用例：我们希望 `location_id` 字段对所有 `DatacenterDevice` 必填，但磁带库除外。

解决方案与上述情况类似，只需在 `DatacenterDevice` 类上声明上述方法，并在函数中测试最终类是否不是 `TapeLibrary`。

以下是在 PHP 方法中获取和测试最终类值的方法：

```php
if ($this->Get('finalclass') != 'TapeLibrary') { ...
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-subclass>

版本：3_2_0/customization/mandatory-field-subclass.txt · Last modified: 2025/05/21 10:59 by 127.0.0.1
