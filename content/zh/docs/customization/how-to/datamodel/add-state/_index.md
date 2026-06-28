---
title: "统计在某状态中花费的时间"
linkTitle: "统计在某状态中花费的时间"
date: 2025-06-27
weight: 10
description: >
  统计在某状态中花费的时间。
---

{{% pageinfo %}}
本文档介绍如何使用秒表属性统计工单在特定状态中花费的时间。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state)。
{{% /pageinfo %}}

## 概述

本教程统计每张工单等待第三方提供商的时间。需要：

- 在 UserRequest 类上添加秒表属性，在 `pending_provider` 状态时计时
- 添加子项字段显示等待提供商的时间
- 仅在 UserRequest 的某些状态中显示总等待时间

假设已[添加 "pending_provider" 状态和 2 个转换](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state-transition)。

## 使用 ITSM Designer（Combodo 客户）

### 添加秒表

1. 点击 Stopwatches 标题旁的小按钮
2. 填写代码、标签，选择状态 `pending_provider`

### 追踪时间

1. 创建新字段，类型选择 **Stopwatch Value**
2. 选择秒表，值选择 **Total time spent**

### 显示秒表

将字段添加到展示/详情视图中。在 Schema 标签页中，在秒表不相关的状态中隐藏此字段。

## 使用 iTop 扩展

### 添加秒表

```xml
<field id="providerstopwatch" xsi:type="AttributeStopWatch" _delta="define">
  <states>
    <state id="pending_provider">pending_provider</state>
  </states>
  <working_time/>
  <thresholds/>
  <always_load_in_tables>true</always_load_in_tables>
</field>
```

```xml
<entry id="Class:UserRequest/Attribute:providerstopwatch" _delta="define">
  <![CDATA[Provider stopwatch]]>
</entry>
```

### 追踪时间

此步骤**必须**执行，才能在表单中显示或通过 OQL 查询：

```xml
<field id="pending_provider_delay" xsi:type="AttributeSubItem" _delta="define">
  <target_attcode>providerstopwatch</target_attcode>
  <item_code>timespent</item_code>
</field>
```

可用子项代码：`timespent`、`started`、`laststart`、`stopped`

```xml
<entry id="Class:UserRequest/Attribute:pending_provider_delay" _delta="define">
  <![CDATA[Provider time spent]]>
</entry>
```

### 显示秒表

```xml
<presentation>
  <details _delta="must_exist">
    <items>
      <item id="col:col1">
        <items>
          <item id="fieldset:Ticket:moreinfo">
            <items>
              <item id="pending_provider_delay" _delta="define">
                <rank>80</rank>
              </item>
              <item id="providerstopwatch" _delta="define">
                <rank>90</rank>
              </item>
            </items>
          </item>
        </items>
      </item>
    </items>
  </details>
</presentation>
```

### 按状态控制显示

- 在 `new` 状态中隐藏 `pending_provider_delay`（会传播到所有链式状态）
- 在 `resolved` 状态中设为只读

```xml
<lifecycle>
  <states>
    <state id="new" _delta="must_exist">
      <flags>
        <attribute id="pending_provider_delay" _delta="define">
          <hidden/>
        </attribute>
      </flags>
    </state>
    <state id="resolved" _delta="must_exist">
      <flags>
        <attribute id="pending_provider_delay" _delta="define">
          <read_only/>
        </attribute>
      </flags>
    </state>
  </states>
</lifecycle>
```

## 秒表行为

1. **从未启动**：所有子项为空
2. **首次进入 pending_provider**：秒表运行中，Elapsed 不可用，Started 和 LastStart 相等
3. **首次返回 assigned**：秒表停止，Elapsed 可用，Stopped 有记录
4. **再次进入 pending_provider**：秒表重新运行，Started 不变，LastStart 更新
5. **再次返回 assigned**：秒表停止，Elapsed 累计，注意不等于 Started 和 Stopped 的差值

秒表自动计算，用户不可编辑。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-state.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
