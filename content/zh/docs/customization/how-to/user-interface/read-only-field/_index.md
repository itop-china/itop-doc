---
title: "强制字段只读"
linkTitle: "强制字段只读"
date: 2025-06-27
weight: 10
description: >
  强制字段在创建和编辑时只读。
---

{{% pageinfo %}}
本文档介绍如何强制字段在创建和编辑表单中只读。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:read-only-field)。
{{% /pageinfo %}}

## 概述

本示例确保用户无法在 WorkOrder 对象上输入结束日期，因为其值已通过其他方式计算。

**前置条件**：熟悉教程中使用的语法。

## 实现方式

可以通过 ITSM Designer 或扩展实现。两种方式的主要区别在于将 PHP 代码集成到 iTop 中的方式：Designer 更快捷，扩展更灵活。

### 使用 Designer

需要具有 "Designer PHP developer" 角色。

### 使用扩展

必须已创建扩展。

## 使字段只读

需要重载两个方法：一个用于"创建表单"，一个用于"修改表单"。强制 `end_date` 在创建和修改时都只读。

```php
public function GetAttributeFlags($sAttCode, &$aReasons = array(), $sTargetState = '')
{
    // 在控制台编辑对象时调用此函数
    // 为对象的每个字段调用
    // 但仅修改单个字段的行为
    if ($sAttCode == 'end_date')
    {
        // 将新标志与父类设置的标志组合
        return(OPT_ATT_READONLY | parent::GetAttributeFlags($sAttCode, $aReasons, $sTargetState));
    }
    return parent::GetAttributeFlags($sAttCode, $aReasons, $sTargetState);
}

public function GetInitialStateAttributeFlags($sAttCode, &$aReasons = array())
{
    // 在控制台创建对象时调用此函数
    // 为对象的每个字段调用
    // 但仅修改单个字段的行为
    if (($sAttCode == 'end_date'))
    {
        // 将新标志与父类设置的标志组合
        return(OPT_ATT_READONLY | parent::GetInitialStateAttributeFlags($sAttCode, $aReasons));
    }
    // 其他字段由父类处理
    return parent::GetInitialStateAttributeFlags($sAttCode, $aReasons);
}
```

## 相关主题

- [对特定用户隐藏字段](../hide-field-on-profile/)
- [强制字段只读](../read-only-field/)

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:read-only-field)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:read-only-field>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/read-only-field.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
