---
title: "使用 TLS 连接 MySQL"
linkTitle: "使用 TLS 连接 MySQL"
date: 2025-06-27
weight: 40
description: "如何配置 iTop 使用 TLS 加密连接到 MySQL 数据库。"
---

{{% pageinfo %}}
本文档介绍如何配置 iTop 使用 TLS 加密连接到 MySQL 数据库。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:php_and_mysql_tls)。
{{% /pageinfo %}}

## 在 iTop 中使用 TLS

如果 iTop 托管在与 MySQL 服务器不同的服务器上，并且使用了共享基础设施，那么您可能希望在应用程序和数据库之间使用加密。

一种方法是使用 MySQL 安全连接。请参阅官方文档：[MySQL 5.6 参考手册 :: 6.4 使用加密连接](https://dev.mysql.com/doc/refman/5.6/en/using-encrypted-connections.html)

自版本 2.5 起，iTop 允许使用以下参数：

- 启用加密：`db_tls.enabled`
- 证书颁发机构文件：`db_tls.ca`

在 iTop 中使用此类连接之前，您需要检查配置。在 phpinfo（调用 `setup/phpinfo.php`）中，您应该在 "mysqlnd" 部分看到以下内容：

- core SSL：supported
- extended SSL：supported

Combodo 还强烈建议使用以下脚本测试连接：

```php
<?php
ini_set ('error_reporting', E_ALL);
ini_set ('display_errors', '1');
error_reporting (E_ALL|E_STRICT);

assert_options(ASSERT_ACTIVE, true);
assert_options(ASSERT_WARNING, true);
assert_options(ASSERT_BAIL, true);

$sMySqlHost = 'mysqlserver'; //TODO
$iMySqlPort = 3306;
$sMySqlUser = 'user'; //TODO
$sMySqlPassword = 'password'; //TODO
$iMySqlFlag = MYSQLI_CLIENT_SSL_DONT_VERIFY_SERVER_CERT;
$sTlsKey = '/var/mysql/client-key.pem'; //TODO 修正为正确的值，如未使用则设为 null
$sTlsCert = '/var/mysql/client-cert.pem'; //TODO 修正为正确的值，如未使用则设为 null
$sTlsCa = '/var/mysql/ca.pem'; //TODO 修正为正确的值，如未使用则设为 null

assert(is_readable($sTlsKey), 'Can\'t open SSL Key file');
assert(is_readable($sTlsCert), 'Can\'t open SSL Cert file');
assert(is_readable($sTlsCa), 'Can\'t open SSL CA file');

echo "Trying to connect using :\n host=$sMySqlHost, user=$sMySqlUser, port=$iMySqlPort\n";
echo "TLS options :\n key=$sTlsKey\n cert=$sTlsCert\n ca=$sTlsCa\n";

$oMysqli = new mysqli();
$oMysqli->init();
$oMysqli->ssl_set($sTlsKey, $sTlsCert, $sTlsCa, NULL, NULL);
$oMysqli->real_connect($sMySqlHost, $sMySqlUser, $sMySqlPassword, null, $iMySqlPort, NULL, $iMySqlFlag);

if ($oMysqli->connect_errno)
{
        die ('Connect error (' . mysqli_connect_errno() . '): ' . mysqli_connect_error() . "\n");
} else {
        if (!IsOpenedDbConnectionUsingTls($oMysqli)) {
                $oMysqli->close();
                die ('The connection can be opened but is not TLS encrypted !');
        }

        echo "Successfully connected using TLS !\n";

        $sTlsCipherValue = GetMySqlVarValue($oMysqli, 'ssl_cipher');
        $sTlsVersionValue = GetMySqlVarValue($oMysqli, 'ssl_version');
        echo "TLS cipher=$sTlsCipherValue\n";
        echo "TLS version=$sTlsVersionValue\n";

        $oMysqli->close();
}

/**
 * <p>DB 连接可以在没有加密的情况下透明地打开（没有抛出错误），即使使用了 TLS 参数。<br>
 * 可以调用此方法来确保 DB 连接确实使用了 TLS。
 *
 * <p>我们使用此对象连接：{@link self::$m_oMysqli}
 *
 * @param \mysqli $oMysqli
 *
 * @return boolean true if the connection was really established using TLS
 * @throws \MySQLException
 *
 * @uses IsMySqlVarNonEmpty
 */
function IsOpenedDbConnectionUsingTls($oMysqli)
{
        $bNonEmptySslVersionVar = IsMySqlVarNonEmpty($oMysqli, 'ssl_version');
        $bNonEmptySslCipherVar = IsMySqlVarNonEmpty($oMysqli, 'ssl_cipher');

        return ($bNonEmptySslVersionVar && $bNonEmptySslCipherVar);
}

/**
 * @param \mysqli $oMysqli
 * @param string $sVarName
 *
 * @return bool
 * @throws \MySQLException
 *
 * @uses GetMySqlVarValue
 */
function IsMySqlVarNonEmpty($oMysqli, $sVarName)
{
        $sResult = GetMySqlVarValue($oMysqli, $sVarName);

        return (!empty($sResult));
}

/**
 * @param \mysqli $oMysqli
 * @param string $sVarName
 *
 * @return string
 * @throws \MySQLException
 *
 * @uses 'SHOW STATUS' queries
 */
function GetMySqlVarValue($oMysqli, $sVarName)
{
        $oResults = $oMysqli->query("SHOW SESSION STATUS LIKE '$sVarName'", 1);

        if ($oResults === false) {
                return false;
        }

        $aResults = $oResults->fetch_array(MYSQLI_NUM);
        $sResult = $aResults[1];

        return $sResult;
}
```

成功时，您应该看到：

```
Trying to connect using :
 host=192.168.10.70, user=sha256user, port=3306
TLS options :
 key=/var/www/html/client-key.pem
 cert=/var/www/html/client-cert.pem
 ca=/var/www/html/ca.pem
Successfully connected using TLS !
TLS cipher=DHE-RSA-AES256-SHA
```

## 故障排除

如果您收到关于 `--ssl` 或 `--ssl-mode` 的警告或错误，例如：

iTop >= 2.6.2 应该使用 MySQL >= 5.7.0 处理这些警告，如果您仍然遇到这些警告，或者在较低版本或其他 MySQL 供应商中遇到它们，您可以验证：

```sql
SELECT Version()
```

和

```sql
SELECT @@version
```

确保您收到的版本和 MySQL 供应商格式类似于：

```
10.3.15-MariaDB-log
```

这些信息将由 iTop 处理，以根据您的 MySQL 供应商/版本选择正确的参数，因此需要正确填写。

如果您在使用 mariadb mysqldump 命令时遇到以下错误，请检查您使用的 mysqldump 版本：

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:php_and_mysql_tls>

版本：3_2_0/install/php_and_mysql_tls.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
