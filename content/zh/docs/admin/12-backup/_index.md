---
title: "数据备份"
linkTitle: "系统：数据备份"
date: 2025-06-27
weight: 31
description: >
  介绍 iTop 的 GUI、计划任务、CLI 和手动备份方式。
---

{{% pageinfo %}}

在 iTop 中，所有数据（包括上传的文档）都存储在 MySQL 数据库中。因此，强烈建议定期备份数据库！

{{% /pageinfo %}}

## iTop 备份包含什么？

备份是一个 zip 文件，包含恢复应用所需的所有数据：

- 配置（即配置文件 `itop-config.php`）
- 数据（即 MySQL 数据库的完整转储）
- .xml delta 文件 — 适用于使用 ITSM Designer 自定义实例的 Combodo 客户
- 从 iTop Hub 和 ITSM Designer 部署的扩展模块

注意：

- 如果在运行备份后安装了新模块，恢复备份等同于卸载这些模块。
  - 对于通过 iTop Hub 安装的模块，请从 Hub 重新推送它们。
  - 对于通过 ITSM Designer 安装的模块，请连接到 ITSM Designer 并再次运行 Move To Production。
  - 对于通过 "extensions" 文件夹安装的模块，如果希望将模块重新安装到 iTop 中，请再次运行 setup。
- 如果自备份以来升级了 iTop 或添加了新模块，请注意恢复可能会导致数据库与代码库不一致。恢复后，iTop 可能无法工作。建议运行 Setup 以将数据库与 iTop 数据模型对齐（由新 iTop 版本或最近添加的扩展带来的）。

## 限制

备份需要 PHP 的 `exec` 函数可用。对于超过 68 GB 的大型数据库，建议直接使用 `mysqldump` 进行备份。

## GUI 备份

自 iTop 2.1.0 起，管理员可以使用特殊的"备份"菜单：

此管理页面提醒您当前设置，并列出备份文件：

"计划备份"指由后台任务生成的备份。更多详细信息请参阅下面的专用章节。

点击"立即备份！"按钮执行备份（无需确认）：

## 备份后台任务

### 配置

可以在 iTop 配置文件的 `itop-backup` 部分中调整自动备份方案：

| 参数 | 类型 | 描述 | 默认值 |
|---|---|---|---|
| mysql_bindir | string | 如果不在 "path" 中，MySQL 二进制文件的目录。用于计划备份和 REST 服务的默认值 | |
| week_days | string | 必须执行自动备份的星期几（小写）CSV 列表 | monday, tuesday, wednesday, thursday, friday |
| time | string | 必须执行自动备份的 24 小时制时间 | 23:30 |
| retention_count | int | 目标目录中保留的备份文件数量 | 5 |
| enabled | bool | 打开/关闭自动备份 | true |
| file_name_format | string | 备份名称（zip），仅用于计划备份。支持以下占位符：__HOST__、__DB__、__SUBNAME__。可以基于 PHP/strftime 规范提供时间信息 | __DB__-%Y-%m-%d_%H_%M |
| itop_backup_incident | string | iTop 的 URL。如果备份失败，则在此 iTop 中创建工单。（此参数在 2.5.2+ 中称为 itop_root） | 如果为空或没有参数，则使用当前 iTop APP_ROOT |
| extra_files | array | （自 3.1 / bug N°6133 起）要通过 CLI 脚本备份/恢复的附加文件/文件夹路径列表 | 如果为空，备份归档包含常用文件（conf/dump/...） |

备份概览页面不会告知您备份是否完全禁用。

## CLI 脚本

### CLI 备份

您可以使用以下命令生成备份：

```bash
php datamodels/2.x/itop-backup/backup.php --auth_user=<LOGIN> --auth_pwd=<PASSWORD>
```

#### CLI 备份配置文件（推荐）

可以将 param_file 作为参数传递给 backup.php 脚本。例如：

```bash
php datamodels/2.x/itop-backup/backup.php --param_file=<此文件>[,<另一个文件>]
```

示例参数文件与模块捆绑在一起：`datamodels/2.x/itop-backup/backup.params.distrib`

所有这些参数都可以在命令中或 param_file 中传递。如果未指定 `mysql_bindir` 参数（无论是在命令行还是在 param_file 中），则将使用 iTop 配置文件参数。

### CLI 检查备份脚本

此脚本也与模块捆绑在一起：`datamodels/2.x/itop-backup/check-backup.php`。

这是一个监控工具，必须在 backup.php 之后执行。

它将：

- 验证生成的备份文件是否按文件名规范存在
- 旨在检测文件大小的可疑变化
- 如果存在 `itop_backup_incident` 和 `check_ticket_*` 参数，则备份失败时会在本地或远程 iTop 实例上创建工单

### CLI 恢复

您可以使用以下命令恢复备份：

```bash
php datamodels/2.x/itop-backup/restore.php --auth_user=<LOGIN> --auth_pwd=<PASSWORD> --backup_file=<PATHTOBACKUP>
```

恢复操作不会恢复文件权限。您可能需要对以下文件执行 chown（www-data）操作：

- conf/production/config.itop.php
- data/production.delta.xml
- data/cache-production
- data/production-modules

如果数据模型使用可逆加密的密码字段，请确保新系统和旧系统使用相同的加密算法：如果旧系统上存在 mcrypt PHP 扩展，则新系统上也必须存在 mcrypt 扩展。如果 mcrypt 不存在，则也不应存在。

注意：用户账号密码使用单向加密，不受 mcrypt 存在的影响。

## 手动备份（使用 mysqldump）

与以前版本的 iTop 一样，您仍然可以使用 MySQL 附带的 `mysqldump` 命令行工具创建自己的备份。

您可以使用以下 mysqldump 命令运行数据库的完整备份：

在 Linux 系统上：

```bash
/usr/bin/mysqldump --opt --default-character-set=utf8mb4 --single-transaction --add-drop-database --user=<user> --password=<password> <DB> | gzip < <file>
```

在 Windows 系统上：

```bash
mysqldump.exe --opt --default-character-set=utf8mb4 --single-transaction --add-drop-database --user=<user> --password=<password> <DB> > <file>
```

其中：

- `<user>`：连接 MySQL 的用户名
- `<password>`：对应的密码
- `<DB>`：安装 iTop 的数据库名称
- `<file>`：要生成的归档文件的名称

数据库内容转储后，只需归档此转储和文件 `conf/production/config-itop.php`，即可保留 iTop 实例的完整映像。

- 确保以 UTF-8 MB4（`--default-character-set=utf8mb4`）导出数据，否则重音字符将丢失。
- 选项 `--single-transaction` 有两个效果：它生成一致的备份，因为所有表都在一个事务中导出，并且它为错误 1449（定义者不存在）提供了解决方法，如果您导出已从另一个系统重新导入或已由不再存在的用户创建的数据库，则可能会发生此错误。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:backup>

版本：3_2_0/admin/backup.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
