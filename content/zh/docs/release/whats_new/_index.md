---
title: "iTop 3.2 社区版"
linkTitle: "iTop 3.2 新特性"
date: 2025-06-27
weight: 30
description: >
  iTop 3.2 社区版的新特性概览，包括新闻中心、通知中心、HTML 编辑器、新主题、门户搜索等用户、管理员和开发者方面的改进。
---

{{% pageinfo %}}
本文档介绍 iTop 3.2 社区版的新特性。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:release:whats_new)。
{{% /pageinfo %}}

## 版本信息

- 3.2.0 Beta 版本发布日期：2024年6月（Beta 已知问题）
- 3.2.0 发布日期：2024年9月
- 3.2.1 发布日期：2025年3月
- 3.2.2-1 发布日期：2025年8月
- 3.2.3 发布日期：2026年4月
- [下载链接](https://sourceforge.net/projects/itop/files/)
- 升级前请阅读：[迁移说明](../change_log/)
- iTop 历史变更列表：[累积变更日志](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log)
- 开发者迁移说明：[将扩展迁移到 3.2](../change_log/)
- [Combodo 3.2 兼容扩展版本](https://store.itophub.io/en/3_2_0/extensions)

## 用户新特性

### 新闻中心

现有的新闻中心功能已扩展到所有 iTop 后台办公用户。此前仅限于 iTop 管理员和外部新闻提供者（如 iTop Hub）。

从此版本开始，iTop 本身成为一个新闻提供者，这意味着当 iTop 中发生某些事件时，它可以向目标用户发送新闻。

这使用了现有的触发器-操作机制。一种新的通知操作类型允许发送新闻，替代或并行于电子邮件。

- 新闻消息会显示给目标 iTop 用户，在 iTop 后台办公中，通过铃铛图标下方查看。
- 铃铛上的红色圆点通知用户有未读新闻。仅在用户在 iTop 中导航时刷新。
- 当用户点击其新闻之一时，它会打开操作中指定的 URL，通常是触发新闻的对象。新闻会自动标记为已读并记录日期。

用户可以检索所有收到的新闻，并逐个或批量处理：

- 可以将其标记为已读或未读
- 可以删除它们
- 无论是否已读，新闻会在所有用户中根据 iTop 可配置延迟后自动删除，默认 60 天。

这些新闻通知只能发送给有权访问 iTop 后台办公的 iTop 用户。

### 通知中心

后台办公用户现在可以自行取消订阅特定通知。

我们在这里所说的通知，是指特定触发器和操作的组合。

- 例如：管理员可能配置了一个日志更新触发器，通过电子邮件和新闻通知代理；另一个位置创建触发器，通过新闻通知一些人。
- 在这种情况下，代理可以：
  - 为第一个触发器在电子邮件和新闻之间选择，如果触发器允许，甚至可以完全取消订阅。
  - 如果位置创建触发器的新闻对他无用，可以取消订阅该新闻。

限制：触发器和操作的配置人员可以限制用户取消订阅的可能性：

- 对于"提及"触发器，我们通常希望拒绝用户取消订阅所有渠道，他们将必须保留至少一个，以确保他们被通知。
- 对于某些操作（如 iCalendar 邀请、未经身份验证的表单等），用户根本不允许取消订阅。
- 用户只能取消订阅他们已经至少收到过一次通知事件的操作。
- 用户只能取消订阅直接发送到与其用户关联的联系人的操作，例如电子邮件和新闻，而不是 Rocket、Teams 等此类通知渠道。

### HTML 字段编辑器

iTop 使用外部提供商工具 CKEditor，出于维护和安全原因必须升级。新版本与之前版本有很大不同，大多数编辑功能以不同的图标保留，少数功能丢失，同时添加了一些新功能。

这个新版本的编辑器在格式化表格方面比以前的版本强大得多，但像任何新版本一样，需要一些时间来适应。

#### 提示与技巧

- 如何退出嵌入代码部分？按 3 次"Enter"键
- 当您从以前的案例日志复制粘贴一段内容到新的案例日志时，背景颜色会保留，并且很难移除。为避免这种情况，请使用组合键：Ctrl+Shift+V 仅粘贴原始文本而不带格式。如果您熟悉 HTML，可以移除背景颜色：点击"源码"按钮，直接编辑 HTML 代码并移除 `div` 标签。

### 新控制台主题

为确保 iTop 的可访问性，我们的团队一直在开发新的后台办公主题。这些 UI 符合 WCAG 标准，专注于让视觉障碍用户更容易使用解决方案：

- **色盲主题**：旨在帮助色盲用户，该主题实际上分为两个子主题以适应特定情况：
  - 一个适用于红色盲和绿色盲
  - 另一个适用于蓝色盲
- **高对比度主题**：增加对比度，让用户更容易区分屏幕上的不同元素。它可以帮助从色盲到低视力问题等不同病理的用户。

### 欢迎弹窗

Combodo 和 iTop 扩展的编辑者现在可以决定向某些用户（通常是管理员，但也可以是所有用户）显示与新版本相关的消息。

- iTop 升级后，用户首次连接时可能会显示多条消息
- 这些消息一旦被用户确认，就不再显示
- 在 iTop 3.2 中，向所有用户显示四条消息，向 iTop 管理员显示一条消息

按钮行为：

- **稍后提醒我**：下次连接 iTop 时会再次显示所有消息
- **下一步**：将当前消息标记为已读并显示下一条（如果是最后一条则关闭窗口）
- 点击弹窗窗口外部会关闭窗口，下次连接 iTop 时，未确认的消息将再次显示

### 门户中的新搜索

默认在终端用户门户中添加了一个搜索 Brick，允许他们无论状态如何都能检索其工单。

## 管理员新特性

### 数据模型访问

在控制台中显示的任何 iTop 对象，其类标签显示在标题部分，对 iTop 管理员是可点击的，会跳转到该特定类的数据模型页面。

### 通知

围绕通知进行了多项改进。主要改进如下：

#### 通过新闻中心

此版本带来了一种新操作，通过 iTop 中显示的新闻来通知后台办公用户。

- 此操作可以由任何触发器触发。
- 开箱即用，"通过新闻中心通知"操作会自动创建，详情如下：
  - 一个用于向在任何 iTop 对象上被提及的任何人发送新闻（iTop 检索任何现有的"提及"触发器并将它们链接到新操作）
  - 一个用于通知工单的代理，但此操作未链接到任何触发器，仅作为示例。
- 此操作的触发会为每个具有关联活动用户的收件人人员生成一条新闻

#### 异步

大多数操作提供了一个新的"异步"字段，用于指定它是必须立即触发并阻塞用户直到完成，还是在后台执行或遵循全局 iTop 设置。

#### 订阅策略

触发器现在可以定义用户是否允许取消订阅所有通信渠道、除一个之外的所有渠道或不允许，默认允许完全取消订阅。

对于"对象提及"和"请求审批"等触发器，建议更改此设置。

#### 操作中的最近执行

在操作对象中添加了一个新的 ajax 标签页（异步显示，如仪表板属性）：最近执行。

它将显示此特定操作的日志。默认显示 61 天，但可以使用 `notifications.last_executions_days` 配置参数更改。

#### 类标签重命名

为了更清晰地区分指定如何执行特定操作的"操作"和代表操作执行结果的"事件"，我们重命名了"操作"和"事件"下的大多数类。

## 开发者新特性

### 新事件

在 3.2.0 中，添加了一些事件并移除了一些事件。

已移除：

- `EVENT_DB_BEFORE_APPLY_STIMULUS`
- `EVENT_DB_AFTER_APPLY_STIMULUS`
- `EVENT_DB_APPLY_STIMULUS_FAILED`

已添加：

- `EVENT_DB_ABOUT_TO_DELETE`：删除已确认并将发生。对象及其关系在数据库中仍然可用于 OQL 查询和 Get('att_code')
- `EVENT_ENUM_TRANSITIONS`：管理当前对象状态下的允许转换。唯一允许的操作是使用 `$this->DenyTransition($sTransitionCode)` 拒绝转换

### 新 XML

从 iTop 3.2.1 起，AttributeDateTime 和 AttributeDate 使用 `<default_value>` XML 标签来预填充字段，并在 PHP 直接创建对象时设置它。

- `NOW()` → 对象创建时的当前日期（时间）
- `DATE_ADD(NOW(), INTERVAL 7 DAY)` → 当前日期（时间）+ 7 天
- 或任何支持计算日期的 OQL 语法

这些默认值可以在旧版本的 iTop 上设置，只是不会有任何效果。

### 新 API

#### \iBackupExtraFilesExtension

允许（通过扩展或代码片段）指定额外的文件和目录，以添加到 iTop 备份存档中，与标准文件（配置文件、数据库转储等）一起。

```php
class MyFilesToAddToBackupArchive implements \iBackupExtraFilesExtension
{
    public function GetExtraFilesRelPaths(): array
    {
        return [
            // 保存在数据文件夹中的文件
            'data/file1.txt',
            // 保存在当前环境（通常是"production"）模块中的文件
            'env-'.\utils::GetCurrentEnvironment().'/some-module/file2.txt',
            // 日志文件夹中的文件
            'log/file3.txt',
        ];
    }
}
```

#### \iWelcomePopupExtension

允许（通过扩展或代码片段）在登录后台办公时向用户显示弹窗消息。消息将在每次登录时显示，直到用户确认消息。

要提供您的消息，请扩展 `\AbstractWelcomePopupExtension` 类（它使用默认方法实现实现了 `\iWelcomePopupExtension`），并在 `GetMessages()` 方法中返回您的消息。

```php
use AbstractWelcomePopupExtension;
use utils;
use Combodo\iTop\Application\WelcomePopup\MessageFactory;

class MyTestProvider extends AbstractWelcomePopupExtension
{
    /**
     * @inheritDoc
     */
    public function GetMessages(): array
    {
        return [
            // 左侧标题和描述，右侧插图的文本消息
            MessageFactory::MakeForLeftTextsRightIllustration(
                // 提供者内消息的唯一 ID
                "fake_id_01",
                // 消息标题
                "Example 1",
                // 消息描述，可以包含 HTML
                "Some text to be displayed",
                // 插图的绝对 URI
                utils::GetAbsoluteUrlAppRoot() . "images/illustrations/undraw_relaunch_day.svg"
            ),

            // 左侧插图，右侧标题和描述的文本消息
            MessageFactory::MakeForLeftIllustrationRightTexts(
                "fake_id_02",
                "Example 2",
                "Some text to be displayed, but on the right",
                utils::GetAbsoluteUrlAppRoot() . "images/illustrations/undraw_relaunch_day.svg"
            ),

            // 完整 HTML 描述的消息
            MessageFactory::MakeForLeftTextsRightIllustration(
                "fake_id_03",
                "Example 3",
                <<<HTML
                    <div>
                        <p>Some content for the message</p>
                        <p>Some other content for the message</p>
                    </div>
HTML,
                utils::GetAbsoluteUrlAppRoot() . "images/illustrations/undraw_relaunch_day.svg"
            ),

            // 嵌入视频的消息
            MessageFactory::MakeForLeftTextsRightIllustration(
                "fake_id_03",
                "HTML with YouTube video",
                <<<HTML
<iframe width="560" height="315" src="https://www.youtube.com/embed/GCUdV7tHmEA?si=T6tcJFqobQ0TxLgo&amp;start=16" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
HTML
            ),
        ];
    }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:release:whats_new>

版本：3_2_0/release/whats_new.txt · Last modified: 2026/04/30 09:19 by 127.0.0.1
