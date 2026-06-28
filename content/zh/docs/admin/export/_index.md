---
title: "导出数据"
linkTitle: "管理：导出数据"
date: 2025-06-27
weight: 16
description: >
  通过 OQL 查询导出 iTop 数据为 CSV、XML 或 XLSX 格式。
---

{{% pageinfo %}}

iTop 提供了一个通用的 Web 服务，用于基于 OQL 查询导出任何数据。此服务可用于从 iTop 提取数据，以便与第三方工具集成。此 Web 服务可以以多种格式返回数据：

- HTML
- CSV
- XML
- Spreadsheet（用于导入到 Excel 或 OpenOffice 的纯 HTML）
- XLSX（Excel 2007、2010、2013...）
- PDF

此服务可以通过 iTop 服务器上的命令行界面本地调用，也可以通过 HTTP 请求远程调用。

{{% /pageinfo %}}

## 使用

### 命令行接口

```bash
php /var/www/itop/webservices/export-v2.php --auth_user=login --auth_pwd=password --expression=query --format=csv --fields=<以逗号分隔的字段列表>
```

### 远程 Web 访问

有多种方式可以通过 Web 连接远程访问该服务。以下是使用 wget 命令的语法（如果启用了基本认证）：

```bash
wget --http-user=login --http-password=password http://itopserver/webservices/export-v2.php?expression=query&format=csv&fields=<以逗号分隔的字段列表>
```

或使用令牌（更安全）：

```bash
wget --post-data='--auth-token=YOURTOKEN' http://itopserver/webservices/export-v2.php?expression=query&format=csv&fields=<以逗号分隔的字段列表>
```

## 参数

| 参数 | 描述 | 默认值 |
|---|---|---|
| param_file | 参数文件 — 请参阅参数文件 | - |
| auth_user | 用户登录名 — 仅限 CLI 模式 | - |
| auth_pwd | 用户密码 — 仅限 CLI 模式 | - |
| expression | OQL 查询 | 如果缺少 'query'，则为必填 |
| query | 存储在查询手册中的查询标识符 | 如果缺少 'expression'，则为必填 |
| format | spreadsheet（推荐用于与 MS-Excel Web 查询集成）、html、xml、csv 或 xlsx | html |
| fields | 以逗号分隔的属性列表（例如 "name,brand,model"）。支持扩展属性代码（例如 caller_id->org_id->code），但可能会显著降低导出速度（因为它们需要额外的数据库查询）。谨慎使用！ | 由 expression 指定的类的所有属性代码。这些不是本地化的 |
| with_archive | 1：导出将包含归档对象。0 或省略参数：不返回归档对象 | 0 |
| arg_xxx | 如果 OQL 查询有参数，则需要：参数 'xxx' 的值 | 无 |

## 输出

### HTML

HTML 格式将输出作为 HTML 表格提供。

### Spreadsheet

此格式专用于集成到电子表格中。特别是，它是与 Excel Web 查询一起使用的推荐方法。有关此 Excel 集成的更多信息，请参阅文章"如何使用 iTop 查询创建 Excel 报告"。

#### 格式特定参数

使用 Spreadsheet 格式时，以下附加参数可用：

| 参数名 | 描述 | 默认值 |
|---|---|---|
| date_format | 用于导出日期和时间字段的格式（使用 PHP 日期和时间说明符指定） | 与 GUI 中相同 |
| formatted_text | 是否以 HTML 标记导出富文本字段。1 = 导出标记，0 = 无标记 | 1 |
| no_localize | 如果设置为 0，则标题和值将以登录用户的语言本地化。设置为 1 以使用内部属性代码和值（枚举） | 0 |

### XML

使用 XML 格式时，以下附加参数可用：

| 参数名 | 描述 | 默认值 |
|---|---|---|
| linksets | 设置为 1 以检索指向相关对象的链接（1-多或多-多关系）。0 表示仅返回对象的"标量"值 | 0 |
| no_localize | 如果设置为 0，则标题和值将以登录用户的语言本地化。设置为 1 以使用内部属性代码和值（枚举） | 0 |

### CSV

CSV 格式输出示例：

```
id,Name,Management IP
1,"dbserver1.demo.com","10.1.1.10"
6,"webserver.demo.com","10.1.1.20"
```

#### 格式特定参数

| 参数名 | 描述 | 默认值 |
|---|---|---|
| charset | 用于编码输出的字符集 | UTF-8 |
| date_format | 用于导出日期和时间字段的格式（使用 PHP 日期和时间说明符指定） | 与 GUI 中相同 |
| formatted_text | 是否以 HTML 标记导出富文本字段。1 = 导出标记，0 = 无标记 | 0 |
| no_localize | 如果设置为 0，则标题和值将以登录用户的语言本地化。设置为 1 以使用内部属性代码和值（枚举） | 0 |
| separator | 输出中字段之间用作分隔符的字符 | ,（逗号） |
| text-qualifier | 用于文本字符串的字符 | "（双引号） |

### PDF

此格式生成 PDF 文档，包含一个包含请求数据的大表格。注意：表格的自动布局使所有列的宽度相同。因此，它最适合少量（<10）列。要容纳更多列，请使用页面的纵向方向。

#### 格式特定参数

| 参数名 | 描述 | 默认值 |
|---|---|---|
| date_format | 用于导出日期和时间字段的格式（使用 PHP 日期和时间说明符指定） | 与 GUI 中相同 |
| page_size | 页面布局的纸张大小。可能的值：A3、A4 或 Letter | A4 |
| page_orientation | 页面纸张的方向。可能的值：Landscape 或 Portrait | Portrait |

### XLSX

#### 格式特定参数

| 参数名 | 描述 | 默认值 |
|---|---|---|
| date_format | 用于导出日期和时间字段的格式（使用 PHP 日期和时间说明符指定） | 与 GUI 中相同 |
| formatted_text | 是否以 HTML 标记导出富文本字段。1 = 导出标记，0 = 无标记 | 0 |

## 历史

- 0.9 首次实现此功能
- 1.2.1 添加了参数 'query'，作为 'expression' 的替代
- 1.2.1 添加了格式 'spreadsheet'，将日期和时间列分开
- 1.2.1 修复了 HTTPS 和 MS-IIS 的阻塞问题（Trac:#485）
- 1.2.1 参数文件可以作为参数指定（文档是错误的：实际上未实现）
- 1.2.1 分支 Spreadsheet 格式：修复了时间问题（Trac:#541）。解决方法是使用 XML 格式（XCel 支持此格式）
- 2.0：添加了标志 no_localize
- 2.1.0：添加了 XLSX 格式
- 2.2.0：通过创建新的 export-v2.php 页面重新设计导出

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:exportdata>

版本：3_2_0/advancedtopics/exportdata.txt · Last modified: 2026/03/10 13:11 by 127.0.0.1
