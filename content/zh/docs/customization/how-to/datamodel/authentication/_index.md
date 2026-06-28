---
title: "新的认证方式"
linkTitle: "新的认证方式"
date: 2025-06-27
weight: 10
description: >
  新的认证方式。
---

{{% pageinfo %}}
本文档介绍 iTop 2.7+ 的认证流程以及如何通过扩展添加新的认证方式。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:authentication)。
{{% /pageinfo %}}

## 概述

从 iTop 2.7.0 开始，添加新的认证方式变得更加容易。本文档介绍：

- iTop 2.7 的登录流程
- 扩展登录流程的新接口（API）
- 如何扩展认证流程

## 认证行为

iTop 2.7 的认证流程使用 FSM（有限状态机）。

### 通用算法

- 自动机从 `start` 状态开始
- 对每个状态调用所有相关插件
- 当所有插件都接受继续时，自动机进入下一个状态

### 登录状态

| 状态 | 说明 |
|------|------|
| start | 入口状态，首次调用或错误/注销后 |
| login mode detection | 检测使用哪个登录插件 |
| read credentials | 读取凭据，显示表单或重定向到外部认证系统 |
| check credentials | 验证凭据是否有效 |
| credentials ok | 验证凭据对应有效的 iTop 用户 |
| user ok | 额外用户检查，如双因素认证 |
| connected | 用户已连接 |
| error | 发生错误，下一个状态为 start |

### 主要变量

- `$_SESSION['login_state']` — 当前状态
- `$_SESSION['login_mode']` — 登录模式
- `$_SESSION['can_logoff']` — 是否允许注销

## 认证接口

### iLoginFSMExtension

低级插件接口，包含两个方法：

- `ListSupportedLoginModes()` — 返回支持的登录模式数组
- `LoginAction($sLoginState, &$iErrorCode)` — 每个状态调用

返回值：
- `LOGIN_FSM_RETURN_ERROR` — 发生错误
- `LOGIN_FSM_RETURN_OK` — 登录成功，流程终止
- `LOGIN_FSM_RETURN_IGNORE` — 继续到下一个插件或状态

### AbstractLoginFSMExtension

抽象类，实现 `iLoginFSMExtension` 并为每个状态提供回调函数：

- `OnStart(&$iErrorCode)`
- `OnModeDetection(&$iErrorCode)`
- `OnReadCredentials(&$iErrorCode)`
- `OnCheckCredentials(&$iErrorCode)`
- `OnCredentialsOK(&$iErrorCode)`
- `OnUsersOK(&$iErrorCode)`
- `OnConnected(&$iErrorCode)`
- `OnError(&$iErrorCode)`

### iLogoutExtension

用户注销时调用。

- `ListSupportedLoginModes()` — 返回支持的登录模式
- `LogoutAction()` — 用户注销时调用

## 扩展认证流程

要添加新的认证方式：

1. 提供扩展 `AbstractLoginFSMExtension`（推荐）或实现 `iLoginFSMExtension` 的 PHP 类
2. 可选：提供实现 `iLogoutExtension` 的 PHP 类
3. 在 `allowed_login_types` 配置中注册新模式

### 登录 API

```php
// 验证凭据对应有效用户
public static function LoginWebPage::CheckUser($sAuthUser, $sAuthPassword='', $sAuthentication='external')

// 登录成功时存储用户信息到会话
public static function LoginWebPage::OnLoginSuccess($sAuthUser, $sAuthentication, $sLoginMode)

// 检查已登录用户是否仍然有效
public static function LoginWebPage::CheckLoggedUser(&$iErrorCode)
```

### 用户预配

在 `AbstractLoginFSMExtension::OnCheckCredentials()` 中创建用户和人员：

```php
private function DoUserProvisioning($sLogin, $sEmail, $sFirstName, $sLastName, $sOrganization, $aProfiles)
{
    if (!Config::Get('synchronize_user')) {
        return;
    }
    try {
        if (LoginWebPage::FindUser($sLogin, false)) {
            return; // 用户已存在
        }
        $oPerson = LoginWebPage::FindPerson($sEmail);
        if ($oPerson == null) {
            if (!Config::Get('synchronize_contact')) {
                return;
            }
            $oPerson = LoginWebPage::ProvisionPerson($sFirstName, $sLastName, $sEmail, $sOrganization);
        }
        LoginWebPage::ProvisionUser($sLogin, $oPerson, $aProfiles);
    } catch (Exception $e) {
        IssueLog::Error($e->getMessage());
    }
}
```

### 示例：CAS 认证

`authent-cas` 模块实现 CAS 认证，包含 `CASLoginExtension` 类：

- `ListSupportedLoginModes()` — 返回 `['cas']`
- `OnReadCredentials()` — 重定向到 CAS 服务器认证
- `OnCheckCredentials()` — 检查凭据并预配用户
- `OnCredentialsOK()` — 验证 iTop 用户有效性
- `OnConnected()` — 检查用户仍然有效
- `LogoutAction()` — 同时从 CAS 服务器注销

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:authentication>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/authentication.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
