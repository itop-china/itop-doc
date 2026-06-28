---
title: "排序转换"
linkTitle: "排序转换"
date: 2025-06-27
weight: 10
description: >
  自定义生命周期转换按钮的显示顺序。
---

{{% pageinfo %}}
本文档介绍如何自定义具有生命周期的对象转换按钮的显示顺序。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:order-transition)。
{{% /pageinfo %}}

## 概述

iTop 3.1 引入了转换按钮排序的新功能。

在 3.1 版本之前，给定状态下的转换按钮按 XML 声明顺序显示。

现在可以通过 iTop 配置参数 `lifecycle.transitions_sort_type` 指定排序方式：

| 排序类型 | 说明 |
|----------|------|
| **xml** | 默认值，与 3.1 之前的行为相同 |
| **alphabetical** | 按标签的字母顺序排序（不同语言可能有不同的顺序） |
| **fixed** | 基于"转换目标状态"的顺序排序。顺序始终相同，不受用户语言或当前对象状态影响 |
| **relative** | 基于"转换目标状态"的顺序排序，从当前状态上方开始，然后是当前状态，最后是下方。顺序随当前状态变化，最频繁使用的转换优先显示 |

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## Fixed 与 Relative 的区别

要使用这些逻辑，建议为状态定义 rank（状态是枚举属性的值）。从 iTop 3.1 开始，标准数据模型中所有具有生命周期的对象都已为状态设置了 rank。

假设有一个类具有以下状态（ranked）：1:New, 2:Dispatch, 3:Assign, 4:Resolve, 5:Close，以及这些状态之间的经典转换：

| 当前状态 | Relative 顺序 | Fixed 顺序 |
|----------|---------------|------------|
| New | Dispatch→Assign→Resolve→Close | Dispatch→Assign→Resolve→Close |
| Dispatch | Assign→Resolve→Close→Re-dispatch→Re-open | Re-open→Re-dispatch→Assign→Resolve→Close |
| Assign | Resolve→Close→Re-assign→Re-dispatch→Re-open | Re-open→Re-dispatch→Re-assign→Resolve→Close |
| Resolved | Close→Re-assign→Re-dispatch→Re-open | Re-open→Re-dispatch→Re-assign→Close |
| Closed | （无转换） | （无转换） |

## 配置

在 iTop 配置文件中设置：

```php
'lifecycle.transitions_sort_type' => 'relative',
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:order-transition)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:order-transition>

版本：3_2_0/customization/order-transition.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
