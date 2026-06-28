---
title: "计划 TTO 开始"
linkTitle: "计划 TTO 开始"
date: 2025-06-27
weight: 10
description: >
  计划 TTO 开始。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现用户请求的"计划 TTO 开始"功能，即允许用户提前创建工单，但仅在到达计划日期后才开始计算 TTO 和 TTR。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

实现以下功能：

- 用户可提前创建用户请求，将其放入队列
- 工单仅在到达计划日期后才开始工作（TTO 和 TTR 在计划日期前不开始计时）

## 实现步骤

### 1. 添加日期字段与新状态

在 `UserRequest` 类中添加：

- 新字段 `planned_date`（计划日期）
- 新状态 `scheduled`（已计划）
- 自动刺激 `ev_autoschedule` 及相关转换

```xml
<classes>
  <class id="UserRequest">
    <fields>
      <!-- 添加计划日期字段 -->
      <field id="planned_date" xsi:type="AttributeDateTime" _delta="define">
        <sql>planned_date</sql>
        <is_null_allowed>true</is_null_allowed>
        <default_value/>
      </field>
      <!-- 向现有状态添加新状态值 -->
      <field id="status" _delta="must_exist">
        <values>
          <value id="scheduled" _delta="define">scheduled</value>
        </values>
      </field>
      <!-- 添加计时器以统计在此状态停留的时间 -->
      <field id="scheduledstopwatch" xsi:type="AttributeStopWatch" _delta="define">
        <states>
          <state id="scheduled">scheduled</state>
        </states>
        <working_time/>
        <thresholds/>
        <always_load_in_tables>true</always_load_in_tables>
      </field>
    </fields>
    <lifecycle>
      <stimuli>
        <!-- 添加新刺激以编程方式改变状态 -->
        <stimulus _delta="define" id="ev_autoschedule" xsi:type="StimulusInternal"/>
      </stimuli>
      <states>
        <state id="new" _delta="must_exist">
          <flags>
            <attribute id="scheduledstopwatch" _delta="define">
              <hidden/>
            </attribute>
          </flags>
          <transitions>
            <!-- 添加第一个转换：将 UserRequest 设置为 "scheduled" -->
            <transition id="ev_autoschedule" _delta="define">
              <stimulus>ev_autoschedule</stimulus>
              <target>scheduled</target>
              <actions/>
            </transition>
          </transitions>
        </state>
        <!-- 定义 "scheduled" 状态的详细信息 -->
        <state id="scheduled" _delta="define">
          <flags>
            <!-- 显示计时器（教学目的） -->
            <attribute id="scheduledstopwatch">
              <read_only/>
            </attribute>
            <!-- 防止修改计划日期 -->
            <attribute id="planned_date" _delta="define">
              <read_only/>
            </attribute>
          </flags>
          <transitions>
            <!-- 添加第二个转换：将 UserRequest 恢复为 "new" -->
            <transition id="ev_autoschedule">
              <stimulus>ev_autoschedule</stimulus>
              <target>new</target>
              <actions/>
            </transition>
          </transitions>
          <inherit_flags_from>new</inherit_flags_from>
        </state>
        <state id="assigned" _delta="must_exist">
          <flags>
            <attribute id="planned_date" _delta="define">
              <read_only/>
            </attribute>
          </flags>
        </state>
      </states>
    </lifecycle>
    <!-- 在用户请求详情中显示计时器 -->
    <presentation>
      <details _delta="must_exist">
        <items>
          <item id="col:col1">
            <items>
              <item id="fieldset:Ticket:moreinfo">
                <items>
                  <item id="scheduledstopwatch" _delta="define">
                    <rank>90</rank>
                  </item>
                </items>
                <rank>20</rank>
              </item>
            </items>
          </item>
        </items>
      </details>
    </presentation>
  </class>
</classes>
<dictionaries>
  <dictionary id="EN US">
    <entries>
      <entry id="Class:UserRequest/Attribute:status/Value:scheduled" _delta="define">
        <![CDATA[Waiting for planned date]]>
      </entry>
      <entry id="Class:UserRequest/Stimulus:ev_autoschedule" _delta="define">
        <![CDATA[Wait for planned date]]>
      </entry>
      <entry id="Class:UserRequest/Attribute:scheduledstopwatch" _delta="define">
        <![CDATA[Scheduled stopwatch]]>
      </entry>
    </entries>
  </dictionary>
</dictionaries>
```

### 2. 自动转换

如果填写了计划日期，则在创建后自动将工单转换为 "scheduled" 状态。在 `UserRequest` 类中添加 PHP 方法：

```php
protected function AfterInsert()
{
   parent::AfterInsert();
   if (!empty($this->Get('planned_date')))
   {
      $this->ApplyStimulus('ev_autoschedule');
   }
}
```

**重要说明**：

- `parent::AfterInsert()` — 调用父类的同名方法，确保不覆盖 Ticket 类中可能已定义的逻辑
- `$this->Get('attribute_code')` — 获取当前对象的属性值，注意属性代码必须存在，否则会报错
- `ApplyStimulus('stimulus_code')` — 应用刺激以触发状态转换

**注意**：使用 `OnInsert()` 代替 `AfterInsert()` 会导致 MySQL 错误（连接过多）。

### 3. 到达日期后自动恢复为 "new" 状态

使用计时器的阈值功能，在目标达成时自动执行方法：

```xml
<field id="scheduledstopwatch" xsi:type="AttributeStopWatch" _delta="define">
  <states>
    <state id="scheduled">scheduled</state>
  </states>
  <goal>ScheduledStart</goal>
  <thresholds>
    <threshold id="100">
      <actions>
        <action>
          <verb>ApplyStimulus</verb>
          <params>
            <param xsi:type="string">ev_autoschedule</param>
          </params>
        </action>
      </actions>
    </threshold>
  </thresholds>
  <always_load_in_tables>true</always_load_in_tables>
</field>
```

定义目标计算类（放在扩展的 `main.my-extension.php` 中）：

```php
class ScheduledStart implements iMetricComputer
{
   public static function GetDescription()
   {
      return "Time to wait before reopening a scheduled ticket";
   }
   public function ComputeMetric($oObject)
   {
      $iDelay = null; /* 返回 'null' 表示无目标 */
      if (MetaModel::IsValidAttCode(get_class($oObject), 'planned_date')
        && (!empty($oObject->Get('planned_date')))
      {
          $oStartDate = new DateTime();
          $oEndDate = new DateTime($oObject->Get('planned_date'));
          $iDelay = $oEndDate->format('U') - $oStartDate->format('U');
          $iDelay = ($iDelay < 0) ? 0 : $iDelay;
      }
      return $iDelay;
   }
}
```

**注意**：未定义 `working_time`，默认使用 24h×365d。

## 局限性

本教程有一些局限性，在[计划用户请求（高级）](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay2)中有进一步探讨。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-activation-delay>

版本：3_2_0/customization/add-activation-delay.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
