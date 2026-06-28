---
title: "状态延迟后通知"
linkTitle: "状态延迟后通知"
date: 2025-06-27
weight: 10
description: >
  状态延迟后通知。
---

{{% pageinfo %}}
本文档介绍如何在工单在特定状态中停留超过指定时间后发送通知。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-stopwatch)。
{{% /pageinfo %}}

## 概述

当工单在 `assigned` 状态中超过 2 小时和 6 小时时分别通知相关人员。需要：

- 定义实现 `iMetricComputer` 的 PHP 类，计算固定延迟作为秒表目标
- 在 UserRequest 上添加秒表属性，在 `assigned` 状态时计时，使用固定目标
- 设置工作时间计算方式

## 使用 ITSM Designer（Combodo 客户）

### 定义目标

需要 "Designer PHP developer" 配置文件。定义 6 小时延迟，在 2 小时（33%）和 6 小时（100%）时通知：

```php
class FixedDelayMetric implements iMetricComputer
{
    public static function GetDescription()
    {
        return "iTop configurable delay in hours, 6 by default";
    }
    public function ComputeMetric($oObject)
    {
        $iRes = 3600 * MetaModel::GetConfig()->GetModuleSetting('itop-tickets', 'pending_delay', '6');
        return $iRes;
    }
}
```

在 iTop 配置文件中添加：

```php
$MyModuleSettings = array(
    'itop-tickets' => array(
        'pending_delay' => 36,
    ),
);
```

### 添加秒表

1. 创建秒表，选择状态 `assigned`
2. 在 33% 处添加阈值
3. 在 100% 处添加阈值

### 定义工作时间

- 使用 `DefaultWorkingTimeComputer` 进行 24x7 计时
- 使用 `SLAComputation` 考虑工作时段（通常仅适用于子工单类）

## 使用 iTop 扩展

### 定义目标

```php
class FixedDelayMetric implements iMetricComputer
{
    public static function GetDescription()
    {
        return "Fixed 6h delay";
    }
    public function ComputeMetric($oObject)
    {
        $iRes = 6 * 3600; // 目标以秒为单位
        return $iRes;
    }
}
```

### 添加秒表

```xml
<field id="fixdelay" xsi:type="AttributeStopWatch" _delta="define">
  <states>
    <state id="assigned">assigned</state>
  </states>
  <working_time>DefaultWorkingTimeComputer</working_time>
  <thresholds/>
  <goal>FixedDelayMetric</goal>
  <always_load_in_tables>true</always_load_in_tables>
</field>
```

```xml
<entry id="Class:UserRequest/Attribute:fixdelay" _delta="define">
  <![CDATA[6h Delay]]>
</entry>
```

## 配置通知

在 iTop 中定义基于阈值的触发器，并链接到通知动作。使用新创建的秒表 `fixdelay`，可用阈值为 33 和 100。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-stopwatch>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-stopwatch.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
