---
title: "废弃对象"
linkTitle: "废弃对象"
date: 2023-08-27
weight: 12
description: >
    <br> ➡️ 介绍废弃对象。
---

{{% pageinfo %}}

iTop 2.4引入了数据模型，现在每个对象类都定义了一个[废弃](https://www.itophub.io/wiki/page?id=3_1_0:feature:obsolescence "3_1_0:feature:obsolescence")概念，通过高亮显示/隐藏废弃对象来提高用户体验。

{{% /pageinfo %}}

## 高亮显示废弃对象

废弃的对象会在控制台中进行标记，通过图标和标签使此显而易见。

在列表上： [![](https://www.itophub.io/wiki/media?w=600&tok=6b2624&media=3_1_0:user:obsolescence-list-hypervisor.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:obsolescence-list-hypervisor.png "3_1_0:user:obsolescence-list-hypervisor.png")

在对象上： [![](https://www.itophub.io/wiki/media?w=500&tok=1177cc&media=3_1_0:user:obsolescence-details-hypervisor.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:obsolescence-details-hypervisor.png "3_1_0:user:obsolescence-details-hypervisor.png")

## 改进的影响分析

废弃对象在影响分析中被忽略。

废弃`ESX1`之前： [![](https://www.itophub.io/wiki/media?w=500&tok=8c7ed2&media=3_1_0:user:obsolescence-impactanalyses-before2-4.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:obsolescence-impactanalyses-before2-4.png "3_1_0:user:obsolescence-impactanalyses-before2-4.png")

废弃`ESX1`之后： [![](https://www.itophub.io/wiki/media?w=500&tok=50c1f0&media=3_1_0:user:obsolescence-impactanalyses-after2-4.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:obsolescence-impactanalyses-after2-4.png "3_1_0:user:obsolescence-impactanalyses-after2-4.png")

## 隐藏废弃对象

基于用户偏好，从iTop控制台的**显示列表**中移除定义为废弃的对象。

**废弃对象详情**不会考虑用户偏好而显示。 [![](https://www.itophub.io/wiki/media?w=500&tok=89fb02&media=3_1_0:user:obsolescence-userpreference.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:obsolescence-userpreference.png "3_1_0:user:obsolescence-userpreference.png")

>> ![警告](/docs/images/warning.png) <font style="color: #ff9999">请小心使用此用户偏好，它确实隐藏了现有对象：</font>

### 修改模式

*   在详细信息界面上，下拉列表：不会提供废弃对象。

*   在关系选项卡中，不会显示废弃对象，因此无法删除。
    
*   在关系选项卡中，无法添加废弃对象。
    

#### 其他显示差异

*   **搜索菜单**和**快捷方式**显示不包含废弃对象的列表
    
*   **组件**不包括废弃对象
    
*   **全局搜索**不返回废弃对象
    
*   批量修改不会修改废弃对象
    
*   **审计**不会在废弃对象上报告审计错误
    
*   **运行查询**不返回废弃对象
    
*   **CSV导出**应返回不包含废弃对象的列表

在此模式下仍然可以通过**CSV导入**废弃对象

>> [理解审计](../11-understanding_audits/)  ← 上一篇 | 下一篇 → [Excel报表](../13-reports_in_excel/) 
---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:obsolescence>

版本：3_1_0/user/obsolescence.txt · Last modified: 2023/07/21 10:19 (external edit)

