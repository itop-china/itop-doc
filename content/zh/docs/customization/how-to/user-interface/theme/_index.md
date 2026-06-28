---
title: "创建主题"
linkTitle: "创建主题"
date: 2025-06-27
weight: 10
description: >
  编写自定义 SCSS 主题，全面修改 iTop 界面外观。
---

{{% pageinfo %}}
本文档介绍如何创建自定义主题，从修改少量颜色到编写完整的 CSS 主题。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:theme)。
{{% /pageinfo %}}

## 概述

除了现有的默认主题外，还可以：

- 修改少量颜色以匹配企业品牌色
- 如果有 CSS 技能，可以创建自己的主题，彻底改变 iTop 控制台的外观

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 修改少量颜色

```xml
<branding>
  <themes>
    <theme id="fullmoon">
      <variables>
        <variable id="ibo-hyperlink-color" _delta="define">purple</variable>
      </variables>
    </theme>
  </themes>
</branding>
```

## 修改更多颜色

### 主要变量

| SCSS 变量 | 用途 |
|-----------|------|
| `ibo-color-primary-XXX` | 标准 iTop 中大多数橙色出现的位置 |
| `ibo-hyperlink-color` | 超链接文本颜色，如菜单条目、外部键 |
| `ibo-hyperlink-color--on-hover` | 悬停时面包屑或超链接条目的文本颜色 |
| `ibo-color-secondary-XXX` | 字段集标题背景、表头文本、编辑容器边框 |
| `ibo-navigation-menu--body--background-color` | 左侧菜单面板 |
| `ibo-top-bar--background-color` | 顶部栏 |
| `ibo-navigation-menu--action--background-color--on-hover` | 悬停菜单组时的背景色 |
| `ibo-tab-container--tab-header--background-color--on-hover` | 悬停标签页时的背景色 |

所有 iTop 3.0 变量定义在 `<iTop>/css/backoffice/` 下的多个文件中：

- `ibo-` 表示新内容（变量或类），`ibo` 代表 ItopBackOffice，因此不适用于终端用户门户
- `ibo-vendor-` 表示在第三方库提供的 SCSS 规则中使用的变量
- 例如 `ibo-input-text--padding-x` 可在 `<iTop>/css/backoffice/input/_input-text.scss` 中找到

### 变量值

为每个要修改的变量创建 XML 条目，指定新值：

- 可以设置任意数量的变量
- 如果定义的变量 ID 在任何 scss 文件中都不存在，将被忽略
- 变量值可以是：
  - 另一个变量：`$ibo-color-transparent`、`$ibo-body-text-color` 等（变量必须在上方定义）
  - 颜色：颜色名称 `purple`、十六进制 `#F6F6F6`、RGB `rgb(123, 123, 132)`、RGBA `rgba(123, 123, 123, 0.5)`、HSL `hsl(123, 50%, 50%)`、HSLA `hsla(123, 50%, 50%, 0.23)`
  - 文本
  - 数字，如 `box-radius:0`
  - SCSS 函数：`hue-rotate(-139deg)` 或 `lighten($brand-primary, 15%)`

### 导入 SCSS 变量文件

从 iTop 3.0 开始，可以通过添加 `xsi:type="variable"` 导入包含变量列表的 SCSS 文件：

```xml
<theme id="light-grey">
  <imports>
    <import id="my-css-variables" xsi:type="variable" _delta="define">my-module/css/my-css-variables.scss</import>
  </imports>
</theme>
```

```scss
$ibo-body-text-color: #000000;
$ibo-body-background-color: $ibo-color-white-200;
```

### 自定义样式表

可以在模块中定义自己的样式表和 scss 文件，并在主题中指定。假设 SCSS 文件位于扩展的 `<my-module>/css/` 下，则 XML 中的路径为：

```xml
<theme id="fullmoon">
  <imports>
    <import id="my-helpers" xsi:type="utility" _delta="define">my-module/css/my-helpers.scss</import>
  </imports>
  <stylesheets>
    <stylesheet id="my-style" _delta="define">my-module/css/my-style.scss</stylesheet>
  </stylesheets>
</theme>
```

## 创建新主题

### 经典主题

在 XML 中创建新主题（例如 `old-school`），修改 scss 变量并添加新的 css 规则。为此需要在 iTop 扩展中编写 scss 文件。

- 必须将规则与变量重定义分开放在不同的源文件中
- 对于变量，可以在 `import` 标签下的文件中重定义，或直接在 `variable` 标签下定义

```xml
<branding>
  <themes>
    <theme id="old-school" _delta="define">
      <variables>
      </variables>
      <imports>
        <import id="old-school-scss-variables" xsi:type="variables">combodo-theme-old-school/scss/scss-variables.scss</import>
      </imports>
      <stylesheets>
        <stylesheet id="backoffice">../css/backoffice/main.scss</stylesheet>
        <stylesheet id="old-school">combodo-theme-old-school/scss/rules.scss</stylesheet>
      </stylesheets>
    </theme>
  </themes>
</branding>
```

注意：

- 导入 scss 时使用 `xsi:type="variables"`，这些文件必须**只**包含"变量"
- 如果有 CSS 规则，在 `stylesheet` 标签下指定
- 必须指定标准 scss 样式表 `../css/backoffice/main.scss`，除非您重写了全部内容，并且建议放在第一个位置，以便您自己的 scss 覆盖默认样式

示例 CSS 规则：

```scss
.ibo-fieldset-legend {
  color: $ibo-color-grey-600;
  font-size: small;
  width:unset;
  border-bottom:0;
  margin-bottom:0;
  padding: 4px 4px 0 4px;
  margin-left: -4px;
}

.ibo-fieldset {
  border: 1px solid $ibo-color-grey-400 !important;
  padding: 10px 10px;
  border-radius: 6px;
  margin-top: 18px;
}
```

## 测试实例主题

以下是 iTop 内置的 `test-red` 主题的 XML：

### iTop 3.0 及以上版本

```xml
<theme id="test-red" _delta="define">
  <variables>
    <variable id="ibo-page-banner--background-color">$ibo-color-red-600</variable>
    <variable id="ibo-page-banner--text-color">$ibo-color-red-100</variable>
    <variable id="ibo-page-banner--text-content">"THIS IS A TEST INSTANCE"</variable>
  </variables>
  <imports>
  </imports>
  <stylesheets>
    <stylesheet id="fullmoon">../css/backoffice/main.scss</stylesheet>
    <stylesheet id="environment-banner">../css/backoffice/themes/page-banner.scss</stylesheet>
  </stylesheets>
</theme>
```

在顶部添加彩色横幅和文本消息。

## 从 2.7 迁移到 3.0 主题

### 主题名称

如果您有 2.7.x 版本的 iTop 并自定义了 `light-grey`：

```xml
<theme id="light-grey" _delta="force">
  ...
</theme>
```

对于 iTop 3.0 及更高版本，需要同时自定义 `fullmoon` 和 `darkmoon` 主题：

```xml
<theme id="fullmoon" _delta="force">
  ...
</theme>
<theme id="darkmoon" _delta="force">
  ...
</theme>
```

### SCSS 文件

2.7 主题中的代码：

```xml
<stylesheets>
  <stylesheet id="jqueryui">../css/ui-lightness/jqueryui.scss</stylesheet>
  <stylesheet id="main">../css/light-grey.scss</stylesheet>
  <stylesheet id="environment-banner">../css/backoffice-environment-banner.scss</stylesheet>
</stylesheets>
```

在 3.0 中替换为：

```xml
<stylesheets>
  <stylesheet id="fullmoon">../css/backoffice/main.scss</stylesheet>
  <stylesheet id="environment-banner">../css/backoffice/themes/page-banner.scss</stylesheet>
</stylesheets>
```

### 2.7 与 3.0 变量名称映射

#### 直接对应

| 2.7 变量 | 3.0 变量 |
|----------|----------|
| hyperlink-color | ibo-hyperlink-color |
| breadcrumb-text-highlight-color | ibo-hyperlink-color--on-hover |
| frame-background-color | ibo-navigation-menu--body--background-color |
| frame-background-color | ibo-top-bar--background-color |
| hover-background-color | ibo-navigation-menu--action--background-color--on-hover |
| hover-background-color | ibo-tab-container--tab-header--background-color--on-hover |

#### 3.0 的 XXX 变量

在 3.0 中，某些变量使用了变体。在 2.7 中可能只声明了一个颜色变量，而在 3.0 中需要设置多个具有颜色变化的变量：

| 2.7 变量 | 3.0 变量列表 |
|----------|-------------|
| brand-primary | ibo-color-primary-XXX |
| complement-color | ibo-color-secondary-XXX |
| complement-light | ibo-color-secondary-XXX |

XXX 范围从 100 到 900（100, 200, 300, ... 900）以及 950，共 10 个变量。

### 使用现有颜色

要使用现有 iTop 颜色代码，在 iTop 3.0+ 中使用浏览器开发工具查看现有值，然后使用以下语法之一转换：

- `$ibo-lifecycle-success-state-primary-color`
- `var(--ibo-lifecycle-success-state-primary-color)`

使用现有颜色的优势在于，主题创建或修改时会自动应用到您的设置/新类，保持 iTop 界面的一致性。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:theme)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:theme>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/theme.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
