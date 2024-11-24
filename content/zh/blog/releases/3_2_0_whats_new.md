
---
title: "iTop 3.2.0 新特性"
linkTitle: "iTop 3.2.0 新特性"
date: 2024-11-24
description: >
  
---


## iTop 3.2 社区版

*   3.2.0 Beta 版本发布日期：_2024年6月_
    
*   3.2.0 发布日期： _2024年 9月_
    
*   [下载链接](https://sourceforge.net/projects/itop/files/itop/3.2.0/ "https://sourceforge.net/projects/itop/files/itop/3.2.0/")

*   iTop变更历史列表：[累积的变更日志](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log "3_2_0:release:change_log")
    
*   升级前须知： [迁移说明](https://www.itophub.io/wiki/page?id=3_2_0:install:migration_notes "3_2_0:install:migration_notes")

*   开发者迁移须知： [迁移扩展到3.2](https://www.itophub.io/wiki/page?id=3_2_0:release:developer "3_2_0:release:developer")
    
*   [Combodo 3.2 适配的插件版本 ](https://www.itophub.io/wiki/page?id=3_2_0:release:extensions "3_1_0:release:extensions")

# iTop 社区版新特性

## 对于用户

### 消息

现有的 [消息空间](https://www.itophub.io/wiki/page?id=3_2_0:feature:newsroom "3_2_0:feature:newsroom") 功能已扩展到所有 iTop 后台用户。之前该功能仅限于 iTop 管理员和外部消息提供者，如 iTop Hub。

从这一版本开始，iTop 成为一个 **消息提供者**，这意味着当 iTop 中发生某些事件时，它可以向目标用户发送消息。

这一功能使用了现有的触发器-动作机制。新增的  `动作通知`  类型允许发送 **消息**，可以替代或与电子邮件并行发送。

1.  消息会显示给目标 iTop 用户，在 iTop 后台中，通过铃铛图标展示。

2. 铃铛上的红点会通知用户有未读的消息。

3.  当用户点击其中一条消息时，它会打开动作中指定的 URL，一般是触发该消息的对象。消息会自动标记为已读，并附上日期。

<img src="https://www.itophub.io/wiki/media?media=3_2_0:release:newsroom-bell-empty.png" width="30%" height="25%"/>
<img src="https://www.itophub.io/wiki/media?media=3_2_0:release:newsroom-bell-one-message.png" width="30%" height="35%"/>
<img src="https://www.itophub.io/wiki/media?media=3_2_0:release:newsroom-url-result.png" width="30%" height="35%"/>

&nbsp;

用户可以查看所有收到的消息，并逐一或批量处理：

+   用户可以标记消息为已读或未读。

+   用户可以删除消息。

+   无论是否已读，消息都会在经过 iTop 配置的保留时间后自动删除，默认保留为 60 天。

这些消息通知只能发送给有权限访问 iTop 后台的用户。


### 通知中心
后台用户现在可以 **[取消订阅](https://www.itophub.io/wiki/page?id=3_2_0:feature:newsroom#unsubscribe_to_notifications "3_2_0:feature:newsroom")** 特定的通知。

[![](https://www.itophub.io/wiki/media?w=900&tok=3fa931&media=3_2_0:feature:newsroom-notifications-center.png)](https://www.itophub.io/wiki/media?media=3_2_0:feature:newsroom-notifications-center.png "3_2_0:feature:newsroom-notifications-center.png")

我们这里所说的 `通知`，是指特定触发器和动作的组合。

+   举例：管理员可能已经配置了
    
    +   针对日志更新的触发器，通过电子邮件和消息通知工程师。
        
    +   以及另一个针对位置创建的触发器，通过消息通知某些人。
        
+   在这种情况下，工程师将能够：
    
    +   **在邮件和消息之间选择** 对于第一个触发器，如果触发器允许，甚至可以取消订阅所有通知。
        
    +   **取消订阅** 位置创建触发器的消息，如果对他没有用处的话。
        

*限制* 配置触发器和动作的人员可以限制用户取消订阅的权限：

+   对于 `对象提及时` 触发器, 通常希望禁止用户取消订阅  **所有** 通道，他们必须至少保留一个通道，以确保他们收到通知。

+   对于某些动作，如日历邀请、未经认证的表单等，用户不允许取消订阅。

+   用户 **只能** 对于可接收到至少一个通知事件的通知动作取消订阅。

+   用户只能对直接发送给链接到他们用户关联的联系人（如电子邮件和消息）的动作取消订阅，而不能取消订阅 Rocket、Teams 等其他通知通道。
    

### HTML文本编辑器

iTop 使用了一个外部提供的工具，叫做 CKEditor，出于维护和安全原因，这个工具需要升级。新版本与之前的版本有很大不同，大部分编辑功能得到了保留，并且有不同的图标，部分功能丢失，新增了一些功能。

| 新的HTML编辑器工具栏 |
| --- |
| [![](https://www.itophub.io/wiki/media?w=900&tok=05cf1a&media=3_2_0:release:ckeditor-5-toolbar.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:ckeditor-5-toolbar.png "3_2_0:release:ckeditor-5-toolbar.png") |

| 在新工具栏中找回以前的功能 |
| --- |
| [![](https://www.itophub.io/wiki/media?w=1000&tok=b34780&media=3_2_0:release:ckeditor-4-to-5.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:ckeditor-4-to-5.png "3_2_0:release:ckeditor-4-to-5.png") |

这个新版本的编辑器在格式化表格方面比以前更强大，但和任何新版本一样，使用它需要一些时间来适应。

#### 提示与技巧

+   如何退出嵌入代码的部分？按三次“Enter”键。

+   当你将之前的工单日志复制粘贴到新的工单日志中时，背景颜色会保留，这样很难去掉。为了避免这种情况，可以使用快捷键 Ctrl+Shift+V，只粘贴纯文本而不带格式。如果你熟悉 HTML，可以点击 **源代码** 按钮，直接编辑 HTML 代码并去掉 `div` 标签。

### 新的控制台主题

为了确保 iTop 的可访问性，我们的团队为后台开发了新的主题。这些主题符合 WCAG 标准，专为视觉障碍用户设计，使他们更容易使用该解决方案： 

[![](https://www.itophub.io/wiki/media?w=250&tok=ca6553&media=3_2_0:release:console-themes-wcag.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:console-themes-wcag.png "3_2_0:release:console-themes-wcag.png")

+   色盲主题：专为色盲用户设计，实际上分为两种子主题，以适应特定情况：
    
    +   一种适应红绿色盲和绿黄色盲（protanopia & deuteranopia）
        
    +   另一种适应蓝黄色盲（tritanopia）

+   高对比度主题：增强对比度，帮助用户更容易地区分屏幕上的不同元素。对于色盲以外的低视力用户也有帮助。
    

### 欢迎弹出窗口

Combodo 和 iTop 扩展的编辑者现在可以决定向某些用户（通常是管理员，也可以是所有用户）显示与新版本相关的消息。

+   在 iTop 升级后，用户首次登录时可能会看到多个消息
    
+   这些消息一旦被用户确认后，将不再显示
    
+   在 iTop 3.2 中，所有用户会看到四条消息，只有 iTop 管理员会看到一条专门的消息
    
[![](https://www.itophub.io/wiki/media?w=800&tok=daa51b&media=3_2_0:release:welcome-popup-api-overview.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:welcome-popup-api-overview.png "3_2_0:release:welcome-popup-api-overview.png")

按钮的行为：

+   稍后提醒我：将在下次登录 iTop 时再次显示所有消息
    
+   下一步：确认当前消息已读并显示下一条消息（如果是最后一条，则关闭窗口）
    
+   点击弹窗外的区域，将关闭弹窗，下次登录 iTop 时未确认的消息将再次显示
    
### 新的门户搜索

在终端用户门户中默认添加了一个搜索框，允许用户检索他们的工单，无论其状态如何。

[![](https://www.itophub.io/wiki/media?w=800&tok=5b6a91&media=3_2_0:release:portal-search-brick.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:portal-search-brick.png "3_2_0:release:portal-search-brick.png")

## 对于管理员

### 数据模型访问

在控制台显示的任何 iTop 对象的类标签，管理员可以点击该标签，跳转到该类的数据库模型页面。

### 通知

围绕 [通知](https://www.itophub.io/wiki/page?id=3_2_0:admin:notifications "3_2_0:admin:notifications") 做了多项改进，主要包括以下内容：

#### 消息空间

此版本带来了一个新的操作，通过[消息](https://www.itophub.io/wiki/page?id=3_2_0:feature:newsroom "3_2_0:feature:newsroom")通知后台用户。

+   该操作可以通过任何触发器触发。

+   开箱即用，通过 *消息通知* 操作会自动创建， [查看详细信息](https://www.itophub.io/wiki/page?id=3_2_0:install:migration_notes#connect_news "3_2_0:install:migration_notes")：
    
    +   一个方面，用于向任何在 iTop 对象中被提及的人发送消息（*iTop 会检索任何已存在的 `被提及触发器` 并将其与新的操作关联*）
        
    +   一个方面，用于通知工单的工程师，但这个操作没有链接到任何触发器，它只是一个示例
        
+   触发该操作将为每个拥有关联活跃用户的收件人生成一条消息
    

#### 异步操作

大多数操作都新增了一个 *异步* 字段，用于指定是否应立即触发并在未完成时阻止用户，或者在后台执行，或者遵循全局的 iTop 设置。

#### 订阅策略

触发器现在可以定义是否允许用户取消订阅 **所有** 通信渠道、**除了一个** 或 **没有**，默认设置是 *允许完全取消订阅*。

对于像 `对象体积是` 和 `审批请求时` 这样的触发器，最好更改此设置。

#### 操作中的最后执行记录

在操作对象中添加了一个新的 Ajax 标签（*以异步方式显示，作为仪表盘属性*）: `最后执行`。

它将显示该特定操作的日志。默认情况下，显示 61 天的记录，但可以通过 `notifications.last_executions_days` [配置参数](https://www.itophub.io/wiki/page?id=3_2_0:admin:itop_configuration_file#m-n "3_2_0:admin:itop_configuration_file")进行修改

[![](https://www.itophub.io/wiki/media?w=700&tok=74b14a&media=3_2_0:release:last_executions.png)](https://www.itophub.io/wiki/media?media=3_2_0:release:last_executions.png "3_2_0:release:last_executions.png")

#### 类标签重命名

为了更清楚地区分 **操作（Action）**（指定如何执行特定操作）和 **事件（Event）**（表示操作执行结果），我们已经重新命名了大多数属于 Action 和 Event 的类。

## 对于开发者

### 新的事件

在3.2.0中，增加和移除了一些事件

*移除*

+   EVENT\_DB\_BEFORE\_APPLY\_STIMULUS
    
+   EVENT\_DB\_AFTER\_APPLY\_STIMULUS
    
+   EVENT\_DB\_APPLY\_STIMULUS\_FAILED
    

*增加*

+   EVENT\_DB\_ABOUT\_TO\_DELETE: 删除已确认并将发生。对象及其关系仍可在数据库中用于 OQL 查询和 Get('att\_code')
    
+   EVENT\_ENUM\_TRANSITIONS: 管理当前对象状态中允许的转换。唯一允许的操作是使用 $this→DenyTransition($sTransitionCode) 拒绝转换。
    
### 新的API

#### \\iBackupExtraFilesExtension

允许（通过扩展或代码片段）指定额外的文件和目录，与标准文件（配置文件、数据库备份等）一起添加到 iTop 备份归档中。

[Example](https://www.itophub.io/wiki/page?do=export_code&id=3_2_0:release:whats_new&codeblock=0 "Download Snippet")

```php
class MyFilesToAddToBackupArchive implements \iBackupExtraFilesExtension
{
        public function GetExtraFilesRelPaths(): array
        {
                return [
                        // A file saved in the data folder
                        'data/file1.txt',
                        // A file saved in a module in the current environment ("production" most of the time)
                        'env-'.\utils::GetCurrentEnvironment().'/some-module/file2.txt',
                        // A file from the log folder
                        'log/file3.txt',
                ];
        }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:release:whats_new#new_apis>

版本：3_2_0/release/whats_new.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1