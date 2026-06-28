---
title: "强制字段必填"
linkTitle: "强制字段必填"
date: 2025-06-27
weight: 10
description: >
  强制字段必填的多种实现方式。
---

{{% pageinfo %}}
本文档介绍强制字段必填的不同技术方案。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field)。
{{% /pageinfo %}}

## 概述

根据需求不同，有多种方式可以强制字段必填。每种技术适用于不同的场景，教程会说明每种技术能控制哪些修改方式。

可能的修改方式包括：

- 控制台 - 对象创建/修改表单以及批量修改表单
- 门户 - 对象创建/修改表单
- CSV 导入 - 控制台和命令行
- DataSynchro
- REST/JSON API

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 第一系列：PhysicalDevice "Location" 字段必填

- Always mandatory for all sub-classes of PhysicalDevice
- Always mandatory but only for a subset of the PhysicalDevice sub-classes
- Mandatory for a given class, but only if the object respects a particular condition

## 第二系列：UserRequest "Service" 和 "Service subcategory" 字段必填或可选

- Mandatory on a transition or a state of the lifecycle
- Mandatory on the User Portal while it is not mandatory in the Console

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field>

2025/05/16 15:19 by127.0.0.1

版本：3_2_0/customization/mandatory-field.txt · Last modified: 2025/05/16 15:19 by 127.0.0.1
