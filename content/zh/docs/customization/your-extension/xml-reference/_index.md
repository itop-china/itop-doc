---
title: "XML 数据模型参考"
linkTitle: "XML 数据模型参考"
date: 2025-06-27
weight: 10
description: >
  XML 数据模型参考。
---

{{% pageinfo %}}
本文档是 iTop 模块中 `datamodel.xxxx.xml` 文件所使用的 XML 格式的参考文档。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference)。
{{% /pageinfo %}}

## 概述

XML 数据模型文件可用于定义：

- **类** - 使用安装程序或工具包"编译"时将生成实际 PHP 类
- **菜单** - 插入 iTop 页面左侧的应用程序菜单中
- **角色** - 管理对 iTop 对象的访问权限
- **品牌标识**

要定制用户门户，请参阅[门户 XML 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)。

## 基本原则

XML 数据模型包含**初始声明**和/或对在其他 XML 文件中做出的声明的**更改**。

iTop 编译器分两步工作：

1. 加载已安装模块的 XML 数据模型文件。XML 被合并为一个单一的 XML 定义。重要的是要理解，从一个空定义开始，iTop 将逐个合并每个 XML
2. 解释最终的合并定义

默认情况下，给定 XML 的内容被合并到合并定义中。

### 更改节点内容

您可以使用 `_delta` 属性定义更改。此属性指定给定节点（包括其子节点）应如何处理。

`_delta` 可以取以下值：

| `_delta` | 含义 |
|----------|------|
| `merge`（默认） | 如果此节点尚不存在，则创建它。然后检查其子节点中的 delta。这主要与结构节点相关 |
| `must_exist` | 确保此节点已存在。然后检查其子节点中的 delta |
| `if_exists` | 2.3.0 新增 - 检查此节点是否已存在。如果是，检查其子节点中的 delta。否则忽略此节点。类似于 `must_exist`，但跳过当前节点而不是停止整个过程 |
| `define` | 这是此节点的首次定义。其子节点中不应包含任何标志 |
| `define_if_not_exists` | 如果节点尚不存在则定义它。否则忽略它 |
| `redefine` | 此节点的内容必须被 delta 节点的内容替换 |
| `delete` | 删除此节点。如果节点不存在则停止处理。不要在此节点下提供任何子节点 |
| `delete_if_exists` | 删除此节点。不要在此节点下提供任何子节点 |
| `force` | 2.4.0 新增 - 强制定义此节点，无论它是否存在 |

节点通过其标签名和 `id` 属性来标识。如果没有给出 `id`，则节点被标识为找到的第一个具有相同标签名的节点。

当编译器遇到 `define`/`redefine` 时，它认为子树是纯内容定义。因此，该子树中找到的任何 `_delta` 或 `_rename_from` 属性都将被忽略。

当单个节点下可以有多个相同标签的节点时，我们称之为集合。

### 重命名节点

另一个属性是 `_rename_from`。使用它来指定项目（例如类字段）实际上是从 `_rename_from` 重命名为 `id` 的现有项目。

## XML 通用结构

| 标签 | 用法 | 说明 |
|------|------|------|
| `<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">` | 必需 | 结构节点。此标签前不允许有注释。与先前版本相比的变化，请参阅 Version_30 的详细信息 |
| `<classes>` | 必需 | 声明的类 |
| `<class id="name">` | 零个或多个 | 类声明 |
| `<parent>cmdbAbstractObject</parent>` | 必需 | 父类。参见类属性继承 |
| `<properties>` | 必需 | 属性 |
| `<is_link>1</is_link>` | 可选 | 区分用于链接其他类的类。对于链接类设置为 1 |
| `<comment>` | 必需 | 添加到编译文件中的 PHP 注释，位于类声明之前 |
| `<category>bizmodel,searchable</category>` | 可选 | 此类的用途。参见类类别 |
| `<abstract>false</abstract>` | 必需 | 抽象类不能被实例化 |
| `<key_type>autoincrement</key_type>` | 必需 | 始终设置为 "autoincrement" |
| `<db_table>name</db_table>` | 必需 | 此类使用的 MySQL 表名。此处给出的名称将自动添加安装时提供的后缀 |
| `<db_key_field>id</db_key_field>` | 必需 | 将标识符字段始终设置为 "id" 即可 |
| `<db_final_class_field>` | 必需 | 如果类位于类层次结构的顶部，则必须定义哪个 MySQL 列将用于跟踪对象实例的实际类。将其设置为 "finalclass" 即可 |
| `<naming>` | 可选 | 定义用于组成对象友好名称的属性。默认情况下，友好名称将渲染为给定属性的连接，以空格分隔。您可以通过添加字典条目 `Class:<myClass>/Name` 指定任何其他格式。此格式以类 printf 格式表达式给出（仅支持 `$s`。例如 `'%1$s of %2$s'`）。由于此格式位于字典中，它可能被翻译，友好名称将取决于最终用户的语言 |
| `<attributes>` | 必需 | 用于组成友好名称的属性列表。注意顺序很重要 |
| `<attribute id="name">` | 至少一个 | 属性 |
| `<complementary_attributes>` | 可选 | 定义用于补充对象友好名称以区分重复项的属性列表。默认情况下，补充为空。您可以通过添加字典条目 `Class:<myClass>/ComplementaryName` 指定格式 |
| `<fields_semantic>` | 可选 | 定义承载类某些方面的属性（例如图像、状态等） |
| `<image_attribute>` | 可选 | 承载应代表对象的图像的属性代码（必须声明为 AttributeImage）。如果未定义，则在必要时使用类图标 |
| `<state_attribute>` | 可选 | 承载对象状态的属性代码，如果有生命周期则必需，属性必须是当前类的枚举。如果此处未定义但在父类中定义，则继承 |
| `<order>` | 可选 | 定义类的默认排序顺序，如果省略则按友好名称排序 |
| `<columns>` | 必需 | 列 |
| `<column id="name" ascending="true|false">` | 至少一个 | 按升序或降序对此属性排序。属性的顺序很重要 |
| `<style>` | 可选 | 指定类的样式（颜色和图标）。自 iTop 3.0 起支持 |
| `<icon>../../images/user-request.png</icon>` | 可选 | 为类指定图标（相对于模块根目录的路径） |
| `<main_color>#4E79A5</main_color>` | 可选 | 类的主色，可以是任何有效的 CSS 颜色（hexa、rgba、hsla，但不能是变量）或 SCSS 变量 |
| `<complementary_color>#FFFFFF</complementary_color>` | 可选 | 类的互补色，可以是任何有效的 CSS 颜色或 SCSS 变量 |
| `<reconciliation>` | 必需 | 定义数据导入的默认协调方案 |
| `<indexes>` | 可选 | 定义表索引 |
| `<index id="name">` | 零个或多个 | 显式强制创建数据库索引，包含所有指定属性，按声明的顺序 |
| `<archive>` | 可选 | 归档配置 |
| `<enabled>true</enabled>` | 必需 | 仅适用于根类。设置为 true 以使此类及其后代可归档（添加两个魔法属性：archive_flag 和 archive_date） |
| `<obsolescence>` | 可选 | 过时配置。一旦为类定义了过时，就会添加两个魔法属性（obsolescence_flag 和 obsolescence_date），层次结构中的所有类都有该标志（默认为 "No"） |
| `<condition><![CDATA[status='closed']]></condition>` | 必需 | 定义对象是否过时的 OQL 表达式。此条件将由子类继承，除非被重新定义 |
| `<uniqueness_rules>` | 可选 | 保存对象时用于检查其唯一性的规则 |
| `<fields>` | 必需 | 属性声明（与从父类继承的属性累积） |
| `<lifecycle>` | 可选 | 生命周期：状态和转换。在 3.0 中，"lifecycle/attribute" 标签被替换为 "fields_semantic/attribute_state" |
| `<highlight_scale>` | 可选 | 定义对象显示（列表中的背景颜色和图标）的高亮代码列表 |
| `<presentation>` | 必需 | 展示 |
| `<details>` | 必需 | 定义对象的可视化和编辑表单的展示。可以被生命周期标志 "hidden" 覆盖 |
| `<search>` | 必需 | 搜索屏幕的 "Add new criteria" 菜单的 "Most popular" 部分中显示的属性有序列表 |
| `<default_search>` | 可选 | 搜索屏幕中显示的默认搜索条件有序列表。如果留空或不存在，则继承自父类 |
| `<list>` | 必需 | 默认在结果列表中显示的属性有序列表 |
| `<summary>` | 可选 | 在外部键弹出概述中显示的属性有序列表。自 iTop 3.1 起 |
| `<custom_presentations>` | 可选 | 扩展带来的自定义属性列表。自 iTop 3.1 起 |
| `<menus>` | 必需 | 主 GUI 中显示的菜单声明（左窗格） |
| `<user_rights>` | 必需 | 用户权限策略的实现：用户将拥有一个或多个角色，授予他们访问权限 |
| `<groups>` | 必需 | 组是类的集合。授权基于此分组 - 参见 "profiles" |
| `<profiles>` | 必需 | 将在应用程序中列出的角色。用户可拥有一个或多个角色。"administrator" 角色始终存在且不可重新定义 |
| `<files>` | 可选 | 用于在 XML 中嵌入二进制文件（如图标）。自 iTop 2.0.1 起支持 |
| `<dictionaries>` | 可选 | 用于在 XML 中添加本地化。自 iTop 2.0.1 起支持 |
| `<branding>` | 可选 | GUI 的外观。Logo 定义为 PNG 文件（相对于模块根目录的路径 = env-production），或 fileref 标签 |
| `<main_logo>` | 可选 | 主 GUI 的 Logo（菜单展开时左上角）。尺寸：最大宽度 310px，最大高度 70px |
| `<main_logo_compact>` | 可选 | 控制台菜单折叠时左上角的 Logo。尺寸：宽度 37px，高度 37px |
| `<login_logo>` | 可选 | 登录页面的 Logo。尺寸：最大宽度 300px，最大高度 54px |
| `<portal_logo>` | 可选 | 客户门户的 Logo。尺寸：最大宽度 192px，最大高度 50px |
| `<main_favicon>` | 可选 | 主 GUI 和默认其他 GUI 使用的 Favicon（浏览器标签中的图标）。自 iTop 3.2.0 起 |
| `<portal_favicon>` | 可选 | 最终用户门户使用的 Favicon。自 iTop 3.2.0 起 |
| `<login_favicon>` | 可选 | 登录页面使用的 Favicon。自 iTop 3.2.0 起 |
| `<themes>` | 必需 | 主题主节点，用于自定义 iTop 外观。自 iTop 2.7.0 起 |
| `<themes_common>` | 必需 | **3.1 新增** 全局主题规则，与 themes 节点中声明的每个主题一起编译。可以包含与 theme 节点相同的内容 |
| `<constants>` | 可选 | 要编译为 PHP defines 的常量 |
| `<portals>` | 可选 | 用户界面入口点的定义。自 iTop 2.2.0 起支持 |
| `<module_parameters>` | 可选 | 模块特定参数的定义。自 iTop 2.2.0 起支持 |
| `<module_designs>` | 可选 | 模块特定设计数据。自 iTop 2.3.0 起支持 |
| `<snippets>` | 可选 | 要注入 PHP 模型文件中的 PHP 代码片段。自 iTop 2.2.0 起支持 |
| `<meta>` | 可选 | 存储有关 XML 定义的元信息的根节点，编译器忽略 |
| `<events>` | 可选 | **3.1 新增** 事件定义列表 |
| `<event_listeners>` | 可选 | **3.1 新增** 全局事件监听器 |

## 字段类型

字段（也称为属性）是对象的实际数据成员。一个字段通常对应数据库中一个（或多个）表列。不同类型的字段如下：

| 类型 | 说明 |
|------|------|
| `AttributeBlob` | 二进制大对象（最大 4GB） |
| `AttributeCaseLog` | 案例日志，讨论线程。每条消息标有说话者姓名和当前时间 |
| `AttributeCustomFields` | 自定义模块处理的自定义字段。自 iTop 2.3.0 起支持 |
| `AttributeDashboard` | 仅用于显示信息的仪表板字段。自 iTop 2.6.0 起支持 |
| `AttributeDate` | 日期（无时间） |
| `AttributeDateTime` | 日期和时间 |
| `AttributeDecimal` | 十进制值 |
| `AttributeDuration` | 持续时间，以秒存储，以天/小时/分钟/秒显示 |
| `AttributeEmailAddress` | 电子邮件地址 |
| `AttributeEncryptedPassword` | 加密存储的密码字符串（最大 65535 字符），在 UI 中不可读。自 3.2.1 起 |
| `AttributeEncryptedString` | 加密存储的字符串（最大 255 字符），在 UI 中可读 |
| `AttributeEnum` | 固定值集合中的字符串 |
| `AttributeEnumSet` | 固定值集合中的字符串集合 |
| `AttributeExternalField` | 另一个对象持有的属性的别名（参见 "ExternalKey"） |
| `AttributeExternalKey` | 指向给定类对象的外部键 |
| `AttributeHierarchicalKey` | 指向同一类的外部键，用于构建对象层次结构 |
| `AttributeHTML` | HTML 文本（最大 4GB） |
| `AttributeImage` | 图像（最大 4GB） |
| `AttributeInteger` | 正整数值 |
| `AttributeIPAddress` | IP 地址 |
| `AttributeLinkedSet` | 指向当前对象的对象集合 |
| `AttributeLinkedSetIndirect` | 通过"链接类"与当前对象相关的对象集合 |
| `AttributeMetaEnum` | 在其他枚举字段之后计算的字符串，可在子类中定义。自 iTop 2.3.0 起支持 |
| `AttributeObjectKey` | 灵活的外部键：指向任何类对象的指针。自 iTop 2.2.0 起实验性支持 |
| `AttributePercentage` | 百分比（0 到 100 之间的整数），以条形显示 |
| `AttributePhoneNumber` | 电话号码 |
| `AttributeRedundancySettings` | 关系冗余设置。自 iTop 2.2.0 起支持 |
| `AttributeStopWatch` | 累计在某些状态中花费的时间 |
| `AttributeString` | 字符串（限制为 255 字符的一行） |
| `AttributeSubitem` | 秒表中存在的某个状态信息。两者必须在同一类中定义！ |
| `AttributeTagSet` | 要与对象关联的标签列表。存储在 255 长度字符串上 |
| `AttributeText` | 多行文本（最大 64KB） |
| `AttributeLongText` | 大文本（最大 4GB） |
| `AttributeURL` | URL（http...） |

## 生命周期

### 刺激（Stimuli）

每个从一个状态到另一个状态的转换（对于有生命周期的对象）在对象收到刺激时触发。不同类型的刺激如下：

| 类型 | 说明 |
|------|------|
| `StimulusUserAction` | 最终用户决定的操作。刺激显示在 Actions 菜单中（如果对象处于考虑此刺激的状态） |
| `StimulusInternal` | 可以以编程方式触发的操作 |

### 转换上的操作

有关可在 XML 中作为操作调用的现有方法，请参阅[转换可用方法](https://www.itophub.io/wiki/page?id=3_2_0:customization:actions-on-transitions)。

## 菜单类型

不同类型的菜单如下：

| 类型 | 说明 |
|------|------|
| `MenuGroup` | 顶级菜单。此菜单将始终保持可见。它是其他菜单的容器 |
| `DashboardMenuNode` | 仪表板。内容可以通过 "export" 功能生成。内容可以在文件（definition_file）中或直接在此处（definition） |
| `NewObjectMenuNode` | 创建新对象的快捷方式 |
| `SearchMenuNode` | 搜索对象的快捷方式 |
| `TemplateMenuNode` | 用于二级菜单组 |
| `OQLMenuNode` | 显示搜索结果的快捷方式，给定 OQL 查询 |

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference>

2026/01/23 14:22 by127.0.0.1

版本：3_2_0/customization/xml_reference.txt · Last modified: 2026/01/23 14:22 by 127.0.0.1
