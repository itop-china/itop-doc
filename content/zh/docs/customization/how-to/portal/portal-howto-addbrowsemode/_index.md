---
title: "添加新的浏览模式"
linkTitle: "添加新的浏览模式"
date: 2025-06-27
weight: 10
description: >
  添加新的浏览模式。
---

{{% pageinfo %}}
本文档介绍如何为 BrowseBrick 添加新的浏览模式。本示例使用 Microsoft Metro UI 风格，但您可以根据需要实现任何样式（如轮播图等）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_addbrowsemode)。
{{% /pageinfo %}}

## 概述

在本教程中，我们将为 BrowseBrick 添加一种新的浏览对象的方式。本示例使用 Microsoft Metro UI 风格，但您可以根据需要实现任何样式（如轮播图 carousel）。

## 前提条件

- 知道如何制作 iTop 扩展并升级系统
- 拥有安装了演示数据和增强版门户的 iTop 系统
- 拥有足够权限访问门户的账户（通常需要 "Portal User" 角色）
- 了解 twig 和 CSS 语言（如果要自定义本示例）

## 教程目标

在本教程中，您将学习如何：

- 向现有 BrowseBrick 添加新的浏览模式

## 分步说明

### 1. 创建扩展

首先，创建一个将修改门户 XML 配置的 iTop 扩展。如有必要，请查看定制指南中的[扩展模块](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)部分。

- 将扩展命名为 `sample-portal-add-browse-mode-to-browse-brick`
- 删除 `main.sample-portal-add-browse-mode-to-browse-brick.php` 文件，因为我们不需要 PHP 代码

### 2. 创建模板

现在需要创建将为该浏览模式渲染的模板。首先为这个模式选择一个名称，本示例中我们选择 `metro`。

然后创建一个名为 `browsebrick-mode-metro.html.twig` 的 twig 文件，并复制粘贴以下代码（文件名不重要）：

```twig
{# itop-portal-base/portal/src/views/bricks/browse/mode_tree.html.twig #}
{# Browse brick tree mode layout #}
{% extends 'itop-portal-base/portal/src/views/bricks/browse/layout.html.twig' %}
 
{% block bBrowseMainContent %}
    <div id="brick-content-metro">
    </div>
{% endblock %}
 
{% block pPageLiveScripts %}
    {{ parent() }}
 
    <script type="text/javascript">
        var browseMode = '{{ sBrowseMode }}';
        var levelsProperties = {{ aLevelsProperties|raw }};
        var rawDatas = {{ aItems|raw }};
 
        $(document).ready(function(){
            for(var i in rawDatas)
            {
                var itemKeys = Object.keys(rawDatas[i]);
                var itemLastLevelAlias = itemKeys[itemKeys.length - 1];
 
                $('<div class="browse-element vertical-center">'+rawDatas[i][itemLastLevelAlias].name+'</div>').appendTo('#brick-content-metro');
            }
            $('<div style="clear: both"></div>').appendTo("#brick-content-metro");
        });
    </script>
{% endblock %}
```

开始时我们扩展了 BrowseBrick 布局，这样就不需要重新定义整个页面模板。然后我们放置一些标记来定义对象容器，并添加一个 JavaScript 片段来解析 JSON 数据并填充容器。

现在创建一个 CSS 文件来应用样式。命名为 `browsebrick-mode-metro.css` 并复制粘贴以下代码：

```css
#brick-content-metro{
        padding: 20px;
}
#brick-content-metro .browse-element{
        float: left;
        margin: 0 0.5% 10px 0.5%;
        width: 19%;
        height: 120px;
        text-align: center;
        background-color: #EA7D1E;
        color: #FFFFFF;
        box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12)
}
#brick-content-metro .browse-element:hover{
        opacity: 0.85;
        transition: all linear 0.2s;
}
```

### 3. 修改门户配置

现在扩展已准备好，我们只需要制作一个 XML delta 并更改门户配置以使用它。打开 `datamodel.sample-portal-add-browse-mode-to-browse-brick.xml` 文件并粘贴以下代码：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  version="1.0">
  <module_designs>
    <module_design id="itop-portal" xsi:type="portal">
      <properties>
        <themes>
          <theme id="sample-portal-add-browse-mode-to-browse-brick" _delta="define">sample-portal-add-browse-mode-to-browse-brick/browsebrick-mode-metro.css</theme>
        </themes>
      </properties>
      <bricks>
        <brick id="services" xsi:type="Combodo\iTop\Portal\Brick\BrowseBrick">
          <browse_modes>
            <availables>
              <mode id="metro" _delta="define">
                <template>sample-portal-add-browse-mode-to-browse-brick/browsebrick-mode-metro.html.twig</template>
              </mode>
            </availables>
          </browse_modes>
        </brick>
      </bricks>
    </module_design>
  </module_designs>
</itop_design>
```

这添加了一个 `theme` 节点用于 Brick 的 CSS，以及一个 `mode` 节点用于 Brick 的可用浏览模式。确保路径和文件名与您的系统一致。

### 4. 升级系统

最后，使用新扩展选项运行 iTop 系统升级并访问门户。您将看到新模式现在可在"New request" Brick 的右上角使用。

## 下载

您可以在以下地址找到此扩展：`sample-portal-add-browse-mode-1.0.1-156.zip`

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_addbrowsemode>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/portal_howto_addbrowsemode.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
