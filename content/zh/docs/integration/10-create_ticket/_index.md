
---
title: "通过 API 创建工单"
linkTitle: "通过 API 创建工单"
date: 2025-06-27
weight: 10
description: >
  <br> ➡️ 使用 REST API 自动创建 iTop 工单
---

{{% pageinfo %}}

本指南演示如何通过 REST/JSON API 自动创建 iTop 工单，适用于监控告警自动转工单、邮件转工单等场景。

{{% /pageinfo %}}

## 概述

本页包含各种语言的**示例**脚本，用于从命令行在 iTop 中创建工单。这些脚本使用 iTop 的 REST/JSON API 在远程 iTop 服务器上创建工单（脚本必须通过 http/https 访问 iTop）。这些脚本旨在与 Nagios 一起使用，因为它们需要 4 个参数：host、service、service_status 和 service_state_type，但唯一有意义的参数是 host，并且调整脚本以满足您的特定需求非常容易。

选择您最喜欢的脚本语言，不要犹豫**定制**它。

## 使用 PHP

本节提供了一个用 **PHP** 脚本语言编写的示例脚本，用于在（远程）iTop 中使用 REST/JSON Web 服务创建工单。为了简化此示例，仅执行了最少的参数验证和返回状态验证。

要求：带有 cURL 模块的 PHP。

限制：Nagios 中的 "host" 值必须对应于 iTop 中唯一的 FunctionalCI。

以下 PHP 脚本创建一个 UserRequest 工单（您可以将配置更改为创建 Incident 或 Change），并将提供的 host（= FunctionalCI）附加到它。工单在与 host 相同的组织中创建。

```php
#!/usr/bin/php
<?php
// Configuration
$ITOP_URL = 'https://demo.combodo.com/simple';
$ITOP_USER = 'admin';
$ITOP_PWD = 'admin';
$TICKET_CLASS = 'UserRequest';
$TITLE = 'Service Down on %1$s';
$DESCRIPTION = 'The Service "%2$s" is down on "%1$s"';
$COMMENT = 'Created from PHP';
 
if ($argc != 5)
{
        echo "Usage: {$argv[0]} <host> <service> <service_status> <service_state_type>\n";
        exit;
}
$host = $argv[1];
$service = $argv[2];
$service_status = $argv[3];
$service_state_type = $argv[4];
$url = $ITOP_URL.'/webservices/rest.php?version=1.0';
 
if (($service_status != "OK") && ($service_status != "UP") && ($service_state_type == "HARD"))
{
        $payload = array(
                        'operation' => 'core/create',
                        'class' => $TICKET_CLASS,
                        'fields' => array(
                                        'org_id' => sprintf('SELECT Organization AS O JOIN FunctionalCI AS CI ON CI.org_id = O.id WHERE CI.name="%1$s"', $host),
                                        'title' => sprintf($TITLE, $host, $service),
                                        'description' => sprintf($DESCRIPTION, $host, $service),
                                        'functionalcis_list' => array(
                                                array('functionalci_id' => sprintf("SELECT FunctionalCI WHERE name='%s'", $host), 'impact_code' => 'manual'),       
                                        ),
                        ),
                        'comment' => $COMMENT,
                        'output_fields' => 'id',
        );
 
        $data = array(
                        'auth_user' => $ITOP_USER,
                        'auth_pwd' => $ITOP_PWD,
                        'json_data' => json_encode($payload)
        );
 
        $options = array(
                        CURLOPT_POST                    => count($data),
                        CURLOPT_POSTFIELDS              => http_build_query($data),
                        // Various options...
                        CURLOPT_RETURNTRANSFER  => true,     // return the content of the request
                        CURLOPT_HEADER                  => false,    // don't return the headers in the output
                        CURLOPT_FOLLOWLOCATION  => true,     // follow redirects
                        CURLOPT_ENCODING                => "",       // handle all encodings
                        CURLOPT_AUTOREFERER             => true,     // set referer on redirect
                        CURLOPT_CONNECTTIMEOUT  => 120,      // timeout on connect
                        CURLOPT_TIMEOUT                 => 120,      // timeout on response
                        // Disabling SSL verification
                        CURLOPT_SSL_VERIFYPEER  => false,    // Disable SSL certificate validation
                        CURLOPT_SSL_VERIFYHOST  => false,  // Disable host vs certificate validation
        );
 
        $handle = curl_init($url);
        curl_setopt_array($handle, $options);
        $response = curl_exec($handle);
        $errno = curl_errno($handle);
        $error_message = curl_error($handle);
        curl_close($handle);
 
        if ($errno !== 0)
        {
                echo "Problem opening URL: $url, $error_message\n";
                exit;
        }
        $decoded_response = json_decode($response, true);
        if ($decoded_response === false)
        {
                echo "Error: ".print_r($response, true)."\n";
        }
        else if ($decoded_response['code'] != 0)
        {
                echo $decoded_response['message']."\n";
        }
        else
        {
                echo "Ticket created.\n";
        }
}
else
{
        echo "Service state type !='HARD', doing nothing.\n";
}
```

### 用法

```bash
create-ticket.php <host> <service> <service_status> <service_state_type>
```

### 配置

编辑脚本开头的以下行（在脚本开头）以根据您的环境进行调整：

```php
// Configuration
$ITOP_URL = 'https://demo.combodo.com/simple';
$ITOP_USER = 'admin';
$ITOP_PWD = 'admin';
$TICKET_CLASS = 'UserRequest';
$TITLE = 'Service Down on %1$s';
$DESCRIPTION = 'The Service "%2$s" is down on "%1$s"';
$COMMENT = 'Created from PHP'
```

### 故障排除

您可以通过手动运行脚本来测试工单创建。例如，如果您的 iTop 中存在名为 Server1 的服务器，您可以运行以下命令来创建工单：

```bash
create-ticket.php "Server1" "Manual Test" "DOWN" "HARD"
```

## 使用 Perl

本节提供了一个用 **Perl** 脚本语言编写的示例脚本，用于在（远程）iTop 中使用 REST/JSON Web 服务创建工单。为了简化此示例，仅执行了最少的参数验证和返回状态验证。

要求：带有 LWP 和 JSON 模块的 Perl。

限制：Nagios 中的 "host" 值必须对应于 iTop 中唯一的 FunctionalCI。

以下 Perl 脚本创建一个 UserRequest 工单（您可以将配置更改为创建 Incident 或 Change），并将提供的 host（= FunctionalCI）附加到它。工单在与 host 相同的组织中创建。

```perl
#!/usr/bin/perl
use strict;
use warnings;
use LWP 5.64;
use JSON;
 
# Default values
my $ITOP_URL = 'https://demo.combodo.com/simple';
my $ITOP_LOGIN = "admin";
my $ITOP_PWD = "admin";
my $TICKET_CLASS = 'UserRequest';
my $DEFAULT_DESCRIPTION = 'Service "%1$s" is down on host "%2$s"';
my $DEFAULT_TITLE = 'Service down on "%1$s"';
my $COMMENT = "Created from $0";
 
# Parameters checking
my ($host, $service, $service_status, $service_state_type) = @ARGV;
if (not defined $host)
{
        die "Parameter 1: 'host' needed.\n";
}
if (not defined $service)
{
        die "Parameter 2: 'service' needed.\n";
}
if (not defined $service_status)
{
        die "Parameter 3: 'service status' needed.\n";
}
if (not defined $service_state_type)
{
        die "Parameter 4: 'service state type' needed.\n";
}
 
if ( ($service_status ne "OK" ) && ( $service_status ne "UP" ) && ( $service_state_type eq "HARD" ))
{
        my $url = "$ITOP_URL/webservices/rest.php?version=1.0";
        my $browser = LWP::UserAgent->new;
        $browser->ssl_opts(verify_hostname => 0, SSL_verify_mode => 0x00);
 
        my %ci_link = ( 'functionalci_id' => "SELECT FunctionalCI WHERE  name='$host'", 'impact_code' => 'manual');
 
        my %fields = (
                'org_id' => "SELECT Organization AS O JOIN FunctionalCI AS CI ON CI.org_id=O.id WHERE CI.name='$host'",
                'title' => sprintf($DEFAULT_TITLE, $host),
                'description' => sprintf($DEFAULT_DESCRIPTION, $service, $host),
                'functionalcis_list' => [ \%ci_link ],
        );
        my %data = (
                'operation' => 'core/create',
                'class' => $TICKET_CLASS,
                'comment' => $COMMENT,
                'output_fields' => 'id',
                'fields' => \%fields,
        );
 
        my $response = $browser->post($url, [
                'auth_user' => $ITOP_LOGIN,
                'auth_pwd' => $ITOP_PWD,
                'json_data' => encode_json \%data,
        ]);
 
        if ($response->is_success)
        {
                my $output = decode_json( $response->decoded_content);  # or whatever
                if ($output->{'code'} != 0)
                {
                        print $output->{'message'}."\n";
                }
                else
                {
                        print "Ticket created.\n";
                }                 
        }
        else
        {
                die $response->status_line;
        }
}
else
{
        print "Service state type !='HARD', doing nothing.\n";
}
```

### 用法

```bash
create-ticket.pl <host> <service> <service_status> <service_state_type>
```

### 配置

编辑脚本开头的以下行（在脚本开头）以根据您的环境进行调整：

```perl
# Default values
my $ITOP_URL = 'https://demo.combodo.com/simple';
my $ITOP_LOGIN = "admin";
my $ITOP_PWD = "admin";
my $TICKET_CLASS = 'UserRequest';
my $DEFAULT_DESCRIPTION = 'Service "%1$s" is down on host "%2$s"';
my $DEFAULT_TITLE = 'Service down on "%1$s"';
my $COMMENT = "Created from $0";
```

### 故障排除

您可以通过手动运行脚本来测试工单创建。例如，如果您的 iTop 中存在名为 Server1 的服务器，您可以运行以下命令来创建工单：

```bash
create-ticket.pl "Server1" "Manual Test" "DOWN" "HARD"
```

## 使用 Python

本节提供了一个用 **python** 脚本语言编写的示例脚本，用于在（远程）iTop 中使用 REST/JSON Web 服务创建工单。为了简化此示例，仅执行了最少的参数验证和返回状态验证。

要求：带有 requests、json 和（显然）sys 包的 python。

限制：Nagios 中的 "host" 值必须对应于 iTop 中唯一的 FunctionalCI。

以下 python 脚本创建一个 UserRequest 工单（您可以将配置更改为创建 Incident 或 Change），并将提供的 host（= FunctionalCI）附加到它。工单在与 host 相同的组织中创建。

```python
#!/usr/bin/python
import requests
import json
import sys
 
ITOP_URL = 'https://demo.combodo.com/simple'
ITOP_USER = 'admin'
ITOP_PWD = 'admin'
TICKET_CLASS = 'UserRequest'
TITLE = 'Service down on %(host)s'
DESCRIPTION = 'The service %(service)s is down on %(host)s'
COMMENT = 'Created from Python'
 
if len(sys.argv) != 5:
        print "Usage: "+sys.argv[0]+" host service service_status service_state_type\n"
        sys.exit()
else:
        print str(sys.argv)
        host = sys.argv[1]
        service = sys.argv[2]
        service_status = sys.argv[3]
        service_state_type = sys.argv[4]
 
if (service_status != "OK") and (service_status != "UP") and (service_state_type == "HARD" ):
        json_data = {
                'operation': 'core/create',
                'class': TICKET_CLASS,
                'fields': {
                        'title': TITLE % {'host': host },
                        'description': DESCRIPTION % {'host': host, 'service': service },
                        'org_id': 'SELECT Organization AS O JOIN FunctionalCI AS CI ON CI.org_id = O.id WHERE CI.name="%(host)s"' % {'host': host},
                        'functionalcis_list': [ {
                                'functionalci_id': "SELECT FunctionalCI WHERE name='%(host)s'" % {'host': host},
                                'impact_code': 'manual',
                        }],
                },
                'comment': COMMENT,
                'output_fields': 'id',
        }
        encoded_data = json.dumps(json_data)
        r = requests.post(ITOP_URL+'/webservices/rest.php?version=1.0', verify=False, data={'auth_user': ITOP_USER , 'auth_pwd': ITOP_PWD , 'json_data': encoded_data})
        result = json.loads(r.text);
        if result['code'] == 0:
                print "Ticket created.\n"
        else:
                print result['message']+"\n"
else:
        print "Service state type !='HARD', doing nothing.\n"
```

### 用法

```bash
create-ticket.py <host> <service> <service_status> <service_state_type>
```

### 配置

编辑脚本开头的以下行以根据您的环境进行调整：

```python
ITOP_URL = 'https://demo.combodo.com/simple'
ITOP_USER = 'admin'
ITOP_PWD = 'admin'
TICKET_CLASS = 'UserRequest'
TITLE = 'Service down on %(host)s'
DESCRIPTION = 'The service %(service)s is down on %(host)s'
COMMENT = 'Created from Python'
```

### 故障排除

您可以通过手动运行脚本来测试工单创建。例如，如果您的 iTop 中存在名为 Server1 的服务器，您可以运行以下命令来创建工单：

```bash
create-ticket.py "Server1" "Manual Test" "DOWN" "HARD"
```

## 使用 bash 和 wget

本节提供了一个用 **bash** 脚本语言编写的示例脚本，用于在（远程）iTop 中使用 REST/JSON Web 服务创建工单。为了简化此示例，仅执行了最少的参数验证和返回状态验证。

要求：bash 和 wget。

限制：Nagios 中的 "host" 值必须对应于 iTop 中唯一的 FunctionalCI。

以下 bash 脚本创建一个 UserRequest 工单（您可以将配置更改为创建 Incident 或 Change），并将提供的 CI 附加到它。工单在与 CI 相同的组织中创建。

```bash
#!/bin/bash
##################################################################################
#                                                                                #
# Example script for creating a UserRequest ticket via the REST/JSON webservices #
#                                                                                #
##################################################################################
 
# iTop location and credentials, change them to suit your iTop installation
ITOP_URL="https://demo.combodo.com/simple"
ITOP_USER="admin"
ITOP_PWD="admin"
 
 
# Parameters checking, see below for default values
if [ "$1" == "" ]; then
        echo "Missing parameter 1: host"
        exit -1
else
        HOST="$1"
fi
 
if [ "$2" == "" ]; then
        echo "Missing parameter 2: Service"
        exit -1
else
        SERVICE="$2"
fi
 
if [ "$3" == "" ]; then
        echo "Missing parameter 3: Service Status"
        exit -1
else
        SERVICE_STATUS="$3"
fi
 
if [ "$4" == "" ]; then
        echo "Missing parameter 4: Service State Type"
        exit -1
else
        SERVICE_STATUS_TYPE="$4"
fi
 
# Default values, adapt them to your configuration
TICKET_CLASS="UserRequest"
ORGANIZATION="SELECT Organization JOIN FunctionalCI AS CI ON CI.org_id=Organization.id WHERE CI.name='"${HOST}"'"
TITLE="Service Down on $1"
DESCRIPTION="The service $SERVICE is in state $SERVICE_STATUS on $HOST"
 
# Let's create the ticket via the REST/JSON API
if [[ ( "$SERVICE_STATUS" != "OK" ) && ( "$SERVICE_STATUS" != "UP" ) && ( "$SERVICE_STATUS_TYPE" == "HARD" ) ]]; then
        CIS_LIST='[{"functionalci_id":"SELECT FunctionalCI WHERE  name=\"'"$1"'\"", "impact_code": "manual"}]'
        JSON_DATA='{"operation":"core/create", "class":"'"${TICKET_CLASS}"'", "fields": {"functionalcis_list":'"${CIS_LIST}"', "org_id":"'"${ORGANIZATION}"'", "title":"'"$TITLE"'", "description":"'"$DESCRIPTION"'"}, "comment": "Created by the Monitoring", "output_fields": "id"}'
 
        RESULT=`wget -q --post-data='auth_user='"${ITOP_USER}"'&auth_pwd='"${ITOP_PWD}"'&json_data='"${JSON_DATA}" --no-check-certificate -O -  "${ITOP_URL}/webservices/rest.php?version=1.0"`
 
        PATTERN='"key":"([0-9])+"'
        if [[ $RESULT =~ $PATTERN ]]; then
                echo "Ticket created successfully"
        else
                echo "ERROR: failed to create ticket"
                echo $RESULT
        fi
else
        echo "Service State Type != HARD, doing nothing"
fi
```

### 用法

```bash
create-ticket.bash <host> <service> <service_status> <service_state_type>
```

### 配置

更改脚本顶部的 3 行以适应您的环境：

```bash
ITOP_URL="https://demo.combodo.com/simple"
ITOP_USER="admin"
ITOP_PWD="admin"
```

然后更改默认值以满足您的需求：

```bash
# Default values, adapt them to your configuration
TICKET_CLASS="UserRequest"
ORGANIZATION="SELECT Organization JOIN FunctionalCI AS CI ON CI.org_id=Organization.id WHERE CI.name='"${HOST}"'"
TITLE="Service Down on $1"
DESCRIPTION="The service $SERVICE is in state $SERVICE_STATUS on $HOST"
```

### 故障排除

您可以通过手动运行脚本来测试工单创建。例如，如果您的 iTop 中存在名为 Server1 的服务器，您可以运行以下命令来创建工单：

```bash
create-ticket.bash "Server1" "Manual Test" "DOWN" "HARD"
```

## 使用 bash 和 curl

本节提供了一个用 **bash** 脚本语言编写的示例脚本，用于在（远程）iTop 中使用 REST/JSON Web 服务更新工单。

复制粘贴此命令作为示例：

```bash
curl -X POST -F 'version=1.3' -F 'auth_user=admin' -F 'auth_pwd=admin' http://localhost/itop/webservices/rest.php --form-string 'json_data={"operation":"core/create","comment":"Synchronization from blah...", "class":"UserRequest","output_fields":"id, friendlyname", "fields":{"org_id":"SELECT Organization WHERE id=3", "caller_id":{"name":"monet","first_name":"claude"},"title":"issue blah","description":"something happened"}}'
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:advancedtopics:create_ticket>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/advancedtopics/create_ticket.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
