---
title: "转换时字段必填"
linkTitle: "转换时字段必填"
date: 2025-06-27
weight: 10
description: >
  转换时字段必填。
---

{{% pageinfo %}}
本文档介绍如何在生命周期转换时或特定状态中强制字段必填。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-on-transition)。
{{% /pageinfo %}}

## 概述

当对象具有生命周期时，iTop 数据模型允许在转换和状态级别指定哪些字段必须填写。

## 使用 ITSM Designer（Combodo 客户）

### 转换时必填

要求从 New 状态移动到 Assigned 状态时填写 Service 字段：

1. 在 Lifecycle 标签页中选择转换
2. 设置字段为必填

### 状态中必填

要求所有处于 Assigned 状态的 UserRequest 都定义 Service：

1. 在 Lifecycle 标签页中选择状态
2. 设置字段为必填

## 使用 iTop 扩展

### 转换时必填

```xml
<class id="UserRequest">
  <lifecycle>
    <states>
      <state id="new">
        <transitions>
          <transition id="ev_assign" _delta="must_exist">
            <flags>
              <attribute id="service_id" _delta="define">
                <mandatory/>
              </attribute>
            </flags>
          </transition>
        </transitions>
      </state>
    </states>
  </lifecycle>
</class>
```

### 状态中必填

```xml
<class id="UserRequest" _delta="must_exist">
  <lifecycle>
    <states>
      <state id="assigned" _delta="must_exist">
        <flags>
          <attribute id="service_id" _delta="define">
            <mandatory/>
          </attribute>
        </flags>
      </state>
    </states>
  </lifecycle>
</class>
```

## 迁移注意事项

Setup 时无可见效果，但不符合要求的对象将无法在控制台或门户中修改，直到提供 Service。建议创建审计规则检索不符合要求的对象并修复。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-on-transition>

版本：3_2_0/customization/mandatory-on-transition.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
