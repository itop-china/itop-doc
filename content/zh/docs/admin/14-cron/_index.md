---
title: "调度后台任务"
linkTitle: "技巧：调度后台任务"
date: 2025-06-27
weight: 44
description: >
  配置 cron.php 定期执行 iTop 后台任务。
---

{{% pageinfo %}}

为了正常运行，iTop 维护操作和异步任务必须定期执行。为了简化安装，所有后台任务都被分组以从单个文件启动：`webservices/cron.php`。

{{% /pageinfo %}}

## 依赖 cron.php 的功能

以下功能依赖 cron.php 的激活：

- 当工单达到**阈值（TTO/TTR）**时发送通知，如果没有调用此 Web 服务，则不会发生。（任务：CheckStopWatchThresholds）
- 检查工单 SLA。达到限制的工单将进入升级 TTO/TTR 状态。
- 自动备份。
- 自动删除在创建或编辑对象期间创建的、已取消的无用附件和内联图片（任务：InlineImageGC，每小时运行）
- 异步邮件。默认情况下，此选项被禁用。要启用它，请在配置文件中设置 `email_asynchronous` 为 1（任务：ExecAsyncTask）
- 许多扩展也依赖此 cron，例如：Ticket Creation from Email、Approval Automation、Communication to Customers 等

所有后台任务由 `cron.php` 顺序处理。脚本将循环直到超过最大时间（请参阅参数中的 `cron_max_execution_time`）。此最大时间用于避免内存泄漏。

当 `cron.php` 脚本启动时，会设置一个锁，并在脚本退出时释放。因此，同一 iTop 实例上的任何并发运行将立即退出（如果锁已设置）。

- 将 `cron_max_execution_time` 参数设置得不要太低，大约 600（10 分钟）：这将允许正确处理需要很长时间才能完成的任务
- 例如每分钟启动 `cron.php` 脚本

## Windows 调度

使用 schedtask.exe 或 'at' 命令将 cron.php 计划为每 5 分钟运行一次。

```bash
schtasks.exe /create /sc minute /mo 1 /tn "iTop CRON" /tr "\"C:\www\itop\webservices\cron.cmd\""
```

注意：将 `C:\www\itop` 替换为您的 iTop 目录路径

## Linux 调度

编辑 crontab 以每分钟执行脚本：

```bash
*/1 * * * * www-data /usr/bin/php /var/www/html/itop/webservices/cron.php --param_file=/etc/itop-cron.params >>/var/log/itop-cron.log 2>&1
```

注意：将 `/var/www/html/itop` 替换为您的 iTop 目录路径

## 从 Web 调度

cron.php 页面也可以通过 Web 服务器执行。如果您无法访问系统（例如在共享托管系统上），这很有用。在这种情况下，您可以依赖 Web cron 服务为您运行它。但与本地计划作业相比，频率和执行时间可能会受到限制。

## 参数

| 参数 | 描述 | 默认值 |
|---|---|---|
| param_file | 参数文件的路径 | |
| auth_user | 用户登录名 — 仅限 CLI 模式，如果未使用参数文件 | - |
| auth_pwd | 用户密码 — 仅限 CLI 模式，如果未使用参数文件 | - |
| verbose | 如果设置为 1，将提供更多信息，用于故障排除。注意：由于进程在后台持续运行，日志文件往往会很快变大。不要长时间将此选项设置为 1。 | 0 |
| status_only | （iTop 2.0.1 新增）如果设置为 1，则显示计划任务的状态，进程立即停止（可以与 cron.php 的正常执行并行启动）。 | 0 |

## 参数文件

由于传递给 cron.php 的命令行参数对系统上的其他用户可见，因此建议的做法是将所有敏感参数从命令行移开。这就是"参数文件"的目的。

`param_file` 参数可以与大多数 REST/CLI Web 服务一起使用。按照惯例，cron.php 服务搜索名为 "cron.params" 的参数文件来读取其参数。

- 参数文件包含键/值对。
- 注释以 # 开头（`#` 之后找到的任何字符都将被忽略）

示例：

```
# 这是参数文件
#
# 如果参数同时在文件和参数中给出，则保留作为参数给出的值
#
 
# 认证
auth_user = qwertyuiop
auth_pwd = ded!catedL0g1n
```

## 设置

这些设置配置在主 iTop 配置文件 "itop-config.php" 中：

| 设置 | 描述 | 默认值 |
|---|---|---|
| cron_max_execution_time | cron.php 脚本的持续时间（秒）：如果超过，脚本将退出，即使还有剩余任务要处理。必须短于 php max_execution_time 设置（注意，在 CLI 中，默认设置为 0，表示无限制）。如果 cron.php 通过 Web 运行，则必须短于 Web 服务器响应超时。 | 600 |
| cron_sleep | cron.php 再次检查是否需要执行某些操作之前的持续时间（秒） | 2 |
| email_asynchronous | 如果设置为 1，则邮件离线发送，这需要激活 cron.php。例外：某些功能（如邮件测试工具）将强制使用序列化模式 | 0 |

## 允许的用户

只有管理员才被允许执行 `cron.php`。

## 故障排除

当任务不再运行时，有几件事需要了解：

### cron.php 在做什么？

- cron.php 程序启动时，会查找实现此 PHP 接口的任务，并将它们记录在表 `priv_backgroundtask` 中。
- 此表中存在的条目取决于安装的 iTop 扩展。
- `priv_backgroundtask` 包含每个任务的多个信息，例如：上次运行时间、下次运行预计何时开始、此任务的平均执行时间、任务当前是**活动**还是**暂停**（由管理员请求，字段状态）...
- cron.php 程序查找活动且下次运行已过期的任务，**逐个执行**，要求每个任务在 `cron_max_execution_time` 后停止执行。任务当然会在有意义的点停止，例如对于 Mail To Ticket Automation，它可以在处理 2 封接收到的邮件之间停止。询问任务下次运行应该是什么时间，并将该信息存储在表中。
- 然后检查自身启动时间是否超过 `cron_max_execution_time`，如果是，则自杀（这是因为永不结束的进程通常会消耗内存，而这些内存不会完全释放）
- 否则等待 `cron_sleep` 秒，然后再次检查表中是否有准备执行的任务。

### 当...时可以做什么

**任务似乎从未执行：**

当特定任务遇到使其陷入无限循环的问题时，cron.php 可能会被 PHP `max_execution_time` 停止（通常在 CLI 中不会）；在所有情况下，跟随该任务的任务将永远不会执行。在 cron.php 的后续运行中，由于任务总是按相同的顺序执行，同样的问题可能会再次发生。为了识别有问题的任务，您应该通过设置 `priv_backgroundtask` 表中的状态，逐个暂停您怀疑有问题的任务，并查看是否已停止有问题的任务。这种情况通常是由于带来该任务的扩展的 bug，或任务面临计划外情况。

应监控日志文件以生成警报，以便提前通知此类问题。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:cron>

版本：3_2_0/admin/cron.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
