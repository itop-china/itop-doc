---
title: "iTop 与 NGINX"
linkTitle: "iTop 与 NGINX"
date: 2025-06-27
weight: 55
description: "介绍如何在 NGINX 服务器上配置 iTop，包括 Apache .htaccess 规则转换及门户 URL 路由处理。"
---

{{% pageinfo %}}
本文档介绍如何在 NGINX 上配置和运行 iTop。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:nginx)。
{{% /pageinfo %}}

## 转换 Apache 配置

你需要手动将 iTop 源代码中的 `.htaccess` 文件转换为 NGINX 的配置规则。

请注意，每次升级后，都应检查是否引入了新的规则。最简单的方式是通过 GitHub 对比文件变更（[示例](https://github.com/Combodo/iTop/compare)）。

## 门户配置

如果你在 NGINX 上运行 iTop 并选择了增强门户（enhanced portal），很可能会在某些门户页面上遇到 404 错误。

默认情况下，当访问类似 `http://localhost/dir/script.php/arg1/arg2` 的 URL 时，NGINX 会认为 `script.php` 是一个目录，并尝试执行位于 `/dir/script.php/arg1/arg2` 的索引文件（该文件并不存在）。

在 iTop 中，这意味着当 NGINX 尝试执行：

```
http://localhost/pages/exec.php/browse/faq?exec_module=itop-portal.php&exec_page=index.php
```

NGINX 实际上会尝试执行 `/pages/exec.php/browse/faq`，而这不是一个真实的脚本。

你需要正确配置 NGINX 服务器，使其能够正确处理这些 URL。

增强门户基于 Symfony 框架，该框架提供了相关的[配置文档](https://symfony.com/doc/current/setup/web_server_configuration.html)。你可以根据你的实例进行适配。请记住，门户使用的是 `/pages/exec.php` 而非 `/index.php`。

## 推荐配置

```nginx
location / {
    try_files $uri $uri/ =404;
}

location ~ ^(.+\.php)(/.*)$ {
    fastcgi_pass    unix:/var/run/php7.2-fpm.sock;  # Debian 系统，具体路径因发行版而异
    fastcgi_split_path_info ^(.+\.php)(/.*)$;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:nginx>

版本：3_2_0/install/nginx.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
