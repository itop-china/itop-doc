---
title: "修改数据模型"
linkTitle: "修改数据模型"
date: 2025-06-27
weight: 10
description: >
  修改数据模型。
---

{{% pageinfo %}}
本文档介绍如何通过扩展现有扩展或编写自定义扩展来修改 iTop 数据模型。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:start#changing_the_datamodel)。
{{% /pageinfo %}}

## 概述

iTop 支持通过以下两种方式定制数据模型：

- **添加现有扩展**：浏览已发布的扩展列表，按需安装。
- **编写自定义扩展**：创建 iTop 扩展模块，实现个性化需求。

## 基础知识

创建 iTop 扩展模块需要了解以下内容：

- [iTop 定制机制](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 理解如何扩展或修改 iTop
- [分步示例](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 创建您的第一个扩展
- [扩展骨架](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 新扩展的结构说明
- [API 搜索与操作对象](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [CRUD 事件](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 在对象上添加业务逻辑
- [事件 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 添加自定义事件（3.1 新增）
- [界面 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 自定义 GUI
- [XML 数据模型参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 与 [XML 门户参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [iTop 编码规范](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [FontAwesome v5](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 图标使用

## 数据模型修改示例

### 类、字段与关系

- [属性使用与限制](https://www.itophub.io/wiki/page?id=3_2_0:customization:attribute-limitation)
- [为 Server 类添加字段](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-attribute-sample)
- [(重新)定义字典条目](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dictionay-entry)
- [强制字段始终必填](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-always)
- [从 Ticket 中移除字段](https://www.itophub.io/wiki/page?id=3_2_0:customization:remove-field)
- [在 Team 上添加仪表盘](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashboard-attribute)
- [创建新的 CI 类：Monitor](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-class-sample)
- [定义依赖关系](https://www.itophub.io/wiki/page?id=3_2_0:customization:neighbours)
- [添加 1:1 关系](https://www.itophub.io/wiki/page?id=3_2_0:customization:one-to-one-relation)
- [n:n 自反与对称关系](https://www.itophub.io/wiki/page?id=3_2_0:customization:n-n-reflexive-relation)
- [追踪对象创建者](https://www.itophub.io/wiki/page?id=3_2_0:customization:tracking-creator)
- [合并状态](https://www.itophub.io/wiki/page?id=3_2_0:customization:meta-enum)
- [在 PHP 中添加 TagSet](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-value-to-tagset)
- [在 PHP 中添加日志条目](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-log-entry)
- [添加 n:n 关系](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-relation)

### 生命周期：状态、转换、秒表

- [添加状态和转换](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state-transition)
- [统计在某状态中花费的时间](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-state)
- [状态延迟后通知](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-stopwatch)
- [为 Physical Device 添加生命周期](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-lifecycle)
- [转换时字段必填](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-on-transition)
- [转换时执行动作](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter)
- [转换方法](https://www.itophub.io/wiki/page?id=3_2_0:customization:actions-on-transitions)

### 认证与权限

- [创建新配置文件](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-profile-sample)
- [委派管理员工具菜单](https://www.itophub.io/wiki/page?id=3_2_0:customization:delegate_rights)
- [定义密码策略](https://www.itophub.io/wiki/page?id=3_2_0:customization:password-policy)
- [实现密码过期](https://www.itophub.io/wiki/page?id=3_2_0:customization:password-expiration)
- [新的认证方式](https://www.itophub.io/wiki/page?id=3_2_0:customization:authentication)
- [用户保护](https://www.itophub.io/wiki/page?id=3_2_0:customization:user-protection)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:start#changing_the_datamodel>

Last modified: 2026/06/10 17:31 by127.0.0.1

版本：3_2_0/customization/start.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
