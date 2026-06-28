---
title: "门户上的可选关系"
linkTitle: "门户上的可选关系"
date: 2025-06-27
weight: 10
description: >
  门户上的可选关系。
---

{{% pageinfo %}}
本文档介绍如何在门户中实现基于服务子类别的动态可选 n:n 关系。通过数据模型扩展和 PHP 代码覆盖 `GetAttributeFlags()` 方法来实现。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_dynamic_link)。
{{% /pageinfo %}}

## 概述

在本教程中，我们将介绍如何使 n:n 关系根据服务子类别动态可选。

## 使用场景

假设您希望在门户中创建用户请求时，要求用户选择某些应用解决方案，但仅针对某些服务子类别；对于其他服务子类别，您不希望用户被此选项打扰。

## 实现步骤

要实现此功能，需要执行以下步骤：

1. 在 **Service Subcategory** 上添加一个 `with_as` 字段（枚举 yes/no），用于存储是否必须向用户提示 n:n 关系 "Application Solutions"
2. 在 **UserRequest** 类上创建一个 `applicationsolutions_list` 的 LinkedSetIndirect，并使其依赖于 `servicesubcategory_id`
3. 在 **User Request** 上创建一个 ExternalField `with_as`，以从 `servicesubcategory_id` 获取等效字段
4. 修改 Ticket 的门户创建和编辑表单，添加 `applicationsolutions_list`
5. 覆盖 `UserRequest::GetAttributeFlags()` 以在适用时隐藏 `applicationsolutions_list`

## PHP 代码实现

```php
public function GetInitialStateAttributeFlags($sAttCode, &$aReasons = array())
{
       if (($sAttCode == 'applicationsolutions_list') && \ContextTag::Check(\ContextTag::TAG_PORTAL) && $this->Get('with_as') =='no')
        {
            return(OPT_ATT_HIDDEN | parent::GetInitialStateAttributeFlags($sAttCode, $aReasons));
        }
        return parent::GetInitialStateAttributeFlags($sAttCode, $aReasons);
}
 
public function GetAttributeFlags($sAttCode, &$aReasons = array(), $sTargetState = '')
{
        if (($sAttCode == 'applicationsolutions_list') && \ContextTag::Check(\ContextTag::TAG_PORTAL) && $this->Get('with_as') =='no')
        {
            return(OPT_ATT_HIDDEN | parent::GetAttributeFlags($sAttCode, $aReasons, $sTargetState));
        }
        return parent::GetAttributeFlags($sAttCode, $aReasons, $sTargetState);
}
```

## 代码说明

- `GetInitialStateAttributeFlags()`：在对象初始状态（创建时）确定属性标志
- `GetAttributeFlags()`：在对象生命周期中确定属性标志
- `\ContextTag::Check(\ContextTag::TAG_PORTAL)`：检查当前上下文是否在门户中
- `OPT_ATT_HIDDEN`：隐藏属性的标志
- 当 `with_as` 为 'no' 时，隐藏 `applicationsolutions_list` 字段

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_dynamic_link>

版本：3_2_0/customization/portal_howto_dynamic_link.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
