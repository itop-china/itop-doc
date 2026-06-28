---
title: "隐藏对象历史"
linkTitle: "隐藏对象历史"
date: 2025-06-27
weight: 10
description: >
  对特定用户隐藏活动面板中的历史记录。
---

{{% pageinfo %}}
本文档介绍如何对特定角色的用户隐藏对象历史记录。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-history)。
{{% /pageinfo %}}

## 概述

本示例为具有 "Support Agent" 角色的用户隐藏对象的活动面板中的历史记录。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 注意事项

- 该方案在客户端隐藏历史记录，安全性不完全
- 可以通过 JS 代码从 DOM 中完全移除信息，但高级用户仍可在浏览器中设置断点阻止 JS 执行并查看历史
- 允许查看历史记录的角色列表可以放入模块参数中，便于后续修改

## 实现

通过实现 `iBackofficeStyleExtension` 接口，根据当前用户角色动态返回 CSS：

```xml
<snippets>
  <snippet id="hide_history_entries" _delta="define">
    <placement>core</placement>
    <rank>0</rank>
    <content><![CDATA[
  class HideHistoryEntries implements iBackofficeStyleExtension
  {
    public function GetStyle(): string
    {
      // 检查当前用户是否具有需要隐藏历史记录的角色
      $aCurrentUserProfiles = \UserRights::ListProfiles();
      $aProfilesToHideEntriesFor = ['Support Agent'];
      foreach ($aCurrentUserProfiles as $sCurrentUserProfile) {
        if (in_array($sCurrentUserProfile, $aProfilesToHideEntriesFor)) {
          // 强制隐藏编辑记录
          return <<<CSS
  .ibo-activity-entry.ibo-edits-entry {
    display: none !important;
  }
  CSS;
        }
      }

      // 当前用户没有受限角色，保持默认样式
      return '';
    }
  }
    ]]></content>
  </snippet>
</snippets>
```

## 自定义角色

修改 `$aProfilesToHideEntriesFor` 数组中的角色名称，即可控制对哪些用户隐藏历史记录：

```php
$aProfilesToHideEntriesFor = ['Support Agent', 'Portal user'];
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-history)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:hide-history>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/hide-history.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
