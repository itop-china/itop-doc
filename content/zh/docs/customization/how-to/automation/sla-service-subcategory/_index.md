---
title: "按服务子目录的 SLA"
linkTitle: "按服务子目录的 SLA"
date: 2025-06-27
weight: 10
description: >
  按服务子目录的 SLA。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中修改 SLA 逻辑，使 SLA 按服务子目录定义而非按客户定义。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:sla-service-subcategory)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

- 了解 TTO（响应时间）和 TTR（解决时间）截止时间如何为特定工单计算
- 了解如何更改计算逻辑

## 标准数据模型中的工作原理

### 数据模型

- [服务管理模块](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)（服务、SLA、合同）

### 计算流程

#### 1. 计算 TTO 和 TTR

当创建或修改用户请求或事件时，iTop 检索所有关联的计时器（默认 Time-To-Own 和 Time-To-Resolve），对每个计时器：

- 启动或停止计时器
- 计算与每个计时器关联的截止时间（如果有）
- 更新计时器子项值

#### 1.2 计算截止时间

如何知道特定 TTO 或 TTR 目标何时达到？

- TTO 和 TTR 使用相同的查询检索适用 SLT，使用 `metric` 参数（TTO 或 TTR），因为 SLT 标记为 TTO 或 TTR
- 它们还可以依赖 CoverageWindow 和 Holidays，使用 [SLAs based on working hours](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 扩展

#### 1.2.1 检索适用 SLT

SLT 告诉 iTop 对当前用户请求或事件应用什么延迟（TTO 或 TTR）。

SLT 检索查询定义为常量：

```xml
<constants>
  <constant id="RESPONSE_TICKET_SLT_QUERY" xsi:type="string" _delta="redefine"><![CDATA[
    SELECT SLT AS slt 
    JOIN lnkSLAToSLT AS l1 ON l1.slt_id=slt.id 
    JOIN SLA AS sla ON l1.sla_id=sla.id 
    JOIN lnkCustomerContractToService AS l2 ON l2.sla_id=sla.id 
    JOIN CustomerContract AS sc ON l2.customercontract_id=sc.id 
    WHERE slt.metric = :metric 
    AND l2.service_id = :this->service_id 
    AND sc.org_id = :this->org_id 
    AND slt.request_type = :request_type 
    AND slt.priority = :this->priority
  ]]></constant>
</constants>
```

```php
$sType=get_class($oTicket);
if ($sType == 'Incident')
    $sRequestType = 'incident';
else
    $sRequestType = $oTicket->Get('request_type');
```

## 修改方案

本教程描述一个特定的自定义数据模型，其中"SLA 按服务子目录定义"，但相同的逻辑适用于不同的数据模型。

### 标准数据模型中的结构

- 不同 SLA 可以应用于每个交付给客户的服务：服务 A 一个 SLA，服务 B 另一个 SLA
- 不同客户可以对同一服务应用不同的 SLA：服务 A 对客户 1 一个 SLA，对客户 2 另一个 SLA
- SLA 由 SLT 组成
- SLT 可以被多个 SLA 复用

### 修改步骤

#### 1. 从 lnkCustomerContractToService 中移除 SLA

- 通过 XML 注入从 `SLA` 类中移除 `customercontracts_list`（不要通过标准 Designer UI 操作，否则会删除链接类）
- 注释或删除 `SLA::CheckToWrite()` 方法

```xml
<class id="SLA" _created_in="itop-service-mgmt" _delta="must_exist">
  <fields>
    <field id="customercontracts_list" xsi:type="AttributeLinkedSetIndirect" _delta="delete"/>
  </fields>
  <methods>
    <method id="DoCheckToWrite" _delta="delete"/>
  </methods>
  <presentation>
    <details _delta="redefine">
      <items>
        <item id="col:col0">
          <items>
            <item id="name"><rank>10</rank></item>
            <item id="org_id"><rank>20</rank></item>
            <item id="description"><rank>30</rank></item>
          </items>
          <rank>10</rank>
        </item>
        <item id="slts_list"><rank>20</rank></item>
      </items>
    </details>
  </presentation>
</class>
```

#### 2. 在 ServiceSubcategory 上添加 SLA

```xml
<class id="ServiceSubcategory" _delta="if_exists">
  <fields>
    <field id="sla_id" xsi:type="AttributeExternalKey" _delta="define">
      <sql>sla_id</sql>
      <target_class>SLA</target_class>
      <on_target_delete>DEL_MANUAL</on_target_delete>
      <is_null_allowed>true</is_null_allowed>
    </field>
  </fields>
</class>
```

#### 3. 强制提供服务子目录

如果希望在工单创建时设置截止时间，则必须提供服务子目录。标准数据模型中它不是必填的，需要修改使其必填。

### 适用 SLT

常量 `RESPONSE_TICKET_SLT_QUERY` 的值必须被覆盖：

```
SELECT SLT AS slt 
JOIN lnkSLAToSLT AS l1 ON l1.slt_id=slt.id 
JOIN SLA AS sla ON l1.sla_id=sla.id 
JOIN ServiceSubcategory AS ss ON ss.sla_id=sla.id 
WHERE slt.metric = :metric 
AND ss.id = :this->servicesubcategory_id 
AND slt.request_type = :request_type 
AND slt.priority = :this->priority
```

### 扩展：SLA considering business hours

如果安装了此扩展并修改了 CoverageWindow 的定义位置（`lnkCustomerContractToService` 类中的 ExternalKey），则需要相应修改配置文件中 `coverage_oql` 参数。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:sla-service-subcategory>

版本：3_2_0/customization/sla-service-subcategory.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
