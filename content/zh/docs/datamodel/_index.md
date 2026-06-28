
---
title: "iTop 数据模型"
linkTitle: "数据模型"
date: 2025-06-27
weight: 6
description: >
  介绍 iTop 3.2.0 中管理的各类对象、它们之间的关系以及生命周期。
---

{{% pageinfo %}}
本文档解释 iTop 中不同对象的含义、角色和相互关系。实际可用的对象类型取决于安装的模块和数据模型。
{{% /pageinfo %}}

## 概述

iTop 的数据模型围绕 CMDB（配置管理数据库）构建，核心对象包括：

- **组织（Organization）**：客户、供应商等组织实体
- **人员（Person）** 与 **团队（Team）**：联系人和工作团队
- **配置项（CI）**：服务器、网络设备、PC、软件实例等
- **工单（Ticket）**：事件（Incident）、用户请求（User Request）、变更（Change）等
- **服务管理**：服务（Service）、服务子目录（Service Subcategory）、SLA、SLT、客户合同

## 核心关系

- 人员属于某个组织
- 团队由人员组成
- 配置项隶属于组织
- 工单由人员提交，分配给团队或人员处理
- 服务通过客户合同与组织关联

## 生命周期

iTop 中的许多对象（尤其是工单和 CI）都定义了生命周期，包括状态、转换规则和权限控制。生命周期可以在扩展中进行定制。

## 模块数据模型

iTop 的不同模块对应不同的管理领域：

- [配置管理（CMDB）模块](./itop-config-mgmt/)
- [数据中心管理模块](./itop-datacenter-mgmt/)
- [终端用户设备管理模块](./itop-endusers-devices/)
- [高级存储管理模块](./itop-storage-mgmt/)
- [虚拟化管理模块](./itop-virtualization-mgmt/)
- [变更管理模块](./itop-change-mgmt/)
- [变更管理 ITIL 模块](./itop-change-mgmt-itil/)
- [事件管理 ITIL V3 模块](./itop-incident-mgmt-itil/)
- [问题管理模块](./itop-problem-mgmt/)
- [已知错误数据库模块](./itop-knowledge-mgmt/)
- [用户请求管理（服务台）模块](./itop-request-mgmt/)
- [服务管理（服务、SLA、合同）模块](./itop-service-mgmt/)

## 参考

更详细的数据模型说明请参考 [iTop 官方数据模型文档](https://www.itophub.io/wiki/page?id=3_2_0:datamodel:start)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:datamodel:start>

版本：3_2_0/datamodel/start.txt · Last modified: 2025/08/12 16:44 by 127.0.0.1
