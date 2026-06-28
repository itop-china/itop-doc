---
title: "数据完整性检查"
linkTitle: "数据完整性检查"
date: 2025-06-27
weight: 10
description: >
  使用 EVENT_DB_CHECK_TO_WRITE 事件检查数据完整性。
---

{{% pageinfo %}}
本文档介绍如何使用事件机制在对象保存前检查数据完整性，阻止不合规数据写入数据库。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:check-to-write)。
{{% /pageinfo %}}

## 概述

通过订阅 `EVENT_DB_CHECK_TO_WRITE` 事件，可以在对象写入数据库前进行数据完整性检查。该方法适用于：

- 控制台和门户中的交互式操作（提交后报告错误）
- 阻止 DataSynchro、REST/JSON 和 CSV 导入创建或更新不合规对象

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 理论基础

订阅 `EVENT_DB_CHECK_TO_WRITE` 事件，并定义对象类的回调方法 `evtCheckToWrite()`：

- 该事件在写入数据库前触发
- 回调方法在遇到数据不一致时应提供错误消息
- 错误使用 `$this->AddCheckIssue('错误消息')` 记录
- 警告使用 `$this->AddCheckWarning('警告消息')` 记录
- 如果返回时存在至少一个错误，对象不会被写入数据库

### 消息显示方式

- **交互模式**（控制台、门户、CSV 导入）：向用户显示错误和警告
- **非交互模式**（DataSynchro、REST/JSON、CLI）：根据跟踪级别记录到 `itop/log/error.log`

### 迁移注意事项

升级后，不合规的现有对象无法再被修改，直到修复为合规状态。建议创建审计规则来识别不合规对象并逐一修复。

在 iTop 3.1.0 之前，可以使用 `Extensibility API` 将相同代码放入 `iApplicationObjectExtension::OnCheckToWrite()` 中。

## 示例

### 示例一：结束日期必须晚于开始日期

防止 Change 对象的结束日期早于开始日期：

**XML 事件订阅：**

```xml
<class id="Change" _delta="must_exist">
  <event_listeners>
    <event_listener id="evtCheckToWrite" _delta="define">
      <!-- 事件 ID 不需要与函数名相同，但保持一致更方便 -->
      <event>EVENT_DB_CHECK_TO_WRITE</event>
      <rank>10</rank>
      <!-- 回调必须是现有类方法的名称，名称可自定义 -->
      <callback>evtCheckToWrite</callback>
    </event_listener>
  </event_listeners>
</class>
```

**PHP 回调方法：**

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 防御性编程：确保 'end_date' 和 'start_date' 未被其他扩展移除
    // 比较前先转换为秒更安全
    if (MetaModel::IsValidAttCode(get_class($this), 'start_date') 
     && MetaModel::IsValidAttCode(get_class($this), 'end_date')
     && (AttributeDateTime::GetAsUnixSeconds($this->Get('start_date')) 
       > AttributeDateTime::GetAsUnixSeconds($this->Get('end_date'))))
    {
       $this->AddCheckIssue(Dict::Format('Class:Error:EndDateMustBeGreaterThanStartDate'));
    }
}
```

### 示例二：生产状态服务器必须填写位置

防止生产状态的服务器未提供位置信息：

**XML 事件订阅：**

```xml
<class id="Server" _delta="must_exist">
  <event_listeners>
    <event_listener id="evtCheckToWrite" _delta="define">
      <event>EVENT_DB_CHECK_TO_WRITE</event>
      <rank>10</rank>
      <callback>evtCheckToWrite</callback>
    </event_listener>
  </event_listeners>
</class>
```

**PHP 回调方法：**

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 防御性编程：确保 'status' 是当前类上的有效字段
    // 枚举值返回的是 code 而非 label，因此测试 code
    if (MetaModel::IsValidAttCode(get_class($this), 'status')
    && ($this->Get('status') == 'production'))
    {
        // AttributeExternalKey 永远不会为 NULL，空值用 0 表示
        if (MetaModel::IsValidAttCode(get_class($this), 'location_id')
        && ($this->Get('location_id') == 0))
        {
            // 'Server:Error:LocationMandatoryInProduction' 必须在字典中声明
            $this->AddCheckIssue(Dict::Format('Server:Error:LocationMandatoryInProduction'));
        }
    }
}
```

也可以使用纯文本错误消息：

```php
$this->AddCheckIssue('Location is mandatory for all Servers in production');
```

**字典条目定义：**

```xml
<entry id="Server:Error:LocationMandatoryInProduction" _delta="define">
  <![CDATA['Location is mandatory for all Servers in production']]>
</entry>
```

### 示例三：FunctionalCI 名称唯一性

防止两个 FunctionalCI 具有相同名称（SoftwareInstance、MiddlewareInstance、DatabaseSchema 和 ApplicationSolution 除外）：

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 检查 FunctionalCI 名称是否必须唯一
    $aChanges = $this->ListChanges();
    // 检查 name 字段是否被设置或修改
    if (array_key_exists('name', $aChanges))
    {
      $sNewName = $aChanges['name'];
      // 检索所有具有该新名称的 FunctionalCI，忽略某些子类
      $oSearch = DBObjectSearch::FromOQL_AllData("
         SELECT FunctionalCI WHERE name = :newFCI 
         AND finalclass NOT IN ('DBServer','Middleware','OtherSoftware','WebServer',
            'PCSoftware','MiddlewareInstance','DatabaseSchema','ApplicationSolution')
      ");
      $oSet = new DBObjectSet($oSearch, array(), array('newFCI' => $sNewName));
      // 如果至少有一个 FunctionalCI 匹配
      if ($oSet->Count() > 0)
      {
         // 阻止写入数据库
         $this->AddCheckIssue(Dict::Format('Class:FunctionalCI:FCINameMustBeUnique', $oSet->Count(), $sNewName));
      }
   }
}
```

**带占位符的字典条目：**

```xml
<entry id="Class:FunctionalCI:FCINameMustBeUnique" _delta="define">
  <![CDATA['Functional CI name are expected to be unique, there are already %1$s using the name %2$s']]>
</entry>
```

### 示例四：变更必须关联 CI

确保每个变更至少关联一个 CI：

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 检查当前变更是否应有关联的 CI
    if (is_subclass_of($this,'Change'))
    {
        $oSet = $this->Get('functionalcis_list');
        if ($oSet->Count() == 0)
        {
             $this->AddCheckIssue(Dict::S('Class:Change/Error:AtLeastOneCiIsNeeded'));
        }
    }
}
```

从 iTop 3.2.0 开始，可以通过在 XML 中标记字段 `with_php_constrains` 来确保当 LinkedSet 或 LinkedSetIndirect 被修改时触发 CheckToWrite：

```xml
<class id="Ticket">
  <fields>
    <field id="functionalcis_list">
      <with_php_constrains _delta="define">true</with_php_constrains>
    </field>
  </fields>
</class>
```

### 示例五：用户必须至少有一个角色

确保用户至少关联一个角色：

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 检查 profile_list 是否被修改，避免不必要的加载
    $aChanges = $this->ListChanges();
    if (array_key_exists('profile_list', $aChanges))
    {
        $oSet = $this->Get('profile_list');
        if ($oSet->Count() == 0)
        {
             $this->AddCheckIssue(Dict::S('Class:User/Error:AtLeastOneProfileIsNeeded'));
        }
    }
}
```

### 示例六：阻止创建权限

允许某些用户修改 FunctionalCI，但仅允许具有 "Configuration Manager" 角色的用户创建新的 FunctionalCI：

```php
public function evtCheckToWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    if ($this->IsNew() // 是否尝试创建新对象
    && !(UserRights::HasProfile('Configuration Manager')) // 用户没有 "Configuration Manager" 角色
    {
        $this->AddCheckIssue(Dict::S('Class:FunctionalCI/Error:CreationDenied'));
    }
}
```

此示例中的字典条目不存在，需要自行创建。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:check-to-write)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:check-to-write>

2026/02/09 12:02 by127.0.0.1

版本：3_2_0/customization/check-to-write.txt · Last modified: 2026/02/09 12:02 by 127.0.0.1
