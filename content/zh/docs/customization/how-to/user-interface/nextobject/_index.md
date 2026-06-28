---
title: "对象间导航"
linkTitle: "对象间导航"
date: 2025-06-27
weight: 10
description: >
  在对象详情页添加上一个/下一个导航按钮。
---

{{% pageinfo %}}
本文档介绍如何在对象详情页添加导航按钮，方便在同类对象间切换。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:nextobject)。
{{% /pageinfo %}}

## 概述

本教程将在某些对象详情页上添加两个按钮，允许导航到上一个和下一个对象。

导航范围由以下条件定义：

- **code**（必需）：一个标量属性代码，其值必须与当前对象相同。例如：在同一组织的人员间导航
- **filter**（可选）：一个过滤条件，减少可导航的对象范围。例如：仅导航活动状态的人员
- **order**（可选）：默认 `id`。一个标量属性代码，定义导航顺序。目前假设该字段值唯一，重复值会被忽略/跳过。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 配置

可以在 iTop 中启用对象间导航。每个类只能定义一个导航规则：

```php
$MyModuleSettings = array(
   'combodo-object-navigation' => array(
       'classes' => array(
            'UserRequest' => array(
                'code' => 'org_id',
                'filter'=> array('code'=>'status','value'=>'closed','operator'=>'!='),
            ),
            'WorkOrder' => array(
                'code' => 'ticket_id',
                'filter'=> array('code'=>'status','value'=>'closed','operator'=>'!='),
                'order' => 'start_date',
            ),
            'Team' => array(
                'code' => 'org_id',
                'filter'=> array('code'=>'status','value'=>'active'),
                'order'=>'name',
            ),
            'Person' => array(
                'code' => 'org_id',
                'filter'=> array('code'=>'status','value'=>'active'),
                'order'=>'name',
            ),
        )
    )
);
```

### 过滤条件参数

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| code | 是 | - | 属性代码 |
| operator | 否 | `=` | 支持 `>`, `>=`, `<`, `<=`, `!=` |
| value | 否 | `''` | 空字符串 |

## 扩展代码

```php
class ObjectNavigationMenuExtension implements iPopupMenuExtension
{
    static public function GetConfig()
    {
        return MetaModel::GetModuleSetting('combodo-object-navigation', 'classes', array());
    }

    public static function EnumItems($iMenuId, $param)
    {
        $aResult = array();
        $aClassCode = static::GetConfig();
        switch($iMenuId)
        {
            case iPopupMenuExtension::MENU_OBJDETAILS_ACTIONS: // 仅控制台

            $sClass = get_class($param);
            if (array_key_exists($sClass, $aClassCode)) {
                $sAttCode = $aClassCode[$sClass]['code'];
                $sOrder = array_key_exists('order', $aClassCode[$sClass]) ? $aClassCode[$sClass]['order'] :'id';
                $sOrderValue = ($sOrder === 'id') ? $param->GetKey() : $param->Get($sOrder);
                $bFilter = false;
                if (array_key_exists('filter', $aClassCode[$sClass])) {
                    $sFilterCode = array_key_exists('code', $aClassCode[$sClass]['filter']) ? $aClassCode[$sClass]['filter']['code'] : '';
                    $sFilterValue = array_key_exists('value', $aClassCode[$sClass]['filter']) ? $aClassCode[$sClass]['filter']['value'] : '';
                    $sFilterOperator = array_key_exists('operator', $aClassCode[$sClass]['filter']) ? $aClassCode[$sClass]['filter']['operator'] : '=';
                    $bFilter = MetaModel::IsValidAttCode($sClass, $sFilterCode);
                }

                foreach ( ['>','<'] AS $sOperator) {
                    $bAsc = ($sOperator === '>') ? true : false;
                    $oSearch = new DBObjectSearch($sClass);
                    if (MetaModel::IsValidAttCode($sClass, $sAttCode))
                        $oSearch->AddCondition($sAttCode, $param->Get($sAttCode), '=');
                    if (($sOrder === 'id') || MetaModel::IsValidAttCode($sClass, $sOrder))
                        $oSearch->AddCondition($sOrder, $sOrderValue, $sOperator);
                    if ($bFilter)
                        $oSearch->AddCondition($sFilterCode, $sFilterValue, $sFilterOperator);
                    $oSet = new DBObjectSet($oSearch, array($sOrder => $bAsc),[],null,3);
                    $oObj = $oSet->Fetch();
                    if (is_object($oObj)) {
                        if ($sOperator === '>') {
                            $oItem = new URLButtonItem(
                                'UI:next:object',
                                'Next',
                                utils::GetAbsoluteUrlAppRoot().'pages/UI.php?operation=details&class='.get_class($oObj).'&id='.$oObj->GetKey(),
                                '_top'
                            );
                            $oItem->SetIconClass('fas fa-caret-right');
                            $oItem->SetTooltip("Switch to the next logical object");
                        } elseif ($sOperator === '<') {
                            $oItem = new URLButtonItem(
                                'UI:previous:object',
                                'Previous',
                                utils::GetAbsoluteUrlAppRoot().'pages/UI.php?operation=details&class='.get_class($oObj).'&id='.$oObj->GetKey(),
                                '_top'
                            );
                            $oItem->SetIconClass('fas fa-caret-left');
                            $oItem->SetTooltip("Switch to the previous logical object");
                        }
                        $aResult[] = $oItem;
                    }
                }
            }
            break;
        }
        return $aResult;
    }
}
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:nextobject)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:nextobject>

版本：3_2_0/customization/nextobject.txt · Last modified: 2025/05/20 16:14 by 127.0.0.1
