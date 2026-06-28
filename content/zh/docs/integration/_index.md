---
title: "iTop 集成"
linkTitle: "iTop 集成"
date: 2025-06-27
weight: 9
description: >
  iTop 与外部系统的集成：数据同步、REST/JSON API、导入导出、Nagios 监控、LDAP 同步等。
---

{{% pageinfo %}}

iTop 提供了多种与外部系统集成的能力。本文档涵盖数据同步、API 访问、数据导入导出等集成方式。

{{% /pageinfo %}}

## 概述

CMDB 很少是独立运行的应用。为了将 iTop 与基础设施的其他部分集成，iTop 提供了三种强大的机制：

### 导入 / 导出

- **export-v2.php**：可作为 Web 服务或命令行工具使用。该页面允许基于 OQL 查询将任意 iTop 对象集导出为 XML、CSV、Excel (.xlsx) 或 HTML 格式。
- **import.php**：可作为 Web 服务或命令行工具使用，用于从 CSV 文件导入或更新 iTop 对象。

### 数据同步

数据同步支持将来自各种数据源的数据联邦到 iTop 中：

- [数据同步概述](./01-data_synchro_overview/)
- [示例：如何同步人员](./09-synchro_howto_personsfromldap/)
- [数据同步参考](./02-data_synchronization/)

所有这些服务几乎适用于 iTop 中的任何对象：设备、联系人、联系人、工单、用户账户等。

### JSON 服务

- [REST/JSON 服务](./06-rest_json/) 是通用服务。API 提供底层操作（搜索对象、创建/更新/删除对象），可作为任何类型集成的构建模块。此外，自定义模块可以提供更高级别的操作，并通过同一入口点提供服务。
- [REST/JSON API 测试台](./rest_json_playground/)

### 导入 LinkedSet

- [导入 LinkedSet](./import_a_link_set/) 介绍如何在 CSV 导入中处理 1:n 和 n:n 关系。

### 为 iTop 收集数据

收集器是一个独立的应用程序，它从外部源提取数据，然后通过数据同步推送到 iTop。一些常用应用程序已有现成的收集器，但在大多数情况下，您需要编写自己的收集器，或者至少修改现有收集器以处理您关心的数据。

可以作为基础：[Data collector Base](https://github.com/Combodo/iTopDataCollectorToolkit)

#### 集成示例

- [与 LDAP 集成](./09-synchro_howto_personsfromldap/)
- 与 OCSng 清单集成
- 与 Vsphere 集成
- [与 Nagios 集成](./08-nagios/)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:start>

版本：3_2_0/advancedtopics/start.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
