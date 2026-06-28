---
title: "门户定制"
linkTitle: "门户定制"
date: 2025-06-27
weight: 10
description: >
  门户定制。
---

{{% pageinfo %}}
本文档介绍 iTop 门户定制。自 iTop 2.3 起，增强版门户提供了丰富的定制选项，可通过 XML 配置和扩展实现个性化需求。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:start#customizing_the_portal)。
{{% /pageinfo %}}

## 概述

自 iTop 2.3 版本起，增强版门户提供了丰富的定制选项，允许您根据最终用户的需求进行个性化配置，几乎无需编码。

## 门户定制能力

通过门户定制，您可以实现：

- **访问权限控制**：通过 XML 定义哪些用户/角色可以访问门户
- **菜单定制**：自定义门户中的导航菜单
- **表单定制**：控制对象的显示方式、字段布局和可见性
- **外观定制**：修改主题、颜色和图标
- **扩展功能**：通过开发新的 Brick（功能模块）来扩展门户功能
- **多实例支持**：为不同的用户群体创建多个独立的门户实例

## 定制方式

### 通过扩展现有模块

查看 [iTop 扩展市场](https://store.itophub.io/)，选择适合您需求的扩展模块并按文档安装。

### 通过编写自定义扩展

要编写自己的门户扩展，需要掌握以下基础知识：

- [iTop 定制机制](../../) — 了解如何扩展或修改 iTop
- [逐步示例](../../) — 创建您的第一个扩展
- [扩展骨架生成工具](../../) — 创建新扩展的骨架和文件结构说明
- [XML 数据模型参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference) 和 [XML 门户参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)
- [iTop 编码规范](https://www.itophub.io/wiki/page?id=3_2_0:customization:coding_standards)
- [FontAwesome v5](https://fontawesome.com/) 图标库

## 门户定制教程

以下是门户定制的具体教程：

- [门户定制概述](portal-overview/) — 门户定制的整体介绍
- [门户 XML 参考](portal-xml/) — 门户 XML 配置的完整参考
- [门户限制](portal-limitations/) — 当前已知的门户限制
- [门户字段必填](mandatory-in-portal/) — 在门户中强制字段必填
- [查看更多或更少的工单](portal-howto-change-scope/) — 修改用户可见的工单范围
- [为他人创建工单](portal-howto-change-caller/) — 允许为其他用户创建工单
- [修改范围](portal-howto-changescope/) — 更改门户中的可见范围
- [修改 Bootstrap 主题](portal-howto-changebstheme/) — 更换门户主题
- [修改菜单图标](portal-howto-changebrickicon/) — 修改 Brick 的图标
- [添加创建按钮](portal-howto-addbutton/) — 添加快捷创建按钮
- [添加新的浏览模式](portal-howto-addbrowsemode/) — 自定义浏览模式
- [添加 Dashlet](portal-howto-add-manage-extended-brick/) — 在门户中添加 Dashlet
- [创建新门户](new-portal/) — 从零开始创建新门户
- [门户上的可选关系](portal-howto-dynamic-link/) — 动态可选的 n:n 关系

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:start#customizing_the_portal>

Last modified: 2026/06/10 17:31 by127.0.0.1

版本：3_2_0/customization/start.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
