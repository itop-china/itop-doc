---
title: "实施指南"
linkTitle: "实施指南"
date: 2022-11-29
weight: 4
description: >
  本文档解释了iTop实施的关键概念和操作步骤

---

本文档的目的是一步步地描述，对于组织实现iTop必须要创建哪些iTop对象。例如，为了创建用户请求工单，需要确保此请求的发起人存在，并且至少有一个与该客户签订的合同，它定义了交付给客户的服务，等等。本文档解释了在iTop中创建对象的顺序。

为了创建一个 _干净_ 的生产环境，最好安装一个 _不包含_ 示例数据的iTop实例。不过，也可以使用示例数据安装另一个iTop实例，以便快速查看生成一个完整功能实例所需要的基本数据。

以下图解总结了指导流程:

[![iTop on-boarding cheat sheet](https://www.itophub.io/wiki/media?w=400&tok=ba212c&media=3_0_0:implementation:impleguideschema.png "iTop on-boarding cheat sheet")](https://www.itophub.io/wiki/media-detail?id=3_0_0:implementation:start&media=3_0_0:implementation:impleguideschema.png "3_0_0:implementation:impleguideschema.png")

本文档没有详细描述如何使用iTop的所有特性。对于更多使用iTop的细节，参考 “[iTop用户手册](../enduser/)”。

## iTop中创建新的对象
----------------------------

在iTop中有多重创建新对象的方式，这取决于对象的类以及是否希望交互式地、逐个地或者批量地创建对象。通过菜单创建每个对象的对应类的步骤在[数据模型文档](../datamodel/)中详细进行了解释，但是对于管理员来说，有两种更便捷的方法：

*   **通过 CSV 导入**: 如果希望创建同一类对象的多个实例，通常从现有数据集导入它们更容易。“数据管理”菜单下的CSV导入工具就是为此设计的。以CSV格式准备数据：作为文本文件，每行一个对象，值由固定字符(分号、逗号或制表符)分隔。然后通过CSV导入向导引导，将文件加载到iTop中。
    
*   **通过全局检索**: 要创建任何类的新对象，请使用“管理工具”部分的菜单“通用搜索”。执行这个类的对象的搜索，然后使用“操作 / 新建…”弹出菜单来创建类的新实例。
    

## 配置管理
------------------------

[![Configuration Management on-boarding](https://www.itophub.io/wiki/media?w=500&tok=80f8f0&media=3_0_0:implementation:configuration_management.png "Configuration Management on-boarding")](https://www.itophub.io/wiki/media-detail?id=3_0_0:implementation:start&media=3_0_0:implementation:configuration_management.png "3_0_0:implementation:configuration_management.png")

### 创建组织

当计划部署iTop时，要做的首要决定是关于组织的结构。在iTop中，组织主要用于两个目的：从安全的角度来说，描述客户和供应商实体以及划分数据。几乎所有在iTop中加载的对象都与组织有关，因此在将其他对象加载到iTop之前，创建一个合适的组织结构是很重要的。

#### 理解客户和供应商

在iTop中，没有所谓的“客户”或“供应商”，只有“组织”。就像在现实生活中一样，组织是客户还是供应商取决于观察的视角。例如，组织“公司A”可以是“公司B”的客户，同时也是“公司C”的供应商。iTop中的客户/供应商关系使用合同表示。如果有一个合同，“B公司”作为供应商，“A公司”作为客户，那么“A公司”就是“B公司”的客户。

#### 客户合同和供应商合同的不同之处在哪里？

供应商合同是客户合同的稍微简化版本，有两个限制:

*   供应商与服务目录中的任何服务都不相关。
    
*   服务级别协议在供应商合同中记录为一个自由的文本字段，因此不能用于iTop中的自动计算。
    
供应商合同对于记录与第三方供应商的合同(在ITIL术语中称为支持合同)非常有价值，对于这些合同，iTop中不会跟踪任何工单。

当然，可以使用客户合同来描述与第三方供应商的合同关系，但这代表着还必须在iTop中记录该供应商的服务目录。

#### 组织和访问权限

Apart from the customer/provider relations, another reason to create several Organizations in iTop is to restrict access to some areas of the managed data.

In iTop the rights to “read” (or display) objects from the database is defined on a per Organization basis. Each user is given (in the definition of her/his account) the rights to access a set of Organizations.

Organizations can be structured as a hierarchy. When this is the case, the access rights are inherited from the “Parent” Organization to the “Child” Organizations. For example, if “Company A” has two child Organizations: “Company A1” and “Company A2”, then if a user has the rights to access the objects in “Company A”, she/he will also be allowed to access the objects in “Company A1” and “Company A2”. On the other hand, a user who is allowed to access only “Company A1” will be allowed to access neither the objects in “Company A” nor those in “Company A2”.

The rights to “write” (i.e. create, modify or delete) objects are defined only by the profile(s) assigned to the user account. For example the profile “Support Agent” gives the rights to create or modify User Request tickets (but not to delete them).

This means that a user has the same access rights over all Organizations that she/he is allowed to access.

For example, in the current version of iTop, a user cannot have the rights to access the data of the Organizations “Company A” and “Company B” and the rights to create Servers only in “Organisation B”. If she/he is given the rights to create Servers, this will apply to both “Company A” and “Company B”.

### 创建地理位置

The Locations are very useful for grouping object by geography. Even if the location attribute is not a mandatory field when you create a CI in the CMDB, it is strongly recommended to create Locations beforehand and then to track the locations of all CIs.

Carefully plan the creation of the Locations. Locations are difficult to identify (there is no commonly accepted unique identifier for a Location), if your company does not have one already, you may want to put in place a _naming convention_ in order to avoid duplicate Locations in the CMDB.

#### 共享地址位置

In Enterprise environments, even though the split of roles and responsabilities are in favor of creating several sub Organizations, it is often needed to have “shared” locations among several Organizations to document “co-locations”. iTop does not provide - in its standard version - a way to actually “share” objects between Organizations. However, the Locations are “inherited” from parent Organizations to child Organizations in the same manner as the access rights. This means that a Person, a Server or a Network Device belonging to “Company A2” can be located on a Location owned by “Company A”.

### 创建人员

The Persons are very important in iTop as they are used to define all the contacts and their responsibilities. A Person belongs to one and only one organization. A Person can be a member of one or more Team(s), and therefore should be created before trying to setup Teams.

Also, each user record is linked to a Person object. Therefore Persons must be created before loading user accounts into iTop. The user record defines the access rights (and identification method), whereas the Person object defines the information about the contact: name, location, email address, telephone…

### 创建团队

The teams are linked to several types of object, like contracts or tickets, in order to define responsibilities. Teams are also used as “workgroups” for assigning tickets. Teams used for assigning tickets must also have at least one member (the agent to assign the ticket to). The attribute “Role” on the link between a Team and a Person is not mandatory, so you can leave it empty, but it is useful to define the role of the Person in the Team (Team Leader, Manager…).

### 设备和软件配置

Once the structure of the Organizations, the Locations and the contacts (Teams and Persons) have been loaded, you can start to populate the CMDB.

Since the software instances depend on the software types defined in the software catalog and are documented as installed on a particular host, you should start by documenting:

*   The physical infrastructure: Servers, Network Devices, PCs, etc…
    
*   The Software catalog, by creating the needed type of “Software” objects
    

## 服务管理
------------------

Before managing tickets in iTop, the _services catalog_, the _Delivery Models_ and the _contracts_ must be defined. [![Service Management on-boarding](https://www.itophub.io/wiki/media?w=500&tok=e54611&media=3_0_0:implementation:service_management.png "Service Management on-boarding")](https://www.itophub.io/wiki/media-detail?id=3_0_0:implementation:start&media=3_0_0:implementation:service_management.png "3_0_0:implementation:service_management.png")

### 服务目录

The “Services Catalog” is the list of Services that are available from a given provider Organization. The Services Catalog is documented in iTop by creating Service objects, assigned to the given Organization (considered as the provider of the service). Services are organized in a two-level hierarchy, through the two classes of objects: **Service** and **Service Subcategory**. Create the top level Services before loading sub categories.

The third level “Service Family” is used to group Services together and is **mandatory** for the Enhanced Portal.

Once the service catalog (Services and Service Subcategories) is defined, create the Customer Contracts that will link each “customer” Organization to its “providers” by creating one Customer Contract per couple of provider/customer and linking the appropriate Services to the contract.

### 交付模式

The Delivery Model is the object that defines which Team works for which customer. You can use a Delivery Model object to group together all the “support teams” for a given set of Services, or the support Teams dedicated to a particular customer. Each customer Organization must be assigned one, and only one, Delivery Model.

In the standard iTop 2.0 data model, there is no link between Teams and Services. The only limitation when assigning a ticket to a Team is that the Team must be part of the Delivery Model assigned to the Organization which is the customer of the ticket.

For example, if you have the following Teams:

*   **Helpdesk team**: a Team that processes all helpdesk requests/calls.
    
*   **MS Office Support Team**: a Team that processes all support requests about MS Office.
    
*   **Hardware Support Team**: a Team that handles hardware calls (Replacements, new hardware orders)
    
*   **Network Support Team**: a Team that handles network related issues
    
*   **Customer B Helpdesk Team**: a helpdesk team dedicated to Customer B
    
*   **Customer B Hardware Team**: a Team handling hardware calls for Customer B
    

You can then build two different Delivery Models:

*   “Delivery Model 1” composed of:
    
    *   Helpdesk Team
        
    *   MS Office Support Team
        
    *   Network Support Team
        
*   “Delivery Model 2” composed of:
    
    *   Customer B Helpdesk Team
        
    *   Customer B Hardware Team
        
    *   MS Office Team
        

The “Delivery Model 1” will be used by the Organizations “Customer A”, “Customer A1”, “Customer A2” and “Customer C”; whereas “Delivery Model 2” will be used by “Customer B”.

### 服务级别协议和服务级别目标

The definition of Service Level Agreements (SLAs) and Service Level Targets (SLTs) are not mandatory to manage tickets in iTop, but without them iTop can neither compute deadlines for processing a ticket, nor escalate the ticket automatically.

In order to compute whether or not the expected Service Level Agreements are respected, iTop introduces two possible types of metrics called SLTs (Service Level Targets):

*   **TTO (Time To Own)**: the time between the creation of a ticket and its assignment to an Agent.
    
*   **TTR (Time To Resolve)**: the time between the creation of a ticket and its resolution (i.e. measured when the ticket enters the state “resolved”)
    

A SLT defines a duration associated with:

*   A **metric**: either TTO or TTR
    
*   A **type of ticket** (incident or user request)
    
*   A **priority** (since tickets with higher priority should generally be processed more quickly)
    

A SLA is simply defined as a named group of SLTs (for example to distinguish between “Gold” and “Silver” service levels).

The definition of SLAs/SLTs have two effects in iTop:

*   Notifications can be defined for any percentage of the “threshold” associated with one of the metrics (for example one can configure notifications to send an email to the agent working on a ticket when 50% of the Time To Resolve is reached and to the team leader when reaching 75%).
    
*   When 100% of a metric is reached, the ticket is automatically set to a special “escalation” state (there are two specific states defined in the tickets’ life-cycle: Escalation TTO and Escalation TTR). Entering such a state can also be used to trigger specific notifications.
    

For example, one can define the following service level matrix:

| Incidents – Priority High | Incidents – Priority Medium | Requests – Priority High | Requests – Priority Medium |
| --- | --- | --- | --- |
| Time To Own: 5 min | Time To Own: 30 min | Time To Own: 30 min | Time To Own: 4 hours |
| Time To Resolve: 1 hour | Time To Resolve: 4 hours | Time To Resolve: 4 hours | Time To Resolve: n/a |

This would lead to creating 4 SLTs, one for each row of the table. These 4 SLTs can be grouped under one SLA named “Gold Service Level”.

Finally SLAs can be associated to Customer Contracts in order to define the applicable metrics for the contract.

Your iTop instance is now ready to run. You may have a look at the [Configuration of Notifications](https://www.itophub.io/wiki/page?id=3_0_0:admin:notifications "3_0_0:admin:notifications") to setup email notifications for the tickets.



---
原文：<https://www.itophub.io/wiki/page?id=3_0_0:implementation:start> 

版本：3_0_0/implementation/start.txt · Last modified: 2022/01/21 16:52 (external edit)