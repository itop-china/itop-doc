
---
title: "iTop 3.0 新特性"
linkTitle: "iTop 3.0 新特性"
date: 2022-09-13
description: >
  
---


## iTop 3.0 社区版
==================

*   3.0.0 Beta 版本发布日期：_2021年4月_
    
*   3.0.0 发布日期： _2022年 1月_
    
*   3.0.1 发布日期： _2022年 4月_
    
*   3.0.2 发布日期： _2022年 9月_
    
*   [下载链接](https://sourceforge.net/projects/itop/files/itop/3.0.0/ "https://sourceforge.net/projects/itop/files/itop/3.0.0/")
    
*   升级须知： [迁移说明](https://www.itophub.io/wiki/page?id=3_0_0:install:270_to_300_migration_notes "3_0_0:install:270_to_300_migration_notes")
    
*   iTop变更历史列表：[累积的变更日志](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log "3_0_0:release:change_log")
    
*   [3.0.0 版本 已知问题 ](https://www.itophub.io/wiki/page?id=3_0_0:release:beta-known-issues "3_0_0:release:beta-known-issues") 列表
    
*   检查 [扩展 3.0 适配版本](https://www.itophub.io/wiki/page?id=3_0_0:release:extensions "3_0_0:release:extensions")
    

## iTop 社区版新特性
============================

<table class="inline"><tbody><tr class="row0"><td class="col0 centeralign">这个版本专注于改进iTop的 <strong>外观</strong> 和 <strong>可用性</strong>。</td></tr></tbody></table>

[![Welcome page](https://www.itophub.io/wiki/media?w=600&tok=0bcd25&media=3_0_0:user:fullmoon-welcome.png "Welcome page")](https://www.itophub.io/wiki/media?media=3_0_0:user:fullmoon-welcome.png "3_0_0:user:fullmoon-welcome.png")

* * *

### 首页
--------

[![Homepage](https://www.itophub.io/wiki/media?w=600&tok=1e551a&media=3_0_0:user:welcome.png "Homepage")](https://www.itophub.io/wiki/media?media=3_0_0:user:welcome.png "3_0_0:user:welcome.png")

不能错过的主要内容：**布局、颜色、图标、菜单……** 所有这些都完全改变了，更可读，给重要信息留下更多空间，突出重要的东西，所以可以更高效。

可能的操作的主要变化:

*   在iTop中任何位置一键访问 [欢迎面板](about:blank#menus "3_0_0:release:3_0_whats_new ↵") 
    
*   添加了一个新的 [快速创建](about:blank#quick_create "3_0_0:release:3_0_whats_new ↵") 操作，以避免搜索相应的类创建菜单。
    
*   [快速搜索](about:blank#quick_search "3_0_0:release:3_0_whats_new ↵") 从右侧移动到左侧，在界面的上方。
    
*   [菜单](about:blank#menus "3_0_0:release:3_0_whats_new ↵") 可以简化成图标，从而为实际数据释放空间。
    
*   [用户菜单](https://www.itophub.io/wiki/page?id=3_0_0:user:main#user_menu "3_0_0:user:main") 移动到屏幕另一侧的角落了!
    

* * *

### 快速搜索
------------

![Quick search icon](https://www.itophub.io/wiki/media?w=350&tok=940c75&media=3_0_0:user:quick-search-tooltip.png "Quick search icon") [![Quick search result](https://www.itophub.io/wiki/media?w=500&tok=74500f&media=3_0_0:user:quick-search-result.png "Quick search result")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-search-result.png "3_0_0:user:quick-search-result.png")

快速搜索现在在左侧。

*   主要的新特性是 **它记录了过去的搜索记录**

*   与以前一样，当重新打开快速搜索时，最后的搜索仍然在那里，因此如果犯了一个拼写错误，可以修复它，而无需重新输入整个字符串。
    

现在可以通过新的配置参数配置该特性 [global\_search.xxx](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#f-l "3_0_0:admin:itop_configuration_file")，这允许：

*   完全禁用这个功能
    
*   删除过去搜索的踪迹和显示
    
*   优化过去搜索操作保留的数量（默认为10）
    

* * *

### 快速创建
------------

[![Quick create button](https://www.itophub.io/wiki/media?w=300&tok=7baa36&media=3_0_0:user:quick-creation-tooltip.png "Quick create button")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-creation-tooltip.png "3_0_0:user:quick-creation-tooltip.png") [![Quick creation dropdown](https://www.itophub.io/wiki/media?w=300&tok=7b3ee3&media=3_0_0:user:quick-creation-dropdown.png "Quick creation dropdown")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-creation-dropdown.png "3_0_0:user:quick-creation-dropdown.png")

全新功能：

它允许快速创建任何对象，甚至不知道菜单在哪里，如果有的话。

只需键入所需类的开头，系统就会推荐与之匹配的类。

*   如果只有一个匹配的类，只需按回车键，就会显示该类的创建表单。

*   可以使用键盘上的方向键来浏览建议列表
    

现在可以通过配置参数配置该特性 [quick\_create. .xxx](https://www.itophub.io/wiki/page?id=latest:admin:itop_configuration_file#o-r "latest:admin:itop_configuration_file")，这允许：

*   完全禁用这个功能
    
*   删除过去创建的踪迹和显示
    
*   优化过去创建操作保留的数量（默认为10）
    
*   优化通过自动补全特性显示的结果数量（默认为10）
    

* * *

### 对象显示
--------------

3.0 版本提升了[对象显示](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification "3_0_0:user:display_and_modification")的形式：

[![](https://www.itophub.io/wiki/media?w=500&tok=5fd63e&media=3_0_0:customization:class-icon-instance.png)](https://www.itophub.io/wiki/media?media=3_0_0:customization:class-icon-instance.png "3_0_0:customization:class-icon-instance.png") [![UserRequest transitions](https://www.itophub.io/wiki/media?w=500&tok=383a31&media=3_0_0:release:object-details-banner-scrolled.png "UserRequest transitions")](https://www.itophub.io/wiki/media?media=3_0_0:release:object-details-banner-scrolled.png "3_0_0:release:object-details-banner-scrolled.png")

#### 标头和操作

标头部分已经完全重做：

*   突出显示重要信息，如对象状态
    
*   为每一类对象使用特定的颜色，以便在任何时候都更清楚地显示所处位置。
    
*   锁定了顶部栏，所以即使当你向下滚动一个对象时，操作仍然可以访问，不适合所有的浏览器窗口
    
*   用富有意义的图标替换文本菜单，为重要数据腾出空间
    
*   将转换操作从其他操作中分离出来，因此它们更容易检索
    
*   显示对象的图标可以特定于显示的实例，以便更好地区分

* * *

#### 导航

[![Horizontal & Scrollable in read mode](https://www.itophub.io/wiki/media?w=400&tok=f9468a&media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "Horizontal & Scrollable in read mode")](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "3_0_0:user:tabs-scrollable-not-loaded-tab.png") [![Vertical tabs](https://www.itophub.io/wiki/media?w=450&tok=c650f0&media=3_0_0:user:tabs-vertical-classic-read.png "Vertical tabs")](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-vertical-classic-read.png "3_0_0:user:tabs-vertical-classic-read.png")

显示对象内容的新模式，定义了如何从一个选项卡切换到另一个选项卡：

_经典_： 这个模式和之前一样：

*   只能同时显示一个选项卡。
    
*   点击选项卡标题切换到另一个选项卡。
    

_滚动_： 新的模式：

*   所有的选项卡显示在同一个页面
    
*   通过使用鼠标或者点击选项卡标题滚动
    
*   异步的诸如仪表盘选项卡不会加载，除非点击显示它们。
    

* * *

### 活动面板
--------------

#### 工单日志独立编辑

[![Icon to switch to log edition](https://www.itophub.io/wiki/media?w=400&tok=d66212&media=3_0_0:user:activity-panel-entry-form-icon.png "Icon to switch to log edition")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-entry-form-icon.png "3_0_0:user:activity-panel-entry-form-icon.png") [![Editing a log](https://www.itophub.io/wiki/media?w=350&tok=0f5c79&media=3_0_0:user:activity-panel-save-transition.png "Editing a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-save-transition.png "3_0_0:user:activity-panel-save-transition.png")

添加了一个新的面板，以加速处理人只需要在日志记录中提供回复并可能应用变化的常见情况。

*   为此，他不需要修改工单，而是可以直接输入答复并发送它，同时如果需要，只需单击一次就可以应用变化。

*   这个新选项只存在于控制台中，适用于所有具有工单日志的对象。
    
*   现在可以通过XML对象声明来控制工单日志的顺序。

_详情见 [用户手册](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification#activity_panel "3_0_0:user:display_and_modification")_

* * *

#### 历史过滤

[![Activity history](https://www.itophub.io/wiki/media?w=300&tok=3dcd4f&media=3_0_0:user:activity-panel-history-format.png "Activity history")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-history-format.png "3_0_0:user:activity-panel-history-format.png") [![Log history](https://www.itophub.io/wiki/media?w=300&tok=8392c1&media=3_0_0:user:activity-panel-caselogs.png "Log history")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs.png "3_0_0:user:activity-panel-caselogs.png") [![Filter History](https://www.itophub.io/wiki/media?w=300&tok=20e144&media=3_0_0:user:activity-panel-mixed.png "Filter History")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-mixed.png "3_0_0:user:activity-panel-mixed.png")

在命名为“活动面板”的这部分屏幕中，可以检索日志和历史，它们都合并在一个时间轴中，这能更有效地了解完整的历史。

*   可以过滤此面板，以查看任何类型的条目
    
    *   **日志** 条目，你可以过滤更多，只查看评论或私信。
        
    *   **状态变化** 无论何时的对象的状态改变
        
    *   **编辑** 当对象创建或修改时(包括发送的通知)
        
*   在条目旁边，如果用户有头像，则显示用户头像，否则显示用户姓名的首字母。
    

历史时间戳是 **相对近的时间** 和 **绝对高于** 某指定的延迟。

历史显示能够配置，通过新的 [活动面板参数](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#a "3_0_0:admin:itop_configuration_file")。

* * *

### 提及用户

[![Mention someone in a log](https://www.itophub.io/wiki/media?w=350&tok=37d12e&media=3_0_0:user:mention-user-in-caselog.png "Mention someone in a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog.png "3_0_0:user:mention-user-in-caselog.png") [![Result of a mention in log](https://www.itophub.io/wiki/media?w=350&tok=783385&media=3_0_0:user:mention-user-in-caselog-result.png "Result of a mention in log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog-result.png "3_0_0:user:mention-user-in-caselog-result.png")

在控制台中，处理人可能希望快速通知工单日志中的某个人，以引起他们的注意。

*   那个人可能与工单没有关联，但我们仍然想通知他们。
    
*   只需输入 **@** 和姓名的开头，就会提示可用人员。
    
*   然后在提交包含 `提及` 的工单日志条目时，该人将收到一封电子邮件通知。
    
*   同一工单日志中可以提及多个人。
    
*   建议在工单上提及的人默认是属于
    
    *   这个工单的客户组织
        
    *   或者与当前用户相同的组织。
        
*   这个逻辑可以通过修改 [通知](https://www.itophub.io/wiki/page?id=3_0_0:admin:notifications#on_mention "3_0_0:admin:notifications") 改变。
    
* * *

### 列表
----

还记得在列表中滚动时失去列标题是多么痛苦吗?这回结束了，当你向下滚动时，现在他们仍然是可见的。

同时，用于筛选列表的搜索条件仍然显示在屏幕上。

还可以注意到与状态值相关的彩色圆圈。

[用户指南-管理列表](https://www.itophub.io/wiki/page?id=3_0_0:user:lists "3_0_0:user:lists").

[![](https://www.itophub.io/wiki/media?w=500&tok=47260b&media=3_0_0:user:search-list-with-header.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-list-with-header.png "3_0_0:user:search-list-with-header.png")[![](https://www.itophub.io/wiki/media?w=500&tok=7cd4fa&media=3_0_0:user:search-list-header-locked.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-list-header-locked.png "3_0_0:user:search-list-header-locked.png")

* * *

### 仪表盘
---------

已经改进了仪表盘的外观，有新的图标和图表

*   基于状态的组件头部统计使用了与每个值相关的颜色，以使其更容易阅读
    
*   仪表盘徽章已简化，以更好地突出显示计数和类名，并删除链接中无用的重复文本

[![Dashlet Hearder Statistic](https://www.itophub.io/wiki/media?w=500&tok=ef6e1a&media=3_0_0:release:dashlet-header-stat2.png "Dashlet Hearder Statistic")](https://www.itophub.io/wiki/media?media=3_0_0:release:dashlet-header-stat2.png "3_0_0:release:dashlet-header-stat2.png")[![Dashlet Badge](https://www.itophub.io/wiki/media?w=500&tok=7f67bf&media=3_0_0:release:dashlet-badge2.png "Dashlet Badge")](https://www.itophub.io/wiki/media?media=3_0_0:release:dashlet-badge2.png "3_0_0:release:dashlet-badge2.png")

*   仪表盘特定的菜单已经得到了协调，因此在查看仪表盘的标准版本时，只要有了自定义版本，版本模式就会应用于自定义版本，这一点更容易理解。
    
*   查看详情见 [这里](https://www.itophub.io/wiki/page?id=3_0_0:user:dashboards "3_0_0:user:dashboards")
    

* * *

### 气泡的工单日志
---------------

在用户门户中显示工单日志更加时髦：

[![Buble caselog in Portal](https://www.itophub.io/wiki/media?w=600&tok=56b906&media=3_0_0:user:portal-bubble-caselog.png "Buble caselog in Portal")](https://www.itophub.io/wiki/media?media=3_0_0:user:portal-bubble-caselog.png "3_0_0:user:portal-bubble-caselog.png") —-

### 菜单
-----

[![Search in Menus](https://www.itophub.io/wiki/media?w=200&tok=ead4c4&media=3_0_0:user:menubar-searchmenu.png "Search in Menus")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-searchmenu.png "3_0_0:user:menubar-searchmenu.png")

[菜单](https://www.itophub.io/wiki/page?id=3_0_0:user:main#the_menu_bar "3_0_0:user:main") 有丰富的图标，可以缩小显示图标，从而为有价值的信息获得空间

#### 欢迎

快速回到iTop首页的方法！

*   上方左侧图标![Back to Homepage](https://www.itophub.io/wiki/media?w=40&tok=11b32f&media=3_0_0:user:welcome-icon.png "Back to Homepage") 过去绝不会带你到想去的地方，我打赌，
    
*   现在它将带你返回到iTop首页，默认回到欢迎面板！
    
*   这个图标能够在XML中自定义，作为 `品牌` 部分
    

[![Count in query menus](https://www.itophub.io/wiki/media?w=250&tok=c0dad9&media=3_0_0:user:menubar-second-level.png "Count in query menus")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-second-level.png "3_0_0:user:menubar-second-level.png")

#### 对象统计

预定义查询中的对象数

*   精确的对象数量显示在菜单本身，
    
*   `99+` 代表多于99条。
    

#### 菜单查询

*   在Chrome的快捷键 `Alt+M` ，能够不使用鼠标在菜单中进行搜索
    
*   然后输入一些字符过滤包含字符的菜单
    
*   **空格** 字符，显示 **所有** 菜单
    

#### 展开 & 折叠

[![Collapsed menus and filtered organization](https://www.itophub.io/wiki/media?w=300&tok=922a53&media=3_0_0:user:menubar-filtered-on-organization.png "Collapsed menus and filtered organization")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-filtered-on-organization.png "3_0_0:user:menubar-filtered-on-organization.png")

*   使用汉堡包图标 [![Expending menu icon](https://www.itophub.io/wiki/media?w=30&tok=cbb519&media=3_0_0:user:menubar-expand-icon.png "Expending menu icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-expand-icon.png "3_0_0:user:menubar-expand-icon.png") 展开和折叠菜单的第一层。
    
*   当菜单栏展开后，分组的图标旁边显示了文字。
    
*   想要折叠菜单栏，点击 [![> sign](https://www.itophub.io/wiki/media?w=30&tok=fd7c80&media=3_0_0:user:menubar-expanded-icon.png "> sign")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-expanded-icon.png "3_0_0:user:menubar-expanded-icon.png") 图标。
    
*   当菜单栏折叠时，如果过滤了某个组织，则会显示一个红色圆圈[![Filtered menu collapse icon](https://www.itophub.io/wiki/media?w=30&tok=c4af09&media=3_0_0:user:menubar-filtered-on-organization-icon.png "Filtered menu collapse icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-filtered-on-organization-icon.png "3_0_0:user:menubar-filtered-on-organization-icon.png")。

* * *

### 关系
---------

[![](https://www.itophub.io/wiki/media?w=600&tok=42fb18&media=3_0_0:user:relation-display.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-display.png "3_0_0:user:relation-display.png") [![](https://www.itophub.io/wiki/media?w=600&tok=2393dd&media=3_0_0:user:relation-edition.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-edition.png "3_0_0:user:relation-edition.png")

 in read and edit mode are now identical in terms of displayed fields.  
It's much faster now to replace a team member by another one, just by editing their name. This new logic is available on all many to many relationships.

在读取和编辑模式下的[关系显示](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification#managing_objects_relations "3_0_0:user:display_and_modification")现在在显示字段方面是相同的。

现在用另一个人替换一个团队成员要快得多，只需要编辑他们的名字。这种新的逻辑适用于所有多对多关系。

* * *

### 用户首选项
---------------

[![](https://www.itophub.io/wiki/media?w=500&tok=a76041&media=3_0_0:user:user-preferences.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:user-preferences.png "3_0_0:user:user-preferences.png")

3.0版本带来了新的用户首选项来控制iTop的行为，所以你可以选择最适合你的习惯的模式。 

你可以控制iTop对象的显示时间：

*   **布局**，能够控制选项卡标题显示在顶部(_与之前一样_) 或者在左侧。
    
*   **导航**: 只显示单个选项卡的内容(_与之前一样_)或所有选项卡同时显示，要么在其他选项卡下面，允许使用简单的鼠标滚动导航
    
*   新的选项使每次编辑一个HTML字段时打开工具栏
    
*   新的选项使你可以在不修改工单本身的情况下，直接能够在工单的工单日志中输入一些东西。

如果你喜欢用键盘快速导航，为频繁的动作添加了快捷方式。

查看 [如何管理你的用户首选项](https://www.itophub.io/wiki/page?id=3_0_0:user:main#managing_your_preferences "3_0_0:user:main")。

#### Fullmoon 或者 Darkmoon

选择主题，饱满或者暗淡, 与你的心情一致。

[![Darkmoon preference](https://www.itophub.io/wiki/media?w=400&tok=703bd5&media=3_0_0:release:darkmoon-preference.png "Darkmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-preference.png "3_0_0:release:darkmoon-preference.png")[![Fullmoon preference](https://www.itophub.io/wiki/media?w=400&tok=6f8336&media=3_0_0:release:fullmoon-preference.png "Fullmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:fullmoon-preference.png "3_0_0:release:fullmoon-preference.png")

[![Darkmoon Homepage](https://www.itophub.io/wiki/media?w=800&tok=b91a02&media=3_0_0:release:darkmoon-homepage.png "Darkmoon Homepage")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-homepage.png "3_0_0:release:darkmoon-homepage.png")

* * *

### 预定义的OQL查询
----------------------

#### 安装时

*   在安装时(新安装或版本升级)，一组在通知中可用的OQL查询会自动加载。
    
*   查询标签和描述使用iTop默认语言，如果存在翻译 (`EN US`, `FR FR` 和 `DE DE`)
    
*   对于每个要加载的查询，对于OQLQuery标记iTop查询作为`Template for OQL fields`，并且有完全相同的 `Expression` (_OQL_)。
    
    *   如果有一个和一个已经存在，那么没有新的查询被加载，并且现有的查询**没有更新**。
        
    *   如果没有找到，则创建一个新的OQLQuery
        
    *   如果发现多个，则创建一个新的iTop(_已知 iTop 限制_)

[![Notification icon to search for predefined queries](https://www.itophub.io/wiki/media?w=400&tok=e32a99&media=3_0_0:user:predefined-query-search.png "Notification icon to search for predefined queries")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search.png "3_0_0:user:predefined-query-search.png") [![Search a predefined OQL](https://www.itophub.io/wiki/media?w=400&tok=b125b7&media=3_0_0:user:predefined-query-search-popup.png "Search a predefined OQL")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search-popup.png "3_0_0:user:predefined-query-search-popup.png")

#### 通知中的使用    

*   OQL查询标记为`Template for OQL fields`，建议在编辑任何类型为`OQL`的iTop字段时，作为一个新的操作来检索现有的查询，并轻松地从选定的OQL查询复制OQL。

*   可以创建自己的模板查询，

*   你可以修改OQL查询模板自动加载的标签和描述。

*   OQL查询模板中OQL的修改对过去使用OQL查询作为源的通知没有影响。这些通知保留了查询的旧版本。

* * *

### 用户管理
---------------

#### 多个 LDAP

iTop现在原生支持连接到 [多个 LDAP](https://www.itophub.io/wiki/page?id=extensions:authent-ldap "extensions:authent-ldap") 服务器的能力。

#### Admin自毁灭

[![](https://www.itophub.io/wiki/media?w=400&tok=5644c4&media=3_0_0:release:disabling-user-account.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:disabling-user-account.png "3_0_0:release:disabling-user-account.png")

以下的修改是为了 **阻止管理员** 或者 用户 **提交自毁灭**.

*   用户不能禁用自己的账号
    

[![](https://www.itophub.io/wiki/media?w=600&tok=df8ab3&media=3_0_0:release:removing-admin-profile.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:removing-admin-profile.png "3_0_0:release:removing-admin-profile.png")

*   用户不能删除允许他编辑用户帐户的最后一个角色。
    
*   如果用户至少有一个允许的组织，则其联系人必须将其组织包含在用户允许的组织列表中。
    

[![Deletion of admin user](https://www.itophub.io/wiki/media?w=500&tok=e03a1b&media=3_0_0:release:deletion-of-admin.png "Deletion of admin user")](https://www.itophub.io/wiki/media?media=3_0_0:release:deletion-of-admin.png "3_0_0:release:deletion-of-admin.png")

*   用户不能删除自己的账号。
    
*   用户不能移除关联到自身账号的联系人。

*   允许访问后台的用户不能向自己的用户帐户添加“门户角色”或任何其他角色，这将阻止他再访问后台。
    

_如果必须执行上述任何操作，则必须由另一个用户执行_。

如果你实现了 [用户代理](https://www.itophub.io/wiki/page?id=3_0_0:customization:delegate_rights "3_0_0:customization:delegate_rights")，然后一个新的配置参数允许改善这些用户的体验，通过防止他们编辑管理员和获得错误消息，通过简单地向他们隐藏那些管理员用户。查看 [security.hide\_administrators](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#s-t "3_0_0:admin:itop_configuration_file") 配置参数。

* * *

### 集成
-----------

#### Webhooks

允许任何已存在的触发器

*   发送聊天通知到Google Chat, Rocket.chat 和 Slack, 同时发送email通知到相同的利益相关者。
    
*   复制/镜像另一个itop对象的部分，通过一个操作的json中的简单配置，并更新本地触发对象的远程信息
    
*   调用任何提供web服务的第三方应用程序
    
关于此特性的更多详细信息包含在3.0.0产品中，并作为iTop 2.7.x上的扩展

* * *

### 系统
------

#### 安装

*   由于视图产生的问题比它带来的价值更多(_视图的表名称超过MySQL的限制等等_)，它们从3.0.0版本被删除

*   在安装过程中，所有与定义的业务模型类对应的 `view__ClassName_` 都将被系统地删除。
    

#### REST/JSON

在CLI模式下，JSON数据结构现在可以放在一个单独的文件中，在命令行中，您只需提供文件的路径，就像这样：**json-data@<path>**.

#### 监控

*   [监控](https://www.itophub.io/wiki/page?id=3_0_0:admin:monitoring:healthcheck "3_0_0:admin:monitoring:healthcheck")：允许监控itop状态，无需通过任何认证HTTP
    

* * *

### 新的定制
------------------

#### 分组菜单图标

*   定义[菜单图标](https://www.itophub.io/wiki/page?id=3_0_0:customization:menu-icon "3_0_0:customization:menu-icon")。如果没有图标，则使用标签的第一个字母。
    

#### 设置类的颜色和图标

随着iTop 3.0，现在可以通过iTop扩展或ITSM设计器

*   定义 [类的颜色](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors "3_0_0:customization:class-colors")：这个颜色用于对象细节、列表和一些组件的顶部栏。
    
*   定义 [类的图标](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#class_icon "3_0_0:customization:class-colors") 用于自定义类，或更改现有类的图标。
    
*   对于某些类，比如Person，显示在对象标头上的图标可以是特定于每个对象的。这里只需要定义 [示例 icon](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#object_icon "3_0_0:customization:class-colors")，指定要使用的对象AttributeImage字段。
    

#### 设置枚举值的颜色

*   iTop 3.0，现在可以对任意枚举字段的每个值 [定义颜色和字体](https://www.itophub.io/wiki/page?id=3_0_0:customization:enum-colors "3_0_0:customization:enum-colors") 图标。
    

#### 创建你自己的主题

*   iTop 3.0，甚至更容易去 [定义自己的iTop主题](https://www.itophub.io/wiki/page?id=3_0_0:customization:theme "3_0_0:customization:theme")，在现有的基础上或在原地。
    
*   每个用户都可以在安装的软件中选择自己想要的主题。
    

#### 丰富对象的友好名称

有时一个友好名称不足以区分两个对象，特别是当您想在下拉列表中选择它时。为了应对这一问题，iTop 3.0带来了一个新的概念， 去[区分同音异议词](https://www.itophub.io/wiki/page?id=3_0_0:customization:longname "3_0_0:customization:longname").

* * *

### 对于开发者
---------------

#### 新的DBObject方法

*   在DBObjects上，增加了新的方法，所有类上都是可用的
    
*   _主要的用处是，对于XML开发者和ITSM Designer用户在无须编写代码的情况下，修改变化上的属性_
    
*   **SetCurrentDateIfNull**, **AddValue**, **SetComputedDate**, **SetComputedDateIfNull**
    

查看详情，请参见 [可用的方法](https://www.itophub.io/wiki/page?id=3_0_0:customization:actions-on-transitions "3_0_0:customization:actions-on-transitions")，在变化上作为操作可以使用。

#### 记录对已弃用文件/ PHP方法的调用

3.0.0中增加了一个新的日志文件：`log/deprecated-calls.log`。

这将包含调用已弃用文件或PHP方法的日志，并将帮助开发人员迁移他们的代码。实际上iTop API的一部分标有 [@deprecated](https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated "https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated") 通常会在下一个iTop主要版本移除：即iTop 3.0.0中一个方法标记为`@deprecated`则肯定会在iTop 3.1.0确定被移除。

默认情况下，这些日志是禁用的，但可以使用`log_level_min`配置参数为适当的日志通道启用它们。此外，如果在GitHub克隆上使用记录器将有不同的行为。

查看参考 [对应的文档](https://www.itophub.io/wiki/page?id=3_0_0:admin:log:channels#deprecated_calls "3_0_0:admin:log:channels")。

#### 在向导安装中预编译主题

这个功能是对设置的优化，可以为主题节省大量时间(每个主题大约30秒)。

更多的细节，查看 [主题预编译](https://www.itophub.io/wiki/page?id=3_0_0:advancedtopics:setup_theme_precompilation "3_0_0:advancedtopics:setup_theme_precompilation")。

#### 新的 developer_mode.enabled 配置参数

一些针对扩展和核心开发人员的iTop行为是由 \\utils::IsDevelopmentEnvironment 方法触发的：Twig 缓存重置, setup symlinks, DeprecatedCallsLog, …

这个方法只对Github克隆返回true。

现在是新的 `developer_mode.enabled` 参数允许控制方法返回值:如果参数有一个布尔值，那么它将被用作方法返回值，否则现有的行为将被保留。
331/5000 
现在是新的“developer_mode”。启用的config参数允许控制方法返回值:如果参数有一个布尔值，那么它将被用作方法返回值，否则现有的行为将被保留。

默认的配置参数值是 `null` 所以除非设置了显式值，否则不会发生任何更改。

#### 生成 symlinks 标记

此选项仅在满足以下所有条件时可用:

*   运行在一个开发环境中 (当直接使用iTop GitHub仓库克隆时，或者当 `developer_mode.enabled` [configuration parameter](https://www.itophub.io/wiki/page?id=latest:admin:itop_configuration_file "latest:admin:itop_configuration_file") 设置为true时)
    
*   `symlink` PHP 功能可用
    

如果在这样的环境中启动安装程序，则会在安装程序中显示一个新选项，在 “Miscellaneous Parameters” 向导安装中：

[![](https://www.itophub.io/wiki/media?w=600&tok=a94d5d&media=3_0_0:release:symlink.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:symlink.png "3_0_0:release:symlink.png")

当编译完成并选中该选项时， 创建 `/data/.compilation-symlinks` 文件。
此外，如果该文件存在，设置复选框将被选中。对应的选项在3.0.0 toolkit中也是一样的。

注意，当编译从任何没有向编译器(`\MFCompiler::Compile`)提供`useSymLinks`参数的客户端启动时，这个文件将被用来生成符号链接。如ITSM设计器连接器、集线器连接器、调用RuntimeEnvironment的自定义脚本。

这对扩展开发人员来说是一个好处:如果您正在使用带有符号链接选项的工具包进行开发，并且需要启动设置，那么将直接获得符号链接。在此之前，必须使用toolkit重新编译以获取符号链接。

#### 编译器总是生成新的 model.\*.php

在iTop 3.0.0中自提交[c5d265f6](https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26# "https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26#") ，现在当需要写入一个`model.*.php`文件时，编译器将总是会移除当前的文件。这代表着`model.*.php` 文件将不再作为symlink生成。

如果编译是使用符号链接选项完成的，下面是这种行为更改结果的简短总结:

| 有 model.\*.php | 有 datamodel.\*.xml | 结果 |
| --- | --- | --- |
| ✔ | ❌ | ➖ 在原始模型文件中所做的修改将需要在iTop中推送一个新的编译 |
| ✔ | ✔ | ➖ 同上<br>➕ 如果模型是来源于版本(Git, Svn, …)的，在model.\*.php中将不能得到编译的代码 |
| ❌ | ✔ | ➕ 同上 |

---
原文：<https://www.itophub.io/wiki/page?id=3_0_0:release:3_0_whats_new>

版本：3_0_0/release/3_0_whats_new.txt · Last modified: 2022/09/13 14:25 (external edit)