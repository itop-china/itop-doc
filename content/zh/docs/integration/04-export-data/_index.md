---
title: "导出数据 (export-v2.php)"
linkTitle: "导出数据"
date: 2025-06-27
weight: 4
description: >
  <br> ➡️ 使用 export-v2.php 基于 OQL 查询导出数据
---

{{% pageinfo %}}

iTop 提供通用的 Web 服务 `export-v2.php`，基于 OQL 查询导出数据，用于与第三方工具集成。支持格式：HTML、CSV、XML、Spreadsheet、XLSX、PDF

{{% /pageinfo %}}

## 调用方式

### 命令行

```bash
php /var/www/itop/webservices/export-v2.php --auth_user=login --auth_pwd=password --expression="SELECT Server" --format=csv --fields=name,brand,model
```

### 远程 HTTP

```bash
# Basic 认证
wget --http-user=login --http-password=password "http://itopserver/webservices/export-v2.php?expression=SELECT+Server&format=csv"

# Token 认证
wget --post-data='--auth-token=YOURTOKEN' "http://itopserver/webservices/export-v2.php?expression=SELECT+Server&format=csv"
```

## 参数

| 参数 | 描述 | 默认值 |
|---|---|---|
| param_file | 参数文件 | - |
| expression | OQL 查询 | 与 query 二选一 |
| query | [查询手册](../../admin/04-phrasebook/)中保存的查询 ID | 与 expression 二选一 |
| format | `html`/`csv`/`xml`/`spreadsheet`/`xlsx`/`pdf` | html |
| fields | 逗号分隔的属性列表（支持 `caller_id->org_id->code`） | 类的所有属性 |
| with_archive | `1` 包含归档对象 | 0 |
| arg_xxx | OQL 参数 xxx 的值 | 无 |

> 输出字段顺序遵循 `fields` 参数中的顺序。扩展属性码可能显著降低导出速度。

## 输出格式

### HTML

HTML 格式将输出作为 HTML 表格提供。

### Spreadsheet

推荐用于 Excel Web 查询集成。

| 参数 | 描述 | 默认值 |
|---|---|---|
| date_format | 日期格式 | 同 GUI |
| formatted_text | 导出富文本标记 | 1 |
| no_localize | 使用内部代码和值 | 0 |

### XML

| 参数 | 描述 | 默认值 |
|---|---|---|
| linksets | `1` 检索关联对象 | 0 |
| no_localize | 使用内部代码和值 | 0 |

> XML 格式忽略 `fields` 参数，始终检索所有字段。

XML 输出示例：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Set>
  <Server alias="Server" id="1">
    <name>Server1</name>
    <description></description>
    <org_id>3</org_id>
    <org_id_friendlyname>Demo</org_id_friendlyname>
    <organization_name>Demo</organization_name>
    <status>production</status>
    ...
  </Server>
</Set>
```

### CSV

| 参数 | 描述 | 默认值 |
|---|---|---|
| charset | 字符编码 | UTF-8 |
| separator | 分隔符 | , |
| text-qualifier | 文本限定符 | " |
| date_format | 日期格式 | 同 GUI |
| formatted_text | 导出富文本标记 | 0 |
| no_localize | 使用内部代码和值 | 0 |

CSV 示例：

```csv
id,Name,Management IP
1,"dbserver1.demo.com","10.1.1.10"
6,"webserver.demo.com","10.1.1.20"
```

### XLSX

| 参数 | 描述 | 默认值 |
|---|---|---|
| date_format | 日期格式 | 同 GUI |
| formatted_text | 导出富文本标记 | 0 |

### PDF

| 参数 | 描述 | 默认值 |
|---|---|---|
| date_format | 日期格式 | 同 GUI |
| page_size | A3/A4/Letter | A4 |
| page_orientation | Landscape/Portrait | Portrait |

> PDF 适合 <10 列，列多时建议 Landscape。

## 权限要求

- 门户用户不允许访问此服务
- 用户必须在指定类上有 `bulk read` 权限

## 历史版本

- 0.9：首次实现此功能
- 1.2.1：添加参数 `query`，作为 `expression` 的替代
- 1.2.1：添加格式 `spreadsheet`，拆分日期和时间列
- 2.0：添加标志 `no_localize`
- 2.1.0：添加 XLSX 格式
- 2.2.0：通过创建新的 `export-v2.php` 页面重新设计导出功能

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:exportdata>

版本：3_2_0/advancedtopics/exportdata.txt · Last modified: 2026/03/10 13:11 by 127.0.0.1
