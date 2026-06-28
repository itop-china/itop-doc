---
title: "安装扩展"
linkTitle: "安装扩展"
date: 2026-06-27
weight: 2
description: >
  介绍如何在 iTop 中安装或升级扩展，包括通过 iTop Hub 自动安装和手动安装两种方式。
---

{{% pageinfo %}}
本文介绍 iTop 扩展的安装方法。Combodo 商业用户可通过支持门户申请安装；社区用户可使用 iTop Hub 自动安装，或按本文步骤手动安装。
{{% /pageinfo %}}

## Combodo 客户

如果您与 Combodo 签订了合同，并使用 Professional、Essential 或 Tailored 版本的 iTop，请在 Combodo 用户门户上提交请求以安装新扩展。

> 根据您的产品和合同，可能会有附加条件或额外费用。

## iTop Hub 安装

如果您是社区用户，并希望安装 iTop Hub 上可用的扩展，最简单的方法是：

1. 在 [iTop Hub](https://www.itophub.io/) 注册账号。
2. 将您的 iTop 实例注册到 Hub。
3. 使用 Hub 的**自动安装**机制将扩展部署到您的 iTop 服务器。

自动安装会检查您的 iTop 版本与目标扩展版本之间的**兼容性**。

## 手动安装

安装或升级扩展时，通常需要执行以下步骤：

### 将扩展代码复制到 iTop 服务器

- 从扩展 wiki 页面下载包含扩展的 zip 文件，并将其放到 iTop 服务器上。
- 将 zip 文件内容解压到 iTop 的 `extensions` 文件夹中。注意：解压方式取决于您的 iTop 版本，详见下文[从 zip 中提取文件](#从-zip-中提取文件)。
- 确保 Web 服务器进程对新复制的文件、目录及子目录具有足够的读取权限（在 Linux 上，Web 服务器进程还需要能够执行 [x] 目录）。

### 运行安装向导

- 移除 iTop 配置文件的只读标志（在 Linux 上，使其对 Web 服务器进程可写 [w]）。
- 在浏览器中访问 iTop 的 `setup` 目录以启动安装向导（例如：`http://itop.mycompany.com/setup` 或 `http://localhost/itop/setup`）。
- 当提示选择要安装的扩展时，确保选中您刚刚下载的扩展。

## Extensions 文件夹下的文件结构

### 从 zip 中提取文件

#### iTop 2.4.0 及以上版本

直接将 zip 文件解压到 `extensions` 文件夹中，然后继续后续步骤。

#### iTop 2.4.0 之前的版本

对于由多个模块组成的扩展，请确保只将 zip 文件中的子文件夹复制到 iTop 的 `extensions` 文件夹中，如下图所示：

![iTop 2.4.0 之前的扩展目录结构](/images/extensions/extension-copy.png)

---
原文：<https://www.itophub.io/wiki/page?id=extensions:installation>

版本：extensions/installation.txt · Last modified: 2025/01/31 11:44 by 127.0.0.1
