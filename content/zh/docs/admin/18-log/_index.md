---
title: "iTop 日志"
linkTitle: "技巧：iTop 日志"
date: 2025-06-27
weight: 51
description: >
  iTop 日志文件位置、内容和配置方法。
---

{{% pageinfo %}}

与许多其他应用一样，iTop 在日志文件中写入大量有用的信息。它们都可以在 iTop 根目录下的 log 目录中找到。

请注意，此目录不应被 Web 用户读取：请参阅安全关键目录访问。

{{% /pageinfo %}}

## 文件

### Setup

- `setup.log`
- `install-<date>.xml`：安装向导中做出的选择摘要
- `setup-queries-<date>_<time>.sql`：在"更新数据库架构"步骤期间发送到 DB 的查询列表

### iTop 应用

- `error.log`
- `deadlocks.log`（自 iTop 2.7.1 起）：数据库死锁的附加跟踪信息
- `deprecated-calls.log`（自 iTop 3.0.0 起）：对已弃用 PHP 方法或文件的调用
- `tools.log`：工具错误，当前仅用于备份

## 数据库

除了文件之外，在发生未捕获的异常时，iTop 可以将日志写入 `EventIssue` 类。您可以使用以下查询访问它们：在"运行查询"菜单中执行 `SELECT EventIssue`。

并非所有异常都会被写入（例如，REST 服务异常不会）。总体而言，如果满足以下条件，它们会被写入：

- 问题发生在标准页面中（在 UI.php 下）
- 问题发生在门户页面中，并且存在适当的 `log_level_min.write_in_db` 级别（请参阅下面的 `filter_portal_exceptions`）

## 配置

### 日志轮转

自 iTop 2.7.0 起，日志文件每月轮转。这意味着上个月的日志会加上后缀 `<year>-month<month_no>`。例如，如果我们在 2021 年 2 月，当前错误日志是 `error.log`，而上个月（2021 年 1 月）的错误日志是 `error.2021-month01.log`。

轮转周期可以在 iTop 配置中使用 `log_filename_builder_impl` 参数进行配置。可能的值：

- `DefaultLogFileNameBuilder`：不轮转
- `DailyRotatingLogFileNameBuilder`：后缀 `<year>-<month_no>_<day_no>`
- `WeeklyRotatingLogFileNameBuilder`：后缀 `<year>-week<week_no>`
- `MonthlyRotatingLogFileNameBuilder`：后缀 `<year>-month<month_no>`

自动日志清除：您可以使用 `log_purge.enabled` 参数激活清除（默认禁用）。您可以使用 `log_purge.max_keep_days` 参数定义日志保留时间（默认 365 天）。

### 过滤日志

自 iTop 2.7.0 起，`log_level_min` 配置参数允许过滤日志。这允许按通道指定要保留的日志级别。

级别按以下层次结构包含（值对应 LogAPI 类常量）：

```php
abstract class LogAPI {
        public const LEVEL_ERROR   = 'Error';
        public const LEVEL_WARNING = 'Warning';
        public const LEVEL_INFO    = 'Info';
        public const LEVEL_OK      = 'Ok';
        public const LEVEL_DEBUG   = 'Debug';
        public const LEVEL_TRACE   = 'Trace';
```

因此，例如过滤 LEVEL_INFO 将包含以下级别的日志：LEVEL_INFO、LEVEL_WARNING、LEVEL_ERROR。

要将级别应用于所有通道，只需在 iTop 配置文件中设置以下参数值，如下例所示。请注意，自 2.7.5 和 3.0.0 起，iTop 核心通道在 `LogChannels` 类中分组。

```php
'log_level_min' => LogAPI::LEVEL_TRACE,
```

要按通道设置特定级别：

```php
'log_level_min' => array(
            LogChannels::INLINE_IMAGE => LogAPI::LEVEL_TRACE,
            'UserRequest'             => LogAPI::LEVEL_TRACE,
            'MyCustomExtension'       => LogAPI::LEVEL_INFO,
    ),
```

由于默认日志通道（\LogAPI::CHANNEL_DEFAULT）是 ""（空字符串），您也可以这样做：

```php
'log_level_min' => array(
            ''                        => LogAPI::LEVEL_WARNING,
            LogChannels::INLINE_IMAGE => LogAPI::LEVEL_TRACE,
            'UserRequest'             => LogAPI::LEVEL_TRACE,
            'MyCustomExtension'       => LogAPI::LEVEL_INFO,
    ),
```

现有通道在专门的 wiki 页面中详细说明：iTop logs channels。

以下示例均无效：

- `'MyChannel' => LEVEL_WARNING,`
- `'MyChannel' => '',`
- `'MyChannel' => 'LogAPI::LEVEL_WARNING',`
- `'MyChannel' => 'warning',`

### 为 ITSM Designer 中的 PHP 开发人员

为了调试您在 ITSM Designer 中创建的 PHP 方法，您可以：

1. 在方法中添加调试跟踪到专用通道 Delta XML

```php
public function UpdateParentTicketLog()
{
    IssueLog::Debug("Entering UpdateParentTicketLog",'Delta XML');
        $oLog = $this->Get('log');
        $sLog = $oLog->GetModifiedEntry('html');
        IssueLog::Debug("Modified entry:$sLog.",'Delta XML');
        if ($sLog != '')
        {
            IssueLog::Debug("Test (sLog != chaine vide) == true",'Delta XML');
                $oTicket = MetaModel::GetObject('Ticket', $this->Get('ticket_id'), false);
                if ($oTicket)
                {
                    IssueLog::Debug("Test (oTicket) == true",'Delta XML');
                        $oTicket->Set('private_log', $sLog);
                        $oTicket->DBUpdate();
                }
        }
}
```

2. 在 iTop 配置文件中激活它们

```php
'log_level_min' => array(
            'Delta XML'       => LogAPI::LEVEL_DEBUG,
    ),
```

3. 在 iTop 中导航以触发您正在调试的方法
4. 检查日志以查看结果

### 异常日志记录

自 iTop 3.0 起，可以使用 `\ExceptionLog::LogException($oException);` 记录异常。

您可以像往常一样使用 `log_level_min` 和 `log_level_min.write_in_db` 配置其行为。通道必须是异常的类，如果未找到，它将尝试所有父树直到 Exception。

当没有配置存在时，请注意数据库日志记录对 Error 级别启用。

#### 过滤门户异常

门户触发 "Warning" 异常，默认情况下不会写入数据库日志。

例如，要启用其中一些，您可以配置：

```php
'log_level_min.write_in_db' => array(
            'CoreCannotSaveObjectException' => LogAPI::LEVEL_WARNING,
            'CoreOqlException' => LogAPI::LEVEL_WARNING,
    ),
```

#### 扩展开发人员

由于此行为是通用的，扩展开发人员可以通过调用 `\ExceptionLog::LogException($oException);` 来使用它。

在这种情况下，建议抛出特定的异常，以便能够按类过滤它们。

## 模块开发人员如何记录日志

最简单的答案：使用 IssueLog 类及其静态日志记录方法：Trace、Ok、Info、Warning、Error。

如果使用特定通道，您应该在模块的文档中说明！

如果您想记录到特定文件和/或自定义行为，您可以创建自己的日志实现！扩展 LogAPI 抽象类会有所帮助。如果是这样，请不要忘记：

- 调用 Enable 方法！此外，您可以覆盖它以记录到特定文件路径（例如参见 \DeadLockLog::Enable）
- 将适当的 LEVEL_DEFAULT 常量值设置为您的实现，设置为 LEVEL_* 常量之一
- 记录文档！;)

您还可以通过实现 iLogFileNameBuilder 接口或 RotatingLogFileNameBuilder 抽象类来添加新的轮转行为。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:log>

版本：3_2_0/admin/log.txt · Last modified: 2025/10/02 19:16 by 127.0.0.1
