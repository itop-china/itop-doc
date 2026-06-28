---
title: "门户定制概述"
linkTitle: "门户定制概述"
date: 2025-06-27
weight: 10
description: >
  门户定制概述。
---

{{% pageinfo %}}
本文档介绍 iTop 门户定制的整体概述。自 iTop 2.3.0 起，门户完全可定制，通过 XML 配置即可实现个性化需求，几乎无需编码。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_overview)。
{{% /pageinfo %}}

## 概述

自 iTop 2.3.0 起，门户推出了全新的版本，完全可定制。这使您能够根据最终用户的需求进行定制，几乎无需编码。

## 目标受众

您是一名开发人员或顾问。您已经熟悉 [iTop XML 设计](https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference)的基础知识。

## 门户能实现什么？

- **访问权限、菜单、表单**：全部在 XML 中定义，可以轻松更改
- **可定制**：从配置到外观和感觉
- **可扩展**：通过开发 Brick（作为扩展）并配置到 XML 中，添加（和重用）新功能
- **多实例**：设置多个实例/配置以满足各种最终用户需求，仅向他们提供所需内容

## 工作原理

### 对象安全

数据安全基于数据模型的安全布局，实例无法访问超过控制台允许的内容。此外，在实例上可用于可视化和编辑的对象必须显式允许，这有助于您控制用户可以访问的内容。

### 实例功能

每个门户实例都有自己的配置，使它们完全独立于彼此。

一个实例由多个"Brick"组成，每个 Brick 启用自己的功能，如创建对象、浏览对象集合等。Brick 有自己的配置，但依赖于实例配置，无法覆盖它。

目前有 6 种类型的 Brick 可用：

| Brick 类型 | 说明 |
|-----------|------|
| **CreateBrick** | 显示对象创建表单 |
| **BrowseBrick** | 浏览对象层次结构，并为每个级别指定操作（查看或编辑对象、从此对象创建另一个对象）。可以从多个视图进行导航，如常规列表或树。一个用例是浏览服务目录以找到要创建请求的服务 |
| **ManageBrick** | 通过在两轴上分组来管理对象并编辑它们。通常用于管理正在进行的请求或一组 CI |
| **FilterBrick** | 预过滤另一个 Brick |
| **AggregatePageBrick** | 包含一个或多个 Brick 瓦片的页面 |
| **UserProfileBrick** | 显示当前用户信息的表单，以便他们可以编辑其中一些 |

可以在同一实例中添加多个相同类型的 Brick，只要它们具有不同的 ID。此外，可以开发更多 Brick 以满足其他需求（显示图片、嵌入 iframe 或视频等）。

## 配置实例

配置在数据模型中的 `/itop_design/module_designs/module_design[@="<PORTAL_ID>"]` 节点下进行。

根据您的设置选择，其他部分可以在 itop-request-mgmt、itop-request-mgmt-itil、itop-incident-mgmt-itil、itop-full-itil、itop-knownerror-mgmt 和 itop-portal 中找到。

### 对象范围

配置实例时，首先要做的是为所有应在门户中访问的对象设置范围。这将是所有 Brick 逻辑的基石。未启用对象类可能会导致 Brick 出现意外行为。

范围一旦确定了用户应该查看和编辑的内容，就很容易定义：

1. 选择对象类
2. 为用户可以查看的对象指定 OQL 查询
3. （可选）为用户可以编辑的对象指定 OQL 查询。该查询将应用于"查看"查询的子集。如果未指定，用户将无法编辑此类的对象
4. （可选）为此范围指定允许的用户角色。这意味着您可以根据用户的角色允许不同的范围

### 对象表单

现在范围已定义，您需要定义这些对象在门户中的显示方式。默认情况下，将显示包含"details" z-list 中所有属性的基本表单，但您可以自定义此布局以优化布局和/或添加/隐藏属性。

表单为特定类（及其子类）定义，用于一个或多个模式（查看、创建、编辑）。如果没有定义匹配类/模式的表单，将回退到默认表单。

您可以选择指定要显示的属性列表，在这种情况下，它们将像默认表单一样一个接一个地显示。或者，您可以提供一个 HTML 布局，门户将用正确的标记填充。可以使用 Bootstrap 类和 Twig 运算符。

您还可以在属性上设置标志，它们将与数据模型生命周期中的标志合并。

### 操作规则

操作规则是在特定情况下应用于 Brick 的行为，如预设对象值或定义提交/取消表单时打开的页面。其语法类似于 ObjectCopier，但没有它的一些限制。

操作规则可以在多个 Brick 中使用，但并非所有 Brick 都支持它们。目前它们只能在 BrowseBrick 和 CreateBrick 中使用。

### Brick

配置 Brick 应该是配置实例时的最后一步，因为它依赖于所有前面的配置。请记住，它们基于数据模型的安全性和实例的范围。

每个 Brick 都有自己的配置和特性，详细信息请参考参考指南。

## 定制外观

新门户基于 Twig（HTML 布局）和 Bootstrap（样式）等众所周知的框架，您还可以使用字体库，如 Font Awesome 和 Glyphicons 也已嵌入。这使您能够找到许多在线资源和示例。

### 更改 Bootstrap 主题

通过更改 Bootstrap 主题，您可以轻松更改门户的整体外观和感觉。许多免费主题可在线获取，您甚至可以构建自己的主题。

查看 [www.bootswatch.com](https://bootswatch.com/) 或 how-tos 中的 "sample-portal-new-theme" 示例模块。

### 更改布局

更改布局稍微复杂一些，因为您必须重新编码 HTML 标记，但这将给您自由塑造它的能力。

可以覆盖多个级别的布局：

- 全局门户结构
- 首页
- 通用 Brick 页面
- 每个 Brick 内容布局

查看 "sample-portal-alter-twig" 示例模块以获取示例。

## Web 分析器

自 iTop 2.7.0 起，门户基于 Symfony。为了便于开发，您可以启用 Symfony 的"Web 分析器"，这是一个开发工具，提供有关请求执行的详细信息。

要启用它：

1. 在同一目录中，复制文件 `/datamodels/2.x/itop-portal-base/portal/.env`（或 "/env-production/itop-portal-base/portal/.env" 以避免运行安装程序，但这将在下次安装程序运行时被删除）
2. 将复制的文件命名为 `.env.local`
3. 在此新文件中添加以下行：

```
APP_ENV=dev
```

此设置的结果是在门户屏幕底部显示一个横幅。

## 资源

请参阅 [客户门户 XML 参考指南](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)

## 模块参数

itop 门户具有可在 iTop 配置文件中覆盖的模块参数。这些参数对于每个门户实例可能不同。

### lazy_loading_threshold

定义告诉 Browse 和 Manage Brick 的**自动加载**模式在 **full** 和 **lazy** 之间切换的阈值：

- **auto**：如果数据计数小于门户实例的 "lazy_loading_threshold" 模块参数，则数据将一次性加载；超过此值将动态加载每个页面/级别
- **full**：所有数据将一次性加载
- **lazy**：数据将在每个页面/级别动态加载

### enable_formmanager_content_check

此参数用于 iTop 2.7.6、3.0.0 和 3.0.1，在后续版本（2.7.7、3.0.2 和 3.1.0）中已删除。如果门户扩展返回错误消息 "Twig content not allowed in this context!"，则可以将此参数设置为 'false'。

```php
$MyModuleSettings = array(
  'itop-portal' => array(  // itop-portal 是 iTop 中包含的用户门户
    // 'lazy_loading_threshold' => '500', 由于这是默认值，因此无需在此处指定
    'enable_formmanager_content_check' => false,
  ),
  'itop-business-portal' => array(  // 门户实例的 id，这里是扩展带来的另一个门户
    'lazy_loading_threshold' => '1000',
    'enable_formmanager_content_check' => true,  // 由于这是默认值，因此可以省略
  ),
);
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_overview>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/portal_overview.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
