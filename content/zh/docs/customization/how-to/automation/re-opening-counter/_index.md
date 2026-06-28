---
title: "重开计数器"
linkTitle: "重开计数器"
date: 2025-06-27
weight: 10
description: >
  重开计数器。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中统计用户请求被重开的次数。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter)。
{{% /pageinfo %}}

## 目标

统计用户请求被重开的次数。需要完成：

- 向 `UserRequest` 添加计数器字段
- 停用历史追踪（可选）
- 修改 `UserRequest` 生命周期，在从 `resolved` 到 `assigned` 的转换时调用方法
- 修改展示以显示计数器
- 添加计数器字段的标签

## 使用 ITSM Designer（仅限 Combodo 客户）

### 添加字段

1. 进入 `UserRequest` 类，Schema 标签
2. 创建新字段：
   - 字段代码：`reopen_counter`（仅小写字母，无空格、破折号或其他非字母字符）
   - 类型：Number (Integer)
   - 定义标签
   - 停用历史追踪（可选）

### 修改生命周期

1. 进入 Lifecycle 标签
2. 在图中选择从 `resolved` 到 `assigned` 的转换
3. 在右侧面板，点击动作列表底部按钮
4. 在对话框中：
   - 选择方法 `AddValue`
   - 在 Target field 中选择 `reopen_counter`
   - 在 Value 中输入 1

### 修改展示

进入 Presentation 标签，将 `reopen_counter` 添加到 Console 中 `UserRequest` 的详情中。

## 使用 iTop 扩展

### 添加计数器字段

```xml
<classes>
  <class id="UserRequest" _delta="must_exist">
    <fields>
      <field id="reopen_count" xsi:type="AttributeInteger" _delta="define">
        <sql>reopen_count</sql>
        <default_value>0</default_value>
        <is_null_allowed>true</is_null_allowed>
      </field>
    </fields>
  </class>
</classes>
```

### 停用历史追踪

如果认为记录 `reopen_count` 计数器的每次变更在历史中无用，可以添加 `<tracking_level>none</tracking_level>` 到字段定义中。

```xml
<field id="reopen_count">
  <tracking_level>none</tracking_level>
</field>
```

适用场景：

- 不断变化的值，由外部来源控制
- 计算计数器，其修改日期可能无用

### 在转换时调用方法

每次工单从 `resolved` 移动到 `assigned` 状态时增加计数器：

```xml
<state id="resolved">
  <transitions>
    <transition id="ev_reopen">
      <actions _delta="redefine">
        <action>
          <verb>AddValue</verb>
          <params>
            <param xsi:type="attcode">reopen_count</param>
            <param xsi:type="int">1</param>
          </params>
        </action>
      </actions>
    </transition>
  </transitions>
</state>
```

### 声明 PHP 方法

如果所需方法不在可用方法中，可以创建自己的方法：

```php
public function MyLifecycleMethod($sAttCode, $iIncrement=1)
{
   if (MetaModel::IsValidAttCode(get_class($this), $sAttCode)
   && is_numeric($iIncrement) 
   && (MetaModel::GetAttributeDef(get_class($this),$sAttCode) instanceof AttributeInteger))
   {
       $iNew = $this->Get($sAttCode) + $iIncrement;
       $this->Set($sAttCode, $iNew);
   }
   return true;
}
```

PHP 方法需要嵌入在 XML 结构中。

### 添加计数器到展示

将 `reopen_count` 添加到 `UserRequest` 详情页的第 3 列，`SLA report` 字段集中：

```xml
<class id="UserRequest" _delta="must_exist">
  <presentation>
    <details>
      <items>
        <item id="col:col3">
          <items>
            <item id="fieldset:Ticket:SLA">
              <items>
                <item id="reopen_count" _delta="define">
                  <rank>80</rank>
                </item>
              </items>
            </item>
          </items>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

### 添加计数器标签

```xml
<entry id="Class:UserRequest/Attribute:reopen_count" _delta="define">Reopening counter</entry>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter>

版本：3_2_0/customization/add-counter.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
