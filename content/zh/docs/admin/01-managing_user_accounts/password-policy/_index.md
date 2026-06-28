---
title: "密码复杂度策略"
linkTitle: "管理：密码复杂度策略"
date: 2025-06-26
weight: 12
description: >
  <br> ➡️ 配置 iTop 用户密码的复杂度要求
---

{{% pageinfo %}}

管理员可配置密码复杂度策略，确保用户使用安全的密码。

{{% /pageinfo %}}

## 默认策略

创建新的本地用户账号或更改本地用户密码时，iTop 会应用密码策略，通过正则表达式检查密码复杂度。

默认情况下，密码必须满足：

- 至少包含一个小写字母
- 至少包含一个大写字母
- 至少包含一个数字
- 至少包含一个特殊字符
- 长度超过 8 个字符

其他注意事项：

- 现有密码不受影响
- 安装期间创建的 admin 账号不受影响
- 所有更改密码的方式均受影响，但 CSV 导入和数据同步除外（已知限制）
- 管理员无法绕过策略，但可以修改策略配置

## 配置

默认设置不会显式出现在配置文件中，但格式如下：

```php
$MyModuleSettings = array(
   'authent-local' => array (
      'password_validation.pattern' => '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$',
   ),
);
```

### 禁用策略

如需禁用密码模式匹配策略，将正则表达式设为空字符串：

```php
$MyModuleSettings = array(
    'authent-local' => array(
        'password_validation.pattern' => '',
    ),
);
```

### 自定义策略

如需应用自己的策略，只需编写相应的正则表达式。建议使用 [regex101.com](https://regex101.com/) 测试正则表达式。

例如，强制密码长度在 6 到 15 个字符之间：

```php
$MyModuleSettings = array(
    'authent-local' => array(
        'password_validation.pattern' => '.{6,15}', 
        'password_validation.message' => array(
            'FR FR' => 'Le mot de passe doit faire en 6 et 15 caractères de long',
            'EN US' => 'Password length must be between 6 and 15 characters',
        ),
    ),
);
```

设置密码验证提示信息时，可以使用翻译键 `Error:UserLocalPasswordValidator:UserPasswordPolicyRegex/ValidationFailed`，或使用配置键 `password_validation.message`：

- 配置键优先级高于翻译键
- 可以是字符串或按语言分类的数组
- 如果使用数组，`EN US` 条目将作为用户语言未找到时的回退

### 其他策略

可以通过扩展引入[其他密码策略](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)。

## 密码过期

LocalUser 类新增了两个原生字段：`expiration` 和 `password_renewed_date`。

- `password_renewed_date` 在密码更改时自动填充
- `expiration` 标志允许定义过期规则

如需实现密码过期策略，请参考[相关指南](https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:password-policy>

Last modified: 2025/03/10 10:24 by127.0.0.1

版本：3_2_0/admin/password-policy.txt · Last modified: 2025/03/10 10:24 by 127.0.0.1
