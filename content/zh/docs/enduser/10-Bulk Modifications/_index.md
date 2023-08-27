---
title: "批量修改"
linkTitle: "批量修改"
date: 2023-08-27
weight: 10
description: >
      <br> ➡️ 介绍如何批量修改对象。
---

{{% pageinfo %}}

在 iTop 中，有两种方法可以进行批量修改：

* **交互式 CSV 导入**：这对于重新导入一组已导出并修改的数据非常有用。
* **列表上的修改操作**：这对于数据清理（规范化）很有用，当希望将一组对象内的值进行对齐时，或者在需要以相同方式修改许多对象时很有用。

{{% /pageinfo %}}

## 交互式 CSV 导入

iTop 提供了强大的 CSV 导入功能，以帮助终端用户（和管理员）在 iTop 中批量创建或更新对象。

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">CSV 导入**故意不会**在值上应用任何过滤器，就像在控制台中编辑对象时一样。它也不会应用任何预填充。但是在保存对象时进行相同的检查。</font>

要启动 CSV 导入向导，请单击**数据管理**部分中的**_CSV 导入_**菜单。

![CSV 导入菜单项](https://www.itophub.io/wiki/media?w=250&tok=a1724f&media=3_1_0:user:csv-import-menu.png)

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">只有具有**批量修改**权限的用户才允许使用交互式 CSV 导入。</font>

### CSV 模板

iTop 为创建/导入任何类别的对象提供了 CSV 模板。你可以从 CSV 导入向导的第三个选项卡**模板**中下载或复制/粘贴模板。

![CSV 导入模板](https://www.itophub.io/wiki/media?w=600&tok=2413a9&media=3_1_0:user:csv-import-template-1.png)

从下拉列表中选择所需的类以生成模板。然后单击**_大的 Excel 图标_**以下载模板，或从图标下面的文本区域中复制/粘贴文本。

![提示](/docs/images/tip.png) <font style="color: #00CC33">获得填充模板的另一种方法是从 CSV 中导出现有对象。有关如何执行此任务的详细说明，请参见[导出数据](https://www.itophub.io/wiki/page?id=3_1_0:advancedtopics:exportdata)。</font>

### 值的预期格式

为了加载某些类型的属性，需要以特定的格式提供它们的值。

#### 关联集合（LinkedSet）

点击[这里](https://www.itophub.io/wiki/page?id=3_1_0:advancedtopics:import_a_link_set)了解导入关系所需的格式。

#### 日期

导入数据的日期格式可以在导入过程中指定，但是源文件中的所有日期必须使用相同的格式。这个格式可以是你的 iTop 上默认的格式，也可以是指定的任何格式。

#### 包含 HTML 的文本

你可以提供带有标签的原始 HTML。示例：\<p>\<b>加粗\<\/b>\<br>是的\<\/p>

#### 图片/文件（2.4 中的新增功能）

某些类别包含图片或文件文档作为其字段之一。例如，人员 类别包含一个 Picture 字段，用于保存此人的照片。在交互式编辑 人员 时，用户可以从计算机上传图像以提供人的照片。然而，在执行 CSV 导入时，不可能“上传”此类文件，也不能将其内容放在 CSV 文件本身中，因为 CSV 格式不支持这样做。

在这种情况下，CSV 文件必须在适当的 CSV 列中提供**用于上传文件的 URL**。这个 URL 必须能够从 iTop 服务器访问，并返回预期的图像（或文件文档）。如果上传失败，或者上传的文档格式与字段的预期格式不匹配（例如，如果 URL 对于`picture`字段不返回图像），则此字段的导入/更新将失败（整个 CSV 行将被拒绝）。

>> ![备注](/docs/images/note.png) <font style="color: #DA70D6">

**限制：**
>> * URL **必须**直接指向要上传的图像（不支持重定向）
>> * URL 必须可以从 iTop Web 服务器访问（注意，一些公共网站可能会拒绝 PHP 脚本的访问 - 它们会检查 HTTP User Agent 字符串）
>> * URL **不能**需要身份验证，因为上传是由 iTop 服务器自身执行的
>> * **支持**指向 iTop 本身的 URL（例如，CSV/Excel 导出提供的 URL）。但仅当它们指向同一个 iTop 实例时（在这种情况下，导入将解析所提供的 URL，并从 iTop 数据库中读取文档）。
>> * 如果使用**管理员帐户**执行 CSV 导入，可以指定位于 iTop 服务器本身上的文件路径（但这仅适用于管理员）。

</font>

#### 外部对象

要加载作为对其他对象的外部键的属性，可以提供作为远程类的“一致属性”声明的任何组合的属性。

例如：如果要加载 用户请求 并设置 发起人（_caller_id_），则可以提供以下列的任何组合来标识发起人：

* Caller->Email
* Caller->Organization name
* Caller->First Name
* Caller->Last Name
* Caller->Full Name
* Caller->Employee number

#### 标签集合（TagSet）

要加载标签集合属性，必须以带有|分割的标签的**标签**导入。最好在开头和末尾都放置一个标签。

### 上传数据

CSV 导入的第一步是将数据上传到服务器。你可以从计算机上传文件，也可以直接将数据复制/粘贴到向导的第二个选项卡中。

要从计算机上传文件，请在向导的第一个选项卡上使用文件上传表单。确保你还选择了用于保存文件的适当字符集。

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">如果下拉列表中没有你使用的字符集，请联系您的 iTop 管理员（通过 `csv_import_charsets` 配置变量可以配置此列表）。</font>

如果选择复制/粘贴数据，请使用向导的第二个选项卡**复制和粘贴数据**：

![复制和粘贴数据](https://www.itophub.io/wiki/media?w=800&tok=ecf8c9&media=3_1_0:user:csv-import-copy.png)

然后单击**_下一步 »_**以继续进行向导的下一步。

![CSV 导入步骤 2](https://www.itophub.io/wiki/media?w=800&tok=239773&media=3_1_0:user:csv-import-person-step2.png)

以下参数在此步骤中必须进行调整：

| 参数 | 意义 |
| --- | --- |
| 分隔符字符 | 这是用于在 CSV 文件内部分隔不同列的字符。如果在页面底部的预览中正确显示并分隔列，那么当前的选择就是正确的（CSV 文件的典型选择是逗号） |
| 文本限定符字符 | 有时单元格内的值包含分隔符字符。此类字段然后由**文本限定符**字符括起来，以防止分隔符字符在单元格中间被错误解释。（典型值是单引号或双引号） |
| 将第一行视为标头 | 如果文件的第一行包含标头（列名）而不是实际数据，请选中此复选框。请注意，在页面底部的预览中，标头行以不同的颜色显示。 |
| 在开始处跳过 `x` 行 | 一些 CSV 文件（通常是手动创建的脚本生成的 CSV 文件）在文件的开始部分包含一些注释。使用此设置来告诉 iTop 忽略所需数量的行以跳过注释。跳过的行会从页面底部的预览中移除。 |
| 日期格式 | 指定您的源数据中的日期和日期时间字段是以哪种格式编写的。您必须为源数据中的所有日期使用单个格式。如果日期不需要指定时间，如果日期时间不包含任何时间信息，则将使用 00:00:00 |

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">如果预览中的重音字符未正确显示，请使用**<< 返回**按钮返回向导的第一页，并在再次上传 CSV 文件之前选择适当的字符集。</font>

一旦预览中的数据看起来正确，点击**_下一步 »_**按钮以继续向导的下一步：

![数据映射](https://www.itophub.io/wiki/media?w=800&tok=31ecd7&media=3_1_0:user:csv-import-person-step3.png "数据映射")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:bulk_modify&media=3_1_0:user:csv-import-person-step3.png "3_1_0:user:csv-import-person-step3.png")

导入向导的第三步是定义CSV文件的列与iTop对象字段之间的映射关系。  
首先：在下拉列表中**选择要导入的类**。这将确定可用于映射的字段列表。  
如果您想要的类不在列表中：

- 或许您没有足够的访问权限，您需要在该类上拥有 `bulk-modify` 权限才能允许导入CSV对象。
- 或许无法导入该类的对象，对于一些iTop内部类（CMDBChange，CMDBChangeOp，Event等），甚至对于管理员也是如此。

### 字段映射

如果CSV文件最初是使用模板或iTop的CSV导出功能创建的，那么CSV中提供的标题应该会自动为您提供正确的映射关系。

如果不是这种情况，您将需要手动创建这些映射。

>> ![备注](/docs/images/note.png) <font style="color: #DA70D6">向导要求为要导入数据的每一列提供映射。不过，您可以通过选择 **– 忽略该栏 –** 作为该列的映射来忽略某列（即不导入该列）。</font>

### 搜索条件

CSV导入向导可用于在iTop中创建或更新对象。向导在此步骤使用所定义的 `搜索条件` 来确定CSV文件的每一行是否对应于iTop中的现有对象。如果对象存在，则将对其进行更新；否则将创建新对象。通常情况下，在iTop的搜索表单中，所有选定的 `搜索条件` 都会使用AND运算符进行组合。（即对象的每个**搜索**条件都必须匹配才视为匹配项）。

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">在iTop中，完全相同的导入CSV文件可能会因所选的 `搜索条件` 不同而产生不同的结果。在此阶段定义的搜索条件将影响所创建或更新的对象数量。</font>

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">
**高级用法（管理员专用）**<br>
管理员可以访问**高级模式**（页面右上角的复选框），该模式允许根据对象的内部标识符（ID或Key编号）导入对象。这对于从iTop中导出并重命名对象非常有用。请勿将此选项用于未从iTop导出的对象，或者至少确保您了解正在导入的数据！**高级模式** 还允许管理员像[此处所述](https://www.itophub.io/wiki/page?id=3_1_0:advancedtopics:import_a_link_set "3_1_0:advancedtopics:import_a_link_set")导入**链接集合（LinkedSet）**。
</font>

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">
**设计提示（管理员专用）**<br>
每个类在数据模型中都定义了“协调属性”。如果在加载中提供了这些属性，则它们会自动设置为“搜索条件”。
如果用户希望通过加载更新其中一些搜索条件，必须取消选中它们，并使用其他条件来检索iTop对象。
一旦映射和搜索条件看起来正确，请通过点击 **_模拟导入_** 按钮进行导入模拟。
</font>

#### 模拟导入

几秒钟后，将显示以下摘要界面：

[![带错误的第四步](https://www.itophub.io/wiki/media?w=800&tok=4f2372&media=3_1_0:user:csv-import-person-step4-errors.png "带错误的第四步")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-import-person-step4-errors.png "3_1_0:user:csv-import-person-step4-errors.png")

错误行以红色背景突出显示。错误不会阻止导入运行，但相应的行将被拒绝。

该界面提供了有关未能理解的内容的反馈。

- 人员状态中的“active”值是枚举类型的字段，但未能理解。`active`是存储在数据库中的实际代码，但这不是iTop在此处所期望的，它期望该代码在用户语言环境下的标签，所以您应该提供首字母大写的“Active”。
- 没有名为“IT Department2”的组织。→ _小心，这可能是由于当前用户无权查看该特定组织。_
- iTop无法确定您想要使用的巴黎位置。在这个示例中，数据库包含两个巴黎位置，一个位于“IT Department”组织下，另一个位于“Demo”组织下。

要解决最后一个错误，请重新启动加载并在Excel中**添加一个新列**，以指定“位置->所有者组织的名称”。

[![带修复的数据映射](https://www.itophub.io/wiki/media?w=800&tok=b64fe5&media=3_1_0:user:csv-import-person-step3-error-fixed.png "带修复的数据映射")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-import-person-step3-error-fixed.png "3_1_0:user:csv-import-person-step3-error-fixed.png")

注1：最后一行的映射是手动完成的（_第一列和第二列的值不同_），因为我不知道“位置组织”的确切预期命名。

注2：尝试映射所提供的位置名称时，它不会检查此位置是否与数据模型中定义的筛选器相匹配。出于优化性能的考虑，当加载大量数据时，特意做出了这个技术选择。

[![没有错误的第四步](https://www.itophub.io/wiki/media?w=800&tok=7a501b&media=3_1_0:user:csv-import-person-step4-no-error.png "没有错误的第四步")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-import-person-step4-no-error.png "3_1_0:user:csv-import-person-step4-no-error.png")

注意要创建的对象数量、要更新的对象数量以及错误数量。您可以使用页面顶部的复选框来筛选显示，以更快地分析结果。

如果模拟结果看起来奇怪，可能是 `搜索条件` 不正确。然后按下**返回**按钮更改它们并再次进行模拟。如果需要修改数据，请点击 _**|<< 重来**_（**复制和粘贴数据**选项卡将包含上传的数据副本）。如果模拟看起来正确，请点击 _**执行导入！**_ 执行实际导入。

### 执行导入

如果导入的对象数量和要创建或更新的对象百分比超过一定水平，将显示确认对话框：

[![CSV导入确认对话框](https://www.itophub.io/wiki/media?w=300&tok=9a5d44&media=3_1_0:user:csv-import-5.png "CSV导入确认对话框")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-import-5.png "3_1_0:user:csv-import-5.png")

点击**_确定_**关闭对话框并继续进行数据导入。

向导的最后一个界面显示了导入过程中执行的操作摘要。

[![导入摘要](https://www.itophub.io/wiki/media?w=800&tok=946bd0&media=3_1_0:user:csv-import-person-step5.png "导入摘要")](https://www.itophub.io/wiki/media?media=3_1_0:user:csv-import-person-step5.png "3_1_0:user:csv-import-person-step5.png")

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">
>> 
>> 在发生错误的情况下，被拒绝的行会列在报告底部，可以将其复制/粘贴，并在重新导入之前进行修正。
>> <br>
>> 另一种方法是进行 _迭代_ ：
>> 
>> 1. 完成导入向导，并记录哪些行出现了错误。包含错误的行将被简单地忽略。
>> 2. 在您的引用CSV文件中修复出现错误的行。
>> 3. 使用您的引用CSV文件（整个文件）重新运行导入。
>> 4. 重复直到没有错误。
>> 
>> iTop将忽略未更改的行，因为相应的数据已经是最新的（除非在两次导入之间被其他人修改）。如果您需要维护数据的引用CSV文件，则迭代整个CSV文件可能是首选。
</font>

## 修改操作

iTop允许对一组对象进行批量修改。此操作非常有用，可以在一次操作中将多个对象的字段设置为相同的值。

- **批量修改**。这仅在列表中的所有对象都属于相同类别的情况下才可能实现。例如，不能对联系人列表执行**修改**操作，因为列表可能包含团队和个人。如果要执行此操作，请确保将搜索范围缩小到仅涵盖一个对象类别。
- **受限访问**。并非所有用户都被允许执行批量操作。如果下拉列表中没有显示菜单项，请请求管理员检查您的iTop帐户的安全配置。
- **修改大量对象**。（几百个或更多）可能需要较长的时间来执行。由于出于安全原因，所有交互操作都有时间限制（超时），在执行重要修改之前，请联系管理员以检查是否允许/可持续在交互模式下执行。用于大规模更新操作的备选解决方案是准备一个CSV文件，在服务器上直接以命令行模式加载。

[![全部修改..](https://www.itophub.io/wiki/media?w=800&tok=8b1127&media=3_1_0:user:menu-modify-all.png "全部修改..")](https://www.itophub.io/wiki/media?media=3_1_0:user:menu-modify-all.png "3_1_0:user:menu-modify-all.png")

从**其他操作**菜单项中选择**_修改_**，将显示以下页面：

[![全部修改](https://www.itophub.io/wiki/media?w=800&tok=181766&media=3_1_0:user:modify-all-2.png "全部修改")](https://www.itophub.io/wiki/media?media=3_1_0:user:modify-all-2.png "3_1_0:user:modify-all-2.png")

在这一步中，您可以选择要更新的对象。默认情况下，所有对象都被选中，从而进行修改。浏览列表以检查是否存在问题，然后点击**_下一步 »_**继续到下一个界面。

**对象修改表单**显示了每个字段旁边的复选框和数值指示器。指示器显示了在所选对象的所有字段中存在多少不同的值。如果所有对象的该字段具有相同的值，则指示器为绿色（[![仅一个值](https://www.itophub.io/wiki/media?media=3_1_0:user:homogenous-indicator.png "仅一个值")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:bulk_modify&media=3_1_0:user:homogenous-indicator.png "3_1_0:user:homogenous-indicator.png")），复选框已选中且字段可编辑。否则，指示器为红色，复选框未选中。当鼠标指针位于红色指示器上方时，将显示工具提示，显示有关字段的不同值的信息。

[![全部修改表单](https://www.itophub.io/wiki/media?w=800&tok=3d0de8&media=3_1_0:user:modify-all-3.png "全部修改表单")](https://www.itophub.io/wiki/media?media=3_1_0:user:modify-all-3.png "3_1_0:user:modify-all-3.png")

只有与复选框对应的字段将被修改。所有其他字段将保持不变。通过选中**红色**指示器（即包含多个不同值的字段）前的复选框，可以将所有值强制修改为相同的值。

点击**_预览修改 »_**以显示确认界面：

[![全部修改确认](https://www.itophub.io/wiki/media?w=800&tok=6cb828&media=3_1_0:user:modify-all-4.png "全部修改确认")](https://www.itophub.io/wiki/media?media=3_1_0:user:modify-all-4.png "3_1_0:user:modify-all-4.png")

检查列表查看**错误**列中是否报告了任何错误，准备就绪后，点击**_全部修改_**以执行实际的批量修改。

---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:bulk_modify>

版本：3_1_0/user/bulk_modify.txt · Last modified: 2023/07/21 10:19 (external edit)




