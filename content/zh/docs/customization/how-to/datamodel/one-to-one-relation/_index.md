---
title: "添加 1:1 关系"
linkTitle: "添加 1:1 关系"
date: 2025-06-27
weight: 10
description: >
  添加 1:1 关系。
---

{{% pageinfo %}}
本文档介绍如何在两个类之间创建一对一关系。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:one-to-one-relation)。
{{% /pageinfo %}}

## 概述

iTop 没有专门的 1:1 关系字段类型，但可以通过以下方式实现：

- 此方案仅为可选方案之一
- 关系只能在一边编辑
- 关系必须从两边可见

## 两个类之间的 1:1 关系

以 Person 和 CompanyCar 为例：一个人只能有一辆公司车，一辆车只能分配给一个人。

### 声明两个外部键

```xml
<field id="companycar_id" xsi:type="AttributeExternalKey" _delta="define">
  <filter><![CDATA[SELECT CompanyCar AS cc WHERE cc.person_id = 0]]></filter>
  <dependencies/>
  <sql>companycar_id</sql>
  <target_class>CompanyCar</target_class>
  <is_null_allowed>true</is_null_allowed>
  <on_target_delete>DEL_MANUAL</on_target_delete>
  <allow_target_creation>true</allow_target_creation>
</field>
```

```xml
<field id="person_id" xsi:type="AttributeExternalKey" _delta="define">
  <filter/>
  <dependencies/>
  <sql>person_id</sql>
  <target_class>Person</target_class>
  <is_null_allowed>true</is_null_allowed>
  <on_target_delete>DEL_MANUAL</on_target_delete>
  <allow_target_creation>false</allow_target_creation>
</field>
```

### 强制键同步

使用事件监听器在写入后同步两个外部键：

```xml
<event_listeners>
  <event_listener id="AfterWriteOneToOneRelationKeys" _delta="define">
    <event>EVENT_DB_AFTER_WRITE</event>
    <filters>
      <filter>Person</filter>
      <filter>CompanyCar</filter>
    </filters>
    <rank>0</rank>
    <code><![CDATA[function(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $sCurrentClass = 'Person';
    $sKeyToCurrent = 'person_id';
    $sRemoteClass = 'CompanyCar';
    $sKeyToRemote = 'companycar_id';
    $oObject = $oEventData->Get('object');

    if (get_class($oObject) == $sCurrentClass) {
        $aChanges = $oObject->ListPreviousValuesForUpdatedAttributes();
        if (($oEventData->Get('is_new') || array_key_exists($sKeyToRemote, $aChanges)) 
            && ($oObject->Get($sKeyToRemote) > 0)) {
            $oNewRemote = MetaModel::GetObject($sRemoteClass, $oObject->Get($sKeyToRemote), false, true);
            if ($oNewRemote) {
                $oNewRemote->Set($sKeyToCurrent, $oObject->GetKey());
                $oNewRemote->DBUpdate();
            }
        }
        if (!$oEventData->Get('is_new') && array_key_exists($sKeyToRemote, $aChanges) 
            && ($aChanges[$sKeyToRemote] > 0)) {
            $oOldRemote = MetaModel::GetObject($sRemoteClass, $aChanges[$sKeyToRemote], false, true);
            if ($oOldRemote) {
                $oOldRemote->Set($sKeyToCurrent, 0);
                $oOldRemote->DBUpdate();
            }
        }
    }
}]]></code>
  </event_listener>
  <event_listener id="OnDeleteOneToOneRelationKeys" _delta="define">
    <event>EVENT_DB_BEFORE_DELETE</event>
    <filters>
      <filter>Person</filter>
      <filter>CompanyCar</filter>
    </filters>
    <rank>0</rank>
    <code><![CDATA[function(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $sCurrentClass = 'Person';
    $sKeyToCurrent = 'person_id';
    $sRemoteClass = 'CompanyCar';
    $sKeyToRemote = 'companycar_id';
    $oObject = $oEventData->Get('object');

    if ((get_class($oObject) == $sCurrentClass) && ($oObject->Get($sKeyToRemote) > 0)) {
        $oOldRemote = MetaModel::GetObject($sRemoteClass, $oObject->Get($sKeyToRemote), false, true);
        if ($oOldRemote) {
            $oOldRemote->Set($sKeyToCurrent, 0);
            $oOldRemote->DBUpdate();
        }
    }
}]]></code>
  </event_listener>
</event_listeners>
```

### 防止在一边编辑

为避免无限更新循环，锁定一边的编辑：

```php
public function evtSetInitialAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{   
  $this->ForceInitialAttributeFlags('person_id', OPT_ATT_HIDDEN); 
}
public function evtSetAttributeFlags(Combodo\iTop\Service\Events\EventData $oEventData)
{   
  $this->ForceAttributeFlags('person_id', OPT_ATT_READONLY); 
}
```

### 允许"抢占"

若要将已分配的车辆重新分配给另一个驾驶员：

- 修改过滤器允许抢占
- 在更新前一个驾驶员时，需要避免无限循环

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:one-to-one-relation>

版本：3_2_0/customization/one-to-one-relation.txt · Last modified: 2025/05/19 16:10 by 127.0.0.1
