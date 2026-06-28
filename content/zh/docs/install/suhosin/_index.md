---
title: "iTop 与 Suhosin"
linkTitle: "iTop 与 Suhosin"
date: 2025-06-27
weight: 57
description: "介绍 Suhosin 安全扩展对 iTop 的影响，以及需要调整的相关配置参数和已知问题。"
---

{{% pageinfo %}}
本文档介绍 Suhosin 安全扩展与 iTop 的兼容性问题及配置建议。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:suhosin)。
{{% /pageinfo %}}

[Suhosin](http://www.hardened-php.net/) 是一个额外的安全层，在 PHP 之上执行多项安全检查。如果你的 Web 服务器不暴露在公共互联网上，且你不计划向数百万并发用户交付 iTop 应用，可以考虑适当放宽某些 Suhosin 限制，以换取更多功能。

以下是已知问题及相关 Suhosin 配置参数：

| 参数 | 默认值 | 症状 | 建议修复方案 |
|------|--------|------|--------------|
| `suhosin.post.max_vars` | 1000 | 编辑包含超过 300 个相关 CI 的工单时失败。无法一次性删除/修改超过 997 个对象。 | 在 Suhosin 配置中提高该限制 |
| `suhosin.get.max_value_length` | < 1024 | 不可预测的影响。iTop 在安装时会检测到此问题。 | 在 Suhosin 配置中提高该限制 |

更多关于 Suhosin 的信息：[http://www.hardened-php.net/](http://www.hardened-php.net/)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:suhosin>

版本：3_2_0/install/suhosin.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
