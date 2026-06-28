---
title: "生命周期：转换时的标志"
linkTitle: "生命周期：转换标志"
date: 2025-06-27
weight: 10
description: >
  介绍 iTop 生命周期中状态转换时字段标志（mandatory、must_change、must_prompt）的配置与行为。
---

{{% pageinfo %}}
本文档介绍生命周期中状态转换时的字段标志配置。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:feature:lifecycle)。
{{% /pageinfo %}}

## 概述

自 2.4 版本起，当对象通过转换从源状态进入目标状态时，您可以定义在转换表单中哪些字段需要被记录（必填）、必须被更改或仅被提示。

## 状态上的标志

在状态上设置的 `must_change`、`must_prompt` 和 `mandatory` 标志适用于所有以该状态为终点的转换。

## 示例

例如，在一个工单（Ticket）上，有 3 个不同的转换以 `assigned` 状态为终点：

- 在 `assign` 转换期间，您希望提示用户输入必填的 `agent`（2.4 之前所有转换的默认行为）
- 在 `re-assign` 转换上，您希望强制更改 `agent`（自 2.4 起在 XML 中支持）
- 在门户上执行的 `re-open` 转换中，`agent` 字段甚至不应显示（自 2.4 起在增强门户中支持）
- 在 `assigned` 状态下，`agent` 在工单修改表单中应为只读模式，否则更改代理将不会触发与转换关联的操作（例如向新代理发送通知邮件）
- 一个字段现在可以在转换期间被设为必填，之前隐藏，之后只读，从而只允许具有允许运行该转换的角色的用户写入该字段

## 配置方法

示例 2：如何在 XML 中配置

```xml
<class id="UserRequest">
  <lifecycle>
    <states>
      <state id="assigned">
        <transitions>
          <transition id="ev_reassign">
            <target>assigned</target>
            <flags>
              <attribute id="agent_id">
                <must_change/>
              </attribute>
              <attribute id="team_id">
                <must_prompt/>
              </attribute>
            </flags>
          </transition>
```

## iTop 行为

控制台上的转换表单会根据数据模型中定义的标志自动构建。在门户上，可以覆盖自动表单，但空的必填字段不能被移除。

### 适用于转换的标志

对于对象的每个字段，iTop 会组合在转换上设置的所有标志以及最终状态上定义的 `Must_xxx` 和 `Mandatory` 标志（并忽略最终状态上的其他标志，如 `hidden`、`read_only`、`read_write`）。

### 转换表单

按以下顺序检查标志，并在第一个匹配处停止：

- `must_change`：以编辑模式显示，值必须更改且与之前不同
- `must_prompt`：以编辑模式显示
- 最终状态或转换上的 `mandatory`，且初始值为空：以编辑模式显示
- 转换上的 `read_only`：以只读模式显示该字段
- 如果以上情况均不符合：不在表单中显示该字段

表单验证：

- 转换上、最终状态上或字段定义上的 `mandatory` 标志：强制要求填写该字段
- 否则，字段可以留空

### 状态上的修改表单

- `Must Change`：强制在控制台上更改该字段（对门户无影响）
- `Must Prompt`：对控制台和门户均无影响

## 门户：定义转换表单

增强门户支持按转换定义特定表单。

```xml
<form id="ticket-reopen" _delta="define">
  <class>UserRequest</class>
  <fields/>
  <twig>
    <div>
      <div class="form_field" data-field-id="public_log" data-field-flags="mandatory"/>
      <div class="form_field" data-field-id="team_id" data-field-flags="hidden"></div>
      <div class="form_field" data-field-id="agent_id" data-field-flags="hidden"></div>
    </div>
  </twig>
  <modes>
    <mode id="apply_stimulus">
      <stimuli>
        <stimulus id="ev_reopen"/>
      </stimuli>
    </mode>
  </modes>
</form>
```

与门户中定义的任何其他表单一样，您可以在字段上设置标志以：

- 向门户用户隐藏字段，即使该字段在控制台中被提示

```html
<div class="form_field" data-field-id="xxxxx" data-field-flags="hidden"/>
```

- 强制门户用户在字段中输入值，即使该字段在控制台中不是必填的

```html
<div class="form_field" data-field-id="xxxxx" data-field-flags="mandatory"/>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:feature:lifecycle>

版本：3_2_0/feature/lifecycle.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
