
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

User Preference
---------------

[![](https://www.itophub.io/wiki/media?w=500&tok=a76041&media=3_0_0:user:user-preferences.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:user-preferences.png "3_0_0:user:user-preferences.png")

The version 3.0 brings new user preferences to control the behavior of iTop, so you can choose the modes that suits best your habits.  

You can control when an iTop object is displayed:

*   the tabs titles **layout**, which can be displayed on top (_as before_) or on the left side.
    
*   the **navigation**: only the content of a single tab is displayed (_as before_) or all tabs are displayed at once, one under the others, allowing to navigate with a simple mouse scroll
    
*   New option to have the toolbar open each time you edit an HTML field
    
*   New option so you directly have the possibility to enter something in the caselog of a Ticket and sent it without modifying the Ticket it-self.
    

If you like to navigate quickly just with the keyboard, we have added shortcut for frequent actions.

Check here for [how to manage your User Preferences](https://www.itophub.io/wiki/page?id=3_0_0:user:main#managing_your_preferences "3_0_0:user:main").

### Fullmoon or Darkmoon

Choose your theme, Full or Dark, aligned with your mood.

[![Darkmoon preference](https://www.itophub.io/wiki/media?w=400&tok=703bd5&media=3_0_0:release:darkmoon-preference.png "Darkmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-preference.png "3_0_0:release:darkmoon-preference.png")[![Fullmoon preference](https://www.itophub.io/wiki/media?w=400&tok=6f8336&media=3_0_0:release:fullmoon-preference.png "Fullmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:fullmoon-preference.png "3_0_0:release:fullmoon-preference.png")

[![Darkmoon Homepage](https://www.itophub.io/wiki/media?w=800&tok=b91a02&media=3_0_0:release:darkmoon-homepage.png "Darkmoon Homepage")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-homepage.png "3_0_0:release:darkmoon-homepage.png")

* * *

Predefined OQL queries
----------------------

#### On Setup

*   On Setup (new installation or version upgrade), a set of OQL queries usable in Notifications are automatically loaded.
    
*   Queries label and description are in iTop default language, when translation exist (`EN US`, `FR FR` and `DE DE`)
    
*   For each query to load, iTop searchs for OQLQuery flagged as `Template for OQL fields` and having the exact same `Expression` (_OQL_).
    
    *   If one and one only exists already, then no new query is loaded and the existing one is **not updated**.
        
    *   If none are found, a new OQLQuery is created
        
    *   If more than one is found, then a new one is created (_known iTop limitation_)
        

[![Notification icon to search for predefined queries](https://www.itophub.io/wiki/media?w=400&tok=e32a99&media=3_0_0:user:predefined-query-search.png "Notification icon to search for predefined queries")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search.png "3_0_0:user:predefined-query-search.png") [![Search a predefined OQL](https://www.itophub.io/wiki/media?w=400&tok=b125b7&media=3_0_0:user:predefined-query-search-popup.png "Search a predefined OQL")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search-popup.png "3_0_0:user:predefined-query-search-popup.png")

#### Usage in Notification

*   OQL Queries flagged as `Template for OQL fields`, are proposed when editing any iTop field of type `OQL`, as a new action to retrieve existing queries and easily copy the OQL from the selected OQL Query.
    

*   You can create your own template queries,
    
*   You can modify the label and description of the template OQL queries automatically loaded.
    
*   A modification of the OQL in a template OQL Query has no effect on Notifications which in the past, have used that OQL Query as source. Those notifications keep the old version of the query.
    

* * *

User management
---------------

#### Multi LDAP

iTop now supports natively the possibility to connect to [multiple LDAP](https://www.itophub.io/wiki/page?id=extensions:authent-ldap "extensions:authent-ldap") servers

#### Admin suicide

[![](https://www.itophub.io/wiki/media?w=400&tok=5644c4&media=3_0_0:release:disabling-user-account.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:disabling-user-account.png "3_0_0:release:disabling-user-account.png")

The following modifications was made in order to **prevent admins** or users **to commit suicide**.

*   A user cannot disable his own account
    

[![](https://www.itophub.io/wiki/media?w=600&tok=df8ab3&media=3_0_0:release:removing-admin-profile.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:removing-admin-profile.png "3_0_0:release:removing-admin-profile.png")

*   A user cannot remove his last profile allowing him to edit users accounts.
    
*   If a user has at least one allowed organization, then its contact must have his organization in the list of the user's allowed orgs.
    

[![Deletion of admin user](https://www.itophub.io/wiki/media?w=500&tok=e03a1b&media=3_0_0:release:deletion-of-admin.png "Deletion of admin user")](https://www.itophub.io/wiki/media?media=3_0_0:release:deletion-of-admin.png "3_0_0:release:deletion-of-admin.png")

*   A user cannot delete his own account.
    
*   A user cannot remove the contact linked to his own user account.
    
*   A user allowed to acces the backoffice cannot add to his own user account a “Portal profile” or any other profile which would prevent him to access the backoffice anymore.
    

_If any of the above actions must be done, then another user must do it_.

If you have implemented [user delegation](https://www.itophub.io/wiki/page?id=3_0_0:customization:delegate_rights "3_0_0:customization:delegate_rights"), then a new configuration parameter allow to improve those users experience by preventing them from editing Administrators and getting after that, an error message, by simply hiding to them those Administrator users. See [security.hide\_administrators](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#s-t "3_0_0:admin:itop_configuration_file") configuration parameters.

* * *

Integration
-----------

### Webhooks

Allow on any existing triggers to

*   send chat notifications to Google Chat, Rocket.chat & Slack, with the same placeholders as email notification.
    
*   replicate / mirror part of an object on another itop, through a simple configuration in json in an action and update local triggering object with remote information
    
*   call any third party application offering webservices
    

More details about this feature included in 3.0.0 Products and as extension on iTop 2.7.x

* * *

System
------

#### Setup

*   As Views were generating more issues than it was bringing value (_table name of view exceeding MySQL limit for eg._), they were removed since version 3.0.0
    
*   All the views corresponding to a defined bizmodel class named with the following convention `view__ClassName_` are now systematically removed during Setup.
    

#### REST/JSON

In CLI mode the JSON data structure can now be put in a separate file and in the command line, you just provide the path of the file, like this **json-data@<path>**.

#### Monitoring

*   [Monitoring](https://www.itophub.io/wiki/page?id=3_0_0:admin:monitoring:healthcheck "3_0_0:admin:monitoring:healthcheck"): allow to monitor itop status without any authentication via http
    

* * *

New customizations
------------------

#### Icon on Group Menu

*   Define an [Icon on Menu](https://www.itophub.io/wiki/page?id=3_0_0:customization:menu-icon "3_0_0:customization:menu-icon"). Without an icon, the first letter of the label is used.
    

#### Set color and icon on class

With iTop 3.0 it's now possible with an iTop extension or through the ITSM Designer to

*   Define a [color on Class](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors "3_0_0:customization:class-colors"): this color is used for the top bar of a object detail, a list and some dashlets.
    
*   Define a [class icon](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#class_icon "3_0_0:customization:class-colors") for one of your custom class or changing the one of an existing class
    
*   For some class, like Person, the icon displayed on the object header can be specific per object. For this just define a [Instance icon](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#object_icon "3_0_0:customization:class-colors"), specifying the object AttributeImage field to use.
    

#### Set colors on enum values

*   With iTop 3.0 it's now possible to [define colors and fontawesome](https://www.itophub.io/wiki/page?id=3_0_0:customization:enum-colors "3_0_0:customization:enum-colors") icon for each value of any Enumeration field.
    

#### Create your own theme

*   With iTop 3.0 it's even easier to [define your own iTop theme](https://www.itophub.io/wiki/page?id=3_0_0:customization:theme "3_0_0:customization:theme"), on top of the existing one or in place.
    
*   Every user can select the theme he wants, among those installed.
    

#### Enrich object friendlyname

Sometimes a friendlyname is not enough to differentiate 2 objects, especially when you want to select it within a drop-down list. In order to cope with this, iTop 3.0 brings a new concept, to [differentiate homonyms](https://www.itophub.io/wiki/page?id=3_0_0:customization:longname "3_0_0:customization:longname").

* * *

For developpers
---------------

#### New methods on DBObject

*   We have added new methods on DBObjects, available on all classes
    
*   _mainly useful for XML developers and ITSM Designer users to modify attributes on transitions without coding_
    
*   **SetCurrentDateIfNull**, **AddValue**, **SetComputedDate**, **SetComputedDateIfNull**
    

Check that new page for details on [methods available](https://www.itophub.io/wiki/page?id=3_0_0:customization:actions-on-transitions "3_0_0:customization:actions-on-transitions"), usable as action on transitions.

#### Log calls to deprecated files / PHP methods

A new log file is added in 3.0.0 : `log/deprecated-calls.log`.

This will contains logs of calls to deprecated files or PHP methods, and will help developers to migrate their code. Actually parts of the iTop API marked with `[@deprecated](https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated "https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated")` are usually removed in the next iTop major version : ie a method marked as `@deprecated` in iTop 3.0.0 will certainly be removed in iTop 3.1.0.

By default those logs are disabled, but you can enabled them using the `log_level_min` config parameter for the appropriate log channels. Also, the logger will have a different behavior if used on a GitHub clone.

See the [corresponding documentation](https://www.itophub.io/wiki/page?id=3_0_0:admin:log:channels#deprecated_calls "3_0_0:admin:log:channels") for reference.

#### Themes precompilation at wizard setup

This feature is an optimization of the setup to spare significant time with themes (about 30 seconds per theme).

for more details see [theme precompilation](https://www.itophub.io/wiki/page?id=3_0_0:advancedtopics:setup_theme_precompilation "3_0_0:advancedtopics:setup_theme_precompilation").

#### New developer\_mode.enabled config parameter

Some iTop behaviors intended for extensions and core developers are triggered by the \\utils::IsDevelopmentEnvironment method : Twig cache reset, setup symlinks, DeprecatedCallsLog, …

This method was returning true only for Github clones.

Now the new `developer_mode.enabled` config parameter allows to control the method returned value : if the parameter has a boolean value then it will be used as the method return value, otherwise the existing behavior will be kept.  
Default config parameter value is `null` so that nothing changes unless an explicit value is set.

#### Generate symlinks flag

This option is available only if all of the following conditions are met :

*   we are running on a dev environment (either when using directly a iTop GitHub repo clone, or when the `developer_mode.enabled` [configuration parameter](https://www.itophub.io/wiki/page?id=latest:admin:itop_configuration_file "latest:admin:itop_configuration_file") is set to true)
    
*   the `symlink` PHP function is available
    

If the setup is launched in such environment,a new option is displayed in the setup, in the “Miscellaneous Parameters” wizard step:

[![](https://www.itophub.io/wiki/media?w=600&tok=a94d5d&media=3_0_0:release:symlink.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:symlink.png "3_0_0:release:symlink.png")

When the compilation is done with the option checked, a `/data/.compilation-symlinks` file is created.  
Also if this file is present the setup checkbox will be checked. It will be the same in the 3.0.0 toolkit for the corresponding option.

Note that this file will be used to generate symlinks when compilation is launched from any client that aren't providing the `useSymLinks` parameter to the compiler (`\MFCompiler::Compile`). Eg. ITSM Designer connector, Hub connector, custom script calling RuntimeEnvironment.

This is a gain for extension developers : if you are developing using the toolkit with the symlinks option, and if you need to launch the setup, you will get directly symlinks. Before it was mandatory to compile again using the toolkit to get back symlinks.

#### Compiler always generate new model.\*.php

Since commit [c5d265f6](https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26# "https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26#") in iTop 3.0.0 the compiler now will always remove the previous file when it needs to write a `model.*.php` file. This implies the `model.*.php` files won't ever be generated as a symlink.

If the compilation was done with the symlink option, below is a short summary of this behavior change consequences:

| Has model.\*.php | Has datamodel.\*.xml | Consequence |
| --- | --- | --- |
| ✔ | ❌ | ➖ Modification done in the original model file will need a new compilation to be pushed in iTop |
| ✔ | ✔ | ➖ Same as above  
➕ If your module is versionned (Git, Svn, …), you won't get the compiled code in model.\*.php |
| ❌ | ✔ | ➕ Same as above |

3\_0\_0/release/3\_0\_whats\_new.txt · Last modified: 2022/09/13 14:25 (external edit)