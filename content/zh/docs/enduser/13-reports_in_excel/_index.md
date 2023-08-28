---
title: "Excel报表"
linkTitle: "Excel报表"
date: 2023-08-27
weight: 13
description: >
    <br> ➡️ 介绍Excel报表的使用。
---

{{% pageinfo %}}

**如何使用iTop查询创建Excel报表**

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">近期版本的Excel（Excel 2016，Office 365）提供了两种将Web数据导入Excel的方法。最近的版本（默认版本）基于PowerQuery，**不支持基本身份验证**，因此无法与iTop一起使用。然而，旧的方法仍然作为额外的菜单项可用，您可以在Excel中启用它。更让人困惑的是，这两个菜单项的标签完全相同！</font>

{{% /pageinfo %}}

## 确保正确配置Excel

点击菜单项“数据” / “从Web获取”。如果您得到类似于下面的对话框（PowerQuery），则不行。

![Excel GetPowerQueryDataFromWeb向导](https://www.itophub.io/wiki/media?w=600&tok=dd2f7e&media=3_1_0:user:wrong-import-excel-import-dialog.png "Excel GetPowerQueryDataFromWeb wizard")

而是应该得到类似于这样的对话框：

![Excel GetExternalDataFromWeb向导](https://www.itophub.io/wiki/media?w=600&tok=1a2248&media=3_1_0:user:new-web-excel-import-query.png "Excel GetExternalDataFromWeb wizard")

要使用旧的`GetExternalDataFromWeb`向导，请按照以下步骤进行：

进入“文件” / “选项”菜单

![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel-import-options-menu.png)

点击左侧的“自定义功能区”菜单：

在左上角的下拉列表中，选择“主选项卡”，在显示的树中，打开“数据”项目，并选择菜单项“从Web获取”

![](https://www.itophub.io/wiki/media?w=800&tok=845c98&media=3_1_0:user:excel-import-ribbon-dialog.png)

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">由于新旧菜单的标签完全相同，请确保选择正确的菜单：将鼠标悬停在项目上；会显示一个小工具提示，**它应该是“GetExternalDataFromWeb”，而不是“GetPowerQueryDataFromWeb”**
</font>

![GetExternalDataFromWeb](https://www.itophub.io/wiki/media?w=800&tok=82b401&media=3_1_0:user:getexternaldatafromweb.png "GetExternalDataFromWeb")

要将命令添加到功能区中，您必须创建一个新的“组”（使用对话框底部的按钮）。该组具有默认名称，但如果愿意，可以重新命名它：

[![新组](https://www.itophub.io/wiki/media?media=3_1_0:user:excel-import-new-group.png "新组")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel-import-new-group.png "3_1_0:user:excel-import-new-group.png")

类似地，您可以重新命名菜单并选择一个图标。一旦菜单添加到功能中，您应该会看到类似于这样的东西：

![](https://www.itophub.io/wiki/media?media=3_1_0:user:web-excel-import-command.png)

当单击自定义菜单时，应该会出现“External Data From Web”向导：

![](https://www.itophub.io/wiki/media?w=600&tok=1a2248&media=3_1_0:user:new-web-excel-import-query.png)

## 从iTop导入数据

管理员可以在iTop中存储预定义查询（菜单“管理/查询手册”）。然后可以使用这些查询在Excel中创建报表。查询通过编号进行标识。在Excel中使用由iTop管理员提供的URL调用它。例如，存储在查询短语本中的下面的URL返回用户请求列表：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report8.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report8.png "3_1_0:user:excel_report8.png")

要在Excel中使用此查询，请在Excel选项卡**数据**中单击**_From Web_**按钮

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report1.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report1.png "3_1_0:user:excel_report1.png")

会显示一个窗口用于输入要调用的URL：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report2.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report2.png "3_1_0:user:excel_report2.png")

在**地址**部分输入iTop管理员提供的URL，然后单击**_Go_**。

iTop身份验证窗口会显示。输入您的用户帐户和密码：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report3.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report3.png "3_1_0:user:excel_report3.png")

如果系统提示您的安全弹出窗口，请单击**_OK_**。

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report4.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report4.png "3_1_0:user:excel_report4.png")

**New Web Query**会更新为要导入的列的列表：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report5.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report5.png "3_1_0:user:excel_report5.png")

单击**_Import_**按钮。Excel会询问您要在何处插入数据：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report6.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report6.png "3_1_0:user:excel_report6.png")

如果查询包含参数，Excel将打开多个连续的窗口以输入这些参数。请注意，日期参数仅支持格式_年-月-日_。

单击**_OK_**按钮，Excel会显示查询的结果。用于显示列的语言与您在iTop中的登录的默认语言相对应。

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:excel_report7.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:excel_report&media=3_1_0:user:excel_report7.png "3_1_0:user:excel_report7.png")

要刷新数据，请在Excel的**数据**选项卡上单击**_Refresh All_**按钮：

您可以使用尽可能多的iTop查询，并使用标准Excel功能动态地创建图表。

>> →上一篇： [废弃对象](../12-obsolete_object/) 
---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:excel_report>

版本：3_1_0/user/excel_report.txt · Last modified: 2023/07/21 10:19 (external edit)