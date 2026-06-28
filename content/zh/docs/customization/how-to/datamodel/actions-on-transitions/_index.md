---
title: "转换方法"
linkTitle: "转换方法"
date: 2025-06-27
weight: 10
description: >
  转换方法。
---

{{% pageinfo %}}
本文档介绍在 iTop 生命周期转换中可用的预定义 PHP 方法及其参数。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:actions-on-transitions)。
{{% /pageinfo %}}

## 概述

在 XML 生命周期定制中，当对象发生特定转换时，可能需要执行某些动作。这些动作是对象类的 PHP 方法。您既可以编写自定义方法，也可以使用 DBObject 上已声明的现有方法。

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 参数说明

### $sAttCode

- 字符串类型，必须是当前类的有效属性代码
- 不提供有效性检查，若代码无效将导致致命错误
- 可在 XML 类定义的 `field id` 中找到
- 也可在 iTop 的数据模型查看器中找到，使用属性的**代码**而非标签

### $value

- 固定字面量值，通常为字符串，也可以是数字

## 可用方法

### AddValue($sAttCode, $iValue = 1)

递增或递减当前对象的字段值。

- 不对字段类型或值进行控制，无效组合将导致 iTop 崩溃
- `$value` 应为数字或浮点数，可为负数
- `$sAttCode` 应为 Decimal、Integer、Percentage 或 Duration 类型的属性代码

```xml
<actions>
  <action id="1">
    <verb>AddValue</verb>
    <params>
      <param id="1" xsi:type="string">assign_counter</param>
      <param id="2" xsi:type="integer">1</param>
    </params>
  </action>
</actions>
```

### Copy($sDestAttCode, $sSourceAttCode)

将当前对象的一个字段内容复制到另一个字段。

- 不检查属性代码的有效性和一致性
- 如需要会将 HTML 转换为文本
- 日期和数字自动转换为文本

### Reset($sAttCode)

将指定字段重置为默认值。

### ResetStopWatch($sAttCode)

重置秒表属性。

- 会验证是否为当前对象的秒表属性
- 清空 TimeSpent
- 重置后如同从未停止过
- 若正在运行，则从头开始计时

### Set($sAttCode, $value)

为指定属性设置固定值。不检查代码格式或值的有效性。

- 例如设置 Ticket 的 `caller_id` 时，`$value` 必须是 iTop 中存在的 Person 对象的数字 ID
- 枚举类型的 `$value` 应使用代码而非标签

```php
Set('caller_id', 6);
```

### SetIfNull($sAttCode, $value)

与 `Set` 相同，但如果字段已有值则保持不变。

### SetComputedDate($sAttCode, $sModifier = '', $sAttCodeSource = '')

从源日期（省略则使用当前时间）计算新日期，应用修饰符后复制到目标字段。

修饰符示例：

- `+5 days` — 5 天后
- `-3 weeks` — 3 周前
- `first weekday of next month` — 下月第一个工作日
- `monday of next week` — 下周一

### SetComputedDateIfNull($sAttCode, $sModifier = '', $sAttCodeSource = '')

与 `SetComputedDate` 相同，但如果字段已有值则保持不变。

### SetCurrentPerson($sAttCode)

将当前执行方法的用户的关联 Person 设置到指定字段。

- 若字段是指向 Person 类或其父类的外部键：复制关联 Person 的 ID
- 若字段是指向其他类的外部键：将导致崩溃
- 若字段是字符串：放入关联 Person 的友好名称

### SetCurrentDate($sAttCode)

将 Date 或 DateTime 属性设置为当前时间。

### SetCurrentDateIfNull($sAttCode)

与 `SetCurrentDate` 相同，但如果字段已有值则保持不变。

### SetElapsedTime($sAttCode, $sRefAttCode, $sWorkingTimeComputer = null)

检查 `itop/core/dbobject.class.inc.php` 中的代码了解详情。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:actions-on-transitions>

版本：3_2_0/customization/actions-on-transitions.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
