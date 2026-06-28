---
title: "门户字段必填"
linkTitle: "门户字段必填"
date: 2025-06-27
weight: 10
description: >
  门户字段必填。
---

{{% pageinfo %}}
本文档介绍如何在用户门户中强制字段必填。通过修改门户 XML 配置中的 `data-field-flags` 属性，可以覆盖数据模型中的字段必填设置。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-in-portal)。
{{% /pageinfo %}}

## 概述

本教程介绍如何在用户门户中强制某些字段必填。这是一个[强制字段必填](../../user-interface/mandatory-field/)的特定应用场景。

## 前提条件

- 熟悉[教程中使用的语法](../../../)
- 已[创建扩展](../../../)

## 使用场景

本示例将介绍如何在用户门户中创建用户请求（UserRequest）时，强制要求填写 `service_id` 和 `servicesubcategory_id` 字段。在控制台中，这两个字段在数据模型中不是必填的，且在生命周期中在"已解决"状态之前也不是必填的。

用户门户通过 XML 描述，您可以在 `<form>` 标签下方修改表单的行为和外观。有关所有可能的配置选项，请参考[门户 XML 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)。

## 实现方法

在门户 XML 中，使用 `data-field-flags="mandatory"` 属性可以强制字段必填：

```xml
<module_design id="itop-portal">
  <forms>
    <form id="ticket-create">
      <class>Ticket</class>
      <fields/>
      <!-- 如果不重新定义整个 twig，则无法修改其中的一部分 -->
      <twig _delta="redefine">
        <div class="row">
          <div class="col-sm-6">
            <!-- data-field-flags 可以强制字段为 mandatory、read_only、hidden -->
            <!-- 或者设置为 must_change（必须修改） -->
            <!-- "mandatory,must_change" 强制字段必须修改为非空值 -->
            <div class="form_field" data-field-id="service_id" data-field-flags="mandatory"></div>
          </div>
          <div class="col-sm-6">
            <div class="form_field" data-field-id="servicesubcategory_id" data-field-flags="mandatory">
            </div>
          </div>
        </div>
        <!-- [其余 XML 标签...] -->
      </twig>
    </form>
  </forms>
</module_design>
```

## 移除必填标志

要移除必填标志，只需重新定义 twig，并在其中移除 `data-field-flags="mandatory"` 属性。

## 特殊情况

如果某个字段同时满足以下条件：

- 在数据模型中必填，或由于生命周期标志而必填
- 且当前为空
- 且在门户表单中被指定为 hidden、read_only 或被省略

则门户引擎将忽略这些表单标志，并将该字段作为必填项添加到表单末尾。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-in-portal>

版本：3_2_0/customization/mandatory-in-portal.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
