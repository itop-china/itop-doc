---
title: "在 PHP 中添加日志条目"
linkTitle: "在 PHP 中添加日志条目"
date: 2025-06-27
weight: 10
description: >
  在 PHP 中添加日志条目。
---

{{% pageinfo %}}
本文档介绍如何在 PHP 方法中向 Caselog 属性添加日志条目。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-log-entry)。
{{% /pageinfo %}}

## 概述

在 PHP 方法中向 Caselog 属性添加特定日志条目。

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 熟悉仪表盘设计和 OQL

## 实现方法

- `Get()` 在 AttributeCaselog 上返回一个 `ormCaselog` 对象
- 使用 `ormCaselog` 的公共方法 `AddLogEntry()`
- 将修改后的日志设置回当前对象
- 使用 `$this->DBUpdate()` 确保持久化

## 代码示例

```php
public function PrefillTransitionForm(&$aContextParam)
{
    switch ($aContextParam['stimulus']) {
        case 'ev_resolve':
            // 获取日志，返回的是 ormCaselog 对象
            $oLog = $this->Get('public_log');
            // 添加日志条目：文本、创建者标签、可选的用户 ID
            $oLog->AddLogEntry(
                'The text to add to the log<br>With html tag if needed',
                'A text description of the User who added this entry',
                :current_user_id
            );
            // 将修改后的日志设置回当前对象
            $this->Set('public_log', $oLog);
            break;
    }
}
```

## 相关主题

- [在 PHP 中添加 TagSet](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-value-to-tagset)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-log-entry>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/add-log-entry.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
