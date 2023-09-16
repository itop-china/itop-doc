
---
title: "iTop 3.1.0 新特性"
linkTitle: "iTop 3.1.0 新特性"
date: 2023-09-16
description: >
  
---


## iTop 3.0 社区版

*   3.1.0 Beta 版本发布日期：_2023年6月_
    
*   3.1.0 发布日期： _2023年 8月_
    
*   [下载链接](https://sourceforge.net/projects/itop/files/itop/3.0.0/ "https://sourceforge.net/projects/itop/files/itop/3.1.0/")
    
*   升级须知： [迁移说明](https://www.itophub.io/wiki/page?id=3_1_0:install:migration_notes "3_1_0:install:migration_notes")

*   开发者迁移须知： [迁移扩展到3.1](https://www.itophub.io/wiki/page?id=3_1_0:release:developer "3_1_0:release:developer")
    
*   iTop变更历史列表：[累积的变更日志](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log "3_1_0:release:change_log")
    
*   [3.0.0 版本 已知问题 ](https://www.itophub.io/wiki/page?id=3_1_0:release:beta-known-issues "3_1_0:release:beta-known-issues")列表

# iTop 社区版新特性

<table class="inline"><tbody><tr class="row0"><td class="col0 centeralign">这个版本专注于改进iTop后端控制台的用户体验。</td></tr></tbody></table>

* * *

## 同义词区分

### 摘要卡片

有时，仅仅通过对象的名称并不能够清晰地识别，这种情况下，将鼠标悬停在该对象的名称上，停留一段时间，那么，会在弹出窗口中会显示有关该对象的更多信息，并有可能直接在全屏模式下编辑该对象。

#### 人员

[![ ](https://www.itophub.io/wiki/media?w=500&tok=f6e2a3&media=3_1_0:release:overcard-popup-person.png " ")](https://www.itophub.io/wiki/media?media=3_1_0:release:overcard-popup-person.png "3_1_0:release:overcard-popup-person.png")

Multiple other classes do have a summary by default, [more details](https://www.itophub.io/wiki/page?id=3_1_0:feature:overcard#summary_card "3_1_0:feature:overcard").  
You can add a [summary](https://www.itophub.io/wiki/page?id=3_1_0:customization:xml_reference#presentation "3_1_0:customization:xml_reference") on your own classes as well…

许多其他的类默认情况下都有摘要，[更多详情](https://www.itophub.io/wiki/page?id=3_1_0:feature:overcard#summary_card "3_1_0:feature:overcard")。  
你也可以在自定义的类上添加[摘要](https://www.itophub.io/wiki/page?id=3_1_0:customization:xml_reference#presentation "3_1_0:customization:xml_reference")…

### 补充名称

在下拉列表中选择对象时会非常有用：

- 人员（电子邮件 + 组织名称） [![](https://www.itophub.io/wiki/media?w=600&tok=44b387&media=3_1_0:release:complementary-name-person.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:complementary-name-person.png "3_1_0:release:complementary-name-person.png")

- 触发器（类别，附加信息） [![](https://www.itophub.io/wiki/media?w=600&tok=e4906c&media=3_1_0:release:complementary-name-trigger.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:complementary-name-trigger.png "3_1_0:release:complementary-name-trigger.png")

许多其他类别也具有补充名称，[更多详情](https://www.itophub.io/wiki/page?id=3_1_0:feature:overcard#complementary_name "3_1_0:feature:overcard")。

## 关系

我们简化了创建、添加、修改、移除和删除相关对象的方式，提供这些操作而无需编辑当前对象。

### 1:n 视图模式

如果用户拥有权限，他们可以在详细信息视图中添加和删除子对象，而无需编辑当前对象本身。

以工单为例，用户可以在工单上创建、修改或删除相关联的工作任务。

*   创建
    

[![](https://www.itophub.io/wiki/media?w=600&tok=b4ef1a&media=3_1_0:release:relation-read-ticket-add-workorder.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-add-workorder.png "3_1_0:release:relation-read-ticket-add-workorder.png") 

[![](https://www.itophub.io/wiki/media?w=400&tok=425b01&media=3_1_0:release:relation-read-ticket-add-workorder-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-add-workorder-popup.png "3_1_0:release:relation-read-ticket-add-workorder-popup.png")

*   修改
    

[![](https://www.itophub.io/wiki/media?w=600&tok=610c30&media=3_1_0:release:relation-read-ticket-modify-workorder.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-modify-workorder.png "3_1_0:release:relation-read-ticket-modify-workorder.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=d50393&media=3_1_0:release:relation-read-ticket-modify-workorder-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-modify-workorder-popup.png "3_1_0:release:relation-read-ticket-modify-workorder-popup.png")

*   删除
    

[![](https://www.itophub.io/wiki/media?w=600&tok=ad2cb7&media=3_1_0:release:relation-read-ticket-delete-workorder.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-delete-workorder.png "3_1_0:release:relation-read-ticket-delete-workorder.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=4f9220&media=3_1_0:release:relation-read-ticket-delete-workorder-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-ticket-delete-workorder-popup.png "3_1_0:release:relation-read-ticket-delete-workorder-popup.png")

只要用户允许编辑和删除工作任务，不管是否允许修改用户请求，上述操作对他都将是可用的。

### n:n 视图模式

It's now possible to add and remove related objects from the details view, without editing the current object it-self, which means that a user can do it even if he is not allowed to modify the current object, as long as he is explicitly allowed to modify the relationship or at least the remote class.

现在可以在详细视图中添加和删除关联对象，而无需编辑当前对象本身。这意味着，只要用户明确允许修改关系或至少远程类，即使不允许修改当前对象，他也可以执行这些操作。

以团队为例，我们希望：

*   添加一个人员，
    

[![](https://www.itophub.io/wiki/media?w=600&tok=2d4126&media=3_1_0:release:relation-read-team-add-person.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-add-person.png "3_1_0:release:relation-read-team-add-person.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=06330d&media=3_1_0:release:relation-read-team-add-person-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-add-person-popup.png "3_1_0:release:relation-read-team-add-person-popup.png")

*   修改角色
    

[![](https://www.itophub.io/wiki/media?w=600&tok=b61fe8&media=3_1_0:release:relation-read-team-modify-person.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-modify-person.png "3_1_0:release:relation-read-team-modify-person.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=42f615&media=3_1_0:release:relation-read-team-modify-person-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-modify-person-popup.png "3_1_0:release:relation-read-team-modify-person-popup.png")

*   或者从团队中移除
    

[![](https://www.itophub.io/wiki/media?w=600&tok=6a0ca4&media=3_1_0:release:relation-read-team-remove-person.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-remove-person.png "3_1_0:release:relation-read-team-remove-person.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=e13ce0&media=3_1_0:release:relation-read-team-remove-person-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-read-team-remove-person-popup.png "3_1_0:release:relation-read-team-remove-person-popup.png")

### 像标签集一样的 n:n 关系

iTop 3.1 版本引入了一种新的方式来处理多对多关系，这些关系没有属性，也不期望包含许多相关对象。

#### 用户 - 用户角色

例如，一个用户可以与几个角色关联，通过这项新功能，可以在对象的“属性”选项卡中选择角色，这样更容易记得填写它们。 [![](https://www.itophub.io/wiki/media?w=800&tok=274699&media=3_1_0:release:user-creation-profiles.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:user-creation-profiles.png "3_1_0:release:user-creation-profiles.png")

限制

*   仍然没有视觉指示：关系是必填且未填写
    
*   当在弹出界面中创建/修改对象时，关系选项卡不会显示，因此无法选择任何允许的组织。

[![](https://www.itophub.io/wiki/media?w=600&tok=6a218a&media=3_1_0:release:person-details-new-user-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:person-details-new-user-popup.png "3_1_0:release:person-details-new-user-popup.png")

*   在 3.0.0 版本中，用户到角色关系上有一个备注字段，可以用于指定何时以及为什么分配了该角色，甚至可以是用户请求的参考，证明了该访问权限。但另一方面，没有办法对删除的角色进行备注。
    
*   现在可以从用户日志中进行备注。

#### 通知 - 触发器

另一个例子，当创建/编辑电子邮件通知时，可以在通知的“属性”选项卡中直接选择触发器。 

[![](https://www.itophub.io/wiki/media?w=800&tok=30cf75&media=3_1_0:release:notification-details-triggers-property.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details-triggers-property.png "3_1_0:release:notification-details-triggers-property.png")

如果想要的触发器尚不存在，可以从这里创建它。

[![](https://www.itophub.io/wiki/media?w=600&tok=183d60&media=3_1_0:release:notification-triggers-create.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-triggers-create.png "3_1_0:release:notification-triggers-create.png") 

[![](https://www.itophub.io/wiki/media?w=400&tok=588eb6&media=3_1_0:release:notification-triggers-create-choose-type.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-triggers-create-choose-type.png "3_1_0:release:notification-triggers-create-choose-type.png") 

[![](https://www.itophub.io/wiki/media?w=400&tok=a91c76&media=3_1_0:release:notification-triggers-create-popup.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-triggers-create-popup.png "3_1_0:release:notification-triggers-create-popup.png") 

创建后，它将添加到弹出窗口中的 _相关触发器_ 字段中。

如果对这种新模式不太熟悉，关系的反向部分仍然会使用选项卡显示。

[![](https://www.itophub.io/wiki/media?w=600&tok=7f92e1&media=3_1_0:release:notification-trigger-notifications-tab.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-trigger-notifications-tab.png "3_1_0:release:notification-trigger-notifications-tab.png")

*   这种其他视图仍然允许设置**排序**关系字段。

[![](https://www.itophub.io/wiki/media?w=600&tok=a50966&media=3_1_0:release:notification-trigger-notification-edit-order.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-trigger-notification-edit-order.png "3_1_0:release:notification-trigger-notification-edit-order.png")

### n:n 编辑

这些按钮已移到列表的右上角。

[![](https://www.itophub.io/wiki/media?w=600&tok=550dda&media=3_1_0:release:relation-edit-person-add-remove-team.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:relation-edit-person-add-remove-team.png "3_1_0:release:relation-edit-person-add-remove-team.png")

### 门户中的 n:n

可以在用户标准门户中编辑多对多（n:n）关系的属性。

[![](https://www.itophub.io/wiki/media?w=800&tok=513ba6&media=3_1_0:release:portal-links-supported-fields.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:portal-links-supported-fields.png "3_1_0:release:portal-links-supported-fields.png")

有一些属性类型是**不受支持**的，其约束与后台用户界面中是相同的：

- 多行属性（HTML、长文本、案例日志等）
    
- 文件和图片
    
- 标签集和枚举集
    
- 关联集    

可以在[门户XML](https://www.itophub.io/wiki/page?id=3_1_0:customization:portal_xml "3_1_0:customization:portal_xml")中指定链接类属性的有序列表，以限制用户门户可见的属性。

### 链接字典

与链接相关的操作/图标提示、弹出窗口标题和确认消息，可以根据类别/属性[进行定制和专门化](https://www.itophub.io/wiki/page?id=3_1_0:customization:translation#relationships "3_1_0:customization:translation")。

### 过滤列表

现在可以在每个列表中（数据表列表、对象关系选项卡、运行查询结果等），可以点击：

*   列表计数：_总计：X 个对象_
    
*   或使用新的操作菜单 _使用搜索条件显示列表_...    

[![](https://www.itophub.io/wiki/media?w=600&tok=03e8bc&media=3_1_0:release:filter-list-link-and-menu.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:filter-list-link-and-menu.png "3_1_0:release:filter-list-link-and-menu.png")

这两个链接将在全屏模式下打开相同的查询，带有相应的搜索条件集。

*   然后，可以更改过滤器以减少结果，
    
*   运行菜单“配置此列表”以修改显示的字段，等等。


[![](https://www.itophub.io/wiki/media?w=600&tok=5974cf&media=3_1_0:release:filter-list-search-screen.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:filter-list-search-screen.png "3_1_0:release:filter-list-search-screen.png")

*   对于多对多关系选项卡，查询包括链接及其字段。
    
*   它还提供了对这些链接和相关对象的批量操作。
    

[![](https://www.itophub.io/wiki/media?w=600&tok=b494c7&media=3_1_0:release:filter-list-query-and-actions.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:filter-list-query-and-actions.png "3_1_0:release:filter-list-query-and-actions.png")

### 多类别的批量操作

当返回的对象列表包含多个类别的对象时，对于那些在这些类别上拥有批量修改权限的用户，会提供不同的新操作。对于每个类别，如果用户允许操作，它会提供：

*   批量编辑
    
*   批量删除
    

您可能会在显示在对象详细信息中的多对多关系选项卡中遇到这种情况。这样的列表包含两个类别，链接和远程类别。


[![](https://www.itophub.io/wiki/media?w=600&tok=12ea31&media=3_1_0:release:bulk-actions-on-multiple-classes-2.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:bulk-actions-on-multiple-classes-2.png "3_1_0:release:bulk-actions-on-multiple-classes-2.png")

可以在以下情况下遇到这种情况，即在以下位置输入多类别 OQL：

*   仪表盘列表
    
*   运行查询
    
*   快捷方式

例如，在三个类别上运行查询的情况：

[![](https://www.itophub.io/wiki/media?w=600&tok=d2a60e&media=3_1_0:release:bulk-actions-on-multiple-classes-3.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:bulk-actions-on-multiple-classes-3.png "3_1_0:release:bulk-actions-on-multiple-classes-3.png")

## 数据模型变化

### 新的布局

通知：新的布局 

[![](https://www.itophub.io/wiki/media?w=600&tok=062c1f&media=3_1_0:release:notification-details.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details.png "3_1_0:release:notification-details.png")

触发器：新的列表 

[![](https://www.itophub.io/wiki/media?w=600&tok=c1c85e&media=3_1_0:release:notification-triggers-list.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-triggers-list.png "3_1_0:release:notification-triggers-list.png")

用户：新的布局和工具提示

[![](https://www.itophub.io/wiki/media?w=600&tok=4e61be&media=3_1_0:release:user-creation-tooltips.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:user-creation-tooltips.png "3_1_0:release:user-creation-tooltips.png")

人员：添加了用户选项卡，当然，只有允许查看用户类别的用户才能看到它。

[![](https://www.itophub.io/wiki/media?w=600&tok=13a0f8&media=3_1_0:release:person-details-users_list.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:person-details-users_list.png "3_1_0:release:person-details-users_list.png") 

[![](https://www.itophub.io/wiki/media?w=600&tok=158b49&media=3_1_0:release:person-details-new-user.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:person-details-new-user.png "3_1_0:release:person-details-new-user.png")

*   如果人员的组织已经关联了“门户用户”，而且新的组织不允许该用户，那么就不能再更改该组织，因为这将会破坏用户访问 iTop 的权限。

问题管理：新的详情页布局

<table class="inline"><tbody><tr class="row0"><td class="col0">3.0 layout</td><td class="col1">3.1 layout aligned to the User Request fields order and columns</td></tr><tr class="row1"><td class="col0"><a href="https://www.itophub.io/wiki/media?media=3_1_0:release:problem-30-layout.png" class="media" title="3_1_0:release:problem-30-layout.png"><img src="https://www.itophub.io/wiki/media?w=500&amp;tok=756d7d&amp;media=3_1_0:release:problem-30-layout.png" class="mediacenter" alt="" width="500"></a></td><td class="col1"><a href="https://www.itophub.io/wiki/media?media=3_1_0:release:problem-31-layout.png" class="media" title="3_1_0:release:problem-31-layout.png"><img src="https://www.itophub.io/wiki/media?w=500&amp;tok=301351&amp;media=3_1_0:release:problem-31-layout.png" class="mediacenter" alt="" width="500"></a></td></tr></tbody></table>

客户合同和供应商合同：新的详细信息页面布局，具有两列和三个字段集。

### 更多的工具提示

#### 通知

通知增强了工具提示，提供了可用的占位符。

[![](https://www.itophub.io/wiki/media?w=900&tok=44a389&media=3_1_0:release:notification-details-tooltips.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details-tooltips.png "3_1_0:release:notification-details-tooltips.png") 

[![](https://www.itophub.io/wiki/media?w=700&tok=e8cdbe&media=3_1_0:release:notification-details-tooltip-cc.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details-tooltip-cc.png "3_1_0:release:notification-details-tooltip-cc.png") 

[![](https://www.itophub.io/wiki/media?w=550&tok=3fae5d&media=3_1_0:release:notification-details-tooltip-body.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details-tooltip-body.png "3_1_0:release:notification-details-tooltip-body.png") 

[![](https://www.itophub.io/wiki/media?w=400&tok=47e98e&media=3_1_0:release:notification-details-tooltip-status.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:notification-details-tooltip-status.png "3_1_0:release:notification-details-tooltip-status.png")

#### 菜单

菜单工具提示已经恢复（在 3.0.0 中消失了）。

[![](https://www.itophub.io/wiki/media?w=400&tok=230cba&media=3_1_0:release:menu-tooltip.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:menu-tooltip.png "3_1_0:release:menu-tooltip.png")

#### 对象标签页

工具提示更加醒目，同时也显示在选项卡标题上。

[![](https://www.itophub.io/wiki/media?w=800&tok=d86582&media=3_1_0:release:object-details-tab-tooltip.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:object-details-tab-tooltip.png "3_1_0:release:object-details-tab-tooltip.png") 

[![](https://www.itophub.io/wiki/media?w=800&tok=572312&media=3_1_0:release:object-details-tab-tooltip-title.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:object-details-tab-tooltip-title.png "3_1_0:release:object-details-tab-tooltip-title.png")

### 链接上的唯一性规则

在所有标准数据模型的多对多链接上都添加了唯一性规则。  

如果想在自定义链接上执行相同的操作，请查看[迁移说明部分](https://www.itophub.io/wiki/page?id=3_1_0:install:migration_notes#uniqueness_rule_on_links "3_1_0:install:migration_notes")。

### 枚举值排序

新的XML标签允许定义给定枚举属性应如何显示其值。请参阅[如何排序枚举属性的值](https://www.itophub.io/wiki/page?id=3_1_0:customization:order-enum "3_1_0:customization:order-enum")

### 转换顺序

现在可以通过配置参数和标准数据模型中的工单类别上添加的默认排序来[排序带有生命周期的类别的转换](https://www.itophub.io/wiki/page?id=3_1_0:customization:order-transition "3_1_0:customization:order-transition")。

### 转换表单

转换表单中的字段顺序现在会自动遵循类别详细信息选项卡中设置的顺序。与详细信息界面的设置顺序保持一致。

### 委托历史记录

现在可以允许没有管理员角色的 iTop 用户查询对象历史记录，只需为他们提供一个带有新组**History**的角色，或者使用由扩展[Admin tools delegation](https://www.itophub.io/wiki/page?id=extensions:itop-admin-delegation-profiles "extensions:itop-admin-delegation-profiles")带来的**Query History**角色。 

此外，请注意这样的用户不应该拥有“允许的组织”，并且应该具有对所有启用历史记录跟踪的类别的读取访问权限，因为出于安全原因，如果他们没有这些权限，它不是绝对安全的，通过历史记录可以以碎片的形式查看所有这些对象，了解它们的更改情况。


CSV import
----------

Feedback during CSV import have been improved, when reconciliation on enumeration value or external key are failing

*   On enumeration, in case of no match, the allowed values are displayed
    
*   On external key, in case of no match,
    
    *   some of the existing values are displayed and a search button is proposed to check by yourself in another window
        
    *   if there is no entries in iTop (or no entries visible to the current user), a message will tell you:
        
        *   _There are no 'Organization' objects_
            
        *   _There are no 'Organization' objects found with your current profile_

## CSV导入

在CSV导入期间，当枚举值或外部键的匹配失败时，反馈得到了改进

*   在枚举值的情况下，如果没有匹配项，将显示允许的值
    
*   在外部键的情况下，如果没有匹配项，
    
    *   将显示一些现有值，并提供一个搜索按钮，以便在另一个窗口中自行检查
        
    *   如果在iTop中没有条目（或当前用户无法看到条目），将显示以下消息：
        
        *   _没有'组织'对象_
            
        *   _没有找到与您当前配置文件匹配的'组织'对象_

[![](https://www.itophub.io/wiki/media?w=800&tok=9669e8&media=3_1_0:release:csv-step4-no-extkey-match.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:csv-step4-no-extkey-match.png "3_1_0:release:csv-step4-no-extkey-match.png")

## 登出

现在会自动返回登录界面

## 审计

### 新仪表盘

配置审计的新仪表盘

[![](https://www.itophub.io/wiki/media?w=800&tok=0823b2&media=3_1_0:release:audit-overview.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:audit-overview.png "3_1_0:release:audit-overview.png")

_以下的改进是由Combodo的由来已久的合作伙伴Itomig贡献的。非常感谢Lars Kaltefleiter！_

### 审计分割

按领域分割审计：

*   用户只能查看与自己领域相关的审计，不会被那些不是他们负责修复的错误所干扰
    
*   提高了审计性能，甚至在iTop的数据增长如此之大以至于在合理时间内审计永远无法结束的情况下，恢复了审计能力
    
*   限制审计计算量，限制为对请求审计用户有意义的内容

[![](https://www.itophub.io/wiki/media?w=800&tok=e3ab39&media=3_1_0:release:audit-domain-selection.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:audit-domain-selection.png "3_1_0:release:audit-domain-selection.png")

<a href="https://www.itophub.io/wiki/media?media=3_1_0:release:audit-domain-details.png" class="media" title="3_1_0:release:audit-domain-details.png"><img src="https://www.itophub.io/wiki/media?w=600&amp;tok=c7ef01&amp;media=3_1_0:release:audit-domain-details.png" class="mediacenter" alt="" width="600"></a>

<a href="https://www.itophub.io/wiki/media?media=3_1_0:release:audit-domain-results.png" class="media" title="3_1_0:release:audit-domain-results.png"><img src="https://www.itophub.io/wiki/media?w=600&amp;tok=095f6c&amp;media=3_1_0:release:audit-domain-results.png" class="mediacenter" alt="" width="600"></a>

*   对于每个审计类别的结果，拥有足够权限的人可以使用“扳手”图标跳转到审计类别对象，以根据需要调整规则。
    
*   对于Combodo的客户，包括[超链接配置器](https://www.itophub.io/wiki/page?id=extensions:combodo-custom-hyperlinks "extensions:combodo-custom-hyperlinks")，可以直接从这些对象中测试审计领域、类别或规则的结果。

### 可配置的阈值

按类别配置的阈值颜色

*   现在可以在每个规则中定义结果良好、一般或不佳的阈值。

[![](https://www.itophub.io/wiki/media?w=600&tok=14e892&media=3_1_0:release:audit-category-creation.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:audit-category-creation.png "3_1_0:release:audit-category-creation.png")

## 查询语句

在查询短语中添加了新信息，以跟踪每个查询的使用情况，以便可以清除不再使用的查询：

*   总使用次数
    
*   上次用户
    
*   上次使用日期

[![](https://www.itophub.io/wiki/media?w=600&tok=f087b3&media=3_1_0:release:queryphrase-details.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:queryphrase-details.png "3_1_0:release:queryphrase-details.png")

* * *

## 对于管理员

### 通知

[电子邮件通知](https://www.itophub.io/wiki/page?id=3_1_0:admin:notifications "3_1_0:admin:notifications") 已增强，新增了以下字段：

*   一个 _语言_ 字段，允许在指定的语言中翻译占位符，而不是触发通知的用户的语言。
    
*   一个 _HTML模板_ 文件，允许发送漂亮的HTML电子邮件，而不会丢失包含占位符的可能性。请注意，现在可以进行[预览](https://www.itophub.io/wiki/page?id=3_1_0:admin:notifications#message_contents_and_placeholders "3_1_0:admin:notifications")。
    
*   一个 _忽略通知标志_ 字段。如果设置为“否”，它将自动从TO、CC和BCC中删除通知设置为“否”的人员。不再需要在OQL中包含此逻辑。

### 使用令牌进行身份验证

此模块提供了两种使用身份验证令牌进行API调用的方式：

*   **应用程序令牌** 是iTop中的一种特殊类型的用户。
    
    *   它使用令牌进行身份验证，无法连接到iTop用户界面（控制台、门户等）
        
    *   它有自己的角色和允许的组织
        
    *   它可以访问所有API（REST、同步、导出等），没有可能的限制
        
*   **个人令牌** 与iTop用户关联
    
    *   它使用令牌进行身份验证，无法连接到iTop用户界面（控制台、门户等）
        
    *   它继承自其关联的用户、角色和允许的组织
        
    *   它可以限制到一些AOI（例如，仅支持REST和导出）
        
    *   它的个人令牌管理可以委托给具有特殊角色的用户
        

如果公司的安全策略要求每个用户通过SSO SAML进行身份验证，那么个人令牌是不支持SSO SAML访问的iTop API的解决方案。用于Excel或PowerBI动态报告的导出是其中之一。

查看[令牌身份验证](https://www.itophub.io/wiki/page?id=extensions:authent-token "extensions:authent-token")模块以获取更多详细信息

### 密码过期

1. 您已经定义了密码策略，但这不适用于现有密码。您可以批量更新iTop用户，强制他们更改密码，以确保他们的新密码符合策略。

[![](https://www.itophub.io/wiki/media?w=600&tok=2ff8a1&media=3_1_0:release:password-forced-change.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:password-forced-change.png "3_1_0:release:password-forced-change.png")

2. 现在，如果愿意，可以通过设置此模块配置参数 `password_expiration_delay` 强制iTop本地用户定期更改密码。

查看[密码过期管理](https://www.itophub.io/wiki/page?id=extensions:combodo-password-expiration "extensions:combodo-password-expiration")模块以获取更多详细信息。

### 用户管理委托

如果将用户管理委托给非管理员，他们将无法看到管理员用户。要恢复以前的行为，请将配置参数 `security.hide_administrators` 设置为 _false_。

### 自动清理日志

大型系统记录了大量数据。实际的日志系统允许轮换日志文件以防止内容过大，但服务器磁盘上仍然保留了所有文件。我们添加了一个定期任务来删除旧文件并释放服务器磁盘空间。由两个新参数控制：

*   `log_purge.enabled`，布尔类型，默认值为false
    
*   `log_purge.max_keep_days`，整数（以天为单位），默认值为365

### 在最终用户标准门户中进行调试

以前，要在门户中访问调试消息，必须激活门户调试模式。为了简化故障排除，现在可以通过[日志](https://www.itophub.io/wiki/page?id=3_1_0:admin:log "3_1_0:admin:log")配置来激活调试消息，就像对应用程序的任何其他部分一样。

相关消息包括：

*   AggregatePageBrick不显示
    
*   出于安全原因无法访问的对象（范围配置错误等）

### 文件属性/附件下载通知

在ormDocument对象（文件属性、附件）中添加了一个下载计数器：

*   迁移后，计数器从0开始，即使对于以前已经下载过的现有文档。
    
*   在附件表中（在对象详细信息中）显示计数器。
    
*   不在AttributeBlob上显示计数器。

[![](https://www.itophub.io/wiki/media?w=600&tok=3580e5&media=3_1_0:release:file-download-counter.png)](https://www.itophub.io/wiki/media?media=3_1_0:release:file-download-counter.png "3_1_0:release:file-download-counter.png")

#### 文件属性

现在提供了一个新的“触发器（在对象文档下载时）”，当有人在后台或最终用户门户中下载文件属性（例如“文档文件”类中的“文件”）时，它将激活。

此触发器使您可以在操作中访问新的占位符（当然，标准占位符仍然可用）：

*   `$file->mime_type$` 文件的MIME类型（例如：“image/png”）
    
*   `$file->file_name$` 文件的名称，如上传时
    
*   `$file->downloads_count$` 文件被下载的次数。请注意，这是在当前下载之前的计数，因此可以hook一些检查以防止超过阈值。
    
*   `$file->data$` 文件的二进制内容
    
*   `$file->data_as_base64$` 文件的Base64编码内容，对于与其他应用程序的集成可能会很有用

#### 附件

现在提供了一个新的“触发器（在对象附件下载时）”，当有人在后台或最终用户门户中下载附件时，它将被激活。

此触发器使您可以在操作中访问新的占位符（当然，标准占位符仍然可用）：

*   `$attachment->xxx$` 与 `$this->xxx$` 相同，但使用附件本身（`$this` 是它附加到的对象）
    
*   `$attachment->mime_type$` 文件的MIME类型（例如：“image/png”）
    
*   `$attachment->file_name$` 文件的名称，如上传时
    
*   `$attachment->downloads_count$` 文件被下载的次数。请注意，这是在当前下载之前的计数，因此您可以钩住一些检查以防止超过阈值。
    
*   `$attachment->data$` 文件的二进制内容
    
*   `$attachment->data_as_base64$` 文件的Base64编码内容，对于与其他应用程序的集成可能会很有用

请注意 `$xxx->data$` 和 `$xxx->data_as_base64$` 的输出可能会很大。

### 重新启动安装程序

在以前的版本中，要启动安装程序，必须修改配置文件权限，因此需要访问服务器文件系统。

现在，在“应用程序升级”屏幕中提供了一个按钮（从 [PR #244](https://github.com/Combodo/iTop/pull/244 "https://github.com/Combodo/iTop/pull/244") 集成）。

[![](https://www.itophub.io/wiki/media?w=600&tok=52b465&media=3_1_0:release:launch_setup.png)](https://www.itophub.io/wiki/media-detail?id=3_1_0:release:whats_new&media=3_1_0:release:launch_setup.png "3_1_0:release:launch_setup.png")

该按钮的可用性取决于 isdevenv 属性的组合（请参见\\utils::IsDevelopmentEnvironment）和 `setup.launch_button.enabled` 配置参数。请参考下表查看列表（❌ = 未定义值，👻 = 隐藏，💻 = 显示）：

| setup.launch\_button.enabled | isDevEnv | 按钮 |
| --- | --- | --- |
| ❌ | false | 👻 |
| true | false | 💻 |
| false | false | 👻 |
| ❌ | true | 💻 |
| true | true | 💻 |
| false | true | 👻 |

## 对于开发者

### 自定义模块：model.*.php 文件声明

在编写模块时，即使 `model.*.php` 文件未由iTop编译生成，也可以指定该文件（在 `module.*.php` 文件中的 'datamodel' 键中）。

此外，如果模块中存在 `datamodel.*.xml` 文件，编译器将自动选择它以生成相应的 `model.*.php` 文件。

从iTop 3.1.0开始，不再需要声明 `model.*.php` 文件（在 `module.*.php` 文件中的 'datamodel' 键），因为编译器将通过自动加载程序，自动将其添加到datamodel中。

### 自定义模块：对/pages/exec.php 的调用，现在允许在页面参数中使用子目录

`exec.php` 脚本用于执行模块内的脚本。例如，Ajax端点。

使用此脚本，现在可以指定要执行的脚本和子目录。例如：`exec.php?exec_module=mymodule&exec_page=ajax/endpoint.php&exec_env=production`

请参见[PR＃221](https://github.com/Combodo/iTop/pull/221 "https://github.com/Combodo/iTop/pull/221")。

### 自定义模块：使用自己的自定义zlists

有时需要一个自定义zlist，其中包含一组有限/特定的属性列表。从iTop 3.1+开始，现在可以定义自己的自定义zlist，并像标准zlist一样使用它们，使用`\MetaModel::GetZListItems()`。有关更多详细信息，请参见[此处](https://www.itophub.io/wiki/page?id=3_1_0:customization:xml_reference#xml_general_structure "3_1_0:customization:xml_reference")。

### 对象详细信息URL：使用attcode/attvalue访问

自2.7.0以来，引入了一种生成ref字段的新方法。这可能导致ref和id字段的值不同。

当从外部系统构建对象详细信息URL时（例如[Bugtraq](https://github.com/mstrap/bugtraq "https://github.com/mstrap/bugtraq")），这可能会导致问题，因为参数是类和id。

已存在的解决方法是将friendlyname值发送到id参数...但这仅在friendlyname只包含ref以外的字段时才可能。

为了解决friendlyname包含多个字段（标题、org等）的情况，现在可以在控制台和用户门户中使用新的URL。例如，对于具有id=99和ref=100的对象：

```
/pages/UI.php?operation=details&class=UserRequest&id=99
/pages/UI.php?operation=details&class=UserRequest&attcode=ref&attvalue=R-000100


/pages/exec.php/object/view/UserRequest/99?exec\_module=itop-portal-base&exec\_page=index.php&portal\_id=itop-portal
/pages/exec.php/object/view/UserRequest/ref/R-000100?exec\_module=itop-portal-base&exec\_page=index.php&portal\_id=itop-portal
```

如果未找到实例或找到多个实例，则会出现以下情况：

*   管理控制台：将抛出异常。
    
*   用户门户：将显示404错误页面。 

请参见 [PR #273](https://github.com/Combodo/iTop/pull/273 "https://github.com/Combodo/iTop/pull/273")。

---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:release:whats_new>

版本：3_1_0/release/whats_new.txt · Last modified: 2023/09/11 13:35 (external edit)