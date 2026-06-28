---
title: "Wiki / 插入 XML 语法"
linkTitle: "Wiki / 插入 XML 语法"
date: 2025-06-27
weight: 10
description: >
  Wiki / 插入 XML 语法。
---

{{% pageinfo %}}
本文档介绍教程中使用的简化 XML 语法，以及如何将其扩展为符合 iTop XML 树结构的完整格式。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:insert-xml)。
{{% /pageinfo %}}

## 概述

本文档解释如何扩展教程中提供的 XML 代码片段，使其符合 iTop XML 树结构。

## 添加 XML 代码

### 简化语法

为了提高教程的可读性并突出需要更改的 XML 节点，周围的 XML 结构以简化的路径语法提供。

- 每个层级用 `/` 分隔
- `itop_design` 是唯一可能的顶层标签，有时在 wiki 语法中可能省略，但在 XML 文件中不要省略
- 末尾带 `s` 的标签通常是集合
- 在集合下，通常可以找到不带 `s` 的相同标签，并用 `id` 来区分节点
- `brick@toto` 表示 `<brick id="toto">`

以下是最短的可能语法示例，其中**只需修改一个节点**：

```xml
      <default _delta="redefine">tree</default>
```

我们不会在 XML 标签中逐个打开和关闭每个层级，而是只提供一个表示树结构的字符串，并将其放在代码块的标题中。

通常为了可读性会压缩得更少：

```xml
   <brick id="services">
       <browse_modes>
           <default _delta="redefine">tree</default>
       </browse_modes>
   </brick>
```

### 完整 XML 结构

以下是将上述代码块扩展为 iTop 所需的完整 XML 结构的方式：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design version="1.6">
  <module_designs>
    <module_design id="itop-portal">
      <bricks>
        <brick id="services">
          <browse_modes>
            <!-- 在此处插入代码块内容 -->
          </browse_modes>
        </brick>
      </bricks>
    </module_design>
  </module_designs>
</itop_design>
```

此外，这两行必须放在 XML 文件顶部：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design version="1.6">
```

`version="1.6"` 对应扩展所需的最低 iTop XML 版本。XML 版本自 iTop 2.0 起可用，至少到 iTop 2.6，可以从 iTop 版本猜测，将第一个数字减 1。

- 例如：所有 iTop 2.6.x 版本使用 XML 版本 1.6
- 如果您使用 iTop 2.5 中添加的 XML 标签，则 XML 版本不要低于 1.5

### 测试

将简化的 XML 扩展为完整结构后，将其复制到扩展的 `datamodel.my-extension.xml` 文件中（my-extension 是您的真实扩展名称），然后运行安装程序或工具包查看结果。

## 添加 PHP 代码

插入方法只能在 2 个位置进行：类中或模块中。

- 对于类，我们只在代码块标题中提供需要声明方法的类：`class:UserRequest`
- 对于模块，没有特定的语法

### 在现有类上的方法

这部分解释如何在类上定义/覆盖 PHP 方法。

- 多个教程会告诉您在类上编写 PHP 方法以实现 iTop 中的新行为
- 它们甚至可能提供确切的 PHP 代码片段
- 但它们不会解释如何将 PHP 代码插入 iTop XML 结构
- 这种技术独立于方法本身，正是我们要解释的
- 为了不那么抽象，我们使用一个真实的示例

#### 简化语法

在代码块标题中，您会找到需要声明方法的类。例如：`class:UserRequest`

```php
public function IncrementCounter($sAttCode, $iIncrement=1)
{
   // 防御性编程，确保字段代码在当前类上有效       
   if (MetaModel::IsValidAttCode(get_class($this), $sAttCode))
   {
       $iNew = $this->Get($sAttCode) + $iIncrement;
       $this->Set($sAttCode, $iNew);
   }
   return true;
}         
```

PHP 代码必须先扩展，然后才能粘贴到 `datamodel.my-extension.xml` 文件中。

#### 完整 XML 代码

以下是其扩展方式：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design version="1.3">
  <classes>
    <!-- 类名在简化语法框的标题中 -->
    <class id="UserRequest" _delta="must_exist">
      <methods>
        <!-- 任何 'id' 都可以，但如果与函数名相同则更容易记住 -->
        <method id="IncrementCounter" _delta="define">
          <static>false</static>
          <access>public</access>
          <!-- comment 是可选的 -->
          <comment><![CDATA[
/**
 * $sAttCode 应该是 UserRequest 类中 Integer 或 Decimal 类型的有效字段代码
 * $iIncrement 必须是整数
 */
          ]]></comment>
          <code><![CDATA[
public function IncrementCounter($sAttCode, $iIncrement=1)
{
   // 防御性编程，确保字段代码在当前类上有效       
   if (MetaModel::IsValidAttCode(get_class($this), $sAttCode))
   {
       $iNew = $this->Get($sAttCode) + $iIncrement;
       $this->Set($sAttCode, $iNew);
   }
   return true;
}         
          ]]></code>
        </method>
      </methods>
    </class>
  </classes>
</itop_design>
```

解码方式的详细信息：

| 源 | 应翻译为... |
|------|-------------|
| `public function IncrementCounter()` | `<access>public</access>` |
| `protected function ...` | `<access>protected</access>` |
| `public function ...` | `<static>false</static>` |
| `public static function ...` | `<static>true</static>` |
| `public function IncrementCounter(` | `<method id="IncrementCounter">` |

#### 风险

当您定义某个 DBObject 可覆盖方法之一时，请注意它可能已经在标准 iTop 数据模型中完成。如果是这种情况，在安装/工具包编译时，由于您使用 `_delta="define"` 添加方法，如果它已经存在则会失败。在这种情况下，您可以执行 "redefine"，但随后需要镜像现有代码，否则将破坏 iTop 的当前行为。

#### ITSM Designer 特定要求

如果满足以下条件，则需要 `arguments` 标签：

- 您的扩展将加载到 ITSM Designer 中
- **且** 方法必须由转换上的操作调用

```xml
        <method id="IncrementCounter" _delta="define">
          < ... >
          <arguments>
            <argument id="1">
              <mandatory>true</mandatory>
              <type>attcode</type>
            </argument>
            <argument id="2">
              <mandatory>false</mandatory>
              <type>int</type>
            </argument>
          </arguments>
        </method>
```

## 在新 PHP 类中

最简单的方式是将此代码放入扩展的 `main.my-extension.php` 文件中。

但也可以放在 XML 结构中：

```xml
    <snippet id="ScheduledStart" _delta="define">
      <placement>module</placement>
      <module>itop-request-mgmt</module>
      <rank>200</rank>
      <content><![CDATA[
         /* 在此处输入包含类定义和方法的代码 */
      ]]></content>
    </snippet> 
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:insert-xml>

版本：3_2_0/customization/insert-xml.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
