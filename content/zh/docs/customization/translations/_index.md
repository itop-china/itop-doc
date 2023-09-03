---
title: "如何翻译"
linkTitle: "如何翻译"
date: 2023-09-03
weight: 1
description: >
    <br> ➡️ 介绍如何对iTop语言进行本地化
---

## 原则

在 iTop 和 iTop 模块中，语言由两个要素确定：

* ISO 639-1 语言代码。例如：pt 表示葡萄牙语。
* ISO 国家代码。例如：br 表示巴西。

本地化依赖于字典文件，这些文件的名称以小写语言代码作为前缀，例如：`pt_br.dictionary.itop.core.php`。这些文件是数据模型的一部分，因此在每次修改后都需要进行编译（重新运行安装或使用工具包）。

在 iTop 中，嵌入的字典文件位于以下位置：

* `<itop-root>/dictionaries/`
* `<itop-root>/datamodels/2.x/<module>/dictionaries`

在模块中，这些文件位于模块的根目录。

自 iTop 3.0.0（N°2969）起，模块的字典文件可以位于模块的根文件夹或名为 `dictionaries` 的子文件夹中。

出于兼容性原因，作为扩展分发的模块保留了它们的字典文件在根文件夹中的方式，但iTop核心模块（datamodels/2.x）已经进行了修改。

## 字典文件格式

字典实际上是一个PHP文件。它必须以UTF-8字符集编码（这是必须的）。我们建议像下面的示例一样省略PHP的结束标记：

```
<?php
/\*\*
 \* Localized data
 \*
 \* @copyright   Copyright (C) 2015 John Foo Ltd
 \* @author      John Foo (john@foo.com)
 \* @license     http://opensource.org/licenses/AGPL-3.0
 \*/

Dict::Add('PT BR', 'Brazilian', 'Portuguese', array(
        'Menu:ChangeManagement' => 'Gerenciamento Mudanças',
        'Menu:Change:Overview' => 'Visão geral',
        'Menu:NewChange' => 'New Change~~',
));
```

注意事项：

* 函数调用的第一个参数是大写的语言代码。
* 函数调用的第二个参数是英语中的语言名称。
* 函数调用的第三个参数是目标语言中的语言名称。
* `Dict::Add` 函数的行在所有相同语言的字典文件中必须相同（是的，这里有冗余信息）。
* 请注意某些字符串末尾的 `~~`。这个后缀不会显示给最终用户。它由Combodo在发布新版本时添加，用于显示哪些新字符串需要翻译。
    
## 一些通用规则

一些通用规则：

*  **保持一致性：** 重复使用已经翻译的术语（例如，“经理”是许多关键词中使用的词汇）。
*  **英文术语：** 如果在上下文中更容易理解，可以保留英文术语。
*  **避免过于口语化的表述：** iTop是一款既被公司使用又被其客户使用的产品。
*  **不要硬编码“iTop”名称：** 使用常量（它们在 `core/config.class.inc.php` 中定义）：
   *  `ITOP_APPLICATION`：应用程序包的完整名称，例如“iTop Community”或“iTop Professional”。
   *  `ITOP_APPLICATION_SHORT`：应用程序的名称，例如“iTop”。
*  **类名命名方式：** 使用驼峰命名法。
*  **数据模型项目命名标准：** `Class:<classname>`、`Class:<classname>/Attribute:<fieldname>`。例如：`Class:Ticket`、`Class:Ticket/Attribute:ref`、`Class:UserRequest/Attribute:status/Value:new`。
*  **字段标签翻译：** 请在定义字段的类中进行翻译，而不是在子类中进行。例如，对于 `Class:Ticket/Attribute:ref` 是可以的，但对于 `Class:Change/Attribute:ref` 则不应该。如果需要后者，可以使用自定义模块将其添加到您的iTop实例中。
*  **操作标签中的类别：** 尽量不要在通用用户的操作标签中提及类别。但对于管理员用户可以这样做。如果使用类别标签，请将其大写化，例如将“notification”改为“Notification”。
*  **特殊条目 `Class:<classname>/Attribute:friendlyname`：** 在英文中显示为“Full name”，如果没有翻译，它不对应于特定的类字段，而是对应于用作外部键、对象列表和对象详情中的对象标签的魔法属性。

这些规则有助于维护和确保翻译的一致性。

| Key syntax                                    | Purpose                                        | Example                            |
| -------------------------------------------- | ---------------------------------------------- | ---------------------------------- |
| Class:&lt;classname&gt;                        | Translating the **name** of a class            | Class:Ticket                       |
| Class:&lt;classname&gt;/Attribute:&lt;fieldname&gt; | Translating a field **label**                   | Class:Ticket/Attribute:ref         |
| Class:&lt;classname&gt;/Attribute:&lt;fieldname&gt;/Value:&lt;value&gt; | Translating a **value** of an Enum attribute   | Class:UserRequest/Attribute:status/Value:new |
| Class:&lt;classname&gt;/Attribute            | Formatting the friendlyname **value**. (*see example below*) | 'Class:Person/Name' ⇒ '%2$s %1$s' |




_Friendlyname 语法_: 在这个示例中

```
'Class:Person/Name' \=> '%2$s, %1$s',  /\* example: "Christie, Agatha" \*/ 
```

*   `%1$s` 对应于Person类的命名XML标签中的第一个字段，因此是 `first_name`。
*   `%2$s` 对应于Person类的命名XML标签中的第二个字段，因此是 `name`。

这允许指定不同的顺序，并且甚至是一些其他字符和分隔符。

您可以通过以下链接获取有关 friendlyname 的更多信息：[friendlyname](https://www.itophub.io/wiki/page?do=export_code&id=3_1_0:customization:translation&codeblock=2 "Download Snippet")。

```
<classes\>
  <class id\="Person"\>
     <properties\>
        <naming\>
          <attributes\>
            <attribute id\="first\_name"/> <!-- mapped to %1$s -->
            <attribute id\="name"/>       <!-- mapped to %2$s -->
          </attributes\>
        </naming\>
```

## 字典关键词的命名约定

新条目的命名应根据其领域和目的，从最不具体的信息开始命名。

最常用的分隔符是':'，但也可以找到'/'和'-'。

```
'Core:BulkExport:TextFormat' \=> 'Text fields containing some HTML markup',
'UI:CSVImport:TextQualifierCharacter' \=> 'Text qualifier character',
'DayOfWeek-Sunday-Min' \=> 'Su',
```

使用后缀来定义相同标签的变种：

*   `+` 表示短描述（通常显示在工具提示中）
*   `?` 表示帮助/解释（可以跨多行）
    

```
'Core:SynchroAtt:update' \=> 'Update ?',
'Core:SynchroAtt:update+' \=> 'Used to update the object',
 
'UI:CSVImport:AdvancedMode' \=> 'Advanced mode',
'UI:CSVImport:AdvancedMode+' \=> 
  'In advanced mode the "id" (primary key) of the objects can be used to update and rename objects.'
  .'However the column "id" (if present) can only be used as a search criteria'
  .' and can not be combined with any other search criteria.',
```

当建立了命名约定后，标识符应该指定为 <name>:<value>，就像以下示例中的方式：

```
'Class:Event/Attribute:date' \=> 'Date',
'Class:Event/Attribute:date+' \=> 'date and time at which the changes have been recorded',
```

请注意，在这种情况下，分隔符应该是 '/'。

#### 枚举值

枚举或枚举集的值使用自己的语法：

```
  'Class:Action/Attribute:status/Value:test'      \=> 'Being tested',
        'Class:Action/Attribute:status/Value:test+'     \=> 'Action has maybe a different behavior than when in production',
        'Class:Action/Attribute:status/Value:enabled'   \=> 'In production',
        'Class:Action/Attribute:status/Value:enabled+'  \=> '',
        'Class:Action/Attribute:status/Value:disabled' \=> 'Inactive',
        'Class:Action/Attribute:status/Value:disabled+' \=> 'Action is not effective',
```

#### 实体覆盖

子类可以覆盖属性（或值）的标签/工具提示，即使该属性已在其父类之一中定义。

```
  'Class:ActionEmail/Attribute:status/Value:test+'       \=> 'Only the Test recipient is notified',
        'Class:ActionEmail/Attribute:status/Value:enabled+'    \=> 'All To, Cc and Bcc emails are notified',
        'Class:ActionEmail/Attribute:status/Value:disabled+'   \=> 'The email notification will not be sent',
        'Class:ActionEmail/Attribute:test\_recipient'           \=> 'Test recipient',
```

### 关系

默认链接相关的操作/图标工具提示、弹出窗口标题和确认消息如下所示。

它们可以根据需要进行自定义，甚至可以根据类别/关联设置属性进行定制化（请参阅下文）。

#### 1:n 关系

| 通用字典条目代码                   | 用途                                                       | 英文             | 法文                    |
| ------------------------------- | ---------------------------------------------------------- | ----------------- | ----------------------- |
| UI:Links:Create:Button+         | 列表右上角的<strong>加号图标</strong>工具提示                       | Create a %4$s         | Créer un(e) %4$s         |
| UI:Links:Create:Modal:Title     | <strong>子对象创建</strong>弹出窗口标题                             | Create a %4$s in %2$s | Ajouter un(e) %4$s à %2$s |
| UI:Links:ModifyObject:Button+   | 行右端的<strong>铅笔图标</strong>工具提示                            | Modify this object       | Modifier cet objet       |
| UI:Links:ModifyObject:Modal:Title | <strong>子对象修改</strong>弹出窗口标题                             | Modify %5$s        | Modifier %5$s           |
| UI:Links:Remove:Button+         | 行右端的<strong>减号图标</strong>工具提示                            | Remove this %4$s      | Retirer cet(te) %4$s     |
| UI:Links:Remove:Modal:Title     | <strong>子对象从其宿主中移除</strong>弹出窗口标题                      | Remove a %4$s from its %1$s | Retirer un(e) %4$s de son/sa %1$s |
| UI:Links:Remove:Modal:Message   | <strong>子对象移除</strong>的确认消息                             |Do you really want to remove %5$s from %2$s? | Voulez vous vraiment retirer %5$s de %2$s？ |
| UI:Links:Delete:Button+         | 行右端的<strong>垃圾桶图标</strong>工具提示                          | Delete this %4$s        | Supprimer cet(te) %4$s   |
| UI:Links:Delete:Modal:Title     | <strong>子对象删除</strong>弹出窗口标题                             | Delete a %4$s       | Supprimer un(e) %4$s     |
| UI:Links:Delete:Modal:Message   | <strong>子对象删除</strong>的确认消息                             | Do you really want to delete %5$s? | Voulez vous vraiment supprimer %5$s？ |


#### n:n 关系

| 通用字典条目代码                   | 用途                                                       | 英文                             | 法文                            |
| ------------------------------- | ---------------------------------------------------------- | -------------------------------- | ------------------------------- |
| UI:Links:Add:Button+            | 列表右上角的<strong>加号图标</strong>工具提示                     | Add a %4$s                      | Ajouter un %4$s                  |
| UI:Links:Add:Modal:Title        | <strong>链接创建</strong>弹出窗口标题                             | Add a %4$s to %2$s               | Ajouter un %4$s à %2$s           |
| UI:Links:ModifyLink:Button+    | 行右端的<strong>铅笔图标</strong>工具提示                          | Modify this link                 | Modifier cette relation          |
| UI:Links:ModifyLink:Modal:Title | <strong>链接修改</strong>弹出窗口标题                             | Modify the link between %2$s and %5$s | Modifier la relation entre %2$s et %5$s |
| UI:Links:Remove:Button+         | 行右端的<strong>减号图标</strong>工具提示                          | Remove this %4$s                 | Retirer ce %4$s                  |
| UI:Links:Remove:Modal:Title     | <strong>链接删除</strong>弹出窗口标题                             | Remove %4$s                      | Retirer un %4$s                  |
| UI:Links:Remove:Modal:Message   | <strong>链接删除</strong>的确认消息                             | Do you really want to remove %5$s from %2$s? | Voulez vous vraiment retirer %5$s de %2$s？ |

##### 占位符

*   **$%1s**: 宿主对象类名称（本地化）
    
*   **$%2s**: 宿主对象友好名称
    
*   **$%3s**: 宿主对象内的当前标签名称（本地化）
    
*   **$%4s**: 远程对象类名称（本地化）
    
*   **$%5s**: 远程对象友好名称 _注意：并非所有情况下都可用，需要检查！_

##### Specialized

除非为给定类的特定LinkedSet（或LinkedSetIndirect）属性定义了更具体的条目，否则使用上面的通用条目代码。

以下是考虑法语中类别属性的覆盖逻辑示例：

```
Dict::Add('FR FR', 'French', 'Français', [array](http://www.php.net/array)(
        'Class:Person/Attribute:team\_list/UI:Links:Add:Button+'         \=> 'Ajouter une %4$s',
        'Class:Person/Attribute:team\_list/UI:Links:Add:Modal:Title'     \=> 'Ajouter une %4$s à %2$s',
        'Class:Person/Attribute:team\_list/UI:Links:Remove:Button+'      \=> 'Retirer cette %4$s',
        'Class:Person/Attribute:team\_list/UI:Links:Remove:Modal:Title'  \=> 'Retirer une %4$s',
        'Class:Team/Attribute:persons\_list/UI:Links:Add:Button+'        \=> 'Ajouter une %4$s',
        'Class:Team/Attribute:persons\_list/UI:Links:Add:Modal:Title'    \=> 'Ajouter une %4$s à %2$s',
        'Class:Team/Attribute:persons\_list/UI:Links:Remove:Button+'     \=> 'Retirer cette %4$s',
        'Class:Team/Attribute:persons\_list/UI:Links:Remove:Modal:Title' \=> 'Retirer une %4$s'
));
```

### 最终用户门户

如果您添加了一个新的终端用户门户，您可能希望创建一个字典条目，以便为其创建一个真实的标签，要做到这一点，请按照以下语法进行操作：

```
// Default portal
'portal:itop-portal' \=> 'Standard portal',
'portal:<YOUR\_PORTAIL\_ID>' \=> 'Your new portal label',
```

### UI 主题

如果您为后台创建了一个新主题，您可能希望创建一个字典条目，以便用户在首选项页面中选择它时能够获得一个漂亮的标签。要做到这一点，请按照以下语法进行操作：
```
// Default theme
'theme:fullmoon' \=> 'Full Moon 🌕',
'theme:<YOUR\_THEME\_ID>' \=> 'Your new theme label',
```

## 如何贡献改进现有语言

要改进现有语言，您需要执行以下步骤：

1. 从[iTop主存储库](https://github.com/Combodo/iTop "https://github.com/Combodo/iTop")或相关的模块存储库创建一个分支（Fork）。

2. 在您的分支上进行修改，并按需改进现有语言的翻译。

3. 提交拉取请求（Pull Request）：有关详细的提交步骤，请查看您正在修改的存储库中的CONTRIBUTING.md文件。GitHub的帮助页面也提供了关于[从分支创建拉取请求](https://help.github.com/articles/creating-a-pull-request-from-a-fork/ "https://help.github.com/articles/creating-a-pull-request-from-a-fork/")的详细信息。

**为现有语言添加翻译**：使用 grep 命令查找包含 ~~ 的文本，并在原地进行翻译。

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">
>> 以下是在Linux命令行中查找包含 ~~ 标记的德语（de）字典条目的快速命令：<br>
>> ``` find -name "de*dict*.php" | grep -v "env-" | xargs grep "~~" ``` <br>
>> 要查找其他语言的字典条目，只需将命令中的 de* 更改为您想处理的语言代码（例如fr、it、sp等），然后从安装iTop的目录运行此命令。这将帮助您找到包含 ~~ 标记的文本行，以便进行翻译。
</font>

**为新语言添加翻译**：首先找到您的语言代码和国家代码。然后将英语文件（dictionary.\*.php或en.dict.\*.php）复制到相应的目录中，并使用相关的前缀（例如，`pt_br.dict…`）。然后对这些文件进行翻译。

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">不要忘记修改 `Dict::Add` 函数调用的参数。如果不这样做，将在运行时用您的翻译覆盖英语文本。</font>

提交的拉取请求将由Combodo的维护人员进行分析，并最终合并到原始存储库中。

---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:customization:translation>

版本：3_1_0/customization/translation.txt · Last modified: 2023/07/21 10:19 (external edit)
