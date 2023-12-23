
---
title: "iTop是什么？"
linkTitle: "文档"
weight: 20
menu:
  main:
    weight: 20
---

{{% pageinfo %}}
如果你已经了解了这些，访问查看[最新版3.0的wiki文档](/cn/docs/3.0)！
{{% /pageinfo %}}

## 关于 iTop

iTop即IT运维门户（IT Operational Portal）。iTop是一个开源的网页应用程序，用于IT环境的日常运营。iTop根据ITIL最佳实践思想设计，但是并不强制规定任何具体的流程。无论你是想要非正式的或者更实用的流程，还是严格地与ITIL对齐，这个应用都是足够灵活，能够适配你的流程。

iTop的核心是CMDB（配置管理数据库），这是iTop最初开发的第一部分。后续才开发了工单和所有的衍生流程。

iTop背后的理念是：CMDB必须是一种运维工具。保证准确和最新的CMDB的唯一方法是由IT团队（支持代理、IT工程师等）每天使用。此外，CMDB与其他IT工具（监控系统、报告工具、自动化库存等）集成得越多越好。

iTop的特性，使用它可以做到：
- 记录IT基础设施以及基础设施的各个部分和相关者之间的所有关系（服务器、应用、网络设备、虚拟机、联络人、位置）
- 管理事件、用户请求、计划内停机
- 记录IT服务和包括服务级别协议的外部供应商合同
- 通过手工或脚本的方式导出所有信息
- 批量导入（手工和脚本）或者同步/联合来自外部系统的任何数据

iTop能够被不同类型的人员使用：
- 服务台代理
- 支持工程师 (一线，二线)
- 服务经理
- IT经理
- 最终用户：可以使用简化的“门户”界面直接提交请求。

iTop依赖 Apache/IIS, MySQL 和 PHP:
- 能够运行在支持这些应用的任何操作系统。在Windows, Linux (Debian, Ubuntu 和 Redhat)已经经过验证测试。同时也可以运行在 Solaris 和 MacOS X。
- iTop 是基于网页的应用，不需要在用户的个人电脑部署任何客户端软件。一个简单的网页浏览器就足够了 (IE 10+, FF 48+, Chrome 或者 Safari 5+).

---
原文：<https://www.itophub.io/wiki/page?id=start>

版本：start.txt · Last modified: 2022/01/10 17:20 by vdumas