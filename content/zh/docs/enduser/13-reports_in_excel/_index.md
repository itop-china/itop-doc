---
title: "电子表格报表"
linkTitle: "电子表格报表"
date: 2023-08-27
weight: 13
description: "介绍如何使用iTop查询在Excel、LibreOffice、WPS Office和OnlyOffice中创建电子表格报表。"
---

{{% pageinfo %}}

**如何使用iTop查询创建电子表格报表**

{{% /pageinfo %}}

## 从iTop获取数据

管理员可以在iTop中存储预定义查询（菜单"管理/查询手册"）。这些查询然后可以用于在Excel中创建报表。查询通过编号进行标识。在Excel中使用由iTop管理员提供的URL调用它。例如，存储在查询短语本中的下面的URL返回用户请求列表：

然后，您可以使用此URL查询与您的 favorite 电子表格应用程序：

- Excel
- Libre Office
- WPS Office
- OnlyOffice

## Excel 报表

有两种模式可以自动从iTop提取数据到Excel：基本身份验证（也称为传统的从Web查询）和Power Query Builder

|  | 从Web查询 | Power Query Builder |
| --- | --- | --- |
| 登录 | 基本身份验证，使用登录名/密码 | Token |
| iTop 用户 | iTop 本地用户 | 用户Token（使用任何类型的iTop用户）或应用程序Token |
| 支持查询变量 | 是 | 否 |
| 支持多行（文本&HTML）字段 | 是 | 否 |
| export-v2 支持的格式 | csv, spreadsheet, html | csv only |
| 凭据安全性 | 登录名/密码不需要存储在表格中 | Token 自动以明文形式存储在文件中 |

### 传统从Web查询

#### 先决条件

- Web服务器必须授权基本身份验证
- iTop login_mode 包含 basic
- 用户必须是 "iTop 本地用户"（并且该用户未配置MFA）

#### 激活此模式

点击菜单项"数据" / "从Web获取"。如果您得到类似于下面的对话框（PowerQuery），则不行。

而是应该得到类似于这样的对话框：

要使用旧的 GetExternalDataFromWeb 向导，请按照以下步骤进行：

进入"文件" / "选项"菜单

点击左侧的"自定义功能区"菜单：

在左上角的下拉列表中，选择"主选项卡"，在显示的树中，打开"数据"项目，并选择菜单项"从Web获取"

要将命令添加到功能区中，您必须创建一个新的"组"（使用对话框底部的按钮）。该组具有默认名称，但如果愿意，可以重新命名它：

类似地，您可以重新命名菜单并选择一个图标。一旦菜单添加到功能中，您应该会看到类似于这样的东西：

当单击自定义菜单时，应该会出现"External Data From Web"向导：

### 构建报表

要在Excel中使用此查询，请在Excel选项卡 **数据** 中单击 **From Web** 按钮

会显示一个窗口用于输入要调用的URL：

在 **地址** 部分输入iTop管理员提供的URL，然后单击 **Go**。

iTop身份验证窗口会显示。输入您的用户帐户和密码：

单击 **确定**：如果系统提示您的安全弹出窗口。

**New Web Query** 会更新为要导入的列的列表：

单击 **Import** 按钮。Excel会询问您要在何处插入数据：

如果查询包含参数，Excel将打开多个连续的窗口以输入这些参数。请注意，日期参数仅支持格式 _年-月-日_。

单击 **确定** 按钮，Excel会显示查询的结果。用于显示列的语言与您在iTop中的登录的默认语言相对应。

要刷新数据，请在Excel的 **数据** 选项卡上单击 **Refresh All** 按钮：

您可以使用尽可能多的iTop查询，并使用标准Excel功能动态地创建图表。

## Power Query Builder

### 先决条件

- login_mode token 必须启用
- 用户Token 或 应用程序Token

### 构建报表

假设您在iTop中创建了一个Web查询，可以使用此URL调用

```
http://localhost/itop/webservices/export-v2.php?format=csv&login_mode=token&query=109
```

打开Excel，并使用新的向导模式导入

假设您在iTop中创建了个人Token并复制了该token。

|  | 在新的向导弹出窗口中： |  |
| --- | --- | --- |
| a. | 选择 **Advanced**（默认模式是 Basic） |  |
| b. | 在字段 URL parts 中输入：`http://localhost/itop/webservices/export-v2.php?format=spreadsheet&login_mode=token&query=109` |  |
| c. | 在字段 HTTP request header parameters (optional) - 输入 Auth-Token（而不是 auth_token）- 从iTop粘贴Token值。 |  |
| d. | 按 **确定** 按钮， |  |

在新的弹出窗口中，使用 Navigator

| 1. 点击表格 | 2. 按 **Load** 按钮 | 3. 在Excel表格中获取结果 |
| --- | --- | --- |

### 迁移到 Power Query Builder

现有的电子表格将需要重新制作

- 首先查看 Query Builder 的要求
- 对于每个电子表格，使用csv格式在url中重新创建相应的Power Query，这将自动创建一个新工作表，因此您的数据透视表和计算将需要更新
- 变量不再可用，因此您需要在iTop中创建多个 QueryPhrases
- 多行数据不能再导出（因为Query Builder仅支持csv格式）

## LibreOffice 报表

该软件的默认配置与iTop兼容：无需更改任何设置。

要在LibreOffice Calc中使用iTop查询，请选择要插入数据的单元格。然后，单击菜单 **Sheet > External links…** 或 **Data** 选项卡中的 **External links** 按钮

将显示 **External data** 窗口以输入要调用的URL：

在 **URL of External Data Source** 部分输入iTop管理员提供的URL，然后按键盘上的 **Enter** 键。

将显示iTop身份验证窗口。输入您的用户帐户和密码：

然后您可以调整导入选项。如果您没有特殊需求，默认设置即可：

**Available Tables/Ranges** 将更新为要导入的表格列表。要仅获取一个表格，请选择 HTML_1：

单击 **确定** 按钮，LibreOffice Calc 将显示查询结果。用于显示列的语言与您在iTop中登录的默认语言相对应。

要刷新数据，请单击菜单 **Edit > Links to External files…**，然后在 Edit Links 窗口中单击 **Update** 按钮。

您可以使用尽可能多的iTop查询，并使用标准LibreOffice Calc功能动态地创建图表。

## WPS Office 报表

请按照 WPS Office 编辑器网站上的 [howto](https://www.wps.com/) 进行操作。

要在WPS Office中使用iTop查询，请转到 **Data** 选项卡，然后单击按钮 **Import Data > From Web…**。

要在WPS Office中更新iTop查询，请转到 **Data** 选项卡，然后单击按钮 **Refresh All**。

## OnlyOffice 报表

OnlyOffice 似乎不支持Web查询。您可以访问编辑器网站上的 [reference documentation](https://www.onlyoffice.com/)，以检查较新版本是否有更改。

## 常见问题

### 为什么值以单引号开头？

由于安全修复，自 iTop 3.2.3 / 3.3.0 起，值前面会加上单引号，以避免CSV注入漏洞。这可能会破坏一些现有的电子表格，如果您信任导入的数据并希望禁用此保护，可以在导出URL中添加 `&ignore_excel_sanitization=1`。

>> →上一篇： [废弃对象](../12-obsolete_object/)
---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:user:excel_report>

版本：3_2_0/user/excel_report.txt · Last modified: 2026/04/24 15:34 by 127.0.0.1
