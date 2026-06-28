---
title: "用户认证选项"
linkTitle: "用户认证选项"
date: 2025-06-27
weight: 10
description: "介绍 iTop 支持的各种用户认证机制，包括表单、Basic HTTP、CAS、外部认证、LDAP 等，以及如何配置 allowed_login_types 和集成外部认证系统。"
---

{{% pageinfo %}}
本文档介绍 iTop 的用户认证选项。为了与环境无缝集成，iTop 支持多种认证机制，可以在同一实例中按用户混合使用不同的认证类型。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:admin:user_authentication_options)。
{{% /pageinfo %}}

## 概述

为了与环境无缝集成，iTop 可以使用多种认证机制。iTop 的部分行为是在 Web 服务器层面定义的，但可以在每个用户的基础上混合使用不同的认证类型。

例如，如果您已经使用 LDAP 服务器对终端用户进行认证，那么可以方便地对终端用户使用 LDAP 认证，而对自动化流程和脚本使用的功能账号使用本地密码认证。

在本文档中，"外部认证" 是指用户认证完全在 iTop 之外进行（由 Web 服务器或某种 Web 服务器插件完成）。在这种情况下，iTop 应用程序只会接收经过 Web 服务器验证后的已认证用户的名称。如果您将 iTop 安装在 Apache 下，并使用 .htaccess 文件保护目录，就会发生这种情况。"外部认证" 也用于使用外部服务器的认证。在这种情况下，用户是 "外部" 的，但登录类型不是 "外部"。

部署 iTop 时，您必须决定应用程序是使用外部认证机制还是依赖 iTop 内部机制。如果应用程序使用 "内部" 认证，则同一安装可以共存多种认证类型（例如，您可以配置 iTop 使用基于表单的对话框，并混合使用 LDAP 和内部用户）。

如果认证不是 "外部" 的，那么 iTop 将主动参与认证过程。目前 iTop 支持三种内部认证类型：

- **本地（Local）**：基于加密存储在 iTop 数据库中的密码
- **应用令牌（Application Token）**：基于加密存储在 iTop 数据库中的令牌
- **LDAP**：通过与远程 LDAP 或 Active Directory 服务器交互

## 登录类型（控制台和门户）

为了认证用户，应用程序必须提示用户输入登录名和密码。iTop 提供了几种方法来处理与终端用户的登录对话：

| 登录类型 | 用途 | 限制 |
|----------|------|------|
| form | 基于表单的登录，最适合交互式登录。还提供注销/登出功能 | 不适合批处理/脚本使用，或在终端用户"隐藏" Web 浏览器的情况下使用（例如 Excel Web 查询） |
| basic | 基本 HTTP 认证。兼容所有支持此协议的应用程序（例如 wget、Excel Web 查询） | 没有注销/登出功能 |
| cas | 使用 JA-SIG CAS API 连接到 CAS 服务器进行认证 | 提供与其他 CAS 应用程序的透明单点登录，例如 LifeRay 门户 |
| url | 兼容任何应用程序。如果您想在 OpenOffice 中运行 Web 查询，则需要使用此方式 | 密码必须以明文形式写在页面地址中！ |
| token | 专为应用程序连接 iTop Web 服务而设计，更多详情见下文 | |
| external | 当认证由 Web 服务器本身在访问 iTop 应用程序之前完成时使用 | iTop 在 "外部" 用户连接时不执行任何认证。iTop 只是信任 Web 服务器传递的参数 |

### 更多详情

- **"基于表单的对话框"**：这是默认机制，向终端用户显示格式化的对话框。
- **"基本认证（Basic Authentication）"**：此机制依赖于 HTTP 协议的基本认证。在大多数 Web 浏览器中，这会显示为弹出窗口。命令行工具（如 wget）通常可以使用这种类型的认证。
- **"CAS"**：在此模式下，iTop 将认证委托给兼容 CAS 的服务器。
- **"URL"**：某些脚本或应用程序传递认证凭据的能力非常有限。在这种情况下，可以直接在 URL 中传递登录名和密码。请注意，出于安全考虑，此方法默认禁用，但可以通过配置启用。
- **"外部（External）"**：当认证已由 Web 服务器完成，并且 iTop 仅作为服务器端变量接收已认证用户的名称时，使用此登录类型。

## 登录类型（Web 服务）

为了访问 Web 服务（如 REST API），您必须在 HTTP 请求中提供认证数据。

根据当前 `allowed_login_types` 的配置，您需要选择以下认证方法之一：

| 允许的登录类型 | 如何构建 HTTP 请求 | curl 示例（Linux） |
|----------------|---------------------|---------------------|
| basic | 按照基本认证标准在 HTTP 头中提供用户名和密码 | `curl https://my.itop.com/.../api.php -F param1=xyz... --basic -u $NAME:$PASSWORD` |
| form | 必须 POST `auth_user` 和 `auth_pwd` | `curl https://my.itop.com/.../api.php -F param1=xyz... -F auth_user=$USER -F auth_pwd=$PASSWORD` |
| url | 必须在 URL 中传递 `auth_user` 和 `auth_pwd` | `curl https://my.itop.com/.../api.php -G -F param1=xyz... -F auth_user=$USER -F auth_pwd=$PASSWORD` |

```bash
curl https://my.itop.com/.../api.php -F param1=xyz... --basic -u $NAME:$PASSWORD
```

```bash
curl https://my.itop.com/.../api.php -F param1=xyz... -F auth_user=$USER -F auth_pwd=$PASSWORD
```

```bash
curl https://my.itop.com/.../api.php -G -F param1=xyz... -F auth_user=$USER -F auth_pwd=$PASSWORD
```

## 配置文件

iTop 配置文件中的参数 `allowed_login_types` 通过定义启用哪些登录方法以及应用程序尝试它们的顺序来决定 iTop 应用程序的行为。

此参数是一个文本字符串，其中值由管道符（`|`）分隔。字符串由 `form`、`basic`、`url`、`cas` 和 `external` 按所需顺序组合而成。

默认模式是列表中的第一个。它定义了未提供凭据时应用程序的行为。第一个 "模式" 必须是 `form`、`basic`、`cas` 或 `external` 之一。

此外，默认设置了密码策略，可以进行自定义。

## 'login_mode' 页面参数

连接到任何 iTop 网页时，可以通过在 URL 中指定参数 "login_mode" 来覆盖默认登录模式。

值是允许的模式之一：`form`、`basic`、`url`、`cas`、`external`。只要配置文件中启用了相应模式，就会使用此登录模式（仅针对此次连接，不会持久化）。如果值无效，则忽略它并使用配置文件中定义的第一个 "模式"。

例如，如果配置文件包含：

```php
allowed_login_types => 'form|basic|external',
```

并且页面使用参数 `?login_mode=basic` 调用，则此页面将使用基本认证机制。

如果页面使用参数 `?login_mode=url&auth_user=foo&auth_pwd=bar` 调用，由于 `url` 模式被排除在配置之外，将使用默认模式（在上例中为 `form`）。

## 示例

对于用户通过本地密码（存储在 iTop 数据库中）或 LDAP 服务器进行认证的 iTop 实例，并且用户使用 Web 浏览器（在应用程序中导航）或 Microsoft Excel（运行一些 Web 查询报告），可以在配置文件中设置以下值：

```php
'allowed_login_types' => 'form|basic',
```

连接到应用程序时，终端用户将使用常规的 iTop 登录表单提示输入登录名/密码。交互式使用应用程序时，终端用户可以使用 "注销菜单" 退出应用程序。

使用 Excel 时，可以通过在 Web 查询页面链接末尾添加 `&login_mode=basic`，让 Excel 在首次启动 Web 查询时提示用户输入登录名/密码。

在此配置中，还可以使用命令行工具（如 wget）让脚本从 iTop 检索数据，语法如下：

```bash
wget --http-user=<login> --http-password=<password> -O test.csv --auth-no-challenge "http://127.0.0.1/webservices/export.php?expression=SELECT%20Contact&format=csv"
```

或者使用以下替代命令：

```bash
wget --no-check-certificate --http-user=admin --http-password=admin2 -O test.csv "https://127.0.0.1/webservices/export.php?expression=SELECT%20Contact&format=csv&login_mode=basic"
```

在第一个命令行中，wget 会自动将凭据发送到 Web 服务器（使用基本认证机制），iTop 将检测到它们的存在。

在第二个命令中，wget 起初不会发送任何凭据，但告诉 iTop 首选的认证方式是 "basic"（即基本认证），wget 将从 Web 服务器收到 "401 未授权" 的响应，然后使用提供的凭据重试。

## 基本认证与 Apache CGI 模式

Apache Web 服务器中的 PHP 可以配置为以两种不同模式运行：作为模块或作为 CGI。

使用基本认证机制时，iTop 依赖 Web 服务器填充两个 PHP 内部变量：`$_SERVER['PHP_AUTH_USER']` 和 `$_SERVER['PHP_AUTH_PW']`。当 PHP 作为 Apache 模块运行时，当终端用户填写 "基本认证" 弹出对话框时，Web 服务器会自动填充这两个变量，但当 PHP 作为 CGI 运行时则不会。

在后一种情况下，可以使用简单的重写规则将认证信息传递给 PHP。

操作方法如下：

确保 Apache 中已激活重写引擎模块，否则 "重写规则" 将被忽略（如果不确定重写引擎是否已启用，可以注释掉下面示例中的 `<IfModule mod_rewrite.c>` 和 `</IfModule>` 两行。然后重启 Apache。如果在 Apache 日志文件中看到关于 "RewriteEngine on" 不被识别为有效配置指令的错误，则重写引擎未在您的 Web 服务器上配置）。

使用您喜欢的文本编辑器将以下代码写入 iTop Web 目录根目录的 `.htaccess` 文件中（确保运行 PHP/CGI 进程的用户有足够的权限读取此文件）。

```apache
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
</IfModule>
```

这将使 Apache 服务器使用凭据（base64 编码）填充服务器变量 `$_SERVER['HTTP_AUTHORIZATION']`。iTop 读取并解码此变量以提取登录名和密码。

## 与外部认证集成

iTop 可以使用外部认证机制（Apache 的 .htaccess 文件、CA SiteMinder 代理等），但用户的配置文件始终在 iTop 中定义，对于每个允许连接到 iTop 的用户，数据库中必须有一个 iTop "外部用户" 记录。

使用外部认证机制时，任何对 iTop 应用程序的请求都会被拦截，终端用户会在连接到 iTop 之前被要求输入认证信息。在这种情况下，iTop 不知道认证方式（登录名/密码、智能卡上存储的证书等）。对 iTop 来说唯一重要的信息是已认证用户的 "登录名"（即标识符）。

iTop 使用 PHP 应用程序的标准机制，默认读取 `$_SERVER['REMOTE_USER']` 服务器变量。如果在 iTop 数据库中找到具有相应登录名的 "外部用户" 记录，该用户将连接到 iTop。如果未找到匹配项，则将使用下一个认证机制，并提示用户使用 iTop 进行认证。

```php
'ext_auth_variable' => '$_SERVER[\'REMOTE_USER\']',
```

例如，如果您的单点登录系统使用 cookie 变量 `auth_user` 传递用户名，您可以使用：

```php
'ext_auth_variable' => '$_COOKIE[\'auth_user\']',
```

如果您的系统使用 HTTP 头，您也可以使用 PHP 函数 `getallheaders()`，它返回每个头变量的数组。

```php
'ext_auth_variable' => 'getallheaders()[\'SSL_DN_CERTIFICATE\']',
```

```php
'allowed_login_types' => 'external|form|basic',
```

由于认证完全委托，iTop 无法提供注销机制。对于使用外部方法认证的用户，注销菜单项将被隐藏。请注意，iTop 会话 cookie 将一直保留到浏览器窗口关闭！

由于 iTop 使用 PHP 变量 `$_SERVER['REMOTE_USER']` 来识别外部用户，如果您的 Web 服务器运行在 Windows 上，这就变得非常简单。使用 IIS 时，您可以依赖集成 Windows 认证；如果使用 Apache，可以使用 `sspi_auth_module`。两者都会将变量 `$_SERVER['REMOTE_USER']` 设置为已认证用户，格式为 "DOMAIN\\USERNAME"。只需以相同方式创建您的外部用户名称：DOMAIN\\USERNAME，iTop 认证对您的终端用户将是透明的。

### 使用 Apache .htpasswd 进行外部认证的示例配置

在下面的示例中，用户由存储在 `/var/www/` 的 `.htpasswd` 文件进行认证。

您可以使用以下命令为相应用户生成登录名和密码。

在激活外部认证之前，您必须至少创建一个与 `.htpasswd` 文件中定义的用户对应的外部用户，并赋予 "Administrator" 配置文件。

这非常重要，因为 iTop 的本地认证将被 Apache 服务器自动停用。

然后要在 iTop 中激活外部认证，您必须将外部选项设置为 iTop 配置文件中的第一个选项。

#### iTop 配置

```php
$MySettings = array(
        ...
        'allowed_login_types' => 'external|form|basic',
        ...
);
```

完成后，您只需按如下方式更改 Apache Web 服务器的配置：

#### Apache 配置文件

```apache
<Directory /var/www/>
        AuthUserFile /var/www/.htpasswd
        AuthName "Please identify yourself..."
        AuthType Basic
        require valid-user
</Directory>
```

#### 集成测试脚本

如果您使用第三方认证机制，可以将以下 PHP 脚本放在 iTop 的 `pages` 目录中的文件中。然后将您的 Web 浏览器指向它来测试您的外部认证是否将适当的信息传递给 iTop。

```php
<?php
//
// Script to test External Authentication
//
require_once('../approot.inc.php');
require_once(APPROOT.'core/config.class.inc.php');
require_once(APPROOT.'application/utils.inc.php');
require_once(APPROOT.'application/startup.inc.php');

echo "<h1>External Authentication: Integration Test Script</h1>";
try
{
        $aAllowedLoginTypes = utils::GetConfig()->GetAllowedLoginTypes();
        $sAllowedLoginTypes = implode('|', $aAllowedLoginTypes);
        echo "<p>allowed_login_types set to '$sAllowedLoginTypes'</p>\n";

        if (!in_array('external', $aAllowedLoginTypes))
        {
                    echo "<p>Check your iTop configuration file, ".
                           "<b>allowed_login_type</b> does not enable ".
                           "'external' authentication.</p>";
        }
        else
        {
                   echo "<p>Ok, external authentication is enabled by allowed_login_type.</p>";
                $sExternalAuthVariable = utils::GetConfig()->GetExternalAuthenticationVariable();
                echo "<p>External Authentication Variable: '$sExternalAuthVariable'</p>\n";
                if ($sExternalAuthVariable != '')
                {

                        $sEval = '$bVarIsSet = isset('.$sExternalAuthVariable.');';
                        eval($sEval);
                        if ($bVarIsSet)
                        {
                                $sEval = '$sAuthUser = '.$sExternalAuthVariable.';';
                                eval($sEval);
                                echo "<p>External Authentication Variable set to: ".
                                         "'$sAuthUser'</p>\n";
                                if ($sAuthUser != '')
                                {
                                        echo "<p><b>Ok, integration with external authentication ".
                                                 "successful !</b></p>\n";
                                }
                                else
                                {
                                        echo "<p>Empty user information passed by the web ".
                                                 "server.</p>\n";
                                }
                        }
                        else
                        {
                                echo "<p>External Authentication Variable <b>NOT</b> set.</p>\n";
                        }
                }
                else
                {
                        echo "<p>Check your iTop configuration file, <b>ext_auth_var</b> is set ".
                                 "to an empty string.</p>\n";
                }
        }
}
catch(ConfigException $e)
{
        echo "<p>iTop configuration file not found. Did you already install iTop ?</p>\n";
}
echo "<hr/>\n";
echo "<p>For information:</p>";
echo "<pre>\$_SERVER variable:\n";
print_r($_SERVER);
echo "\$_COOKIE variable:";
print_r($_COOKIE);
echo "\getallheaders() array of headers:";
print_r(getallheaders());
echo "</pre>\n";
?>
```

此脚本将返回服务器变量，如下所示：

这将帮助您识别定义已认证用户的变量。它必须返回与 `.htpasswd` 文件中存储的登录名以及相应 iTop 外部用户的登录名相同的值。

因此，您可能会遇到处理 Web 服务调用的困难，但命令行脚本可以正常工作（`cron.php` 或 `synchro_import.php`）。

## LDAP 认证配置

iTop 支持对远程 LDAP 服务器（或 Windows Active Directory 服务器）进行 LDAP 认证。两种类型的用户（在 iTop 本地数据库中存储账户的用户和具有 LDAP 账户的用户）可以在同一 iTop 实例中共存，按用户配置。

创建 LDAP 用户时，在提示 "新建用户账户" 时选择适当的类型：

#### 配置 iTop 连接到您的 LDAP 服务器

安装 iTop 后，打开文件 `config-itop.php` 并查找 `authent-ldap` 部分。它应如下所示：

```php
      'authent-ldap' => array (
               'host' => 'localhost',
                'port' => 389,
                'default_user' => '',
                'default_pwd' => '',
                'base_dn' => 'dc=mycompany,dc=com',
                'user_query' => '(&(uid=%1$s))',
                'options' => array (
                        17 => 3,
                        8 => 0,
                ),
                'debug' => false,
                'servers' => array(
                    'MySecond-LDAP-Server' => array(
                        'host' => 'server1',
                        'port' => 389,
                        'default_user' => '',
                        'default_pwd' => '',
                        'base_dn' => 'dc=mycompany,dc=com',
                        'user_query' => '(&(uid=%1$s))',
                        'options' => array (
                                17 => 3,
                                8 => 0,
                        ),
                        'debug' => false,
                     ),
                ),
        ),
```

其中：

- `host` 参数必须包含 LDAP 服务器的 IP 地址或主机名
- `port` 参数是用于连接 LDAP 的 TCP 端口号（LDAP 默认为 389）

如果您在 `host` 参数中指定了协议，则 `port` 的值将被 PHP 忽略（即 `ldap://` 意味着端口 389，`ldaps://` 意味着端口 636）。

要通过非标准端口使用 LDAPS 连接，您必须在 `host` 中同时指定协议和端口，并将 `port` 设为 `null`。

示例：

```php
  'authent-ldap' => array (
               'host' => 'ldaps://ldap.demo.com:6636',
               'port' => null,
               ...
        );
```

有关更多信息，请参阅 `ldap_connect`。

- `default_user` 和 `default_pwd` 标识一个具有足够权限的 LDAP 账户，可以以只读模式连接到您的 LDAP 服务器以搜索指定用户。在大多数系统上，匿名用户可以做到这一点，因此您可以将这两个字段留空。
- `base_dn` 定义用于搜索用户/登录名的 "根"。它可以是 "dc=mycompany,dc=com" 或 "ou=People,dc=mycompany,dc=com" 之类的内容。如果不确定，请咨询您的 LDAP 管理员。
- `user_query` 定义一个 LDAP 查询，用于搜索用户。您可以使用以下占位符编写任何有效的 LDAP 查询：
  - `%1$s`：用户的 iTop 登录名（即他/她在登录表单中输入的内容）
  - `%2$s`：用户的名字
  - `%3$s`：用户的姓氏
  - `%4$s`：用户的电子邮件
- `debug` 必须设置为 `true` 才能打开调试跟踪输出（在文件 `log/error.log` 中）。由于调试跟踪包含明文密码，建议在生产环境中关闭它们，但在配置阶段它们对排查应用程序行为很有用。
- `servers`：服务器配置数组，与默认配置相同。服务器的名称是在 LDAP 用户定义中引用的名称。（如果为空，则使用默认配置）。

#### 配置 iTop 连接到您的 CAS 服务器

在您的 iTop 服务器上安装 Central Authentication Service，以便能够连接到 CAS 服务器。

安装 iTop 后，打开文件 `config-itop.php` 并将 `cas` 添加到 `allowed_login_types`：

```php
//'cas' first, means login will be automatically redirected to CAS
allowed_login_types => 'cas|form|basic|external',
```

配置位于通用 iTop 参数中。

它应如下所示：

```php
      'authent-cas' => array (
                'cas_debug' => false,
                'cas_host' => '',
                'cas_port' => '',
                'cas_context' => '',
                'cas_version' => '',
                'service_base_url' => '',
        ),
```

所有可能的参数：

| 参数 | 类型 | 可见？ | 描述 | 默认值 |
|------|------|--------|------|--------|
| cas_context | string | 否 | CAS 上下文 | |
| cas_debug | bool | 否 | 激活 CAS 调试 | false |
| cas_default_profiles | string | 否 | 当从 CAS 未检索到配置文件时，创建新用户使用的 iTop 配置文件列表，以分号分隔 | Portal user |
| cas_host | string | 否 | CAS 主机名 | |
| cas_logout_redirect_service | string | 否 | 使用 CAS 注销时使用的重定向服务（URL） | |
| cas_memberof | string | 否 | 用户必须是其成员的组名列表，以分号分隔（仅适用于 SAML，例如 cas_version => "S1"） | |
| cas_memberof_attribute_name | string | 否 | 2.7.0 新增：CAS 服务器上 memberOf 属性的名称 | memberOf |
| cas_port | integer | 否 | CAS 服务器使用的端口 | 443 |
| cas_profile_pattern | string | 否 | 从 LDAP/CAS 组名中提取 iTop 配置文件名称的正则表达式模式 | `/^cn=([^,]+),/` |
| cas_server_ca_cert_path | string | 否 | 用于验证 CAS 服务器证书的 CA 证书路径 | |
| cas_update_profiles | bool | 否 | 是否从 CAS 信息更新现有用户的配置文件 | false |
| cas_user_synchro | bool | 否 | 是否与 CAS/LDAP 同步用户 | false |
| cas_version | string | 否 | 要使用的 CAS 协议版本："1.0"（CAS v1）、"2.0"（CAS v2）或 "S1"（SAML V1） | 2.0 |
| service_base_url | string | 否 | iTop 服务器 URL。iTop 2.7.8 及 3.0.2 之后新增 | |

工作配置示例：

```php
      'authent-cas' => array (
                'cas_context' => '/cas',
                'cas_debug' => true,
                'cas_host' => 'cas-server.combodo.net',
                'cas_memberof' => 'Configuration Manager',
                'cas_memberof_attribute_name' => 'businessCategory',
                'cas_port' => 8443,
                'cas_version' => 'S1',
                'cas_user_synchro' => true,
                'service_base_url' => 'https://my.itop.server.net',
        ),
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:user_authentication_options>

版本：3_2_0/admin/user_authentication_options.txt · Last modified: 2025/01/02 12:38 by 127.0.0.1
