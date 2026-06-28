---
title: "iTop 和反向代理"
linkTitle: "iTop 和反向代理"
date: 2025-06-27
weight: 50
description: "如何配置 iTop 以在反向代理后面正常工作。"
---

{{% pageinfo %}}
本文档介绍如何配置 iTop 以在反向代理后面正常工作。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:reverse_proxy)。
{{% /pageinfo %}}

## iTop 和反向代理

自版本 2.7.4 起，iTop 与反向代理兼容，前提是正确配置了反向代理。

## HTTP 头

在 iTop 执行的某些阶段（安装、通过 SSO 登录...），应用程序需要有关客户端浏览器请求的原始 URL 的信息。

当运行 iTop 的 PHP/Web 服务器通过反向代理访问时，有关实际 HTTP 请求的信息无法通过正常的 HTTP 头获得，因此反向代理**必须**提供这些附加信息。提供此信息的事实标准是通过使用 `X-Forwarded-*` HTTP 头。

iTop 考虑以下头：

| 头名称 | 含义 |
|------|------|
| `X-Forwarded-Host` | 客户端浏览器看到的主机。（例如 itop.mycompany.com） |
| `X-Forwarded-Port` | 客户端浏览器使用的端口。（例如 80、8080、443...） |
| `X-Forwarded-Proto` | 客户端浏览器使用的协议。http 或 https |
| `X-Forwarded-Protocol` | X-Forwarded-Proto 的替代头：客户端浏览器使用的协议。http 或 https |

### 安全考虑

这些头中的值只有在来自合法来源（即反向代理）时才应该被信任。

由于 `X-Forwarded-*` 头是纯文本 HTTP 头，任何 Web 浏览器客户端都可以轻松地在请求中注入这些头。

为了消除对可信来源复杂配置的需要（IPv4 或 IPv6 地址范围），iTop 使用以下策略：

- iTop 应用程序的**根 URL** 在应用程序**安装期间**计算（基于可用的服务器信息和 HTTP 头）。此值会提示给管理员，管理员负责验证它。在这种情况下，`X-Forwarded-*` HTTP 头始终被信任。
- 当计算重定向 URL 时，iTop 将此计算出的 URL 与存储的根 URL 进行比较。如果计算出的 URL 以根 URL 开头，则可以安全地执行重定向。否则，重定向将指向应用程序的起始页面。只有当您将 `behind_reverse_proxy` 配置参数设置为 `true` 时，`X-Forwarded-*` HTTP 头才会被信任。

这意味着您的 Web 服务器必须只能由您的代理访问（换句话说，不能直接由所有公共 IP 地址访问）。

## 超时、重试和自定义错误

当 iTop 执行某些耗时操作（安装、移至生产环境、数据库完整性检查）时，如果应用程序响应太慢，反向代理可能会放弃请求。根据代理配置，请求将被报告为错误或自动重新启动！这可能会在应用程序中产生意外错误。

为防止此类错误发生，请确保：

- 为 iTop 请求配置**较长的读取超时**（某些安装任务在大型到中型数据库上可能需要一个小时才能完成）。
- **禁用重试**（当请求超时时，反向代理可以重试请求，这会破坏 iTop 的某些页面）。
- **禁用代理的自定义错误**（某些代理可以拦截错误代码并替换响应，这会破坏 iTop 的某些页面）。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:reverse_proxy>

版本：3_2_0/install/reverse_proxy.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
