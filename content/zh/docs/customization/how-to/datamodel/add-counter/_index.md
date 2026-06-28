---
title: "转换时执行动作"
linkTitle: "转换时执行动作"
date: 2025-06-27
weight: 10
description: >
  转换时执行动作。
---

{{% pageinfo %}}
本文档介绍如何在工单状态转换时执行动作，以统计工单重新打开次数为例。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter)。
{{% /pageinfo %}}

## 概述

本用例演示如何统计用户请求被重新打开的次数。需要：

- 为用户请求添加计数器字段
- 可选：禁用历史追踪
- 修改生命周期，在从 `resolved` 到 `assigned` 的转换时调用方法
- 修改展示以显示计数器
- 为计数器字段添加标签

## 使用 ITSM Designer（Combodo 客户）

### 添加字段

1. 进入 UserRequest 类，在 Schema 标签页创建新字段
2. 字段代码：`reopen_counter`（仅小写字母，无空格或特殊字符）
3. 类型选择：**Number (Integer)**
4. 定义标签
5. 可选：禁用历史追踪

### 修改生命周期

1. 进入 Lifecycle 标签页
2. 在图中选择从 `resolved` 到 `assigned` 的转换
3. 在右侧面板点击动作列表底部的按钮
4. 在对话框中选择方法 `AddValue`
5. 目标字段选择 `reopen_counter`
6. 值输入 `1`

### 修改展示

进入 Presentation 标签页，将 `reopen_counter` 添加到 UserRequest 的详情视图中。

## 使用 iTop 扩展

### 添加计数器字段

```xml
<classes>
  <class id="UserRequest" _delta="must_exist">
    <fields>
      <field id="reopen_count" xsi:type="AttributeInteger" _delta="define">
        <sql>reopen_count</sql>
        <default_value>0</default_value>
        <is_null_allowed>true</is_null_allowed>
      </field>
    </fields>
  </class>
</classes>
```

### 禁用历史追踪（可选）

若不需要记录计数器每次变更的历史：

```xml
<field id="reopen_count">
  <tracking_level>none</tracking_level>
</field>
```

### 在转换时调用方法

在从 `resolved` 到 `assigned` 的转换时递增计数器：

```xml
<state id="resolved">
  <transitions>
    <transition id="ev_reopen">
      <actions _delta="redefine">
        <action>
          <verb>AddValue</verb>
          <params>
            <param xsi:type="attcode">reopen_count</param>
            <param xsi:type="int">1</param>
          </params>
        </action>
      </actions>
    </transition>
  </transitions>
</state>
```

### 声明自定义 PHP 方法

若预定义方法不满足需求，可创建自定义方法：

```php
public function MyLifecycleMethod($sAttCode, $iIncrement = 1)
{
    if (MetaModel::IsValidAttCode(get_class($this), $sAttCode)
        && is_numeric($iIncrement)
        && (MetaModel::GetAttributeDef(get_class($this), $sAttCode) instanceof AttributeInteger))
    {
        $iNew = $this->Get($sAttCode) + $iIncrement;
        $this->Set($sAttCode, $iNew);
    }
    return true;
}
```

### 添加展示

将计数器添加到 UserRequest 详情页的 SLA 报告字段集中：

```xml
<class id="UserRequest" _delta="must_exist">
  <presentation>
    <details>
      <items>
        <item id="col:col3">
          <items>
            <item id="fieldset:Ticket:SLA">
              <items>
                <item id="reopen_count" _delta="define">
                  <rank>80</rank>
                </item>
              </items>
            </item>
          </items>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

### 添加标签

```xml
<entry id="Class:UserRequest/Attribute:reopen_count" _delta="define">重新打开计数器</entry>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter>

版本：3_2_0/customization/add-counter.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
