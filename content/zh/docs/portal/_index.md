---
title: "标准门户手册"
linkTitle: "标准门户手册"
weight: 4
description: >
  增强版客户门户！
---

{{% pageinfo %}}

**增强版**客户门户，引入于 iTop 2.3.0 版本，帮助客户轻松创建和跟踪用户请求和事件工单。该门户提供了简化的界面来管理这些工单。

该门户支持两种用户角色：

- **门户用户** 仅允许查看他们提交的工单
- **门户高级用户** 允许查看其组织（及子组织）的所有工单

{{% /pageinfo %}}


## 首页

门户的用户界面设计为根据屏幕大小自动适应其呈现方式。因此，各种元素的内容和排列可能会根据连接到门户的设备而变化。但是，门户的所有功能能够在所有屏幕尺寸上正常使用。

例如，在典型的笔记本电脑上，具有相对较大的屏幕，门户的首页如下所示：[![Portal Home page - laptop screen](https://www.itophub.io/wiki/media?w=600&tok=3e2369&media=3_1_0:user:home-wide.png "Portal Home page - laptop screen")](https://www.itophub.io/wiki/media?media=3_1_0:user:home-wide.png "3_1_0:user:home-wide.png")

在较小的屏幕上，例如在手机上，首页显示如下：[![Portal Home page - mobile phone screen](https://www.itophub.io/wiki/media?w=200&tok=ec3e42&media=3_1_0:user:home-narrow.png "Portal Home page - mobile phone screen")](https://www.itophub.io/wiki/media?media=3_1_0:user:home-narrow.png "3_1_0:user:home-narrow.png")


## 创建工单
要创建新的工单，请在页面左侧点击“新建工单”菜单，或者在首页点击大的新建工单图块。

然后，会提示使用以下3种可能的模式之一选择服务和服务类别：

**嵌套 模式：**
![New Request Mosaic](https://www.itophub.io/wiki/media?media=3_1_0:portal:portalmosaic2.png "新的工单 嵌套")

**树形 模式：**
![New Request Tree](https://www.itophub.io/wiki/media?media=3_1_0:feature:portalbrowsetreesearch.png "新的工单 树形")

在此模式下，可以搜索关键字。按下回车键后，它会用与关键字匹配的行来过滤树。

- 如果关键字匹配一个服务名称，则将保留其所有子服务。

- 有可能看不出为何保留某一行，您的 iTop 可能已配置为在未显示的字段上进行搜索。
    
**列表 模式：**
![ New Request Select](https://www.itophub.io/wiki/media?media=3_1_0:portal:portalnewrequestlistwithtip.png "新的工单 选择") 

在此模式下，可以搜索关键字。按下回车键后，它会用与关键字匹配的行来过滤树。

- 有可能看不出为何保留某一行，您的 iTop 可能已配置为在未显示的字段上进行搜索。

- 如果关键字匹配一个服务名称，则将保留其所有子服务。

>> ![提示](/docs/images/note.png) <font style="color: #DA70D6"> 如果没有提供服务，请询问管理员检查：[故障排查](./#门户故障排查)
</font>

您可以使用右上角的选项卡在不同模式之间切换。  

要创建新工单，请单击想要的项目（_服务子目录_）。

然后，一个表单会以模态对话框的形式显示。填写表单并单击“提交”以提交您的工单。您可以通过将文档拖放到表单中，或者在表单的“附件”部分使用“浏览…”按钮来附加文档到工单。

>> ![提示](/docs/images/note.png) <font style="color: #DA70D6"> 您可以通过在文本中拖放它们，来在“描述”字段中包含图片。
</font>


[![ 工单创建表单 ](https://www.itophub.io/wiki/media?w=600&tok=4f68fe&media=3_1_0:user:new-request-3.png " Request creation form ")](https://www.itophub.io/wiki/media?media=3_1_0:user:new-request-3.png "3_1_0:user:new-request-3.png")

当提交工单时，显示将返回到打开的工单列表，您的新工单将位于列表顶部。

![](https://www.itophub.io/wiki/media?media=3_1_0:portal:portalongoingrequest.png)

## 更新现有工单

当工单尚未关闭时，仍然可以进行更新。使用门户，您可以：

- 向工单的日志中添加新条目，进一步解释您的需求或回答支持团队的问题。
    
- 将新文档附加到工单
    
- 重新打开“已解决”的工单（如果您对解决方案不满意）。

要更新现有工单，首先点击“正在处理的工单”菜单来定位该工单。

>> ![警示](/docs/images/warning.png) <font style="color: #DA70D6">在页面右上角，注意到“进行中/已解决”切换按钮。这个切换按钮用于过滤显示的工单列表。默认情况下，已解决的工单不会显示。</font>

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">您可以使用位于列表右上方的“筛选器”输入框在列表中搜索。筛选器还会搜索工单的描述，这在列表中不是可见的列。
</font>


一旦定位到要编辑的工单，请点击其参考号（“R-000xxx”）以打开其详细信息：

[![ 正在处理的工单列表 ](https://www.itophub.io/wiki/media?media=3_1_0:user:on-going-requests.png " List on-going requests ")](https://www.itophub.io/wiki/media?media=3_1_0:user:on-going-requests.png "3_1_0:user:on-going-requests.png")

显示的表单允许您编辑日志并添加/删除附件。完成后，使用底部的“提交”按钮（或右侧的“勾号”按钮）提交您的更新。

[![](https://www.itophub.io/wiki/media?w=600&tok=8b1855&media=3_1_0:user:update-request.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:update-request.png "3_1_0:user:update-request.png")

## 变更你的角色

客户可以通过名为“我的资料”的菜单从门户编辑其个人资料信息。

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:home-menu-1.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:home-menu-1.png "3_1_0:user:home-menu-1.png")

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">最终用户允许编辑的实际字段列表取决于门户的配置。默认情况下，iTop 允许最终用户编辑他们的电话号码、位置、职能、图片以及他们的首选语言。
</font>

>> ![警示](/docs/images/warning.png) <font style="color: #DA70D6">当密码在 iTop 外部管理时（例如，使用 LDAP 或基于 Active Directory 的身份验证时），密码管理表单不会显示。</font>

[![ 更新您的个人资料](https://www.itophub.io/wiki/media?w=600&tok=0c8818&media=3_1_0:user:my-profile.png " 更新您的个人资料")](https://www.itophub.io/wiki/media?media=3_1_0:user:my-profile.png "3_1_0:user:my-profile.png")

>> ![提示](/docs/images/tip.png) <font style="color: #00CC33">“头像”字段仅支持 JPEG、PNG 和 GIF 类型的图像。
</font>


## 退出门户

退出门户，使用“注销”菜单：

[![](https://www.itophub.io/wiki/media?media=3_1_0:user:home-menu-2.png)](https://www.itophub.io/wiki/media?media=3_1_0:user:home-menu-2.png "3_1_0:user:home-menu-2.png")

## 门户错误排查

如果出现：“没有服务”，则您可能忘记了[实施指南](../implementation/ "3_1_0:implementation:start")中的一个步骤

- 门户用户必须属于 _Customer A_ 组织
- 门户用户必须具有 _Portal user_ `角色`
- _Customer A_ 缺少一个 `客户合同`
- 上述 `客户合同` 缺少附加的 `服务`
- 您的 `服务` 缺少 `服务系列`
- 您的 `服务` 下缺少 `服务子目录`
- `服务` 的状态未定义或已过时
- `服务子目录` 的状态未定义或已过时
    
---
原文：<https://www.itophub.io/wiki/page?id=3_1_0:portal:portal_v2>

版本：3_1_0/portal/portal_v2.txt · Last modified: 2023/11/07 17:33 (external edit)


