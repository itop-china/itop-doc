---
title: "编写自己的扩展"
linkTitle: "编写自己的扩展"
date: 2025-06-27
weight: 10
description: >
  编写自己的扩展。
---

{{% pageinfo %}}
本文档介绍 iTop 定制的整体概览，包括通过安装现有扩展和编写自定义扩展两种方式。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。
{{% /pageinfo %}}

## 定制方式

### 安装现有扩展

- 查看已发布的扩展列表，选择并安装适合您需求的扩展。

### 编写自己的扩展

创建 iTop 扩展模块的基础知识：

- 了解 [iTop 定制机制](https://www.itophub.io/wiki/page?id=3_2_0:customization:datamodel)，理解如何扩展或修改 iTop。
- 参考[逐步示例](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-attribute-sample)，创建您的第一个扩展。
- 使用[扩展骨架生成工具](https://www.itophub.io/wiki/page?id=3_2_0:customization:new_extension)创建新扩展，并了解[文件结构](https://www.itophub.io/wiki/page?id=3_2_0:customization:new_extension)。
- 使用[对象操作 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:api:objects-manipulation:start) 搜索和操作对象。
- 使用 [CRUD 事件](https://www.itophub.io/wiki/page?id=3_2_0:extensibility:events_crud) 在对象上添加业务逻辑，事件遵循 [CRUD 序列](https://www.itophub.io/wiki/page?id=3_2_0:customization:sequence_crud)。
- 使用 [Events API](https://www.itophub.io/wiki/page?id=3_2_0:customization:events_api) 添加自定义事件（iTop 3.1 新增）。
- 使用 [Interfaces API](https://www.itophub.io/wiki/page?id=3_2_0:customization:extensions_api:interfaces) 定制 GUI。
- [XML 数据模型参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:xml_reference) 和 [XML Portal 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)。
- [iTop 编码标准](https://www.itophub.io/wiki/page?id=3_2_0:customization:coding_standards)。
- 图标使用 [FontAwesome v5](https://fontawesome.com/v5/search)。

## "How to" 示例

### 修改数据模型

#### 类、字段与关系

- 属性用法与约束
- 为 Server 类添加字段
- （重新）定义字典条目
- 强制字段始终必填
- 从 Ticket 中移除字段
- 为 Team 添加仪表板
- 创建新的 CI 类：Monitor
- 定义依赖关系
- 添加 1:1 关系
- n-n 自反与对称关系
- 对象创建者
- 合并状态
- 在 PHP 中添加 TagSet
- 在 PHP 中添加日志条目
- 添加 n:n 关系
- 机密属性

#### 生命周期：状态、转换、计时器

- 添加状态和转换
- 统计在状态中花费的时间
- 在状态延迟后通知
- 计时器行为
- 为物理设备添加生命周期
- 通过生命周期强制字段必填
- 在转换上执行操作
- 转换上可用的预定义方法
- 允许在非默认状态直接创建
- 在日志更新时重新分配工单
- 隐藏转换

#### 认证与权限

- 创建新角色
- 委派"管理工具"菜单
- 定义密码策略
- 实现密码过期
- 创建自定义认证方式
- 防止用户意外被禁用

### 用户界面

#### 必填、隐藏、控制

- 强制字段必填
- 将字段设为只读
- 为某些用户隐藏成本
- 表单预填充：创建表单预填充、转换预填充、搜索条件预填充
- 数据完整性检查：确保结束日期在起始日期之后、物理设备在生产环境时必须填写位置、防止 LinkedSet 变更超出库存、防止人员组织变更破坏门户用户关联、限制用户只能修改不能创建对象
- 定义过时规则
- 防止重复

#### 显示

- 更改 iTop 主页
- 在"其他操作"弹出菜单中添加条目
- 为控制台仪表板创建新 dashlet：iFrame
- 丰富对象显示
- 区分同名对象
- 更改页面标题
- 对象间导航
- 隐藏对象标签页：影响分析或仪表板
- 在列表上添加操作
- 隐藏对象历史记录
- 添加对象概览
- 枚举值排序
- 转换排序
- 计算对象图标

#### 主题与颜色

- 更改 iTop 徽标
- 更改颜色等
- 高亮关键对象
- 高亮状态
- 更改菜单图标
- 类颜色与图标
- 更改左侧菜单颜色
- 更改主色调
- 创建新主题

### 自动化

- 使用对象复制器复制 linkedset
- 计算工单结束日期
- 统计工单重新打开次数
- 在 1:n 上计算字段
- 在 n:n 上计算字段
- 存储 n:n 关系计数
- 从外部应用同步数据
- 将工单转移到另一个 iTop
- 存储 1:n 关系计数
- 在添加附件时添加日志条目
- 计算 linkedset 依赖值

### 工单管理

- 统计等待第三方的时间
- 考虑覆盖窗口计算解决延迟
- 统计用户请求重新打开次数
- 在延迟后自动关闭
- 计划日期开始的用户请求 TTO
- 计划用户请求（高级）
- 按服务子类别设置 SLA
- 从父组织继承服务
- 按国家使用节假日日历计算 SLA
- 级联变更关闭：在相关变更关闭时自动解决所有关联用户请求
- 使用中间商的服务提供商
- 在日志更新时重新分配工单

## 定制门户

自 2.3 版本起，增强型门户提供了定制选项。

- 门户定制概览
- 门户 XML 参考
- 门户限制

### 操作示例

- 在用户门户上强制字段必填
- 允许查看更多或更少的工单
- 为他人创建工单
- 更改范围
- 更改 Bootstrap 主题
- 更改菜单图标
- 添加"创建"按钮
- 添加新的浏览模式
- 添加 Dashlet
- 创建新门户
- 门户上的可选关系
- 为各种客户创建工单
- 在表单中定位附件

## 贡献 iTop 翻译

- 如何翻译

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:start>

Last modified: 2026/06/10 17:31 by127.0.0.1

版本：3_2_0/customization/start.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
