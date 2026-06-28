---
title: "表单预填充"
linkTitle: "表单预填充"
date: 2025-06-27
weight: 10
description: >
  自动预填充对象创建表单、搜索表单和转换表单中的字段值。
---

{{% pageinfo %}}
本文档介绍如何使用 API 方法预填充 iTop 表单中的字段值。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:form_prefill)。
{{% /pageinfo %}}

## 概述

iTop 已经内置了一些自动预填充行为：

- **搜索预设**：编辑 Team 并添加成员时，Person 搜索会自动按 Team 的组织过滤
- **创建预设**：在编辑 User Request 时创建新的 Caller Person，该 Person 的组织会自动填充为 User Request 的组织

对于 95% 的情况这些自动行为已经足够，但某些特殊场景需要通过 API 方法进行定制。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## API 方法

| 方法 | 说明 |
|------|------|
| `PrefillSearchForm(&$aContextParam)` | 预设相关对象的搜索框字段 |
| `PrefillCreationForm(&$aContextParam)` | 预设对象创建表单字段 |
| `PrefillTransitionForm(&$aContextParam)` | 预设转换表单字段 |

这些方法可以在以下场景中使用：

- 从菜单/操作调用
- 在间接 LinkedSet 属性（n:n 关系）中添加对象时
- 从编辑对象时 ExternalKey 属性旁的 + 按钮（1:n 关系）
- 从 LinkedSet 属性的行内编辑模式（n:1 关系）

## 预填充搜索表单

在**源对象**类上定义，预设每个相关对象搜索框中的字段。

### 上下文参数

| 参数 | 说明 |
|------|------|
| `$aContextParam['dest_class']` | 搜索的目标类 |
| `$aContextParam['filter']` | 过滤条件（DBObjectSearch 对象） |
| `$aContextParam['user']` | 当前登录用户的用户名 |
| `$aContextParam['origin']` | `console` 或 `portal` |

### 示例：按提供商过滤服务

在 Contract 类上，限制搜索仅返回提供商的服务，以及客户和提供商的联系人及文档：

```php
/** 示例：在 Contract 类上修改搜索，仅搜索：
 *      提供商的服务
 *      客户和提供商的联系人及文档 **/
public function PrefillSearchForm(&$aContextParam)
{
  // 如果搜索的是 'Service' 类或其子类
  if($aContextParam['dest_class'] == 'Service'
     || is_subclass_of($aContextParam['dest_class'], 'Service'))
  {
    // 如果搜索类有 'org_id' 属性且 Contract 的 provider_id 不为空
    if(MetaModel::IsValidAttCode($aContextParam['dest_class'],'org_id')
       && !empty($this->Get('provider_id')))
    {
        // 移除默认搜索设置的任何条件
        $aContextParam['filter']->ResetCondition();
        // 设置搜索类的 org_id 条件为 Contract 的提供商
        $aContextParam['filter']->AddCondition('org_id', $this->Get('provider_id'));
    }
  }
  // 如果搜索的是 Contact 或 Document 类或其子类
  elseif (($aContextParam['dest_class'] == 'Contact'
          || is_subclass_of($aContextParam['dest_class'], 'Contact'))
          || ($aContextParam['dest_class'] == 'Document'
          || is_subclass_of($aContextParam['dest_class'], 'Document')))
  {
    if(MetaModel::IsValidAttCode($aContextParam['dest_class'],'org_id'))
    {
      $aOrgIds = array();
      if(!empty($this->Get('provider_id'))) $aOrgIds[] = $this->Get('provider_id');
      if(!empty($this->Get('org_id')))      $aOrgIds[] = $this->Get('org_id');

      if(count($aOrgIds)>0)
      {
         // 使用 IN 参数设置多个 org_id 条件
         $aContextParam['filter']->ResetCondition();
         $aContextParam['filter']->AddCondition('org_id', $aOrgIds , 'IN');
      }
    }
  }
}
```

### 示例：限制为 Server 子类

```php
class UserRequest extends Ticket
{
    /**
     * 限制 CI 搜索仅返回 Server 类
     * 并允许用户设置其他 Server 字段作为搜索条件
     */
    public function PrefillSearchForm(&$aContextParam)
    {
        if($aContextParam['dest_class'] == 'FunctionalCI')
        {
            // 将 FunctionalCI 搜索改为仅搜索 Server
            $aContextParam['filter']->ChangeClass('Server');
        }
    }
}
```

使用 `ChangeClass('Server')` 比 `AddCondition('finalclass', 'Server')` 更好，因为前者允许使用任何 Server 字段作为搜索条件，而后者仅限于 FunctionalCI 的字段。

### 示例：使用关系过滤

```php
class UserRequest extends Ticket
{
    /**
     * 限制 CI 搜索仅返回与请求者关联的 PC
     * SELECT PC JOIN lnkContactToFunctionalCI AS L ON L.functionalci_id=PC.id
     * WHERE L.contact_id = :this->caller_id
     */
    public function PrefillSearchForm(&$aContextParam)
    {
        if($aContextParam['dest_class'] == 'FunctionalCI')
        {
            // 过滤为仅 PC
            $aContextParam['filter']->AddCondition('finalclass', 'PC');
            // 搜索 lnkContactToFunctionalCI
            $oSearchLnk = new DBObjectSearch('lnkContactToFunctionalCI');
            // 限制为与请求者相关的链接
            $oSearchLnk->AddCondition('contact_id', $this->Get('caller_id'));
            // 将链接搜索与 FunctionalCI 搜索关联
            $aContextParam['filter']->AddCondition_ReferencedBy($oSearchLnk, 'functionalci_id');
        }
    }
}
```

## 预填充创建表单

预设类的创建表单字段。

- 自动机制已完成预设工作，如果对象是从另一个对象创建的，字段可能已被填充
- `$this` 引用即将创建的对象

### 上下文参数

| 参数 | 说明 |
|------|------|
| `$aContextParam['user']` | 当前登录用户的用户名 |
| `$aContextParam['origin']` | `console` 或 `portal` |
| `$aContextParam['source_obj']` | 仅在创建外部键对象时可用（例如从 Person 创建 Team） |

### 示例 1：从 ServiceSubcategory 创建 RequestTemplate

```php
public function PrefillCreationForm(&$aContextParam)
{
    $id = $this->Get('servicesubcategory_id');
    if ($id != 0)
    {
        // 获取原始对象
        $oSubcategoryObject = MetaModel::GetObject('ServiceSubCategory', $id, false);
        // 使用原始对象的字段值预填充其他数据
        $this->Set('service_id', $oSubcategoryObject->Get('service_id'));
    }
}
```

### 示例 2：预设 Contract 的日期和提供商

```php
public function PrefillCreationForm(&$aContextParam)
{
    // 如果尚未设置，将合同开始日期预设为当前日期
    if(empty($this->Get('start_date'))) {
        $this->Set('start_date', time());
    }

    // 获取当前用户
    $oUser = UserRights::GetUserObject();
    // 将合同提供商预设为当前用户的组织
    // 注意：'org_id' 仅在 iTop 2.5.0 及以上版本的 User 类中可用
    $this->Set('provider_id', $oUser->Get('org_id'));
}
```

### 示例 3：预设 UserRequest 的请求者

```php
public function PrefillCreationForm(&$aContextParam)
{
    // 获取当前用户
    $oUser = UserRights::GetUserObject();
    // 将 caller 字段预填充为用户的联系人
    $this->SetIfNull('caller_id', $oUser->Get('contactid'));

    return true;
}
```

## 预填充转换表单

预设转换表单中的值：

- 此时转换尚未执行
- `$this` 引用即将应用转换的当前对象

### 上下文参数

| 参数 | 说明 |
|------|------|
| `$aContextParam['expected_attributes']['attribute_code']` | 表单中属性的显示标志 |
| `$aContextParam['origin']` | `console` 或 `portal` |
| `$aContextParam['stimulus']` | 应用的刺激 |

### 示例："分配给我" 逻辑

如果分配或重新分配工单，且工单未分配给我，同时我是该工单派发团队的一员，则在进入转换表单时将我的名字预设为 "agent"：

```php
public function PrefillTransitionForm(&$aContextParam)
{
  $oPerson = UserRights::GetContactObject();
  // 如果当前用户有关联的 Person 且处于分配转换
  if ($oPerson && ($aContextParam['stimulus'] == 'ev_assign'
      || $aContextParam['stimulus'] == 'ev_reassign'))
  {
    $iTicketAgentId = $this->Get('agent_id');
    $iPersonId = $oPerson->GetKey();

    // 如果 agent 不是当前用户
    if ($iTicketAgentId != $iPersonId )
    {
      // 检查当前联系人是否可以分配给该工单
      $iTicketTeamId = $this->Get('team_id');

      $oTeamLinkSet = $oPerson->Get('team_list');
      $bIsInTeam = false;
      while($oTeamLink = $oTeamLinkSet->Fetch())
      {
        $iTeam = $oTeamLink->Get('team_id');
        if ($iTicketTeamId == $iTeam) { $bIsInTeam = true; }
      }
      if($bIsInTeam)
      {
        $this->Set('agent_id', $iPersonId);
        // 移除 MUST CHANGE 标志
        if(array_key_exists('agent_id', $aContextParam['expected_attributes']))
        {
          $aContextParam['expected_attributes']['agent_id'] = ~OPT_ATT_MUSTCHANGE & $aContextParam['expected_attributes']['agent_id'];
        }
      }
    }
  }
}
```

### 已知限制

- 当 agent 被预设为用户名时，工单详情中的显示也会更新，仿佛修改已完成，可能造成混淆
- 用户可以通过将 agent 设置回之前的值来绕过 "must-change" 标志

## 在 XML 中集成方法

以下是在 XML 数据模型定义中声明上述方法的示例：

```xml
<class id="RequestTemplate" _delta="must_exist">
    <methods>
        <method id="PrefillCreationForm" _delta="define">
            <static>false</static>
            <access>public</access>
            <type>Overload-DBObject</type>
            <arguments>
                <argument id="1">
                    <type>reference</type>
                    <mandatory>true</mandatory>
                </argument>
            </arguments>
            <code><![CDATA[public function PrefillCreationForm(&$aContextParam)
          {       // 函数代码    }]]>
            </code>
        </method>
    </methods>
</class>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:form_prefill)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:form_prefill>

2025/07/09 16:07 by127.0.0.1

版本：3_2_0/customization/form_prefill.txt · Last modified: 2025/07/09 16:07 by 127.0.0.1
