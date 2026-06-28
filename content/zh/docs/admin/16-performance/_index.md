---
title: "调优 iTop 性能"
linkTitle: "技巧：调优 iTop 性能"
date: 2025-06-27
weight: 45
description: >
  iTop 性能优化建议，涵盖 PHP、MySQL 和 iTop 配置。
---

{{% pageinfo %}}

为了提高 iTop 服务器的性能，您必须首先找到瓶颈。是 PHP 页面执行太慢，还是 MySQL？

实际的应用性能调优需要深入了解 iTop 实例的实际使用模式，但有一些通用的检查点：

{{% /pageinfo %}}

## 安装 APCu

如果系统上可用，请安装并启用 APCu（Alternative PHP Cache）。APCu 通过将 PHP 解析的结果作为操作码缓存在共享内存中来加速 PHP 应用。此外，iTop 使用 APCu 将许多内部结构缓存在内存中，而不是在每次页面加载时重建它们。

安装 APCu 将提高应用的整体响应性，这对于"小"页面尤其重要。如果不可用，iTop 实现了一个基于文件的简单缓存机制。

```ini
[apcu]
apc.shm_size=128M
apc.ttl=7200
```

## 安装 FPM

为了提高性能，您可以使用 php-fpm 和 fastcgi。

关于 Apache + FPM 的超时观察：

- 超时来自 Apache，通过 ProxyTimeout 指令。如果未定义，Apache 将使用 TimeOut 指令（默认为 60s）。
- AJAX 请求确实返回 504 错误（超时）。
- 后续 AJAX 请求将不会发送，我们必须猜测 setup 何时结束以及何时可以重新运行它。
- Setup 过程是健壮的，当启动 DB 升级时，即使 Apache 超时，它也会完成。这意味着如果我们重新运行 setup，它不会启动新的查询，而是等待当前查询的结束。
- 如果 MySQL 在 setup 期间重新启动，MySQL 会回滚并恢复到上一个表。没有减速，没有数据丢失。

警告：

- 超时发生后，我们不知道 setup 何时结束。当前的解决方案是检查当前的 MySQL 进程，等待结束并再次运行 setup。
- 注意磁盘可用空间。ALTER TABLE 需要相当于表大小的磁盘可用空间。例如，如果 "attachment" 表占用 7GB，则 ALTER TABLE 需要额外的 7GB。（如果选中了复选框，请考虑 iTop 备份的大小）。
- 维护和只读模式：在"小"服务器上，SQL 查询会占用如此多的资源，以至于在只读模式下使用 iTop 很可能不可用。

## 配置 Apache 模块：Headers & Expires

激活 apache 的模块：

```bash
a2enmod expires
a2enmod headers
```

配置它们：

```apache
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType image/gif  A172800
  ExpiresByType image/jpeg A172800
  ExpiresByType image/png  A172800
  ExpiresByType text/css   A172800
  ExpiresByType text/javascript A172800
  ExpiresByType application/x-javascript A172800
</IfModule>
 
<IfModule mod_headers.c>
  <FilesMatch "\.(gif|jpe?g|png|css|swf|js)$">
    Header set Cache-Control "max-age=2592000, public"
  </FilesMatch>
</IfModule>
```

## 检查 MySQL 的键缓存

确保 MySQL 有足够的内存来**缓存所有索引**在内存中。重要的状态变量是：`key_read_requests` 和 `key_reads`。

实际的 `key_reads / key_read_requests` 比率应尽可能低（通常小于 0.1%）。如果此比率太高，这意味着您应该增加分配给缓存 MySQL 索引的内存量（在 `my.cnf` 中调整变量 `key_buffer_size` 并重新启动 MySQL 服务器）。

## 检查查询缓存

检查 MySQL 查询缓存是否已启用，并有足够的内存来缓存最常见查询的结果。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:performance>

版本：3_2_0/admin/performance.txt · Last modified: 2025/05/16 09:57 by 127.0.0.1
