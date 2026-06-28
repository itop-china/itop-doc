---
title: "从 Ticket 中移除字段"
linkTitle: "从 Ticket 中移除字段"
date: 2025-06-27
weight: 10
description: >
  从 Ticket 中移除字段。
---

{{% pageinfo %}}
本文档介绍如何从 iTop 类中完全移除字段。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:remove-field)。
{{% /pageinfo %}}

## 概述

移除字段需要识别该字段在 iTop XML 数据模型中的所有使用位置。以 UserRequest 的 `urgency` 字段为例，需要检查：

- 字段定义（`fields/field@urgency`）
- 类属性（naming、order、reconciliation 等）
- 生命周期（lifecycle）
- 展示（presentation）
- 方法（methods）
- 门户表单（module_designs/module_design@itop-portal/forms）
- 字典条目
- OQL 查询（filter、Dashlets、Audit rules、Notifications 等）

> 移除标准数据模型中的字段可能破坏依赖该字段的 iTop 扩展的兼容性。

## 仅隐藏字段

在某些情况下，仅隐藏字段给用户可能已足够。

### 在门户中隐藏

创建表单时隐藏：

```xml
<form id="ticket-create" _delta="must_exist">
  <twig _delta="redefine">
    <div class="row">
      <div class="col-sm-6">
        <div class="form_field" data-field-id="impact"></div>
      </div>
      <div class="col-sm-6">
        <!-- 从默认门户中移除 urgency -->
        <!-- <div class="form_field" data-field-id="urgency"></div> -->
      </div>
    </div>
  </twig>
</form>
```

### 在控制台中隐藏

```xml
<presentation>
  <details _delta="must_exist">
    <items>
      <item id="col:col2">
        <items>
          <item id="fieldset:Ticket:Type">
            <items>
              <item id="urgency" _delta="delete"/>
            </items>
          </item>
        </items>
      </item>
    </items>
  </details>
</presentation>
```

> 仅隐藏不会完全移除字段，仍可通过 CSV 导出、列表配置、CSV 导入、REST/JSON API 访问。

## 完全移除字段

### 字段定义

```xml
<field id="urgency" _delta="delete">
</field>
```

### 类属性

检查 `urgency` 是否用于：
- friendlyname
- 协调字段（CSV 导入）
- 过时逻辑
- 唯一性规则

### 生命周期标志

```xml
<state id="resolved">
  <flags>
    <attribute id="urgency" _delta="delete"/>
  </flags>
</state>
```

### 方法

检查 PHP 方法中是否有 `$this->Get('urgency')` 引用。例如 `ComputePriority` 方法需要修改。

### 展示

从 `search`、`list` 和 `default_search` 中移除：

```xml
<presentation>
  <search>
    <items>
      <item id="urgency" _delta="delete"/>
    </items>
  </search>
</presentation>
```

### 字典条目

理论上应删除对应字典条目，但不删除不影响 iTop 行为。

### OQL 查询

检查以下位置是否使用了该字段：
- 数据模型中的 filter 标签
- Dashlets
- 查询短语
- 审计规则
- 书签 URL
- 通知
- 配置文件参数

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:remove-field>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/remove-field.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
