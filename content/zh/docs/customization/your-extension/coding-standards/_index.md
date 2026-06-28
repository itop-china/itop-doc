---
title: "iTop 编码标准"
linkTitle: "iTop 编码标准"
date: 2025-06-27
weight: 10
description: >
  iTop 编码标准。
---

{{% pageinfo %}}
本文档介绍 Combodo 的 iTop 编码规范（主要针对 PHP）。这些规范与 PSR-12 标准有很多共通之处，但也存在一些显著差异，请注意区分。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:coding_standards)。
{{% /pageinfo %}}

## 文件编码

- 源代码文件使用 UTF-8 编码（文件开头不含 BOM）。
- 换行符必须为 LF。
- PHP 文件必须使用长标签 `<?php` 开头，但不能包含 PHP 结束标签。这可以防止在文件末尾意外添加空白字符。

## 空白与缩进

缩进方式：

- **PHP 文件**：使用制表符（配置编辑器将制表符显示为 4 个字符宽度）
- **SCSS**：2 个空格
- **Twig**：4 个空格

`if/else`、`try/catch`、`while`、`switch`、匿名类的开括号必须位于行尾，闭括号必须位于主体后的下一行。类和函数的开括号保持在下一行。

示例：

```php
class NiceWebPage extends WebPage
{
    ...
 
    public function SetContentType($sContentType)
    {
        if ($sContentType == '') {
            // Do something
        } else {
            // Do something different
        }
    }
}
```

函数调用时，参数紧跟在函数名后的括号内：函数名与参数列表之间没有空格。每个参数列表中的逗号后跟一个空格。

示例：

```php
$sValue = Utils::ReadParam('param1', 'default_value');
```

二元运算符（`==`、`+`、`&&`）两侧有空格。

例外：连接运算符 `.` 两侧没有空格，因为这样可以保持代码更紧凑，且在使用等宽字体时不会降低可读性。

示例：

```php
if (isset($aPerson[$this->iPersonId][0]) && ($aPerson[$this->iPersonId][0] != "")) {
   if ($this->sSynchronizeOrganization == 'yes') {
       $sName = $aPerson[$this->iPersonId]['first_name'].' '.$aPerson[$this->iPersonId]['last_name'];
   }
}
```

## 字符串分隔符

可以使用任何您喜欢的分隔符，主要目标是保持代码可读性。

使用 heredoc/nowdoc 时，建议使用允许 JetBrains 语言注入的分隔符。

示例：

```php
$sHtml = '<a href="http://www.combodo.com">';
 
$sFooBarBaz = "{$foo}-{$bar} {$baz}";
 
$sJs = <<<JS
console.debug("this is some JS code");
console.debug("having the right delimiter keyword will help language injection !");
JS;
```

## 变量命名

变量、函数参数和对象属性使用**驼峰命名法**（即每个单词首字母大写，其余小写），并使用**前缀字母作为类型提示**：

| 前缀 | 类型 |
|------|------|
| `a` | 哈希或数组 |
| `i` | 整数 |
| `o` | PHP 对象 |
| `s` | 字符串 |
| `f` | 浮点数 |
| `r` 或 `h` | 资源句柄 |

示例：

```php
$iCount = 1;
$sText = 'This is a text';
$oPage = new WebPage('test');
$fRank = 1.25;
$hDir = opendir('/opt');
```

没有前缀的变量被认为是混合类型（可以是字符串、数组或对象）。

### 允许的例外

- 循环计数器使用的局部变量（如 `$i`、`$j`）可以没有前缀。
- 在涉及大量数值变量的数学计算中，可以省略数值变量的前缀（如 `$x`、`$y`、`$xMax`）。
- 由于历史原因，`WebPage` 类（及相关类）以及 `MetaModel` 内部某些部分使用不同的约定：变量全部小写，用下划线分隔单词。对象属性使用 `m_` 前缀。

### 数组键命名

数组键使用**蛇形命名法**（snake_case）。

示例：

```php
$aMyArray = [
   'value_raw' => $sMyValue,
   'input_id' => $iInputId,
];
```

请使用适当的 PHPDoc 语法记录键（见下文）。

### 配置参数命名

使用小写，单词之间用下划线分隔。

当多个配置参数与同一主题相关时，可以使用以点号结尾的前缀进行分组。

例如：`email_transport_smtp.host`

## 函数命名（PHP、JS）

函数和对象方法使用**驼峰命名法**。即使 PHP 对函数名不区分大小写，这也有助于区分项目中的函数和 PHP 内置函数（通常为小写）。函数名通常基于表示正在执行的动作的动词。

示例：

```php
function DisplayWelcomePopup(WebPage $oP)
{
    // Code goes here
}
```

## 类型提示

自 iTop 3.0.0 起（最低 PHP 7.1.3），可以使用 PHP 类型提示（在方法签名中添加类型），但：

- 仅在新代码中使用 PHP 类型提示，不要修改现有方法。
- 注意遵循最低 PHP 版本的能力（例如，联合类型仅在 PHP 8.0.0 起可用）。
- 在流式方法上，不要添加返回类型，否则会导致继承问题。

## 比较（== vs ===）

自 2022/12/22 起，严格比较（`===`）成为所有新开发的标准规则。

例外：

- 如果不确定比较数据的类型，则优先使用严格比较（`===`）并添加显式转换。
- 如果这不可能，软比较（`==`）可以被容忍，但前提是必须同时包含抑制 PHPStorm 警告的注释和解释为什么软比较是唯一方式的注释。

## 应避免的模式

### 使用 empty() 检查字符串是否为空

检查字符串是否为空时，不要使用 `empty()`，而应使用 `strlen() > 0`（或更好的 `\utils::IsNullOrEmptyString()`，如果您的代码面向 iTop 3.0.2+），因为在某些情况下变量可能包含 `"0"`，而 `empty("0")` 会将其评估为 true。

```php
$sFoo = '';
 
// 不要这样做
if (empty($sFoo)) {
  // Some stuff
}
 
// 应该这样做
// - iTop 2.7+
if (strlen($sFoo) === 0) {
  // Some stuff
}
// - iTop 3.0.2+
if (\utils::IsNullOrEmptyString($sFoo)) {
  // Some stuff
}
```

## PhpDoc

编写 PhpDoc 的规则在仓库本身中有描述：参见 `/.doc/README.md`。

### @since

我们还使用 `@since` 标签来指示类/属性/方法的引入或修改。这在**所有类、API 上都是强制性的**。

示例：

```php
/**
 * ...
 *
 * @since 2.5.2 2.6.0 new 'transaction_id' filter
 * @since 2.7.0 new 'element_identifier' filter
 * @since 3.0.0 new utils::ENUM_SANITIZATION_* const
 * @since 2.7.7, 3.0.2, 3.1.0 N°4899 - new 'url' filter
 */
protected static function Sanitize_Internal($value, $sSanitizationFilter)
```

### Bool VS boolean

请在 PHPDoc 中使用 `bool`，因为：

- `bool` 和 `boolean` 在 PHPDoc 中都有效。
- 只有 `bool` 在 PHP 中有效，`boolean` 会导致问题。

### 数组：psalm/phpstan 语法

示例：

```php
/**
 * ...
 * @return array<string, \CheckResult> full path as key, CheckResult error as value
 */
```

### 带命名键的数组：array Shapes

示例：

```php
      /** 
       * @param array{
       *     languageCode: string, 
       *     entries: array{
       *        code: string, 
       *        value: string
       *      }
       *    } $aDictData 
       */
      public static $aDictData;
```

## 字典条目

这是一个独立的主题，请参阅专门的 wiki 页面：[如何翻译](../../translations/)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:coding_standards>

版本：3_2_0/customization/coding_standards.txt · Last modified: 2026/01/28 10:40 by 127.0.0.1
