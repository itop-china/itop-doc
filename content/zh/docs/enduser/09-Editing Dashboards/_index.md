---
title: "编辑仪表盘"
linkTitle: "编辑仪表盘"
date: 2022-11-09
weight: 9
description: >
      <br> ➡️ 介绍如何配置仪表盘。
---

{{% pageinfo %}}
## 编辑仪表盘

iTop 中的某些页面是**仪表盘**。仪表盘用于在同一页上显示有关不同 iTop 对象的信息。大多数**概览**页面以及**欢迎**页面都是仪表盘。在 iTop 2.0 中，每个用户都可以通过编辑现有的仪表盘页面来定制自己的仪表盘，但是不能够创建新的仪表盘页面。

当页面是可编辑的仪表盘时，在页面右上角会出现小的**笔状**下拉菜单，靠近**退出**菜单旁边。

![仪表盘弹出菜单](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-popup-menu-create.png "仪表盘弹出菜单")

要编辑当前页面，请选择**新建自定义版本**。

几秒钟后，一个弹出对话框会出现，其中包含**仪表盘编辑器**对话框：

[![仪表盘编辑器对话框](https://www.itophub.io/wiki/media?w=800&tok=42bc35&media=3_1_0:user:dashboard-editor.png "仪表盘编辑器对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-editor.png "3_1_0:user:dashboard-editor.png")

仪表盘由名为**组件**的构建块组成。

仪表盘本身排列了包含组件的显示。仪表盘仅具有三个属性：

* 布局（一列、两列或三列）
* 可选标题
* 自动刷新设置（禁用，或以秒为单位的刷新间隔）

布局确定如何在页面上排列组件：它确定了一个网格，每个组件都分配给网格的一个单元格。当布局更改时，单元格（以及单元格内的组件）将重新组织以产生所需的显示。

[![仪表盘布局](https://www.itophub.io/wiki/media?w=500&tok=d9cb5f&media=3_1_0:user:dashboards-layouts.png "仪表盘布局")](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboards-layouts.png "3_1_0:user:dashboards-layouts.png")

要编辑组件的属性，请在对话框的左侧单击它。选择的组件周围会出现橙色边框，并且组件的属性将显示在对话框的右侧。要修改组件的外观，只需在右侧修改属性。组件将根据你的修改而改变。要从仪表盘中删除所选的组件，请单击所选组件右上角的**_红色叉_**。

要将新的组件添加到仪表盘中，请将其中一个组件图标拖动到仪表盘的所需区域，然后在右侧调整属性以完成仪表盘。

[![](https://www.itophub.io/wiki/media?w=800&tok=c3d6f8&media=3_1_0:user:dashboard-edition2.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-edition2.png "3_1_0:user:dashboard-edition2.png")

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">你还可以从任何 iTop 对象列表创建新的组件。有关如何执行此操作的更多信息，请参见[管理列表](../07-managing_lists/)。</font>

在编辑完成后，点击**_保存_**，保存修改并返回 iTop 页面。

要撤消自从点击**编辑此页面**以来所做的所有修改，请点击**_取消_**。


>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">仪表盘的修改适用于当前用户。所有其他用户会保留自己的仪表盘副本（或默认仪表盘，如果他们未自定义它的话）</font>

{{% /pageinfo %}}

## 组件（Dashlet）类型

以下是用于构建 iTop 仪表盘的不同类型的组件：

| 图标 | 名称 | 描述 |
| --- | --- | --- |
| ![文本](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-text.png "文本") | 文本 | 一个自由文本区域。用于在页面上添加标题或内容。 |
| ![列表](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-list.png "列表") | 对象列表 | 以表格形式显示 iTop 对象的列表，类似于任何搜索结果。 |
| ![饼图](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-pie-chart.png "饼图") | 饼图 | iTop 对象的列表，根据给定字段分组并显示为饼图。**2.5 版本新增**：除计数外，还可以在指定字段上使用各种功能（求和、平均、最小和最大值）。还可以指定排序方向和最大结果数。 |
| ![柱状图](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-bar-chart.png "柱状图") | 柱状图 | iTop 对象的列表，根据给定字段分组并显示为柱状图。**2.5 版本新增**：除计数外，还可以在指定字段上使用各种功能（求和、平均、最小和最大值）。还可以指定排序方向和最大结果数。 |
| ![分组（表）](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-groupby-table.png "分组（表）") | 分组（表） | iTop 对象的列表，根据给定字段分组并显示为表格。**2.5 版本新增**：除计数外，还可以在指定字段上使用各种功能（求和、平均、最小和最大值）。还可以指定排序方向和最大结果数。 |
| ![标头](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-header.png "标头") | 标头 | 左侧带有图标和标题的灰色横栏。 |
| ![带计数的标头](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-header-stats.png "带计数的标头") | 带计数的标头 | 左侧带有图标、标头和一个表格的灰色横栏，显示按给定字段分组的对象计数。 |
| ![徽章](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-badge.png "徽章") | 徽章 | 带有文本的图标，显示给定类别的对象总数，并提供两个链接：“创建…” 和 “搜索…”。 |

## 动态组件

大多数组件在其属性中都包含了一个 OQL（对象查询语言）。这些 OQL 可以根据当前用户、当前时间以及当前对象（如果存在）进行调整，实现动态效果。

如果仪表盘是一个 `菜单` 仪表盘，您可以使用前两种方法。

### 基于当前用户

**:current\_contact\_id**：这是与连接用户关联的联系人的 ID，如果用户未关联联系人，则为 0。它允许显示当前用户是处理人的工单，例如：

```sql
SELECT Ticket WHERE agent\_id \= :current\_contact\_id
```

### 基于时间

在下面的 OQL 示例中，我们显示过去 30 天内创建且尚未关闭的工单：

```
SELECT Ticket 
WHERE creation\_date \> DATE\_FORMAT(DATE\_SUB(NOW(), INTERVAL 30 DAY),'%Y-%m-%d 00:00:00') 
AND STATUS !\= 'closed'  
```

### 基于当前对象

仅适用于在对象上定义的仪表板属性，您可以使用当前对象的任何字段来过滤您的 OQL。

例如，在组织（Organization）上，您可以使用占位符 `:this->_att_code_`，其中 `_att_code_` 可以是组织的任何字段，包括 `id`。

```
SELECT UserRequest WHERE org\_id\=:this\->id
```

## 编辑自定义版本

一旦创建了特定仪表盘的自定义版本，只能编辑自定义版本 ![编辑仪表板的自定盘版本](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-popup-menu-edit.png "编辑仪表盘的自定义版本")

## 在不同版本之间切换

在浏览仪表盘时，你可以随时在自定义版本和标准版本之间切换显示。

*   橙色建筑图标表示处于**标准版本**： ![标准仪表板图标](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-icon-standard.png "标准仪表板图标")
    
*   橙色人物图标表示正在查看**自定义版本**： ![自定义仪表板图标](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-icon-custom.png "自定义仪表板图标")

## 导出仪表盘
---------------------

*   仪表盘定义可以导出为XML文件，用于存档或与其他用户共享。
    
*   要导出仪表板，请点击菜单项 **_导出到文件…_**。
    
*   在提示时，输入下载位置（导出的仪表盘将保存到计算机上的位置）。

![导出仪表板](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-popup-menu-export.png "导出仪表板")

## 导入仪表盘
---------------------

![导入仪表板](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-popup-menu-import.png "导入仪表板")

要从XML文件导入仪表盘定义，请点击 **_从文件导入…_**，然后从计算机上选择要上传的XML文件。

![](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-upload.png)

如果在尚未自定义的仪表板菜单上导入仪表板，系统将自动创建一个自定义版本。

当在已存在自定义版本的情况下导入仪表板时，该自定义版本将会丢失。
如果想要保留该版本，请先导出它。

## 打印仪表板
--------------------

可以选择纸张方向，然后使用浏览器的打印菜单：

[![打印版本的仪表板](https://www.itophub.io/wiki/media?w=500&tok=563ad7&media=3_1_0:user:dashboard-printed-version.png "打印版本的仪表板")](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-printed-version.png "3_1_0:user:dashboard-printed-version.png")

## 放弃定制内容
-----------------------------

![](https://www.itophub.io/wiki/media?media=3_1_0:user:dashboard-popup-menu-delete.png)

随时可以放弃仪表盘的定制内容。只需点击 **_删除自定义版本…_**，然后在弹出的确认对话框进行确认。

## 高级自定义

### 拆分单元格

有时手动重新组织仪表盘会有些困难，特别是当在一个单元格中有许多仪表盘并且想要将它们拆分成多个单元格时。

1. 在仪表盘上，选择操作 `导出到文件…` 并将文件保存到您的计算机上
    
2. 使用 XML 编辑器进行编辑，输入下面的代码片段，其中想要拆分单元格的位置
    
    * 每次粘贴代码时，**将 X 替换为一个唯一的数字**，以标识仪表盘中新单元格的顺序
        
3. 保存文件
    
4. 在你的 iTop 仪表盘上选择操作 `从文件导入…` 并上传保存的 XML 文件

[单元格分隔符](https://www.itophub.io/wiki/page?do=export_code&id=3_1_0:user:dashboards&codeblock=3 "下载片段")

```
      </dashlets\>
    </cell\>
    <cell id\="X"\>
      <rank\>X</rank\>
      <dashlets\>
```

描述仪表盘的一个XML文件样例：

[仪表板导出](https://www.itophub.io/wiki/page?do=export_code&id=3_1_0:user:dashboards&codeblock=4 "下载代码片段")


```
<?xml version\="1.0"?>
<dashboard xmlns:xsi\="http://www.w3.org/2001/XMLSchema-instance"\>
  <layout\>DashboardLayoutOneCol</layout\>
  <title\>Menu:WelcomeMenuPage</title\>
  <auto\_reload\>
    <enabled\>false</enabled\>
    <interval\>300</interval\>
  </auto\_reload\>
  <cells\>
    <cell id\="0"\>
      <rank\>0</rank\>
      <dashlets\>
        <dashlet id\="1" xsi:type\="DashletHeaderStatic"\>
          <rank\>0</rank\>
          <title\>Menu:ConfigManagementCI</title\>
          <icon\>../images/icons/icons8-database.svg</icon\>
        </dashlet\>
        <dashlet id\="2" xsi:type\="DashletBadge"\>
          <rank\>1</rank\>
          <class\>BusinessProcess</class\>
        </dashlet\>
        <dashlet id\="3" xsi:type\="DashletBadge"\>
          <rank\>2</rank\>
          <class\>ApplicationSolution</class\>
        </dashlet\>
        <dashlet id\="4" xsi:type\="DashletBadge"\>
          <rank\>3</rank\>
          <class\>Contact</class\>
        </dashlet\>
        <dashlet id\="5" xsi:type\="DashletBadge"\>
          <rank\>4</rank\>
          <class\>Location</class\>
        </dashlet\>
        <dashlet id\="7" xsi:type\="DashletBadge"\>
          <rank\>5</rank\>
          <class\>Server</class\>
        </dashlet\>
        <dashlet id\="8" xsi:type\="DashletBadge"\>
          <rank\>6</rank\>
          <class\>NetworkDevice</class\>
        </dashlet\>    
<!-- You want to split here -->
        <dashlet id\="11" xsi:type\="DashletHeaderDynamic"\>
          <rank\>0</rank\>
          <title\>Menu:RequestManagement</title\>
          <icon\>itop-welcome-itil/images/user-request-deadline.svg</icon\>
          <subtitle\>Menu:UserRequest:OpenRequests</subtitle\>
          <query\>SELECT UserRequest WHERE status != "closed"</query\>
          <group\_by\>status</group\_by\>
          <values\>new,assigned,escalated\_tto,escalated\_ttr,resolved</values\>
        </dashlet\>
        <dashlet id\="12" xsi:type\="DashletObjectList"\>
          <rank\>1</rank\>
          <title\>UI:WelcomeMenu:MyCalls</title\>
          <query\>SELECT UserRequest AS i WHERE i.agent\_id = :current\_contact\_id AND status NOT IN ("closed", "resolved")</query\>
          <menu\>true</menu\>
        </dashlet\>
      </dashlets\>
    </cell\>
  </cells\>
</dashboard\>
```
### 状态排序

* 编辑仪表盘时，**值的顺序**可能不是想要的顺序，UI不允许你重新组织它们。
* 通过使用与上述相同的过程进行XML编辑，可以解决这个问题。
* 每当再次在UI中编辑此仪表盘时，这项工作都会丢失！[:-(](https://www.itophub.io/lib/images/smileys/icon_sad.gif)，因为它会按字母顺序重新排序。 

```
  <values>assigned,dispatched,escalated\_tto,escalated\_ttr,new,resolved</values>
```

[![](https://www.itophub.io/wiki/media?w=600&tok=db49a3&media=3_1_0:user:dashlet-header-bad-order.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-header-bad-order.png "3_1_0:user:dashlet-header-bad-order.png")

```
        <dashlet id\="11" xsi:type\="DashletHeaderDynamic"\>
          <rank\>0</rank\>
          <title\>Menu:RequestManagement</title\>
          <icon\>itop-welcome-itil/images/user-request-deadline.svg</icon\>
          <subtitle\>Menu:UserRequest:OpenRequests</subtitle\>
          <query\>SELECT UserRequest WHERE status != "closed"</query\>
          <group\_by\>status</group\_by\>
          <values\>new,dispatched,assigned,escalated\_tto,escalated\_ttr,resolved</values\>
        </dashlet\>
```

[![](https://www.itophub.io/wiki/media?w=600&tok=08ee16&media=3_1_0:user:dashlet-header-good-order.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:dashlet-header-good-order.png "3_1_0:user:dashlet-header-good-order.png")

---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:dashboards>

版本：3_1_0/user/dashboards.txt · Last modified: 2023/07/21 10:19 (external edit)
