---
title: "安全最佳实践"
linkTitle: "技巧：安全最佳实践"
date: 2025-06-27
weight: 47
description: >
  iTop 安装和运维中的安全建议。
---

{{% pageinfo %}}

iTop 基于 PHP，其内容由 Web 服务器提供。

本页参考 PHP 和 Web 服务器配置，以增强 iTop 安装的安全性。

您将在这里找到一些 HTTP 标头配置，以在您的 Web 服务器中配置，从而增加额外的安全层。由于本页力求保持简单，这里提到的标头通常可以进一步微调以更加严格。

{{% /pageinfo %}}

## 目录写入权限

Web 服务器用户应被允许对 iTop 根目录下的以下目录具有写入权限：

- conf
- data
- env-*
- 根目录（iTop Hub 连接器将在编译之前删除 env-production-build 目录）
- log

## 保护关键目录访问

以下文件目录必须对 Web 用户拒绝访问：

- conf：目录及其所有内容
- data：目录及其所有内容
- datamodels：仅允许具有以下扩展名的文件：css|scss|js|map|png|bmp|gif|jpe?g|svg|tiff|woff2?|ttf|eot|html
- env-*：仅允许具有以下扩展名的文件：css|scss|js|map|png|bmp|gif|jpe?g|svg|tiff|woff2?|ttf|eot|html
- extensions：仅允许具有以下扩展名的文件：css|scss|js|map|png|bmp|gif|jpe?g|svg|tiff|woff2?|ttf|eot|html
- lib：目录及其所有内容
- log：目录及其所有内容
- setup/permissions-test-folder/permissions-test-subfolder/：仅当您的 Web 服务器不使用 .htaccess 或 web.config 时才需要。如果访问未被拒绝，您将在 iTop 设置期间收到安全警告（自 3.0.2 和 2.7.8 起）

您还应阻止目录列表。

## 禁用配置编辑器

由于 iTop 配置存储为 PHP 文档，因此可以通过配置编辑器进行 PHP 代码注入。如果您认为让 iTop 管理员交互式编辑配置文件风险太大（例如，如果 iTop 安装在与其他应用共享的服务器上），您可以完全禁用交互式配置编辑器。要禁用交互式编辑器，请在配置文件的 'module_settings' 部分设置以下配置参数：

```php
'itop-config' => [ 
    'config_editor' => 'disabled', 
]
```

## 使用 HTTPS

您应仅使用 https 协议提供页面。

### Strict-Transport-Security HTTP 标头

强制 https 连接的一个好方法是发送 Strict-Transport-Security HTTP 标头。我们建议使用以下值：

```
Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains;" env=HTTPS
```

有关此标头的更多信息，请查看相应的参考：Strict-Transport-Security - HTTP | MDN

## 防止会话窃取

虽然 PHP 默认配置从安全角度来看相当相关，但可以增强：您应该更改以下条目的默认值：

### session.cookie_httponly

为了防止恶意 JavaScript 代码嗅探用户的会话，您应该启用 session.cookie_httponly（请参阅 PHP 文档）。

您可以在 php.ini 中使用 `session.cookie_httponly = 1` 或在 Apache 中使用 `php_flag session.cookie_httponly on` 来实现。

### session.cookie_secure

如果您使用 https，则应启用此指令，以便仅通过安全连接发送 cookie，请参阅 PHP 文档。

### session.cookie_samesite

您应使用 LAX 值启用此指令，以便会话 cookie 更难拦截，请参阅 PHP 文档。

### zend.exception_ignore_args

此 PHP 参数在某些 PHP 发行版中默认设置为 false，应设置为 true，以避免在发生异常时，参数值以明文形式写入 error_log。这些参数可能包含例如 iTop 数据库的登录名和密码。

## iTop 发送的 HTTP 标头

### X-Frame-Options

这指示浏览器是否应被允许在 <frame>、<iframe>、<embed> 或 <object> 中渲染页面。

请参阅参考：X-Frame-Options - HTTP | MDN

如果您使用的是较旧的 iTop 版本，可以在 Apache 配置中添加：

```
Header always set X-Frame-Options "sameorigin"
```

### X-Content-Type-Options

这允许选择退出 MIME 类型嗅探（Content-Type 标头中公布的 MIME 类型不应更改）。

请参阅此参考：X-Content-Type-Options - HTTP | MDN

如果您使用的是较旧的 iTop 版本，可以在 Apache 配置中添加：

```
Header always set X-Content-Type-Options "nosniff"
```

## 其他 HTTP 标头

### Referrer-Policy

HTTP_REFERER 标头由浏览器在每个 http 查询中发送，以给出上一页的 URL。可以通过从服务器发送 Referrer-Policy http 标头来更改此行为。

参考文档：Referrer-Policy - HTTP | MDN

我们建议使用 strict-origin-when-cross-origin 值，以便：

- 在 iTop 内部发送整个字符串
- 仅在 https 上的跨源请求中发送 origin（方案、主机、端口）
- 在非安全目标（http）上不发送 referer

Apache 的示例配置：

```
Header always set Referrer-Policy "strict-origin-when-cross-origin"
```

### Content-Security-Policy

此标头将指定浏览器可以在每个页面上加载哪些资源。其主要目标是防止跨站脚本（XSS）和数据注入攻击。

请参阅参考：Content Security Policy (CSP) - HTTP | MDN

iTop 社区包的简单配置可以是：

```
Header set Content-Security-Policy "default-src 'self'; frame-src 'self' www.itophub.io; img-src 'self' data: blob:; script-src 'self' 'unsafe-inline' 'unsafe-eval'; connect-src 'self' www.itophub.io; style-src 'self' 'unsafe-inline';
```

## Apache 配置示例

```
php_flag session.cookie_httponly on
 
# 仅用于 https:
Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains;" 
php_flag session.cookie_secure on
```

## iTop 扩展

摘自新扩展指南：

### 安全

如果您希望文件在没有任何认证的情况下被调用（在大多数情况下不推荐），您需要将文件添加到 model.<module>.php 文件的 delegated_authentication_endpoints 中。

```php
...
    'delegated_authentication_endpoints' => [
        'index.php',
        'open_access.php'
    ],
...
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:security>

版本：3_2_0/install/security.txt · Last modified: 2026/04/13 17:00 by 127.0.0.1
