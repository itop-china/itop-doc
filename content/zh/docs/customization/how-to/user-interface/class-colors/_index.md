---
title: "类颜色与图标"
linkTitle: "类颜色与图标"
date: 2025-06-27
weight: 10
description: >
  为 iTop 类设置颜色、图标和对象图标。
---

{{% pageinfo %}}
本文档介绍如何为 iTop 类设置主色调、图标以及每个对象实例的图标。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:class-colors)。
{{% /pageinfo %}}

## 概述

iTop 3.0 引入了为类设置颜色和图标的新功能：

- **类颜色**：为每个类设置特定颜色，在列表中显示为彩色线条，便于区分不同类
- **枚举值颜色**：枚举字段的值在对象名称下方显示，并关联颜色（如工单状态）
- **对象图标**：每个对象实例可以使用不同的图标（如 Person 的头像）

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 使用 ITSM Designer

在 ITSM Designer 中打开类定义，选择颜色和要使用的属性即可。

## 使用扩展

### 类图标

在 `datamodel.xxxx.xml` 文件的类属性中添加 `style` 标签：

```xml
<class id="FAQCategory" _delta="if_exists">
  <properties>
    <style>
      <!-- 指定类的可选图标（相对于 iTop 模块的路径）-->
      <icon _delta="define">../my-extension-code/images/icon8-faq.svg</icon>
    </style>
  </properties>
</class>
```

图标约束：

- 推荐使用 SVG 格式，体积小且缩放效果好
- 图标必须是正方形
- 240px 是类图标的理想尺寸
- 最好使用透明背景
- 不应有边框
- 提供指向 iTop 中 SVG 或 PNG 文件的相对路径
- 也可以引用 XML 中以 base64 编码的 fileref

### 使用 fileref 的图标

1. 使用在线工具将图标编码为 base64
2. 在 `datamodel.xxxx.xml` 中创建以下 XML 结构：

```xml
<classes>
  <class id="xxxx">
    <properties>
      <style>
        <!-- 指定以文件形式嵌入 XML 的图标 -->
        <icon _delta="define">
          <fileref ref="my-image-unique-id"/>
        </icon>
      </style>
    </properties>
  </class>
</classes>
<files>
  <file id="my-image-unique-id" xsi:type="File" _delta="define">
    <name>cron.svg</name>
    <mime_type>image/svg</mime_type>
    <width>240</width>
    <height>240</height>
    <!-- 粘贴 base64 转换结果（非常长） -->
    <data>VBORw0KGgoAAAANSUhE.[...].UgAAALQAAAC5CA</data>
  </file>
</files>
```

### 类颜色

在 `datamodel.xxxx.xml` 文件的类属性 `style` 标签中：

- `main_color`：类的主色调
- `complementary_color`：辅助色

颜色格式：

- CSS 颜色代码：`#689F38FF`
- iTop SCSS 变量：`$ibo-color-blue-400`、`$ibo-transparent`、`$ibo-body-text-color` 等

```xml
<properties>
  <style _delta="define">
    <!-- 指定类的可选图标（相对于 iTop 根目录的路径）-->
    <icon>images/user-request.png</icon>
    <!-- 类的主色调，可使用任何有效的 CSS 颜色（十六进制、HSLA、变量）或 SCSS 变量 -->
    <main_color>$ibo-color-primary-500</main_color>
    <complementary_color></complementary_color>
  </style>
</properties>
```

### 对象图标

可以为每个类实例设置不同的图标。类必须具有 Image 类型的字段来存储实例相关的信息。

在 `datamodel.xxxx.xml` 中修改类的 XML：

```xml
<properties>
  <fields_semantic _delta="define">
    <!-- 指定类中 AttributeImage 类型的属性代码 -->
    <image_attribute>picture</image_attribute>
  </fields_semantic>
</properties>
```

### 完整示例

以下是在 Location 类上同时实现三种定制的完整示例：

```xml
<class id="Location" _delta="must_exist">
  <properties>
    <fields_semantic>
      <state_attribute _delta="redefine">type</state_attribute>
      <image_attribute _delta="define">image</image_attribute>
    </fields_semantic>
    <style>
      <main_color _delta="define">#00ff00</main_color>
    </style>
  </properties>
  <fields>
    <field id="type" xsi:type="AttributeEnum" _delta="define">
      <sql>type</sql>
      <values>
        <value id="campus">
          <code>campus</code>
        </value>
        <value id="building">
          <code>building</code>
        </value>
        <value id="floor">
          <code>floor</code>
        </value>
        <value id="room">
          <code>room</code>
        </value>
      </values>
      <default_value>building</default_value>
      <is_null_allowed>false</is_null_allowed>
      <display_style/>
      <dependencies/>
      <tracking_level>all</tracking_level>
    </field>
    <field id="image" xsi:type="AttributeImage" _delta="define">
      <default_image/>
      <is_null_allowed>true</is_null_allowed>
      <storage_max_width>600</storage_max_width>
      <storage_max_height>400</storage_max_height>
      <display_max_width/>
      <display_max_height/>
      <tracking_level>all</tracking_level>
    </field>
  </fields>
  <presentation>
    <details>
      <items>
        <item id="type" _delta="define">
          <rank>100</rank>
        </item>
        <item id="image" _delta="define">
          <rank>110</rank>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:class-colors)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:class-colors>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/class-colors.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
