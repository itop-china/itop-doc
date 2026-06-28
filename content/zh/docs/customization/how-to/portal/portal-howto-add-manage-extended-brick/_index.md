---
title: "添加 Dashlet"
linkTitle: "添加 Dashlet"
date: 2025-06-27
weight: 10
description: >
  添加 Dashlet。
---

{{% pageinfo %}}
本文档介绍如何使用 ManageBrick 在门户中添加 Dashlet。Dashlet 可以是饼图、柱状图、排行榜（top_list）或徽章（badge）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_add_manage_extended_brick)。
{{% /pageinfo %}}

## 概述

在本教程中，我们将使用 ManageBrick 在门户中添加一个 Dashlet。Dashlet 可以是以下类型之一：

- 饼图（pie chart）
- 柱状图（bar chart）
- 排行榜（top list）
- 徽章（badge）

## 前提条件

- 拥有安装了演示数据和增强版门户的 iTop 系统
- 拥有足够权限访问门户的账户（通常需要 "Portal User" 角色）
- 能够修改数据模型定义（创建扩展或使用 ITSM Designer）

## 教程目标

在本教程中，您将学习如何：

- 向现有门户添加一个新的 Dashlet
- 支持多种显示模式：饼图、柱状图、排行榜、徽章

## 示例：进行中工单 ManageBrick

以下 XML 代码将添加一个饼图瓦片到标准用户门户的首页，显示"进行中"与"已解决"工单的分布：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  version="1.0">
  <module_designs>
    <module_design id="itop-portal" xsi:type="portal">
      <bricks>
        <brick id="ongoing-tickets-for-portal-user-ext" xsi:type="Combodo\iTop\Portal\Brick\ManageBrick" _delta="define">
          <active>true</active>
          <rank>
            <default>20</default>
          </rank>
          <width>6</width>
          <title>
            <default>Brick:Portal:OngoingRequests:Title</default>
          </title>
          <description>Brick:Portal:OngoingRequests:Title+</description>
          <decoration_class>
            <default>fa fa-etsy fa-2x</default>
          </decoration_class>
          <oql><![CDATA[SELECT Ticket]]></oql>
          <fields>
            <field id="title"/>
            <field id="start_date"/>
            <field id="status"/>
            <field id="service_id"/>
            <field id="servicesubcategory_id"/>
            <field id="priority"/>
            <field id="caller_id"/>
          </fields>
          <display_modes>
            <availables>
              <mode id="list"/>
              <mode id="pie-chart"/>
              <mode id="bar-chart"/>
            </availables>
            <default>pie-chart</default>
            <tile>badge</tile>
          </display_modes>
          <export>
            <fields>
              <field id="title"/>
              <field id="start_date"/>
              <field id="status"/>
              <field id="service_id"/>
              <field id="servicesubcategory_id"/>
              <field id="priority"/>
              <field id="caller_id"/>
              <field id="description"/>
            </fields>
          </export>
          <grouping>
            <tabs>
              <show_tab_counts>true</show_tab_counts>
              <groups>
                <group id="opened">
                  <rank>1</rank>
                  <title>Brick:Portal:OngoingRequests:Tab:OnGoing</title>
                  <condition><![CDATA[SELECT Ticket AS T WHERE operational_status NOT IN ('closed', 'resolved')]]></condition>
                </group>
                <group id="resolved">
                  <rank>2</rank>
                  <title>Brick:Portal:OngoingRequests:Tab:Resolved</title>
                  <condition><![CDATA[SELECT Ticket AS T WHERE operational_status = 'resolved']]></condition>
                </group>
              </groups>
            </tabs>
          </grouping>
          <data_loading>full</data_loading>
        </brick>
      </bricks>
    </module_design>
  </module_designs>
</itop_design>
```

将上述 XML 放入扩展中，运行安装程序，然后在门户中查看结果。

## 关键配置说明

| 配置项 | 说明 |
|--------|------|
| `display_modes` | 定义数据在 ManageBrick 中的显示方式 |
| `availables` | 可用的显示模式：list、pie-chart、bar-chart |
| `default` | ManageBrick 打开时的默认显示模式 |
| `tile` | 在首页和 AggregatePageBrick 中的显示方式：text、badge、pie-chart、bar-chart、top-list |
| `grouping` | 按标签页对对象进行分组 |
| `show_tab_counts` | 是否显示每个标签页的对象数量 |

## 启用导出到 Excel

您可以在每个 ManageBrick 上添加"导出到 Excel"功能。支持两种方式定义要导出的属性：

### 使用与页面显示相同的属性

```xml
<brick xsi:type="Combodo\iTop\Portal\Brick\ManageBrick">
  <export><export_default_fields>true</export_default_fields></export>
</brick>
```

### 使用特定的导出字段列表

```xml
<brick xsi:type="Combodo\iTop\Portal\Brick\ManageBrick">
  <export>
    <fields>
      <field id="title"/>
      <field id="start_date"/>
      <!-- 更多字段... -->
    </fields>
  </export>
</brick>
```

这将在相应页面上显示导出按钮。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_add_manage_extended_brick>

版本：3_2_0/customization/portal_howto_add_manage_extended_brick.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
