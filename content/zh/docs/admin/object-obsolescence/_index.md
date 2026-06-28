---
title: "对象废弃"
linkTitle: "技巧：对象废弃"
date: 2025-06-27
weight: 49
description: >
  iTop 对象生命周期中的废弃状态。
---

{{% pageinfo %}}

iTop 2.4 引入，数据模型现在包含按对象类定义的废弃概念，以通过突出显示/隐藏废弃对象来改善用户体验。

- 请参阅用户指南中的废弃用户体验。
- 有关配置自己的废弃规则，请参阅教程：定义废弃规则。

{{% /pageinfo %}}

## 搜索废弃对象

```sql
SELECT Person WHERE obsolescence_flag
```

## 限制

## 默认废弃规则

### 哪些对象被视为废弃？

一般而言：

- 状态等于 obsolete 或 inactive 的对象
- 作为另一个对象的子对象的对象，如果其主对象被废弃，则该对象也被废弃。例如：如果其 ConnectableCI 被废弃，则 Physical Interface 被废弃。此规则有两个例外：Virtual Machine 和 Hypervisor 仅当且仅当它们自己的状态为 obsolete 时才被废弃
- 超过 15 个月前过期的许可证（搜索查询无法缓存，因此高容量时需谨慎）

#### 配置管理核心

- Contact: status='inactive'
- Document: status='obsolete'

##### CIs

- Application Solution: status='inactive'
- Business Process: status='inactive'
- DB Server: status='inactive'
- Database Schema: 其 DBServer 被废弃
- Middleware: status='inactive'
- Middleware Instance: 其 Middleware 被废弃
- Network Device: status='obsolete'
- Other Software: status='inactive'
- PC Software: status='inactive'
- Server: status='obsolete'
- Web Application: 其 Web server 被废弃
- Web server: status='inactive'

##### 其他

- Group: status='obsolete'
- Location: status='inactive'
- OSLicence: 许可证不是永久的，且定义了结束日期，并已超过 15 个月
- OSPatch: 未定义废弃
- Organization: status='inactive'
- Physical Interface: 其 Device 被废弃
- Software: 未定义废弃
- Software Licence: 许可证不是永久的，且定义了结束日期，并已超过 15 个月
- Software Patch: 未定义废弃
- Subnet: 未定义废弃
- VLAN: 未定义废弃

#### 最终用户设备

所有最终用户设备使用在 Physical Device 上定义的逻辑：status='obsolete'

#### 虚拟化管理

- Farm: status='obsolete'
- Hypervisor: status='obsolete'
- Logical Interface: 其 Virtual Machine 被废弃
- Virtual Machine: status='obsolete'

#### 高级存储

- Fiber Channel Interface: 其 Datacenter Device 被废弃
- Logical Volume: 其 Storage System 被废弃
- NAS: status='obsolete'
- NAS File System: 其 NAS 被废弃
- SAN Switch: status='obsolete'
- Storage System: status='obsolete'
- Tape: 其 Tape Library 被废弃
- Tape Library: status='obsolete'

#### 数据中心

- Enclosure: status='obsolete'
- PDU: status='obsolete'
- Power Source: status='obsolete'
- Rack: status='obsolete'

#### 工单

自 2.5.0 起，工单不再定义废弃规则，因为它会降低性能。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:feature:obsolescence>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/feature/obsolescence.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
