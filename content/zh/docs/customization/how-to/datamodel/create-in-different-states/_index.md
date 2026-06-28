---
title: "额外的创建状态"
linkTitle: "额外的创建状态"
date: 2025-06-27
weight: 20
description: >
    允许在默认状态之外的其他生命周期状态中创建对象。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中允许对象在除默认状态外的其他生命周期状态中创建。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:create-in-different-states)。
{{% /pageinfo %}}

## 目标

假设我们有一个带有生命周期的 `Task` 类，默认情况下 `Task` 在 `new` 状态中创建。我们希望也允许在另一个状态 `template` 中创建 Task。

## 使用 Designer

**前提条件：** 必须是 Combodo 客户。

此操作只能由 Combodo 执行。

## 使用 iTop 扩展

**前提条件：** 请先查看 [添加状态和转换](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state) 教程。

在 `template` 状态声明中，只需添加 3 行即可：

```xml
<states>
  <state id="template">
    <initial_state_path>
      <state_ref _delta="define">new</state_ref>
    </initial_state_path>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:create-in-different-states>

版本：3_2_0/customization/create-in-different-states.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
