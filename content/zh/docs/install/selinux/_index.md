---
title: "iTop 与 SELinux"
linkTitle: "iTop 与 SELinux"
date: 2025-06-27
weight: 56
description: "介绍在启用 SELinux 的 Linux 系统（如 Fedora、RedHat、CentOS）上配置 iTop 所需的额外安全设置。"
---

{{% pageinfo %}}
本文档介绍在启用 SELinux 的 Linux 发行版上运行 iTop 所需的配置。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:selinux)。
{{% /pageinfo %}}

某些 Linux 发行版（如 Fedora、RedHat、CentOS 等）默认启用了 SELinux。在使用 iTop 之前，需要进行额外的安全配置。

## 基础 SELinux 配置

```bash
# 允许对 iTop 根目录及其子目录进行读写
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/itop(/.*)?"
# 应用策略
restorecon -Rv /var/www/html/itop/
# 查看已应用的策略
ls -lZ /var/www/html/itop/
```

此基础配置可与 iTop 正常工作。如需应用更严格的权限，你需要具备深入的 SELinux 知识。

## 文件写入问题

如果安装过程中提示 iTop 的 `conf` 文件夹已存在但无法写入，且目录权限看起来正确，则可以尝试临时关闭 SELinux 上下文检查：

```bash
setenforce 0
```

这会完全关闭安全上下文检查。**这绝对不适合生产环境**，但有助于排查问题根源。有关安全上下文的更多信息，请参阅[此处](https://wiki.centos.org/HowTos/SELinux)或[此处](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/index)。

## 连接远程 MySQL 服务器

如果 iTop 无法连接到远程 MySQL 服务器，请使用以下命令检查 SELinux 设置：

```bash
getsebool -a | grep 'httpd'
```

输出应类似于：

```
allow_httpd_anon_write –> off
allow_httpd_bugzilla_script_anon_write –> off
allow_httpd_cvs_script_anon_write –> off
allow_httpd_mod_auth_pam –> off
allow_httpd_nagios_script_anon_write –> off
allow_httpd_prewikka_script_anon_write –> off
allow_httpd_squid_script_anon_write –> off
allow_httpd_sys_script_anon_write –> off
httpd_builtin_scripting –> on
httpd_can_network_connect –> off
httpd_can_network_connect_db –> off
httpd_can_network_relay –> off
httpd_can_sendmail –> on
httpd_disable_trans –> off
httpd_enable_cgi –> on
httpd_enable_ftp_server –> off
httpd_enable_homedirs –> on
httpd_rotatelogs_disable_trans –> off
httpd_ssi_exec –> off
httpd_suexec_disable_trans –> off
httpd_tty_comm –> on
httpd_unified –> on
httpd_use_cifs –> off
httpd_use_nfs –> off
```

如果看到 `httpd_can_network_connect_db –> off`，这意味着 Web 服务器被阻止与 MySQL 服务器建立网络连接。

要更改此安全设置，请以 root 身份执行以下命令：

```bash
setsebool -P httpd_can_network_connect_db on
```

## 从远程连接 iTop

如果你只能从本机连接到 Web 服务器，而无法从远程系统访问，请检查防火墙（iptables）配置。

```bash
firewall-cmd --list-services
```

命令输出应类似于：

```
dhcp-v6-client http mdns ssh
```

如果列表中没有 `http`，则对 Web 服务器的访问将被阻止。要以 root 身份解除阻止，请执行：

```bash
firewall-cmd --add-service=http
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:selinux>

版本：3_2_0/install/selinux.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
