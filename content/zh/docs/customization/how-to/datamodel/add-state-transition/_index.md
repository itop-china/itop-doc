---
title: "添加状态和转换"
linkTitle: "添加状态和转换"
date: 2025-06-27
weight: 10
description: >
  添加状态和转换。
---

{{% pageinfo %}}
本文档介绍如何为 UserRequest 添加新状态和转换，以标识等待第三方提供商的状态。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state-transition)。
{{% /pageinfo %}}

## 概述

本教程将：

- 为 UserRequest 添加新状态，表示等待第三方提供商
- 添加新事件，将用户请求移入该新状态
- 添加两个转换，允许工单移入和移出此状态
- 为需要执行此转换的用户启用访问权限

## 使用 ITSM Designer（Combodo 客户）

### 创建新状态

1. 点击工具栏的 **Add State** 按钮
2. 填写必填属性并点击 **Create State**

### 添加事件

1. 点击 Events 标题旁的小按钮
2. 事件代码按约定命名为 `ev_xxxx`，如 `ev_pending_provider`
3. 类型选择 **End User action**（用户界面中可提议的转换）
4. 事件的标签将应用于所有使用该事件的转换

### 添加转换

1. 点击工具栏按钮或右键状态选择 **New Transition**
2. 选择起始状态、事件和目标状态
3. 点击 OK 创建新转换

### 启用访问权限

为 Support Agent 配置文件启用此权限：

1. 导航到 **User Rights** 主标签页
2. 点击 **Profiles** 子标签页
3. 选择 **Support Agent** 配置文件
4. 在 UserRequest 前点击编辑图标
5. 找到 `ev_pending_provider` 事件，将权限从 Undefined 改为 Allow

## 使用 iTop 扩展

### 声明新状态

```xml
<!-- 向现有 status 添加新状态值 -->
<field id="status" _delta="must_exist">
  <values>
    <value id="pending_provider" _delta="define">
      <code>pending_provider</code>
    </value>
  </values>
</field>
```

添加字典条目：

```xml
<entry id="Class:UserRequest/Attribute:status/Value:pending_provider" _delta="define">
  <![CDATA[Pending provider]]>
</entry>
```

### 添加事件（刺激）

```xml
<stimuli>
  <stimulus id="ev_pending_provider" xsi:type="StimulusUserAction" _delta="define"/>
</stimuli>
```

```xml
<entry id="Class:UserRequest/Stimulus:ev_pending_provider" _delta="define">
  <![CDATA[Wait for Provider]]>
</entry>
```

### 添加转换

```xml
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
    <flags/>
    <transitions>
      <transition id="ev_assign">
        <stimulus>ev_assign</stimulus>
        <target>assigned</target>
        <actions/>
      </transition>
    </transitions>
    <inherit_flags_from>assigned</inherit_flags_from>
  </state>
</states>
```

### 启用访问权限

```xml
<profile id="5" _delta="must_exist">
  <groups>
    <group id="UserRequest" _delta="must_exist">
      <actions>
        <action id="ev_pending_provider" _delta="define">allow</action>
      </actions>
    </group>
  </groups>
</profile>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state-transition>

版本：3_2_0/customization/add-state-transition.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
