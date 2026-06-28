
---
title: "管理员指南"
linkTitle: "管理员指南"
date: 2025-06-26
weight: 5
description: >
  本文档面向负责配置和运维 iTop 应用的系统管理员。
---

## 目标读者

本文档面向系统管理员。最终用户请参考 [最终用户手册](../enduser/)。

### 前提条件

至少具备 MySQL 或 **SQL** 的基本知识。

## 管理菜单

- [用户账号和配置文件](./01-managing_user_accounts/)：管理用户、配置文件和权限
  - [忘记密码](./01-managing_user_accounts/forgot_password/)
  - [密码复杂度策略](./01-managing_user_accounts/password-policy/)
- [用户认证选项](./user_authentication_options/)：登录类型、Basic 认证、LDAP/CAS 集成
- [使用 iTop](./using_itop/)：登录与主界面导航
- [审计 CMDB](./02-audit/)：使用 OQL 审计规则检查数据一致性
- [运行对象查询](./03-objects_queries/)：执行 OQL 查询
  - [OQL](./03-objects_queries/oql/)：对象查询语言
- [查询手册](./04-phrasebook/)：保存和管理常用 OQL 查询
- [导出数据](./export/)：通过 OQL 查询导出数据
- [浏览数据模型](./05-browsing_the_data_model/)：查看类、属性、关系和生命周期

## 配置菜单

- [通用配置](./06-configuration_editor/)：在线编辑 iTop 配置文件
  - [配置参数](./06-configuration_editor/configuration-parameters/)：iTop 配置文件的完整参数参考
- [同步数据源](./synchronize-data/)：将 iTop 对象与外部数据源对齐
- [通知](./10-notifications/)：基于触发器的自动通知
  - [通知配置示例](./10-notifications/notifications-step-by-step/)
  - [多语言通知](./10-notifications/notif-multi-language/) 🚧
  - [通知占位符](./10-notifications/placeholders/)

## 系统菜单

- [数据库完整性](./11-database-tools/)：检查数据库一致性
- [数据备份](./12-backup/)：GUI、计划任务、CLI 和手动备份
- [应用升级](./13-core-update/)：通过浏览器升级 iTop

## 管理员技巧

- [新闻中心](./21-newsroom/)：向后台用户推送消息
- [委派管理员工具](./delegate-admin-tools/)：将部分管理员菜单委派给其他用户
- [设置 iTop 为只读](./08-settings/)：进入维护/只读模式
- [防止并发修改](./09-locking/)：对象并发编辑锁定
- [调度后台任务](./14-cron/)：配置 cron.php 定期维护
- [调优 iTop 性能](./16-performance/)：性能优化建议
- [安全最佳实践](./security-best-practices/)：安装和运维安全建议
- [管理个人数据](./19-rgpd/)：GDPR 合规提示
- [归档](./archiving/)：对象归档机制
- [对象废弃](./object-obsolescence/)：对象生命周期中的废弃状态
- [iTop 日志](./18-log/)：日志位置和配置
- [HTML 格式限制](./html-formatting-limitations/)：富文本字段支持的 HTML

## 相关章节

以下功能在管理员工作中经常被引用，详细文档请查看对应章节：

- **[数据同步](../integration/02-data_synchronization/)**：将 iTop 对象与外部数据源对齐（先看[概述](../integration/01-data_synchro_overview/)）
- **[导出数据](../integration/04-export-data/)**：export-v2.php 命令行和远程导出
- **[CLI 数据导入](../integration/05-importcli/)**：通过 CSV 文件批量导入
- **[REST/JSON API](../integration/06-rest_json/)**：通过 HTTP 操作 iTop 数据
- **[Nagios 集成](../integration/08-nagios/)**：监控数据同步
- **[LDAP 人员同步](../integration/09-synchro_howto_personsfromldap/)**：从 LDAP 目录同步人员

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:start>

版本：3_2_0/admin/start.txt · Last modified: 2025/01/23 11:42 by 127.0.0.1
