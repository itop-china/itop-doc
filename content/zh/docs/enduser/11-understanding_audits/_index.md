---
title: "理解审计"
linkTitle: "理解审计"
date: 2023-08-27
weight: 11
description: >
      <br> ➡️ 介绍审计的作用。
---

{{% pageinfo %}}
**审计**是iTop的一项功能，旨在检查iTop数据库中存储的信息的一致性。审计用于回答诸如：“我们是否为生产中的任何设备定义了活动的支持合同？”或“我们是否知道所有服务器的本地化以便进行现场支持？”

[![简单审计报告示例](https://www.itophub.io/wiki/media?w=450&tok=0d7026&media=3_1_0:user:audit-report.png "简单审计报告示例")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:audits&media=3_1_0:user:audit-report.png "3_1_0:user:audit-report.png")

这些验证被称为**审计规则**。

**审计规则**分组成**审计类别**。类别定义了必须符合规则的对象（范围）的列表。此范围是动态计算的。换句话说，当显示审计页面时，计算要检查的对象列表。

**审计规则**定义了需要检查范围内每个对象的实际约束。例如，“设备必须连接到至少一个启用的供应商合同”。

要添加或修改**审计类别**或**审计规则**，请向您的iTop管理员询问。只有管理员被允许管理审计类别和规则。

{{% /pageinfo %}}

## 理解审计报告

通过单击**_数据管理_**菜单中的**_审计_**链接，可以交互地运行审计。

[![审计报告解释](https://www.itophub.io/wiki/media?w=500&tok=f49636&media=3_1_0:user:audit-report2.png "审计报告解释")](https://www.itophub.io/wiki/media-detail?id=3_1_0:user:audits&media=3_1_0:user:audit-report2.png "3_1_0:user:audit-report2.png")

审计报告列出了所有需要审计的类别。对于每个类别，标题行包含：

*   该类别中的对象数量
    
*   具有**至少一个错误**的对象数量（由该类别中的规则报告）
    
*   该类别中没有任何错误的对象的百分比
    
*   然后，对于每个规则，附加行指示：
    
    *   有关该规则的错误对象数量。单击**_数字_**会显示错误对象列表。
        
    *   该规则下没有错误的对象的百分比

>> [批量修改](../10-bulk_modifications/)  ← 上一篇 | 下一篇 → [废弃对象](../12-obsolete_object/) 
---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:user:audits>

版本：3_1_0/user/audits.txt · Last modified: 2023/07/21 10:19 (external edit)