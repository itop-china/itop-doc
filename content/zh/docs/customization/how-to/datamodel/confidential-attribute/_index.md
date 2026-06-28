---
title: "添加保密属性"
linkTitle: "添加保密属性"
date: 2025-06-27
weight: 10
description: >
    通过将保密字段放入独立类并控制访问权限，实现字段级别的保密属性。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中为特定对象添加保密属性，限制特定用户角色的读写访问。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:confidential-attribute)。
{{% /pageinfo %}}

## 目标

**需求：** 特定对象上的某些信息需要对部分用户限制可见性。

**约束：** 目前 iTop 按类和组织全局控制读取访问，没有字段级别的选项。

**方案：** 本教程提供一种实现保密属性的方式：

- 读取权限限制为具有特定角色的用户，其他用户只能看到 `*`
- 写入权限按角色分配
- 保密属性可以是任意类型：成本、HTML 描述、图片、案例日志等

## 设计概述

为确保该字段不被未授权用户读取，我们将其放入一个独立的类中。

> **注意：** 基于当前用户隐藏对象详情中的字段是一种虚假的安全性。通过配置对象列表中显示的字段，任何人都可以获取该字段的值。

实现步骤：

1. 创建保密类
2. 更新宿主类
3. 建立一对一关系的连接

## 保密类

这个新类只包含：

- 一个硬编码的友好名称 `******`
- 一个 `value` 字段，类型对应需要存储的保密值
- 一个指向宿主类的外部键（宿主类本应包含该保密属性）

该类必须设置 `category = grant_by_profile, application`：

- `grant_by_profile` 允许控制谁可以看到它。需要创建一个包含此新类的组，以及包含该组的配置文件
- `application` 将其从 "所有类" 组提供的读取访问中移除

定义一个摘要卡片，显示 "value" 和宿主对象的友好名称。

可以放在任何模块中，但放在宿主类所在的模块更合理。

- 防止从保密属性类编辑外部键 → 设为只读（2 个事件）
- 当不存在外部键时，通过 CheckToWrite 阻止创建此类对象（事件）
- 从表单中隐藏该字段，但将 `host_id_friendlyname` 放入表单以帮助记住正在修改的内容

## 宿主类

创建一个指向新创建类的外部键：

- 添加过滤器，只列出未分配的保密属性（实际上避免提供任何已有项）
- 确保 AfterWrite → 更新保密属性的外部键
- 当外部键 != 0 时阻止编辑，但仍可以更改其内容

在保密类上创建一个 LinkedSet 属性，使用外部键 `host_id`，并将其显示为 "properties"。

## 同步键

参考 [添加 1:1 关系](https://www.itophub.io/wiki/page?id=3_2_0:customization:one-to-one-relation)。

## 局限性

- 无法阻止保密属性的纯创建，可能导致孤儿值
- 无法在弹出窗口中编辑属性

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:confidential-attribute>

版本：3_2_0/customization/confidential-attribute.txt · Last modified: 2025/05/20 12:39 by 127.0.0.1
