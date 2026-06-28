---
title: "实现密码过期"
linkTitle: "实现密码过期"
date: 2025-06-27
weight: 10
description: >
  实现密码过期。
---

{{% pageinfo %}}
本文档介绍如何实现密码过期功能。从 iTop 3.1.0 开始，此功能已内置在 Password Expiration Management 模块中。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:password-expiration)。
{{% /pageinfo %}}

## 概述

> **注意**：从 iTop 3.1.0 开始，此功能已内置在 [Password Expiration Management](https://www.itophub.io/wiki/page?id=3_2_0:customization:password-expiration) 模块中，无需再手动实现。

本教程描述如何强制现有用户更改密码以符合新添加的复杂性策略。管理员将所有用户的 `expiration` 标志设为 `expired`，用户登录时将被要求更改密码。

## 插入检查点

```php
class MyClass extends AbstractLoginFSMExtension
{
    public function ListSupportedLoginModes() { return array('form'); }

    protected function OnUsersOK(&$iErrorCode)
    {
        /* 在此处添加特定代码 */
        return LoginWebPage::LOGIN_FSM_CONTINUE;
    }
}
```

## 检查密码是否过期

```php
$oUser = UserRights::GetUserObject();
if ($oUser->Get('expiration') == 'expired')
{
   /* 添加更多代码 */
}
```

## 请求新密码

```php
public function DisplayChangePwdForm($bFailedLogin = false, $sIssue = null)
{
    $oTwigContext = new LoginTwigRenderer();
    $aVars = $oTwigContext->GetDefaultVars();
    $aVars['bFailedLogin'] = $bFailedLogin;
    $aVars['sIssue'] = $sIssue;
    $oTwigContext->Render($this, 'changepwdform.html.twig', $aVars);
}
```

模板 `iTop/templates/login/password/changepwdform.html.twig` 可复用，需移除 `old_pwd` 部分。同时有 `changepwdform.js.twig` 控制两次输入是否相等以及密码是否符合策略。

## 保存新密码

```php
$sNewPwd = utils::ReadPostedParam('new_pwd', '', 'raw_data');
$oUser->Set('password', $sNewPwd);
$oUser->Set('expiration', 'limited');
$oUser->DB_Update();
```

## 错误处理

```php
try
{
    if (!UserRights::ChangePassword($sOldPwd, $sNewPwd))
    {
        $oPage = self::NewLoginWebPage();
        $oPage->DisplayChangePwdForm(true);
        $oPage->output();
        exit;
    }
}
catch (CoreCannotSaveObjectException $e)
{
    $oPage = self::NewLoginWebPage();
    $oPage->DisplayChangePwdForm(true, $e->getIssue());
    $oPage->output();
    exit;
}
```

## 注意事项

当扩展自动化过期行为时，应修改 `UserLocal:password:expiration` 的翻译，以反映此行为。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:password-expiration>

版本：3_2_0/customization/password-expiration.txt · Last modified: 2025/07/03 12:43 by 127.0.0.1
