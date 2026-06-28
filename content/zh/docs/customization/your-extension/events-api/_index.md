---
title: "Events API"
linkTitle: "Events API"
date: 2025-06-27
weight: 10
description: >
  Events API。
---

{{% pageinfo %}}
本文档介绍 iTop 3.1 引入的 Events API，这是一种通过事件机制扩展 iTop 功能的全新方式。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:events_api)。
{{% /pageinfo %}}

## 概述

Events 服务是 iTop 3.1 中的新功能，属于[扩展性 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces) 的一部分。

该服务通过事件提供扩展性。主要行为是**事件提供者**注册他们要触发的事件，**事件监听器**注册当事件触发时要调用的回调函数。

## 示例

- [存储 n:n 关系计数](https://www.itophub.io/wiki/page?id=3_2_0:customization:count-linkset-indirect)
- [添加附件时添加日志条目](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-log-entry)

## 事件发布者

### 注册

提供者必须在 PHP 中触发事件之前，先在 XML 中注册事件。注册需要：

- **event**：大致上是一个唯一的名称
- **event_data**：与事件一起提供的参数
- **sources**：监听器可用的过滤条件，可选且特定于事件

#### 事件 ID

事件 ID 应遵循常量命名规范（即全大写，仅使用下划线字符），并建议事件名称包含 'EVENT'。

- 当然，它在 iTop 和所有扩展中必须是唯一的
- 在以下示例中，我们将事件命名为 `EVENT_DOWNLOAD_DOCUMENT`
- 将自动创建一个与名称相同的字符串常量

```php
const EVENT_DOWNLOAD_DOCUMENT = 'EVENT_DOWNLOAD_DOCUMENT'; 
```

#### 事件数据

事件数据由事件提供者在事件触发时提供给所有监听器。它是与事件一起提供的信息，以便监听器可以在有足够信息的情况下采取行动。

- 数据特定于提供者，由扁平的值列表组成
- 值可以是任何 PHP 值，如对象或数组，必须在声明中指定
- 事件数据及其类型在提供者事件注册中声明
- 它们特定于每个事件

在以下示例中，声明了 5 个 event_datum：

- `object`：DBObject
- `document`：ormDocument
- `att_code` 和 `content_disposition`：字符串
- `debug_info`：字符串，在 Combodo 创建的事件中始终存在

#### 事件源

事件源是一种根据事件来源过滤事件的方式。

例如，对于数据模型对象上的事件，对象的类是监听器可以使用的源。实际上，所有父类都被添加到事件源中，因此监听器可以在类树的任何级别过滤事件。监听器可以指定监听 "Ticket" 事件。在继承自 Ticket 的对象上触发的所有事件都将发送给此监听器。

#### XML 结果

```xml
  <events>
    <event id="EVENT_DOWNLOAD_DOCUMENT" _delta="define">
      <description>A document has been downloaded from the GUI</description>
      <sources>
        <source id="Document">Document</source>
      </sources>
      <event_data>
        <event_datum id="object">
          <description>The object containing the document</description>
          <type>DBObject</type>
        </event_datum>
        <event_datum id="document">
          <description>The document downloaded</description>
          <type>ormDocument</type>
        </event_datum>
        <event_datum id="att_code">
          <description>Attribute code of the object, containing the document</description>
          <type>string</type>
        </event_datum>
        <event_datum id="content_disposition">
          <description>To differentiate if the document was displayed in preview or truly downloaded</description>
          <type>string</type>
        </event_datum>
        <event_datum id="debug_info">
          <description>Debug string</description>
          <type>string</type>
        </event_datum>
      </event_data>
    </event>
  </events>
```

#### 所有 iTop 事件

- 所有 iTop 核心事件声明可以在 `<itop>/code/datamodel.application.xml` 中找到
- 当然，这不包括由 iTop 扩展带来的事件

### 事件触发

此部分用 PHP 编写。由事件提供者在适合触发事件时执行。必须提供：

- 与注册中声明的 `id` 和 `type` 一致的事件数据
- 适用的事件源

```php
public static function DownloadDocument(WebPage $oPage, $sClass, $id, $sAttCode, $sContentDisposition = 'attachment', $sSecretField = null, $sSecretValue = null)
{  
   // ...
   $aEventData = array(
      'debug_info' => $oDocument->GetFileName(),
      'object' => $oObj,
      'document' => $oDocument,
      'att_code' => $sAttCode,
      'content_disposition' => $sContentDisposition,
   );
   $aEventSources = [];
   foreach (MetaModel::EnumParentClasses(get_class($this), ENUM_PARENT_CLASSES_ALL, false) as $sClass) {
        $aEventSources[] = $sClass;
   }
 
   Combodo\iTop\Service\Events\EventService::FireEvent(
      new Combodo\iTop\Service\Events\EventData(EVENT_DOWNLOAD_DOCUMENT, $aEventSources , $aEventData)
   );
   // ...
}
```

## 事件监听器

监听器将指定，如果特定事件在其指定的过滤器匹配的源上触发，则执行特定的 PHP 代码。

- **event**：事件的字符串名称
- **callback**：匹配过滤条件的事件发生时执行的代码
- **filter**：一组字符串。如果事件的 `$aEventSources` 中有**任何一个**过滤字符串，则执行回调代码。对于许多触发器，这些字符串对应于类名。此参数可选。
- **rank**：如果您不是唯一响应该事件的扩展，可以指定一个 rank，以确保在另一个您知道其 rank 的扩展之前或之后执行

注册可以通过多种方式完成。

### 在类中的 XML 方式

您可以在 `UserRequest` 类中定义一个监听器，为此指定：

- `event_listener id`：给它任何您喜欢的名称，在类中必须唯一
- `event`：在 XML 标签 `event` 下，如 `EVENT_DB_AFTER_WRITE`
- `callback`：在 XML 标签 `callback` 下，提供此类中方法的名称
- `rank`：在 XML 标签 `rank` 下
- `filter`：在集合 `filters/filter` 下，但在类中声明时是隐式的

```xml
    <class id="UserRequest" _created_in="itop-request-mgmt" _delta="must_exist">
      <event_listeners>
        <event_listener id="OnUserRequestUpdateDone" _delta="define">
          <event>EVENT_DB_AFTER_WRITE</event>
          <callback>OnUserRequestUpdateDone</callback>
          <rank>0</rank>
        </event_listener>
      </event_listeners>
```

注册 `EVENT_DB_AFTER_WRITE` 事件：

- 类似于重写 `UserRequest::OnUpdate`，但没有被另一个定制覆盖的风险，因为事件的所有监听器按顺序调用执行各自的工作
- 类似于实现 `iObjectApplicationExtension OnDBUpdate()`，但对于许多事件，等效的接口方法不存在，而且使用接口无法控制执行顺序

### 在 XML 中使用直接代码

此处 XML 声明在任何类之外，在 `itop_design` XML 树的根级别。

注意：

- 需要 XML `filter` 标签来声明适用的类
- 如果 `event` 对 `filter` 中的类不适用，不会失败，不会显示警告，只是回调永远不会被调用
- 方法没有名称
- 您无法访问 `$this`，当前 `$oObject` 由事件提供（`$oEventData->Get('object')`）

```xml
  <event_listeners>
    <event_listener id="OnAttachmentDownloadActivateTriggers" _delta="define">
      <event>EVENT_DOWNLOAD_DOCUMENT</event>
      <filters>
        <filter>Attachment</filter>
      </filters>
      <rank>0</rank>
      <code><![CDATA[
      function(Combodo\iTop\Service\Events\EventData $oEventData)
      {
          if ($oEventData->Get('content_disposition') !== ormDocument::ENUM_CONTENT_DISPOSITION_ATTACHMENT) {
              return;
        }
          $oObject = $oEventData->Get('object');
        $sAttCode = $oEventData->Get('att_code');
        $oDocument = $oEventData->Get('document');
          ...
      }
]]></code>
    </event_listener>
  </event_listeners>
```

### 回调

如果您在 XML 中的类里注册了监听器，则在类上创建回调作为 PHP 方法。

```php
public function OnUserRequestUpdateDone(Combodo\iTop\Service\Events\EventData $oEventData)
{
      $sEvent = $oEventData->GetEvent();
      $aChange = $oEventData->Get('changes');
      // 执行您的处理
}
```

在回调代码中：

- 您可以通过 `$oEventData->Get('xx')` 获取事件发布者注册的事件数据（其中 'xx' 是 XML 标签中 'event_datum' 的 'id'）
- 在某些事件中，对象上可以使用标准方法，如 `DBObject::AddCheckIssue()`、`DBObject::ListChanges()` 等
- 当事件和回调方法在类本身上声明时，可以使用 `$this` 代替 `$oEventData->Get('object')`

### 示例：人员变更时

在标准 iTop 中，我们通过此事件机制[防止门户用户在人员组织变更时失去访问权限](https://www.itophub.io/wiki/page?id=3_2_0:customization:form_prefill)。

### PHP 中的监听器

如果您在 PHP 中进行注册和回调，最简单的方式是声明一个实现 `iEventServiceSetup` 的新类。在一个地方执行 `RegisterEventsAndListeners()` 中的注册，并指定回调代码。

监听器可以指定它们要监听的源。

```php
class AttributeBlobEventListener implements iEventServiceSetup
{
        public function RegisterEventsAndListeners()
        {
                EventService::RegisterListener(
                        EVENT_DOWNLOAD_DOCUMENT,
                        [$this, 'OnAttributeBlobDownloadActivateTrigger']
                );
        }
 
        public function OnAttributeBlobDownloadActivateTrigger(Combodo\iTop\Service\Events\EventData $oEventData): void
        {
              // 回调代码
              ...
        }
}
```

```php
class EventListener implements iEventServiceSetup
{
        public function RegisterEventsAndListeners()
        {
                EventService::RegisterListener(
                        EVENT_DOWNLOAD_DOCUMENT,
                        [$this, 'OnAttachmentDownloadActivateTriggers'],
                        'Attachment'
                );
        }
 
        public function OnAttachmentDownloadActivateTriggers(Combodo\iTop\Service\Events\EventData $oEventData): void
        {
              if ($oEventData->Get('content_disposition') !== ormDocument::ENUM_CONTENT_DISPOSITION_ATTACHMENT) {
                 return;
              }
              $oObject = $oEventData->Get('object');
              $sAttCode = $oEventData->Get('att_code');
              $oDocument = $oEventData->Get('document');
              ...
        }
}
```

## 现有事件

要获取更多关于 [CRUD 事件](https://www.itophub.io/wiki/page?id=3_2_0:extensibility:events_crud) 的详细信息：

- 它们的名称和用法
- 它们的数据
- 回调代码中可调用的 DBObject 方法

### 查找与数据模型类关联的事件

在数据模型页面中，可以查看为特定类注册的所有事件和监听器。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:events_api>

版本：3_2_0/customization/events_api.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
