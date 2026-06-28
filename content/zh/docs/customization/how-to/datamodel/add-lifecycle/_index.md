---
title: "为类添加生命周期"
linkTitle: "为类添加生命周期"
date: 2025-06-27
weight: 10
description: >
  为类添加生命周期。
---

{{% pageinfo %}}
本文档介绍如何为 PhysicalDevice 类添加简单的生命周期。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-lifecycle)。
{{% /pageinfo %}}

## 概述

本教程演示如何为 PhysicalDevice 添加生命周期，使用现有的状态值并定义状态间的转换。

需要：

- 确定承载生命周期状态的枚举属性（若不存在则创建）
- 定义默认状态（对象创建时自动使用）
- 定义不同的状态和刺激事件
- 为每个状态定义：前一个状态（作为字段标志的基础）、可用的转换、字段的必填/只读/隐藏标志

## 使用 ITSM Designer（Combodo 客户）

1. 选择类，进入 **Lifecycle** 标签页，点击 **Add State** 图标
2. 选择用于存储生命周期状态的**枚举字段**
3. 点击 **Initialize**，枚举字段的现有值将被创建为状态
4. 若枚举有默认值，则作为**初始状态**；否则第一个值被使用（可随时修改）

## 使用 iTop 扩展

### 数据模型

PhysicalDevice 已有 `status` 枚举字段可用于承载生命周期。假设管理 4 个状态：implementation、production、obsolete、stock。标准数据模型中 CI 创建时状态为 production，这里改为 implementation：

```xml
<class id="PhysicalDevice">
  <fields>
    <field id="status">
      <default_value _delta="redefine">implementation</default_value>
    </field>
  </fields>
</class>
```

### 生命周期定义

添加生命周期标签、状态字段和状态列表：

```xml
<class id="PhysicalDevice" _delta="must_exist">
  <lifecycle _delta="define">
    <attribute>status</attribute>
    <stimuli>
      <stimulus id="ev_move2prod" xsi:type="StimulusUserAction"/>
      <stimulus id="ev_obsolete" xsi:type="StimulusUserAction"/>
      <stimulus id="ev_stock" xsi:type="StimulusUserAction"/>
    </stimuli>
    <states>
      <state id="implementation">
        <flags/>
        <transitions>
          <transition id="ev_move2prod">
            <stimulus>ev_move2prod</stimulus>
            <target>production</target>
            <flags/>
            <actions/>
          </transition>
        </transitions>
      </state>
      <state id="production">
        <flags/>
        <transitions>
          <transition id="ev_obsolete">
            <target>obsolete</target>
            <actions/>
          </transition>
          <transition id="ev_stock">
            <target>stock</target>
            <actions/>
          </transition>
        </transitions>
      </state>
      <state id="obsolete">
        <flags/>
        <transitions/>
      </state>
      <state id="stock">
        <flags/>
        <transitions>
          <transition id="ev_move2prod">
            <stimulus>ev_move2prod</stimulus>
            <target>production</target>
            <flags/>
            <actions/>
          </transition>
        </transitions>
      </state>
    </states>
  </lifecycle>
</class>
```

状态转换图：

```
implementation --ev_move2prod--> production --ev_stock--> stock
                                    |
                                    +--ev_obsolete--> obsolete
```

有关生命周期的更多可能性，请参阅 [XML 数据模型参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-lifecycle>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-lifecycle.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
