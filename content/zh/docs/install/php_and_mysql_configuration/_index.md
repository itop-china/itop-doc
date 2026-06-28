---
title: "配置 PHP、Web 服务器和数据库..."
linkTitle: "配置 PHP、Web 服务器和数据库..."
date: 2025-06-27
weight: 30
description: "iTop 所需的 PHP、Web 服务器和数据库服务器配置指南。"
---

{{% pageinfo %}}
本文档介绍 iTop 所需的 PHP、Web 服务器和数据库服务器配置。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:php_and_mysql_configuration)。
{{% /pageinfo %}}

## Web 服务器

### 允许将 OQL 查询作为参数传递

在 iTop 中，许多页面会将 OQL 查询作为参数发送。这是无风险的，因为查询在发送给数据库服务器之前，会先由 iTop 进行解释和定制，并转换为单一的只读 SQL 查询。

换句话说，对于任何查询，iTop 都会：

- 检查语法和类的有效性
- 根据用户权限添加适当的过滤器
- 防止注入攻击

由于 OQL 语法与 SQL 接近，这可能会被 mod_security 等安全系统阻止。您必须允许这些查询才能使用 iTop。例如，使用 mod_security：

```apache
SecRule REQUEST_URI "@beginsWith /pages/UI.php" \
"id:'000013', \
phase:1, \
t:none, \
nolog, \
pass, \
ctl:ruleRemoveById=942190, \
ctl:ruleRemoveById=942360" \

SecRule REQUEST_URI "@beginsWith /pages/ajax.render.php" \
"id:'000013', \
phase:1, \
t:none, \
nolog, \
pass, \
ctl:ruleRemoveById=942190, \
ctl:ruleRemoveById=942360, \
ctl:ruleRemoveById=949110, \
ctl:ruleRemoveById=980130, \
ctl:ruleRemoveById=920220, \
ctl:ruleRemoveById=942100"
```

### 临时目录的写入权限

确保 Web 服务器对临时目录具有写入权限。

### APCu

我们强烈建议启用 APCu！有关更多详细信息，请阅读[优化 iTop 性能](https://www.itophub.io/wiki/page?id=3_2_0:admin:performance)。

但是，如果您在多个实例上使用 APCu，在执行"移至生产环境"后，必须在所有实例上清除缓存。由于我们没有工具来执行此操作，实际上这意味着：

- 要么重启所有 Web 服务器
- 要么不使用 APCu

### 数据库客户端模块

如果您的 iTop 数据库位于与 Web 服务器不同的外部服务器上，您需要在 Web 服务器上安装 MariaDB（或 MySQL）的客户端安装包。

## PHP

### 必需扩展

#### 其他 PHP 扩展

- `php-gd` 是使用 CKEditor 添加图像以及自动调整 HTML 字段中图像大小所必需的。
- PHP LDAP 模块是支持 LDAP 或 Active Directory 认证所必需的。
- 加密数据：请查看加密数据以了解需要安装什么才能使用 EncryptedString 属性。

### php.ini 设置

php.ini 中的推荐值摘要：

```ini
memory_limit = 256M ; 如有需要可以增加
max_input_vars = 5000

; upload_tmp_dir : 应指向一个具有写入权限的目录

; 还要检查以下用于附件的选项（请参阅下面的专用章节）
; 根据您的偏好调整值！
; - upload_max_filesize
; - max_file_uploads
; - post_max_size
; - max_input_time
```

#### max_input_vars

在各种使用场景中，iTop 会向服务器发送大量数据。特别是某些 XHR 查询会发送当前对象结构的描述：属性列表及所有相应属性。如果您的数据模型在对象上添加了大量属性，您可能会在这些屏幕之一上遇到错误行为：

- 编辑具有许多关系的对象时（iTop 会创建一个包含所有关系的大表单）
- 在对象列表中：在"配置此列表"对话框中勾选大量属性后，点击列标题对列表排序
- 点击列标题对列表排序
- 在"配置此列表"对话框中勾选大量属性后

此类行为可能由 Web 服务器引起：`php.ini` 中的参数 `max_input_vars` 定义了发送到服务器的最大数据量。其默认值为 1000，对于具有许多字段的自定义对象可能不够。如果您遇到此类行为，可以将 `max_input_vars` 值从 1000 更新为 3000 或 5000，具体取决于需要传输的数据量。

#### 附件上传

iTop 能够上传和存储文档（即文件）作为各种对象（工单、CI 等）的附件。这些文档以二进制大对象的形式存储在 iTop 数据库中。为了安全地上传和存储文档，必须在 PHP 和 MySQL 中一致地调整多个设置。

在 PHP 中，几个变量控制文件上传：

| 参数 | 说明 |
|------|------|
| `file_uploads` | 设置为 1 允许文件上传，设置为 0 阻止所有文件上传。 |
| `upload_tmp_dir` | 服务器上存储上传文件的临时位置。确保此参数指向运行 Web 服务器的进程（或在 IIS 使用 Windows 内置认证的情况下，最终用户）可以访问（和写入）的位置，并且有足够的剩余空间。 |
| `upload_max_filesize` | 允许上传的文件的最大大小。值以字节表示。您可以使用 K 表示千字节（=1024 字节）、M 表示兆字节、G 表示千兆字节。例如：4M 表示 4 兆字节。 |
| `max_file_uploads` | 单个网页中可同时上传的最大文件数。iTop 通常一次只上传一个文件。您可以安全地使用默认值 20。 |
| `post_max_size` | 通过 POST 请求发送到服务器的最大数据量。此值必须大于 `upload_max_filesize`，因为同一请求将包含一些额外信息（文档标题、操作代码...）。因此最好在这里设置更大的值。例如，如果 `upload_max_filesize` 是 4M，那么 `post_max_size` 设置为 5M。 |
| `memory_limit` | 文件上传到服务器后，将在存储到数据库之前读入内存。因此，请确保 `memory_limit`（如果启用）至少是 `upload_max_filesize` 的 5 倍。 |
| `max_input_time` | 此值定义服务器读取输入的最大允许时间。这包括上传文件所花费的时间。对于通过慢速连接上传大文件，默认的 60 秒可能不够。 |

大小关系：

| `upload_max_filesize` | < | `post_max_size` | < | `max_allowed_packet` | < | `memory_limit` |
|------|------|------|------|------|------|------|
| php.ini | | php.ini | | my.cnf | | php.ini |

## 数据库服务器

### 数据库服务器用户

从 MySQL 5.7 开始，root 用户在 MySQL 中没有显式密码，因此您需要创建一个具有密码的用户账户来安装 iTop。以下命令创建一个具有所有权限的用户 `iTop`。这对于测试很有用，但**不是生产环境中的最佳配置**（因为安全很重要）：

```bash
sudo mysql
```

登录 MySQL 后，执行以下命令：

```sql
GRANT ALL PRIVILEGES ON *.* TO 'iTop'@'%' IDENTIFIED BY 'some_password';
FLUSH PRIVILEGES;
```

iTop 日常使用和安装所需的权限：

- `SELECT`、`INSERT`、`UPDATE`、`DELETE`：iTop 日常使用
- `CREATE`（表）、`ALTER`、`CREATE VIEW`：安装和数据模型修改
- `CREATE`（数据库）：如果您要求安装程序为您创建数据库，以及 ITSM Designer 用于测试数据库创建（在这种情况下也需要 `DROP`）
- `SHOW VIEW`、`LOCK TABLES`：用于备份
- `DROP` 和 `TRIGGER`：由 DataSynchro 使用
- `SUPER`：DataSynchro 需要，仅当 MySQL 启用了二进制日志但没有 `--log-bin-trust-function-creators` 选项时（参见 MySQL Bugs: #39489）
- `PROCESS`：仅由 `CMDBSource::LogDeadLock` 用于获取死锁上下文（`SHOW ENGINE INNODB STATUS` 查询）（死锁日志自 iTop 2.7.1 / 3.0.0 起可用，参见 PR #139）

### 设置

```ini
innodb_buffer_pool_size = 512M
query_cache_size = 32M
query_cache_limit = 1M

innodb_default_row_format = DYNAMIC
innodb_large_prefix = true

; max_allowed_packet : 应设置为大于 php.ini 中 upload_max_filesize 的值
```

### 国际化

自 iTop 2.5 起，使用的字符集是 utf8mb4，排序规则为 utf8mb4_general_ci。为了让 iTop 正确处理字符串，必须满足以下要求：

- MySQL 版本 5.5.3 或更新
- `innodb_default_row_format` 变量设置为 `DYNAMIC`（默认值）或 `COMPRESSED`
- `innodb_large_prefix` 设置为 `true`

### 附件

上传的文件存储在 MySQL 数据库中，每个文件一个查询。因此，允许的最大查询大小必须大于上传文件的最大大小。这是通过 MySQL 服务器上 my.cnf 配置文件中的变量 `max_allowed_packet` 配置的。

### MySQLDump

此实用程序模块在 MariaDB（或 MySQL）的客户端安装包中可用。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:php_and_mysql_configuration>

版本：3_2_0/install/php_and_mysql_configuration.txt · Last modified: 2025/07/03 12:47 by 127.0.0.1
