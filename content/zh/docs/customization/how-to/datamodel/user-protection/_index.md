---
title: "用户保护"
linkTitle: "用户保护"
date: 2025-06-27
weight: 10
description: >
  用户保护。
---

{{% pageinfo %}}
本文档介绍如何防止因修改人员组织而导致用户意外被禁用。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:user-protection)。
{{% /pageinfo %}}

## 概述

若用户定义了 "Allowed organizations" 并关联到 Person，则该 Person 的组织必须在允许的列表中。此检查在 iTop 3.0.0 中已添加到用户对象创建/修改和 Person 删除时，但修改 Person 组织到不在允许列表中的组织的情况仍未被保护。

本教程添加对 Person 类的保护。

## DoCheckToWrite

必须覆盖此函数：

```php
public function DoCheckToWrite()
{
    if (array_key_exists('org_id', $this->ListChanges()) && ($this->HasUserAccount(true))) {
        $iNewOrg = $this->Get('org_id');
        $aUserOrgs = [$iNewOrg];
        $sHierarchicalKeyCode = MetaModel::IsHierarchicalClass('Organization');
        if ($sHierarchicalKeyCode !== false) {
            $sOrgQuery = 'SELECT Org FROM Organization AS Org JOIN Organization AS Root ON Org.'
                         .$sHierarchicalKeyCode.' ABOVE Root.id WHERE Root.id = :id';
            $oOrgFilter = new DBObjectSearch::FromOQL_AllData($sOrgQuery);
            $oOrgFilter->AllowAllData(true);
            $oOrgSet = new DBObjectSet($oOrgFilter, [], ['id' => $iNewOrg]);
            while ($aRow = $oOrgSet->FetchAssoc()) {
                $oOrg = $aRow['Org'];
                $aUserOrgs[] = $oOrg->GetKey();
            }
        }
        $oUserSet = $this->GetUsers(true);
        while($oUser = $oUserSet->Fetch())
        {
            if (!UserRights::IsAdministrator($oUser)) {
                $oSet = $oUser->get('allowed_org_list');
                if ($oSet->Count() > 0) {
                    $bFound = false;
                    while ($oOrg = $oSet->Fetch()) {
                        if (in_array($oOrg->Get('allowed_org_id'), $aUserOrgs)) {
                            $bFound = true;
                            break;
                        }
                    }
                    if (!$bFound) {
                        $this->m_aCheckErrors[] = $oUser->Get('login').": "
                                .Dict::S('Class:User/Error:AllowedOrgsMustContainUserOrg');
                    }
                }
            }
        }
    }
    return parent::DoCheckToWrite();
}
```

## 辅助函数

可选的 Helper 函数：

```php
public function GetUsers($bActiveOnly = false)
{
    $sOQL = $bActiveOnly ? 'SELECT User WHERE contactid = :person' 
                : "SELECT User WHERE contactid = :person AND status='active'";
    $oFilter = DBSearch::FromOQL($sOQL, array('person' => $this->GetKey()));
    $oFilter->AllowAllData(true);
    $oUserSet = new DBObjectSet($oFilter);
    return $oUserSet;
}

public function HasUserAccount($bActiveOnly = false)
{
    static $bHasUserAccount = null;
    if (is_null($bHasUserAccount)) {
        $bHasUserAccount = ($this->GetUsers($bActiveOnly)->Count() > 0);
    }
    return $bHasUserAccount;
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:user-protection>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/user-protection.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
