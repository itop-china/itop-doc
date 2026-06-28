---
title: "持久化统计 n:n"
linkTitle: "持久化统计 n:n"
date: 2025-06-27
weight: 10
description: >
  持久化统计 n:n。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中持久化存储 n:n 关系的计数，例如在团队上统计成员数量。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:count-linkset-indirect)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

在对象 A 的详情中显示通过多对多关系链接到对象 A 的对象 B 的数量。本示例使用 Team 与 Person 的关系，在 Team 上存储团队成员数量。

- `lnkPersonToTeam` 类有 `person_id` 和 `team_id` 外键，存储多对多关系
- `Team` 上有 `persons_list` 字段，提供链接到该团队的人员列表
- `Person` 上有 `teams_list` 字段，提供链接到该人员的团队列表
- 需要在 `Team` 类上创建 `persons_count` 字段，存储团队中的人员数量

需要支持：

- 在 A 对象列表中查看此计数
- 通过 OQL 查询轻松查找具有超过 10 个相关 B 对象的 A 对象

## iTop 3.1.1+ 方式

使用事件机制，订阅特定事件并在事件触发时执行方法。

### 计算成员

```php
public function CountMembers(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $oLnkSet = $this->Get('persons_list');
    if (is_object($oLnkSet)) {
        $this->Set('persons_count', $oLnkSet->Count());
        $this->DBUpdate();
    }
}
```

### 处理字段

```xml
<class id="Team" _delta="must_exist">
  <fields>
    <field id="persons_list" _delta="must_exist">
      <with_php_computation>true</with_php_computation>
    </field>
    <field id="persons_count" xsi:type="AttributeInteger" _delta="define">
      <sql>persons_count</sql>
      <default_value>0</default_value>
      <is_null_allowed>false</is_null_allowed>
    </field>
  </fields>
</class>
```

### 订阅事件

```xml
<class id="Team"  _delta="must_exist">
  <event_listeners>
    <event_listener id="CountMembers" _delta="define">
      <event>EVENT_DB_LINKS_CHANGED</event>
      <callback>CountMembers</callback>
      <rank>0</rank>
    </event_listener>
  </event_listeners>
</class>
```

## 3.1.1 之前的方式

这种方式更复杂。需要确定何时计算什么。

### 在 Team 上

添加计数器字段：

```xml
<class id="Team" _delta="must_exist">
  <fields>
    <field id="persons_count" xsi:type="AttributeInteger" _delta="define">
      <sql>persons_count</sql>
      <default_value>0</default_value>
      <is_null_allowed>false</is_null_allowed>
    </field>
  </fields>
</class>
```

创建函数：

```php
public function ComputeValues()
{
        $this->ComputePersons();
}
 
public function ComputePersons($iDelta=0)
{
    if ($iDelta==0)
    {
        $oSet = $this->Get('persons_list');
        $i = $oSet->count();
    }
    else
    {
        $i = $this->Get('persons_count') + $iDelta;
    }
    $this->Set('persons_count', $i);
    return $i;
}
```

### 在链接对象上

#### 创建

- 要求 Team 重新计算其计数

#### 修改

需要考虑所有可能的变更：

- 团队变更：旧团队减一，新团队加一

#### 删除

- 要求 Team 从其计数中减一

```php
public function UpdateRemote($iTeamId, $iDelta = 0)
{
    $oTeam = MetaModel::GetObject('Team', $aChanges['Team'], false, true);
    if (is_object($oTeam ))
    {
        $oTeam->ComputePersons($iDelta);
        $oTeam->DBUpdate();
    }
}
 
protected function AfterInsert()
{
        $this->UpdateRemote($this->Get('team_id'), 1);
}
 
protected function AfterUpdate()
{
    $aChanges = $this->ListPreviousValuesForUpdatedAttributes();
 
    if (array_key_exists('team_id', $aChanges))
    {
         $this->UpdateRemote($aChanges['team_id'], -1);
         $this->UpdateRemote($this->Get('team_id'), 1);
     }
}
 
protected function AfterDelete()
{
         $this->UpdateRemote($this->Get('team_id'), -1);
}
```

### 在 Person 上

- 人员创建 → 通过关联链接的创建处理
- 人员删除 → 通过关联链接的级联删除处理

无需额外操作！

### 通用 UpdateCounter 函数

```php
/**
 * @param $id 远程对象的 ID
 * @param $sClass 远程对象的类名
 * @param $sCounterCode 远程类上存储关系计数的属性代码
 * @param $iDelta 添加到计数器的数值（可为负数）
 */
public function UpdateCounter($id, $sClass, $sCounterCode, $iDelta=0)
{
    if (in_array($sCounterCode,MetaModel::GetAttributesList($sClass)))
    {
        $oObject = MetaModel::GetObject($sClass, $id, false, true);
        if (is_object($oObject ) && ($iDelta!=0))
        {
            $i = $oObject->Get($sCounterCode) + $iDelta;
            $oObject->Set($sCounterCode, $i);
            $oObject->DBUpdate();      
        }
    }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:count-linkset-indirect>

版本：3_2_0/customization/count-linkset-indirect.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
