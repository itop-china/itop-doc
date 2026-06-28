
---
title: "REST/JSON 附件操作"
linkTitle: "REST/JSON 附件操作"
date: 2025-06-27
weight: 7
description: >
  通过 REST API 管理对象的附件。
---

{{% pageinfo %}}

通过 REST/JSON API 可以上传和下载 iTop 对象的附件。

{{% /pageinfo %}}

## 添加附件

使用 REST/JSON Web 服务，附件只能与**现有**对象关联（即已记录在数据库中的对象）。如果要创建带有附件的工单，请先创建工单，然后创建附件对象。

使用 `core/create` REST 操作创建新的 `Attachment` 时，必须填写以下字段：

- `item_class`：（字符串）此附件将关联到的对象类（例如 UserRequest）
- `item_id`：（整数）此附件将关联到的对象的 ID
- `item_org_id`：（整数）此附件将关联到的对象的组织 ID
- `creation_date`：（字符串）当前日期和时间，MySQL 格式（例如 « 2021-04-30 12:23:41 »）
- `contents`：包含 3 个元素的数组：
  - `data`：（字符串）文件的 base64 编码二进制内容
  - `filename`：（字符串）文件的名称（用于显示），例如 Untitled-1.docx
  - `mimetype`：（字符串）文件的 MIME 类型，例如 application/vnd.openxmlformats-officedocument.wordprocessingml.document（对于 MSWord .docx 文档）

使用 `core/create` 操作创建 `Attachment` 对象：

```json
{
  "operation": "core/create",
  "class": "Attachment",
  "fields": {
    "item_class": "Ticket",
    "item_id": 42,
    "item_org_id": 3,
    "creation_date": "2021-04-30 12:23:41",
    "contents": {
      "data": "base64编码的文件内容",
      "mimetype": "application/pdf",
      "filename": "document.pdf"
    }
  }
}
```

参数说明：

| 字段 | 说明 |
|---|---|
| `item_class` | 附件所属对象的类名 |
| `item_id` | 附件所属对象的 ID |
| `item_org_id` | 附件所属对象的组织 ID |
| `creation_date` | 创建日期，MySQL 格式 |
| `contents.data` | Base64 编码的文件内容 |
| `contents.mimetype` | 文件 MIME 类型 |
| `contents.filename` | 文件名 |

## 删除附件

附件可以像 iTop 中的任何其他对象一样删除，使用 `core/delete` REST/JSON 操作。附件关联到的**目标**对象不需要任何操作。

## 更新附件

即使可以使用 REST/JSON Web 服务更新 `Attachment` 对象，用户界面也不允许此操作，因此 iTop 可能假设附件是不可变的（例如在索引数据时）。因此，**建议**通过删除旧附件并创建新附件来模拟用户界面的行为。

## 限制

- 附件大小受 PHP `upload_max_filesize` 和 `post_max_size` 限制
- 上传用户必须对目标对象有写权限
- 支持的 MIME 类型通常没有严格限制，但建议仅上传常见文档类型

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:rest_json_attachment>

版本：3_2_0/advancedtopics/rest_json_attachment.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
