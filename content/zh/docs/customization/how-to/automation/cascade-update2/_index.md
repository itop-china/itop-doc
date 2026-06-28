---
title: "对 n:n 远程字段求和"
linkTitle: "对 n:n 远程字段求和"
date: 2025-06-27
weight: 10
description: >
  对 n:n 远程字段求和。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中实现 n:n 关系的计算字段，例如在合同上统计所有关联组件的成本总和。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-update2)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

在对象 A 的详情中显示通过多对多关系链接到对象 A 的对象 B 的总和。本示例在 `Contract` 上统计每个包含的 `Component` 的成本总和。

- `cost` 是 `Component` 类的字段（标准数据模型中不存在此类）
- 在 `Contract` 类上创建 `components_total_cost` 字段，存储 `Component` 成本的总和
- `lnkContractToComponent` 类有 `contract_id` 和 `component_id` 外键，存储多对多关系
- `Component` 上有 `contracts_list` 字段，提供链接到该组件的合同列表
- `Contract` 上有 `components_list` 字段，提供链接到该合同的组件列表

需要支持：

- 能够搜索该"计算"字段
- 能够对该"计算"字段运行审计

## n:n 聚合策略

实现此类"计算"字段（使用多对多关系末端对象的聚合函数）的通用策略：

- 为了能够查询，必须将其存储在数据库中，因此设为持久字段
- 为确保始终准确，需要识别何时必须重新计算并执行

### 在类 A 上

- 编写方法计算"计算"字段的值。最好实现"增量"计算方法，接受远程对象修改导致的增减值作为参数
- 在 EVENT_DB_SET_INITIAL_ATTRIBUTE_FLAGS 上的回调方法：指定"计算"字段在创建表单中隐藏
- 在 EVENT_DB_SET_ATTRIBUTE_FLAGS 上的回调方法：指定"计算"字段在修改时只读

### 在链接类上

有两种选择：

- **简单策略**：使用 EVENT_DB_LINKS_CHANGED 和 `ComputeComponents` 作为回调（与 1:n 策略相同）
- **复杂策略**（本教程采用）：避免完整重新计算。适用于 LinkedSet 中对象数量庞大、希望避免完整重新计算的场景

  - EVENT_DB_AFTER_WRITE 上的回调方法：强制重新计算所有受影响的对象 A
  - EVENT_DB_AFTER_DELETE 上的回调方法：强制重新计算对象 A

### 在依赖类 B 上

- EVENT_DB_AFTER_WRITE 上的回调方法：如果用于计算的字段发生变化（此处为 `Component.cost`），更新对象 A

### 提示与说明

- 使用 `EVENT_DB_AFTER_WRITE` 级联变更，而不是 `EVENT_DB_BEFORE_WRITE`，因为否则远程对象尚未保存到数据库，后续的 CHECK_TO_WRITE 可能失败并阻止写入

## 在 Contract 上

首先创建两个函数：

- 一个从头重新计算扩展总成本，逐个解析扩展
- 一个通过仅添加或移除一个组件来计算总和（提高效率）

```php
// 此函数检索所有相关组件并求和其成本
public function ComputeComponents()
{
        $iSum = 0;
        $oSet = $this->Get('components_list');
        while($oLnk = $oSet->Fetch()) {
                $oComponent = MetaModel::GetObject('Component', $oLnk->Get('component_id'), false, true);
                if (is_object($oComponent )) {
                        $iSum = $iSum + $oComponent ->Get('cost');
                }
        }
        $this->Set('components_total_cost', $iSum);
}
 
public function ComputeComponentsDirect($iDelta)
{
        // 防止数据库不一致
        if (is_numeric($iDelta)) {
                $iNewTotal = $this->Get('components_total_cost') + $iDelta;
                $this->Set('components_total_cost', $i);
        }
}
```

## 在链接对象上

链接对象创建、删除或修改时的处理：

### 创建

- 要求 Contract 将该组件成本添加到其总和中

### 修改

需要考虑所有可能的变更：

- 合同变更但组件不变：从旧合同移除组件成本，向新合同添加组件成本
- 组件变更但合同不变：从合同移除旧组件成本，向合同添加新组件成本
- 两者同时变更：从旧合同移除旧组件成本，向新合同添加新组件成本

### 删除

- 要求 Contract 从总和中移除被删除的组件成本

```php
public function AfterWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    if ($oEventData->Get('is_new')) {
        $this->OnAddRemoveOfALink($this->Get('contract_id'), $this->Get('component_id'), true);
    } else {
        $aChanges = $this->ListPreviousValuesForUpdatedAttributes();
        $bContractChanged = array_key_exists('contract_id', $aChanges);
        $bComponentChanged = array_key_exists('component_id', $aChanges);
 
        if ($bContractChanged || $bComponentChanged) {       
            $iRemovedComponent = ($bComponentChanged) ? $aChanges['component_id'] : $this->Get('component_id');
            $iAddedComponent = $this->Get('component_id');
            $iPreviousContract = ($bContractChanged) ? $aChanges['contract_id'] : 0;
            $iNewContract = $this->Get('contract_id');
 
            $this->OnAddRemoveOfALink($iPreviousContract, $iRemovedComponent, false);
            $this->OnAddRemoveOfALink($iNewContract , $iAddedComponent , true);
        }
    }
}
public function AfterDelete(Combodo\iTop\Service\Events\EventData $oEventData)
{
        $this->OnAddRemoveOfALink(($this->Get('contract_id'), $this->Get('component_id'), false);
}
 
public function OnAddRemoveOfALink($idContract, $idComponent, $bAdd)
{
        $oComponent = MetaModel::GetObject('Component', $idComponent, false, true);
        $oContract = MetaModel::GetObject('Contract', $idContract, false, true); 
 
        if (is_object($oComponent) && is_object($oContract )) {
                $iCost = $oComponent ->Get('cost');
                $iDelta = ($bAdd) ? $iCost : - $iCost ;
                $oContract->ComputeComponentsDirect($iDelta);
                $oContract->DBUpdate();
        }
}
```

## 在 Component 上

需要处理组件的各种变更场景：

- 组件创建 → 通过关联链接的创建处理
- 组件删除 → 通过关联链接的级联删除处理
- 组件 `cost` 修改 → 需要处理

```php
public function AfterWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
    $aChanges = $this->ListPreviousValuesForUpdatedAttributes();
    if (array_key_exists('cost', $aChanges))
    {
        $iDelta = $this->Get('cost') - $aChanges['cost];
        $oSet = $this->Get('contracts_list');
        while($oLnk = $oSet->Fetch())
        {
            $oContract = MetaModel::GetObject('Contract', $oLnk->Get('contract_id'), false, true);
            $oContract->ComputeComponentsDirect($iDelta)
            $oContract->DBUpdate();
        }
    } 
}
```

## 陷阱

理论上以上代码已足够，但存在一个问题：

当在同一事务中更新 Contract 和 lnkContractToComponent 时，代码会启动 Contract::DBUpdate()，其中为每个 lnkContractToComponent 调用 OnInsert()、OnUpdate() 或 OnDelete()，这些代码会执行 $oContract->DBUpdate()，从而进入无限循环（代码会阻止此循环）。结果是第二个 $oContract->DBUpdate() 完全不会执行（静默失败）。

**解决方案**：在 Contract 本身上编写特殊处理：

- 创建时，链接可能同时创建（例如通过 Object-Copier）
- 更新时，从头重新计算总和，因为已知链接处理期间的 Contract DBUpdate 请求会被重入保护忽略
- 删除时，无需操作

```php
public function BeforeWrite(Combodo\iTop\Service\Events\EventData $oEventData)
{
        $aChanges = $this->ListChanges();
        if (array_key_exists('components_list', $aChanges))
        {
            $this->ComputeComponents();
        }
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:cascade-update2>

2025/05/21 11:01 by127.0.0.1

版本：3_2_0/customization/cascade-update2.txt · Last modified: 2025/05/21 11:01 by 127.0.0.1
