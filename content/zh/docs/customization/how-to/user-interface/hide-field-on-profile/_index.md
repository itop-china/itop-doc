---
title: "对特定用户隐藏字段"
linkTitle: "对特定用户隐藏字段"
date: 2025-06-27
weight: 10
description: >
  根据用户角色控制字段的可见性和可编辑性。
---

{{% pageinfo %}}
本文档介绍如何对特定用户隐藏字段，使其无法查看和修改。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-field-on-profile)。
{{% /pageinfo %}}

## 概述

本示例展示如何对不具有特定角色的用户隐藏 Contract 的 cost 字段。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 实现方法

需要重写以下方法，阻止用户查看和修改 "cost" 值：

- `Get()`：阻止通过详情页、列表、CSV 导出或 REST 获取字段值
- `GetAttributeFlags()` 和 `GetInitialAttributeFlags()`：阻止在创建和修改表单中显示和编辑 "cost" 字段

### PHP 代码

```php
public function Get($sAttCode)
{
    // 每次请求对象属性时调用此函数
    if (($sAttCode == 'cost') && !(UserRights::HasProfile('Service Manager')))
    {
        // 如果不允许查看此字段，不返回真实内容
        return('****');
    }
    else return parent::Get($sAttCode);
}

public function GetAttributeFlags($sAttCode, &$aReasons = array(), $sTargetState = '')
{
    // 在控制台编辑对象时调用此函数
    // 为对象的每个字段调用

    // 获取父类设置的标志
    $iFlags = parent::GetAttributeFlags($sAttCode, $aReasons, $sTargetState);

    // 仅修改单个字段的行为
    if (($sAttCode == 'cost') && !(UserRights::HasProfile('Service Manager')))
    {
        // 使用 | 将新标志与现有标志组合
        $iFlags = (OPT_ATT_READONLY | OPT_ATT_HIDDEN | $iFlags);
    }
    return $iFlags;
}

public function GetInitialStateAttributeFlags($sAttCode, &$aReasons = array())
{
    // 在控制台创建对象时调用此函数
    if (($sAttCode == 'cost') && !(UserRights::HasProfile('Service Manager')))
    {
        return(OPT_ATT_READONLY | OPT_ATT_HIDDEN | parent::GetInitialStateAttributeFlags($sAttCode, $aReasons));
    }
    // 其他情况由父类处理
    return parent::GetInitialStateAttributeFlags($sAttCode, $aReasons);
}
```

### 效果

- cost 字段在视图、创建和修改表单中不显示
- 即使用户对该类具有批量写入权限，CSV 导入也无法写入 cost 字段
- REST/JSON API 访问也会受到限制

## 注意事项

- 是否需要同时设置 hidden 和 readonly 标志，还是 hidden 已隐含 readonly？
- 从 iTop 2.6.1 开始，CSV 导入在创建时已正确调用 `GetInitialAttributeFlags()`
- 目前无法阻止用户通过 dashlet 分组查看受保护的值

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-field-on-profile)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-field-on-profile>

版本：3_2_0/customization/hide-field-on-profile.txt · Last modified: 2025/05/20 12:42 by 127.0.0.1
