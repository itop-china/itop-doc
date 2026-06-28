---
title: "添加附件时记录日志"
linkTitle: "添加附件时记录日志"
date: 2025-06-27
weight: 60
description: >
    使用事件机制在添加或删除附件时自动向工单的案例日志中添加记录。
---

{{% pageinfo %}}
本文档介绍如何在添加或删除附件时自动向工单日志添加记录。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:log-attachment)。
{{% /pageinfo %}}

## 目标

需求：每次有人向工单添加附件时，在 UserRequest 工单的日志中添加一条记录。

利用事件机制，可以订阅特定事件并在事件触发时执行方法。

- 在 UserRequest 类上创建一个方法来添加日志条目
- 订阅两个不同的事件并指定回调方法

## 添加日志条目

```php
public function AddLogEntryOnAttachment(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 获取日志，返回的对象是 ormCaselog，即一个对象
    $oLog = $this->Get('public_log');
    // 从事件中获取 Attachment 对象
    $oAttachment = $oEventData->Get('attachment');
    // 从 Attachment 获取 ormDocument
    $oDocument = $oAttachment->Get('contents');  
 
    // 测试哪个"事件"触发了回调
    if ($oEventData->GetEvent() == EVENT_ADD_ATTACHMENT_TO_OBJECT)
        // 添加一条日志条目，包含附件文件名
        $oLog->AddLogEntry('Add an attachment: '.$oDocument->GetFileName());
    else
        $oLog->AddLogEntry('Removed attachment: '.$oDocument->GetFileName());
    // 将修改后的日志设置回当前 UserRequest
    $this->Set('public_log', $oLog);
    $this->DBUpdate();
}
```

## 订阅事件

这里我们订阅了 2 个不同的事件，但使用相同的回调方法来处理：

```xml
<class id="UserRequest" _delta="must_exist">
  <event_listeners>
    <event_listener id="AddLogEntryOnAttachment" _delta="define">
      <event>EVENT_ADD_ATTACHMENT_TO_OBJECT</event>
      <callback>AddLogEntryOnAttachment</callback>
      <rank>0</rank>
    </event_listener>
    <event_listener id="AddLogEntryOnAttachmentRemoval" _delta="define">
      <event>EVENT_REMOVE_ATTACHMENT_FROM_OBJECT</event>
      <callback>AddLogEntryOnAttachment</callback>
      <rank>0</rank>
    </event_listener>
  </event_listeners>
</class>
```

## 完整增量

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.1">
  <classes>
    <class id="UserRequest">
      <event_listeners>
        <event_listener id="AddLogEntryOnAttachment" _delta="define">
          <event>EVENT_ADD_ATTACHMENT_TO_OBJECT</event>
          <callback>AddLogEntryOnAttachment</callback>
          <rank>0</rank>
        </event_listener>
        <event_listener id="AddLogEntryOnAttachmentRemoval" _delta="define">
          <event>EVENT_REMOVE_ATTACHMENT_FROM_OBJECT</event>
          <callback>AddLogEntryOnAttachment</callback>
          <rank>0</rank>
        </event_listener>
      </event_listeners>
      <methods>
        <method id="AddLogEntryOnAttachment" _delta="define">
          <static>false</static>
          <access>public</access>
          <type>EventListener</type>
          <code><![CDATA[    public function AddLogEntryOnAttachment(Combodo\iTop\Service\Events\EventData $oEventData) { blablabla... }  ]]>
          </code>
        </method>
      </methods>
    </class>
  </classes>
</itop_design>
```

## iTop 3.1.0+ 但低于 3.1.2 的替代方案

在 iTop 3.1.0+ 但低于 3.1.2 的版本中，可以响应 Attachment 类的事件：

- `EVENT_DB_AFTER_WRITE`
- `EVENT_DB_AFTER_DELETE`

然后检索与附件关联的对象类、对象键，如果是 UserRequest 则添加日志条目。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:log-attachment>

版本：3_2_0/customization/log-attachment.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
