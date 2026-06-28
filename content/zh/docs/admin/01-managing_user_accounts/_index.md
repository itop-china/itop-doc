
---
title: "用户账号和配置文件"
linkTitle: "管理：用户&配置文件"
date: 2025-06-27
weight: 10
description: >
  管理用户账号、分配配置文件和权限控制。
---

{{% pageinfo %}}

iTop 提供了用户管理模块，允许管理员为用户分配一个（或多个）预定义的配置文件。配置文件的组合决定了每个用户在 iTop 中被允许执行的操作（查看、创建/修改或删除哪些对象）。

在当前版本的 iTop 中，配置文件是预定义的；没有用户界面来修改它们或创建新配置文件。

{{% /pageinfo %}}

## 查看配置文件

使用"管理工具 / 配置文件"菜单访问配置文件：

![配置文件列表](https://www.itophub.io/wiki/media?w=600&tok=289d99&media=3_2_0:admin:profil-list.png)

当点击某个配置文件时，会显示该配置文件的详细信息：

- "用户"选项卡列出拥有此配置文件的所有用户
- "授权矩阵"选项卡显示每个对象类别的允许操作

### iTop 核心配置文件

| ID | 配置文件 | 描述 |
|---|---|---|
| 1 | Administrator | 拥有所有权限（绕过任何控制） |
| 2 | Portal user | 有权访问用户门户。拥有此配置文件的用户无法访问标准应用，将自动重定向到用户门户 |
| 3 | Configuration Manager | 负责管理配置项文档的人员 |
| 4 | Service Desk Agent | 负责创建事件报告的人员 |
| 5 | Support Agent | 分析和解决当前事件的人员 |
| 6 | Problem Manager | 分析和解决当前问题的人员 |
| 7 | Change Implementor | 执行变更的人员 |
| 8 | Change Supervisor | 负责整体变更执行的人员 |
| 9 | Change Approver | 可能受某些变更影响的人员 |
| 10 | Service Manager | 负责向（内部）客户交付服务的人员 |
| 11 | Document author | 任何可能为文档做出贡献的人员 |
| 12 | Portal power user | 2.0.1 新增。拥有此配置文件的用户有权在门户中查看客户的所有工单。必须与其他配置文件（如 Portal User）配合使用 |
| 117 | SuperUser | 拥有除管理员专属权限外的所有权限 — iTop 3.2.1 引入 |
| 1024 | REST Services User | 2.5.0 新增。有权访问 REST Web 服务的用户账号。如果配置设置 `secure_rest_services` 设为 `true`（默认值），则只有拥有此配置文件的用户账号才能使用 REST Web 服务 |

### 扩展配置文件

| ID | 配置文件 | 关联权限 | 扩展 |
|---|---|---|---|
| 20 | Hostmaster | 处理 IP 空间和监控 IP 变更的人员 | IPAM for iTop |
| 21 | IP Helpdesk agent | 处理 IP 请求的人员 | IP Request Management |
| 22 | IP Portal user | 有权访问 IP 门户，在控制台被拒绝 | IPAM for iTop |
| 40 | Business partner user | 有权访问业务合作伙伴门户，在控制台被拒绝 | Portal for Business Partner |
| 43 | User Manager | 有权创建/修改/删除用户... | Admin tools delegation(1/2) |
| 44 | Notification Manager | 有权创建和修改触发器和操作 | Admin tools delegation |
| 45 | Audit Manager | 有权创建和修改审计（类别和规则） | Admin tools delegation |
| 46 | Query Manager | 有权创建和修改查询手册 | Admin tools delegation |
| 47 | SynchroData Manager | 有权创建和修改同步数据源 | Admin tools delegation |
| 48 | Admin Tools Manager | 有权执行上述所有操作 | Admin tools delegation |
| 49 | Time Tracker | 有权跟踪自己的时间 | Time Tracking |
| 50 | Time Tracking Manager | 有权跟踪他人的时间并访问任何人跟踪的时间 | Time Tracking |
| 51 | Archiving Agent | 有权定义归档规则 | Data archiver |
| 52 | Anonymization Agent | 有权匿名化人员 | Personal data anonymizer |
| 107 | Communication Manager | 有权管理通信 | Communications to the Customers |
| 120 | Query History | 拥有所有权限，但查询历史（CMDBChange）除外 | Admin tools delegation(2/2) |
| 121 | Mail Inbox Manager | 有权创建/修改邮件收件箱和 OAuth 客户端 | Mail to Ticket Automation |
| 122 | Mail Messages Manager | 有权查看、修改和删除邮件消息并读取邮件收件箱 | Mail to Ticket Automation |
| 130 | Ansible Manager | 负责 iTop 中 Ansible 文档并有权执行 Ansible 专用 REST Web 服务 | Data model for Ansible |
| 160 | Release Agent | 负责开发新功能或解决软件/产品缺陷 | Software and Release management |
| 161 | Product Owner | 负责产品（测试和增强） | Software and Release management |
| 162 | Release Manager | 负责发布流程（验收测试、CAB、早期支持） | Software and Release management |
| 170 | VCS Manager | 负责版本控制系统管理 | VCS Integration |
| 800 | Alarms Manager | 允许确认警报而不创建工单 | Alarm Console |
| 1025 | Project Manager | 处理项目/风险/问题/WBS | Project Management Extended |
| 5323 | CMDB Guest | 对 CMDB 和 IP 对象（仅）拥有只读权限（不允许批量读取） | IPAM for iTop |
| 5324 | Hostmaster - DNS | 处理 DNS 空间 | DNS Zone Management |
| 5325 | DHCP Manager | 处理 DHCP 空间 | DHCP Management |
| 5326 | IP Portal Automation user | 有资格自动处理其 IP 请求。必须与 "IP Portal user" 配置文件配合使用 | IP Request Management |
| 5327 | Network Security Manager | 负责网络安全。必须与 "Configuration Manager" 配置文件配合使用 | Network Management Extended |
| 5328 | Phone Numbers Manager | 负责电话号码空间 | Phone Number Management |

## 查看用户账号

"管理工具"模块下的"用户账号"菜单，可以查看为 iTop 实例定义的所有登录账号。

点击某个用户时，会显示以下详细信息：

用户账号必须关联到 CMDB 中存储的一个**人员**（请参阅 CMDB 模块文档）。在创建登录账号之前，请确保该用户已在 CMDB 中作为**人员**记录。

如果登录账号没有定义联系人，则该登录账号将受到若干限制（列表非详尽）：

- 无法接收邮件通知。例如：为客户 x 创建了工单
- 无法对某事负责。例如：作为工单分配到的代理
- 无法访问客户门户

"配置文件"选项卡列出与此用户关联的所有配置文件。"授权矩阵"选项卡显示允许给此用户的权限。它是所有关联配置文件对应权限的合并。"允许的组织"选项卡显示允许此用户查看的组织列表。

## 创建用户

要创建新用户，只需在操作下拉列表中点击"新建"，无论是从用户列表还是给定用户的详情页面。随后会出现以下向导：

管理员可以根据所需的认证类型定义不同类型的用户账号：

- **iTop 用户**：账号在 iTop 内部管理。密码存储（加密）在 iTop 的数据库中。此类型适用于管理用户、脚本以及与其他应用的集成。
- **LDAP 用户**：认证由外部 LDAP 或 Active Directory 服务器完成。
- **外部用户**：认证由 Web 服务器直接管理，例如使用 Apache .htaccess 文件或外部单点登录解决方案（如 JASIG-CAS）。

iTop 中所有关于认证的详细信息都在[用户认证选项](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)章节中描述。

如果决定创建 **iTop 用户**，必须输入密码并再次输入以确认。如果两次密码不匹配，密码字段右侧会显示感叹号。

如需实现密码续期策略，请遵循[相关指南](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)。

用户记录定义：

- 该用户的首选语言，用于显示 iTop 用户界面
- 与此用户账号关联的联系人。对于门户用户，此联系人还用于确定门户的默认组织
- 此账号的配置文件列表。每个 iTop 用户账号必须至少有一个配置文件

"添加配置文件..."按钮显示搜索窗口，用于选择要分配给用户的配置文件。分配的配置文件可以在稍后使用用户的"修改"操作进行更改。

## 批量导入登录账号

要批量创建多个登录账号，可以使用 CSV 导入工具。

检查[批量导入关系格式](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)。

可以参考[此示例](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)，该示例用于 CLI 导入，但 CSV 导入格式相同。

### 限制对一组组织的访问

管理员可以为每个用户定义允许其访问的组织列表，使用"允许的组织"选项卡。如果未选择任何组织，则允许该用户查看所有组织。

在组织层级结构的情况下（某些组织有父组织），权限从父组织继承到子组织。换句话说，如果用户有权访问父组织，则该用户也有权访问该组织的所有子组织。

属于禁止访问的组织的所有对象对给定用户完全隐藏。对于该用户，应用程序的行为就好像这些对象不存在一样。

选定的组织可以在稍后使用用户的"修改"操作进行更改。

### 更改用户密码

管理员可以在需要时通过使用用户的"修改"操作来更改用户密码。这对于重置用户密码很有用。

用户可以通过点击"注销"菜单并选择"更改密码..."来更改自己的密码。

### 忘记密码

拥有 **iTop 用户** 类型账号的用户可以自行重置密码：无需管理员进行任何操作。

更多信息请参阅[忘记密码](./forgot_password/)章节。

### 停用账号

从 **iTop 2.3.0** 开始，用户账号上新增了一个"状态"字段。"状态"有两个可能的值："启用"或"禁用"。设置为"禁用"时，账号被停用，用户无法再连接到 iTop。默认值为**启用**。

## 委派给非管理员

可以将用户管理委派给没有管理员配置文件的用户：[委派"管理工具"菜单](../delegate-admin-tools/)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:managing_user_accounts>

Last modified: 2025/03/10 10:24 by127.0.0.1

版本：3_2_0/admin/managing_user_accounts.txt · Last modified: 2026/06/26 11:13 by 127.0.0.1
