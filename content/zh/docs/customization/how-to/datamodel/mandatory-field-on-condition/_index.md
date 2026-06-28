---
title: "按条件强制字段必填"
linkTitle: "按条件强制字段必填"
date: 2025-06-27
weight: 70
description: >
    使用事件机制在特定条件下强制字段必填，支持表单提交前检查和提交时检查两种方式。
---

{{% pageinfo %}}
本文档介绍如何在特定条件下强制字段必填。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-on-condition)。
{{% /pageinfo %}}

## 目标

此用例是强制提供字段的一种方式。

## 提交前检查

### 仅生产环境中的服务器

在此用例中，我们希望确保：

- 创建时，不提议位置
- 修改生产环境中的服务器时，位置变为必填

```xml
<class id="PhysicalDevice">
  <fields>
    <field id="location_id">
      <!-- 如果状态更改，强制重新计算 location_id 标志 -->
      <dependencies _delta="redefine">
        <attribute id="org_id"/>
        <attribute id="status"/>
      </dependencies>
    </field>
  </fields>
</class>
<class id="Server" _delta="must_exist">
  <event_listeners>
    <event_listener id="evtSetInitialFlags" _delta="define">
      <!-- 事件 ID 不需要与函数名相同，但也可以相同 -->
      <event>EVENT_DB_SET_INITIAL_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <!-- 回调必须是现有类方法的名称。名称自由 -->
      <callback>evtSetInitialFlags</callback>
    </event_listener>
    <event_listener id="evtSetAttributeFlags" _delta="define">
      <event>EVENT_DB_SET_ATTRIBUTES_FLAGS</event>
      <rank>10</rank>
      <callback>evtSetAttributeFlags</callback>
    </event_listener>
  </event_listeners>
  <methods>
    <method id="evtSetInitialFlags" _delta="define">
      <static>false</static>
      <access>public </access>
      <comment>此方法在打开服务器创建表单之前调用一次</comment>
      <code><![CDATA[
```

```php
public function evtSetInitialAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{   // 强制标志，忽略现有标志    
    $this->ForceInitialAttributeFlags('location_id', OPT_ATT_HIDDEN); 
    // $this->AddInitialAttributeFlags('location_id', OPT_ATT_HIDDEN); 如果其他代码也强制将其设为必填，可能不起作用
}
```

```php
public function evtSetAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{              
   if ((MetaModel::IsValidAttCode(get_class($this), 'status')) && ($this->Get('status') == 'production'))
   {  // 添加必填标志
      $this->AddAttributeFlags('location_id', OPT_ATT_MANDATORY);
      // 可以决定设置此标志并忽略已为该属性设置的其他标志
      // 在这种情况下，使用 ForceAttributeFlags 代替 AddAttributeFlags
      $this->ForceAttributeFlags('location_id', OPT_ATT_MANDATORY);
   }
}
```

### 仅生产环境中的服务器和网络设备

将上述事件和方法分别在 Server 和 NetworkDevice 类上声明两次。

### 仅生产环境中的数据中心设备

将上述事件和方法在 DatacenterDevice 类上声明，而不是 Server 类。

## 提交时检查

我们也可以在提交时检查是否提供了位置，如果没有，则阻止创建/修改并显示错误消息，以便用户填写位置后再次提交。

订阅 `EVENT_DB_CHECK_TO_WRITE` 事件，并定义对象类的回调方法 `evtCheckToWrite()`：

- 此事件在写入数据库之前生成
- 如果遇到数据不一致，回调方法应提供错误消息。错误消息使用 `$this->AddCheckIssue('Some Error Message')` 生成，警告消息使用 `$this->AddCheckWarning('Some Warning Message')`
- 从此方法返回时，如果至少有一个错误，对象不会写入数据库（创建或更新）
- 错误和警告消息仅在交互模式下显示给用户：控制台、门户、CSV 导入
- 对于数据同步、REST/JSON、CLI，根据跟踪级别记录在 `itop/log/error.log` 中

**迁移注意：** 在设置上没有可见效果，但不符合规范的对象不能再被修改，直到它们变得合规。因此可能会阻止数据同步或 REST/JSON 脚本更新其他字段。要识别有问题的对象，请创建一个审计规则来检索不符合此新约束的对象，并在 UI 中或通过 CSV 导入逐一修复。

在 iTop 3.1.0 之前，可以使用扩展性 API，将相同代码放入 `iApplicationObjectExtension::OnCheckToWrite()` 中。

在此用例中，我们希望阻止服务器在未提供位置的情况下被设置为 "production" 状态。

```xml
<class id="Server" _delta="must_exist">
  <event_listeners>
    <event_listener id="evtCheckToWrite" _delta="define">
      <event>EVENT_DB_CHECK_TO_WRITE</event>
      <rank>10</rank>
      <callback>evtCheckToWrite</callback>
    </event_listener>
  </event_listeners>
```

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
   // 防御性编程，确保 'status' 是当前类上的现有字段
   // 然后检查条件：枚举值返回代码而非标签，因此我们测试代码
   if (MetaModel::IsValidAttCode(get_class($this), 'status')
   && ($this->Get('status') == 'production'))
   {
      // AttributeExternalKey 永远不会为 NULL，0 是空值时使用的值
      if (MetaModel::IsValidAttCode(get_class($this), 'location_id')
      && ($this->Get('location_id') == 0))
      {
         // 'Server:Error:LocationMandatoryInProduction' 必须声明为字典条目
         $this->AddCheckIssue(Dict::Format('Server:Error:LocationMandatoryInProduction'));
      }
   }
}
```

也可以直接提供简单的纯文本错误消息：

```php
$this->AddCheckIssue('Location is mandatory for all Servers in production');
```

在 XML 中定义字典条目的方式：

```xml
<entry id="Server:Error:LocationMandatoryInProduction" _delta="define">
  <![CDATA['Location is mandatory for all Servers in production']]>
</entry>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-on-condition>

版本：3_2_0/customization/mandatory-field-on-condition.txt · Last modified: 2025/05/21 10:58 by 127.0.0.1
