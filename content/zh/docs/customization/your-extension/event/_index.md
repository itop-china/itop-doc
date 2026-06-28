---
title: "方法与事件"
linkTitle: "方法与事件"
date: 2025-06-27
weight: 10
description: >
  方法与事件。
---

{{% pageinfo %}}
本文档对比 DBObject 方法、iApplicationObjectExtension 接口和 Events API（iTop 3.1+）三种扩展方式，帮助您了解如何从旧机制迁移到基于事件的扩展机制。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:event)。
{{% /pageinfo %}}

## 概述

iTop 提供了多种方式来扩展对象的行为。从 iTop 3.1 开始，推荐使用**事件（Events）**机制替代传统的 DBObject 方法重载和 `iApplicationObjectExtension` 接口。

## 方法 vs 事件对比

| DBObject 方法 | iApplicationObjectExtension | 事件（iTop 3.1+） |
|---------------|----------------------------|-------------------|
| ComputeValues | n/a | EVENT_DB_COMPUTE_VALUES |
| DoCheckToWrite | OnCheckToWrite | EVENT_DB_CHECK_TO_WRITE |
| DoCheckToDelete | OnCheckToDelete | EVENT_DB_CHECK_TO_DELETE |
| GetAttributeFlags | n/a | EVENT_DB_SET_ATTRIBUTES_FLAGS |
| GetInitialStateAttributeFlags | n/a | EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS |
| n/a | n/a | EVENT_DB_LINKS_CHANGED |
| n/a | n/a | EVENT_ADD_ATTACHMENT_TO_OBJECT |
| n/a | n/a | EVENT_REMOVE_ATTACHMENT_FROM_OBJECT |
| EnumTransitions | n/a | EVENT_ENUM_TRANSITION |
| OnInsert | n/a | EVENT_DB_BEFORE_WRITE |
| AfterInsert | OnDBInsert | EVENT_DB_AFTER_WRITE |
| OnUpdate | n/a | EVENT_DB_BEFORE_WRITE |
| AfterUpdate | OnDBUpdate | EVENT_DB_AFTER_WRITE |
| OnDelete | OnDBDelete | EVENT_DB_ABOUT_TO_DELETE |
| AfterDelete | n/a | EVENT_DB_AFTER_DELETE |

## 不可替换的方法

以下方法无法通过事件替换：

| DBObject 方法 | iApplicationObjectExtension | 事件 |
|---------------|----------------------------|------|
| PrefillSearchForm | n/a | n/a |
| PrefillCreationForm | n/a | n/a |
| PrefillTransitionForm | n/a | n/a |
| DisplayBareRelations | n/a | n/a |

## 从 DBObject 方法重载迁移到监听器

在类中注册事件监听器，以在回调方法中执行代码：

```xml
  <classes>
     <class id="UserRequest">
      <event_listeners>
        <event_listener id="HideTransitionsIfApprovalRule" _delta="define">
          <event>EVENT_ENUM_TRANSITIONS</event>
          <rank>10</rank>
          <callback>HideTransitionsIfApprovalRule</callback>
        </event_listener>
      </event_listeners>
      <methods>
        <method id="HideTransitionsIfApprovalRule" _delta="define">
          <comment>/**
            * If an approval rule could apply to the current object, hide all transitions
            * As the service and service subcategory are not yet set, we can't determine if the approval rule will really apply
            * So we hide all transitions if the object is new and in a state where an approval rule could apply
            */</comment>
          <static>false</static>
          <access>public </access>
          <code><![CDATA[public function HideTransitionsIfApprovalRule(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // PHP code here...
}]]></code>
        </method>
      </methods>
```

- 回调方法接收一个事件参数，您可以在签名中允许它为 null，以便重用该方法。

## 从 iApplicationObjectExtension 迁移到监听器

### 纯 PHP 方式

首先考虑纯 PHP 方式处理事件。复制粘贴以下模板并根据需要调整：

```php
/**
 * 模板：帮助从 iApplicationObjectExtension 钩子迁移到基于事件的监听器。
 * 作为起点使用：
 * - 必须指定要监听的类列表（或省略参数以监听所有类）
 * - 必须将旧钩子的代码复制/粘贴到适当的方法中
 * - 必须删除不必要的监听器
 * - 建议的事件与旧钩子最接近，但可能不是最合适的
 * - 整个内容可以在 XML 中定义，而不是 PHP，允许在集成时进行更精细的控制（优先级等）
 */
class MyCustomHooks implements iEventServiceSetup
{
        public function RegisterEventsAndListeners() : void
        {
                // TODO: 删除不必要的监听器
                EventService::RegisterListener(EVENT_DB_CHECK_TO_WRITE, [$this, 'OnDBCheckToWrite'], ['Class1', 'Class2']);
                EventService::RegisterListener(EVENT_DB_CHECK_TO_DELETE, [$this, 'OnDBCheckToDelete'], ['Class1', 'Class2']);
                EventService::RegisterListener(EVENT_DB_AFTER_WRITE, [$this, 'OnDBAfterWrite'], ['Class1', 'Class2']);
                EventService::RegisterListener(EVENT_DB_ABOUT_TO_DELETE, [$this, 'OnDBAboutToDelete'], ['Class1', 'Class2']);
        }
 
        public function OnDBCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
        {
                $oObject = $oEventData->Get('object');
                // TODO: 将之前在 OnCheckToWrite 中实现的代码放在这里，使用 AddCheckIssue 报告问题，而不是将它们作为数组返回
        }
        public function OnDBCheckToDelete(Combodo\iTop\Service\Events\EventData $oEventData)
        {
                $oObject = $oEventData->Get('object');
                // TODO: 将之前在 OnCheckToDelete 中实现的代码放在这里，使用 AddDeleteIssue 报告问题
        }
        public function OnDBAfterWrite(Combodo\iTop\Service\Events\EventData $oEventData)
        {
                $oObject = $oEventData->Get('object');
                if ($oEventData->Get('is_new')) {
                        // TODO: 将之前在 OnDBInsert 中实现的代码放在这里
                }
                else {
                        // TODO: 将之前在 OnDBUpdate 中实现的代码放在这里
                }
        }
        public function OnDBAboutToDelete(Combodo\iTop\Service\Events\EventData $oEventData)
        {
                $oObject = $oEventData->Get('object');
                // TODO: 将之前在 OnDBDelete 中实现的代码放在这里
        }
}
```

### XML 方式

在类内部或外部注册事件监听器以执行代码：

示例（来自 `combodo-autodispatch-ticket`，监听器适用于任何类）：

```xml
    <event_listeners>
        <event_listener id="HideTransitionsIfAutoDispatchRule" _delta="define">
            <event>EVENT_DB_AFTER_WRITE</event>
            <filters/>
            <rank>0</rank>
            <code><![CDATA[function(Combodo\iTop\Service\Events\EventData $oEventData)
{
      $oObject = $oEventData->Get('object');
      if ($oEventData->Get('is_new')) {
              // TODO: 将之前在 OnDBInsert 中实现的代码放在这里
      }
      else {
              // TODO: 将之前在 OnDBUpdate 中实现的代码放在这里
      }
}
            ]]></code>
        </event_listener>
    </event_listeners>
```

## 事件详解

### EVENT_DB_COMPUTE_VALUES

注册此事件以在对象修改时计算字段值（基于同一对象其他字段的值）。

```php
public function EvtComputeValues(Combodo\iTop\Service\Events\EventData $oEventData)
{         
        $this->Set('vat', 0.2*$this->Get('cost'));             
}
```

- 您可以通过 `$oEventData->Get('stimulus_applied')` 判断是否处于特定转换中（null 表示不在转换中）。

在旧版本 iTop 和某些类中，您可能会遇到 `ComputeValues()` 方法，该方法已弃用，但执行相同的工作。

### EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS

有两个不同的事件：一个在显示对象的**创建**表单之前，另一个在显示对象的**修改**表单时。

```php
public function EvtSetInitialAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{
   $this->AddInitialAttributeFlags($sAttCode, $iFlags);  // 为字段添加标志
   $this->ForceInitialAttributeFlags($sAttCode, $iFlags); // 强制字段标志
}
/* 标志常量值，使用位运算符 | 组合：
 * OPT_ATT_NORMAL
 * OPT_ATT_HIDDEN
 * OPT_ATT_READONLY
 * OPT_ATT_MANDATORY
 * OPT_ATT_MUSTCHANGE
 * OPT_ATT_MUSTPROMPT
 */
```

### EVENT_DB_SET_ATTRIBUTES_FLAGS

```php
public function EvtSetAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{
   $this->AddAttributeFlags($sAttCode, $iFlags); // 为字段添加标志
   $this->ForceAttributeFlags($sAttCode, $iFlags); // 强制字段标志
}
```

`GetAttributeFlags` 和 `GetInitialStateAttributeFlags` 方法已弃用，不应再使用。

### EVENT_DB_CHECK_TO_WRITE

此事件在对象写入数据库之前触发。

- 允许在特定条件不满足时阻止记录当前对象
- 也可以简单地警告用户非阻塞性问题
- 在回调方法中添加 `AddCheckIssue` 消息将停止对象的创建/修改/转换，并显示错误消息

```php
// 阻塞性问题
$this->AddCheckIssue('Some error message');
// 非阻塞性警告
$this->AddCheckWarning('Some warning message');
```

- 您可以通过 `$oEventData->Get('stimulus_applied')` 判断是否处于特定转换中（空字符串表示不在转换中）

此时修改对象本身已为时过晚。

### EVENT_DB_BEFORE_WRITE

如果您想自动修改当前对象，通常正确的答案是 `EVENT_DB_COMPUTE_VALUES`。

- 如果此更改仅在对象创建时发生，请使用 `EVENT_DB_BEFORE_WRITE` 并通过 `$oEventData->Get('is_new')==$this->IsNew()` 测试是否处于创建状态
- 如果此更新资源密集且仅在某些字段被设置/修改时才应执行，则在 `EVENT_DB_BEFORE_WRITE` 中检查正在进行的更改：`$this->ListChanges()`

### EVENT_DB_AFTER_WRITE

如果您想在某个对象被修改时自动修改其他对象，请使用 `EVENT_DB_AFTER_WRITE`。

- 在当前对象保存到数据库后触发一次
- 使用 `$oEventData->Get('is_new')===true` 测试对象是否刚刚创建
- 使用 `$oEventData->Get('stimulus_applied')` 测试是否处于特定转换中
- 检查已执行的更改：

```php
$aChanges = $oEventData->Get('changes');
$aChanges = $this->ListPreviousValuesForUpdatedAttributes();
```

### EVENT_DISPLAY_OBJECT_DETAILS

此事件在对象显示在用户门户之前触发。

- 它不是设计用来作用于显示内容的，但允许您统计 FAQ 在用户门户中显示的次数，并可能将此计数存储在 FAQ 对象本身中。

### EVENT_DB_LINKS_CHANGED

此事件在对象上触发，在其 LinkedSet（标记为"PHP 计算"）被修改之后。

- 如果宿主对象本身被修改，**不会**触发
- 如果 PHP 代码更新对象的 LinkedSet，**不会**触发
- 如果 LinkedSetIndirect 的远程对象被修改（例如 Team.persons_list 中 Person 的状态变更），**不会**触发
- 如果 LinkedSet 中的子对象被单独添加、移除或修改，则会触发

在此回调执行期间，您不知道：
- 什么发生了变化，甚至不知道哪个 LinkedSet
- 当前对象是否刚刚创建或修改

适用场景：确保一旦链接被创建、修改或删除，您的代码就会执行。可用于存储关系计数或总和、重新排序、查找具有特定值的关系并将其作为 ExternalKey 存储在对象中。

### EVENT_ENUM_TRANSITIONS

此事件在对象显示之前触发。

- 允许在某些条件下移除对象的转换
- 例如，阻止非当前代理的用户将工单重新分配给其他团队
- 如果移除不可用的转换，则无效果

```php
$this->DenyTransition($sStimulusCode)
```

### EVENT_ADD_ATTACHMENT_TO_OBJECT

此事件在附件添加到对象之后触发。

- 允许在案例日志中添加条目或测试附件的约束条件，并在某些条件下自动删除（例如有风险的文件类型）

```php
$oEventData->Get('attachment')
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:event>

Last modified: 2025/10/31 12:23 by127.0.0.1

版本：3_2_0/customization/event.txt · Last modified: 2025/10/31 12:23 by 127.0.0.1
