---
title: "添加生命周期状态"
linkTitle: "添加生命周期状态"
date: 2025-06-27
weight: 10
description: >
  添加生命周期状态。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 的用户请求生命周期中添加新状态（如"等待第三方"），并使用计时器统计在该状态停留的时间。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

跟踪每张工单等待第三方提供商的时间，需要：

- 在 `UserRequest` 类上添加计时器属性，统计工单处于 `pending_provider` 状态的时间
- 添加子项字段以显示等待提供商的时间
- 仅在特定状态下显示等待第三方的总时间

假设已添加 `pending_provider` 状态和相关转换。

## 使用 ITSM Designer（仅限 Combodo 客户）

### 添加计时器

1. 点击底部面板"Stopwatches"标题旁的小按钮创建计时器
2. 输入代码、标签，选择计时器运行的状态（此处为 `pending_provider`）

### 跟踪时间

在 `UserRequest` 类上点击新建字段图标：

- 字段 = `pending_provider_delay`
- 类型 = Stopwatch Value
- 计时器 = 选择 `pending_provider`
- 值 = Total time spent

### 显示计时器

将该字段添加到展示/详情视图中。在 Schema 标签中选择 `pending_provider_delay` 字段，在计时器不相关的状态中隐藏此字段。

## 使用 iTop 扩展

### 添加计时器

```xml
<!-- 添加计时器以统计在此状态停留的时间 -->
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

### 跟踪时间

此步骤**必须**执行，才能在表单中显示该信息并通过 OQL 查询。

```xml
<!-- 声明此计时器子项是显示或查询所必需的 -->
<field id="pending_provider_delay" xsi:type="AttributeSubItem" _delta="define">
  <target_attcode>providerstopwatch</target_attcode>
  <item_code>timespent</item_code>
</field>
```

可用的子项代码：`timespent`、`started`、`laststart`、`stopped`

```xml
<entry id="Class:UserRequest/Attribute:pending_provider_delay" _delta="define">
  <![CDATA[Provider time spent]]>
</entry>
```

### 显示计时器

在详情中显示计时器本身（仅用于理解其行为）：

```xml
<presentation>
  <details _delta="must_exist">
    <items>
      <item id="col:col0">
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
            <rank>20</rank>
          </item>
        </items>
      </item>
    </items>
  </details>
</presentation>
```

### 显示时间

时间仅在计时器停止时计算，因此：

- 不应在 `pending_provider` 状态中显示（信息不准确）
- 在 `new` 状态中不显示（无用且为空）
- 在工单已解决或关闭时显示，设为只读

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

## 完整 XML

```xml
<classes>
  <class id="UserRequest">
    <fields>
      <field id="status" _delta="must_exist">
        <values>
          <value id="pending_provider" _delta="define">pending_provider</value>
        </values>
      </field>
      <field id="providerstopwatch" xsi:type="AttributeStopWatch" _delta="define">
        <states>
          <state id="pending_provider">pending_provider</state>
        </states>
        <working_time/>
        <thresholds/>
        <always_load_in_tables>true</always_load_in_tables>
      </field>
      <field id="pending_provider_delay" xsi:type="AttributeSubItem" _delta="define">
        <target_attcode>providerstopwatch</target_attcode>
        <item_code>timespent</item_code>
      </field>
    </fields>
    <lifecycle>
      <stimuli>
        <stimulus _delta="define" id="ev_pending_provider" xsi:type="StimulusUserAction"/>
      </stimuli>
      <states>
        <state id="assigned" _delta="must_exist">
          <transitions>
            <transition id="ev_pending_provider" _delta="define">
              <stimulus>ev_pending_provider</stimulus>
              <target>pending_provider</target>
              <actions/>
            </transition>
          </transitions>
        </state>
        <state id="pending_provider" _delta="define">
          <flags />
          <transitions>
            <transition id="ev_assign">
              <stimulus>ev_assign</stimulus>
              <target>assigned</target>
              <actions/>
            </transition>
          </transitions>
          <inherit_flags_from>assigned</inherit_flags_from>
        </state>
        <state _delta="must_exist" id="new">
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
    <presentation>
      <details _delta="must_exist">
        <items>
          <item id="col:col0">
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
                <rank>20</rank>
              </item>
            </items>
          </item>
        </items>
      </details>
    </presentation>
  </class>
</classes>
<dictionaries>
  <dictionary id="EN US">
    <entries>
      <entry id="Class:UserRequest/Attribute:status/Value:pending_provider" _delta="define">
        <![CDATA[Pending provider]]>
      </entry>
      <entry id="Class:UserRequest/Attribute:pending_provider_delay" _delta="define">
        <![CDATA[Provider time spent]]>
      </entry>
      <entry id="Class:UserRequest/Stimulus:ev_pending_provider" _delta="define">
        <![CDATA[Wait for Provider]]>
      </entry>
      <entry id="Class:UserRequest/Attribute:providerstopwatch" _delta="define">
        <![CDATA[Provider stopwatch]]>
      </entry>
    </entries>
  </dictionary>
</dictionaries>
```

## 计时器行为

计时器在不同阶段的状态：

| 阶段 | 状态 | 说明 |
|------|------|------|
| 1. 从未启动 | 停止 | Elapsed 不可用 |
| 2. 首次进入 Pending provider | 运行中 | Elapsed 不可用；Started = LastStart |
| 3. 首次返回 Assigned | 停止 | Elapsed 可用；LastStart 为空；Stopped 已记录 |
| 4. 再次进入 Pending provider | 运行中 | Elapsed 不可用；Started 不变；LastStart 为最新启动时间 |
| 5. 再次返回 Assigned | 停止 | Elapsed 可用；LastStart 为空；Stopped 记录最新停止时间 |

**注意**：Elapsed 不等于 Started 与 Stopped 的差值，因为计时器可能多次启动和停止。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-state.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
