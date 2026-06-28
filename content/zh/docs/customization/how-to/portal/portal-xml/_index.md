---
title: "门户 XML 参考"
linkTitle: "门户 XML 参考"
date: 2025-06-27
weight: 10
description: >
  门户 XML 参考。
---

{{% pageinfo %}}
本文档是 iTop 客户门户 XML 配置的完整参考。您必须熟悉 iTop XML 设计的基础知识。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)。
{{% /pageinfo %}}

## 概述

您必须熟悉 [iTop XML 设计](https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference)的基础知识。

有关客户门户定制功能的概述，请查看页面 [定制您的客户门户](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_overview)。

## 结构

此结构特定于基于 **itop-portal-base** 库开发的门户。

### 全局结构标签

| 标签 | 用途 | 说明 |
|------|------|------|
| `<module_design id="PORTAL_UNIQUE_ID" xsi:type="portal">` | 必填 | 定义门户实例配置的结构节点 |
| `<properties>` | 必填 | 实例的全局属性 |
| `<name>portal:itop-portal</name>` | 必填 | 门户名称，用于门户选择下拉框和门户 logo 图像标题属性 |
| `<logo>../images/itop-logo.png</logo>` | 可选 | 实例中使用的 logo。如果定义，将覆盖 Designer 或 env-xxx/branding/portal-logo.png 中的 logo |
| `<themes>` | 必填 | 声明的 CSS 样式表 |
| `<theme id="custom">sample-portal-custom-css/custom.css</theme>` | 零个或多个 | CSS 样式表列表。ID 为 bootstrap\|portal\|custom 的样式表首先加载，重新定义它们将覆盖默认文件。然后加载其他 ID。路径必须相对于 /env-xxx |
| `<templates>` | 必填 | 声明的 TWIG 模板 |
| `<template id="layout">sample-portal-alter-twig/layout.html.twig</template>` | 零个或多个 | 要覆盖的 TWIG 模板列表。可用值为 "layout"（整个页面）或 "home"（首页内容）。（Brick 内容布局可以在每个 Brick 中直接定义） |
| `<urlmaker_class>iTopPortalViewUrlMaker</urlmaker_class>` | 可选 | 用于生成对象查看 URL 的类（例如在通知、linksets 中） |
| `<triggers_query>` | 必填 | 在实例上更新对象时检索触发器的 OQL 查询 |
| `<attachments>` | 必填 | 结构节点 |
| `<allow_delete>true</allow_delete>` | 必填 | 门户中是否可以删除附件。可用值为 true\|false |
| `<allowed_portals>` | 必填 | 结构节点 |
| `<opening_mode>tab</opening_mode>` | 必填 | 定义其他门户（允许当前用户访问）的打开方式。可用值为 "tab"（新标签页打开）或 "self"（当前标签页打开）。默认值为 "tab" |
| `<bricks>` | 必填 | 声明的 Brick |

### Brick 通用标签

| 标签 | 用途 | 说明 |
|------|------|------|
| `<brick id="BRICK_UNIQUE_ID" xsi:type="ANY_FQCN_BRICK">` | 零个或多个 | Brick 的声明。ID 必须在集合中唯一。xsi:type 必须是完全限定类名（包括命名空间）。可以有多个相同 xsi:type 的 Brick 实例，只要它们的 ID 不同。请参阅 Brick 类型部分（注意：仅在此节点下显示通用标签） |
| `<active>true</active>` | 可选 | Brick 在门户上是否激活。注意，在首页和导航菜单上都不可见的活动 Brick 仍然可以通过其 URL 访问。可用值为 true\|false，默认值为 true |
| `<width>6</width>` | 可选 | 首页上瓦片的宽度。值必须是 1-12 之间的整数，12 表示整行宽度。默认值为 3 |
| `<rank>` | 可选 | Brick 在首页和导航菜单上的排名。如果未指定，将放在首位 |
| `<default>1</default>` | 可选 | 首页和导航菜单上的排名。值必须是浮点数 |
| `<home>1</home>` | 可选 | 仅首页上的排名。值必须是浮点数 |
| `<navigation_menu>1</navigation_menu>` | 可选 | 仅导航菜单上的排名。值必须是浮点数 |
| `<title>` | 可选 | Brick 在首页和导航菜单上的标题 |
| `<description>` | 可选 | 将在首页上显示的 Brick 描述 |
| `<visible>` | 可选 | Brick 在首页和导航菜单上是否可见。如果未指定，默认在两个上都为 true |
| `<decoration_class>` | 可选 | Brick 图标在首页和导航菜单上的 CSS 类。可以使用 Glyphicon、Font Awesome 或您自己的 CSS 类 |
| `<security>` | 可选 | 限制哪些角色可以查看此 Brick |
| `<allowed_profiles>` | 可选 | 返回可以查看此 Brick 的角色的 OQL。如果省略，则所有未明确拒绝的角色都可以查看 |
| `<denied_profiles>` | 可选 | 不能查看此 Brick 的角色 |

### 表单标签

| 标签 | 用途 | 说明 |
|------|------|------|
| `<forms>` | 必填 | 声明的表单 |
| `<form id="name">` | 零个或多个 | 表单的声明。ID 必须唯一 |
| `<class>ServiceSubcategory</class>` | 必填 | 表单的对象类。子类将继承此表单（如果它们没有定义自己的） |
| `<properties>` | 可选 | 结构节点 |
| `<display_mode>cosy</display_mode>` | 可选 | 表单字段的显示模式。"cosy" 表示常规标签在值上方的布局；"compact" 表示并排的布局，25% 空间用于标签，75% 用于输入；"dense" 表示并排的布局，输入填充所有可用空间。您还可以使用自定义 CSS 类，该将在表单上用作 "form_xxx"，在字段上用作 "form_field_xxx"。可用值为 cosy\|compact\|dense\|CUSTOM_VALUE，默认值为 cosy |
| `<always_show_submit>false</always_show_submit>` | 可选 | 设置为 false 时，当对象上有可用转换时隐藏提交按钮。可用值为 true\|false，默认值为 false |
| `<navigation_rules>` | 可选 | 要应用于此表单的导航规则 |
| `<fields>` | 可选 | 声明的字段。如果为空，则仅显示来自 twig 标签的字段。如果省略，则仅显示来自 zlist details 的字段，twig 标签将被忽略 |
| `<field id="title">` | 零个或多个 | 字段的声明。ID 必须是类的有效属性代码。如果未放置在 twig 标签中，将逐个放置。缺少的必填属性将自动附加到表单 |
| `<twig>` | 可选 | 表单布局。您可以在此标签下使用任何 HTML 标签来制作完美的表单模板。如果未定义，字段将逐个放置 |
| `<modes>` | 可选 | 声明的模式。如果未定义，表单将适用于所有模式 |
| `<mode id="apply_stimulus">` | 零个或多个 | 定义表单对此类可用的模式。可用值为 view\|edit\|create\|apply_stimulus |

### 类标签

| 标签 | 用途 | 说明 |
|------|------|------|
| `<classes>` | 必填 | 声明的类 |
| `<class id="Contact">` | 零个或多个 | 类的声明。类（或其祖先之一）必须定义才能在实例中显示。ID 必须是有效的对象类 |
| `<scopes>` | 必填 | 声明的范围 |
| `<scope id="name">` | 零个或多个 | 范围的声明。范围定义了角色可以访问的对象集，它们关于用户角色是累积的 |
| `<oql_view>` | 必填 | 定义允许查看的对象集的 OQL 查询 |
| `<oql_edit>` | 可选 | 定义允许编辑的对象集的 OQL 查询。注意，这仅适用于 oql_view 的子集 |
| `<ignore_silos>false</ignore_silos>` | 可选 | 设置为 "true" 时，此范围的 OQL 将不受当前用户允许组织的限制。值可以是 true\|false，默认值为 "false" |
| `<allowed_profiles>` | 可选 | 声明将有权访问该范围的角色。如果此标签不存在，则所有角色都可以访问该范围 |
| `<lists>` | 可选 | 演示列表。目前，仅在门户中的对象的 LinkedSet 中使用 |
| `<lifecycle>` | 可选 | 生命周期：每个角色禁用的事件，如果省略则应用用户角色定义 |
| `<action_rules>` | 可选 | 声明的操作规则。AR 是在特定 Brick 中、特定操作上应用于对象/表单的操作。它们可以组合 |
| `<navigation_rules>` | 可选 | 声明的导航规则。NR 是定义在单击对象表单的提交/取消按钮后去向的操作 |

## Brick 类型

以下是 **itop-portal-base** 库中内置的功能。您可以在单独的模块中实现自己的 Brick，只要其名称（即 xsi:type）不与现有 Brick 冲突。

### UserProfileBrick

用户个人资料编辑 Brick。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<show_picture_form>true</show_picture_form>` | 可选 | 显示/隐藏用户头像表单。可用值为 true\|false，默认值为 true |
| `<show_preferences_form>true</show_preferences_form>` | 可选 | 显示/隐藏用户偏好设置表单。可用值为 true\|false，默认值为 true |
| `<show_password_form>true</show_password_form>` | 可选 | 显示/隐藏用户密码表单。可用值为 true\|false，默认值为 true |
| `<form>` | 必填 | 连接用户的联系信息编辑表单。行为与门户的全局表单完全相同，请参阅相应部分 |

### BrowseBrick

浏览对象层次结构，并为每个级别指定操作（查看或编辑对象、从此对象创建另一个对象）。可以从多个视图进行导航，如常规列表或树。一个用例是浏览服务目录以找到要创建请求的服务。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<levels>` | 必填 | 声明的级别 |
| `<level id="UNIQUE_ID">` | 必填 | 级别的声明。ID 必须唯一，整数更安全，避免使用 '-' |
| `<class>ServiceFamily</class>` | 可选 | 此级别上显示的对象类。如果存在 oql 标签则忽略 |
| `<oql>` | 可选 | 定义要显示的对象类子集的 OQL 查询。如果定义则优先于 class 标签 |
| `<actions>` | 可选 | 该级别对象的可用操作 |
| `<browse_modes>` | 必填 | 浏览模式列表 |
| `<availables>` | 必填 | 可用浏览模式列表 |
| `<default>list</default>` | 必填 | 默认浏览模式。必须是可用浏览模式之一：list\|tree\|mosaic |
| `<default_list_length>20</default_list_length>` | 可选 | 设置列表默认显示的项目数。可用值为 10\|20\|50\|-1 |
| `<data_loading>auto</data_loading>` | 必填 | 定义数据加载方式。可用值为 auto\|full\|lazy |

### ManageBrick

通过在两轴上分组来管理对象并编辑它们。通常用于管理正在进行的请求或一组 CI。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<class>Ticket</class>` | 可选 | 要管理的对象类。如果未定义 oql 标签则必填，否则忽略 |
| `<oql>` | 可选 | 定义要管理的对象子集的 OQL 查询。优先于 class 标签 |
| `<opening_target>modal</opening_target>` | 可选 | 定义操作方式。值可以是 "modal"（模态窗口）、"new"（新窗口）或 "self"（当前窗口）。默认值为 "modal" |
| `<opening_mode>edit</opening_mode>` | 可选 | 定义对象的打开方式。值可以是 edit\|view，默认值为 "edit" |
| `<fields>` | 可选 | 对象列表中显示的属性列表，如果省略则使用 zlist "list" |
| `<display_modes>` | 可选 | 显示模式列表，如果省略则仅使用 'list' |
| `<grouping>` | 必填 | 声明的分组 |
| `<tabs>` | 必填 | 在标签页上的分组通过 OQL 查询完成，在表格上的分组通过 finalclass 完成 |
| `<export>` | 可选 | 允许用户从详细列表视图导出数据 |

### CreateBrick

显示对象创建表单。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<modal>true</modal>` | 必填 | 表单是否在模态对话框或整页中。可用值为 true\|false，默认值为 true |
| `<class>UserRequest</class>` | 必填 | 要创建的对象类。可以是抽象类，系统将提示用户选择最终类 |
| `<rules>` | 必填 | 要应用于表单的操作规则 |

### FilterBrick

预过滤另一个 Brick。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<search_placeholder_value>` | 可选 | 过滤器字段中显示为占位符的字符串 |
| `<search_submit_label>` | 可选 | 提交按钮的标签 |
| `<search_submit_class>` | 可选 | 要添加到提交按钮的 CSS 类 |
| `<target_brick>` | 必填 | 结构节点 |
| `<id>` | 必填 | 必须与目标 Brick 的 id 对应 |
| `<type>` | 必填 | 必须与目标 Brick 的 xsi:type 对应。目前仅支持 BrowseBrick 和 ManageBrick |
| `<tab>` | 必填 | BrowseBrick：用于显示结果的浏览模式（mosaic 除外）。ManageBrick：要显示的标签页（组 id） |

### AggregatePageBrick

包含一个或多个 Brick 瓦片的页面。

| 标签 | 用途 | 说明 |
|------|------|------|
| `<aggregate_page_bricks>` | 必填 | 要包含在页面中的 Brick 列表 |
| `<aggregate_page_brick id="PAGE_BRICK_ID">` | 至少一个 | 要包含的 Brick ID |
| `<rank>1</rank>` | 可选 | 页面中瓦片的排名 |

## 导航规则

您可以创建导航规则并从任何表单中调用它们。

### 可用规则类型

**关闭表单：**
```xml
<navigation_rule id="close-form" xsi:type="close"/>
```

**返回首页：**
```xml
<navigation_rule id="go-to-homepage" xsi:type="go-to-homepage"/>
```

**转到 ManageBrick：**
```xml
<navigation_rule id="go-to-resolved-requests" xsi:type="go-to-manage-brick">
  <id>ongoing-tickets-for-portal-user</id>
  <display_mode>list</display_mode>
  <grouping_tab>resolved</grouping_tab>
</navigation_rule>
```

**转到 BrowseBrick：**
```xml
<navigation_rule id="go-to-services" xsi:type="go-to-browse-brick">
  <id>services</id>
</navigation_rule>
```

**转到对象：**
```xml
<navigation_rule id="go-to-object" xsi:type="go-to-object">
  <oql>SELECT Ticket WHERE id = :this->id</oql>
  <mode>view</mode>
  <opening_target>modal</opening_target>
</navigation_rule>
```

然后在任何表单中调用这些导航规则：

```xml
<form id="ticket-apply-stimulus">
  <properties>
    <navigation_rules _delta="define">
      <submit>
        <default>go-to-resolved-requests</default>
      </submit>
      <cancel>
        <default>go-to-homepage</default>
        <modal>close-form</modal>
      </cancel>
    </navigation_rules>
  </properties>
</form>
```

## 已知限制

自 iTop 3.1.0 版本及安全漏洞修复以来，在门户中添加 UserRequest 和 Person 等之间的关系可能会被拒绝，即使该用户具有有效的 Person 和 UserRequest 范围。用户可能会收到以下错误消息：

```
Attribute pointing to an object that is either non existing or not readable by the current user: 
  current_object = lnkContactToTicket::-1, attcode = ticket_id, attvalue = xxx, current_user = UserLocal::xx
```

根本原因是此关系存储在类 lnkContactToTicket 中，该类包含两个 AttributeExternalKey 类型的字段，一个指向 Ticket 类，另一个指向 Contact 类。

不要犹豫激活门户上的调试日志，以获取更多解释：

```php
'log_level_min' => [\LogChannels::PORTAL => \LogAPI::LEVEL_DEBUG,],
```

## 变更历史

### XML 版本 1.4

此版本随 iTop 2.4 beta 于 2017 年 7 月发布。

- **Filter Brick**：扩展已包含到核心应用程序中
- **UserProfileBrick**：可以禁用头像、偏好设置和密码表单
- **BrowseBrick**：新增 "mosaic" 模式，方便在小设备上显示与浏览对象关联的图像
- **ManageBrick**：显示标签计数
- **Create Brick**：现在支持抽象类
- 表单：可配置的显示模式、字典条目可用、LinkedSet 属性可默认打开
- 可以隐藏某些门户用户的转换

### XML 版本 1.5

- **ManageBrick**：提供新的显示类型（饼图、柱状图和徽章）
- 支持导出到 Excel
- 新增 **AggregatePageBrick**

### XML 版本 1.7

- LinkedSet 属性可以显示（或不显示）超出范围的项目
- ManageBrick 支持标签描述
- 可以更改 Browse 和 Manage Brick 的默认列表大小
- Browse Brick 中可以使用 n:n 关系
- 新增导航规则类型

### XML 版本 3.x

- 自 3.1 版本起，可以在门户中修改 n:n 关系的属性
- 自 3.2 版本起，附件占位符可以在每个门户表单中移动

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml>

版本：3_2_0/customization/portal_xml.txt · Last modified: 2026/02/18 17:10 by 127.0.0.1
