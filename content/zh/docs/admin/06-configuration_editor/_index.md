---
title: "通用配置"
linkTitle: "配置：通用配置"
date: 2025-06-26
weight: 20
description: >
  <br> ➡️ 在线编辑 iTop 配置文件
---

{{% pageinfo %}}

新手应阅读配置概述。

{{% /pageinfo %}}

## 在线编辑器

此工具**仅对 iTop 管理员可用**。它是编辑配置文件 `<itop-root>/conf/production/config-itop` 的快捷方式。此工具还通过确保如果发现任何语法错误，则不会保存更改来保护过程。

可禁用编辑器：

```php
'itop-config' => array(
    'config_editor' => 'disabled',
)
```

编辑器可从"管理工具 / 配置"菜单访问：

它有语法高亮显示和一些功能。

以下是可能的操作：

- 使用 Ctrl+F 查找
- 使用 Ctrl+H 查找和替换
- 使用"应用"按钮或 Ctrl+S 快捷键保存
- "重置"按钮重新加载页面，并将配置恢复到其持久状态（丢弃未持久化的更改）

如果发现语法错误，则无法保存，并在每个相关行上显示注释：

保存后，如果没有遇到语法错误，则会显示绿色横幅：

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:configuration_editor>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/admin/configuration_editor.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
