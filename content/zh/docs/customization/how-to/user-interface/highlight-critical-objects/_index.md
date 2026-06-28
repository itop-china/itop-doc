---
title: "高亮关键对象"
linkTitle: "高亮关键对象"
date: 2025-06-27
weight: 10
description: >
  在列表中突出显示关键对象。
---

{{% pageinfo %}}
本文档介绍如何在对象列表中高亮显示关键对象。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:highlight-critical-objects)。
{{% /pageinfo %}}

## 概述

本示例展示如何在列表中高亮显示某些关键对象实例，以便 iTop 用户快速识别它们。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 列表中的背景色

以下示例根据团队成员的角色为列表中的成员设置不同的颜色：

```php
/**
 * 此函数返回一个 'hilight' CSS 类，用于高亮表格中的某一行
 * 当前 CSS 中定义了 4 种可能的值：
 * HILIGHT_CLASS_CRITICAL, HILIGHT_CLASS_WARNING, HILIGHT_CLASS_OK, HILIGHT_CLASS_NONE
 * 可以像这里一样被派生类覆盖
 */
public function GetHilightClass()
{
    // 可能的返回值：
    // HILIGHT_CLASS_CRITICAL, HILIGHT_CLASS_WARNING, HILIGHT_CLASS_OK, HILIGHT_CLASS_NONE
    $current = parent::GetHilightClass(); // 默认计算

    switch ($this->Get('role_id_friendlyname')) {
        case 'Manager': $new = HILIGHT_CLASS_CRITICAL; break;
        case 'Support Agent': $new = HILIGHT_CLASS_OK; break;
        case 'Team leader': $new = HILIGHT_CLASS_WARNING; break;
    }
    // 比较父类返回的和新的高亮类，保留优先级更高的
    @$current = self::$m_highlightComparison[$current][$new];

    return $current;
}
```

## 高亮颜色

表格高亮颜色由两个 SCSS 变量控制，可以在 Designer 或扩展中修改：

| 高亮类 | 表格颜色 |
|--------|----------|
| HILIGHT_CLASS_CRITICAL | red |
| HILIGHT_CLASS_WARNING | orange |
| HILIGHT_CLASS_OK | green |

```scss
$ibo-vendors-datatables--row-highlight--colors:(
    'red': ($ibo-color-red-100),
    'danger': ($ibo-color-danger-200),
    'alert': ($ibo-color-red-200),
    'orange': ($ibo-color-orange-100),
    'warning': ($ibo-color-warning-200),
    'blue': ($ibo-color-blue-200),
    'info': ($ibo-color-information-200),
    'green': ($ibo-color-green-100),
    'success': ($ibo-color-success-200),
) !default;
```

### 自定义颜色

```xml
<variable id="ibo-vendors-datatables--row-highlight--colors" _delta="define">
('red': ($ibo-color-red-200),'danger': ($ibo-color-danger-300),'alert': ($ibo-color-red-300),'orange': ($ibo-color-orange-100),'warning': ($ibo-color-warning-200),'blue': ($ibo-color-blue-200),'info': ($ibo-color-information-200),'green': ($ibo-color-green-100),'success': ($ibo-color-success-200),)
</variable>
```

单行单个值，无换行，空白不影响，语法应与示例一致。

首单元格颜色：

```scss
$ibo-vendors-datatables--row-highlight--first-cell--colors:(
    'red': ($ibo-color-red-300),
    'danger': ($ibo-color-danger-400),
    'alert': ($ibo-color-red-400),
    'orange': ($ibo-color-orange-300),
    'warning': ($ibo-color-warning-400),
    'blue': ($ibo-color-blue-400),
    'info': ($ibo-color-information-400),
    'green': ($ibo-color-green-300),
    'success': ($ibo-color-success-300),
) !default;
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:highlight-critical-objects)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:highlight-critical-objects>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/highlight-critical-objects.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
