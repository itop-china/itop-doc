---
title: "在 PHP 中添加 TagSet"
linkTitle: "在 PHP 中添加 TagSet"
date: 2025-06-27
weight: 10
description: >
  在 PHP 中添加 TagSet。
---

{{% pageinfo %}}
本文档介绍如何在 PHP 方法中向 TagSet 属性添加特定值。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-value-to-tagset)。
{{% /pageinfo %}}

## 概述

在 PHP 方法中向 TagSet 属性添加特定值。

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 熟悉仪表盘设计和 OQL

## 示例场景

假设有一个 Bug 类：

- 字符串字段 `version`（继承自 Sprint 的外部字段）
- TagSet `versions`（记录修复该 Bug 的产品版本）
- 默认情况下，在 Bug 解决时确保至少包含 Sprint 的 "version"

## 代码示例

```php
public function PrefillTransitionForm(&$aContextParam)
{
    switch ($aContextParam['stimulus']) {
        case 'ev_resolve':
            try {
                // 获取版本字符串
                $sVersion = $this->Get('version');
                // 获取 Bug 应修复的版本（ormTagSet 对象）
                $oVersions = $this->Get('versions');
                // 获取对应标签的 TagSetFieldData 代码
                $Tag = $oVersions->GetTagFromLabel($sVersion);
                // 若不存在则添加
                $oVersions->Add($Tag);
                // 设置回对象
                $this->Set('versions', $oVersions);
            } catch (Exception $e) {
                // 若标签不是有效值，GetTagFromLabel() 会抛出异常
                IssueLog::Warning($e);
            }
            break;
    }
}
```

## 注意事项

若标签不是 TagSet 中的有效值，将抛出异常：

```
CoreUnexpectedValue: 4.0.0 is not defined as a valid tag for Bug:versions in...
```

## 相关主题

- [在 PHP 中添加日志条目](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-log-entry)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-value-to-tagset>

版本：3_2_0/customization/add-value-to-tagset.txt · Last modified: 2025/08/04 15:33 by 127.0.0.1
