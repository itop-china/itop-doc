---
title: "HTML 格式限制"
linkTitle: "技巧：HTML 格式限制"
date: 2025-06-26
weight: 52
description: >
  富文本字段支持的 HTML
---

{{% pageinfo %}}

自 iTop 2.3.0 起，某些字段（例如案例日志条目和工单的描述）支持富文本格式。

此格式使用 HTML 标记实现。这对于在浏览器中显示、在线所见即所得编辑以及从 HTML 邮件导入很方便。

然而，在基于 Web 的应用程序中插入任何类型的 HTML 标记是不可接受的，因为它为各种恶意注入打开了大门。因此，HTML 标记在记录到 iTop 数据库之前总是经过**清理过程**。此清理基于 HTML 标签名、属性和样式的**白名单**。

- 任何不在**标签白名单**中的标签都会被完全移除（包括子标签）
- 任何不在**属性白名单**中的属性（对于考虑的标签）都会被移除
- 任何不在**样式白名单**中的样式都会被移除
- 最后，唯一接受的 URL 方案（在 href 和 src 属性中）是：http:、https:、mailto: 和 data:。

{{% /pageinfo %}}

## 标签和属性白名单

以下标签在清理要存储在 iTop 中的 HTML 时被保留。对于每个标签，下表列出了允许的属性。

| HTML 标签 | 允许的属性 |
|---|---|
| a | href、name、style、target、title |
| b | 无 |
| big | 无 |
| blockquote | style |
| body | 无 |
| br | 无 |
| caption | 无 |
| center | 无 |
| cite | 无 |
| code | 无 |
| code | style |
| del | 无 |
| div | style |
| em | 无 |
| fieldset | style |
| font | face、color、style、size |
| h1 | style |
| h2 | style |
| h3 | style |
| h4 | style |
| hr | style |
| html | 无 |
| i | 无 |
| img | src、style、alt、title |
| ins | 无 |
| kbd | 无 |
| legend | style |
| li | style、value |
| nav | style |
| ol | reversed、start、style、type |
| p | style |
| pre | 无 |
| q | 无 |
| s | 无 |
| samp | 无 |
| section | style |
| small | 无 |
| span | style |
| strong | 无 |
| table | style、width、summary、align、border、cellpadding、cellspacing |
| tbody | style |
| td | style、colspan |
| th | style |
| thead | style |
| tr | style |
| tt | 无 |
| u | 无 |
| ul | style |
| var | 无 |

## 样式白名单

以下样式是允许在 style 属性内使用的唯一项（对于允许 style 的标签）：

`background-color`、`border`、`border-collapse`、`bordercolor`、`cellpadding`、`cellspacing`、`color`、`float`、`font`、`font-family`、`font-size`、`font-style`、`height`、`margin`、`padding`、`text-align`、`vertical-align`、`width`、`white-space`

## 禁用清理器

- `HTMLDOMSanitizer`：默认
- `HTMLPurifierSanitizer`：???
- `HTMLNullSanitizer`：完全不清理

```php
'html_sanitizer' => 'HTMLNullSanitizer',
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:rich_text_limitations>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/admin/rich_text_limitations.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
