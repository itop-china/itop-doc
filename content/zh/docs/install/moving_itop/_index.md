---
title: "将 iTop 移动到不同的 URL [iTop 文档]"
linkTitle: "将 iTop 移动到不同的 URL"
date: 2025-06-27
weight: 120
description: "如何将 iTop 移动到不同的 URL，包括更改目录、服务器名称或创建别名。"
---

{{% pageinfo %}}
本文档介绍如何将 iTop 移动到不同的 URL。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:moving_itop)。
{{% /pageinfo %}}

## 将 iTop 移动到不同的 URL

在某些情况下，更改 iTop 的 URL 可能会有帮助。更改目录、更改服务器名称或 IP、创建别名都是需要进行此操作的情况。

更改后，请在[配置文件](../../admin/06-configuration_editor/configuration-parameters/)中设置 `app_root_url` 字段，否则应用程序将停止工作！

- 此字段必须包含用于在应用程序中导航的根 URL。
- 此值也用于创建 iTop 生成的电子邮件中的 Web 链接。
- 您可以使用 `$SERVER_NAME$` 作为服务器名称的占位符。

请注意，更改此配置参数后，必须重新运行安装程序。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:moving_itop>

版本：3_2_0/install/moving_itop.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
