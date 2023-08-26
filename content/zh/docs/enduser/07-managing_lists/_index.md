---
title: "管理列表"
linkTitle: "管理列表"
date: 2023-08-26
weight: 7
description: >
      <br> ➡️ 介绍如何配置和管理列表，包括配置列表、邮件、导出、添加仪表盘、创建快捷方式等操作。
---

{{% pageinfo %}}
在iTop中，列表是相当常见的。在菜单项中，可以发现有些指向列表的菜单项，也可以在搜索结果和全局搜索中找到列表。一旦显示了一组对象的列表，其所执行的操作始终是相同的。

例如，下面是一个用户请求（User Request）的列表：

[![不分页列表](https://www.itophub.io/wiki/media?w=600&tok=f1a8ea&media=3_1_0:user:managing-lists-1.png "不分页列表")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:lists&media=3_1_0:user:managing-lists-1.png "3_1_0:user:managing-lists-1.png")

如果一个列表包含的元素超过某个数量（可配置），则会显示为分页列表：

[![分页列表](https://www.itophub.io/wiki/media?w=750&tok=0f795c&media=3_1_0:user:list-pages-actions.png "分页列表")](https://www.itophub.io/wiki/media?media=3_1_0:user:list-pages-actions.png "3_1_0:user:list-pages-actions.png")


**导出** 操作仅适用于终端用户的角色中包含 `BULK_READ` 权限的用户。

_Toolkit菜单_

在 iTop 中显示对象列表时，列表本身（而无需通过修改 iTop 中的对象）可以执行一些操作。这些操作通过位于列表右上方的toolkit弹出菜单执行。


{{% /pageinfo %}}

## 配置列表

[![列表配置对话框](https://www.itophub.io/wiki/media?w=350&tok=c5ee56&media=3_1_0:user:list-configuration-dialog.png "列表配置对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:list-configuration-dialog.png "3_1_0:user:list-configuration-dialog.png") 
[![工具包操作：配置此列表](https://www.itophub.io/wiki/media?media=3_1_0:user:list-toolkit-menu-configure.png "工具包操作：配置此列表")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:lists&media=3_1_0:user:list-toolkit-menu-configure.png "3_1_0:user:list-toolkit-menu-configure.png")

第一个可能的操作是配置列表的外观。您可以选择：

*   显示哪些列以及显示顺序
    
*   列表如何排序
    
*   同时显示多少项（参见上面的分页列表）
    
*   此配置将应用于哪个列表：（仅适用于此特定列表，还是适用于所有尚未具有特定配置的列表）。

所有这些配置都是通过弹出对话框完成的：

_高级用法_：

*   如果列表显示多个对象类（例如，SELECT a,b FROM Person AS a JOIN UserRequest AS b…），那么不能将配置保存为 `仅这个列表`，
    
*   如果将其保存为 `默认所有列表`，它仅会影响选择了**完全相同**的类且具有相同别名的列表，例如，如果另一个列表基于该查询（SELECT a2,b FROM Person AS a2 JOIN UserRequest AS b…），则上述保存将不适用，因为存在一个不相同的别名。


## 邮件

[![电子邮件消息](https://www.itophub.io/wiki/media?w=500&tok=c5f418&media=3_1_0:user:list-email.png "电子邮件消息")](https://www.itophub.io/wiki/media?media=3_1_0:user:list-email.png "3_1_0:user:list-email.png") 
[![工具包操作：电子邮件](https://www.itophub.io/wiki/media?w=120&tok=62ee2c&media=3_1_0:user:list-toolkit-menu-email.png "工具包操作：电子邮件")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:lists&media=3_1_0:user:list-toolkit-menu-email.png "3_1_0:user:list-toolkit-menu-email.png")

此操作类似于对象详细信息中的 **邮件** 操作，唯一的不同在于插入到消息中的超链接指向指定的对象列表。



## CSV 导出

[![交互式 CSV 导出](https://www.itophub.io/wiki/media?w=600&tok=b80346&media=3_1_0:user:csv-export.png "交互式 CSV 导出")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-export.png "3_1_0:user:csv-export.png") ![工具包操作：CSV 导出](https://www.itophub.io/wiki/media?w=150&tok=513cdf&media=3_1_0:user:list-toolkit-menu-export.png "工具包操作：CSV 导出")

CSV 导出操作会显示一个配置对话框，允许您：

*   选择格式选项：CSV 的分隔符字符（逗号、分号、制表符或其他字符）
    
*   指定 **文本限定字符** 字符（用于围绕 CSV 内的文本字符串）
    
*   选择字符编码
    
*   对于枚举字段（例如状态），选择值是要本地化（即使用屏幕上显示的值）还是使用内部（与语言无关的）代码。
    
*   选择包含在导出中的字段
    
*   排列列的顺序
    
要排列列的顺序，请在对话框底部显示的 **列顺序** 部分中的表中拖放列。要拖动列，请单击列的 **标头**。

配置好导出后，点击 **_导出_** 来生成它。如果导出包含大量数据（超过 1000 行），将会显示一个进度条。

导出完成后，您可以点击对话框顶部的链接 **_点击此处下载_** ，将结果下载为 .csv 文件，或者从文本区域中复制并粘贴导出的纯文本内容：

![ CSV 导出结果 ](https://www.itophub.io/wiki/media?w=800&tok=6a4b50&media=3_1_0:user:csv-export-2.png " CSV 导出结果 ")

### 如何在 Excel 2007/2010 中粘贴 CSV 数据

如果使用复制/粘贴将 CSV 数据导入 Excel 中，所有数据都将放置在一个列中。幸运的是，这很容易更改。

在 Excel 的 **数据** 选项卡中，点击 **_文本到列_** 图标：[![Excel 中的数据选项卡](https://www.itophub.io/wiki/media?w=600&tok=00b362&media=3_1_0:user:excel-csv-import-1.png "Excel 中的数据选项卡")](https://www.itophub.io/wiki/media?media=3_1_0:user:excel-csv-import-1.png "3_1_0:user:excel-csv-import-1.png")

接下来，会出现以下对话框向导：[![Excel 文本到列向导](https://www.itophub.io/wiki/media?w=500&tok=a1c725&media=3_1_0:user:excel-csv-import-3.png "Excel 文本到列向导")](https://www.itophub.io/wiki/media?media=3_1_0:user:excel-csv-import-3.png "3_1_0:user:excel-csv-import-3.png")[![Excel 文本到列向导](https://www.itophub.io/wiki/media?w=500&tok=abe07d&media=3_1_0:user:excel-csv-import-2.png "Excel 文本到列向导")](https://www.itophub.io/wiki/media?media=3_1_0:user:excel-csv-import-2.png "3_1_0:user:excel-csv-import-2.png")

*   选择 **分隔符**，然后点击 **_下一步 >_**。
    

接下来，在以下屏幕中：

*   选择 **逗号**，然后点击 **_完成_**。
    

在同一会话中（不要关闭和重新启动 Excel），下次复制/粘贴 CSV 数据时，Excel 将自动使用相同的设置执行文本到列的转换。

## Excel 导出

[![Excel 导出选项](https://www.itophub.io/wiki/media?w=600&tok=cf5cbe&media=3_1_0:user:itop-xlsx-export-options.png "Excel 导出选项")](https://www.itophub.io/wiki/media?media=3_1_0:user:itop-xlsx-export-options.png "3_1_0:user:itop-xlsx-export-options.png") ![Excel 导出](https://www.itophub.io/wiki/media?w=140&tok=a89f40&media=3_1_0:user:list-toolkit-menu-exportexcel.png "Excel 导出")

从菜单中直接导出到 Excel（XLSX 格式）：

Excel 导出操作会显示一个配置对话框，允许你：

*   选择包含在导出中的列
    
*   排列列的顺序
    
要排列列的顺序，请在对话框底部显示的 **列顺序** 部分中的表中拖放列。要拖动列，请单击列的 **标头**。

当点击 **导出** 时，Excel 文件将被生成。如果要导出的对象列表很大（> 1000），将显示一个进度条。导出完成后，可以通过点击对话框顶部的链接 **_点击此处下载_** 来下载 Excel 文件：[![Excel 导出进度](https://www.itophub.io/wiki/media?w=600&tok=6dacb3&media=3_1_0:user:itop-xlsx-exporter-progress.png "Excel 导出进度")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:lists&media=3_1_0:user:itop-xlsx-exporter-progress.png "3_1_0:user:itop-xlsx-exporter-progress.png")

对于大量数据的导出（例如几千个对象），CSV 导出可能比 Excel 导出快得多。

## PDF 导出

[![“导出为 PDF...” 配置对话框](https://www.itophub.io/wiki/media?w=700&tok=46664e&media=3_1_0:user:pdf-export-1.png "“导出为 PDF...” 配置对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:pdf-export-1.png "3_1_0:user:pdf-export-1.png") ![“导出为 PDF...” 菜单](https://www.itophub.io/wiki/media?w=140&tok=82d592&media=3_1_0:user:list-toolkit-menu-exporpdf.png "“导出为 PDF...” 菜单 ")

从 iTop 2.2.0 版本开始，有一个新的菜单项 **导出PDF**：

此菜单会生成一个 PDF 文档，其中包含一个大的表格，每个对象在列表中占据一行，每个选定字段占据一列。

导出PDF操作会显示一个配置对话框，允许你：

*   选择用于渲染 PDF 的页面尺寸：A3、A4 或 Letter
    
*   选择页面方向：纵向或横向
    
*   选择包含在导出中的列
    
*   排列列的顺序

要排列列的顺序，请在对话框底部显示的 **列顺序** 部分中的表中拖放列。要拖动列，请单击列的 **标头**。

PDF 输出以等宽列渲染（即，如果选择了 10 列，则每列将使用页面宽度的 1/10）。当选择的列数相对较少（<10）时，效果较好。如果需要生成包含许多列的 PDF，请使用 **横向** 方向。

当点击 **导出** 时，PDF 文档将被创建。如果要导出的对象列表很大（> 1000），将显示一个进度条。导出完成后，可以通过点击对话框顶部的链接 **_点击此处下载_** 来下载 PDF 文件：

![PDF 导出完成](https://www.itophub.io/wiki/media?w=450&tok=12888d&media=3_1_0:user:pdf-export-2.png "PDF 导出完成")

## 添加到仪表盘
----------------

[![添加到仪表板对话框](https://www.itophub.io/wiki/media?w=500&tok=2026eb&media=3_1_0:user:add-to-dashboard.png "添加到仪表板对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:add-to-dashboard.png "3_1_0:user:add-to-dashboard.png") ![工具包操作：添加到仪表板](https://www.itophub.io/wiki/media?w=130&tok=2c7471&media=3_1_0:user:list-toolkit-menu-dashboard.png "工具包操作：添加到仪表板")

显示为列表的每个结果都可以添加到一个可编辑的仪表盘之中。点击菜单 **_添加到仪表盘_**：

然后选择要将列表添加到的仪表盘以及要使用的“仪表盘小部件”类型：

列表可以添加到仪表盘中，作为：

*   对象普通列表
    
*   饼图（通过给定字段对对象进行分组）
    
*   柱状图（通过给定字段对对象进行分组）
    
*   分组（表），显示按给定字段分组的对象计数
    

当用户点击 **确定** 时，新的仪表盘小部件将添加到所选仪表盘的末尾（在最后一个使用的单元格之后添加一个新单元格）。如果勾选了 **编辑仪表板**，则修改后的仪表盘会立即在仪表盘编辑器中打开。

有关如何自定义生成的仪表盘的信息，请参阅 [编辑仪表板](https://www.itophub.io/wiki/page?id=3_1_0:user:dashboards "3_1_0:user:dashboards")。

## 创建快捷方式

[![新建快捷方式对话框](https://www.itophub.io/wiki/media?w=350&tok=f93dc7&media=3_1_0:user:create-shortcut-3.png "新建快捷方式对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:create-shortcut-3.png "3_1_0:user:create-shortcut-3.png") ![工具包操作：创建快捷方式](https://www.itophub.io/wiki/media?w=130&tok=a4f5a2&media=3_1_0:user:list-toolkit-menu-shortcut.png "工具包操作：创建快捷方式")

在提示时：
1.  输入新快捷方式的名称   
2.  点击 **_确定_**   
3.  新的菜单以此名称将出现在 **我的快捷方式** 菜单下

**刷新间隔** 的最小值为 5 秒。

---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:lists>

版本：3_1_0/user/lists.txt · Last modified: 2023/07/21 10:19 (external edit)
