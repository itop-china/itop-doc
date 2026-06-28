---
title: "定义密码策略"
linkTitle: "定义密码策略"
date: 2025-06-27
weight: 10
description: >
  定义密码策略。
---

{{% pageinfo %}}
本文档介绍如何创建自定义密码策略验证器。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:password-policy)。
{{% /pageinfo %}}

## 概述

iTop 不内置复杂的密码策略，但可以通过扩展实现自定义验证器。

## 可能的策略

### 黑名单策略

检查用户密码是否不在弱密码列表中。实现简单，本教程以此为例。

### 密码不能与前密码相同

更复杂，因为：
- iTop 只存储密码哈希
- 盐值是随机的且难以提取

实现概要：
- 验证器需实现 `iApplicationObjectExtension::OnDBUpdate()` 和 `UserLocalPasswordValidator` 接口
- 将之前的密码哈希存储到专用类中
- 使用明文密码与哈希列表对比（不能比较两个哈希）
- 建议限制存储的哈希数量

## 实现验证器

创建实现 `UserLocalPasswordValidator` 接口的类：

```php
class MyCustomPasswordValidator implements UserLocalPasswordValidator
{
   // 您的代码...
}
```

验证时返回 `ValidatePassword` 实例：

- 密码有效：`new UserLocalPasswordValidity(true)`
- 密码无效：`new UserLocalPasswordValidity(false, $sMessage)`

`$sMessage` 必须是已翻译的消息，按约定使用格式：
`'Error:UserLocalPasswordValidator:<YourClassName>/ValidationFailed'`

## 示例：黑名单验证器

```php
class UserPasswordPolicyBlacklist implements UserLocalPasswordValidator
{
   public function __construct()
   {
   }

   public function ValidatePassword($proposedValue, UserLocal $oUserLocal, $config)
   {
      $sBlacklistFile = APPROOT.'data/passwordBlacklist.txt';

      $handle = @fopen($sBlacklistFile, "r");
      if (! $handle) {
         return new UserLocalPasswordValidity(
                false,
                'Unknown error : Failed to read the password blacklist.'
         );
      }
      try {
         while (($sBlackListPwd = fgets($handle, 4096)) !== false) {
            if (trim($sBlackListPwd) == trim($proposedValue))
            {
                $sMessage = Dict::S(
                   'Error:UserLocalPasswordValidator:UserPasswordPolicyBlacklist/ValidationFailed'
                );
                return new UserLocalPasswordValidity(
                   false,
                   $sMessage
                );
            }
         }
      }
      finally
      {
         fclose($handle);
      }
      return new UserLocalPasswordValidity(true);
   }
}
```

`data/passwordBlacklist.txt` 每行一个禁用密码。可使用 [SecLists](https://github.com/danielmiessler/SecLists/blob/master/Passwords/darkweb2017-top10000.txt) 中的前 10000 个常用密码。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:password-policy>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/password-policy.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
