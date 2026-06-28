---
title: "同步故障排除"
linkTitle: "同步故障排除"
date: 2025-06-27
weight: 3
description: >
  <br> ➡️ 数据同步常见问题和解决方案
---

{{% pageinfo %}}

数据同步过程中的常见问题及解决方法。

{{% /pageinfo %}}

## 建议

### 选择 primary_key

使用每个值都唯一且稳定的 `primary_key` 至关重要。

- 确保**永远**不会有 2 个源对象共享相同的 `primary_key` 值。
- 确保源对象永远不会在源中修改其 `primary_key`。

`primary_key` 字段必须在源数据的**单列**中提供。如果要使用源字段的组合，请让源应用程序将它们连接成单个列。

### 协调属性

如何在源数据同步上选择**协调属性**：

- 如果源应用程序是该类的主控（iTop 中不能直接创建该类的对象），则使用 `primary_key` 进行协调，或者更准确地说，使用具有相同信息的列。将源应用程序的 `primary_key` 存储在 iTop 对象字段中可以大大简化未来的故障排除。在这种情况下，源数据必须在 2 个不同的列中复制 `primary_key` 列，第一个用作同步副本对象的 `primary_key`，另一个用于更新 iTop 对象字段。
- 否则，如果您选择可以在源中修改的 iTop 属性：这些**协调**属性**必须由数据同步更新并锁定**！仅当您确定它们在源中**无法修改**时才不需要。

## 内部处理

### 数据源导入

运行 `synchro_import.php` 或使用您自己的进程更新 `synchro_data_xxx` 表时，MySQL 会触发一些后台行为：

- 更新与 `synchro_data_xxx` 中每个更新行关联的 SynchroReplica 对象：`status_last_seen = now`，`status = 'modified'`
- 为 `synchro_data_xxx` 中每个创建的行创建 SynchroReplica 对象：`status_last_seen = now`，`status = 'new'`

### 同步数据

#### 处理未看到的副本

对于以下副本：

```sql
SELECT SynchroReplica 
WHERE sync_source_id = :source_id 
  AND STATUS IN ('new', 'synchronized', 'modified', 'orphan') 
  AND status_last_seen < (now – :full_load_interval)
```

更新 SynchroReplica：
- `status = 'obsolete'`
- 如果删除策略 = "更新" 或 "更新后删除"：使用更新规则更新 iTop 对象，更新 SynchroReplica 的 `info_last_modified = Now`

#### 处理新副本

对于每个状态为 'new' 的 SynchroReplica，我们在 iTop 中搜索与源行具有相同值的每个协调 = 'yes' 的数据同步属性的对象：

- 如果**未找到**对象（或多个匹配且"多个匹配时的操作" = "创建"）：我们创建一个新的 iTop 对象。如果创建成功，我们更新 SynchroReplica：`info_creation_date = now`，`dest_id = 刚创建对象的 id`，`status_dest_creator = 'yes'`，`status = 'synchronized'`。如果创建失败，我们更新 SynchroReplica：`status_last_error = 失败创建的错误消息`
- 如果找到**一个**对象（或多个匹配且"多个匹配时的操作" = "取第一个"）：更新 SynchroReplica：`dest_id = 检索到的对象的 id`，`status_dest_creator = 'no'`，`status = 'synchronized'`。更新 iTop 关联对象。如果成功，更新 SynchroReplica 的 `info_last_modified = now`。如果失败，更新 SynchroReplica 的 `status_last_warning = 失败更新的错误消息`
- 如果找到**多个**对象且"多个匹配时的操作" = "错误"：更新 SynchroReplica 的 `status_last_warning = "n 个目标对象匹配协调条件：xxxxxxxx"`

#### 处理更新的副本

对于每个状态为 "modified" 的 SynchroReplica：
- 更新 iTop 关联对象。如果成功，更新 SynchroReplica：`info_last_modified = now`，`status = 'synchronized'`。如果失败，更新 SynchroReplica：`status_last_warning = 失败更新的错误消息`

#### 处理过时的副本

对于每个应该应用删除策略的 'obsolete' 副本：

```sql
SELECT SynchroReplica 
WHERE sync_source_id = :source_id 
  AND STATUS IN ('obsolete') 
  AND status_last_seen < (now _ :retention_delay)
```

- 如果删除策略 = "更新" 或 "更新后删除"：删除 iTop 对象，删除对应的 SynchroReplica(s)，删除 `synchro_data_xxx` 表中对应的行

## 常见问题

### 非唯一 primary_key

如果源中多个对象共享相同的 primary_key，您将遇到严重麻烦。这些具有相同 primary_key 的各种对象都将更新同一个 iTop 对象。该 iTop 对象将在每次源对象更改时发生变化，而您不会理解原因。

### 非稳定 primary_key

为源数据选择的 `primary_key` 必须是稳定的，对于任何给定对象都永远不会改变。

#### 为什么 primary_key 不能在源中更改？

假设您有一个数据同步，用于 Person，其中您在源中提供了 `primary_key`（人员的电子邮件），但将协调键设置为：`name + firstname + org_id`。

- 您运行第一次同步：在源中，我们有一行 primary_key 为 `smith@biz.com` 的记录。此行创建一个新的 SynchroReplica，然后创建或更新一个具有该电子邮件的 iTop Person：Alex Smith。
- 稍后，在您的源应用程序中，人员的电子邮件由于某种原因从 `smith@biz.com` 更改为 `alex.smith@biz.com`，并启动同步：由于电子邮件是源的 'primary_key'，该新电子邮件在 `synchro_data_xxx` 源表中显示为新行，因此创建新的 SynchroReplica：`alex.smith@biz.com`。新的 SynchroReplica 映射到现有的 iTop Person：Alex Smith，并修改其电子邮件。旧的 SynchroReplica：`smith@biz.com` 不再在源中，并被标记为过时。它仍然映射到同一个 iTop Person：Alex Smith。
- 一些同步后，在删除策略过期延迟时：旧的过时 SynchroReplica：`smith@biz.com` 更新 iTop Person Alex Smith，例如将其状态设置为 inactive。与此同时，新的 SynchroReplica：`alex.smith@biz.com` 保持不变，因为源中没有任何变化，它不更新 iTop Person。
- 更多同步后，在保留持续时间过期时：旧的过时 SynchroReplica：`smith@biz.com` 删除 iTop Person Alex Smith。作为反作用，该删除同时删除了两个 SynchroReplica：`smith@biz.com` 和 `alex.smith@biz.com`。
- 随后的同步：重新创建 SynchroReplica：`alex.smith@biz.com`，并重新创建 iTop Person Alex Smith（假设数据同步可以创建 iTop 对象）。但之前 Alex Smith 的所有关系都丢失了，他创建的工单、他的团队等等...

#### 如果已经选择了错误的 primary_key 怎么办？

如果您已经使用 Person 电子邮件设置了数据同步，但后来注意到这是一个问题，因为您公司的电子邮件地址不稳定，并且正在产生上述问题。那么您考虑使用源应用程序 Person Id，这在您的世界中是一个稳定的值。它可能是稳定的，因为该源应用程序是处理您公司人员的主应用程序，每个新人员都在那里创建，每个更改都在那里进行。无论电子邮件更改、姓氏更改或组织更改如何，人员 id 都保持不变。

在这种情况下，创建一个新的数据同步源并删除前一个。

- 旧数据同步创建的对象不会被标记为由新数据同步创建，
- 因此这将防止数据同步删除对象。

### 未检索到的 ExternalKey

尝试使用包含提供的源信息的协调键字段检索远程 iTop 对象时，该搜索可能会失败，要么是因为没有匹配的对象，要么是因为有多个匹配的对象。如果 ExternalKey 是同步对象的必填字段，这将生成错误，否则只是警告，ExternalKey 将被清空。

```
Could not find [unique] object for 'manager_id': searched on friendlyname = 'Bob Smith'
```

### 无效的枚举值

如果对于同步对象的枚举属性，源提供了无效值，例如 "空字符串"，这**永远**不是有效的枚举值，那么根据枚举属性是否为必填项，您将获得警告或错误。

```
Unable to update destination object: Unexpected value for attribute 'status': Null not allowed: 
issues = {0=>Unexpected value for attribute 'status': Null not allowed}, class = Person, id = 14
```

### 大多数副本变为过时

如果您的数据同步突然似乎使所有副本都过时了，可能的根本原因是同步表上的 SQL 触发器不再存在。

- 对表的不同命令可以删除它们，
- 数据库的备份/恢复也可能丢失它们，如果执行备份的用户没有足够的权限。

要检查 MySQL 触发器是否仍然存在，请运行此 MySQL 命令：

```sql
show triggers like '%synchro_data_xxx%';
```

其中 `synchro_data_xxx` 是您的数据同步表的名称。

每个 synchro_data 表应该有 3 个触发器。如果它们消失了，请参阅下面的提示来修复。

## 提示

### 恢复 MySQL 触发器

如果触发器丢失，可以通过重新保存数据源来重新创建它们。在 iTop 中打开数据源，点击"修改"，然后直接点击"应用"（无需进行任何更改）。这将触发 iTop 重新创建缺失的触发器。

### 删除数据同步

不建议删除数据同步并从头创建一个新的，特别是如果您的数据同步预期会删除 iTop 对象（现在或将来），因为此功能将会丢失。新的数据同步不会删除您在重新创建数据同步当天 iTop 中已经存在的对象。

如果不是这种情况，没有重大后果，只是在删除和新创建的同步上执行 synchro_import 之间的期间，某些用户可能已经修改了 iTop 对象，因为它们不再被锁定，对于同步锁定的字段，他们的更改将被覆盖，因此没有数据问题，只是用户体验有些奇怪...

```sql
DELETE FROM priv_sync_datasource WHERE id= x;
DELETE FROM priv_sync_replica where sync_source_id=x;
DELETE FROM priv_sync_log where sync_source_id=x;
DELETE FROM priv_sync_att_linkset where sync_source_id=x;
DELETE FROM priv_sync_att_extkey where sync_source_id=x;
DELETE FROM priv_sync_att where sync_source_id=x;
DROP table synchro_data_xxx;
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:data_synchronization-troubleshooting>

版本：3_2_0/advancedtopics/data_synchronization-troubleshooting.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
