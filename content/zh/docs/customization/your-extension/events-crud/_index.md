---
title: "CRUD 事件"
linkTitle: "CRUD 事件"
date: 2025-06-27
weight: 10
description: >
  CRUD 事件。
---

{{% pageinfo %}}
本文档介绍 iTop 中通过事件实现 CRUD（创建、更新、删除）扩展性的机制，包括各事件的触发时机、可用数据和 API。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:extensibility:events_crud)。
{{% /pageinfo %}}

## 概述

CRUD 扩展性指在对象被创建、更新或删除时实现特定行为。这需要通过多种方式注入 PHP 代码。

- 对比：[Events、iApplicationObjectExtension 与 DBObject 方法](https://www.itophub.io/wiki/page?id=3_2_0:customization:event)
- 如何[用事件替换旧方案](https://www.itophub.io/wiki/page?id=3_2_0:customization:event)

## 事件监听器

为不同的 CRUD 事件注册监听器，可以在 ORM 操作期间添加功能。

| 事件 | 说明 | 创建/更新 | 删除 |
|------|------|-----------|------|
| 计算值 | 对象修改时计算字段值（可在 CRUD 外调用） | EVENT_DB_COMPUTE_VALUES | n/a |
| 写入前 | 操作开始前调用一次 | EVENT_DB_BEFORE_WRITE | 3.1.2 新增 EVENT_DB_ABOUT_TO_DELETE |
| 写入检查 | 检查请求的操作对该对象是否有效 | EVENT_DB_CHECK_TO_WRITE | EVENT_DB_CHECK_TO_DELETE |
| 写入后 | 数据库操作已完成（状态 OK） | EVENT_DB_AFTER_WRITE | EVENT_DB_AFTER_DELETE |
| 链接修改 | 创建/更新/删除 n-n 链接时，通知该链接指向的所有对象 | EVENT_DB_LINKS_CHANGED | n/a |

注册事件可以通过多种方式完成：[如何添加事件并监听以做出响应](https://www.itophub.io/wiki/page?id=3_2_0:customization:events_api)。

## 类上的事件

要查找给定类上可用的完整事件列表，请进入 iTop 的数据模型，打开类并转到 "events" 选项卡。

## 示例

- 教程：[使用事件实现 CheckToWrite](https://www.itophub.io/wiki/page?id=3_2_0:customization:check-to-write)

## 各事件详解

### 计算值（Compute Values）

对象修改时计算字段值（可在 CRUD 外调用）。

- **事件**：`EVENT_DB_COMPUTE_VALUES`
- **修改对象**：可以修改当前对象，无需调用 `DBWrite()` 保存修改，因为对象即将写入数据库
- **事件数据**：
  - `'object'`：当前对象
- **事件源**：当前对象的所有父类（直到 `cmdbAbstractObject`）
- **可用 API**：
  - 当前更改可通过 `DBObject::ListChanges()` 获取

### 写入前（Before Write）

在请求的操作开始前。在此阶段，可以修改当前对象。

- **事件**：
  - `EVENT_DB_BEFORE_WRITE`
  - `EVENT_DB_ABOUT_TO_DELETE`
- **修改对象**：
  - 对于**创建**和**更新**：可以修改对象值
  - 对于**删除**：对象保证会从数据库中删除。它仍然可用，但只读
- **事件数据**：
  - `'is_new'`：如果对象正在创建
  - `'object'`：当前对象
- **事件源**：当前对象的所有父类（直到 `cmdbAbstractObject`）

### 写入检查（Check to Write）

检查请求的操作对该对象是否有效。这可以在 CRUD 之外由控制台调用以检查唯一性规则。

- **事件**：
  - `EVENT_DB_CHECK_TO_WRITE`
  - `EVENT_DB_CHECK_TO_DELETE`
- **修改对象**：
  - 此时**不得**修改对象
  - 尝试对任何对象字段调用 `Set()` 将抛出 `CoreException`
- **事件数据**：
  - `'object'`：当前对象
  - `'is_new'`：如果对象正在创建
  - `'deletion_plan'`：当前 `DeletionPlan`，用于 `EVENT_DB_CHECK_TO_DELETE`
- **事件源**：当前对象的所有父类（直到 `cmdbAbstractObject`）
- **可用 API**：
  - 当前更改可通过 `DBObject::ListChanges()` 获取
  - 可以使用 `DBObject::AddCheckIssue()` 或 `DBObject::AddDeleteIssue()` 报告问题，这将阻止对象写入或从数据库删除
  - 可以使用 `DBObject::AddCheckWarning()` 报告警告，这**不会**阻止对象写入或从数据库删除

### 写入后（After Write）

请求的操作已在数据库中完成。在此阶段，可以将修改传播到其他对象。

- **事件**：
  - `EVENT_DB_AFTER_WRITE`
  - `EVENT_DB_AFTER_DELETE`
- **修改对象**：
  - 对于**创建**和**更新**：可以再次修改对象值，无需调用 `DBWrite()` 保存修改，因为如果在此阶段修改了对象，将调用延迟的 `DBUpdate()`。在这种情况下，将重新运行完整的**更新**过程（包括所有事件）
- **事件数据**：
  - `'changes'`：本次更新期间所做的更改数组（用于**更新**）
  - `'is_new'`：如果对象正在创建
  - `'object'`：当前对象
- **事件源**：当前对象的所有父类（直到 `cmdbAbstractObject`）
- **可用 API**：
  - 对于**更新**，当前更改也可通过 `ListPreviousValuesForUpdatedAttributes()` 获取

### 链接修改（Link Modified）

当创建、更新或删除 n-n 链接时，所有链接的对象（以及修改情况下之前链接的对象）都会收到事件通知。

- **事件**：`EVENT_DB_LINKS_CHANGED`
- **修改对象**：
  - 此时可以修改对象，需要调用 `DBUpdate()` 来持久化修改
- **事件数据**：
  - `'object'`：链接的对象
- **事件源**：链接对象的所有父类（直到 `cmdbAbstractObject`）

## ApplyStimulus 相关事件

### 事件

**3.1.2 新增**

管理允许的转换。仅允许减少当前对象状态中允许的转换。

- **事件**：`EVENT_ENUM_TRANSITIONS`
- **事件数据**：
  - `'object'`：刺激目标的对象
  - `'allowed_stimuli'`：当前状态中可用的刺激列表
- **事件源**：当前对象的所有父类（直到 `cmdbAbstractObject`），具有生命周期
- **可用 API**：
  - 唯一可能的操作是使用 `DBObject::DenyTransition()` 拒绝转换

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:extensibility:events_crud>

版本：3_2_0/extensibility/events_crud.txt · Last modified: 2025/05/19 16:06 by 127.0.0.1
