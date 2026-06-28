---
title: "新扩展文件结构"
linkTitle: "新扩展文件结构"
date: 2025-06-27
weight: 10
description: >
  新扩展文件结构。
---

{{% pageinfo %}}
本文档介绍创建 iTop 扩展的推荐文件结构和编码规范。这些规范不是强制性的，但强烈建议遵循，以便他人理解扩展的工作原理。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:new_extension)。
{{% /pageinfo %}}

## 概述

这些是新扩展的推荐指南，绝对不是强制性的，但强烈建议遵循，因为这将帮助其他人理解扩展的工作原理。

## 文件夹结构

此结构由 Combodo 研发团队于 2019 年 5 月集体设计。

```
<extension-root>
   asset
      js
      css
      img
      lib
   bin
   dictionaries // iTop 3.0+
   doc
   [legacy]
   src
      Controller
      Helper
      Service
      <SomeService>
      Hook
      Model
   tests
      php-unit-tests
         integration-tests
         unitary-tests
         phpunit.xml
      ci_description.ini
   templates
   vendor
   [compatibilitybridge.php]
   composer.json
   index.php
   Jenkinsfile
   module.<module>.php
   datamodel.<extension>.xml
   [extension.xml]
   [license.<module>.xml]
```

## 文件与文件夹说明

| 文件夹/文件 | 必需 | 说明 |
|------------|------|------|
| `asset` | 否 | 扩展的公共资源（图像、样式表、JS 脚本、库等） |
| `bin` | 否 | 在 CLI 中运行的脚本/可执行文件 |
| `dictionaries` | 否 | 模块的字典文件（例如 `en.dict.<extension>.php`）。自 iTop 3.0.0 起可用，之前版本文件必须放在根文件夹中 |
| `doc` | 否 | 文档文件。可以是 README.md 的图像、markdown 文件等 |
| `legacy` | 否 | 仅当扩展需要兼容引入破坏性更改的 iTop 版本时 |
| `src` | 否 | PHP 文件。子文件夹应使用驼峰命名法并遵循文件的命名空间，以便自动加载器正常工作 |
| `src/Controller` | 否 | 使用 MVC 模式时的控制器类 |
| `src/Hook` | 否 | 实现/扩展 iTop API 的 PHP 类 |
| `src/Model` | 否 | 实体 PHP 类（来自数据模型或非数据模型） |
| `tests` | 否 | 所有类型测试的结构文件夹 |
| `tests/php-unit-tests` | 否 | 所有 PHPUnit 测试的结构文件夹 |
| `tests/php-unit-tests/integration-tests` | 否 | 集成测试文件 |
| `tests/php-unit-tests/unitary-tests` | 否 | 单元测试文件，应与 `/src` 文件夹的结构匹配 |
| `tests/php-unit-tests/phpunit.xml` | 否 | 要运行的测试套件 |
| `tests/ci_description.ini` | 否 | 描述 CI 运行时要使用的参数（默认参数的重载）的文件 |
| `templates` | 否 | 扩展使用的模板（HTML、JS 等） |
| `vendor` | 否 | 不要在此放置任何内容，它将自动由 composer 构建（第三方库和自动加载器） |
| `compatibilitybridge.php` | 否 | 仅当扩展需要兼容引入破坏性更改的 iTop 版本时。将在 `module.<extension>.php` 中加载，并负责根据 iTop 版本加载正确的文件 |
| `composer.json` | 否 | 放置扩展类命名空间和/或类映射；放置要包含的第三方库 |
| `index.php` | 否 | MVC 使用的端点 |
| `Jenkinsfile` | 否 | 在 CI 中启用扩展的文件 |
| `module.<extension>.php` | **是** | 扩展定义文件，包含其代码、版本、依赖项、安装程序等 |
| `datamodel.<extension>.xml` | 否 | 扩展的数据模型 XML 更改（参见下面关于相应 model.php 文件的说明） |
| `extension.xml` | 否 | 扩展的元数据（作者、兼容性、描述、URL 等。由 Designer、Hub 和 Setup 使用。将在构建期间由 Factory 生成） |
| `exclude.txt` | 否 | 包含要从扩展构建中排除的文件/文件夹列表。通常是 `doc/` 文件夹和 "README.md" 文件 |
| `README.md` | 否 | 对于非官方扩展，描述其功能、使用方法和与 iTop 的兼容性。当扩展成为官方扩展时将被移除，其文档将移至 wiki |
| `license.<module>.xml` | 否 | 许可证文件 |

注意：
- 添加一个空的 `model.<module>.php`！
- 在 `module.<module>.php` 的 'datamodel' 键中引用此文件

## 编码规范

### PHP

- 一个 PHP 文件应只包含**一个**类
- PHP 文件应使用 PSR-4 约定命名，即对于 "MyCMDBObject" 类，文件应为 "MyCMDBObject.php" 而不是 "mycmdbobject.class.inc.php"

## 自动加载器

不必通过在 `module.<extension>.php` 文件的 'datamodels' 部分包含它们来在每个 iTop 页面中加载 PHP 文件，我们可以使用自动加载器仅在需要时加载它们。

此自动加载器将作为 iTop 基础自动加载器的**补充**。

编辑 `composer.json` 文件以放置命名空间（和/或类映射）后，生成自动加载器并将其添加到 'datamodels' 部分：

```bash
cd <PATH_OF_THE_EXTENSION>
composer.phar dump-autoload -a
```

```php
...
    'datamodels' => array(
        // Module's autoloader
        'vendor/autoload.php',
        // Explicitly load APIs classes if any
        'src/Hook/MyConsoleUIExtension.php',
    ),
...
```

## 安全性

如果您希望文件可以在没有任何认证的情况下调用（在大多数情况下**不推荐**），您需要将文件添加到 `model.<module>.php` 文件的 `delegated_authentication_endpoints` 中。

```php
...
    'delegated_authentication_endpoints' => [
        'index.php',
        'open_access.php'
    ],
...
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:new_extension>

2026/04/13 17:01 by127.0.0.1

版本：3_2_0/customization/new_extension.txt · Last modified: 2026/04/13 17:01 by 127.0.0.1
