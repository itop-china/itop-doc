---
title: "创建新配置文件"
linkTitle: "创建新配置文件"
date: 2025-06-27
weight: 10
description: >
  创建新配置文件。
---

{{% pageinfo %}}
本文档介绍如何创建新的 iTop 配置文件以控制用户访问权限。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-profile-sample)。
{{% /pageinfo %}}

## 概述

本教程将创建两个新配置文件：

- **Read-Only Except Requests** — 允许浏览所有对象，但只能创建/修改用户请求
- **Read-Only No Portal Access** — 纯只读配置，允许浏览但禁止修改任何内容

## 使用 ITSM Designer（Combodo 客户）

### 创建新配置文件

1. 导航到 **User Rights** Designer 标签页
2. 点击工具栏中的创建按钮
3. 为新配置文件添加组
4. 为每个组定义权限：Allow（允许）、Undefined（未定义/不允许）、Denied（明确拒绝）

### 创建新组

若现有组不满足需求，可创建新组：

1. 点击工具栏中的创建按钮
2. 使用中心窗格的树状视图勾选要添加到组中的类

## 使用 iTop 扩展

### 创建模块

使用扩展创建向导：

| 标签 | 值 | 说明 |
|------|-----|------|
| 模块名称 | sample-add-profile | 以 `itop-` 和 `combodo-` 开头的名称保留 |
| 模块标签 | Add Profile Sample | 安装向导中显示的标签 |
| 模块版本 | 1.0.0 | 使用 X.Y.Z 三位版本号 |
| 类别 | business | 修改数据模型的模块使用 'business' 类别 |
| 依赖 | itop-profiles-itil/1.0.0 | 依赖 iTop ITIL 配置文件模块 |

### 声明新配置文件

编辑 `datamodel.sample-add-profile.xml`，在 `<user_rights>` 内添加：

```xml
<profiles>
  <profile id="50" _delta="define">
    <name>Read-Only Except Requests</name>
    <description>Users with this profile are allowed to browse through all objects in the application and to create/modify user requests (either through the portal or in the normal application)</description>
    <groups>
      <group id="Portal">
        <actions>
          <action id="write">allow</action>
          <action id="delete">allow</action>
        </actions>
      </group>
      <group id="UserRequest">
        <actions>
          <action id="action:write">allow</action>
          <action id="stimulus:ev_close" xsi:type="stimulus">allow</action>
          <action id="stimulus:ev_reopen" xsi:type="stimulus">allow</action>
        </actions>
      </group>
      <group id="*">
        <actions>
          <action id="action:read">allow</action>
          <action id="action:bulk read">allow</action>
        </actions>
      </group>
    </groups>
  </profile>
  <profile id="51" _delta="define">
    <name>Read-Only No Portal Access</name>
    <description>Users with this profile are allowed to browse through all objects in the application but not to modify anything (even through the portal)</description>
    <groups>
      <group id="*">
        <actions>
          <action id="action:read">allow</action>
          <action id="action:bulk read">allow</action>
        </actions>
      </group>
    </groups>
  </profile>
</profiles>
```

### 说明

- 第一个配置文件（id=50）是 "Portal User" 配置文件的克隆，但允许在标准界面中导航
- 第二个配置文件（id=51）是纯只读配置
- 组 `*` 表示"任何类"
- 使用的组定义在 `itop-profiles-itil` 模块中

### 激活配置文件

修改完成后，需要**重新运行安装**以激活新配置文件。

## 部署

将模块文件夹复制到目标 iTop 的 `extensions` 目录并运行安装。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-profile-sample>

版本：3_2_0/customization/add-profile-sample.txt · Last modified: 2026/03/16 14:03 by 127.0.0.1
