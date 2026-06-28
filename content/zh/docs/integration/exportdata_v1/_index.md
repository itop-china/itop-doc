---
title: "导出数据 - export.php"
linkTitle: "导出数据 - export.php"
date: 2025-06-27
weight: 10
description: "介绍 iTop 通用数据导出 Web 服务 export.php 的使用方法，支持 HTML、CSV、XML、Spreadsheet、XLSX 等多种格式，可通过命令行或 HTTP 远程调用。"
---

{{% pageinfo %}}
本文档介绍 iTop 的通用数据导出 Web 服务 `export.php`。该服务基于 OQL 查询导出数据，支持多种输出格式，可通过命令行或 HTTP 请求调用。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:exportdata_v1)。
{{% /pageinfo %}}

## 用途

iTop 提供了一个通用的 Web 服务，用于基于 OQL 查询导出任何数据。这可用于从 iTop 提取数据，以便在第三方工具中使用。此 Web 服务可以返回多种格式的数据：

- HTML
- CSV
- XML
- Spreadsheet（纯 HTML，用于导入 Excel 或 OpenOffice）
- XLSX（Excel 2007、2010、2013…）

此服务可以通过命令行接口在 iTop 服务器本地调用，也可以通过 HTTP 请求远程调用。

## 使用方法

### 命令行接口

```bash
php /var/www/itop/webservices/export.php --auth_login=login --auth_pwd=password --expression=query --format=csv --fields=<以逗号分隔的字段列表>
```

### 远程 Web 访问

有多种方式可以通过 Web 连接远程访问该服务。以下是使用 wget 命令的语法：

```bash
wget --http-user=login --http-password=password http://itopserver/webservices/export.php?expression=query&format=csv&fields=<以逗号分隔的字段列表>
```

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| param_file | 参数文件 - 参见参数文件 | - |
| auth_login | 用户登录名 - 仅 CLI 模式 | - |
| auth_pwd | 用户密码 - 仅 CLI 模式 | - |
| expression | OQL 查询 | 如果缺少 'query' 则为必填 |
| query | 存储在查询手册中的查询标识符。参见查询手册 | 如果缺少 'expression' 则为必填 |
| format | `spreadsheet`（推荐用于与 MS-Excel Web 查询集成）、`html`、`xml`、`csv` 或 `xlsx` | html |
| fields | 以逗号分隔的属性列表（例如 "name,brand,model"）；对 XML 输出无效；对 1.2（RC）之前的 HTML 版本无效 | 由 `<expression>` 指定的类的所有属性代码。这些属性未本地化 |
| no_localize | 如果设置为 0，则标题和值将使用已登录用户的语言进行本地化。设置为 1 以使用内部属性代码和值（枚举） | 0 |

## 输出

### HTML

### Spreadsheet

此格式专用于集成到电子表格中。特别是，这是与 Excel Web 查询一起使用的推荐方法。

有关更多信息，请参阅文章 "如何使用 iTop 查询创建 Excel 报告"。

### XML

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Set>
   <Server alias="Server" id="1">
      <name>dbserver1.demo.com</name>
      <status>production</status>
      <org_id>2</org_id>
      <importance>medium</importance>
      <contact_list>Sorry, no yet implemented</contact_list>
      <document_list>Sorry, no yet implemented</document_list>
      <solution_list>Sorry, no yet implemented</solution_list>
      <contract_list>Sorry, no yet implemented</contract_list>
      <ticket_list>Sorry, no yet implemented</ticket_list>
      <brand>HP</brand>
      <model>DL380</model>
      <serial_number></serial_number>
      <asset_ref></asset_ref>
      <nwinterface_list>Sorry, no yet implemented</nwinterface_list>
      <description></description>
      <location_id>1</location_id>
      <location_details></location_details>
      <management_ip>10.1.1.10</management_ip>
      <default_gateway>255.255.255.0</default_gateway>
      <cpu>2</cpu>
      <ram>16Gb</ram>
      <hdd>120Gb</hdd>
      <os_family>Linux</os_family>
      <os_version>Debian (Lenny)</os_version>
      <application_list>Sorry, no yet implemented</application_list>
      <patch_list>Sorry, no yet implemented</patch_list>
   </Server>
   <Server alias="Server" id="6">
      <name>webserver.demo.com</name>
      <status>production</status>
      <org_id>2</org_id>
      <importance>medium</importance>
      <contact_list>Sorry, no yet implemented</contact_list>
      <document_list>Sorry, no yet implemented</document_list>
      <solution_list>Sorry, no yet implemented</solution_list>
      <contract_list>Sorry, no yet implemented</contract_list>
      <ticket_list>Sorry, no yet implemented</ticket_list>
      <brand>IBM</brand>
      <model>x3400 Tower Server</model>
      <serial_number></serial_number>
      <asset_ref></asset_ref>
      <nwinterface_list>Sorry, no yet implemented</nwinterface_list>
      <description></description>
      <location_id>1</location_id>
      <location_details></location_details>
      <management_ip>10.1.1.20</management_ip>
      <default_gateway>255.255.255.0</default_gateway>
      <cpu>4</cpu>
      <ram>8Gb</ram>
      <hdd>240Gb</hdd>
      <os_family>Unix</os_family>
      <os_version>AIX 4.0</os_version>
      <application_list>Sorry, no yet implemented</application_list>
      <patch_list>Sorry, no yet implemented</patch_list>
   </Server>
</Set>
```

### CSV

```csv
id,Name,Management IP
1,"dbserver1.demo.com","10.1.1.10"
6,"webserver.demo.com","10.1.1.20"
```

## 允许的用户

此页面的使用没有任何限制。

## 历史版本

- 0.9 首次实现此功能
- 1.2.1 添加参数 'query'，作为 'expression' 的替代方案
- 1.2.1 添加格式 'spreadsheet'，可拆分日期和时间列
- 1.2.1 修复 HTTPS 和 MS-IIS 的停止问题（Trac:#485）
- 1.2.1 参数文件可以指定为参数（文档有误：实际上未实现）
- 1.2.1 分支 Spreadsheet 格式：修复时间问题（Trac:#541）。解决方法是使用 XML 格式（Excel 支持此格式）
- 2.0：添加标志 no_localize
- 2.1.0：添加 XLSX 格式

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:exportdata_v1>

版本：3_2_0/advancedtopics/exportdata_v1.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
