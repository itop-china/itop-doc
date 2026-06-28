---
title: "REST/JSON API 测试台"
linkTitle: "REST/JSON API 测试台"
date: 2025-06-27
weight: 9
description: "介绍 iTop REST/JSON API 测试台，用于在线测试 list_operations 和 core/get 等 API 操作。"
---

{{% pageinfo %}}
本文档介绍 iTop REST/JSON API 测试台。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:rest_json_playground)。
{{% /pageinfo %}}

## 概述

iTop 提供了一个在线 REST/JSON API 测试台，你可以通过表单连接到自己的 iTop 服务器，测试 API 的 `list_operations` 和 `core/get` 等操作。

你可以在 [jsfiddle](https://jsfiddle.net/) 中查看对应的代码并进行调整。

## 使用方式

在测试台页面中填写以下信息：

- **iTop 服务器 URL**：你的 iTop 服务器地址（末尾不带斜杠 `/`）
- **iTop 登录名**：你的 iTop 账号
- **密码**：你的 iTop 密码
- **API 版本**：选择要使用的 API 版本
- **操作**：选择要测试的操作（如 `List Operations`）
- **格式**：选择 `JSON` 或 `JSON-P`

填写完成后，点击执行即可查看返回结果。

## 示例结果

```json

```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:rest_json_playground>

版本：3_2_0/advancedtopics/rest_json_playground.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
