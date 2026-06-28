---
title: "LDAP 人员同步"
linkTitle: "LDAP 人员同步"
date: 2025-06-27
weight: 9
description: >
  <br> ➡️ 从 LDAP 目录同步人员信息到 iTop
---

{{% pageinfo %}}

本指南演示如何从 LDAP 目录同步人员信息到 iTop。

{{% /pageinfo %}}

## 先决条件

您需要：

- 了解如何从 LDAP 服务器提取人员信息并将其保存到 .CSV 文件
- 拥有一个 iTop 系统（安装了演示数据），并可以访问管理员账户
- 了解如何使用命令行连接到您的 iTop Web 服务器

## 本教程的目标

在本教程中，您将学习如何：

- 创建和配置用于将一类对象同步到 iTop 中的同步数据源
- 将外部数据输入并同步到此同步数据源
- 理解同步状态报告

## 分步说明

### 初始配置

在这里，您将创建同步数据源。

在**管理工具**菜单中，点击**同步数据源**。

点击**创建新的同步数据源**。

在以下屏幕中，在适当的字段中输入**名称**（来自 LDAP 的人员）、**目标类**（Person）和**用户**（admin）。

点击**创建**按钮以创建数据源。

数据源创建完成后，点击右上角的**修改（铅笔）**并编辑**属性**选项卡。

### 第一次同步：初始加载

然后在 iTop 根目录下的 "data" 目录中创建文本文件 "persons.csv"，内容如下：

```csv
primary_key;name;first_name;org_id;email;status;function;phone;notify
1;Monet;Claude;Demo;claude.monet@demo.com;Active;Manager;+33123456789;Yes
2;Flaubert;Gustave;IT Department;gustave.flaubert@demo.com;Active;;+33987654321;No
```

在 iTop 根目录中从命令行启动以下命令：

```bash
php synchro/synchro_import.php --auth_user=admin --auth_pwd=admin --csvfile=./data/persons.csv --data_source_id=1 --output=summary
```

- auth_user：您的 iTop 登录名
- auth_pwd：您的 iTop 密码
- data_source_id：上面创建的同步数据源的标识符

预期输出：

```
#Load--------------
#------------------
#Data Source: 1
#Synchronize: 1
#Class: Person
#Separator: ;
#Qualifier: "
#Charset Encoding:UTF-8
#Date format: <none>
#Data Size: 228
#Data Lines: 2
#Columns: primary_key, name, first_name, org_id, email, status, function, phone, notify
#Output format: summary
#Simulate: 0
#Change tracking comment: 
#Issues (before synchro): 0
#Created (before synchro): 2
#Updated (before synchro): 0
#Synchronization---
#------------------
#Replicas: 2
#Replicas touched since last synchro: 2
#Objects deleted: 0
#Objects deletion errors: 0
#Objects obsoleted: 0
#Objects obsolescence errors: 0
#Objects created: 0 (0 warnings)
#Objects creation errors: 0
#Objects updated: 0 (0 warnings)
#Objects update errors: 0
#Objects reconciled (updated): 2 (0 warnings)
#Objects reconciled (unchanged): 0 (0 warnings)
#Objects reconciliation errors: 0
#Replica disappeared, no action taken: 0
```

检查同步数据源的状态（如果需要，请按"刷新"图标）

您可以看到 2 个人员已更新。

导航到联系人 "Claude Monet" 的详细信息，您可以看到此对象现在已同步：

检查"活动面板"以查看最近的更改：

如果您尝试修改人员，您可以看到其大多数属性都被锁定：

### 第二次同步：更新联系人

修改文件 "persons.csv"，将 Claude Monet 的职能从 "Manager" 更改为 "Famous painter"。修改 iTop 根目录下 data 目录中的文本文件 "persons.csv"，内容如下：

```csv
primary_key;name;first_name;org_id;email;status;function;phone;notify
1;Monet;Claude;Demo;claude.monet@demo.com;Active;Famous painter;+33123456789;Yes
2;Flaubert;Gustave;IT Department;gustave.flaubert@demo.com;Active;;+33987654321;No
```

使用相同的命令再次启动导入和同步：

```bash
php synchro/synchro_import.php --auth_user=admin --auth_pwd=admin --csvfile=./data/persons.csv --data_source_id=1 --output=summary
```

输出如下：

```
#Load--------------
#------------------
#Data Source: 1
#Synchronize: 1
#Class: Person
#Separator: ;
#Qualifier: "
#Charset Encoding:UTF-8
#Date format: <none>
#Data Size: 235
#Data Lines: 2
#Columns: primary_key, name, first_name, org_id, email, status, function, phone, notify
#Output format: summary
#Simulate: 0
#Change tracking comment: 
#Issues (before synchro): 0
#Created (before synchro): 0
#Updated (before synchro): 2
#Synchronization---
#------------------
#Replicas: 2
#Replicas touched since last synchro: 2
#Objects deleted: 0
#Objects deletion errors: 0
#Objects obsoleted: 0
#Objects obsolescence errors: 0
#Objects created: 0 (0 warnings)
#Objects creation errors: 0
#Objects updated: 1 (0 warnings)
#Objects update errors: 0
#Objects reconciled (updated): 0 (0 warnings)
#Objects reconciled (unchanged): 0 (0 warnings)
#Objects reconciliation errors: 0
#Replica disappeared, no action taken: 0
```

同步输出表明只有 1 个对象已更新。这也可以在同步数据源的"状态"选项卡上查看：

然后导航到人员 "Claude Monet" 的详细信息：

### 第三次同步：创建新联系人

接下来，在 iTop 根目录下 data 目录中的文本文件 "persons.csv" 末尾添加一行：

```csv
primary_key;name;first_name;org_id;email;status;function;phone;notify
1;Monet;Claude;Demo;claude.monet@demo.com;Active;Famous painter;+33123456789;Yes
2;Flaubert;Gustave;IT Department;gustave.flaubert@demo.com;Active;;+33987654321;No
3;Mondrian;Piet;Demo;p.m@demo.com;Active;;+334433221100;No
```

使用相同的命令再次启动导入和同步：

```bash
php synchro/synchro_import.php --auth_user=admin --auth_pwd=admin --csvfile=./data/persons.csv --data_source_id=1 --output=summary
```

输出如下：

```
#Load--------------
#------------------
#Data Source: 1
#Synchronize: 1
#Class: Person
#Separator: ;
#Qualifier: "
#Charset Encoding:UTF-8
#Date format: <none>
#Data Size: 294
#Data Lines: 3
#Columns: primary_key, name, first_name, org_id, email, status, function, phone, notify
#Output format: summary
#Simulate: 0
#Change tracking comment: 
#Issues (before synchro): 0
#Created (before synchro): 1
#Updated (before synchro): 2
#Synchronization---
#------------------
#Replicas: 3
#Replicas touched since last synchro: 3
#Objects deleted: 0
#Objects deletion errors: 0
#Objects obsoleted: 0
#Objects obsolescence errors: 0
#Objects created: 1 (0 warnings)
#Objects creation errors: 0
#Objects updated: 0 (0 warnings)
#Objects update errors: 0
#Objects reconciled (updated): 0 (0 warnings)
#Objects reconciled (unchanged): 0 (0 warnings)
#Objects reconciliation errors: 0
#Replica disappeared, no action taken: 0
```

同步输出表明只有 1 个对象已更新。这也可以在同步数据源的"状态"选项卡上查看：

使用页面左上角的全局搜索搜索 "Contact:Piet"，然后点击对象名称以显示其详细信息。

### 第四次同步：错误案例

然后在 iTop 根目录下 "data" 目录中的文本文件 "persons.csv" 末尾再添加一行：

```csv
primary_key;name;first_name;org_id;email;status;function;phone;notify
1;Monet;Claude;Demo;claude.monet@demo.com;Active;Famous painter;+33123456789;Yes
2;Flaubert;Gustave;IT Department;gustave.flaubert@demo.com;Active;;+33987654321;No
3;Mondrian;Piet;Demo;p.m@demo.com;Active;;+334433221100;No
4;Klimt;Gurstav;Test;gustav.klimt@demo.com;Active;;+335566778899;No
```

使用相同的命令再次启动导入和同步：

```bash
php synchro/synchro_import.php --auth_user=admin --auth_pwd=admin --csvfile=./data/persons.csv --data_source_id=1 --output=summary
```

输出如下：

```
#Load--------------
#------------------
#Data Source: 5
#Synchronize: 1
#Class: Person
#Separator: ;
#Qualifier: "
#Charset Encoding:UTF-8
#Date format: <none>
#Data Size: 361
#Data Lines: 4
#Columns: primary_key, name, first_name, org_id, email, status, function, phone, notify
#Output format: summary
#Simulate: 0
#Change tracking comment: 
#Issues (before synchro): 0
#Created (before synchro): 1
#Updated (before synchro): 3
#Synchronization---
#------------------
#Replicas: 4
#Replicas touched since last synchro: 4
#Objects deleted: 0
#Objects deletion errors: 0
#Objects obsoleted: 0
#Objects obsolescence errors: 0
#Objects created: 0 (0 warnings)
#Objects creation errors: 1
#Objects updated: 0 (0 warnings)
#Objects update errors: 0
#Objects reconciled (updated): 0 (0 warnings)
#Objects reconciled (unchanged): 0 (0 warnings)
#Objects reconciliation errors: 0
#Replica disappeared, no action taken: 0
```

同步输出表明有一个错误。

您可以点击 'Show' 以获取有关刚刚发生的错误的更多详细信息。

然后修改 iTop 根目录下 "data" 目录中的文本文件 "persons.csv"，修复最后一行（将 Test 替换为 Demo）：

```csv
primary_key;name;first_name;org_id;email;status;function;phone;notify
1;Monet;Claude;Demo;claude.monet@demo.com;Active;Famous painter;+33123456789;Yes
2;Flaubert;Gustave;IT Department;gustave.flaubert@demo.com;Active;;+33987654321;No
3;Mondrian;Piet;Demo;p.m@demo.com;Active;;+334433221100;No
4;Klimt;Gurstav;Demo;gustav.klimt@demo.com;Active;;+335566778899;No
```

使用相同的命令再次启动导入和同步：

```bash
php synchro/synchro_import.php --auth_user=admin --auth_pwd=admin --csvfile=./data/persons.csv --data_source_id=1 --output=summary
```

应该没有错误，并且联系人 Gustav Klimt 在 Demo 组织中创建。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:synchro_howto_personsfromldap>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/advancedtopics/synchro_howto_personsfromldap.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
