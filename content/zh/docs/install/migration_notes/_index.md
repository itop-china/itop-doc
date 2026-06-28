---
title: "3.1.x 到 3.2.0 迁移说明"
linkTitle: "3.1.x 到 3.2.0 迁移说明"
date: 2025-06-27
weight: 110
description: "从 iTop 3.1.x 迁移到 3.2.0 的注意事项，包括系统要求、数据库变更和扩展兼容性。"
---

{{% pageinfo %}}
本文档重点介绍将 iTop 迁移到此版本时可能出现的问题。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:migration_notes)。
{{% /pageinfo %}}

## 3.1.x 到 3.2.0 迁移说明

本文档重点介绍将您的 iTop 迁移到此版本时可能出现的问题。

- 有关新功能的重点，请查看[新功能](../../release/whats_new/)
- 有关变更的详尽列表，请查看[变更日志](../../release/change_log/)
- 有关 [3.2 Beta 版本的已知问题](../../release/whats_new/)
- [Combodo 3.2 兼容扩展版本](../../release/whats_new/)

## 3.2.3 特定说明

### 安全修复：自定义扩展迁移

由于安全修复，您可能需要调整您的扩展：[需要做什么以及如何做](../migration_notes/)。

要确定您的扩展是否需要一些调整，您可以将 iTop 的错误级别设置为 DEBUG，需要修复的 PHP 页面将被记录。

如果您的 iTop 的所有扩展都已准备就绪，我们建议您将配置参数 `security.disable_exec_forced_login_for_all_enpoints` 更改为 `false`，以增强 iTop 的安全性，而无需等待后续版本更改默认参数值。

### 安全修复：参数文件位置

由于安全修复，可选的 `--param_file` 参数（可用于 CRON、备份、导入、导出等）现在必须位于 iTop 文件夹之外。这在 [CRON 页面](https://www.itophub.io/wiki/page?id=3_2_0:admin:cron)中已经是推荐做法，现在已被强制执行。

### 安全修复：电子表格中的报告

由于安全修复，电子表格导出中的值现在以单引号 (') 为前缀，以避免 CSV 注入。有关更多信息，请参阅该功能的[问答部分](../../enduser/13-reports_in_excel/)。

### 安全：SMTP 服务器证书验证强制执行

如果您使用 SMTP 服务器的别名通过 iTop 使用 TLS 协议发送电子邮件，请注意 iTop 现在会检查证书的有效性。如果您收到类似 `Unable to connect with STARTTLS: stream_socket_enable_crypto(): Peer certificate CN='some.vertified.domain' did not match expected CN='some.uncertified.domain.alias'` 的错误，请将 `email_transport_smtp.verify_peer` 配置参数设置为 `true`。

### 数据模型：事件类的权限

由于安全修复，`Event` 类（及其子类）以前对任何配置文件都可访问。自 iTop 3.2.3 / 3.3.0 起，它们默认仅对 **Administrator** 和 **SuperUser** 配置文件可访问。

- 如果您希望允许其他配置文件读取它们，您应该将 `Event` 组添加到所需的配置文件中。
- 如果您添加了子类，您应该将它们添加到 `grant_by_profile` 类别中，以便它们遵循与原生类相同的安全规则。

### 数据模型：SuperUser 配置文件

SuperUser 配置文件（ID 117）已更新，添加了缺失的权限。如果您在自定义中更改了它们，请注意我们更改了以下 XPath 的默认数据模型：`/itop_design/user_rights/profiles/profile[(@id="117")]/groups/group[@id='Incident' or @id="Ticket"]`

### 通知：通过 OAuth 和 SSL 的 SMTP

iTop 3.2.3 带来了一个新的出站/入站邮件组件，此组件比以前的组件更严格，这意味着如果您的配置尚未符合 RFC，您可能需要调整它。通常，如果您将电子邮件传输配置如下：

```php
'email_transport' => 'SMTP_OAuth',
'email_transport_smtp.encryption' => 'tls',
'email_transport_smtp.host' => 'some.smtp-server.com',
'email_transport_smtp.port' => '587'
```

您尝试发送电子邮件时可能会收到以下错误：

```
Errors: Connection could not be established with host "ssl://some.smtp-server.com:587": stream_socket_client(): SSL operation failed with code 1. OpenSSL Error messages: error:0A00010B:SSL routines::wrong version number
```

要避免/修复此问题，只需将 `email_transport_smtp.encryption` 参数从 `tls` 更改为 `ssl`，如 [SMTP OAuth 故障排除部分](../../admin/10-notifications/)中所述。

### 扩展：邮件到工单自动化 - "邮箱（用于 IMAP）"属性

自扩展 v3.9.0 起，指定要扫描的文件夹（"邮箱（用于 IMAP）"属性）时，该值必须遵循 [RFC 3501](https://datatracker.ietf.org/doc/html/rfc3501)，这意味着以前容忍的某些格式不再受支持：

- 根文件夹不得以分隔符开头，例如 `/INBOX` 或 `/foo` 不受支持，请使用 `INBOX` 或 `foo`
- 路径不得以分隔符开头，例如 `/INBOX/foo` 不受支持，请使用 `INBOX/foo`

## 3.2.1 特定说明

此版本更改了未提供值时强制日期和日期时间属性的处理方式。

- **之前**：当前日期时间（now）会自动设置到此类字段中（导致用户忽略日期并留下无效值）
- **从 iTop 3.2.1 版本起**：如果未提供值，对象创建/更新将失败。但现在可以在 XML 中为此类属性定义相对默认值：`NOW()` → 对象创建时的当前日期（时间）；`DATE_ADD(NOW(), INTERVAL 7 DAY)` → 当前日期（时间）+ 7 天；或任何 OQL 支持的计算日期的语法

何时重要？

- 如果这些字段是向用户请求的，此 iTop 更改没有影响。
- 如果这些字段是通过覆盖 OnInsert 或 OnUpdate 方法自动填充的，同样此 iTop 更改没有影响。
- 如果这些字段未向用户展示且未由任何代码设置，那么您需要在这些字段的 XML 标签 `default_value` 中设置 `NOW()` 以恢复之前的行为。

如何修复？

- 这可以在 Designer 中快速完成，或者通过 iTop 扩展完成。
- 这可以在升级之前完成，即使在旧版本如 2.7.x 上也可以，因为在 3.2.1 之前，日期和日期时间属性上的默认值会被静默忽略。

## 对用户的影响

除了新功能中描述的新内容外，与 iTop 3.1.x 版本相比，现有 iTop 行为没有破坏性更改。

## 升级前检查

### 系统

iTop 根文件夹下有一个新文件夹 "resources" 和一个新文件 "app.php"。如果必要，请更新您的迁移/备份脚本。

#### PHP 版本

- 新的 PHP 最低版本：8.1.0
- 新的 PHP 最高版本：8.3.x

#### PHP 扩展

PHP 扩展 **APCu** 现在强烈推荐使用，否则性能可能会略有下降。

#### MySQL / MariaDB 版本

- MariaDB 最低版本提高到：10.6+
- MySQL 最低版本保持不变：5.7，但 MySQL 不再是推荐选择

### 数据库

#### 数据库更新操作

N°6619 - 附件：将 `contact_id` 从 `AttributeExternalField` 改为 `AttributeExternalKey`

- `alter_algorithm` 参数设置为 "COPY" 或 "INPLACE"。
- 在较旧版本的 MariaDB 上构建的 `attachment` 表，自那以后从未重建

有关更多信息，请参阅 [MariaDB-InnoDB 在线 DDL](https://mariadb.com/kb/en/innodb-online-ddl-overview/)

以下操作由安装程序执行，但可能相当慢，且不在您期望的时间点。您可以在升级前使用以下命令手动运行操作：

```sql
SET SESSION alter_algorithm='INSTANT';
ALTER TABLE `attachment` ADD `contact_id` INT(11) DEFAULT 0;
ALTER TABLE `attachment` ADD INDEX `contact_id` (`contact_id`);
```

然后使用此查询填充联系人信息：

```sql
UPDATE attachment att
JOIN priv_user us ON att.user_id = us.id
SET att.contact_id = us.contactid
WHERE att.contact_id = 0;
```

### 扩展/自定义代码

像往常一样，某些[扩展必须同时升级](../../release/whats_new/)，其中 4 个需要在之后升级。

如果您使用 XML 和自定义代码开发了自定义扩展，请检查：[开发者检查清单](../migration_notes/)

#### 需要升级的扩展

检查每个 Combodo 扩展的 [3.2 兼容版本](../../release/whats_new/)，您需要在升级前安装。

#### 门户主题

如果您为最终用户门户创建了替换 `bootstrap-theme-combodo.scss` 的自定义主题，您需要重新生成它。否则某些元素可能无法正确显示（HTML 编辑器）。

#### 包含在 iTop 中

### XML 数据模型

#### 配置文件 117

iTop Community 3.2.1 中添加了一个 ID 为 117 的新配置文件 "Super User"。

- 此配置文件允许委派大多数 iTop 管理员任务，但系统方面除外。
- 扩展在定义其带来的对象/功能的访问权限时，应考虑此配置文件。

#### 用户请求

用户请求和事件类的 "Solution" 字段现在支持 HTML。要恢复此数据模型更改，请将以下 XML 添加到扩展中，或要求 Combodo 在 Designer 中为您注入：

```xml
<class id="UserRequest" _delta="if_exists">
  <fields>
    <field id="solution" xsi:type="AttributeText" _delta="if_exists">
      <format _delta="delete_if_exists"/>
    </field>
  </fields>
</class>
<class id="Incident" _delta="if_exists">
  <fields>
    <field id="solution" xsi:type="AttributeText" _delta="if_exists">
      <format _delta="delete_if_exists"/>
    </field>
  </fields>
</class>
```

## 安装程序

## 配置文件

## 升级后检查/操作

### 重命名您的触发器

由于新的取消订阅机制，触发器 "Description" 字段将对控制台用户可见，作为他们收到的通知的标识符，因此该描述应该解释**何时**生成此触发器（他们可能会根据触发器类型猜测，但显式文本可能更容易理解）以及**谁**接收它们。

### 连接新闻

iTop 3.2.0 带有 3 个新的 "通过 Newsroom 通知" 操作：

- **提及人员通知**：自动链接到所有现有的 "Trigger (on object mention)"，在 "Mentioned filter" 字段中搜索 "Person"
- **工单分配时通知代理**：与 "Trigger (on entering a state)" 链接，类为 "User Request"，状态为 "assigned"
- **通过门户更新公共日志时通知**：与 "Trigger (when updated from the portal)" 和 "Trigger (when updated by mail)" 链接，两者类均为 "User Request"

所有 "Trigger (on object mention)" 触发器的 "Subscription policy" 字段（在 3.2.0 中添加的字段）设置为 "Force at least one channel (News or Email)"，因为默认情况下我们不希望 iTop 用户在某个对象日志中提到他们的名字时取消订阅所有渠道。

### 移除搜索 Brick

如果您不希望在标准门户中看到新的搜索 brick，请在 Designer 中添加以下行（针对 Combodo 客户），或创建一个执行此操作的 iTop 扩展。

```xml
<module_design id="itop-portal" xsi:type="portal">
  <bricks>
    <brick id="manage-all-tickets-for-portal-user" xsi:type="Combodo\iTop\Portal\Brick\ManageBrick" _delta="delete"/>
    <brick id="search-within-tickets-for-portal-user" xsi:type="Combodo\iTop\Portal\Brick\FilterBrick" _delta="delete"/>
  </bricks>
</module_design>
```

### X-Content-Type-Options HTTP 头和 CORB 保护

自 iTop 2.7.10 / 3.0.4 / 3.1.2 / 3.2.0 起，`X-Content-Type-Options` HTTP 头以 `nosniff` 值发送。这可能会触发某些资源的 CORB 保护，阻止它们加载（参见 [Chromium CORB 说明](https://chromium.googlesource.com/chromium/src/+/master/services/network/cross_origin_read_blocking_explainer.md#determining-whether-a-response-is-corb_protected)）。

为缓解此问题，在 iTop 核心中对应的资源上禁用发送此 HTTP 头。由于某些扩展可能会受到影响，可以将 `security.enable_header_xcontent_type_options` 配置参数设置为 `false` 以防止发送该头。

## 降级

🚧 进行中

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:migration_notes>

版本：3_2_0/install/migration_notes.txt · Last modified: 2026/06/24 10:08 by 127.0.0.1
