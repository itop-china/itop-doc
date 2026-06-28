---
title: "复制 n:n 对象"
linkTitle: "复制 n:n 对象"
date: 2025-06-27
weight: 10
description: >
  复制 n:n 对象。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中使用对象复制器扩展复制 n:n 关系，例如从 FunctionalCI 创建工单时自动复制关联的联系人。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:object-copier-linkedset)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 目标

丰富 [User actions configurator](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 扩展，以复制关系。

**示例**：从 FunctionalCI 创建工单时，检索链接到该 FunctionalCI 的联系人，并自动将其链接到工单。

```php
public function CopyContactsFromFunctionalCI($oSource)
{
   // 此方法应从 FunctionalCI 调用
   $sSourceClass = get_class($oSource);
   if ($sSourceClass != 'FunctionalCI')
   {
        throw new Exception("Wrong source class '$sSourceClass' : 
        CopyContactsFromFunctionalCI method should be called by a user action on a FunctionalCI!");
   }
   // 此方法被调用两次：
   //   创建表单显示时：'????'
   //   保存时：'apply_new'
   // 仅在一个情况下复制链接，避免链接重复
   $sOperation= utils::ReadPostedParam('operation');
   if ($sOperation == 'apply_new')
   {
        return;
   }
   // 获取相关对象列表
   $oSetSrc = new CMDBObjectSet(DBObjectSearch::FromOQL("
        SELECT Contact AS c
        JOIN lnkContactToFunctionalCI AS l1 ON l1.contact_id = c.id
        WHERE l.functionalci_id = :id"), array(), array('id'=>$oSource->GetKey()));
   // 更简单的方案：$oSetSrc = $oSource->Get('contacts_list');

   $oSetDst = $this->Get('contacts_list');
   while ($oSrc = $oSetSrc->Fetch())
   {
        $oLnkDst = MetaModel::NewObject('lnkContactToTicket');
        $oLnkDst->Set('contact_id', $oSrc->GetKey());
        $oSetDst->AddItem($oLnkDst);
    }
    $this->Set('contacts_list', $oSetDst);
}
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:object-copier-linkedset>

版本：3_2_0/customization/object-copier-linkedset.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
