---
title: "延迟后自动关闭"
linkTitle: "延迟后自动关闭"
date: 2025-06-27
weight: 10
description: >
  延迟后自动关闭。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现工单在"冻结"状态停留超过指定天数后自动关闭的功能。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:auto-close)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

自动关闭在 `frozen` 状态停留超过 21 天的工单。

需要完成：

- 添加带阈值和目标的计时器
- 编写计算方法
- 定义触发器和通知（可选，用于在自动关闭前通知客户）
- 客户回复且工单退出 `frozen` 状态时，重置计数器

## 添加计时器

在 `UserRequest` 类上添加计时器字段：

- 定义计时器运行的状态：`frozen`
- 使用 `DefaultWorkingTimeComputer`（默认 24×7，不关心业务时间和周末假期）
- 定义三个阈值（33%、66%、100%），可用于后续的触发器和通知
- 在 100% 阈值时，自动关闭工单

将以下内容放入扩展的 `datamodel.my-extension.xml` 文件中：

```xml
<field id="pending_customer_stopwatch" xsi:type="AttributeStopWatch" _delta="define">
  <states>
    <state id="frozen">frozen</state>
  </states>
  <working_time>DefaultWorkingTimeComputer</working_time>
  <thresholds>
    <threshold id="33">
      <actions/>
    </threshold>
    <threshold id="66">
      <actions/>
    </threshold>
    <threshold id="100">
      <actions>
        <action>
          <verb>ApplyStimulus</verb>
          <params>
            <param xsi:type="string">ev_resolve</param>
          </params>
        </action>
      </actions>
    </threshold>
  </thresholds>
  <always_load_in_tables>true</always_load_in_tables>
  <goal>ComputePendingDelay</goal>
</field>
```

## 计算方法

将以下内容放入扩展的 `main.my-extension.php` 文件中：

```php
class ComputePendingDelay implements iMetricComputer
{
  public static function GetDescription()
  {
    return "Used to compute delay when pending caller";
  }
  public function ComputeMetric($oObject)
  {
    $iDelay = MetaModel::GetModuleSetting('itop-request-mgmt', 'pending_delay', '21');
    $iRes = $iDelay * 86400;  // 天数 × 每天 86400 秒
    return $iRes;
  }
}
```

## 定义通知

使用上述示例，您可以创建触发器（基于阈值）和动作，当用户请求达到目标的 33%、66% 或 100% 时执行。这意味着您可以在不同阈值级别使用不同的邮件内容。

## 重置计数器

在退出 `frozen` 状态的任何转换上，可以重置计数器：

```xml
<state id="frozen" _delta="define">
  <flags>...</flags>
  <transitions>
    <transition id="ev_autoresolve">
      <stimulus>ev_autoresolve</stimulus>
      <target>resolved</target>
      <actions>
        <action>
          <verb>ResetStopWatch</verb>
          <params>
            <param xsi:type="attcode">pending_customer_stopwatch</param>
          </params>
        </action>
      </actions>
    </transition>
  </transitions>
</state>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:auto-close>

版本：3_2_0/customization/auto-close.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
