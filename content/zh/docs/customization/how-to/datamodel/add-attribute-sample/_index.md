---
title: "为 Server 类添加字段"
linkTitle: "为 Server 类添加字段"
date: 2025-06-27
weight: 10
description: >
  为 Server 类添加字段。
---

{{% pageinfo %}}
本文档介绍如何为现有 iTop 类添加新字段。这是学习创建 iTop 扩展的第一个入门教程。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-attribute-sample)。
{{% /pageinfo %}}

## 概述

本教程将逐步介绍如何为现有 iTop 对象添加新字段。以在 **Server** 对象上添加一个文本字段为例。

## 使用 ITSM Designer（Combodo 客户）

Combodo 的 iTop Professional 或 Essential 客户无需创建扩展，可直接使用 ITSM Designer：

1. 从 iTop 导航到 ITSM Designer
2. 打开 **Classes** 标签页，选择 **Server** 类
3. 点击顶部工具栏的创建新字段图标
4. 选择属性类型，填写字段属性（包括标签）
5. 切换到 **Presentation** 标签页的 **Details view**，拖拽新字段到所需位置
6. 点击 **Move To Production** 按钮推送更改

## 使用 iTop 扩展

### 准备工作

- 在开发机器上安装 iTop
- 支持 UTF-8 的文本编辑器（Windows 可用 Wordpad、PSPad 或 Notepad++）

### 定制流程

1. 安装 iTop 开发实例
2. 安装 [工具包](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 辅助定制
3. 使用[扩展创建向导](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)创建空模块
4. 将模块复制到 `extensions` 文件夹并运行安装
5. 修改模块并使用工具包验证

### 创建模块

使用扩展创建向导，填写以下信息：

| 标签 | 值 | 说明 |
|------|-----|------|
| 模块名称 | sample-add-attribute | 以 `itop-` 和 `combodo-` 开头的名称保留给 Combodo 使用 |
| 模块标签 | Add Attribute Sample | 安装向导中显示的标签 |
| 模块版本 | 1.0.0 | 使用 X.Y.Z 三位版本号 |
| 类别 | business | 修改数据模型的模块应使用 'business' 类别 |
| 依赖 | itop-config-mgmt/2.0.0 | 依赖 iTop 配置管理模块 |

### 安装空模块

将 zip 文件解压到 `extensions` 文件夹，运行 `http://your_itop/setup/` 重新安装，选择 **Update an existing instance**。

### 添加字段

编辑 `datamodel.sample-add-attribute.xml`，在 `<classes>` 标签内添加：

```xml
<class id="Server" _delta="if_exists">
  <fields>
    <field id="notes" xsi:type="AttributeText" _delta="define">
      <sql>notes</sql>
      <default_value/>
      <is_null_allowed>true</is_null_allowed>
    </field>
  </fields>
</class>
```

使用工具包验证后，点击 **Update iTop Code** 应用更改。此时数据库已添加新列，但界面尚未显示。

### 使字段可见

将新字段添加到 Server 的详情展示中。编辑 XML 文件，在 `<presentation>` 中重新定义 `details`：

```xml
<presentation>
  <details _delta="redefine">
    <items>
      <!-- ... 现有字段 ... -->
      <item id="col:col2">
        <items>
          <item id="fieldset:Server:otherinfo">
            <items>
              <item id="description">
                <rank>30</rank>
              </item>
              <item id="notes">
                <rank>40</rank>
              </item>
            </items>
          </item>
        </items>
      </item>
    </items>
  </details>
</presentation>
```

### 添加字段标签

编辑 `en.dict.sample-add-attribute.php`，添加字典条目：

```php
Dict::Add('EN US', 'English', 'English', array(
    'Class:Server/Attribute:notes' => 'Additional Notes',
));
```

### 高级方案

为避免与其他扩展冲突，可以不重新定义整个 `details`，而是精确定位插入点：

```xml
<presentation>
  <details>
    <items>
      <item id="col:col2" _delta="must_exist">
        <items>
          <item id="fieldset:Server:otherinfo" _delta="must_exist">
            <items>
              <item id="notes" _delta="define">
                <rank>40</rank>
              </item>
            </items>
          </item>
        </items>
      </item>
    </items>
  </details>
</presentation>
```

## 部署

将模块文件夹复制到目标 iTop 的 `extensions` 目录并运行安装。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-attribute-sample>

版本：3_2_0/customization/add-attribute-sample.txt · Last modified: 2026/03/16 14:06 by 127.0.0.1
