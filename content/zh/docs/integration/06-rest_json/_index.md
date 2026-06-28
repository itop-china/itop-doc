
---
title: "REST/JSON API"
linkTitle: "REST/JSON API"
date: 2025-06-27
weight: 6
description: >
  通过 REST/JSON API 操作 iTop 数据。
---

{{% pageinfo %}}

iTop 提供 REST/JSON API，允许外部应用通过 HTTP 请求对 iTop 对象进行增删改查操作。

{{% /pageinfo %}}

## 介绍

iTop 提供了一个 REST/JSON 接口，允许第三方应用程序远程与 iTop 交互以检索、创建或更新 iTop 对象。此接口基于一组简单的 HTTP POST 请求。传递给 iTop 和从 iTop 检索的数据使用 UTF-8 字符集以 JSON 编码。

此类请求可以从任何能够发出 HTTP/POST 并操作 JSON 编码数据的编程语言执行。请求甚至可以直接在 javascript 中从任何网页运行，通过跨站点脚本（iTop 支持 CORS 和 JSON-P）。

您还可以在 [Postman](https://documenter.getpostman.com/view/44344/ivanti-itop/7LnFzd) 上找到完整的文档。

用于 POST 请求的 URL 如下：

```
<itop-root>/webservices/rest.php?version=1.3
```

此类请求需要传递以下参数：

- `auth_user`（可选，取决于登录模式）
- `auth_pwd`（可选，取决于登录模式）
- `auth_token`：如果要使用应用程序令牌或个人令牌，作为 auth_user 和 auth_pwd 的替代
- `json_data`

实际上，HTTP 方法可以是 POST 或 GET（这是 JSON-P 支持所需的）。出于安全原因（避免以明文传递凭据）和 GET 对输入数据大小施加限制的原因，建议使用 POST 和 HTTPS。支持 HTTP 基本身份验证。

谁可以访问：

- 由于 REST Web 服务很容易被放入循环中，用户必须对他们修改的类具有**写入访问权限**和**批量写入**权限。应用刺激是一种修改。
- 确保使用 REST Web 服务的脚本具有 **REST 服务用户** 配置文件。
- 具有 **管理员** 配置文件的用户**不会**在没有此额外 **REST 服务用户** 配置文件的情况下访问 REST。

如果要模拟以前的行为（即允许任何用户访问 REST Web 服务），请添加配置参数 `secure_rest_services` 并将其设置为 `false`。

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| version | API 版本。这是确保目标 iTop 服务器可以提供某些功能的一种方式，并且它确保您的脚本的稳定性：只要版本可用，操作将保持不变，但以下情况除外：错误修复、返回消息中的修改、返回的 JSON 结构中的新元素。 | - |
| auth_user | 用户登录名 | - |
| auth_pwd | 用户密码 | - |
| auth_token | 应用程序或个人令牌 | |
| json_data | 包含 JSON 格式请求操作的字符串。或（3.0 中的新功能）`@<path>`，其中您提供带有路径的 JSON 操作文件，用于 CLI 执行 | |
| callback | 如果设置，则使用 JSON-P（JSON with padding） | |

这些参数适用于任何类型的请求操作。

### 认证

请参阅[如何认证到 Web 服务](../../admin/user_authentication_options/)以选择相关的认证模式并相应地调整 HTTP 请求。

通过浏览器测试 API 可以完成，但在这种情况下，您必须调整 `allowed_login_types` 以在 iTop 的配置文件中启用 `url`。

### PHP 数组形式的参数

自 2.7.1 和 3.0.0 起，参数可以使用 PHP 数组语法发送：

```
auth_user=my_user&auth_pwd=my_password&json_data%5Boperation%5D=core%2Fget&json_data%5Bclass%5D=ServiceChange&json_data%5Bkey%5D=SELECT+ServiceChange+WHERE+id%3D1&json_data%5Boutput_fields%5D=request_state
```

### 文件中的参数

自 3.0.0 起，为了测试，您可以将 JSON 操作写入文件以进行 CLI 执行：

```json
{
  "operation":"core/create",
  "comment":"Synchronization from blah...",
  "class":"UserRequest",
  "output_fields":"id, friendlyname",
  "fields":
  {
    "org_id":"SELECT Organization WHERE name = 'Demo'",
    "caller_id":{"name":"monet","first_name":"claude"},
    "title":"issue blah",
    "description":"something happened"
  }
}
```

然后您可以使用以下 Curl 命令在命令行界面上执行此操作（必须启用 formlogin_type）：

```bash
curl -X POST -F 'version=1.3' -F 'auth_user=admin' -F 'auth_pwd=admin'  https://localhost/itop/webservices/rest.php -F 'json_data=@./my-json-operation.json'
```

```bash
curl -X POST -F 'version=1.3' --header 'authorization: basic YWRtaW46YWRtaW4='  https://localhost/itop/webservices/rest.php -F 'json_data=@./my-json-operation.json'

# YWRtaW46YWRtaW4= 对应于字符串 login:password 的 base64 编码
```

```bash
curl -X POST -F 'version=1.3' -F 'auth_token=YOURTOKEN'  https://localhost/itop/webservices/rest.php -F 'json_data=@./my-json-operation.json'
```

如果使用最后一个示例，您需要在 allowed_login_type 参数中激活 login_mode 令牌。

## 操作：list_operations

您应该熟悉的第一个操作是：`list_operations`。此命令返回所有可能的操作列表。

json_data 输入的语法尽可能简单：

```json
{
   "operation": "list_operations"
}
```

回复将如下所示：

```json
{
   "version": "1.2",
   "operations":
   [
      {
         "verb": "core/create",
         "description": "Create an object",
         "extension": "CoreServices"
      },
      {
         "verb": "core/update",
         "description": "Update an object",
         "extension": "CoreServices"
      },
      {
         "verb": "core/get",
         "description": "Search for objects",
         "extension": "CoreServices"
      }
   ],
   "code": 0,
   "message": "Operations: 3"
}
```

请注意以下部分：

```json
{
   "code": 0,
   "message": "Everything went well"
}
```

…是所有由 rest.php 提供的服务共有的，返回的其他信息取决于请求的操作。

## 错误代码

错误代码在 `applicationextension.inc.php` 中可用，作为 RestResult 类的常量：

| 值 | 常量 | 含义 |
|----|------|------|
| 0 | OK | 未遇到任何问题 |
| 1 | UNAUTHORIZED | 缺少/错误的凭据或用户没有足够的权限执行请求的操作 |
| 2 | MISSING_VERSION | 缺少参数 'version' |
| 3 | MISSING_JSON | 缺少参数 'json_data' |
| 4 | INVALID_JSON | 输入结构不是有效的 JSON 字符串 |
| 5 | MISSING_AUTH_USER | 缺少参数 'auth_user' |
| 6 | MISSING_AUTH_PWD | 缺少参数 'auth_pwd' 或您正在使用 url 登录类型，而它在 iTop 的配置文件中未被允许 |
| 10 | UNSUPPORTED_VERSION | 没有可用于指定版本的操作 |
| 11 | UNKNOWN_OPERATION | 请求的操作对指定版本无效 |
| 12 | UNSAFE | 无法执行请求的操作，因为它可能导致数据（完整性）丢失 |
| 100 | INTERNAL_ERROR | 无法执行操作，请参阅消息进行故障排除 |

## 核心服务

核心服务是**通用**服务。它们等同于 iTop 核心 PHP API：DBObject、DBObjectSearch 和 DBObjectSet。

使用这些服务，您可以操作任何类型的数据，前提是您了解足够的类和属性信息。

### 如何指定键

键是标识对象的一种方式。这种类型的规范可用于确定操作的目标对象，并用于确定外部键（或"外键"）的值。

允许三种形式：

- 指定对象的 id（作为数字）：

```json
...
   "key": 123
```

- 指定搜索查询（OQL）：

```json
...
   "key": "SELECT UserRequest WHERE caller_name LIKE \"monnet\""
```

- 指定搜索条件（所有条件都使用 AND 运算符组合）：

```json
...
   "key":
   {
      "name": "Monnet",
      "first_name": "Claude"
   }
```

### 如何指定值

属性的值以取决于属性类型的格式给出。

以下是一个说明某些情况的示例：

```json
   "name": "Monnet",
   "first_name": "Claude",
   "age": 80,
   "picture": {
      "data": "iVBORw0KGgoAAAAN.......AAAAElFTkSuQmCC",
      "filename": "smiley.png",
      "mimetype": "image/png"
   }
```

#### 标量

对于大多数属性类型，值只是一个标量。

对于外部键，值是一个键（见上面的定义）。

对于格式化为纯文本的文本字段，新行通过 "\n" 指定。

示例：

```json
"name": "Monnet",
"description": "A famous french artist.\nLaunched the impressionism trend."
"presentation": "<p>A famous french artist</p><p>Launched the <em>impressionism</em> trend.</p>"
"age": 80,
"org_id": "SELECT Organization WHERE name = 'Demo'",
"location_id": 3,
"supervisor_id":
{
  "name": "Foo",
  "first_name": "John"
}
```

#### 二进制数据（Blobs）

对于 Blobs（即二进制数据），值以包含三个项目的数组形式给出：data、filename 和 mimetype。

- 'data' 是经过 base64 编码的二进制数据
- 'filename' 是原始文件的名称。其目的是在文件被进一步下载时提供默认文件名。
- 'mimetype' 必须与文件格式匹配，以便 iTop 可以正确显示它。

示例：

```json
"picture": {
  "data": "iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAIAAAC0tAIdAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACmSURBVChTfZHRDYMwDESzQ2fqhHx3C3ao+MkW/WlnaFxfzk7sEnE6JHJ+NgaKZN2zLHVN2ssfkae0Da7FQ5PRk/ve4Hcx19Ie6CEGuh/6vMgNhwanHVUNbt73lUDbYJ+6pg8b3+m2RehsVPdMXyvQY+OVkB+Rrv64lUjb3nq+aCA6v4leRqtfaIgimr53atBy9PlfUhoh3fFCNDmErv9FWR6ylBL5AREbmHBnFj5lAAAAAElFTkSuQmCC",
  "filename": "smiley.png",
  "mimetype": "image/png"
}
```

#### 案例日志（Case Log）

自 iTop 2.0.3 起，有 3 种可能的语法用于填充"CaseLog"字段：简写语法、单一项或整个日志。

##### 简写语法

如果提供简单的文本字符串，文本将作为案例日志中的新条目添加，使用当前日期和时间以及当前用户，并且文本将被隐式视为以 HTML 格式设置。

示例：

```json
"public_log": "blah blah blah",
```

##### 富语法

如果提供带有名为 `add_item` 的条目的结构，可以指定附加信息：

- 用户名（默认为用于 REST/JSON API 的凭据）
- 条目的日期/时间（默认为"现在"）
- 注释的格式（默认为"html"，可以设置为"text"）

示例：

```json
"public_log": {
   "add_item":
   {
      "date": "yyyy-mm-dd hh:mm:ss",
      "user_login": "jfoo",
      "message": "The first line\nAnother line",
      "format":"text"
   }
},
```

##### 完整语法

如果提供名为 `items` 的数组，则案例日志的整个内容将被提供的条目替换。

示例：

```json
"public_log":
{
   "items":
   [
      {
         "date": "yyyy-mm-dd hh:mm:ss",
         "user_login": "jfoo",
         "message": "<p>The first line</p><p>A second line</p>"
      },
      {
         "date": "yyyy-mm-dd hh:mm:ss",
         "user_login": "jfoo",
         "message": "<p>The first line</p><p>A second line</p>",
         "format": "html"
      },
      {
         "date": "yyyy-mm-dd hh:mm:ss",
         "user_login": "jfoo",
         "message": "blah blah blah",
         "format": "text"
      }
   ]
},
```

#### 链接集

对于链接集，值是一个对象定义数组。

示例：

```json
"contacts_list":
[
   {
      "role": "artist",
      "contact_id":
      {
         "finalclass": "Person",
         "name": "monet",
         "first_name": "claude"
      }
   },
   {
      "role": "Basket-ball",
      "contact_id": "SELECT Team WHERE name = 'San Antonio Spurs'"
   },
   {
      "contact_id": 1234
   }
]
```

### 响应格式

core/… 操作的响应格式如下：

```json
{
  "objects":
  {
    "objectclass::objectkey":
    {
      ...
    }
  },
  "code": 0,
  "message": "Found: 1"
}
```

其中每个对象的形式为：

```json
    {
      "code": 0,
      "message": "",
      "class": "Person",
      "key": 1234,
      "fields": {
        "id": 1234,
        "name": "My last name",
        "status": "Active",
        "org_id": 123,
        .....
        .....
        .....
      }
    }
```

如果没有要返回的对象，您将得到：

```json
"objects": null
```

可以通过 `output_fields` 参数（如果可用）控制给出的属性列表。`output_fields` 参数可以具有以下形式：

- 以逗号分隔的属性代码列表（例如："name, status, org_id"）。只能给出查询类的属性。
- `*` 表示查询类的所有属性
- `*+`（自 2.0.3 起）表示每个找到的**所有**属性（子类可能比查询类具有更多属性）

### 操作：core/get

搜索对象列表。

示例：

传递以下 json_data：

```json
{
   "operation": "core/get",
   "class": "Person",
   "key": "SELECT Person WHERE email LIKE '%.com'",
   "output_fields": "friendlyname, email"
}
```

或者，使用另一种形式的 "key"：

```json
{
   "operation": "core/get",
   "class": "Person",
   "key": 1,
   "output_fields": "*"
}
```

自 2.6.1（PR #25，感谢 Dennis Lassiter！）起，使用两个新参数处理分页：

- `limit`（整数）：要返回的结果数量（默认：0 = 无限制）
- `page`（整数）：要返回的页码（不能 < 1）

记录排序可以使用 classes/class/properties/order 数据模型 XML 节点控制。

示例：

```json
{
   "operation": "core/get",
   "class": "Person",
   "key": "SELECT Person",
   "output_fields": "friendlyname, email",
   "limit": "5",
   "page": "2"
}
```

### 操作：core/create

创建给定类的新对象。

传递以下 json_data：

```json
{
   "operation": "core/create",
   "comment": "Synchronization from blah...",
   "class": "UserRequest",
   "output_fields": "id, friendlyname",
   "fields":
   {
      "org_id": "SELECT Organization WHERE name = \"Demo\"",
      "caller_id":
      {
         "name": "monet",
         "first_name": "claude"
      },
      "title": "Houston, got a problem!",
      "description": "The fridge is empty"
   }
}
```

… 将导致创建一个新的用户请求。

某些属性具有特殊格式：

- 链接集：目前仅支持间接链接集，请参阅上面给出的示例
- Blobs：文档内容（例如 DocumentFile/file）必须采用 `{data: base64-encoded-data, mimetype: …, filename: …}` 的形式
- 案例日志：允许三种形式。传递字符串等同于从 GUI 中添加新消息：消息代表当前用户（用于调用 Web 服务的凭据）记录。传递形式为 `{add_item: {message: 'blah', user_id: 123, date:'2012-02-28 10:30'}}` 的结构也会添加单条消息。user_id 和 date 是可选的，分别默认为当前用户和当前日期时间。指定 user_id 要求用于调用服务的凭据具有管理员权限，否则操作将失败并返回 UNAUTHORIZED 错误代码。传递形式为 `{items: [ {message: 'blah'} ]}` 的结构将设置整个日志。

响应示例：

```json
{
   "code": 0,
   "message": "",
   "objects":
   {
      "UserRequest::123":
      {
         "code": 0,
         "message": "created",
         "class": "UserRequest",
         "key": 29,
         "fields":
         {
            "id": 29,
            "friendlyname": "R-000029"
         }
      }
   }
}
```

### 操作：core/update

更新一个对象。

传递以下 json_data：

```json
{
   "operation": "core/update",
   "comment": "Synchronization from blah...",
   "class": "UserRequest",
   "key":
   {
      "description": "The fridge is empty"
   },
   "output_fields": "friendlyname, title, contacts_list",
   "fields":
   {
      "contacts_list":
      [
         {
            "role": "pizza delivery",
            "contact_id":
            {
               "finalclass": "Person",
               "name": "monet",
               "first_name": "claude"
            }
         }
      ]
   }
}
```

… 将通过将联系人列表设置为一个联系人（Claude Monet）和角色 'pizza delivery' 来更新用户请求（通过其描述 "The fridge is empty" 标识）。

### 操作：core/apply_stimulus

更新一个对象并应用刺激以更改对象的状态。

传递以下 json_data：

```json
{
   "operation": "core/apply_stimulus",
   "comment": "Synchronization from blah...",
   "class": "UserRequest",
   "key": 15,
   "stimulus": "ev_assign",
   "output_fields": "friendlyname, title, status, contacts_list",
   "fields":
   {
      "team_id": 18,
      "agent_id": 57
   }
}
```

… 将通过设置 `agent_id` 和 `team_id` 字段（对于状态 assigned 是必填的）来更新用户请求（通过其键 "15" 标识），然后应用刺激 `ev_assign`，使工单从状态 new 转换到状态 assigned。

### 操作：core/delete

删除一组对象。

传递以下 json_data：

```json
{
   "operation": "core/delete",
   "comment": "Cleanup for customer Demo",
   "class": "UserRequest",
   "key":
   {
      "org_id": 2
   },
   "simulate": false
}
```

… 将删除客户 #2 的用户请求。

每个报告的对象都有一个删除状态代码和一个提供附加信息的消息。状态代码在 `core/restservices.class.inc.php` 中定义，作为 RestDelete 类的常量：

| 值 | 常量 | 含义 |
|----|------|------|
| 0 | OK | 根据初始请求删除对象 |
| 1 | ISSUE | 一般问题（用户权限或…？） |
| 2 | AUTO_DELETE | 必须删除以保留数据库完整性 |
| 3 | AUTO_DELETE_ISSUE | 必须删除以保留数据库完整性，但不可能 |
| 4 | REQUEST_EXPLICITELY | 必须删除以保留数据库完整性，但必须显式请求 |
| 5 | AUTO_UPDATE | 必须更新以保留数据库完整性 |
| 6 | AUTO_UPDATE_ISSUE | 必须更新以保留数据库完整性，但不可能 |

### 操作：core/get_related

搜索相关对象。

给定一个对象或对象列表，搜索其他受这些对象影响或影响这些对象的对象。

传递以下 json_data：

```json
{
   "operation": "core/get_related",
   "class": "Server",
   "key": 1,
   "relation": "impacts",
   "depth": 4,
   "redundancy": true,
   "direction": "down"
}
```

… 将搜索 Server::1 影响的所有 CI。搜索深度限制为 4 次迭代（默认为 20）。

结果将如下所示：

```json
{
   "objects":
   {
      "objectclass::objectkey":
      {
         ...
      }
   },
   "relations":
   {
      "origin-class::origin-key":
      [
         {
            "key": "destination-class::destination-key"
         }
      ]
   },
   "code": 0,
   "message": "Scope: 1; Found: Server=4, VirtualMachine=3, Farm=1"
}
```

### 操作：core/check_credentials

检查用户登录名 + 密码。

传递以下 json_data：

```json
{
   "operation": "core/check_credentials",
   "user": "john",
   "password": "abc123"
}
```

… 将回复（如果一切顺利）…

```json
{
   "code": 0,
   "message": "",
   "authorized": true
}
```

## 示例和游乐场

如果您已经安装了 iTop（版本 2.0.1+），则可以[点击此处测试 REST API](https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:rest_json_playground)。

以下是如何集成 REST/JSON 调用的示例：使用 bash 和 wget

### 使用配置文件创建用户

当创建对象需要 n:n 关系时，该对象的创建必须包括链接对象的创建。这在 iTop 标准数据模型中很少见，但它仍然存在于创建 User 对象时。

使用的语法有点棘手，因为链接创建不能提供 userid：

```json
{
   "operation": "core/create", 
   "comment": "Created", 
   "class": "UserLocal", 
   "output_fields": "id", 
   "fields": {
      "contactid": 169, 
      "login": "MyUser123",
      "password": "123456", 
      "language": "EN US", 
      "status": "enabled", 
      "profile_list": [{"profileid": "MyProfileID"}]
   }
}
```

### 管理附件

请参阅[使用 REST/JSON 管理对象附件](../07-rest_json_attachment/)。

### 管理内联图像

通过 REST/JSON 添加内联图像

## 如何添加服务

可以通过开发声明类（包含在您的自定义模块中）实现接口 `iRestServiceProvider` 的模块（或扩展）来扩展服务。

一旦您的模块安装完毕，您的自定义服务将可用，并与 `operation=list_operations` 一起列出。

## 变更历史

| iTop 版本 | JSON REST 版本 | 变更 |
|-----------|----------------|------|
| 2.0.1 | 1.0 | 创建 |
| 2.0.2 | 1.1 | 向返回的对象信息添加 'key'（在 1.0 中需要一些解析），将对象搜索条件转换为严格搜索（而不是松散搜索：包含…），允许重置外部键（设置为 0，表示"未定义"） |
| 2.0.3 | 1.2 | 完全处理案例日志（可以完全读取或写入），枚举/GET 给出原始值而不是本地化标签，允许 HTTP 基本认证方法，添加动词 core/check_credentials，改进错误报告（缺少认证参数、写入链接集的错误类），添加选项 `*+` 以输出对象的所有字段（不仅仅是查询类的字段），修复对象删除报告 |
| 2.2.0 | 1.3 | 动词 get_related：添加选项 redundancy 和 direction 以考虑影响分析中的冗余。出于安全原因，现在禁止使用具有 Portal User 配置文件的用户账户使用 REST/JSON Web 服务。如果您仅使用其中一个 Web 服务来检查用户的凭据，请调整您的代码以使用 core/check_credentials 操作。出于安全原因，core/get 和 core/get_related 操作现在仅允许对指定类对象具有批量读取权限的用户。 |
| 2.5.2, 2.6.1, 2.7.0 | 1.4 | 动词 core/get：添加分页参数 limit 和 page |

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:rest_json>

版本：3_2_0/advancedtopics/rest_json.txt · Last modified: 2024/12/11 19:02 by 127.0.0.1
