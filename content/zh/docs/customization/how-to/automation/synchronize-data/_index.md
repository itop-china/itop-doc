---
title: "数据同步"
linkTitle: "数据同步"
date: 2025-06-27
weight: 10
description: >
  数据同步。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中编写和配置数据收集器，从外部应用同步数据到 iTop。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:synchronize-data)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[数据同步参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 概述

收集器（Collector）是一个独立的 PHP 应用程序，从源应用程序获取数据并定期推送到 iTop 中，例如每天运行。它是一个简单的 ETL（提取/转换/加载）应用程序。

您无需编写完整应用程序，可以下载并使用已编写的大部分代码进行增强。

## 关键问题

### 如何从源应用程序获取数据？

- 直接查询数据库（SQL）？
- 使用 REST 和 Web 服务（JSON 格式）？
- 直接使用应用程序生成的 CSV 文件？
- 使用其他类型的 Web 服务（如 ripcord）？

对于前 3 种方法，SDK 中已存在预定义的收集器，编写自己的收集器主要是编写配置文件。对于最后一种情况，需要在 PHP 中做更多工作。

### 在哪个服务器上安装收集器？

- 收集器是独立应用程序，需要由 cron 定期启动
- 收集器必须能够访问源应用程序的数据
- 收集器必须能够 Web 访问 iTop 的 Web 服务，但不需要在同一台机器上
- 收集器必须符合[数据收集器基础 - 要求](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 示例场景

假设您希望用应用程序 "Blabla" 中的 Sites 信息来填充 iTop 中的 Locations 对象。您可以通过 REST/JSON 获取 Blabla 的 Sites 信息。

### 创建收集器

在收集器服务器上：

1. 下载并解压[数据收集器基础](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)包
2. 在该机器上创建 PHP 文件 `/collectors/sitescollector.class.inc.php`：

```php
<?php
class SiteCollector extends JsonCollector
{
}
```

3. 创建另一个文件 `/collectors/main.php`：

```php
<?php
require_once(APPROOT.'collectors/sitecollector.class.inc.php');
Orchestrator::AddCollector(1, 'sitecollector');
```

4. 更新文件 `/conf/params.local.xml`，设置以下 3 个参数：

```xml
<itop_url>https://????/</itop_url>
<itop_login>????</itop_login>
<itop_password>????</itop_password>
```

### 定义 iTop 端

在 iTop 上创建**数据同步 "Locations from Blabla"**，以同步来自 Blabla 应用程序的 Sites 数据。创建时考虑：

- Blabla 应用程序中 Site 对象有哪些可用信息（字段）？
- 哪些需要同步？
- 应该创建新 Location 还是仅更新现有 Location？

### 定义映射

在收集器服务器上运行以下命令：

```bash
php toolkit/dump_tasks.php --task_name="Location from Blabla" > collectors/SitesCollector.json
```

它提取同步数据源的定义，允许收集器强制其存在和行为。

创建的 `collectors/SitesCollector.json` 文件称为 JSON 定义文件，包含在 iTop 上自动创建或更新数据同步源所需的信息。

### 定义映射逻辑

编写 XML 文件指定 Blabla Sites 数据格式与 iTop Location 对象之间的映射逻辑。由于使用 JSON，需要定义：

| 标签 | 用途 |
|------|------|
| `<json_data>` | 用于从 Blabla 应用程序获取 Site 对象及每个对象的字段集。此部分完全取决于 Blabla 应用程序提供的 REST/JSON 接口 |
| `<path>` | 指定如何在 Blabla 返回的 JSON 响应中检索字段代码和值。支持的语法仅限于用 `/` 分隔的标签名。标签可以是 JSON 返回文件中的真实标签，或对于无标签级别（如表格）使用 `*` |
| `<fields>` | 为每个 iTop 字段指定对应的 Blabla 字段。其中特殊必填标签 `<primary_key>` 必须映射到在 Blabla 应用程序中唯一标识 Site 的字段 |
| `<defaults>` | 允许为 iTop 字段指定固定值。可与映射组合使用，用于特定 Blabla Site 没有该字段值的情况 |

这些信息必须在 `conf/params.distrib.xml` 文件的 `<parameters>` 标签下添加：

```xml
<parameters>
    <!-- 收集器类名小写 -->
    <sitecollector> 
        <jsonurl>http://blabla.demo.com/webservices/rest.php</jsonurl>
        <jsonpost>
            <auth_user>blabla-rest-user</auth_user>
            <auth_pwd>blabla-rest-user-password</auth_pwd>
            <json_data>
        <!--
          此部分完全取决于 Blabla 应用程序提供的 REST/JSON 接口
        -->
            </json_data>
            <version>1.3</version>
        </jsonpost>
        <!-- "path" 指定如何在 JSON 响应中检索字段 -->
        <path>objects/*/fields</path>  
        <fields> 
            <primary_key>blabla_id</primary_key> <!-- primary_key 标签必填 -->
            <name>name</name>
            <country>land</country>
            <status>step</status>
         </fields>
         <defaults> <!-- 允许为 iTop Location 字段指定默认值 -->
            <org_id>Demo</org_id>
            <status>active</status>
         </defaults>
     </sitecollector>
</parameters>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:synchronize-data>

版本：3_2_0/customization/synchronize-data.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
