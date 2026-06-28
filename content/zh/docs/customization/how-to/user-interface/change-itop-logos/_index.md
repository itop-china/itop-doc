---
title: "修改 iTop Logo"
linkTitle: "修改 iTop Logo"
date: 2025-06-27
weight: 10
description: >
  替换 iTop 控制台和登录页面的 Logo。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 的 Logo，包括控制台菜单 Logo、登录页面 Logo 和门户 Logo。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-itop-logos)。
{{% /pageinfo %}}

## 概述

iTop 默认在控制台菜单中显示 iTop Logo，可以通过 ITSM Designer 或扩展模块进行自定义。

## 使用 ITSM Designer

**前置条件**：必须是 Combodo 客户。

### 上传 Logo

1. 打开 ITSM Designer 的 "Branding" 标签页
2. 在 Logo 下拉列表中选择，或点击上传按钮上传自定义 Logo

支持的图片格式：

- **PNG**（推荐用于 iTop 2.7 及更早版本，支持透明背景）
- **JPG / JPEG**
- **GIF**
- **SVG**（仅推荐用于 iTop 3.0 及以上版本）

图片会自动调整大小以适应 iTop UI。

### Logo 尺寸要求

| Logo 类型 | iTop 3.0.0 之前 | iTop 3.0.0 及之后 |
|-----------|----------------|-------------------|
| 主 Logo | 220×64 | 310×70 |
| 主 Logo（折叠） | 不适用 | 74×74（显示为 37×37） |
| 登录页面 | 300×54 | 300×54 |
| 门户 | 192×50 | 192×50 |

## 使用 iTop 扩展

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

### 添加文件

添加 Logo 图片文件有两种方式：

1. **直接放在模块中**：需要指定相对路径（模块代码 + 文件名）
2. **将图片数据嵌入 XML**：使用 `fileref` 引用（参见 XML 参考文档）

### 定义 Logo

在扩展的 XML 中通过 `branding` 节点重新定义 Logo：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
  <branding>
    <!-- 折叠菜单时的 Logo（展开菜单请使用 main_logo） -->
    <main_logo_compact _delta="define">sample-itop-logos/custom-logo-compact.png</main_logo_compact>
    <!-- 登录页面 Logo -->
    <login_logo _delta="define">
      <fileref ref="custom-logo"/>
    </login_logo>
  </branding>
</itop_design>
```

## 完整示例

完整的工作示例可在以下仓库中找到：[Combodo/sample-itop-logos](https://github.com/Combodo/sample-itop-logos)

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-itop-logos)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:change-itop-logos>

版本：3_2_0/customization/change-itop-logos.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
