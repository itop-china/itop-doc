---
title: "监控健康检查"
linkTitle: "系统：监控健康检查"
date: 2025-06-27
weight: 46
description: "监控健康检查"
---

{{% pageinfo %}}

如果您需要通过外部工具轮询 iTop 状态，您有一个专用页面。此页面不需要任何认证。返回的状态为 JSON 格式。

{{% /pageinfo %}}

## 端点

```
https://iTOP_URL/webservices/status.php
```

## 示例

```bash
curl http://localhost/iTop/webservices/status.php
{"status":"RUNNING","code":0,"message":""}
```

## 返回状态

| HTTP 状态 | 含义 |
|---|---|
| 200 | 应用正常运行 |
| 500 | 至少一项检查失败 |

## 与监控系统集成

可将该端点配置为 Nagios 或 Zabbix 的 HTTP 检查项，实现自动告警。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:monitoring:healthcheck>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/admin/monitoring/healthcheck.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
