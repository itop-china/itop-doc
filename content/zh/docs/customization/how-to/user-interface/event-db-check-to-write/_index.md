---
title: "使用事件检查数据完整性"
linkTitle: "使用事件检查数据完整性"
date: 2025-06-27
weight: 10
description: >
  使用事件机制在对象保存前检查数据一致性。
---

{{% pageinfo %}}
本文档介绍如何使用事件机制检测数据不一致并阻止不合规对象保存到数据库。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:event_db_check_to_write)。
{{% /pageinfo %}}

## 概述

通过订阅事件并编写回调方法，可以在对象写入数据库前进行数据一致性检查。

- 在控制台或门户中，提交后报告错误
- 阻止 DataSynchro、REST/JSON 和 CSV 导入创建或更新不合规对象

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 理论基础

订阅事件并在对象类上编写回调方法 `XxxxxXxxx()`：

- 该方法在写入数据库前被调用
- 遇到数据不一致时添加错误消息
- 错误使用 `$this->AddCheckIssue()` 记录
- 警告使用 `$this->AddCheckWarning()` 记录
- 如果返回时存在至少一个错误，对象不会被写入数据库

### 消息显示方式

- **交互模式**（控制台、门户、CSV 导入）：向用户显示错误和警告
- **非交互模式**（DataSynchro、REST/JSON、CLI）：根据跟踪级别记录到 `itop/log/error.log`

## 示例：防止组织修改破坏关联用户

本示例检查修改 Person 的组织时，如果该 Person 有关联的 User，确保这些 User 不会因组织修改而损坏。

### 订阅事件

```xml
<class id="Person" _delta="define">
  <event_listeners>
    <event_listener id="CheckUsersUpdate">
      <event>EVENT_DB_CHECK_TO_WRITE</event>
      <callback>CheckUsersOnUpdate</callback>
      <rank>1</rank>
    </event_listener>
  </event_listeners>
</class>
```

可通过查看 iTop 数据模型的 "Events" 标签页了解类支持的事件。

### 检查条件

```php
public function CheckUsersOnUpdate(Combodo\iTop\Service\Events\EventData $oEventData)
{
    // 该方法可以通过添加 Check Issue 阻止 Person 修改
    $aChanges = $this->ListChanges();
    // Person 的组织被修改
    if (array_key_exists('org_id', $aChanges))
    {
        // 当前用户可能无权查看 User 类，因此不能使用 $this->Get('user_list')
        $oSearch = new DBObjectSearch('User');
        $oSearch->AddCondition('contactid', $this->GetKey(), '=');
        $oSearch->AllowAllData();
        $oUserSet = new DBObjectSet($oSearch);

        // Person 有关联的 User
        if ($oUserSet->Count() > 0) {
            $oAddon = UserRights::GetModuleInstance();
            // 遍历每个关联的 User
            while($oUser = $oUserSet->Fetch())
            {
                // 获取其允许的组织列表和角色
                $aOrgs = $oAddon->GetUserOrgs($oUser,'Organization');
                $oSet = $oUser->Get('profile_list');
                $aProfiles = $oSet->GetColumnAsArray('profile');

                // User 有允许的组织列表、不在新组织中、具有 "Portal user" 角色且已启用
                if ((count($aOrgs) > 0) && !in_array($this->Get('org_id'), $aOrgs)
                    && in_array('Portal user',$aProfiles) && ($oUser->Get('status') === 'enabled'))
                {
                    // 阻止 Person 修改
                    // 如不想阻止，可使用 $this->AddCheckWarning(...)
                    $this->AddCheckIssue(Dict::Format('Class:Person/Error:ChangingOrgDenied', $this->Get('org_id_friendlyname')));
                }
            }
        }
    }
}
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:event_db_check_to_write)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:event_db_check_to_write>

版本：3_2_0/customization/event_db_check_to_write.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
