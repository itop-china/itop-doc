
---
title: "定制化 iTop"
linkTitle: "定制化 iTop"
date: 2025-06-27
weight: 11
description: >
  介绍如何通过现有扩展或编写自定义扩展来定制 iTop。
---

{{% pageinfo %}}

iTop 可以通过两种方式定制：安装现有扩展，或编写自己的扩展模块。

{{% /pageinfo %}}

## 使用现有扩展

可以查看 [iTop 已发布扩展列表](../extensions/) 并按要求安装。

## 编写自己的扩展

创建 iTop 扩展模块的基础知识：

- 参考 [iTop 定制机制](./your-extension/datamodel/) 了解**如何扩展或修改 iTop**
- 从 [逐步示例：添加字段](./how-to/datamodel/add-attribute-sample/) 开始，创建你的第一个扩展

> 不要害怕编写第一个扩展，即使你不是开发者。许多定制可以在不写任何 PHP 代码的情况下完成。

- [创建新扩展的辅助工具](./your-extension/datamodel/#creating_your_own_extension) 和 [文件结构说明](./your-extension/new-extension/)
- 搜索和操作对象的 [API](./your-extension/api-objects-manipulation/)
- 使用 [CRUD 事件](./your-extension/events-crud/) 在对象上添加业务逻辑，事件遵循 [CRUD 序列](./your-extension/sequence-crud/)
- 添加自己的事件：[Events API](./your-extension/events-api/) - [方法与事件的对比](./your-extension/event/)
- 使用 [Interfaces API](./your-extension/extensions-api-interfaces/) 定制 GUI
- XML 语法参考：[XML 数据模型参考](./your-extension/xml-reference/) 和 [XML 门户参考](./how-to/portal/portal-xml/)
- PHP 代码规范：[iTop 编码标准](./your-extension/coding-standards/)
- 图标：[FontAwesome v5](https://fontawesome.com/v5/search?m=free)

> 在阅读下方示例之前，请先熟悉 [Wiki 语法/插入 XML 语法](./your-extension/insert-xml/)。

## "How to" 示例

### 修改数据模型

#### 类、字段与关系

- [属性的使用与限制](./how-to/datamodel/attribute-limitation/)
- [为 Server 类添加字段](./how-to/datamodel/add-attribute-sample/)
- [(重新)定义字典条目](./how-to/datamodel/add-dictionay-entry/)
- [强制字段始终必填](./how-to/datamodel/mandatory-field-always/)
- [从 Ticket 中移除字段](./how-to/datamodel/remove-field/)
- [在 Team 上添加仪表盘](./how-to/datamodel/add-dashboard-attribute/)
- [创建新的 CI 类：Monitor](./how-to/datamodel/add-class-sample/)
- [定义依赖关系](./how-to/datamodel/neighbours/)
- [添加 1:1 关系](./how-to/datamodel/one-to-one-relation/)
- [n:n 自反与对称关系](./how-to/datamodel/n-n-reflexive-relation/)
- [追踪对象创建者](./how-to/datamodel/tracking-creator/)
- [添加 n:n 关系](./how-to/datamodel/add-relation/)
- [合并状态](./how-to/datamodel/meta-enum/)
- [在 PHP 中添加 TagSet](./how-to/datamodel/add-value-to-tagset/)
- [在 PHP 中添加日志条目](./how-to/datamodel/add-log-entry/)
- [添加保密属性](./how-to/datamodel/confidential-attribute/)
- [额外的创建状态](./how-to/datamodel/create-in-different-states/)
- [LinkedSet 相关值](./how-to/datamodel/event-db-links-changed/)
- [隐藏转换](./how-to/datamodel/hide-transition/)
- [添加附件时记录日志](./how-to/datamodel/log-attachment/)
- [按条件强制字段必填](./how-to/datamodel/mandatory-field-on-condition/)
- [仅对子类强制字段必填](./how-to/datamodel/mandatory-field-subclass/)

#### 生命周期

- [添加状态和转换](./how-to/datamodel/add-state-transition/)
- [统计在某状态中花费的时间](./how-to/datamodel/add-state/)
- [状态延迟后通知](./how-to/datamodel/add-stopwatch/)
- [Stopwatch 的行为](./how-to/datamodel/add-state/#behavior_of_the_stopwatch)
- [为类添加生命周期](./how-to/datamodel/add-lifecycle/)
- [转换时字段必填](./how-to/datamodel/mandatory-on-transition/)
- [转换时执行动作](./how-to/datamodel/add-counter/)
- [转换方法](./how-to/datamodel/actions-on-transitions/)

#### 配置文件与安全

- [创建新配置文件](./how-to/datamodel/add-profile-sample/)
- [委派"管理员工具"菜单](./how-to/datamodel/delegate-rights/)
- [定义密码策略](./how-to/datamodel/password-policy/)
- [实现密码过期](./how-to/datamodel/password-expiration/)
- [新的认证方式](./how-to/datamodel/authentication/)
- [用户保护](./how-to/datamodel/user-protection/)

### 用户界面

- [强制字段必填](./how-to/user-interface/mandatory-field/)
- [强制字段只读](./how-to/user-interface/read-only-field/)
- [对特定用户隐藏成本](./how-to/user-interface/hide-field-on-profile/)
- [表单预填充](./how-to/user-interface/form-prefill/)
- [数据完整性检查](./how-to/user-interface/check-to-write/)
  - [使用事件](./how-to/user-interface/event-db-check-to-write/)
- [定义废弃规则](./how-to/user-interface/obsolescence/)
- [防止重复](./how-to/user-interface/uniqueness-rules/)
- [修改 iTop 首页](./how-to/user-interface/homepage/)
- [在弹出菜单中添加条目](./how-to/user-interface/add-menu-sample/)
- [iframe 仪表盘](./how-to/user-interface/add-dashlet-sample/)
- [丰富对象显示](./how-to/user-interface/display-bare-relation/)
- [区分同名对象](./how-to/user-interface/longname/)
- [修改页面标题](./how-to/user-interface/tab-title/)
- [对象间导航](./how-to/user-interface/nextobject/)
- [隐藏影响分析](./how-to/user-interface/hidetab/)
- [在列表上添加操作](./how-to/user-interface/bulk-edit-links/)
- [隐藏对象历史](./how-to/user-interface/hide-history/)
- [添加对象概览](./how-to/user-interface/summary-card/)
- [排序枚举值](./how-to/user-interface/order-enum/)
- [排序转换](./how-to/user-interface/order-transition/)
- [修改 iTop Logo](./how-to/user-interface/change-itop-logos/)
- [修改颜色等](./how-to/user-interface/color-overview/)
- [高亮关键对象](./how-to/user-interface/highlight-critical-objects/)
- [高亮状态](./how-to/user-interface/enum-colors/)
- [修改菜单图标](./how-to/user-interface/menu-icon/)
- [类颜色与图标](./how-to/user-interface/class-colors/)
- [修改左侧菜单颜色](./how-to/user-interface/change-menu-colors/)
- [修改主色调](./how-to/user-interface/change-main-color/)
- [创建主题](./how-to/user-interface/theme/)
- [在控制台中高亮状态](./how-to/user-interface/markup/)

### 自动化与工单管理

- [复制 n:n 对象](./how-to/automation/object-copier-linkedset/)
- [计算工单结束日期](./how-to/automation/compute-field/)
- [统计工单重开次数](./how-to/automation/count-ticket-reopening/)
- [级联更新](./how-to/automation/cascade-update/)
- [对 n:n 远程字段求和](./how-to/automation/cascade-update2/)
- [持久化统计 n:n](./how-to/automation/count-linkset-indirect/)
- [数据同步](./how-to/automation/synchronize-data/)
- [将工单传输到另一个 iTop](./how-to/automation/itop-webhook/)
- [存储 1:n 关系计数](./how-to/automation/count-linkset/)
- [添加生命周期状态](./how-to/automation/add-state/)
- [获取解决延迟](./how-to/automation/add-subitems/)
- [重开计数器](./how-to/automation/re-opening-counter/)
- [移除历史追踪](./how-to/automation/remove-history-tracking/)
- [延迟后自动关闭](./how-to/automation/auto-close/)
- [计划 TTO 开始](./how-to/automation/add-activation-delay/)
- [计划用户请求](./how-to/automation/add-activation-delay2/)
- [按服务子目录的 SLA](./how-to/automation/sla-service-subcategory/)
- [从父对象继承服务](./how-to/automation/service-heritage/)
- [按国家的假期 SLA](./how-to/automation/multiple-holiday-calendar/)
- [级联变更关闭](./how-to/automation/cascade-change-closure/)
- [SPOC 与合作伙伴](./how-to/automation/spoc/)
- [日志更新时重新分配工单](./how-to/automation/reassign-on-log-update/)

### 门户定制

- [门户定制概述](./how-to/portal/portal-overview/)
- [门户限制](./how-to/portal/portal-limitations/)
- [门户 XML 参考](./how-to/portal/portal-xml/)
- [门户字段必填](./how-to/portal/mandatory-in-portal/)
- [查看更多或更少的工单](./how-to/portal/portal-howto-change-scope/)
- [为他人创建工单](./how-to/portal/portal-howto-change-caller/)
- [修改范围](./how-to/portal/portal-howto-changescope/)
- [修改 Bootstrap 主题](./how-to/portal/portal-howto-changebstheme/)
- [修改菜单图标](./how-to/portal/portal-howto-changebrickicon/)
- [添加"创建"按钮](./how-to/portal/portal-howto-addbutton/)
- [添加新的浏览模式](./how-to/portal/portal-howto-addbrowsemode/)
- [添加 Dashlet](./how-to/portal/portal-howto-add-manage-extended-brick/)
- [创建新门户](./how-to/portal/new-portal/)
- [门户上的可选关系](./how-to/portal/portal-howto-dynamic-link/)
- [门户 - 在表单中定位附件](./how-to/portal/portal_howto_move_attachment/)
- [门户：为不同客户创建工单](./how-to/portal/portal_howto_ticket_multi_org/)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:start>

版本：3_2_0/customization/start.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
