---
title: "CRUD 序列"
linkTitle: "CRUD 序列"
date: 2025-06-27
weight: 10
description: >
  CRUD 序列。
---

{{% pageinfo %}}
本文档详细描述 iTop ORM 中 CRUD 操作（创建、更新、删除）的方法调用序列。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:sequence_crud)。
{{% /pageinfo %}}

## 概述

这是 iTop ORM CRUD 栈（创建、更新、删除操作）中方法调用的映射。要了解更多关于扩展性的信息，请参阅[扩展性 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces)。

### 对象层次结构

iTop 核心中有 3 个类可以扩展用于新的 iTop 对象：

- **DBObject**：数据库中的持久化对象
- **CMDBObject**：添加历史跟踪
- **cmdbAbstractObject**：可编辑对象

所有默认数据模型对象都是 `cmdbAbstractObject` 的子类。

### 栈修改历史

- **2.7.0**：事务（参见：N°679, N°2456）
- **3.1.0**：事件（N°4756, N°5906）

## 图例说明

- **粗体**：可覆盖的回调（在代码中标记为 `overwritable-hook` PHPDoc 标签）
- **红色**：直接对数据库执行的操作
- **蓝色**：父方法
- **绿色**：事件
- **紫色**：对象访问修改

## DBInsert（创建对象）

从 `DBObject::DBInsert` 开始：

1. `cmdbAbstractObject::DBInsert`
2. `DBObject::DBInsertNoReload`
3. `DBObject::DoComputeValues`
4. `cmdbAbstractObject::FireEventComputeValues` - `EventService::FireEvent(EVENT_DB_COMPUTE_VALUES)`（自 3.1.0 N°4756）
5. `DBObject::ComputeValues`
6. `DBObject::OnInsert`
7. `cmdbAbstractObject::FireEventBeforeWrite` - `EventService::FireEvent(EVENT_DB_BEFORE_WRITE, ['is_new' => true])`（自 3.1.0 N°6324）
8. `DBObject::CheckToWrite`
9. 如果 `MetaModel::SkipCheckToWrite` 则返回
10. `DBObject::SetReadOnly`：从此处起不允许 `DBObject::Set`（自 3.1.0 N°4756）
11. `cmdbAbstractObject::FireEventCheckToWrite` - `EventService::FireEvent(EVENT_DB_CHECK_TO_WRITE, ['is_new' => true])`（自 3.1.0 N°4756）
12. `DBObject::SetReadWrite`：从此处起允许 `DBObject::Set`（自 3.1.0 N°4756）
13. `cmdbAbstractObject::DoCheckToWrite`
14. 如果 `CheckToWrite` 返回 false，则抛出 `CoreCannotSaveObjectException`
15. `DBObject::GetState`
16. 遍历 `MetaModel::ListAttributeDefs`，如果 `$oAttDef instanceof AttributeStopWatch`
    - `ormStopWatch::Start`
    - `ormStopWatch::ComputeDeadlines`
17. `DBObject::Set`：设置具有修改值的属性
18. `CMDBSource::Query('START TRANSACTION')`（自 2.7.0 N°679）
19. `DBObject::DBInsertSingleTable($sRootClass)`
20. `DBObject::DBInsertSingleTable($sClass)`：在叶类上调用插入
21. 遍历 `MetaModel::EnumParentClasses`
    - `DBObject::DBInsertSingleTable($sParentClass)`：在类层次结构上调用插入
22. `cmdbAbstractObject::OnObjectKeyReady`
23. `InlineImage::FinalizeInlineImages`
24. `DBObject::DBWriteLinks`
    - 遍历每个修改的 linkset
    - `ormLinkSet::DBWrite`
25. `DBObject::WriteExternalAttributes`
    - `\AttributeCustomFields::WriteExternalValues`
26. `CMDBObject::RecordObjCreation`
    - 删除删除记录
    - 删除 2.0.3 之前遗留的任何其他更改跟踪信息
    - `DBObject::RecordObjCreation`
    - `DBObject::RecordLinkSetListChange`
    - 创建新的 `CMDBChangeOpCreate`
27. `CMDBSource::Query('COMMIT')`（异常时 ROLLBACK）
28. 重置元信息：`m_bIsInDB = true`，`m_bDirty = false`，设置 `m_aOrigValues[$sAttCode]`
29. `MetaModel::StartReentranceProtection()`（自 3.1.0 N°4756）
30. `cmdbAbstractObject::PostInsertActions`
    - `DBObject::PostInsertActions`
    - `cmdbAbstractObject::FireEventAfterWrite`
    - `\cmdbAbstractObject::NotifyAttachedObjectsOnLinkClassModification`（自 3.1.0 N°5906）
    - `\cmdbAbstractObject::FireEventDbLinksChangedForCurrentObject` - `EVENT_DB_LINKS_CHANGED`（自 3.1.0 N°5906）
    - `EventService::FireEvent(EVENT_DB_AFTER_WRITE, ['changes' => [], 'is_new' => true])`（自 3.1.0 N°6324）
    - `DBObject::AfterInsert`
31. 搜索触发器：
    - `$sClassList = MetaModel::EnumParentClasses`
    - `SELECT TriggerOnObjectCreate AS t WHERE t.target_class IN ('$sClassList')`
    - 遍历查询结果：`Trigger::DoActivate`
32. `DBObject::ActivateOnMentionTriggers`
33. 遍历 `iApplicationObjectExtension`（在 `cmdbAbstractObject::DBInsert` 中）
    - `iApplicationObjectExtension::OnDBInsert`
34. `MetaModel::StopReentranceProtection(REENTRANCE_TYPE_UPDATE)`（自 3.1.0 N°4756）
35. 如果对象被修改：`DBObject::DBUpdate`（自 3.1.0 N°4756）
36. `finally`：如果 `static::IsCrudStackEmpty()`
    - `\cmdbAbstractObject::FireEventDbLinksChangedForAllObjects` - `EVENT_DB_LINKS_CHANGED`（自 3.1.0 N°5906）
37. 返回 `DBObject::$m_iKey`

## DBUpdate（更新对象）

1. `cmdbAbstractObject::DBUpdate`
2. 如果没有更改则返回
3. `DBObject::DBUpdate`
4. `MetaModel::StartReentranceProtection`（已在更新中则退出）（自 3.1.0 N°4756）
5. `DBObject::DoComputeValues`
6. `cmdbAbstractObject::FireEventComputeValues` - `EventService::FireEvent(EVENT_DB_COMPUTE_VALUES)`（自 3.1.0 N°4756）
7. `DBObject::ComputeValues`
8. `DBObject::GetState`
9. 如果 `$sState != ''`，遍历 `MetaModel::ListAttributeDefs`
    - 如果 `$oAttDef instanceof AttributeStopWatch`：`ormStopWatch::ComputeDeadlines`
10. `DBObject::OnUpdate`
11. `cmdbAbstractObject::FireEventBeforeWrite` - `EventService::FireEvent(EVENT_DB_BEFORE_WRITE, ['is_new' => false])`（自 3.1.0 N°6324）
12. `DBObject::InitPreviousValuesForUpdatedAttributes`（自 2.7.0 N°2293）
13. 将 `$this->ListChanges()` 保存到 `$aChanges`
14. 冻结更改
15. 如果 `count($this->ListChanges()) == 0`
    - `MetaModel::StopReentranceProtection(REENTRANCE_TYPE_UPDATE)`（自 3.1.0 N°4756）
    - 返回 `DBObject::$m_iKey`
16. `DBObject::CheckToWrite`
17. 如果 `MetaModel::SkipCheckToWrite` 则返回
18. `DBObject::SetReadOnly`：从此处起不允许 `DBObject::Set`（自 3.1.0 N°4756）
19. `cmdbAbstractObject::FireEventCheckToWrite` - `EventService::FireEvent(EVENT_DB_CHECK_TO_WRITE, ['is_new' => false])`（自 3.1.0 N°4756）
20. `DBObject::SetReadWrite`：从此处起允许 `DBObject::Set`（自 3.1.0 N°4756）
21. `cmdbAbstractObject::DoCheckToWrite`
22. 如果返回 false，则抛出 `CoreCannotSaveObjectException`
23. 保存原始值：`DBObject::$m_aOrigValues` 到 `$aOriginalValues` 变量
24. 从 `$aChanges` 中为 `\AttributeDefinition::IsBasedOnDBColumns == true` 的字段设置 `$aDBChanges`
25. `CMDBSource::Query('START TRANSACTION')`（自 2.7.0 N°679）
26. 如果 `!MetaModel::DBIsReadOnly()`
    - 更新每个层次键的左右索引
    - 更新标量属性
    - 使用当前类名和 id 创建新的 `DBObjectSearch`，并 `AllowAllData()`
    - `DBObjectSearch::MakeUpdateQuery` 使用 `$aDBChanges`
    - `\CMDBSource::Query` 执行更新查询
27. `DBObject::DBWriteLinks`
28. `DBObject::WriteExternalAttributes`
    - `\AttributeCustomFields::WriteExternalValues`
29. 属性重置：`m_bDirty`（设为 false），`m_aTouchedAtt`，`m_aModifiedAtt` => 这导致 `ListChanges()` 返回空数组
30. `DBObject::RecordAttChanges` 使用 `$aChanges`
31. `CMDBSource::Query('COMMIT')`（异常时 ROLLBACK）
32. `cmdbAbstractObject::PostUpdateActions`
    - `DBObject::PostUpdateActions`
    - `cmdbAbstractObject::FireEventAfterWrite`
    - `\cmdbAbstractObject::NotifyAttachedObjectsOnLinkClassModification`（自 3.1.0 N°5906）
    - `\cmdbAbstractObject::FireEventDbLinksChangedForCurrentObject` - `EVENT_DB_LINKS_CHANGED`（自 3.1.0 N°5906）
    - `EventService::FireEvent(EVENT_DB_AFTER_WRITE, ['changes' => $aChanges, 'is_new' => false])`（自 3.1.0 N°6324）
    - `DBObject::AfterUpdate`（自 2.7.0 N°2293，更改可使用 `DBObject::ListPreviousValuesForUpdatedAttributes` 访问）
33. 重置 `DBObject::$m_aOrigValues`
34. `TriggerOnObjectUpdate`：遍历使用当前类或其父类的所有触发器
    - `TriggerOnObjectUpdate::DoActivate`（自 3.0.0 N°3245 和 3.0.2 N°5389，`TriggerOnObjectUpdate` 移至数据库更新之后）
35. 重入调用（N°1073）：`unset(DBObject.aUpdateReentrance[$sKey])`
36. `DBObject::ActivateOnMentionTriggers`
37. 搜索 `iApplicationObjectExtension` 实现
    - `iApplicationObjectExtension::OnDBUpdate`（自 2.7.0 N°2293，更改可使用 `DBObject::ListPreviousValuesForUpdatedAttributes` 访问）
38. `MetaModel::StopReentranceProtection()`（自 3.1.0 N°4756）
39. 如果对象被修改且不是无限循环（自 3.1.0）：`DBObject::DBUpdate`（自 3.1.0 N°4756）
40. 返回 `$this->m_iKey`
41. `$this->SetWarningsAsSessionMessages('update')`
42. `finally`：如果 `static::IsCrudStackEmpty()`
    - `\cmdbAbstractObject::FireEventDbLinksChangedForAllObjects` - `EVENT_DB_LINKS_CHANGED`（自 3.1.0 N°5906）
43. 返回 `$res`

## DBDelete（删除对象）

1. `cmdbAbstractObject::DBDelete`
2. `cmdbAbstractObject::DBDeleteTracked_Internal`
3. 搜索 `iApplicationObjectExtension` 实现
    - `iApplicationObjectExtension::OnDBDelete`
4. `CMDBObject::DBDeleteTracked_Internal`
5. `DBObject::DBDelete`
6. `DBObject::MakeDeletionPlan`
7. `DeletionPlan::AddToDelete`：将当前对象添加到待删除列表
8. `EventService::FireEvent(EVENT_DB_CHECK_TO_DELETE, ['deletion_plan' => $oDeletionPlan])`（自 3.1.0 N°4756）
9. `cmdbAbstractObject::DoCheckToDelete`
10. `DBObject::DoCheckToDelete`（@internal，但具有 DeletionPlan 参数）
11. 如果 `$this->InSyncScope()` 则执行某些操作
12. `iApplicationObjectExtension::OnCheckToDelete`（可覆盖的钩子，但无法访问 DeletionPlan 实例）
13. `UserRights::IsActionAllowed`
14. `DeletionPlan::SetDeletionIssues`
15. `DBObject::GetReferencingObjects`
16. 遍历 `$aDependentObjects`
    - `DeletionPlan::AddToUpdate`：如果 ext key 有 `is_null_allowed=true` 参数
    - `DBObject::MakeDeletionPlan`：否则
17. `DeletionPlan::ComputeResults`
18. 如果 `$oDeletionPlan->FoundStopper()`：抛出 `DeleteException`
19. 遍历 `$oDeletionPlan->ListDeletes()`
    - `DBObject::DBDeleteSingleObject`
20. `DBObject::SetReadOnly`：从此处起不允许 `DBObject::Set`（自 3.1.2 N°7118）
21. `EventService::FireEvent(EVENT_DB_ABOUT_TO_DELETE)`（自 3.1.2 N°7118）
22. `DBObject::OnDelete`
23. `$aParams = array('class_list' => MetaModel::EnumParentClasses($sClass, ENUM_PARENT_CLASSES_ALL))`
24. `SELECT TriggerOnObjectDelete AS t WHERE t.target_class IN (:class_list)`
    - 遍历查询结果：`Trigger::DoActivate`
25. `CMDBObject::RecordObjDeletion`
    - 删除 `CMDBChangeOp` 对象
    - `DBObject::RecordObjDeletion`
    - `\DBObject::RecordLinkSetListChange`
    - 创建并持久化新的 `CMDBChangeOpDelete`
26. 遍历 `MetaModel::ListAttributeDefs(get_class($this))`
    - 如果 `$oAttDef->IsHierarchicalKey()`：更新每个层次键的左右索引
    - 否则如果 `!$oAttDef->LoadFromDB()`：`AttributeCustomFields::DeleteValue`
    - `TemplateFieldsHandler::DeleteValues`
27. `DBObject::DBDelete`
28. `CMDBSource::Query('START TRANSACTION')`（自 2.7.0 N°679）
29. 遍历 `MetaModel::EnumParentClasses(get_class($this), ENUM_PARENT_CLASSES_ALL)`
    - `DBObject::DBDeleteSingleTable`
30. `CMDBSource::Query('COMMIT')`（异常时 ROLLBACK）
31. `cmdbAbstractObject::FireEventAfterDelete`
    - `\cmdbAbstractObject::NotifyAttachedObjectsOnLinkClassModification`（自 3.1.0 N°5906）
    - `EventService::FireEvent(EVENT_DB_AFTER_DELETE)`（自 3.1.0 N°6324）
32. `DBObject::AfterDelete`
33. 遍历 `$oDeletionPlan->ListUpdates()`
    - `DBObject::Set`：重置 ext key
    - `DBObject::DBUpdate`
34. `finally`：如果 `static::IsCrudStackEmpty()`
    - `\cmdbAbstractObject::FireEventDbLinksChangedForAllObjects` - `EVENT_DB_LINKS_CHANGED`（自 3.1.0 N°5906）

## ApplyStimulus（应用刺激）

没有重载，起始点在 DBObject 中。

1. `DBObject::ApplyStimulus`
2. `DBObject::EnumTransitions()`
3. `EventService::FireEvent(EVENT_ENUM_TRANSITIONS)`（自 3.1.2）
4. 如果刺激在当前状态无效果：返回 true
5. `DBObject::Set`：设置新状态
6. 遍历 `$aTransitionDef['actions']`
    - 如果 `is_string($actionHandler)`：`call_user_func($aActionCallSpec, $sStimulusCode)`（pref 2.1.0 模块：直接调用方法）
    - 否则遍历 `$aActionHandler['params']`
      - 根据参数类型设置 `$value`
      - `$bRet = call_user_func_array($aCallSpec, $aParams)`
      - 如果 `$bRet === false`：`IssueLog::Info` + `$bSuccess = false`
7. 如果 `$bSuccess`
    - 秒表：启动或停止
    - 如果 `!$bDoNotWrite`：`DBObject::DBWrite`
      - 如果 `$this->m_bIsInDB`：`DBObject::DBUpdate`
      - 否则：`DBObject::DBInsert`
8. 搜索当前类及其父类的所有 `TriggerOnStateLeave`
    - `Trigger::DoActivate`
9. 搜索当前类及其父类的所有 `TriggerOnStateEnter`
    - `Trigger::DoActivate`
10. 返回 `$bSuccess`

## DoCheckToWrite

1. `cmdbAbstractObject::DoCheckToWrite`：**警告**不为空，覆盖时不要忘记调用父类！
2. `\DBObject::DoCheckToWrite`
3. `DBObject::DoComputeValues`
4. 设置未初始化的 "null-not-allowed" 日期时间（和日期）
5. `DBObject::ComputeValues`
6. `DBObject::DoCheckUniqueness`（参见专门章节）
7. `DBObject::ListChanges`
8. 遍历 `$aChanges`
    - `DBObject::CheckValue`
    - `DBObject::CheckConsistency`
9. 如果 `DBObject::$m_bIsInDB && DBObject::InSyncScope && (count($aChanges) > 0)`
    - 为每个因 datasynchro 锁定（`OPT_ATT_SLAVE`）的属性在 `DBObject::$m_aCheckIssues` 中添加错误
10. 遍历 `iApplicationObjectExtension`
    - `iApplicationObjectExtension::OnCheckToWrite`
11. 如果 `!$this->bAllowWrite`
    - `UserRights::IsActionAllowedOnAttribute`：检查每个更改是否允许（如果不允许，将错误添加到 `DBObject::$m_aCheckIssues`）

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:sequence_crud>

2025/01/13 13:29 by127.0.0.1

版本：3_2_0/customization/sequence_crud.txt · Last modified: 2025/01/13 13:29 by 127.0.0.1
