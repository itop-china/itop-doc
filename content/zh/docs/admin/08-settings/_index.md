---
title: "设置 iTop 为只读"
linkTitle: "技巧：设置 iTop 为只读"
date: 2025-06-26
weight: 42
description: >
  <br> ➡️ 将 iTop 设置为只读模式
---

{{% pageinfo %}}

所有 iTop 配置设置都存储在 iTop 安装目录下 `conf/production` 目录中的 `config-itop.php` 文件中。更改参数会立即生效，无需重启 Web 服务器，只需在浏览器中刷新 iTop 页面即可应用新参数。

{{% /pageinfo %}}

## 设置 iTop 为只读模式

有时（例如在执行某些维护任务时）希望将 iTop 应用设为只读。自 1.0.2 版本起，可以使用两个参数来控制：

- 应用是否为只读（以及针对谁）
- 应用只读时显示的消息

这两个参数是 `access_mode` 和 `access_message`。

`access_mode` 参数可以取以下值之一：

| access_mode 值 | 实际值 | 效果 |
|---|---|---|
| ACCESS_READONLY | 0 | 应用对所有用户只读。用户可以浏览应用，但不会有任何数据写入 MySQL 数据库。 |
| ACCESS_ADMIN_WRITE | 2 | 只有管理员用户可以写入数据库。对于其他所有用户，应用处于只读模式。 |
| ACCESS_FULL | 3 | 所有用户都可以写入数据库。这是默认模式。 |

示例：

```php
'access_mode' => ACCESS_ADMIN_WRITE,
'access_message' => '(maintenance until 2PM)',
```

这在 iTop 中会显示如下效果：

## 从不同的 URL 访问 iTop

在某些情况下，从不同的 URL 访问同一个 iTop 实例可能很有用。（例如，公司内部用户从内部网访问，客户从互联网访问）。

一种可能性是安装两个指向同一数据库的 iTop 实例。这样可以对所有参数进行完全控制，但会增加维护工作量，以保持两个实例同步（相同版本的 iTop、一致的参数...）。

另一种可能性是在配置文件中放置一些代码，根据某些服务器参数调整设置。由于配置文件是在每个"页面"加载（即执行）的 PHP 文件，因此设置可以完全动态。

例如，假设有一个反向代理控制对 iTop 的访问，并且希望所有互联网用户使用 HTTPS（安全）访问 iTop，而内部网用户通过 HTTP（更快）连接。可以执行以下操作：

- 从互联网：添加规则将所有 HTTP 流量重定向到 HTTPS；在 HTTPS 虚拟主机配置中添加特定标头：
  - Apache：`RequestHeader set HTTPS On`
  - NGINX：`proxy_set_header HTTPS On;`
- 从内部网：添加规则将所有 HTTPS 流量重定向到 HTTP

在配置文件中为 `app_root_url` 设置以下值：

```php
'app_root_url' => (isset($_SERVER['HTTP_HTTPS']) && ($_SERVER['HTTP_HTTPS'] == 'On')) 
                   ? 'https://itop.yourdomain/' : 'http://itop.yourdomain/',
```

其他组合也是可能的：在 PHP 中，`$_SERVER` 和 `$_COOKIES` 变量是可访问的。

例如：如果您可以从 `https://itop.company.com/itop` 或 `https://public-itop.company.com/itop` 访问 iTop，可以在配置文件中放入以下 PHP 代码：

```php
'app_root_url' => 'https://'
                  .(isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : 'itop.company.com')
                  .'/itop',
```

## 常见问题

**问：Setup 永远不会结束，而且我在层级中有很多对象？**

**答：**这两个症状很可能是相关的。在 Setup 时，iTop 会重新计算层级键，以防它们被破坏。目前还不清楚这种情况是否经常发生，只要速度快就不是大问题，但也可能慢到永远结束。

在这种情况下，只需在 `<my-itop>/data/` 下添加一个空文件 `.setup-rebuild-hkeys-never`，以指定 Setup 跳过层级键的重建。从 3.0 开始，您可以从"数据库完整性"菜单中测试和修复层级键问题。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:settings>

版本：3_2_0/admin/settings.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
