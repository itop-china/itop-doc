---
title: "操作"
linkTitle: "操作"
date: 2022-11-09
weight: 5
description: >
    <br> ➡️ 介绍了对象的常用增删改查、状态变化等操作，以及打印等功能。
---

**---操作---**
-------

在iTop种，操作用于修改对象。操作可以执行:

*   在对象列表 (参考章节 [管理列表](https://www.itophub.io/wiki/page?id=3_0_0:user:lists "3_0_0:user:lists"))情况下，所选的操作将应用于列表中的所有对象
    
*   在对象的详细页面
    
操作按钮只显示给有足够权限执行这些操作的用户。

在iTop中的标准操作是这样的:

[![Other Actions](https://www.itophub.io/wiki/media?media=3_0_0:user:details-popup-menu.png "Other Actions")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:actions&media=3_0_0:user:details-popup-menu.png "3_0_0:user:details-popup-menu.png")

## 新建

此操作用于创建与当前显示的对象类型相同的新对象。点击“新建…”， 显示对象的创建表单。

_默认情况下，该操作总是会显示为_[![Creation icon](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Creation icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png") _图标_，因此在下拉菜单中不会出现。_

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">根据上下文，有些字段可能会自动预填充。例如，如果上下文设置为 **Demo** 组织，当点击 **_新建_** 创建一个新的个人的时候，将显示一个带有组织的表单，预填充为 \*Demo\*.</font>

## 修改

此操作显示要更新对象的表单。创建表单和修改表单两者非常相似，只是在修改对象时，表单中的值会预先填充为当前要修改对象的值。

_默认情况下，此操作一直显示为_
 [![Edit icon](https://www.itophub.io/wiki/media?media=3_0_0:user:modify-button.png "Edit icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:modify-button.png "3_0_0:user:modify-button.png") _图标，因此不会在下拉菜单中出现。_

## 删除

**删除**操作通常位于**其他操作**弹出菜单之中。

该操作用于从iTop中永久删除对象。为了保证iTop中数据的一致性和完整性，删除对象也会影响其他对象。根据数据模型中定义的规则，其他对象可能会被自动修改或删除，又或者在手动删除某些依赖对象之前，可能无法删除。

在任何情况下，都会显示一个列出所有受影响对象的确认界面。

[![Delete confirmation page](https://www.itophub.io/wiki/media?w=600&tok=e52cde&media=3_0_0:user:delete-confirm.png "Delete confirmation page")](https://www.itophub.io/wiki/media?media=3_0_0:user:delete-confirm.png "3_0_0:user:delete-confirm.png")

以删除整个组织为例，系统显示如下确认界面：

[![Object Deletion Disabled](https://www.itophub.io/wiki/media?w=600&tok=768dec&media=3_0_0:user:object-delete-disabled.png "Object Deletion Disabled")](https://www.itophub.io/wiki/media?media=3_0_0:user:object-delete-disabled.png "3_0_0:user:object-delete-disabled.png")

在这种情况下，iTop发现有几个人属于本组织。由于数据模型的定义要求个人必须属于一个组织，而且个人的删除不是自动的，因此当存在属于组织的个人时，不能删除组织。
同样的逻辑适用于所有必须具有组织的其他对象。

*   这就是 **删除!** 按钮变灰的原因。
    
*   为了删除组织，必须首先处理所有出错的对象，要么删除它们，要么将它们分配给其他不同的组织。
    

## 关系

根据所显示对象的类型，还提供了额外的**关系**菜单。例如，对于大多数配置项，定义了两类关系： _影响_ 和 _依赖于_ 。这种情况下，**其他操作** 弹出菜单中会有两个额外可用的菜单。

[!["Impacts..." popup menu action](https://www.itophub.io/wiki/media?w=400&tok=b6d64d&media=3_0_0:user:details-popup-menu-impacts.png "'Impacts...' popup menu action")](https://www.itophub.io/wiki/media?media=3_0_0:user:details-popup-menu-impacts.png "3_0_0:user:details-popup-menu-impacts.png")

当选择这样的操作时，会显示关系的页面：

[![Impact diagram for a Server](https://www.itophub.io/wiki/media?w=800&tok=ecf1fb&media=3_0_0:user:itop_analyse_impact_3.0.png "Impact diagram for a Server")](https://www.itophub.io/wiki/media?media=3_0_0:user:itop_analyse_impact_3.0.png "3_0_0:user:itop_analyse_impact_3.0.png")

*   您可以使用顶部带有图标的复选框来过滤显示(更新选择后只需点击 **_刷新_** 即可)。
    
*   将鼠标移到到对象上以显示附加信息的工具提示(以及指向其详细信息的链接)
    
*   在对象上单击并拖动，可重新排列图表
    
*   点击并拖动 _背景_ 可以移动整个图表
    
*   **+** 和 **\-** 按钮，以及图表右上方的 **滑块** (和鼠标滚轮)用于调整缩放级别
    
*   **分组阈值** 定义了用于创建一个组的相似对象(相同类型，相同状态)的最小数量，以取代图表中的单个对象，简化图表。更改此值时，单击 **_刷新_** 将以新的分组级别重新计算图表
    

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">通过右键单击图表中的对象，可以从弹出菜单中选择 **详情** 返回其详细信息。对于对象的 **组** ，**详情菜单**显示该组中的元素列表。</font><br>[!["Details"](https://www.itophub.io/wiki/media?media=3_0_0:user:impact-details.png 'Details')](https://www.itophub.io/wiki/media?media=3_0_0:user:impact-details.png "3_0_0:user:impact-details.png")

### 上下文

*   **其他信息**下拉列表定义了在计算和显示图表时对于**工单**(更新选择后只需按 **_刷新_** )的考虑。
    
*   当图表中的对象链接到(至少)一个**上下文**工单时，在对象图标旁边会显示一个表示工单类型(事件、变更)的小图标。链接到给定对象的工单列表可在该对象的工具提示中找到。

[!["Context"](https://www.itophub.io/wiki/media?media=3_0_0:user:analyseimpactcontextchange.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:analyseimpactcontextchange.png "3_0_0:user:analyseimpactcontextchange.png")

*   **打开的变更** 上下文对应“变更”，这些变更既没有关闭也没有被拒绝，正在产生停机并影响一些显示的配置项(_Impact != '不受影响'_)
    
*   **最近的变更 (72h)** 上下文对应“在不到3天内关闭的变更，已经产生了停机，并且确实影响了显示的一些配置项.
    
*   **打开的事件** 上下文与事件相对应，这些事件既没有关闭也没有解决，并且确实影响了显示的一些配置项。
    

### 将图表导出为PDF文档

要将图表导出为PDF文档，请使用图表右上方的**工具**菜单: [![Export as PDF menu](https://www.itophub.io/wiki/media?w=300&tok=9bccc9&media=3_0_0:user:relation-popup-menu-export.png "Export as PDF menu")](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-popup-menu-export.png "3_0_0:user:relation-popup-menu-export.png")

将显示如下对话框:

[![Export as PDF dialog-box](https://www.itophub.io/wiki/media?w=300&tok=f66e11&media=3_0_0:user:relation-export-dlg.png "Export as PDF dialog-box")](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-export-dlg.png "3_0_0:user:relation-export-dlg.png")

导出生成了一个可打印的PDF文档，其中第一页包含图表(显示在屏幕上)，左侧是图例，底部有一个可选的备注区域。对象列表作为一组表(每个对象类别一个表)添加到其他页面上。

有以下选项:

*   **页面格式**: PDF文件的尺寸:A3、A4或Letter。
    
*   **页面方向**: 横向(横向)或纵向(纵向)
    
*   **标题**: 文档的标题，作为标题添加到每页的顶部
    
*   **备注**: 在文档的第一页，图表下方，将被整合的自由文本区域(如果不是空的)。
    
*   **包含的对象列表**: 如果选中，图表中的对象列表将作为一个大表格添加到PDF文档中作为附加的页面。
    

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">当勾选了 **包含的对象列表** 并且要导出的对象列表很大时，PDF文档的创建可能会非常慢 (> 100 对象)。</font>

## 邮件

**邮件** 的操作位于 **其他操作** 弹出菜单中。

该操作将创建一个新的eMail消息，其中包含iTop中所选对象的链接。电子邮件是由最终用户计算机上配置的客户端邮件程序创建和发送的。

消息的接收者将收到一个URL链接，以导航到对象的详细信息，但她/他必须有一个iTop帐户才能查看信息，因为将提示她/他进行身份验证才能查看页面。

## CSV 导出

一个对象的CSV导出类似于 [列表的CSV导出](https://www.itophub.io/wiki/page?id=3_0_0:user:lists#csv_export "3_0_0:user:lists"), 除非结果导出中只有一行数据。

## Excel 导出

导出一个对象的Excel类似于 [列表的Excel导出](https://www.itophub.io/wiki/page?id=3_0_0:user:lists#excel_export "3_0_0:user:lists"), 除非结果导出中只有一行数据。

## 打印友好版本

此操作在浏览器的另一个选项卡中打开当前对象的 **打印友好** 版本的详细信息。这个版本的 **详情** 为打印进行了优化：所有的选项卡都作为页面内部分列出，大部分周围的元素(菜单，搜索栏)被删除。

此外，该页面还可以在打印之前通过隐藏/显示部分内容来配置，只需单击 **眼睛** 图标即可。

[![ Configure the print output ](https://www.itophub.io/wiki/media?w=500&tok=41ae7b&media=3_0_0:user:printer-friendly-details.png " Configure the print output ")](https://www.itophub.io/wiki/media?media=3_0_0:user:printer-friendly-details.png "3_0_0:user:printer-friendly-details.png")

要打印页面，可以使用位于页面顶部的 **打印** 按钮，但也可以在打印之前通过使用从 **浏览器菜单** 访问 **打印预览** 来获得所见即所得的预览。

页面顶部的横幅在打印输出中不可见。

## 工单变化
------------------

在iTop中管理的一些对象遵循特定的生命周期，这些生命周期对应于特定的流程。例如，对于iTop中管理的不同工单(事件工单、变更管理工单等)，情况就是如此。对于这些对象，可以使用其他操作，对应于流程执行工作流。
生命周期操作可以在**变化**弹出式菜单中作为附加的菜单项使用:

[![Menu for Ticket Specific Actions](https://www.itophub.io/wiki/media?w=500&tok=bac4bf&media=3_0_0:user:ticket-transitions-menu.png "Menu for Ticket Specific Actions")](https://www.itophub.io/wiki/media?media=3_0_0:user:ticket-transitions-menu.png "3_0_0:user:ticket-transitions-menu.png")

或者直接在对象的修改表单中作为附加的按钮:

[![Ticket Specific Actions buttons](https://www.itophub.io/wiki/media?w=600&tok=35e13d&media=3_0_0:user:ticket-specific-actions.png "Ticket Specific Actions buttons")](https://www.itophub.io/wiki/media?media=3_0_0:user:ticket-specific-actions.png "3_0_0:user:ticket-specific-actions.png")

在后一种情况下，单击**等待批准**按钮严格意义上等同于单击**应用**以保存对象的当前修改，然后从**其他操作**下拉菜单中选择**等待批准**。
每个对象上可用的操作取决于:

*   对象的生命周期(每种类型的对象可能有不同的生命周期)
    
*   对象的当前状态(并非所有状态下都可以执行所有操作)。
    
*   由她/他的角色定义的用户权限：某些操作仅限于特定的角色。
    

## 对象特定的操作

扩展可以为特定对象带来特定的操作。

以下是由 [用户操作配置器](https://www.itophub.io/wiki/page?id=extensions:itop-object-copier "extensions:itop-object-copier") 扩展的示例:

[![Person Specific Actions](https://www.itophub.io/wiki/media?w=400&tok=b0814b&media=3_0_0:user:person-other-actions.png "Person Specific Actions")](https://www.itophub.io/wiki/media?media=3_0_0:user:person-other-actions.png "3_0_0:user:person-other-actions.png")[![Ticket Specific Actions buttons](https://www.itophub.io/wiki/media?w=400&tok=8da916&media=3_0_0:user:ticket-other-actions.png "Ticket Specific Actions buttons")](https://www.itophub.io/wiki/media?media=3_0_0:user:ticket-other-actions.png "3_0_0:user:ticket-other-actions.png")

>> →下一篇：[对象显示和修改](../06-Search/) 

---
原文：<https://www.itophub.io/wiki/page?id=3_0_0:user:actions>

版本：3_0_0/user/actions.txt · Last modified: 2022/01/21 16:52 (external edit)
