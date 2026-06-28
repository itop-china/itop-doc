---
title: "自动化与工单管理"
linkTitle: "自动化与工单管理"
date: 2025-06-27
weight: 10
description: >
  自动化与工单管理。
---

{{% pageinfo %}}
本文档介绍 iTop 定制中的自动化与工单管理相关场景。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。
{{% /pageinfo %}}

## 概述

iTop 定制可通过以下两种方式实现：

- **安装现有扩展**：浏览已发布的扩展列表，选择并安装适合您需求的扩展。
- **编写自定义扩展**：创建您自己的扩展模块，以满足特定的业务需求。

## 编写扩展的基础知识

创建 iTop 扩展模块需要掌握以下基础知识：

- [iTop 定制机制](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 了解如何扩展或修改 iTop
- [分步示例](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 创建您的第一个扩展
- [扩展骨架生成工具](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 辅助创建新扩展并了解文件结构
- [API：搜索和操作对象](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [CRUD 事件](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 在对象上添加业务逻辑
- [事件 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 添加自定义事件（3.1 新增）
- [界面 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 自定义 GUI
- [XML 数据模型参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) 和 [XML 门户参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [iTop 编码规范](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- [FontAwesome v5](https://www.itophub.io/wiki/page?id=3_2_0:customization:start) — 图标使用

## "How to" 示例分类

### 数据模型变更

#### 类、字段与关系

- 属性用法与约束
- 向 Server 类添加字段
- （重新）定义字典条目
- 强制字段始终必填
- 从 Ticket 中移除字段
- 在 Team 上添加仪表板
- 创建新的 CI 类：Monitor
- 定义依赖关系
- 添加 1:1 关系
- n:n 自反与对称关系
- 对象创建者
- 合并状态
- 在 PHP 中添加 TagSet
- 在 PHP 中添加日志条目
- 添加 n:n 关系
- 机密属性

#### 生命周期：状态、转换、计时器

- 添加状态与转换
- 统计状态停留时间
- 状态延迟后通知
- 计时器行为
- 为物理设备添加生命周期
- 按生命周期强制字段必填
- 在转换时执行动作
- 转换时可用的预定义方法
- 允许在非默认状态直接创建
- 日志更新时重新分配工单
- 隐藏转换

#### 认证与权限

- 创建新角色
- 委派"管理工具"菜单
- 定义密码策略
- 实现密码过期
- 创建自定义认证方法
- 防止用户意外被禁用

### 用户界面

#### 必填、隐藏、受控

- 强制字段必填
- 设置字段只读
- 为部分用户隐藏成本
- 表单预填充
- 数据完整性检查
- 定义过时规则
- 防止重复

#### 显示

- 更改 iTop 主页
- 在"其他操作"弹出菜单中添加条目
- 创建控制台仪表板新 dashlet
- 丰富对象显示
- 区分同名对象
- 更改页面标题
- 对象间导航
- 隐藏对象标签页
- 在列表上添加操作
- 隐藏对象历史
- 添加对象概览
- 排序枚举值
- 排序转换
- 计算对象图标

#### 主题与颜色

- 更改 iTop 标志
- 更改颜色及其他
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
- 统计工单重开次数
- 1:n 计算字段
- n:n 计算字段
- 存储 n:n 关系计数
- 从外部应用同步数据
- 将工单传输到另一个 iTop
- 存储 1:n 关系计数
- 添加附件时添加日志条目
- 计算 linkedset 依赖值

### 工单管理

- 统计等待第三方的时间
- 考虑覆盖窗口的解决延迟
- 统计用户请求重开次数 / 停用计数器历史追踪
- 延迟后自动关闭
- 计划日期的 TTO 开始
- 计划用户请求（高级）
- 按服务子目录的 SLA
- 从父组织继承服务
- 按国家使用假期日历进行 SLA 计算
- 级联变更关闭
- 服务提供商与中介
- 日志更新时重新分配工单
- 停用计数器历史追踪

### 门户定制

- 门户定制概览
- 门户 XML 参考
- 门户限制
- 门户 "How to" 示例

### 贡献翻译

- [如何翻译](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:start>

Last modified: 2026/06/10 17:31 by127.0.0.1

版本：3_2_0/customization/start.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
