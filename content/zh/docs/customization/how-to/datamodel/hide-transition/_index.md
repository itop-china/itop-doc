---
title: "隐藏转换"
linkTitle: "隐藏转换"
date: 2025-06-27
weight: 50
description: >
    使用 EVENT_ENUM_TRANSITIONS 事件回调，根据当前用户身份限制工单的转换操作。
---

{{% pageinfo %}}
本文档介绍如何限制工单的转换操作，仅允许处理人、其经理或管理员执行。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-transition)。
{{% /pageinfo %}}

## 目标

在本教程中，我们将了解如何阻止除处理人、其经理或管理员之外的其他人转换工单。

我们将使用 `EVENT_ENUM_TRANSITIONS` 事件的回调。

## 实现逻辑

1. 获取处理人（agent）的 Person 对象
2. 检查是否处于应隐藏转换的情况：
   - 当前连接用户的 ID（`UserRights::GetContactId()`）既不是 `agent_id` 也不是其 `manager_id`
   - 当前用户不是 iTop 管理员（`!UserRights::IsAdministrator()`）
   - 工单处于 "Assigned" 或 "Pending" 状态
3. 然后使用 `$this->DenyTransition($sStimulusCode)` 移除应受限的激励（stimulus）
   - 可以隐藏不存在的激励，不会产生任何影响

## XML 配置

```xml
<classes>
  <class id="UserRequest">
    <event_listeners>
      <event_listener id="HideTransitionsIfNotAgent" _delta="define">
        <event>EVENT_ENUM_TRANSITIONS</event>
        <rank>10</rank>
        <callback>HideTransitionsIfNotAgent</callback>
      </event_listener>
    </event_listeners>
    <methods>
      <method id="HideTransitionsIfNotAgent" _delta="define">
        <comment>/**
          * 如果当前用户既不是处理人，也不是其经理
          * 且当前用户不是管理员
          * 且 UserRequest 处于某些状态
          * 则隐藏某些转换
          */</comment>
        <static>false</static>
        <access>public </access>
        <code><![CDATA[public function HideTransitionsIfNotAgent(Combodo\iTop\Service\Events\EventData $oEventData)....
```

## PHP 代码

```php
public function HideTransitionsIfNotAgent(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $iAgent = $this->Get('agent_id');
    if ($iAgent > 0) {
        $oAgent = MetaModel::GetObject('Person', $iAgent, true, true);
        $iManager = $oAgent->get('manager_id');
        $iCurrentPerson = UserRights::GetContactId();
 
        if ((!in_array($iCurrentPerson, [$iAgent, $iManager]) && !UserRights::IsAdministrator())
        && (in_array($this->Get('status'), ['assigned', 'pending']))) {
            $this->DenyTransition('ev_pending');
            $this->DenyTransition('ev_resolve');
        }
    }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-transition>

版本：3_2_0/customization/hide-transition.txt · Last modified: 2025/11/18 18:05 by 127.0.0.1
