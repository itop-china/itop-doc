---
title: "导入 LinkedSet"
linkTitle: "导入 LinkedSet"
date: 2025-06-27
weight: 8
description: "介绍如何在 iTop 中导入 n:n 关联集合（LinkedSet），包括 CSV 导入语法、高级选项及配置说明。"
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中导入 n:n 关联集合（LinkedSet）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:import_a_link_set)。
{{% /pageinfo %}}

## 什么是 LinkedSet？

LinkedSet 是一种表示相关对象列表的属性，在对象详情页中以标签页形式展示。LinkedSet 分为两种类型：

- **1:n** — 例如"位置上的设备"：一台设备只能位于**一个**位置，而一个位置可以容纳**多台**设备。
- **n:n** — 例如"团队的成员（人员）"：一个人可以属于**多个**团队，一个团队也由**多名**人员组成。

**只有 n:n 类型的 LinkedSet 可以被导入。** 你无法导入关联对象本身，它们必须已经存在于 iTop 中。

**示例**：`UserLocal` 具有属性 `profile_list`，该属性表示通过类 `lnkUserProfile` 附加到 `UserLocal` 对象上的权限列表。

## 何时可以导入关联集合？

以下所有数据输入功能都支持指定关联集合：

- 交互式 CSV 导入
- 命令行（CLI）导入
- 数据同步

## 示例：导入用户

以下示例展示如何在导入用户的同时，为其指定允许的组织（Allowed Organizations）和权限（Profiles）。这两个属性均为多对多关系：

- 假设需要为同一用户允许访问 3 个组织。
- 源文件中的每个组织可以通过其 **id**、**name** 或 **code** 来识别。
- 当加载类似"允许的组织"（Allowed Organizations）这样的 `AttributeLinkedSetIndirect` 时，所需字段来自 n:n 关系类（此处为 `URP_UserOrg`），这意味着你通常只能提供 `allowed_org_id`。
- 但一般情况下，对于 n:n 关系，你了解的可能是远程对象的某些字段值，而非其在 iTop 中的 id。此时，你可以使用远程对象的某个编码来指定，语法如下：
  - 关系类中指向远程对象的外部键（如 `allowed_org_id`）
  - 一个破折号后跟一个大于号：`->`
  - 远程对象的属性编码（如 `name`）
  - 一个冒号：`:`
  - 用于检索远程对象的值（如 `Demo`）
  - 一根竖线 `|`，用于分隔需要关联到同一用户的两个远程对象
  - 重复上述步骤

完整格式如下：

```
allowed_org_id->name:Demo|allowed_org_id->code:IT
```

- `allowed_org_id->id:4` **无效**！
- 请改用 `allowed_org_id:4`

在此示例中，我们结合使用了不同的方式来识别同一用户的多对多关系中的组织。虽然这种方式可行，但日常使用中可能并不常见。

```
Person->Email,Login,Language,Password,Profiles,Allowed Organizations
"monet@demo.com","portal","EN US",1234,"profileid->name:Portal user","allowed_org_id->code:IT|allowed_org_id->name:Demo|allowed_org_id:1"
```

## 高级选项

假设需要为用户指定一组权限，并为每个权限注明授予原因。该"原因"字段属于多对多关系类。

**首先，附加单个权限：**

```
profileid->name:Configuration Manager
```

权限通过类 `URP_UserProfile->profileid` 进行关联。此处指定了类 `URP_Profile` 的属性 `name` 必须匹配 "Configuration Manager"。

**现在，记录授予该权限的原因：**

```
profileid->name:Configuration Manager;reason:operations manager
```

**最后，为同一登录账号赋予另一个角色：**

```
profileid->name:Configuration Manager;reason:operations manager|profileid->name:Change Supervisor
```

每个链接都是独立指定的。

每个新的链接规范都必须以 `|` 开头。

如果需要指定的原因中包含被解析为分隔符的字符，可以用引号将整个属性规范包裹起来：

```
profileid->name:Configuration Manager;reason:operations manager|profileid->name:Change Supervisor;'reason:manager ;-)'
```

## 限制与已知问题

无。

## 配置

在配置文件中，可以修改以下参数：

| 配置项 | 说明 |
|--------|------|
| `link_set_item_separator` | 列表中两项之间的分隔符 |
| `link_set_attribute_separator` | 两个属性之间的分隔符 |
| `link_set_value_separator` | 属性名与值之间的分隔符 |
| `link_set_attribute_qualifier` | 整个属性的限定符 |

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:import_a_link_set>

版本：3_2_0/advancedtopics/import_a_link_set.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
