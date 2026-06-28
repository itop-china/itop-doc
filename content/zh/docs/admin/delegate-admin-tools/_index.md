---
title: "委派管理员工具"
linkTitle: "技巧：委派管理员工具"
date: 2025-06-27
weight: 41
description: >
  将部分管理员菜单委派给其他用户或角色。
---

{{% pageinfo %}}

先决条件：您必须熟悉教程中使用的语法，并且已经创建了一个扩展。

自 iTop 2.5 版本起，您可以将管理员菜单**授予管理员以外的用户**。

{{% /pageinfo %}}

## 限制

以下菜单不能授予管理员以外的任何人：

- 计划备份
- 日志管理（除非您有 Log Management 2.0.1+）
- iTop Hub

某些类（如所有与对象历史相关的类）没有组织，因此，向具有允许组织的用户提供运行查询的访问权限会产生安全漏洞，因为他们可以看到他们无权查看的对象的历史记录。

## 菜单可见性

自 XML 1.5 版本起，现在可以基于类和操作权限（读取、写入、删除等）控制对任何菜单的访问。只有对该类具有该操作权限的人才能看到此菜单。

有关自定义菜单的 XML 标签详细信息，请参阅 XML 参考。

以下管理员菜单默认由类上的操作控制：

- 用户：对 User 的写入
- 配置文件：对 Profile 的写入
- 通知：对 Trigger 的写入
- 审计：对 AuditCategory 的写入
- 运行查询：对 ResourceRunQueriesMenu 的写入
- 查询手册：对 Query 的写入
- 导出：对 ResourceAdminMenu 的写入
- 数据模型：对 ResourceRunQueriesMenu 的写入
- 通用搜索：对 ResourceAdminMenu 的写入
- 同步数据源：对 SynchroDataSource 的写入

上述所有类都可以通过配置文件（通过组）管理其访问权限。开箱即用，有 6 个新的**组**是预定义的，可以被现有或新的配置文件使用。LogManagement 组由扩展 iTop Log Management 引入。

| 组 ID | 默认包含的菜单 | 组中包含的类 |
|---|---|---|
| User | 用户账号、配置文件 | User、URP_UserOrg、URP_UserProfile、URP_Profiles |
| Audit | 审计、运行查询 | AuditCategory、AuditRule、ResourceRunQueriesMenu |
| Notification | 通知、运行查询 | Trigger、Action、lnkTriggerAction、ResourceRunQueriesMenu |
| Query | 查询手册、运行查询 | Query、QueryOQL、ResourceRunQueriesMenu |
| SynchroData | 同步数据源 | SynchroDataSource |
| LogManagement | 日志中心 | ResourceLogMenu |
| AdminTools | 上述所有菜单 | 上述所有类 |

- 编辑具有管理员配置文件的用户
- 将管理员配置文件授予用户

## 分步示例

假设您想让具有"Config Manager"配置文件的用户可以访问"导出菜单"：

- 没有明显的类来控制此菜单，我们将创建一个新的抽象类，命名为：'RessourceExportMenu'
- 我们将自定义"导出菜单"条目，将其绑定到这个新创建的类（将 'ResourceAdminMenu' 替换为 'RessourceExportMenu'）
- 我们将自定义"Config Manager"配置文件，通过一个新的组包含对类 'RessourceExportMenu' 的修改权限

### 创建抽象类

您可以使用现有的有意义的类来控制对该菜单的访问，但在"导出"的情况下，我们找不到任何令人满意的类，因此我们将创建一个新类。

新类必须：

- 继承 AbstractResource
- 具有类别 grant_by_profile

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
      <!-- id=3 对应 Configuration Manager 配置文件 -->
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

在 `datamodel.itop-profiles-itil.xml` 中检查现有配置文件的 id。

## 可以创建的配置文件

这些配置文件不存在，但您可以创建它们，以便将"管理工具"菜单委派给用户：

```xml
<user_rights>
    <profiles>
      <profile id="43" _delta="define">
        <name>User Manager</name>
        <description>create/modify/delete users...</description>
        <groups>
          <group id="User">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
              <action id="action:read bulk">allow</action>
              <action id="action:write bulk">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
      <profile id="44" _delta="define">
        <name>Notification Manager</name>
        <description>Has the rights to create and modify the triggers and actions</description>
        <groups>
          <group id="Notification">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
              <action id="action:read bulk">allow</action>
              <action id="action:write bulk">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
      <profile id="45" _delta="define">
        <name>Audit Manager</name>
        <description>Has the rights to create and modify the audit</description>
        <groups>
          <group id="Audit">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
              <action id="action:read bulk">allow</action>
              <action id="action:write bulk">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
      <profile id="46" _delta="define">
        <name>Query Manager</name>
        <description>Has the rights to create and modify the Query Phrasebook</description>
        <groups>
          <group id="Query">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
              <action id="action:read bulk">allow</action>
              <action id="action:write bulk">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
      <profile id="47" _delta="define">
        <name>SynchroData Manager</name>
        <description>Has the rights to create and modify the Synchro data source</description>
        <groups>
          <group id="SynchroData">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
              <action id="action:read bulk">allow</action>
              <action id="action:write bulk">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
      <profile id="48" _delta="define">
        <name>Admin Tools Manager</name>
        <description>Has the rights to Admin</description>
        <groups>
          <group id="AdminTools">
            <actions>
              <action id="action:write">allow</action>
              <action id="action:delete">allow</action>
              <action id="action:read">allow</action>
            </actions>
          </group>
        </groups>
      </profile>
    </profiles>
</user_rights>
```

## 技术细节

详细解释 2.5 版本围绕菜单访问所做的修改/添加：

### XML 中的"管理工具"菜单

管理员菜单以前完全用纯 PHP 编写，由 `isAdministrator()` 检查保护。它已被翻译成 XML，因此现在可以被覆盖。

菜单 XML 参考已得到丰富，可以指定访问菜单所需的类、操作甚至刺激。

当标签 `enable_admin_only` 设置为 1 时，任何提供的 `<enable_class>` 标签都会被忽略：只有具有管理员配置文件的用户才能看到此菜单。如果您想授予对 `enable_admin_only` 菜单的访问权限，必须将标签 `enable_admin_only` 设置为 0，或使用 `_delta="delete"` 完全删除该标签，并至少添加 `enable_class` 和 `enable_action` 标签。

该设计旨在保持与以前版本 iTop 的扩展兼容性。

WebPageMenuNode 需要针对直接访问进行保护（用户可能猜测网页的 URL 并尝试访问它，即使他没有看到菜单）。为此，每个网页都会检查 `ApplicationMenu::CheckMenuIdEnabled("MenuId");`，其中 MenuId 是菜单 xml 定义中使用的 id。这确保为了能够执行网页，用户必须有权访问相应的菜单。

### 新抽象类

某些管理员菜单没有任何逻辑类可以绑定，因此我们创建了专门用于控制此访问的新类。您可以根据需要扩展此列表。

| 类名 | 用途 |
|---|---|
| AbstractResource | 新的访问权限控制类应继承自 AbstractResource |
| ResourceRunQueriesMenu | 用于检查用户对"运行查询"菜单的访问权限 |
| ResourceAdminMenu | 默认用于所有没有适当类的菜单 |

#### bizmodel 与 grant_by_profile 类

组 * 包含所有具有 bizmodel 类别的类。某些配置文件具有对组 * 的读取访问权限。

具有类别 grant_by_profile 的类默认对管理员以外的用户不可访问。

- 用于控制"管理工具"菜单的应用类具有类别 grant_by_profile。
- 新的抽象类也具有类别 grant_by_profile。

### 授权矩阵中的更改

授权矩阵显示具有类别 grant_by_profile 或 bizmodel 的类。在 iTop 2.5 之前，只显示具有类别 bizmodel 的类。

示例：查看具有 User Manager 配置文件的用户的新授权矩阵条目。

### 新组

以下是 6 个预定义的新组，可以被现有或新的配置文件使用：

```xml
<user_rights>
  <group id="Notification" _delta="define">
    <classes>
      <!-- 此类列表也存在于 AdminTools 组中 -->
      <class id="Trigger"/>
      <class id="lnkTriggerAction"/>
      <class id="Action"/>
      <class id="ResourceRunQueriesMenu"/>
    </classes>
  </group>
  <group id="User">
    <classes>
      <!-- 此类列表也存在于 AdminTools 组中 -->
      <class id="User"/>
      <class id="URP_UserOrg"/>
      <class id="URP_UserProfile"/>
      <class id="URP_Profiles"/>
    </classes>
  </group>
  <group id="Audit">
    <classes>
      <!-- 此类列表也存在于 AdminTools 组中 -->
      <class id="AuditCategory"/>
      <class id="AuditRule"/>
      <class id="ResourceRunQueriesMenu"/>
    </classes>
  </group>
  <group id="Query">
    <classes>
      <!-- 此类列表也存在于 AdminTools 组中 -->
      <class id="Query"/>
      <class id="QueryOQL"/>
      <class id="ResourceRunQueriesMenu"/>
    </classes>
  </group>
  <group id="SynchroData">
    <classes>
      <!-- 此类列表也存在于 AdminTools 组中 -->
      <class id="SynchroDataSource"/>
      <class id="SynchroAttribute"/>
      <class id="SynchroReplica"/> <!-- 3.0 新增 -->
    </classes>
  </group>
</user_rights>
</itop_design>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:delegate_rights>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/delegate_rights.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
