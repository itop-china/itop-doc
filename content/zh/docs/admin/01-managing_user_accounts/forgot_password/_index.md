---
title: "忘记密码"
linkTitle: "管理：忘记密码"
date: 2025-06-26
weight: 11
description: >
  <br> ➡️ 最终用户自助重置 iTop 密码
---

{{% pageinfo %}}

iTop 允许最终用户自助重置密码，无需打扰管理员。此功能默认启用（iTop 2.0.2+）。

{{% /pageinfo %}}

## 工作流程

1. 登录页面底部点击链接 → 输入登录名
2. iTop 搜索账号 → 发送重置邮件
3. 用户点击邮件链接 → 获取密码重置表单（不需要旧密码）
4. 设置新密码（须满足[密码复杂度策略](../password-policy/)）

![登录页面](https://www.itophub.io/wiki/media?media=3_2_0:admin:forgot_password_1.png)

![更改密码](https://www.itophub.io/wiki/media?media=3_2_0:admin:forgot_password_5.png)

## 安全注意事项

- 发送给用户的链接为一次性使用链接
- 如果用户多次尝试重置密码，只有最新链接有效

## 配置

由于该功能依赖发送邮件，首先必须确保 iTop 能够发送邮件。使用页面 `/setup/email.test.php` 检查邮件功能是否正常。邮件配置请参考[邮件配置](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)。

注意：此类邮件同步发送，即使邮件配置为异步发送。

此外，该功能还依赖账号数据：

- 用户必须是 iTop 用户类型（对 LDAP 用户无效）
- 用户账号必须关联一个联系人
- 联系人必须配置有效的电子邮件地址

如果没有任何用户需要此功能，可以在 iTop 配置文件中设置 `forgot_password` 参数为 `false` 来禁用它。禁用时，登录页面上的超链接将消失。

## 前提条件

1. 配置中启用忘记密码功能（默认启用）
2. 用户账号关联电子邮件地址
3. 已配置邮件发送功能

## 错误处理

如果某个用户不满足使用此功能的条件，该功能将不可用。以下是失败尝试的截图示例：

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:forgot_password>

Last modified: 2025/03/10 10:24 by127.0.0.1

版本：3_2_0/admin/forgot_password.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
