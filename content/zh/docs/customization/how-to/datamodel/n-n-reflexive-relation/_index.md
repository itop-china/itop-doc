---
title: "n:n 自反与对称关系"
linkTitle: "n:n 自反与对称关系"
date: 2025-06-27
weight: 10
description: >
  n:n 自反与对称关系。
---

{{% pageinfo %}}
本文档介绍如何创建类与自身的对称多对多关系。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:n-n-reflexive-relation)。
{{% /pageinfo %}}

## 概述

创建类与自身的对称关系，例如人员的同事关系。若 John 是 Anna 的同事，则 Anna 也是 John 的同事。

iTop 默认的多对多关系不是对称的。本教程通过自动创建双向记录来实现对称性。

## 人员同事关系

### 核心思路

当用户创建 (src_person = John, dest_person = Anna) 时，后台自动创建其镜像 (src_person = Anna, dest_person = John)。

### AfterInsert

```php
public function AfterInsert()
{
    $oSearch = DBSearch::FromOQL('SELECT lnkPersonToPerson WHERE src_person_id = :src_id AND dest_person_id = :dest_id');
    $oSet = new DBObjectSet($oSearch, array(), 
       array(
          'src_id' => $this->Get('dest_person_id'), 
          'dest_id' => $this->Get('src_person_id'),
       ),
    );
    if ($oSet->Count() == 0) {
        $oLnk = MetaModel::NewObject("lnkPersonToPerson", 
            array('src_person_id' => $this->Get('dest_person_id'), 
                  'dest_person_id' => $this->Get('src_person_id')));
        $oLnk->DBInsert();
    }
}
```

### AfterUpdate

```php
public function AfterUpdate()
{
    $aChanges = $this->ListPreviousValuesForUpdatedAttributes();
    $sPrevSrc = array_key_exists('src_person_id', $aChanges) ? $aChanges['src_person_id'] : $this->Get('src_person_id');
    $sPrevDest = array_key_exists('dest_person_id', $aChanges) ? $aChanges['dest_person_id'] : $this->Get('dest_person_id');

    $oSearch = DBSearch::FromOQL('SELECT lnkPersonToPerson WHERE src_person_id = :src_id AND dest_person_id = :dest_id');
    $oSet = new DBObjectSet($oSearch, array(), 
       array(
          'src_id' => $sPrevDest, 
          'dest_id' => $sPrevSrc,
       ),
    );
    if ($oSet->Count() > 0) {
        while($oLnk = $oSet->Fetch()) {
            $oLnk->Set('src_person_id', $this->Get('dest_person_id'));
            $oLnk->Set('dest_person_id', $this->Get('src_person_id'));
            $oLnk->DBUpdate();
        }
    } else {
        $oSearchNew = DBSearch::FromOQL('SELECT lnkPersonToPerson WHERE src_person_id = :src_id AND dest_person_id = :dest_id');
        $oSetNew = new DBObjectSet($oSearchNew, array(),
           array(
              'src_id' => $this->Get('dest_person_id'),
              'dest_id' => $this->Get('src_person_id'),
           ),
        );
        if ($oSetNew->Count() === 0) {
            $oLnk = MetaModel::NewObject("lnkPersonToPerson", array(
                'src_person_id' => $this->Get('dest_person_id'),
                'dest_person_id' => $this->Get('src_person_id'),
            ));
            $oLnk->DBInsert();
        }
    }
}
```

### AfterDelete

```php
public function AfterDelete()
{
    $oSearch = DBSearch::FromOQL('SELECT lnkPersonToPerson WHERE src_person_id = :src_id AND dest_person_id = :dest_id');
    $oSet = new DBObjectSet($oSearch, array(), 
       array(
          'src_id' => $this->Get('dest_person_id'), 
          'dest_id' => $this->Get('src_person_id'),
       ),
    );
    if ($oSet->Count() > 0) {
        while($oLnk = $oSet->Fetch()) { 
           $oLnk->DBDelete();
        }
    }
}
```

## NetworkDevice & ConnectableCI

此用例来自 iTop 默认数据模型，比上面的更复杂，因为有时对称有时不对称，取决于 ConnectableCI 是否也是 NetworkDevice。

### AfterInsert

```php
public function AfterInsert() 
{
   $oDevice = MetaModel::GetObject('ConnectableCI', $this->Get('connectableci_id'));
   if (is_object($oDevice) && (get_class($oDevice) == 'NetworkDevice')) {
      $sOQL = "SELECT lnkConnectableCIToNetworkDevice 
        WHERE connectableci_id = :device AND networkdevice_id = :network 
        AND network_port = :nwport AND device_port = :devport";
      $oConnectionSet = new DBObjectSet(DBObjectSearch::FromOQL($sOQL),
        array(),
        array(
                'network' => $this->Get('connectableci_id'),
                'device' => $this->Get('networkdevice_id'),
                'devport' => $this->Get('network_port'),
                'nwport' => $this->Get('device_port'),
        )
      );
      if ($oConnectionSet->Count() == 0) {
        $sLink = $this->Get('connection_type');
        $sConnLink = ($sLink == 'uplink') ? 'downlink' : 'uplink';

        $oNewLink = new lnkConnectableCIToNetworkDevice();
        $oNewLink->Set('networkdevice_id', $this->Get('connectableci_id'));
        $oNewLink->Set('connectableci_id', $this->Get('networkdevice_id'));
        $oNewLink->Set('network_port', $this->Get('device_port'));
        $oNewLink->Set('device_port', $this->Get('network_port'));
        $oNewLink->Set('connection_type', $sConnLink);
        $oNewLink->DBInsert();
      }
   }
}
```

### AfterDelete

```php
public function AfterDelete()
{
    $oDevice = MetaModel::GetObject('ConnectableCI', $this->Get('connectableci_id'), false);
    if (is_object($oDevice) && (get_class($oDevice) == 'NetworkDevice')) {
        $sOQL = "SELECT lnkConnectableCIToNetworkDevice 
                 WHERE connectableci_id = :device AND networkdevice_id = :network 
                 AND network_port = :nwport AND device_port = :devport";
        $oConnectionSet = new DBObjectSet(DBObjectSearch::FromOQL($sOQL),
                array(),
                array(
                        'network' => $this->Get('connectableci_id'),
                        'device' => $this->Get('networkdevice_id'),
                        'devport' => $this->Get('network_port'),
                        'nwport' => $this->Get('device_port'),
                )
        );
        while ($oConnection = $oConnectionSet->Fetch()) {
                $oConnection->DBDelete();
        }
    }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:n-n-reflexive-relation>

版本：3_2_0/customization/n-n-reflexive-relation.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
