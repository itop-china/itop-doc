---
title: "从父对象继承服务"
linkTitle: "从父对象继承服务"
date: 2025-06-27
weight: 10
description: >
  从父对象继承服务。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现子组织从父组织继承服务的功能。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:service-heritage)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

使子组织能够继承父组织的服务。需要修改：

- Console 中用户请求编辑时建议的服务列表
- 检索用于计算 TTO 和 TTR 截止时间的适用 SLT 的方式
- 检索用于计算 TTO 和 TTR 截止时间的适用 Coverage Window 的方式
- Portal 中允许的服务和服务子目录列表

## 数据模型

修改 `UserRequest` 和/或 `Incident` 类的 `service_id` 字段的 filter：

```xml
<field id="service_id" xsi:type="AttributeExternalKey">
  <filter _delta="redefine">
    <![CDATA[
      SELECT Service AS s JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
      JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
      JOIN Organization AS root ON cc.org_id = root.id 
      JOIN Organization AS child ON child.parent_id BELOW root.id 
      WHERE child.id = :this->org_id AND s.status != 'obsolete'  
    ]]>
  </filter>
</field>
```

## 适用 SLT

修改检索适用 SLT 的查询：

```xml
<constants>
  <constant id="RESPONSE_TICKET_SLT_QUERY" xsi:type="string" _delta="redefine"><![CDATA[
    SELECT SLT AS slt 
    JOIN lnkSLAToSLT AS l1 ON l1.slt_id=slt.id 
    JOIN SLA AS sla ON l1.sla_id=sla.id 
    JOIN lnkCustomerContractToService AS l2 ON l2.sla_id=sla.id 
    JOIN CustomerContract AS sc ON l2.customercontract_id=sc.id 
    JOIN Organization AS root ON sc.org_id = root.id 
    JOIN Organization AS child ON child.parent_id BELOW root.id 
    WHERE slt.metric = :metric AND l2.service_id = :this->service_id 
    AND child.id = :this->org_id AND slt.request_type = :request_type 
    AND slt.priority = :this->priority
  ]]></constant>
</constants>
```

检索到的 SLT 用于计算拥有或解决特定工单的截止时间，以保持在 SLA 范围内。更多详情参见[按服务子目录的 SLA](https://www.itophub.io/wiki/page?id=3_2_0:customization:sla-service-subcategory) 教程。

## 适用 Coverage Window

需要在配置文件中修改模块 `combodo-sla-computation` 的 `coverage_oql` 参数。该参数是一个 OQL 查询，检索当前工单的适用 CoverageWindow。

替换为以下查询：

```
SELECT CoverageWindow AS cw 
  JOIN lnkCustomerContractToService AS l1 ON l1.coveragewindow_id = cw.id
  JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
  JOIN Organization AS root ON cc.org_id=root.id
  JOIN Organization AS child ON child.parent_id BELOW root.id
WHERE child.id= :this->org_id 
AND l1.service_id = :this->service_id
```

逻辑：
- 获取任何组织的客户合同
- 该组织在组织树中位于工单组织之下
- 工单组织是组织树中的子组织

## 增强门户

默认门户中定义的服务和服务子目录范围限制了可见性，需要修改这些范围，使门户用户能够查看（和选择）其用户组织或任何上级组织购买的服务。

```xml
<module_design id="itop-portal">
  <classes>
    <class id="ServiceFamily">
      <scopes>
        <scope id="all">
          <oql_view _delta="redefine"><![CDATA[SELECT ServiceFamily AS sf 
          JOIN Service AS s ON s.servicefamily_id = sf.id
          JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
          JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
          JOIN Organization AS root ON cc.org_id = root.id 
          JOIN Organization AS child ON child.parent_id BELOW root.id 
          WHERE child.id = :current_contact->org_id AND s.status != 'obsolete']]></oql_view>
        </scope>
      </scopes>
    </class>
    <class id="Service">
      <scopes>
        <scope id="all">
          <oql_view _delta="redefine"><![CDATA[SELECT Service AS s 
          JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
          JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
          JOIN Organization AS root ON cc.org_id = root.id 
          JOIN Organization AS child ON child.parent_id BELOW root.id 
          WHERE child.id = :current_contact->org_id AND s.status != 'obsolete']]></oql_view>
        </scope>
      </scopes>
    </class>
    <class id="ServiceSubcategory">
      <scopes>
        <scope id="all">
          <oql_view _delta="redefine"><![CDATA[SELECT ServiceSubcategory AS ss
            JOIN Service AS s ON ss.service_id=s.id
          JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
          JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
          JOIN Organization AS root ON cc.org_id = root.id 
          JOIN Organization AS child ON child.parent_id BELOW root.id 
          WHERE child.id = :current_contact->org_id  AND s.status != 'obsolete']]></oql_view>
        </scope>
      </scopes>
    </class>
  </classes>
</module_design>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:service-heritage>

版本：3_2_0/customization/service-heritage.txt · Last modified: 2024/12/04 11:58 by 127.0.0.1
