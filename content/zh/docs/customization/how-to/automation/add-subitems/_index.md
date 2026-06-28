---
title: "获取解决延迟"
linkTitle: "获取解决延迟"
date: 2025-06-27
weight: 10
description: >
  获取解决延迟。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中获取考虑覆盖窗口（Coverage Window）的解决延迟，即统计工单在 TTR 中实际花费的工作时间（排除非工作时段）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-subitems)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已安装 [SLA considering business hours](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 扩展

## 计时器内部子项

计时器（Stopwatch）包含 4 个内部子项：

| 代码 | 标签 | 含义 |
|------|------|------|
| `timespent` | Elapsed | 在关联状态中花费的总时间（计时器运行时此值不准确） |
| `started` | Started | 计时器首次启动的时间 |
| `laststart` | LastStart | 计时器最后一次启动的时间（停止时为空） |
| `stopped` | Stopped | 计时器最后一次停止的时间（运行时为空） |

## 需求分析

`Resolution delay` 提供的是 `ttr_started` 和 `ttr_stopped` 之间的时间差，但这可能不是您想要的——它包含所有时间段（包括非工作时间）。

您需要的是支持团队实际花费在解决工单上的时间，排除覆盖窗口之外的时段。这正是计时器子项 `timespent` 所存储的值。

## iTop Essential & Professional

在 ITSM Designer 中：

1. 进入 `UserRequest` 类，点击新建字段图标
2. 在弹出窗口中选择：
   - 类型 = Stopwatch Value
   - 计时器 = 选择 `ttr`
   - 值 = Total time spent
3. 将该字段添加到展示/详情视图中

## iTop Community

创建 iTop 扩展，在 XML 中声明 `UserRequest` 类的字段：

```xml
<fields>
  <field id="ttr_timespent" xsi:type="AttributeSubItem" _delta="define">
    <target_attcode>ttr</target_attcode>
    <item_code>timespent</item_code>
  </field>
</fields>
```

无论是否在详情屏幕中显示，该字段都可在"自定义此列表"视图、Dashlet 和 OQL 查询中使用。

## 示例对比

- 计时器多次启动和停止，因此 "Elapsed" 不等于 "Started" 与 "Stopped" 的差值
- 7×60s + 49s = 469s：Provider time spent 只是 "Elapsed" 子项的友好显示

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-subitems>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-subitems.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
