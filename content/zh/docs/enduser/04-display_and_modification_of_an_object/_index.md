---
title: "对象显示和修改"
linkTitle: "对象显示和修改"
date: 2022-11-09
weight: 4
description: >
  连接到iTop！
---

{{% pageinfo %}}
本文档解释了如何:

1.  在iTop中导航
2.  执行基本的任务，诸如：查询对象，创建和管理对象 
3.  自定义iTop用户界面（列表，快捷键，仪表板）

{{% /pageinfo %}}


**_对象显示和修改_**
-------

## 显示

在iTop中总是以相同的方式显示一个对象的详细信息，如下图：

[![Details of a Contact](https://www.itophub.io/wiki/media?media=3_0_0:user:contact-details.png "Details of a Contact")](https://www.itophub.io/wiki/media?media=3_0_0:user:contact-details.png "3_0_0:user:contact-details.png")

### 标头

标头部分包含了多个关键信息：

*   对象的 **友好名称（friendlyname）**，可以是单个对象字段，如名称(name)或者对象字段的组合，如 人员 的名字 + 姓氏。
    
*   对象所属类。
    
*   如果该对象所属类定义了伴随状态的特定颜色，那么对象 **状态（status）** 则会显示。
    
*   每一类对象都有自己的边框 **颜色**，在任何时候都更清楚所在的位置。

*   一个可选的对象**图标**，对应显示的实例，或者通用于类的所有对象。
    

### 操作

[![Other Actions](https://www.itophub.io/wiki/media?w=300&tok=fe356d&media=3_0_0:user:person-other-actions.png "Other Actions")](https://www.itophub.io/wiki/media?media=3_0_0:user:person-other-actions.png "3_0_0:user:person-other-actions.png")

对象允许的操作列在右上角。常用的操作显示为图标。

*   [![Edit icon](https://www.itophub.io/wiki/media?media=3_0_0:user:modify-button.png "Edit icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:modify-button.png "3_0_0:user:modify-button.png") 允许修改当前对象。如果不允许编辑当前对象，则不可用。
    
*   [![Creation icon](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Creation icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png") 允许创建与当前对象属于同一类的对象。如果不允许创建当前类的对象，则不可用。
    
*   [![Refresh icon](https://www.itophub.io/wiki/media?media=3_0_0:user:refresh-button.png "Refresh icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:refresh-button.png "3_0_0:user:refresh-button.png") 允许刷新当前对象的显示，以防它在显示后被修改。
    
*   [![Search icon](https://www.itophub.io/wiki/media?media=3_0_0:user:search-icon.png "Search icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:search-icon.png "3_0_0:user:search-icon.png") 允许搜索当前类的对象。
    
*   [![Other actions icon](https://www.itophub.io/wiki/media?media=3_0_0:user:more-button.png "Other actions icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:more-button.png "3_0_0:user:more-button.png") 允许列出可以对应于对象的其他操作：
    

  _在这个示例中， 在人员的详情中`Create a user request…` 操作，是由扩展[User action Configurator](https://www.itophub.io/wiki/page?id=extensions:itop-object-copier "extensions:itop-object-copier")提供的功能。_

*   转换（transitions）操作在转换图标下分组。
    

[![UserRequest transitions](https://www.itophub.io/wiki/media?w=500&tok=383a31&media=3_0_0:release:object-details-banner-scrolled.png "UserRequest transitions")](https://www.itophub.io/wiki/media?media=3_0_0:release:object-details-banner-scrolled.png "3_0_0:release:object-details-banner-scrolled.png")

当向下滚动时，头部会缩小但在顶部仍然可见，因此始终可以访问这些操作。

### 选项卡

*   **属性** 选项卡显示对象的实际属性。
    
*   根据所显示对象的类别（例如 _工单_），可能会有一个额外的 **通知** 选项卡可用，显示响应此对象上的事件而发送的所有通知。
    
*   其他选项卡显示所选对象与数据库中其他对象之间的关系。
    
*   例如， **团队** 选项卡 显示所选人员所属的所有团队。**工单** 选项卡显示所选人员作为_请求者_的工单。
    
*   如果没有足够的空间来显示所有选项卡，则可以在位于选项卡行末尾的[![Other tabs icon](https://www.itophub.io/wiki/media?media=3_0_0:user:more-button.png "Other tabs icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:more-button.png "3_0_0:user:more-button.png")  下方访问其余选项卡。
    

[![](https://www.itophub.io/wiki/media?w=400&tok=f93ac0&media=3_0_0:user:tabs-vertical-classic-read.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-vertical-classic-read.png "3_0_0:user:tabs-vertical-classic-read.png") [![Horizontal & Scrollable in read mode](https://www.itophub.io/wiki/media?w=400&tok=f9468a&media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "Horizontal & Scrollable in read mode")](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "3_0_0:user:tabs-scrollable-not-loaded-tab.png")

有两种显示对象内容的方式，用户可以根据偏好进行选择。此导航设置适用于处于读取和编辑模式下所有的iTop对象。

_经典_:

*   一次只显示一个选项卡。
    
*  单击一个选项卡标题，可切换到另一个选项卡。
    

_滚动_:

*   所有选项卡都显示在同一页面中。
    
*  可以用鼠标滚动浏览，或单击选项卡标题。
    

* * *

对象修改
-------------------------

要修改对象，请从对象的详细信息中单击![Edit icon](https://www.itophub.io/wiki/media?media=3_0_0:user:pen-icon.png "Edit icon")图标操作(在只包含一个对象的列表中也可以使用相同的操作)。

用来修改对象的表单与对象的详情页非常相似。唯一的区别是这些字段是可编辑的。例如，修改 _人员_ 的表单如下所示:

[![Form for modifying an Person](https://www.itophub.io/wiki/media?w=600&tok=496d7a&media=3_0_0:user:modify-contact.png "Form for modifying an Person")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:modify-contact.png "3_0_0:user:modify-contact.png")

对于某些字段，值不是自由文本，而是必须要从下拉列表中选择:

[![Drop Down List](https://www.itophub.io/wiki/media?media=3_0_0:user:combo-field.png "Drop Down List")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:combo-field.png "3_0_0:user:combo-field.png")

**树形按钮** (![Tree Button](https://www.itophub.io/wiki/media?media=3_0_0:user:mini_tree.png "Tree Button")) 用来组织层次结构的值。

**加号按钮** ([![Plus](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Plus")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png")) 是创建对象并将其添加到列表的快捷方式。 该按钮仅对允许创建此类型对象的用户可用。例如，在创建或修改工单时，单击 **发起人** 字段的加号按钮([![Plus](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Plus")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png")) 。此时，显示的表单允许去创建一个新的人员：

[![New Person Popup Dialog](https://www.itophub.io/wiki/media?w=600&tok=f6c414&media=3_0_0:user:popup-new-contact.png "New Person Popup Dialog")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:popup-new-contact.png "3_0_0:user:popup-new-contact.png")

当必填字段为空时，或者当字段不遵循字段的预期格式(例如电子邮件地址)时，将出现红色消息。只有在正确填充所有字段时，才能保存对象的修改(使用**应用**按钮)。

当一个给定字段的可能值的数量超过了一个配置值(默认为50)，下拉列表将被一个 _自动填充_ 字段所取代，如下所示:

[![Autocomplete input](https://www.itophub.io/wiki/media?media=3_0_0:user:autocomplete-field.png "Autocomplete input")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:autocomplete-field.png "3_0_0:user:autocomplete-field.png")

输入至少 _三个字母_ 以触发搜索，并从与输入字母匹配的对象列表中选择，或使用放大镜按钮 ([![Magnifier Button](https://www.itophub.io/wiki/media?media=3_0_0:user:magnifier-button.png "Magnifier Button")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:magnifier-button.png "3_0_0:user:magnifier-button.png")) 打开一个查询对话框：

[![Popup dialog to search for Persons](https://www.itophub.io/wiki/media?w=600&tok=2d9c88&media=3_0_0:user:popup-select-contact.png "Popup dialog to search for Persons")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:popup-select-contact.png "3_0_0:user:popup-select-contact.png")

查询对话框列出了所有的对象。可以在选择对象之前使用顶部的表单，缩小搜索范围，然后单击**_确定_**返回到主表单。

当编辑一个HTML字段时， (_工单日志记录是HTML字段_)，包含一个嵌入式编辑器，查看[CKEditor site](https://ckeditor.com/docs/ckeditor4/latest/examples/classic.html "https://ckeditor.com/docs/ckeditor4/latest/examples/classic.html") 获取更多的信息。

对于文本和html字段，iTop提供了拼写检查，通过使用组合键 CTRL+鼠标右键。

活动面板
--------------

### 工单日志独立编辑

添加了一个新的面板，方便处理人只需要在日志条目中提供回复并可能应用变化的这种非常常见的情况。

*   为此，无需修改工单，可以直接输入回复并发送，同时如果需要，只需单击一次即可申请变化。

*   这个新选项只存在于控制台中，对于所有有工单日志的对象。

*   对于有多个工单日志的对象，如果修改了多个工单日志，则要求确认。
    

[![Icon to switch to log edition](https://www.itophub.io/wiki/media?w=400&tok=d66212&media=3_0_0:user:activity-panel-entry-form-icon.png "Icon to switch to log edition")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-entry-form-icon.png "3_0_0:user:activity-panel-entry-form-icon.png")[![Editing a log](https://www.itophub.io/wiki/media?w=350&tok=0f5c79&media=3_0_0:user:activity-panel-save-transition.png "Editing a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-save-transition.png "3_0_0:user:activity-panel-save-transition.png")[![Multi logs update confirmation](https://www.itophub.io/wiki/media?w=350&tok=c9345d&media=3_0_0:user:activity-panel-caselogs-multi-edition.png "Multi logs update confirmation")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs-multi-edition.png "3_0_0:user:activity-panel-caselogs-multi-edition.png")

### 历史记录过滤

在屏幕的这一部分，我们将其命名为“活动面板”，您可以检索日志和历史，它们都合并在一个时间轴中，这能够更有效地理解完整的历史。

*   可以过滤这个面板，去查看：
    
    *   **日志** 记录，你能够更好地过滤，去仅仅查看评论或私信
        
    *   **状态变化** 无论何时对象的状态变化
        
    *   **编辑** 当对象已创建或修改过时（也包括发送的通知）
        
*   在记录的旁边，显示用户照片(如果他们有照片的话)，否则显示的是他们的姓名首字母。
    

历史记录的时间戳是 **相对最近时间**, 例如：`3天前` ，当超过一周的时间则是**绝对时间**，_除非在你的 iTop 中是不同的配置_.

[![](https://www.itophub.io/wiki/media?w=400&tok=ff094d&media=3_0_0:user:activity-panel-mixed.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-mixed.png "3_0_0:user:activity-panel-mixed.png") [![](https://www.itophub.io/wiki/media?w=400&tok=4995e5&media=3_0_0:user:activity-panel-caselogs.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs.png "3_0_0:user:activity-panel-caselogs.png")[![](https://www.itophub.io/wiki/media?w=400&tok=7a7e5a&media=3_0_0:user:activity-panel-history-format.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-history-format.png "3_0_0:user:activity-panel-history-format.png")

### 提及用户

在控制台中，办理人可能希望快速通知工单日志中的某人以引起他们的注意。

*   这个人可能并没有关联到工单，但我们仍然希望通知到他们。
    
*   只需输入**@**和个人姓名的开头，就会提示可用的人员。
    
*   然后在提交包含“提及”的工单日志记录时，该人将收电子邮件通知。

*   同一个工单日志中可以提到多个人。
    

*   工单所提及的建议人选默认属于：
    
    *   工单所在组织的客户，
        
    *   或者与当前用户相同的组织。
        
*   能够通过修改[通知](https://www.itophub.io/wiki/page?id=3_0_0:admin:notifications#on_mention "3_0_0:admin:notifications")改变逻辑。
    

[![Result of a mention in log](https://www.itophub.io/wiki/media?w=350&tok=37d12e&media=3_0_0:user:mention-user-in-caselog.png "Result of a mention in log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog.png "3_0_0:user:mention-user-in-caselog.png")[![Mention someone in a log](https://www.itophub.io/wiki/media?w=350&tok=783385&media=3_0_0:user:mention-user-in-caselog-result.png "Mention someone in a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog-result.png "3_0_0:user:mention-user-in-caselog-result.png")

### 展开 & 折叠

活动面板能够展开或者折叠![Expand & collapse activity panel icons](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-expand-collapse-icons.png "Expand & collapse activity panel icons")  取决于办理人工作时是否需要读取和编辑工单日志或者是否需要修改工单本身。

[![](https://www.itophub.io/wiki/media?w=600&tok=4dc7a8&media=3_0_0:user:activity-panel-collapsed.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-collapsed.png "3_0_0:user:activity-panel-collapsed.png") [![](https://www.itophub.io/wiki/media?w=600&tok=78d45e&media=3_0_0:user:activity-panel-expanded.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-expanded.png "3_0_0:user:activity-panel-expanded.png")

### 并发访问

如果激活了 [concurrent\_lock\_enabled](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#c "3_0_0:admin:itop_configuration_file") 参数，阻止多个用户同时修改同一个对象，那么这个主题才适用。

*   如果用户输入一些文本，或者只是尝试在当前版本下的对象的活动面板中编辑工单日志，或者只是由另一个用户在工单日志版本下编辑案例，那么这个用户将收到一条简短的消息，让他知道只有在其他用户完成后他才能提交他的记录。注意，对于这个用户，`发送`按钮是灰色的。
    
*   iTop将每隔[activity\_panel.lock\_watcher\_period](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#a-b "3_0_0:admin:itop_configuration_file")秒进行检查，是否锁定已释放，如果已释放，它将再次锁定，但这次是针对这个用户, 并且会激活`发送`按钮，而不会丢失已经在工单日志中输入的文本。
    

[![Locked](https://www.itophub.io/wiki/media?w=340&tok=2e98fd&media=3_0_0:user:activity-panel-concurrent-lock.png "Locked")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-concurrent-lock.png "3_0_0:user:activity-panel-concurrent-lock.png")[![Unlocked](https://www.itophub.io/wiki/media?w=340&tok=e86139&media=3_0_0:user:activity-panel-concurrent-unlock.png "Unlocked")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-concurrent-unlock.png "3_0_0:user:activity-panel-concurrent-unlock.png")

* * *

**_处理工单附件_**
-------

附件模块允许将文档(任何文件或图像)上传到iTop，并将其“附加”到iTop中的给定对象。这与电子邮件附件非常相似。

附件与它们所附加的对象相关，当该对象从iTop中删除时，附件也将被删除。如果想将文件上传到iTop，并将它们“附加”到iTop中的对象上，那么可以考虑创建“文档”对象。参考 [文件文档](https://www.itophub.io/wiki/page?id=3_0_0:datamodel:itop-config-mgmt#document_file "3_0_0:datamodel:itop-config-mgmt").

当创建或修改一个工单时，管理工单的附件，点击 **_附件_** 标签页：

[![Ticket Attachments tab](https://www.itophub.io/wiki/media?w=600&tok=665466&media=3_0_0:user:tickets-attachments.png "Ticket Attachments tab")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments.png "3_0_0:user:tickets-attachments.png")

要上传一个新的附件，单击**_选择文件_**按钮并选择所需的文件。注意，单个上传文件的最大大小显示在**选择文件**按钮旁边。如果文件大于该值，则无法上传至iTop。这个最大大小取决于服务器上的几个设置，只能由管理员更改。

附件一旦上传，它们就会列在选项卡中，每个文件都有一个图标。附件的名称是下载的超链接。

使用在行末的回收站图标去删除一个附件。附件仅仅从当前对象（这里是一个工单）做了移除，但是从iTop中已完全删除。[![Delete attachment](https://www.itophub.io/wiki/media?w=600&tok=23aff7&media=3_0_0:user:tickets-attachments-delete.png "Delete attachment")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments-delete.png "3_0_0:user:tickets-attachments-delete.png")

当附件为图像时，当鼠标移动到附件图标上时，就会预览显示。

[![Attachment overview](https://www.itophub.io/wiki/media?w=600&tok=0423d6&media=3_0_0:user:tickets-attachments-overview.png "Attachment overview")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments-overview.png "3_0_0:user:tickets-attachments-overview.png")

对工单的修改（增加或者移除附件）实际上是点击 **应用** 按钮时执行的。对于工单表单，点击 **_取消_** 则会取消对于附件的任何修改。

## 拖拽

还可以通过直接在浏览器窗口上拖拽要附加的文件来添加附件。当文件被拖到“附件”选项卡上时，通常显示附件文件的区域周围会出现一个蓝色阴影:

[![Dragging files over the Attachments tab](https://www.itophub.io/wiki/media?w=600&tok=751e8a&media=3_0_0:user:attachments-drag-and-drop2.png "Dragging files over the Attachments tab")](https://www.itophub.io/wiki/media?media=3_0_0:user:attachments-drag-and-drop2.png "3_0_0:user:attachments-drag-and-drop2.png")

如果拖动时“附件”选项卡不是活动选项卡，则仍然可以将文件附加到工单上，并且在拖动操作时选项卡本身显示为蓝色阴影:

[![Dragging files with the attachment tab hidden](https://www.itophub.io/wiki/media?w=600&tok=0615bf&media=3_0_0:user:attachments-drag-and-drop1.png "Dragging files with the attachment tab hidden")](https://www.itophub.io/wiki/media?media=3_0_0:user:attachments-drag-and-drop1.png "3_0_0:user:attachments-drag-and-drop1.png")

**_管理对象关系_**
-------

在iTop中，显示在对象详细信息上的大多数选项卡表示了与对象之间的关系。所有这些关系都以相同的方式进行管理。

但有两种类型的关系，它们在后台的处理方式略有不同:

*   多个，例如“团队-个人”关系：在这种关系中，一个团队通常包含多个人员，一个人员可以属于**多个**团队

*   一个简单的关系，例如“经理-个人”关系：在这种关系中，经理可以管理多个人员，但一个人员永远不会超过**一个**经理
    

### 多个关系

一个“团队”的成员的修改表单类似这样：

#### 变更

[![Managing team members](https://www.itophub.io/wiki/media?w=600&tok=7c2ecd&media=3_0_0:user:team-relations.png "Managing team members")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relations.png "3_0_0:user:team-relations.png")

要用另一个成员更改一个团队成员，只需编辑要删除的成员的名称，并将其替换为要添加的成员的名称。

#### 增加

为了添加一个成员到团队：

*   点击在底部的“添加 个人 对象…” 按钮。显示将弹出查询表单去选择人员。
    
*   检查列表中期望的个人
    
*   并且点击“添加”返回主表单。
    

[![Adding Persons to a Team](https://www.itophub.io/wiki/media?w=600&tok=1e39d7&media=3_0_0:user:team-relation-add.png "Adding Persons to a Team")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relation-add.png "3_0_0:user:team-relation-add.png")

#### 移除

要从关系中删除对象，请选中表单中的相应行，然后单击底部的“移除对象”按钮。

[![Remove Persons from Team](https://www.itophub.io/wiki/media?w=600&tok=44a953&media=3_0_0:user:team-relation-remove.png "Remove Persons from Team")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relation-remove.png "3_0_0:user:team-relation-remove.png")

注意，从关系中删除对象并不实际从iTop中删除这些对象。只删除对象之间的_关系_。

如果取消当前对象的编辑，将不会保存对关系(添加和删除)的修改。
但是如果您使用+图标创建了一个新对象，那么无论您在当前对象版本上做什么，该对象都会创建。

### 简单关系

在工单上，我们也有类似于“父子”关系，如：经理-个人关系。一个工单可以有**0个或1个**父，而一个父对象可以有0到多个子对象。
另一种简单关系是ConnectableCI上的Interfaces子对象，其中每个子对象**必须有一个**父对象，没有它就不能存在。

*   这样的子对象只能链接到**一个**父对象，所以如果已经有一个父对象，它将被更改，而不能只是添加。
    
[![Adding n:1 relations on Tickets](https://www.itophub.io/wiki/media?w=600&tok=1ac48c&media=3_0_0:user:tickets-relations-n-1-add.png "Adding n:1 relations on Tickets")](https://www.itophub.io/wiki/media?media=3_0_0:user:tickets-relations-n-1-add.png "3_0_0:user:tickets-relations-n-1-add.png")

*   点击“添加 xxxx” 按钮，显示一个弹出的窗口去查询久远的对象
    
*   设置可选的过滤条件
    
*   点击 ![](https://www.itophub.io/wiki/media?media=3_0_0:user:search-refresh-btn.png) 按钮刷新列表。
    
*   确保在希望添加的行的开头的选择框，进行了选择，
    
*   点击“添加”按钮验证你的选择，并且关闭对话框。
    
*   选择的对象将被修改，并且将指向当前的对象， 该情况将在相应的选项卡中可见。
    

[![Managing n:1 relations on Tickets](https://www.itophub.io/wiki/media?w=600&tok=e14557&media=3_0_0:user:tickets-relations-n-1.png "Managing n:1 relations on Tickets")](https://www.itophub.io/wiki/media?media=3_0_0:user:tickets-relations-n-1.png "3_0_0:user:tickets-relations-n-1.png")

要从当前工单中移除相关工单，只需选中相应的复选框，然后单击“移除”。

注意，从关系中删除对象并不会从iTop中删除这些对象。只重置对象之间的_关系_。(在相关的工单上指向当前工单的字段会重置)

>> →下一篇：[对象显示和修改](../05-Actions/) 

---
原文：<https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification>

版本：3_0_0/user/display_and_modification.txt · Last modified: 2022/01/21 16:52 (external edit)
