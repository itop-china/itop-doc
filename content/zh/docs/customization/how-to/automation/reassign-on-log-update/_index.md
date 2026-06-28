---
title: "日志更新时重新分配工单"
linkTitle: "日志更新时重新分配工单"
date: 2025-06-27
weight: 120
description: >
    当客户在门户中更新工单日志时，自动将工单重新分配给处理人。
---

{{% pageinfo %}}
本文档介绍如何在客户更新工单日志时自动重新分配工单。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:reassign-on-log-update)。
{{% /pageinfo %}}

## 目标

在本教程中，我们将了解当客户在门户工单案例日志中输入新条目时，如何强制自动将用户请求重新分配给处理人的不同解决方案。

通常，当客户在用户门户中提供信息或询问有关正在进行的工单的问题时，我们希望工单处理人能够知晓并响应工单，最简单的方式就是重新分配工单。使用 "Mail To Ticket Automation" 扩展可以相对容易地配置此功能，但在门户中则不然。

有多种方式可以实现。这里提供 2 种方法：

- 强制门户用户通过转换更新日志，该转换将重新分配工单
- 检查日志是否在门户中更新，并触发后台转换

## 通过转换更新

1. 在 pending 状态下拒绝案例日志编辑

   使用事件和 PHP 回调方法，在以下情况下使案例日志只读：
   - 在门户中
   - 处于 `pending` 状态
   - 不在转换中

   ```php
   /**
    * EVENT_DB_SET_ATTRIBUTES_FLAGS 的事件监听器
    */
   public function EvtSetAttributesFlags(Combodo\iTop\Service\Events\EventData $oEventData)
   {
       // $oEventData->Get('target_state') 如果不在转换中返回 null，否则提供转换的目标状态
       if (ContextTag::Check('GUI:Portal') && ($this->Get('status') === 'pending') && ($oEventData->Get('target_state') == null)) {
           $this->AddAttributeFlags('public_log', OPT_ATT_READONLY);
       }
   }
   ```

2. 更改从 pending 到 assigned 的转换所使用的激励，将 `ev_assign` 替换为 `ev_reopen`，这是允许门户用户使用的激励。

3. 在转换中强制编辑案例日志（必须提示）

## 后台强制转换

使用 `EVENT_DB_AFTER_WRITE` 事件和回调方法，如果条件匹配，则应用适当的激励以重新分配工单。

```php
public function EvtAfterWriteUserRequest(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 不在创建中，也不在转换中
    if (!$oEventData->Get('is_new') && $oEventData->Get('stimulus_applied') === null) {
        $sStatus = $this->Get('status');
        if (ContextTag::Check('GUI:Portal') && in_array($sStatus, ['pending', 'resolved']))  {
            // 此操作期间所做的更改列表
            $aChanges = $oEventData->Get('changes') ?? [];
            if (array_key_exists('public_log', $aChanges))
            {
                $sStimulus = ($sStatus === 'resolved') ? 'ev_reopen' : 'ev_assign';
                $this->ApplyStimulus($sStimulus);
            }
        }
    } 
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:reassign-on-log-update>

版本：3_2_0/customization/reassign-on-log-update.txt · Last modified: 2025/08/12 14:41 by 127.0.0.1
