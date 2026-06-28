---
title: "配置参数"
linkTitle: "配置：配置参数"
date: 2025-06-26
weight: 1
description: >
  <br> ➡️ iTop 配置文件 itop-config.php 完整参考
---

{{% pageinfo %}}

配置文件位于 `conf/production`，安装时创建，升级时重新生成。

- **MySettings**：iTop 设置
- **MyModuleSettings**：模块设置
- **MyModules**：PHP 文件列表（注释不需要的可显著加速）

{{% /pageinfo %}}

## 数据库连接

| 参数 | 描述 | 默认值 |
|---|---|---|
| db_host | MySQL 主机 | localhost |
| db_user / db_pwd / db_name | 认证信息 | |
| db_tls | MySQL TLS | false |

## 应用设置

| 参数 | 描述 | 默认值 |
|---|---|---|
| approot_url | 应用 URL | |
| graphviz_path | Graphviz 路径 | /usr/bin/dot |
| default_language | 默认语言 | EN US |

## 安全 / 附件 / API / 邮件

| 参数 | 描述 | 默认值 |
|---|---|---|
| security_strict | 强制认证 | true |
| attachment_plugin | 附件功能 | enabled |
| api_local / api_remote | REST API | true |
| email_transport | 邮件方式 | PHP |

### 只读模式

```php
'readonly' => true,
```

### 并发控制

`concurrent_lock` = enabled, `concurrent_lock_duration` = 300s

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:itop_configuration_file>

2026/04/13 17:12 by127.0.0.1

版本：3_2_0/admin/itop_configuration_file.txt · Last modified: 2026/04/13 17:12 by 127.0.0.1
