---
title: "归档"
linkTitle: "技巧：归档"
date: 2025-06-27
weight: 48
description: >
  iTop 对象归档机制。
---

{{% pageinfo %}}

目的：当您的过时数据开始比活跃数据多得多时，提高搜索性能。

{{% /pageinfo %}}

## 启用归档

默认情况下，任何类都不启用归档。只能在数据模型中的**根类**上激活，例如 `FunctionalCI`、`Contact`、`Ticket` 等。有关详细信息，请参阅 XML 参考。

```xml
<classes>
  <class id="Ticket">
    <properties>
      <archive _delta="define">
        <enabled>true</enabled>
      </archive>
    </properties>
  </class>
</classes>
```

允许类的对象被归档对用户界面没有直接影响，直到模块提供归档和取消归档对象的功能。

如果您想**自动**归档每个已关闭且超过两年的工单，则可以开发一个特定的扩展，使用后台任务来完成。此模块目前尚不存在。

#### 归档模块的 API

```php
DBSearch::DBBulkArchive()
DBSearch::DBBulkUnarchive()
DBSearch::DBBulkWriteArchiveFlag.
```

## 用户体验

### 标准模式

所有归档对象对所有用户（包括管理员）都是隐藏的，就像它们被删除了一样。

在其他指向它们的对象中可以找到对其友好名称的引用。例如，一个已归档的联系人是一个未归档变更的呼叫者。如您所见，链接是**非活动**的，您无法打开呼叫者详情。

在其他对象的历史记录中，您只会得到该归档对象的 id：

如果您尝试使用书签 URL 或构建如下 URL 来打开该归档对象的详情：`http://myitop/pages/UI.php?operation=details&class=Person&id=11&`

当对象被归档时，其所有与其他对象的 n:n 链接也会被**归档**，这意味着它们不再可见。

### 归档模式

您可以切换归档模式：

- 在归档模式下，您会看到一个橙色标签提醒您已激活它。
- 所有对象都是**只读**的
- 归档对象是**可见**的并标记为**已归档**
- 引用**已归档**对象的属性是可点击的：

如果您在归档对象上**停用归档模式**：

您会再次收到反馈消息。

## 常见问题

**问："激活归档模式"菜单不可用？**

**答：**归档必须在至少一个类上启用。如果您刚刚通过 Setup、Move To Test、Move To Production 或 iTop Hub 扩展安装完成，请确保**清空 Web 浏览器缓存**，因为这是一个已知问题。

**问：我可以在用户门户中看到"归档对象"吗？**

**答：**不，归档对象永远不能在任何用户门户中显示。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:feature:archiving>

版本：3_2_0/feature/archiving.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
