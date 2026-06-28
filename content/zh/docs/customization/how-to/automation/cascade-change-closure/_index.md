---
title: "级联变更关闭"
linkTitle: "级联变更关闭"
date: 2025-06-27
weight: 10
description: >
  级联变更关闭。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现当变更关闭时，自动关闭所有关联的用户请求。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-change-closure)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

当变更关闭时，自动关闭所有关联的用户请求。

**限制**：提供的 XML 示例仅适用于 `itop-change-mgmt` 选项，不适用于 `itop-change-mgmt-ITIL`。

需要完成：

- 添加方法，对每个关联请求执行 `ev_autoresolve` 刺激
- 在变更关闭时使用此方法作为动作

## 计算方法

修改 `Change` 类，添加以下 PHP 方法：

```php
/**
 * @return bool 成功返回 true，返回 false 阻止转换发生
 */
public function ResolveRelatedRequest()
{
   $sOQL = "SELECT UserRequest WHERE parent_change_id = :ticket AND status != 'resolved'";
   $oRelatedRequestSet = new DBObjectSet(DBObjectSearch::FromOQL($sOQL), array(), array('ticket' => $this->GetKey()));
   while($oRequest = $oRelatedRequestSet->Fetch())
   {
        if ($oRequest->Get('status') != 'resolved' && $oRequest->Get('status') != 'closed' )
        {
           $oRequest->Set('solution', 'ticket automatically resolved by '.$this->Get('friendlyname'));
           $oRequest->ApplyStimulus('ev_autoresolve');
           $oRequest->DBUpdate();
        }
   }
}
```

## 修改变更工作流

在变更关闭时执行此方法，需要修改 `Change` 类的工作流：

```xml
<lifecycle>
  <states>
    <state id="approved" _delta="must_exist">
      <transitions>
        <transition id="ev_finish" _delta="must_exist">
          <actions _delta="redefine">
            <action>
              <verb>SetCurrentDate</verb>
              <params>
                <param xsi:type="attcode">close_date</param>
              </params>
            </action>
            <action>
              <verb>ResolveRelatedRequest</verb>
            </action>
          </actions>
        </transition>
      </transitions>
    </state>
  </states>
</lifecycle>
```

## 完整 XML Delta

```xml
<class id="Change" _delta="must_exist">
  <methods>
    <method id="ResolveRelatedRequest" _delta="define">
      <comment>/**
 * @author My first name My last name
 * @return bool Return true on success or false to prevent the transition to happen
 */</comment>
      <static>false</static>
      <access>public </access>
      <code><![CDATA[ public function ResolveRelatedRequest()
      {
              $sOQL = "SELECT UserRequest WHERE parent_change_id = :ticket AND status != 'resolved'";
              $oRelatedRequestSet = new DBObjectSet(DBObjectSearch::FromOQL($sOQL), array(), array('ticket' => $this->GetKey()));
              while($oRequest = $oRelatedRequestSet->Fetch())
              {
                      if ($oRequest->Get('status') != 'resolved' && $oRequest->Get('status') != 'closed' )
                      {
                              $oRequest->Set('solution', 'ticket automatically resolved by '.$this->Get('friendlyname'));
                              $oRequest->ApplyStimulus('ev_autoresolve');
                              $oRequest->DBUpdate();
                      }
              }
              return true;
      }]]></ code>
      <arguments/>
    </method>
  </methods>
  <lifecycle>
    <states>
      <state id="approved" _delta="must_exist">
        <transitions>
          <transition id="ev_finish" _delta="must_exist">
            <actions _delta="redefine">
              <action>
                <verb>SetCurrentDate</verb>
                <params>
                  <param xsi:type="attcode">close_date</param>
                </params>
              </action>
              <action>
                <verb>ResolveRelatedRequest</verb>
              </action>
            </actions>
          </transition>
        </transitions>
      </state>
    </states>
  </lifecycle>
</class>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-change-closure>

版本：3_2_0/customization/cascade-change-closure.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
