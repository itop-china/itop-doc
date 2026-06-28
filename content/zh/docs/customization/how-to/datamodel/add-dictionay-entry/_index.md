---
title: "重新定义字典条目"
linkTitle: "重新定义字典条目"
date: 2025-06-27
weight: 10
description: >
  重新定义字典条目。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 中显示的标签以及创建新的字典条目。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dictionay-entry)。
{{% /pageinfo %}}

## 概述

通过修改字典条目，可以自定义 iTop 中显示的各类标签。了解[字典条目命名规范](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)有助于正确定义条目。

## 使用 ITSM Designer（Combodo 客户）

### 字典编辑器

在 ITSM Designer 的 **Editors** 主标签页下，使用 **Dictionary** 子标签页全局编辑字典条目。

### 搜索

使用表单搜索要编辑的字典条目。可以按条目的**代码**（如 `Class:Person`）或**内容**搜索。若同时提供代码和内容条件，则只显示同时匹配两者的条目。

### 修改条目

修改后，点击每个条目旁的验证标记，或使用顶部的 **Apply All** 按钮应用所有更改。

### 缺失翻译

可以搜索尚未翻译的条目。

### 新建条目

若字典条目不存在（例如来自 XML 门户的新条目），可使用 **New** 按钮创建。

### 删除条目

搜索条目，选择要删除的条目，然后点击删除按钮。

## 使用 iTop 扩展

### 修改 XML 条目

首先找到条目的**代码**。通用标签位于 `your-itop/dictionary/en.dictionary.itop.xxx.php` 文件中：

- `ui` — 用户界面标签
- `core` — 字段类型和通用对象标签

数据模型类相关的标签位于 `your-itop/datamodels/2.x/xxx/en.dict.xxx.php` 中。

找到代码后，在扩展中重新定义其值。使用 `_delta="redefine"` 替换现有值，使用 `_delta="force"` 在不确定是否存在时强制设置。

示例：将 UserRequest 的 "Requestor" 改为 "Beneficiary"：

```xml
<dictionary id="EN US" _delta="must_exist">
  <entries>
    <entry id="Class:UserRequest/Attribute:caller_id" _delta="redefine">
      <![CDATA[Beneficiary]]>
    </entry>
    <entry id="Class:UserRequest/Attribute:caller_id+" _delta="force">
      <![CDATA[Choose the client person who will get the requested service]]>
    </entry>
  </entries>
</dictionary>
```

### 新建 XML 条目

使用 `_delta="define"` 创建新条目，若条目已存在则会失败。

```xml
<dictionary id="EN US" _delta="must_exist">
  <entries>
    <entry id="Class:Team/Attribute:dashboard" _delta="define">
      <![CDATA[Overview]]>
    </entry>
  </entries>
</dictionary>
```

如需为多语言定义标签，可复制上述 XML 结构并修改语言代码。

### 使用字典文件

除在 XML 中定义外，也可在 PHP 文件中按语言定义字典条目。详见[iTop 翻译](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dictionay-entry>

版本：3_2_0/customization/add-dictionay-entry.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
