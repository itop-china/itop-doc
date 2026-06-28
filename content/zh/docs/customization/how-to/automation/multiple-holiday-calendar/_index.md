---
title: "按国家的假期 SLA"
linkTitle: "按国家的假期 SLA"
date: 2025-06-27
weight: 10
description: >
  按国家的假期 SLA。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中按国家使用不同的假期日历进行 SLA 计算。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:multiple-holiday-calendar)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已安装 [SLA considering business hours](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 扩展

## 目标

- 在 Coverage Windows 中添加指向 Holidays Calendar 的链接
- 修改 SLA 计算以考虑假期

## 在 Coverage Windows 中添加假期日历链接

在 `CoverageWindow` 类上添加 `holidaycalendar_id` 字段：

```xml
<classes>
  <class id="CoverageWindow" _created_in="combodo-sla-computation" _delta="must_exist">
    <fields>
      <field id="holidaycalendar_id" xsi:type="AttributeExternalKey" _delta="define">
        <sql>holidaycalendar_id</sql>
        <filter>SELECT HolidayCalendar</filter>
        <dependencies/>
        <is_null_allowed>true</is_null_allowed>
        <target_class>HolidayCalendar</target_class>
        <on_target_delete>DEL_MANUAL</on_target_delete>
      </field>
      <field id="holidaycalendar_name" xsi:type="AttributeExternalField" _delta="define">
        <extkey_attcode>holidaycalendar_id</extkey_attcode>
        <target_attcode>name</target_attcode>
      </field>
    </fields>
    <presentation>
      <details _delta="redefine">
        <items>
          <item id="name">
            <rank>10</rank>
          </item>
          <item id="description">
            <rank>20</rank>
          </item>
          <item id="holidaycalendar_id">
            <rank>30</rank>
          </item>
        </items>
      </details>
    </presentation>
  </class>
</classes>
<dictionaries>
  <dictionary id="EN US" _delta="must_exist">
    <entries>
      <entry id="Class:CoverageWindow/Attribute:holidaycalendar_id" _delta="define"><![CDATA[Holiday calendar ]]></entry>
      <entry id="Class:CoverageWindow/Attribute:holidaycalendar_id+" _delta="define"><![CDATA[]]></entry>
      <entry id="Class:CoverageWindow/Attribute:holidaycalendar_name" _delta="define"><![CDATA[Holiday calendar name]]></entry>
      <entry id="Class:CoverageWindow/Attribute:holidaycalendar_name+" _delta="define"><![CDATA[]]></entry>
    </entries>
  </dictionary>
</dictionaries>
```

## 修改 SLA 计算以考虑假期

在 iTop 实例的配置文件中调整 `holidays_oql` 参数：

```php
'combodo-sla-computation' => array (
   'coverage_oql' => 
      'SELECT CoverageWindow AS cw 
       JOIN lnkCustomerContractToService AS l1 ON l1.coveragewindow_id = cw.id 
       JOIN CustomerContract AS cc ON l1.customercontract_id = cc.id 
       WHERE cc.org_id= :this->org_id AND l1.service_id = :this->service_id',
   'holidays_oql' => 
      'SELECT Holiday AS h 
       JOIN HolidayCalendar AS hc ON h.calendar_id=hc.id 
       JOIN CoverageWindow AS cw ON cw.holidaycalendar_id=hc.id 
       JOIN lnkCustomerContractToService AS l1 ON l1.coveragewindow_id=cw.id 
       JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
       WHERE cc.org_id = :this->org_id  AND  l1.service_id = :this->service_id',
),
```

## 创建假期日历并关联到覆盖窗口

创建假期和假期日历，将其关联到覆盖窗口，并调整客户合同。

可以按国家、团队、客户等定义不同的日历。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:multiple-holiday-calendar>

版本：3_2_0/customization/multiple-holiday-calendar.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
