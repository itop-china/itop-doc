---
title: "Nagios 集成"
linkTitle: "Nagios 集成"
date: 2025-06-27
weight: 8
description: >
  <br> ➡️ 将 Nagios 监控数据同步到 iTop
---

{{% pageinfo %}}

iTop 可以与 Nagios 监控系统集成，将监控状态信息同步到 iTop 的配置项中。

{{% /pageinfo %}}

## 概述

通过此集成：

- Nagios 告警将转换为 iTop 中的事件工单
- Nagios 中设备的状态详细信息可以直接在 iTop 中查看（作为对象上的额外选项卡）

虽然 Nagios 的配置非常具体（命令定义、处理程序定义），但相同的原理可以应用于任何能够在接收到告警时运行命令行脚本的基于 Web 的监控工具。

将 Nagios 告警转换为 iTop 中的工单具有众多优势，例如：

- 工单可以从创建到解决进行跟踪
- 可以为工单分配 SLA 以确保及时解决
- iTop 可以计算由于某个组件故障而导致的"受影响"基础设施。"受影响"的项目会自动添加到事件工单中
- iTop 可以通知受事件影响的各种人员

## 自动化在 iTop 中创建事件工单

本节描述如何配置 Nagios 以自动在 iTop 中创建事件工单。由于 Nagios "命令"基于命令行脚本，因此编写了一个特殊的 PHP 脚本，该脚本包装了 iTop 的 SOAP Web 服务，用于从命令行创建事件工单。请注意，由于 Nagios 调用的命令行脚本使用 SOAP Web 服务在 iTop 中创建工单，因此 Nagios 和 iTop 可以安装在不同的服务器上，前提是 Nagios 服务器到 iTop 之间可以进行 HTTP(S) 连接。

此脚本称为 "createTicket-nagios.php"。可以从这里下载：https://www.combodo.com/documentation/createTicket-nagios.zip

将此脚本复制到 Nagios 服务器上的目录中（例如 /etc/nagios3），并将文件 'itopsoaptypes.inc.php' 从 iTop 实例的 'webservices' 目录复制到同一目录中。

- 此脚本使用在 Nagios 中触发告警的主机的主机名来标识 iTop 中受影响的对象。因此主机名必须是唯一的。
- 脚本仅为处于 HARD 状态的 Nagios 告警触发工单。此外，它需要在 iTop 中预先配置默认工作组、默认呼叫者和默认客户。（有关工作组、呼叫者和客户的更多详细信息，请参阅 iTop 文档）
- 工单的严重程度始终相同，默认设置为严重。
- 此脚本只是描述如何使用 iTop SOAP Web 服务的示例。请根据您的需求随意改进。

用于工单创建的所有参数都列在脚本的开头，如下所示，必须根据您的配置进行调整。

```php
<?php
// Adjust these settings to fit your iTop installation
// iTop Server location
define('ITOP_SERVER_URL', 'https://localhost/webservices/itop.wsdl.php');
// Valid credentials for connecting to iTop
define('ITOP_USERNAME', 'admin');
define('ITOP_PASSWORD', 'admin2');
// Default settings for creating the incident ticket
define('DEFAULT_IMPACT', 2); // 1 = department, 2 = service, 3 = person
define('DEFAULT_URGENCY', 2); // 1 = high, 2 = medium, 3 = low
define('DEFAULT_CALLER_NAME', 'Dali');
define('DEFAULT_ORGANIZATION_NAME', 'Demo');
define('DEFAULT_SERVICE_NAME', 'HW Monitoring');
define('DEFAULT_SERVICE_SUBCATEGORY', 'HW Troubleshooting');
define('DEFAULT_WORKGROUP_NAME', 'Hardware support');
// End of instance-specific parameters
```

### 在 Nagios 服务器上安装文件

- 步骤 1：将此脚本复制到 <yourDirectory> 以及 itopsoaptypes.class.inc.php

- 步骤 2：通过将以下内容添加到 Nagios 命令文件（大多数情况下称为 commands.cfg）来定义新的 Nagios 命令

```
# Create incident tickets in iTop command definition 
define command{ 
        command_name    create-iTop-ticket 
        command_line    <php path>  <yourDirectory>/createTicket-nagios.php "$HOSTNAME$" "$SERVICEDESC$" "$SERVICESTATE$" "$SERVICESTATETYPE$" "$LONGSERVICEOUTPUT$" 
}
```

其中 <php path> 是 PHP 的完整路径，<your_directory> 是您安装 iTop 脚本的路径。

您可以通过手动运行 PHP 脚本来测试工单创建。

步骤 3：对每个应该触发工单创建的主机或服务模板的事件处理程序选项中使用此命令：

您可以使用以下选项为所有主机和服务全局定义，这些选项大多在 nagios.cfg 中定义：

```
global_host_event_handler=create-iTop-ticket
global_service_event_handler= create-iTop-ticket
```

或者为每个主机和服务使用以下选项：

```
event_handler   create-iTop-ticket
event_handler_enabled  1
```

如果您选择后者，则必须为您创建的每个主机和服务模板配置处理程序。

完成后，下次在 Nagios 中出现 HARD 告警时，它将自动在 iTop 中创建工单！

## 在 iTop 中查看 Nagios 状态

当在 iTop 中显示给定对象的详细信息时，浏览器框架中有多个选项卡。您可以创建一个新的选项卡，显示所选对象的 Nagios 框架。

- 修改 `InfrastructureCI` 类中的 `DisplayBareRelations` 函数
- 这将为所有非编辑模式下的生产环境 InfrastructureCI 添加 Nagios 选项卡。

```php
function DisplayBareRelations(WebPage $oPage, $bEditMode = false) 
{ 
    parent::DisplayBareRelations($oPage, $bEditMode); 
    if (!$bEditMode) 
    { 
        $sStatus = $this->Get('status'); 
        $sName = $this->Get('name'); 
        if ($sStatus == 'production') 
        { 
            $oPage->SetCurrentTab(Dict::S('Nagios')); 
            $oPage->add('<div id="checkmk" style="width:100%;height:500px;">');
            $oPage->add('<iframe style="border:0;padding:0;margin:0;width:100%;height:500px;overflow:auto" ');
            $oPage->add('src="https://<nagios_path>/cgi-bin/status.cgi?host='.$sName.'">');
            $oPage->add('</iframe></div>');
        } 
    }
}
```

- 不要忘记将 "<nagios_path>" 设置为适合您安装的 URL。

**注意**，显示仅在您在 iTop 中使用的对象名称等于 Nagios 中对象的主机名时才有效。

完成后，保存文件并在浏览器中重新加载"详细信息"页面。

结果应该类似于下图：

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:nagios>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/advancedtopics/nagios.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
