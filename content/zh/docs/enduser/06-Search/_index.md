---
title: "搜索"
linkTitle: "搜索"
date: 2022-11-09
weight: 6
description: >
      <br> ➡️ 介绍了对象的搜索操作。
---

**---搜索---**
-------

在iTop中，大多数对象的详细信息中都可以看到搜索图标 ([![Search icon](https://www.itophub.io/wiki/media?media=3_0_0:user:search-icon.png "Search icon")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:search&media=3_0_0:user:search-icon.png "3_0_0:user:search-icon.png")) ，单击此图标会切换到多条件搜索表单。
搜索表单中的所有条件都会使用**AND 操作符**进行组合。这意味着在搜索工单时，如果指定**Claude Monet**为发起人以及一组状态，搜索结果将列出所有符合这些条件的工单。

[![A search result](https://www.itophub.io/wiki/media?w=800&tok=3f37c9&media=3_0_0:user:search-demo-high.png "A search result")](https://www.itophub.io/wiki/media?media=3_0_0:user:search-demo-high.png "3_0_0:user:search-demo-high.png")

你可能**找不到**想要找的对象，原因可能有很多  

*   由于您的用户权限，您不允许查看它，
    
*   在左上角的下拉列表中选择了一个组织，该对象不属于该组织。
    
*   对象是废弃的，`首选项`中没有选择`显示废弃的数据`

## 场景

### 添加条件

大多数搜索都有预定义的搜索条件，但你可能想要更改它们或添加新的搜索条件 [![](https://www.itophub.io/wiki/media?w=400&tok=9bee39&media=3_0_0:user:search-add-criteria.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-add-criteria.png "3_0_0:user:search-add-criteria.png")

1.  打开`添加条件`框
    
2.  可以通过输入属性的开头内容来过滤列表
    
3.  可以点击一个属性名，会将其添加为过滤条件并关闭该框
    
4.  或者，可以点击复选框，它将选中该属性但保持弹出框打开以选择更多条件，在这种情况下，下一步点击名称就能够选中。
    

### 设定标准

1.  打开一个条件框。建议选项将取决于属性的类型。
    

[![](https://www.itophub.io/wiki/media?w=160&tok=052204&media=3_0_0:user:search-set-criteria.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-set-criteria.png "3_0_0:user:search-set-criteria.png")

1.  选择一个选项:
    
    *   在文本框中输入数据，
        
    *   选择单选按钮
        
    *   检查一个或多个选项
        
2.  如果你想要更多的选项，点击“更多”
    
3.  一旦你设置了你的选项，点击按钮
    
    *   `搜索`：执行搜索
        
    *   `应用`：保存你的条件选项(_此选项仅在因性能原因停用“auto-submit”时可用_)
        
    *   `取消`：取消选项和选择条目
        
    *   在屏幕上的任何地方执行默认操作`搜索`或`应用`
        

### 删除条件

您可以通过单击红色的x图标来删除条件。请注意，这种删除通常会自动刷新列表。 [![](https://www.itophub.io/wiki/media?w=800&tok=f1cd50&media=3_0_0:user:search-remove-criteria.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-remove-criteria.png "3_0_0:user:search-remove-criteria.png") 默认情况下，条件带有`任何`，这意味着它不会对结果进行过滤，因此删除它对结果列表没有影响。

### 保存搜索

你可以在结果列表上使用`创建快捷方式…`操作来保存搜索结果. [![Save a search in Shortcut](https://www.itophub.io/wiki/media?w=800&tok=a35b60&media=3_0_0:user:search-create-shortcut.png "Save a search in Shortcut")](https://www.itophub.io/wiki/media?media=3_0_0:user:search-create-shortcut.png "3_0_0:user:search-create-shortcut.png")

*   这会创建一个快捷方式，当后续打开它时，所有**设置的**条件都会在那里。
    
*   带有`任何`的条件不会存储，因此会丢失，但这并不会改变搜索结果。
    

### 重新搜索

可以使用搜索按钮再次强制执行搜索 ([![Refresh button](https://www.itophub.io/wiki/media?media=3_0_0:user:refresh-search.png "Refresh button")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:search&media=3_0_0:user:refresh-search.png "3_0_0:user:refresh-search.png")).

一般来说，它是无用的，因为对条件的任何更改或删除条件都会刷新列表，但如果在执行搜索后创建或修改了与条件匹配的另一个对象，则刷新是有用的。另一种需要它的情况是，由于性能问题，对于这个特定类的搜索不是自动的。

## 搜索功能

这里列出了每种属性类型的详细搜索功能。

### 文本

这适用于简单的文本、html和工单日志。 [![](https://www.itophub.io/wiki/media?w=300&tok=bdd157&media=3_0_0:user:searchmorestring.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:searchmorestring.png "3_0_0:user:searchmorestring.png")


>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">如果出于性能考虑，在字段上声明了一个_索引_，那么默认操作符不是`包含`而是**等于**。工单的**编号**字段就是这样的。</font>

你甚至可以使用正则表达式(_regex_)

>> ![提示](/docs/images/note.png) <font style="color: #DA70D6">
**%**是一个映射任意字符串的**特殊字符**，因此可以搜索:  
>> *   _php%syntax_ 可以搜索在_php_ 和 _syntax_包含任意内容的这个顺序的内容 
>> *   要搜索确切的字符 **%** ，需要输入 **\\%** (反斜杠)
</font>

### 数字

你可以根据数字进行过滤：大于, 小于, 之间，… [![](https://www.itophub.io/wiki/media?w=300&tok=023399&media=3_0_0:user:searchinteger.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:searchinteger.png "3_0_0:user:searchinteger.png")

### 选择列表

它提供了可用值的完整列表，你可以选择它们: _全部_ 、 _无_ 、一个或多个。 [![Search on Enum](https://www.itophub.io/wiki/media?w=500&tok=7e1e54&media=3_0_0:user:search-enum.png "Search on Enum")](https://www.itophub.io/wiki/media?media=3_0_0:user:search-enum.png "3_0_0:user:search-enum.png")

### 对象

根据对象的数量，它将提出完整的对象列表或自动完成模式来检索您需要的对象。你可以选择预留的那些，同时搜索其他的。

[![](https://www.itophub.io/wiki/media?media=3_0_0:user:searchextkeyselected.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:searchextkeyselected.png "3_0_0:user:searchextkeyselected.png")

可以合并确切的值和 _未定义_ 的值（未定义的值代表着未记录，在OQL中=0）。[![Search undefined OR a given value](https://www.itophub.io/wiki/media?w=600&tok=899a9b&media=3_0_0:user:searchextkeyundefined.png "Search undefined OR a given value")](https://www.itophub.io/wiki/media?media=3_0_0:user:searchextkeyundefined.png "3_0_0:user:searchextkeyundefined.png")

### 层次结构

Sometime objects are organized in hierarchy. It's the case on the iTop standard datamodel of the **Organization**. This field looks like a normal object when you try to filter on it, but it's behavior behind the scene, is quite different as when you search for Person belonging to the Organization _IT Department_, then it will search for any Person belonging to **any** _IT Department_ **sub-organizations**, parsing the Organization tree structure **recursively**:

有时对象以层次结构组织。这是iTop标准数据模型中**组织**对象的情况。当尝试在此字段上进行过滤时，它看起来像一个普通对象，但在其后台行为方面，它与搜索属于 IT部门 的人员时完全不同，它会**递归**解析组织树形结构，搜索属于任何 IT部门 **子组织**的人员：

*   _IT Department_
    
    *   _IT Special_
        
        *   _Software Service_
            
        *   Service n°2
            
    *   Division B
        
        *   Service n°3
            

[![](https://www.itophub.io/wiki/media?w=800&tok=43c9eb&media=3_0_0:user:search-hierarchy-criteria.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-hierarchy-criteria.png "3_0_0:user:search-hierarchy-criteria.png")

### 日期

[![](https://www.itophub.io/wiki/media?w=400&tok=6e8fca&media=3_0_0:user:searchdatemore.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:searchdatemore.png "3_0_0:user:searchdatemore.png")

iTop默认使用以下格式来表示 _日期_ 和 _时间_ ：

*   日期： 首先 _年_ 显示为4位数字，接着是一个破折号，后跟用2位数字表示的 _月_ ，然后是一个破折号，最后是用2位数字表示的 _日_ 。（简而言之：YYYY-MM-DD）
    
*   日期和时间：以上述格式开始一个日期，接着是一个空格，然后用2位数字表示的 _小时_（24小时制）后跟一个冒号(:)，然后是用2位数字表示的 _分钟_ 后跟一个冒号(:)，最后是用2位数字表示的 _秒_ 。（简而言之：YYYY-MM-DD hh:mm:ss）

您的管理员可以定义其他格式，这可能取决于您的语言。

[![](https://www.itophub.io/wiki/media?w=400&tok=4dbdb7&media=3_0_0:user:searchdate.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:searchdate.png "3_0_0:user:searchdate.png")

### 最近使用

在选择搜索条件时，最多列出5个名称的第一个列表是为此类对象使用的最后条件。它们按时间顺序排序，最近使用的排在第一位。即使关闭浏览器，它们仍将保留，因为它们存储在您的用户首选项中。

[![](https://www.itophub.io/wiki/media?w=200&tok=4a029d&media=3_0_0:user:search-recently-used.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-recently-used.png "3_0_0:user:search-recently-used.png")

*   **最常用** 由您的管理员定义，比其它更有用的。按字母顺序排列。
    
*   **其它** 这些是其他的对象属性，不太可能用作搜索条件，但如果需要的话可以使用。
    
*   _在**最近使用**中列出的所有名称，同时也列在其它列表中。_
    

## 全局搜索

**全局搜索**功能位于所有iTop页面的左上角。

[![Global search](https://www.itophub.io/wiki/media?media=3_0_0:user:global-search.png "Global search")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:search&media=3_0_0:user:global-search.png "3_0_0:user:global-search.png")

全局搜索在iTop的所有对象中搜索给定的文本字符串。要启动搜索，请**输入要搜索的文本**并单击**放大镜图标**或按下键盘的**回车**键。

搜索结果按组显示：所有匹配的同类对象被分组在一个表中。

由于全局搜索搜索iTop数据库中的所有对象，因此当对象数量增加时，它可能变得相当慢。但是，您可以通过将其范围限制为特定类别的对象来加快搜索速度。指定全局搜索范围的语法如下： `class_name: text_to_search`。

[![Global search scope: Server](https://www.itophub.io/wiki/media?media=3_0_0:user:global-search-server.png "Global search scope: Server")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:search&media=3_0_0:user:global-search-server.png "3_0_0:user:global-search-server.png")

搜索 **Server:webserv** 将在所有服务器对象中搜索包含文本“webserv”的任何字段。

为了限制范围，您还可以将X指定为包含子类的类。例如：

[![Global search scope: Contact](https://www.itophub.io/wiki/media?media=3_0_0:user:global-search-contact.png "Global search scope: Contact")](https://www.itophub.io/wiki/media-detail?id=3_0_0:user:search&media=3_0_0:user:global-search-contact.png "3_0_0:user:global-search-contact.png")

搜索 **Contact:dali** 将搜索包含 dali 的所有团队和人员的任何字段。

全局搜索是 _不_ 区分大小写的。搜索 **Dali**, **dali** 或者 **DALI** 将给出相同的结果。

---
原文：<https://www.itophub.io/wiki/page?id=3_0_0:user:search>

版本：3_0_0/user/search.txt · Last modified: 2022/01/21 16:52 (external edit)