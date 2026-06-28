---
title: "添加创建按钮"
linkTitle: "添加创建按钮"
date: 2025-06-27
weight: 10
description: >
  添加创建按钮。
---

{{% pageinfo %}}
本文档介绍如何使用 CreateBrick 在门户中添加一个快捷创建按钮。该按钮可以在门户的任何位置打开对象创建表单。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_addbutton)。
{{% /pageinfo %}}

## 概述

在本教程中，我们使用 CreateBrick 添加一个快捷请求按钮。

## 前提条件

- 知道如何制作 iTop 扩展并升级系统
- 拥有安装了演示数据和增强版门户的 iTop 系统
- 拥有足够权限访问门户的账户（通常需要 "Portal User" 角色）

## 教程目标

在本教程中，您将学习如何：

- 向默认门户添加一个 Brick
- 使用 CreateBrick 创建一个按钮，在门户的任何位置打开创建表单

## 分步说明

### 1. 创建扩展

首先，创建一个将修改门户 XML 配置以添加新 Brick 的 iTop 扩展。如有必要，请查看定制指南中的[扩展模块](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)部分。

- 将扩展命名为 `sample-portal-add-button`
- 删除 `main.sample-portal-add-button.php` 文件，因为我们不需要 PHP 代码

### 2. 修改门户配置

现在扩展已准备好，我们只需要制作一个 XML delta 并更改门户配置以添加 Brick。打开 `datamodel.sample-portal-add-button.xml` 文件并粘贴以下代码：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
  <module_designs>
    <module_design id="itop-portal" xsi:type="portal">
      <bricks>
        <brick id="quick-new-user-request" xsi:type="Combodo\iTop\Portal\Brick\CreateBrick" _delta="define">
          <active>true</active>
          <rank>
            <default>70</default>
          </rank>
          <width>4</width>
          <modal>true</modal>
          <title>
            <default>Brick:Portal:QuickNewUserRequest:Title</default>
          </title>
          <visible>
            <home>false</home>
          </visible>
          <decoration_class>
            <default>fa fa-bolt fa-2x fa-fw</default>
          </decoration_class>
          <!-- 将使用表单创建的类 -->
          <class>UserRequest</class>
          <rules>
            <rule id="contact-to-userrequest"/>
          </rules>
        </brick>
      </bricks>
    </module_design>
  </module_designs>
</itop_design>
```

这个 Brick 的配置说明：

- **排名**：由于排名大于其他 Brick，它将排在首页和导航菜单中其他 Brick 的后面
- **首页可见性**：不在首页显示（`home=false`）
- **模态对话框**：在模态对话框中打开表单，而不是跳转到完整页面
- **类**：创建 `UserRequest` 类的对象
- **规则**：应用 `contact-to-userrequest` 操作规则中的预设值

### 3. 添加字典条目

编辑 `en.dict.sample-portal-add-button.php` 文件，为按钮标签添加条目：

```php
<?php
Dict::Add('EN US', 'English', 'English', array(
        'Brick:Portal:QuickNewUserRequest:Title' => 'Quick new request',
));
```

可以为其他语言重复相同的操作。

### 4. 升级系统

最后，使用新扩展选项运行 iTop 系统升级并访问门户。您应该在导航菜单上看到新的 "Quick new request" 按钮。点击它，将打开创建表单。

与默认的用户请求创建流程的主要区别是：您无需通过服务目录选择服务子类别，可以直接从门户的任何位置创建对象。

## 下载

您可以在以下地址找到此扩展及示例主题：`sample-portal-add-button-1.0.0-145.zip`

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_addbutton>

版本：3_2_0/customization/portal_howto_addbutton.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
