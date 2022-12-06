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


显示
-------

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

Modification of an object
-------------------------

To modify an object, click on the ![Edit icon](https://www.itophub.io/wiki/media?media=3_0_0:user:pen-icon.png "Edit icon") action, from the details of the object (The same action is also available on a list containing only one object).

The form used to modify an object is quite similar to its details. The only difference is that the fields are editable. For example, the form to modify a _Person_ is displayed as shown below:

[![Form for modifying an Person](https://www.itophub.io/wiki/media?w=600&tok=496d7a&media=3_0_0:user:modify-contact.png "Form for modifying an Person")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:modify-contact.png "3_0_0:user:modify-contact.png")

For some of the fields, the value is not a free-text but instead must be picked from a drop-down list:

[![Drop Down List](https://www.itophub.io/wiki/media?media=3_0_0:user:combo-field.png "Drop Down List")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:combo-field.png "3_0_0:user:combo-field.png")

The **treeview button** (![Tree Button](https://www.itophub.io/wiki/media?media=3_0_0:user:mini_tree.png "Tree Button")) is available for values that are organized as a hierarchy.

The **plus button** ([![Plus](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Plus")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png")) is a shortcut to create an object and add it to the list. The button is only available for users who are allowed to create this type of object. For example, when creating or modifying a ticket, click on the ([![Plus](https://www.itophub.io/wiki/media?media=3_0_0:user:plus-button.png "Plus")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:plus-button.png "3_0_0:user:plus-button.png")) button of the field **Caller**. The form is displayed to enable to create a new Person:

[![New Person Popup Dialog](https://www.itophub.io/wiki/media?w=600&tok=f6c414&media=3_0_0:user:popup-new-contact.png "New Person Popup Dialog")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:popup-new-contact.png "3_0_0:user:popup-new-contact.png")

A red message appears when a mandatory field is left blank, or when a field does not follow the expected format for the field (for example for an email address). The modifications to the object can only be saved (using the **Apply** button) if all the fields are properly filled.

When the number of possible values for a given field exceeds a configured value (50 by default), the drop-down list is replaced by an _autocomplete_ field, as shown below:

[![Autocomplete input](https://www.itophub.io/wiki/media?media=3_0_0:user:autocomplete-field.png "Autocomplete input")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:autocomplete-field.png "3_0_0:user:autocomplete-field.png")

Type at least _three letters_ to trigger the search and pick from the list of objects matching the typed letters, or use the magnifying glass button ([![Magnifier Button](https://www.itophub.io/wiki/media?media=3_0_0:user:magnifier-button.png "Magnifier Button")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:magnifier-button.png "3_0_0:user:magnifier-button.png")) to open a searchdialog:

[![Popup dialog to search for Persons](https://www.itophub.io/wiki/media?w=600&tok=2d9c88&media=3_0_0:user:popup-select-contact.png "Popup dialog to search for Persons")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:popup-select-contact.png "3_0_0:user:popup-select-contact.png")

The search dialog lists all the objects. To narrow the search you can use the form at the top _before selecting an object_ and click on **_Ok_** to return to the main form.

When editing an HTML field, (_Caselog entry are HTML field_), an embedded editor is included, check [CKEditor site](https://ckeditor.com/docs/ckeditor4/latest/examples/classic.html "https://ckeditor.com/docs/ckeditor4/latest/examples/classic.html") for its possibilities.

For text and html fields, iTop provides a spelling checker by pressing CTRL + right-click

Activity Panel
--------------

### Caselog edition alone

A new panel has been added, to speed-up a pretty common situation in which the agent just need to provide a reply within a log entry and maybe apply a transition.

*   For this, instead of modifying the Ticket, he can directly enter his reply and send it, while applying in a single click a transition if required.
    
*   This new option exists within the console only, for all objects having a caselog.
    
*   For objects having multiple caselogs a confirmation is requested if more than one has been modified.
    

[![Icon to switch to log edition](https://www.itophub.io/wiki/media?w=400&tok=d66212&media=3_0_0:user:activity-panel-entry-form-icon.png "Icon to switch to log edition")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-entry-form-icon.png "3_0_0:user:activity-panel-entry-form-icon.png")[![Editing a log](https://www.itophub.io/wiki/media?w=350&tok=0f5c79&media=3_0_0:user:activity-panel-save-transition.png "Editing a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-save-transition.png "3_0_0:user:activity-panel-save-transition.png")[![Multi logs update confirmation](https://www.itophub.io/wiki/media?w=350&tok=c9345d&media=3_0_0:user:activity-panel-caselogs-multi-edition.png "Multi logs update confirmation")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs-multi-edition.png "3_0_0:user:activity-panel-caselogs-multi-edition.png")

### History filtering

In this part of the screen, that we have named the “activity panel”, you retrieve the logs and the history, all merged in a single timeline, which makes it more efficient to understand the full history.

*   You can filter this panel, to view:
    
    *   **log** entries, which you can filter more, to view only the public or the private log
        
    *   **state changes** whenever the object has changed state
        
    *   **edit** when the object was created or modified (includes notification sent as well)
        
*   Next to the entry, the user picture, if they have one, is displayed, otherwise it is their initials.
    

The history timestamps are **relative when recent**, eg: `3 days ago` and **absolute** when older than a week, _unless configured differently on your iTop_.

[![](https://www.itophub.io/wiki/media?w=400&tok=ff094d&media=3_0_0:user:activity-panel-mixed.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-mixed.png "3_0_0:user:activity-panel-mixed.png") [![](https://www.itophub.io/wiki/media?w=400&tok=4995e5&media=3_0_0:user:activity-panel-caselogs.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs.png "3_0_0:user:activity-panel-caselogs.png")[![](https://www.itophub.io/wiki/media?w=400&tok=7a7e5a&media=3_0_0:user:activity-panel-history-format.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-history-format.png "3_0_0:user:activity-panel-history-format.png")

### Mention user

In the console an agent may want to quickly notify someone within a caselog to get their attention.

*   That person may not be linked to the Ticket, but still we want to notify them.
    
*   Just type **@** and the beginning of the person name, you will be prompt with available persons.
    
*   Then at submission of the caselog entry containing a `mention`, the person will receive an email notification.
    
*   Multiple persons can be mentioned in the same caselog.
    

*   The proposed persons to be mentioned on a Ticket are by default those belonging to
    
    *   the customer organization of the Ticket
        
    *   or to same organization as the current user.
        
*   That logic can be changed by modifying the [Notification](https://www.itophub.io/wiki/page?id=3_0_0:admin:notifications#on_mention "3_0_0:admin:notifications")
    

[![Result of a mention in log](https://www.itophub.io/wiki/media?w=350&tok=37d12e&media=3_0_0:user:mention-user-in-caselog.png "Result of a mention in log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog.png "3_0_0:user:mention-user-in-caselog.png")[![Mention someone in a log](https://www.itophub.io/wiki/media?w=350&tok=783385&media=3_0_0:user:mention-user-in-caselog-result.png "Mention someone in a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog-result.png "3_0_0:user:mention-user-in-caselog-result.png")

### Expand & collapse

The activity panel can be collapsed or expanded ![Expand & collapse activity panel icons](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-expand-collapse-icons.png "Expand & collapse activity panel icons")  
Depending if the agent work requires to read and edit the caselog(s) or to modify the Ticket it-self

[![](https://www.itophub.io/wiki/media?w=600&tok=4dc7a8&media=3_0_0:user:activity-panel-collapsed.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-collapsed.png "3_0_0:user:activity-panel-collapsed.png") [![](https://www.itophub.io/wiki/media?w=600&tok=78d45e&media=3_0_0:user:activity-panel-expanded.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-expanded.png "3_0_0:user:activity-panel-expanded.png")

### Concurrent access

This topic only applies, if you have activated the [concurrent\_lock\_enabled](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#c "3_0_0:admin:itop_configuration_file") parameter to prevent multiple users modifying at the same time, the same object.

*   If a user enter some text or just try to edit a caselog in the activity panel of an object currently under edition, or simply under caselog edition by another user, then the first user receive a small message to let him know that he will only be able to submit his entries once the other user will have finished. Notice that the `Send` button is greyed for that first user.
    
*   iTop will check every [activity\_panel.lock\_watcher\_period](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#a-b "3_0_0:admin:itop_configuration_file") seconds, if the lock was released or not, and if it was, it will lock it again but for the first user this time and activate the `Send` button, without loosing the text already entered in the caselog(s)
    

[![Locked](https://www.itophub.io/wiki/media?w=340&tok=2e98fd&media=3_0_0:user:activity-panel-concurrent-lock.png "Locked")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-concurrent-lock.png "3_0_0:user:activity-panel-concurrent-lock.png")[![Unlocked](https://www.itophub.io/wiki/media?w=340&tok=e86139&media=3_0_0:user:activity-panel-concurrent-unlock.png "Unlocked")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-concurrent-unlock.png "3_0_0:user:activity-panel-concurrent-unlock.png")

* * *

Handling Tickets Attachments
============================

Attachments allow to upload a document (any file or image) into iTop and “attach” it to a given object in iTop. This is very similar to email attachments.

Attachments are related to the object they are attached to, and will be deleted when the object is deleted from iTop. If you want to upload files into iTop and have them “attached” to several objects in iTop, then consider creating “Document” objects. Refer to [File documents](https://www.itophub.io/wiki/page?id=3_0_0:datamodel:itop-config-mgmt#document_file "3_0_0:datamodel:itop-config-mgmt").

To manage the attachments to a Ticket, click on the **_Attachments_** tab while creating or modifying a Ticket:

[![Ticket Attachments tab](https://www.itophub.io/wiki/media?w=600&tok=665466&media=3_0_0:user:tickets-attachments.png "Ticket Attachments tab")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments.png "3_0_0:user:tickets-attachments.png")

To upload a new attachment, click on the **_Select a file_** button and select the desired file. Note that the maximum size for a single uploaded file is displayed next to the **Select a file** button. If a file is bigger than this value, it cannot be uploaded into iTop. This maximum size depends on several settings on the server and can be changed only by an administrator.

Once attachments have been uploaded they are listed in the tab, with one icon per file. The name of the attachment is an hyperlink to download it.

Use the trash icon, at the end of the row to delete an attachment. It is not only removed from the current object (here a ticket) but fully deleted from iTop. [![Delete attachment](https://www.itophub.io/wiki/media?w=600&tok=23aff7&media=3_0_0:user:tickets-attachments-delete.png "Delete attachment")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments-delete.png "3_0_0:user:tickets-attachments-delete.png")

When the attachments is an image, then a preview will be shown anytime the mouse moves over the attachment icon.

[![Attachment overview](https://www.itophub.io/wiki/media?w=600&tok=0423d6&media=3_0_0:user:tickets-attachments-overview.png "Attachment overview")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:display_and_modification&media=3_0_0:user:tickets-attachments-overview.png "3_0_0:user:tickets-attachments-overview.png")

The changes to the Ticket (addition or removal of attachments) are actually performed when the **Apply** button is clicked. Clicking on **_Cancel_** for the Ticket form will cancel any change to the attachments.

Drag and drop
-------------

Attachments can also be added by performing a drag drop of the files to attach, directly over the browser's window. When files are dragged over the “Attachments” tab, a blue shadow appears around the area where attached files are normally displayed:

[![Dragging files over the "Attachments" tab](https://www.itophub.io/wiki/media?w=600&tok=751e8a&media=3_0_0:user:attachments-drag-and-drop2.png "Dragging files over the "Attachments" tab")](https://www.itophub.io/wiki/media?media=3_0_0:user:attachments-drag-and-drop2.png "3_0_0:user:attachments-drag-and-drop2.png")

If the “Attachments” tab is not the active one when dragging, files can still be attached to the ticket and the tab itself shows the blue shadow during the drag operation:

[![Dragging files with the attachment tab hidden](https://www.itophub.io/wiki/media?w=600&tok=0615bf&media=3_0_0:user:attachments-drag-and-drop1.png "Dragging files with the attachment tab hidden")](https://www.itophub.io/wiki/media?media=3_0_0:user:attachments-drag-and-drop1.png "3_0_0:user:attachments-drag-and-drop1.png")

Managing Objects Relations
==========================

In iTop most of the tabs displayed on the details of an object represent relations between objects. All these relations are managed in the same manner.  

But there are two flavors of relationships, which are handled slightly differently in the background:

*   A multiple such as the “team-person” relationship: in which a Team usually contains multiple Persons and a Person can belong to **multiple** Teams
    
*   A simple such as the “manager-person” relationship: in which the Manager can manage multiple Persons, but a Person has never more than **one** Manager
    

### Multiple relationship

The form to modify the members of a “Team” looks like this:

#### Change

[![Managing team members](https://www.itophub.io/wiki/media?w=600&tok=7c2ecd&media=3_0_0:user:team-relations.png "Managing team members")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relations.png "3_0_0:user:team-relations.png")

To change a team member by another one, just edit the name of the member to-remove and replace it by the name of the member to-add.

#### Add

In order to add members to the team:

*   click on the “Add Persons…” button at the bottom. This displays - as a popup - the search form to select Persons.
    
*   Check the desired persons in the list
    
*   and click “Add” to go back to the main form.
    

[![Adding Persons to a Team](https://www.itophub.io/wiki/media?w=600&tok=1e39d7&media=3_0_0:user:team-relation-add.png "Adding Persons to a Team")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relation-add.png "3_0_0:user:team-relation-add.png")

#### Remove

To remove objects from the relation, check the corresponding line in the form, then click on the “Remove selected objects” button at the bottom.

[![Remove Persons from Team](https://www.itophub.io/wiki/media?w=600&tok=44a953&media=3_0_0:user:team-relation-remove.png "Remove Persons from Team")](https://www.itophub.io/wiki/media?media=3_0_0:user:team-relation-remove.png "3_0_0:user:team-relation-remove.png")

Note that removing objects from the relation does not actually delete these objects from iTop. Only the _relation_ between the objects is removed.

Modification on relationships (added and removed) will not be saved if you cancel the current object edition.  
But if you have created a new object using the + icon, that object is created regardless of what you do on the current object edition.

### Simple relationship

On Tickets also we have the equivalent of the Manager-Person relationship with a “parent-child” relation. A Ticket can have **zero or one** parent, while a parent can have from zero to many children.  
Another flavor of simple relationship is the Interfaces sub-objects on a ConnectableCI, where each sub-object **must have one** parent and cannot exist without it.

*   Such sub-object can only be linked to a **single** parent object, so if there was one already it will be changed and not only added
    

[![Adding n:1 relations on Tickets](https://www.itophub.io/wiki/media?w=600&tok=1ac48c&media=3_0_0:user:tickets-relations-n-1-add.png "Adding n:1 relations on Tickets")](https://www.itophub.io/wiki/media?media=3_0_0:user:tickets-relations-n-1-add.png "3_0_0:user:tickets-relations-n-1-add.png")

*   Press the “Add xxxx” button which displays a pop-up window to search for the remote objects
    
*   Set optional filtering criterion
    
*   Press the ![](https://www.itophub.io/wiki/media?media=3_0_0:user:search-refresh-btn.png) button to refresh the list.
    
*   Make your choice by checking the checkboxes at the beginning of the row you want to add,
    
*   Press the “Add” button to validate your choice(s) and dismiss the dialog.
    
*   The selected objects will be modified and will point to the current object and that situation will be visible in the corresponding tab.
    

[![Managing n:1 relations on Tickets](https://www.itophub.io/wiki/media?w=600&tok=e14557&media=3_0_0:user:tickets-relations-n-1.png "Managing n:1 relations on Tickets")](https://www.itophub.io/wiki/media?media=3_0_0:user:tickets-relations-n-1.png "3_0_0:user:tickets-relations-n-1.png")

To detach related tickets from the current ticket, just select them by checking the corresponding checkbox and click on “Remove”.

Note that removing objects from the relation does not delete these objects from iTop. Only the _relation_ between the objects is reset. (On the related Ticket the field that was pointing to the current Ticket is reset)

← [The main screen](https://www.itophub.io/wiki/page?id=3_0_0:user:main "3_0_0:user:main")  

[User Manual](https://www.itophub.io/wiki/page?id=3_0_0:user:start "3_0_0:user:start")  

 [Actions](https://www.itophub.io/wiki/page?id=3_0_0:user:actions "3_0_0:user:actions") →

3\_0\_0/user/display\_and\_modification.txt · Last modified: 2022/01/21 16:52 (external edit)
