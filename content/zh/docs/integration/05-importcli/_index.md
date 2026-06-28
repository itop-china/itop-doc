---
title: "CLI 数据导入"
linkTitle: "CLI 数据导入"
date: 2025-06-27
weight: 5
description: >
  <br> ➡️ 通过 CSV 文件批量导入数据到 iTop
---

{{% pageinfo %}}

iTop 提供命令行工具 `import.php`，通过 CSV 文件批量导入数据。

{{% /pageinfo %}}

## 用途

iTop 提供了一个通用的 Web 服务，用于基于源 CSV 文件将数据导入 iTop。此服务可以在服务器上通过命令行界面本地使用，也可以通过 HTTP POST 请求远程使用。

使用此服务，您可以轻松地通过批处理脚本将数据导入 iTop，该脚本从第三方工具提取数据并生成 CSV 格式文件。例如，一个从 Active Directory 提取联系人列表的脚本。

当需要导入真正大量的数据时，CLI 模式是必须的，因为您不会达到 Web 服务器的限制（超时和内存限制）。

## 用法

### 命令行界面

命令行的所有参数都在后面的“参数”部分列出。以下行是必填参数的示例。所有参数都以 `--` 开头。

```bash
php /var/www/itop/webservices/import.php --auth_user=login --auth_pwd=password --class=Organization --csvfile=file --reconciliationkeys="list of keys"
```

协调键对于唯一标识要导入到 iTop 的元素非常重要。协调键必须存在于数据文件中。与交互式 CSV 导入不同，您不限于类定义的默认协调键列表。

此外，外部键将通过协调方案中指定的所有属性来唯一标识。在我们的示例中，如果您认为 Name/Country 唯一标识位置，则在协调方案中同时使用 Location->Name 和 Location->Country。

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| param_file | 参数文件 | - |
| auth_user | 用户登录名 - 仅限 CLI 模式 | - |
| auth_pwd | 用户密码 - 仅限 CLI 模式 | - |
| class | 加载对象的类 | 必填！ |
| csvdata | CSV 内容（仅限 HTTP 模式，数据可以通过此页面参数发布） | HTTP 模式下必填 |
| csvfile | 源文件的路径和名称 | CLI 模式下必填 |
| charset | CSV 数据的字符集编码：UTF-8、ISO-8859-1、WINDOWS-1251、WINDOWS-1252、ISO-8859-15 | 使用 iTop 配置文件中的 `csv_file_default_charset`，默认值为 'ISO-8859-1' |
| date_format | 输入日期格式（用于日期和日期时间）- 示例：Y-m-d、d/m/Y（法国） | <空白> |
| separator | CSV 数据中的列分隔符 | ,（逗号） |
| qualifier | CSV 数据中的文本限定符 | "（双引号） |
| output | `retcode` 返回错误行数，`summary` 返回简洁报告，`details` 获取详细报告（列出每一行） | summary |
| reconciliationkeys | 用于标识现有对象并更新它们或创建新对象的列标签或代码（取决于 `no_localize` 标志）（逗号分隔） | <空白> |
| simulate | 如果设置为 1，则加载不会执行，但会生成预期报告 | 0 |
| with_archive | 如果设置为 1，则导入将检索归档对象作为要更新的对象和有效的外部键 | 0 |
| comment | 要添加到变更日志中的注释 | <空白> |
| no_localize | 如果设置为 0，则列标题、值和协调键应使用登录用户的语言进行本地化。设置为 1 以使用内部属性代码和值（枚举） | 0 = 标签不区分大小写 |

## 输出

命令行将返回一个摘要报告（见下文），总结导入使用的参数和导入结果：

- 创建的元素数量
- 更新的元素数量
- 出错的元素数量

如果您为 `output` 参数指定了 `details` 选项，您将获得每个导入元素的一行及其导入状态（见下面的示例）。

```bash
php /var/www/itop/webservices/import.php --auth_user=login --auth_pwd=password --class=Organization --csvfile=file --reconciliationkeys="list of keys" --output=details
```

### 结果

```
#Output format: details
#Class: Organization
#Separator: ;
#Qualifier: \"
#Charset Encoding:UTF-8
#Data Size: 26
#Data Lines: 1
#Simulate: 0
#Columns: name, code
#Reconciliation Keys: name
#Change tracking comment: 
#Issues: 0
#Warnings: 0
#Created: 1
#Updated: 0
#Unchanged: 0
Line;Status;Object Class;Object Id;name (Name);code (Code)
0;created;Organization;3;\"WorldCompany\";\"WCY\"
```

## 可能的错误

### 缺少参数

```
ERROR: Missing argument 'class'
```

当缺少必填参数时显示此错误。

### 错误的参数

```
#Unknown class: 'toto'
```

如果指定的类在 iTop 中不存在，则会发生此错误。请注意类名区分大小写。

```
#Unknown reconciliationkeys: 'attribute'
```

如果协调键列表中至少有一列未知，则会发生此错误。原因可能是：

- 提供了代码而不是标签，或反之亦然
- 协调键是外部字段
- 协调键不在 csv 文件中

```
#Unknown column: 'Last Nme'
```

如果 csv 文件中的列未知，则会发生此错误。

## 允许的用户

管理员始终被允许执行此页面。

非管理员如果被允许修改给定类的对象，则将被允许执行。

## 导入图像和文件

某些类在其字段中包含图像或文件文档。例如，Person 类包含一个 Picture 字段，用于保存该人员的照片。交互式编辑 Person 时，用户可以从她的计算机上传图像以提供该人员的照片。但是，在执行 CSV 导入时，无法“上传”此类文件或将其内容放入 CSV 文件本身，因为 CSV 格式不支持此操作。

在这种情况下，CSV 文件必须在适当的 CSV 列中提供一个 URL 来上传文件。此 URL 必须可以从 iTop 服务器访问，并返回预期的图像（或文件文档）。如果上传失败或上传文档的格式与字段的预期格式不匹配（例如，如果 URL 没有为 picture 字段返回图像），则此字段的导入/更新将失败（并且 CSV 的整行将被拒绝）。

- URL 必须直接指向要上传的图像（不支持重定向）
- URL 必须可以从 iTop Web 服务器访问（注意某些公共网站可能会拒绝访问 PHP 脚本 - 它们会检查 HTTP User Agent 字符串）
- URL 不需要身份验证，因为上传是由 iTop 服务器本身完成的
- 指向 iTop 本身的 URL（如 CSV/Excel 导出提供的 URL）是支持的。但仅当它们指向同一个 iTop 实例时（在这种情况下，导入将解析提供的 URL 并从 iTop 数据库中读取文档）
- 如果您使用管理员账户执行 CSV 导入，您可以指定位于 iTop 服务器本身的文件路径（但这仅适用于管理员）

引用已存储在 iTop 中另一个对象上的图像的示例。使用的语法：`https://<your-itop>/pages/ajax.document.php?operation=download_document&class=<ObjectClass>&id=<ObjectId>&field=<FieldCode>`

## 用例：将人员及其对应的登录导入 iTop

此用例描述如何将人员和他们的登录导入 iTop。这是从 Active Directory 加载这些信息的一种方式。在这种情况下，您只需编写一个脚本，从 Active Directory 创建两个 csv 文件 person.csv 和 login.csv。

### 导入人员

我们想创建两个联系人：

- 属于组织 Demo 的 Claude Monet
- 属于组织 IT Department 的 Gustave Flaubert

在此示例中，两个组织已存在于 iTop 中。

要导入的类是 Person，csv 文件（login.csv）中的数据为：

```csv
Last Name,Status,Organization->Name,Email,Phone,Notification,Function,First Name
"Monet","Active","Demo","monet@demo.com","","yes","","Claude"
"Flaubert","Active","IT Department","flaubert@it.com","","yes","","Gustave"
```

然后运行以下命令行：

```bash
php webservices/import.php --auth_user=admin --auth_pwd=admin --csvfile="person.csv" --class="Person" --reconciliationkeys="Email"
```

### 导入用户账户

我们想创建两个用户账户：

- support 是配置经理和变更主管，与联系人 flaubert@it.com 相关
- portal 是与联系人 monet@demo.com 相关的门户用户

在此示例中，登录通过电子邮件与联系人关联，我们导入与联系人关联的配置文件。查看导入配置文件的特定语法。有关导入链接集的更多信息，请参阅[导入链接集](../import_a_link_set/)。

要导入的类是 UserLocal：

```csv
Person->Email,Login,Language,Password,Profiles
"flaubert@it.com","support","EN US",1234,profileid->name:Configuration Manager|profileid->name:Change Supervisor
"monet@demo.com","portal","EN US",1234,profileid->name:Portal user
```

然后运行以下命令行：

```bash
php webservices/import.php --auth_user=login--auth_pwd=password --csvfile="login.csv" --class="UserLocal" --reconcialiationkeys="Login"
```

导入允许的组织示例：

- 假设我想为同一个用户允许 3 个组织。
- 源文件中的每个组织可以通过其 id、name 或 code 来标识。
- 加载像 Allowed Organizations 这样的 AttributeLinkedSetIndirect 时，预期的字段是 n:n 关系类的字段（此处 URP_UserOrg），这意味着您只能提供 allowed_org_id。
- 但通常，对于 n:n 关系，您了解远程对象的一些字段值，但可能不知道它的 iTop id。在这种情况下，您可以指定远程对象的代码，并且有一种特殊的语法：
  - 关系类中的 ExternalKey，指向远程对象（例如 allowed_org_id）
  - 一个破折号字符后跟一个大于号：->
  - 远程属性的代码（例如 name）
  - 一个冒号：
  - 检索远程对象的值（例如 Demo）
  - 一个管道符，用于分隔需要链接到同一个用户的 2 个远程对象
  - 以及上述 5 个步骤的重复

像这样 `"allowed_org_id->name:Demo|allowed_org_id->code:IT"`

在此示例中，我结合了不同的方式来标识同一用户的 n:n 关系中的组织，这有效，但您可能不会每天都使用它。

```csv
Person->Email,Login,Language,Password,Profiles,Allowed Organizations
"monet@demo.com","portal","EN US",1234,"profileid->name:Portal user","allowed_org_id->code:IT|allowed_org_id->name:Demo|allowed_org_id:1"
```

### 导入位置

```csv
"name","org_id->name","country","city"
"Bordeaux","Demo","France","Bordeaux"
"Grenoble","Demo","France","Eybens"
"Paris","Demo","France",""
```

然后运行以下命令行：

```bash
php webservices/import.php --auth_user=login --auth_pwd=password --csvfile="location.csv" --charset="UTF-8" --no_localize=1 --class="Location" --reconcialiationkeys="name,org_id->name"
```

## 限制 / 已知问题

- 外部字段（如 `virtualhost_id->org_name`）不能用作协调键。
  - 解决方法：`org_name` 可以替换为 `org_id->name`
- 限制：箭头运算符（->）不能多次使用（即 `virtualhost_id->org_id->name` 不受支持）。

## 历史版本

- 0.9：首次实现此功能
- 2.0：添加标志 `no_localize`

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:importcli>

版本：3_2_0/advancedtopics/importcli.txt · Last modified: 2025/04/29 16:27 by 127.0.0.1
