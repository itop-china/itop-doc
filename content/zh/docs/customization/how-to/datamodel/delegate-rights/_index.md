---
title: "委派管理员工具菜单"
linkTitle: "委派管理员工具菜单"
date: 2025-06-27
weight: 10
description: >
  委派管理员工具菜单。
---

{{% pageinfo %}}
本文档介绍如何将 "管理员工具" 菜单委派给非管理员用户。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:delegate_rights)。
{{% /pageinfo %}}

## 概述

从 iTop 2.5 开始，可以将管理员工具菜单授予非管理员用户。

## 限制

以下菜单**不能**委派给非管理员：

- Schedule Backup
- Log Management（除非使用 Log Management 2.0.1+）
- iTop Hub

某些类（如历史相关类）没有组织，因此向具有 "Allowed Organizations" 的用户提供 "Run Query" 访问权限会产生安全漏洞。

## 菜单可见性

从 XML 1.5 版本开始，可以基于类和操作权限控制任何菜单的访问。只有具有该类操作权限的人才能看到该菜单。

默认由类操作控制的管理菜单：

| 菜单 | 控制类 | 操作 |
|------|--------|------|
| Users | User | write |
| Profile | Profile | write |
| Notifications | Trigger | write |
| Audit | AuditCategory | write |
| Run Query | ResourceRunQueriesMenu | write |
| Query phrasebook | Query | write |
| Export | ResourceAdminMenu | write |
| Data Model | ResourceRunQueriesMenu | write |
| Universal Search | ResourceAdminMenu | write |
| Synchronization Data Sources | SynchroDataSource | write |

预定义组：

| 组 ID | 默认包含菜单 | 包含类 |
|-------|-------------|--------|
| User | 用户账户、配置文件 | User、URP_UserOrg、URP_UserProfile、URP_Profiles |
| Audit | 审计、运行查询 | AuditCategory、AuditRule、ResourceRunQueriesMenu |
| Notification | 通知、运行查询 | Trigger、Action、lnkTriggerAction、ResourceRunQueriesMenu |
| Query | 查询短语手册、运行查询 | Query、QueryOQL、ResourceRunQueriesMenu |
| SynchroData | 同步数据源 | SynchroDataSource |
| LogManagement | 日志中心 | ResourceLogMenu |
| AdminTools | 所有上述菜单 | 所有上述类 |

## 分步示例

将 "Export Menu" 委派给 "Config Manager" 配置文件：

### 创建抽象类

```xml
<class id="RessourceExportMenu" _delta="define">
  <parent>AbstractResource</parent>
  <properties>
    <comment>/* Export Menu access control. */</comment>
    <abstract>true</abstract>
    <category>grant_by_profile</category>
  </properties>
  <presentation/>
  <methods/>
</class>
```

### 覆盖菜单定义

```xml
<menu id="ExportMenu" xsi:type="WebPageMenuNode" _delta="must_exist">
  <enable_class _delta="redefine">RessourceExportMenu</enable_class>
  <enable_action _delta="redefine">UR_ACTION_MODIFY</enable_action>
</menu>
```

### 完成组和配置文件定义

```xml
<user_rights>
  <groups>
    <group id="Export" _delta="define">
      <classes>
        <class id="RessourceExportMenu"/>
      </classes>
    </group>
  </groups>
  <profiles>
    <profile id="3" _delta="must_exist">
      <groups>
        <group id="Export" _delta="define">
          <actions>
            <action id="action:write">allow</action>
          </actions>
        </group>
      </groups>
    </profile>
  </profiles>
</user_rights>
```

## 可创建的配置文件

以下是一些可创建的配置文件示例：

- **User Manager**（id=43）— 管理用户账户
- **Notification Manager**（id=44）— 管理触发器和动作
- **Audit Manager**（id=45）— 管理审计规则
- **Query Manager**（id=46）— 管理查询短语手册
- **SynchroData Manager**（id=47）— 管理同步数据源
- **Admin Tools Manager**（id=48）— 管理所有管理工具

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:delegate_rights>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/delegate_rights.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
