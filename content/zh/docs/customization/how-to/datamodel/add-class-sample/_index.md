---
title: "创建新的 CI 类：Monitor"
linkTitle: "创建新的 CI 类：Monitor"
date: 2025-06-27
weight: 10
description: >
  创建新的 CI 类：Monitor。
---

{{% pageinfo %}}
本文档介绍如何创建新的 iTop 模块以添加自定义 CI 类。以创建 Monitor（显示器）类为例。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-class-sample)。
{{% /pageinfo %}}

## 概述

本教程将创建一个新的 CI 类 **Monitor**，继承自 PhysicalDevice，并添加一个 `technology` 字段来区分 CRT 和 LCD 显示器。

## 使用 ITSM Designer（Combodo 客户）

Combodo 客户可直接在 ITSM Designer 中创建新类。

## 使用 iTop 扩展

### 创建模块

使用扩展创建向导：

| 标签 | 值 | 说明 |
|------|-----|------|
| 模块名称 | sample-add-class | 以 `itop-` 和 `combodo-` 开头的名称保留 |
| 模块标签 | Add Class Sample | 安装向导中显示的标签 |
| 模块版本 | 1.0.0 | 使用 X.Y.Z 三位版本号 |
| 类别 | business | 修改数据模型的模块使用 'business' 类别 |
| 依赖 | itop-config-mgmt/2.0.0, itop-endusers-devices/2.0.0 | 依赖配置管理和终端用户设备模块 |

### 添加 Monitor 类

编辑 `datamodel.sample-add-class.xml`，在 `<classes>` 内添加：

```xml
<class id="Monitor" _delta="define">
  <parent>PhysicalDevice</parent>
  <properties>
    <category>bizmodel,searchable</category>
    <abstract>false</abstract>
    <key_type>autoincrement</key_type>
    <db_table>monitor</db_table>
    <db_key_field>id</db_key_field>
    <db_final_class_field/>
    <naming>
      <attributes>
        <attribute id="name"/>
      </attributes>
    </naming>
    <style>
      <icon>images/monitor.png</icon>
    </style>
    <reconciliation>
      <attributes>
        <attribute id="name"/>
        <attribute id="org_id"/>
        <attribute id="organization_name"/>
      </attributes>
    </reconciliation>
  </properties>
  <fields>
    <field id="technology" xsi:type="AttributeEnum">
      <values>
        <value>crt</value>
        <value>lcd</value>
      </values>
      <sql>technology</sql>
      <default_value/>
      <is_null_allowed>true</is_null_allowed>
      <display_style>radio_horizontal</display_style>
    </field>
  </fields>
  <presentation>
    <details>
      <items>
        <item id="name"><rank>10</rank></item>
        <item id="org_id"><rank>20</rank></item>
        <item id="status"><rank>30</rank></item>
        <item id="business_criticity"><rank>40</rank></item>
        <item id="location_id"><rank>50</rank></item>
        <item id="brand_id"><rank>60</rank></item>
        <item id="model_id"><rank>70</rank></item>
        <item id="technology"><rank>75</rank></item>
        <item id="serialnumber"><rank>80</rank></item>
        <item id="asset_number"><rank>90</rank></item>
        <!-- ... 其他字段 ... -->
      </items>
    </details>
    <search><!-- ... --></search>
    <list><!-- ... --></list>
  </presentation>
</class>
```

### 添加类图标

在 `extensions/sample-add-class/images/` 目录下放置 `monitor.png` 图标文件。

### 修复标签

编辑 `en.dict.sample-add-class.php`，添加字典条目：

```php
Dict::Add('EN US', 'English', 'English', array(
    'Class:Monitor' => 'Monitor',
    'Class:Monitor+' => 'A computer display',
    'Class:Monitor/Attribute:technology' => 'Technology',
    'Class:Monitor/Attribute:technology+' => 'Technology used for the display',
    'Class:Monitor/Attribute:technology/Value:crt' => 'CRT',
    'Class:Monitor/Attribute:technology/Value:lcd' => 'LCD',
));
```

### 添加到 Model.type

将 Monitor 添加到 Model 类的 type 枚举值中：

```xml
<class id="Model" _delta="must_exist">
  <fields>
    <field id="type" xsi:type="AttributeEnum">
      <values>
        <value id="Monitor" _delta="define">Monitor</value>
      </values>
    </field>
  </fields>
</class>
```

### 添加仪表盘项

将 Monitor 添加到配置管理概览仪表盘的 "终端用户设备" 区域：

```xml
<menus>
  <menu id="ConfigManagementOverview" xsi:type="DashboardMenuNode" _delta="must_exist">
    <definition>
      <cells>
        <cell id="2" _delta="must_exist">
          <dashlets>
            <dashlet id="99" xsi:type="DashletBadge" _delta="define">
              <rank>8</rank>
              <class>Monitor</class>
            </dashlet>
          </dashlets>
        </cell>
      </cells>
    </definition>
  </menu>
</menus>
```

## 部署

将模块文件夹复制到目标 iTop 的 `extensions` 目录并运行安装。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-class-sample>

版本：3_2_0/customization/add-class-sample.txt · Last modified: 2026/03/16 14:02 by 127.0.0.1
