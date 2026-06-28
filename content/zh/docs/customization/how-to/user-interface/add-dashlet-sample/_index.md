---
title: "iframe 仪表盘"
linkTitle: "iframe 仪表盘"
date: 2025-06-27
weight: 10
description: >
  创建 iframe 仪表盘组件。
---

{{% pageinfo %}}
本文档介绍如何创建自定义 iframe 仪表盘组件，用于在控制台仪表盘中嵌入外部网页。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashlet-sample)。
{{% /pageinfo %}}

## 概述

本教程将指导您一步步创建 iTop 扩展模块，添加一个新的仪表盘组件类型：iframe 仪表盘。该组件可以嵌入外部网页到 iTop 控制台仪表盘中。

## 前置条件

- 已安装 iTop 开发环境
- 可编辑 PHP 和 XML 文件的文本编辑器（支持 UTF-8）

## 定制流程

1. 安装 iTop 开发实例（请勿在生产环境实验）
2. 安装工具包辅助定制
3. 使用扩展创建向导生成空模块
4. 将模块复制到 `extensions` 目录并运行安装向导
5. 修改模块代码并使用工具包验证

## 创建扩展模块

使用扩展创建向导，填写以下信息：

| 标签 | 值 | 说明 |
|------|-----|------|
| 模块名称 | sample-add-dashlet | 名称不能以 `itop-` 或 `combodo-` 开头，不建议使用空格或特殊字符 |
| 模块标签 | Add Dashlet Sample | 安装向导中显示的模块名称，允许使用本地化字符和空格 |
| 模块版本 | 1.0.0 | 使用三位版本号：X.Y.Z |
| 类别 | business | 修改数据模型的模块应属于 business 类别 |

点击 **Generate!** 下载空模块压缩包。

## 安装空模块

将压缩包解压到开发 iTop 实例的 `extensions` 目录中。模块文件夹包含以下文件：

- `datamodel.sample-add-dashlet.xml`
- `module.sample-add-dashlet.php`
- `en.dict.sample-add-dashlet.php`
- `model.sample-add-dashlet.php`

确保 `conf/production/config-itop.php` 对 Web 服务器可写，然后访问 `http://your_itop/setup/` 运行安装向导，选择 **Update an existing instance**，在扩展列表中勾选您的模块完成安装。

## 添加 IFrameDashlet 类

在扩展目录中创建 `iframedashlet.class.inc.php` 文件。

### 基础类结构

```php
<?php
class DashletIFrame extends Dashlet
{
    public function __construct($oModelReflection, $sId)
    {
        parent::__construct($oModelReflection, $sId);
    }

    static public function GetInfo()
    {
    }

    public function GetPropertiesFields(DesignerForm $oForm)
    {
    }

    public function Render($oPage, $bEditMode = false, $aExtraParams = array())
    {
    }
}
```

### 实现 GetInfo 方法

`GetInfo` 返回仪表盘的基本信息（标签、图标、描述），用于仪表盘编辑器的"可用组件"菜单中：

```php
static public function GetInfo()
{
    return array(
        'label' => Dict::S('UI:DashletIframe:Label'),
        'icon' => 'env-'.utils::GetCurrentEnvironment().'/sample-add-dashlet/images/iframe.png',
        'description' => Dict::S('UI:DashletIframe:Description'),
    );
}
```

### 实现 GetPropertiesFields 方法

`GetPropertiesFields` 构建组件的配置表单，定义用户需要填写的参数：

```php
public function GetPropertiesFields(DesignerForm $oForm)
{
    $oField = new DesignerLongTextField('url', Dict::S('UI:DashletIframe:Prop-Url'), $this->aProperties['url']);
    $oField->SetMandatory();
    $oForm->AddField($oField);

    $oField = new DesignerIntegerField('width', Dict::S('UI:DashletIframe:Prop-Width'), $this->aProperties['width']);
    $oField->SetMandatory();
    $oForm->AddField($oField);

    $oField = new DesignerIntegerField('height', Dict::S('UI:DashletIframe:Prop-Height'), $this->aProperties['height']);
    $oField->SetMandatory();
    $oForm->AddField($oField);
}
```

### 实现 Render 方法

`Render` 负责组件的 HTML 渲染：

```php
public function Render($oPage, $bEditMode = false, $aExtraParams = array())
{
    $sUrl = $this->aProperties['url'];
    $iWidth = (int) $this->aProperties['width'];
    $iHeight = (int) $this->aProperties['height'];

    $oPage->add('<div class="dashlet-content">');

    $sId = utils::GetSafeId('dashlet_iframe_'.($bEditMode? 'edit_' : '').$this->sId);
    $oPage->add('<iframe id="'.$sId.'" width="'.$iWidth.'" height="'.$iHeight.'" frameborder="0" src="'.$sUrl.'"></iframe>');

    if($bEditMode)
    {
        $oPage->add('<div style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; cursor: not-allowed;"></div>');
    }

    $oPage->add('</div>');
}
```

### 完整类代码

```php
<?php
class DashletIFrame extends Dashlet
{
    public function __construct($oModelReflection, $sId)
    {
        parent::__construct($oModelReflection, $sId);
        $this->aProperties['url'] = '';
        $this->aProperties['width'] = 600;
        $this->aProperties['height'] = 650;
        $this->aCSSClasses[] = 'dashlet-inline';
    }

    public function Render($oPage, $bEditMode = false, $aExtraParams = array())
    {
        $sUrl = $this->aProperties['url'];
        $iWidth = (int) $this->aProperties['width'];
        $iHeight = (int) $this->aProperties['height'];

        $oPage->add('<div class="dashlet-content">');

        $sId = utils::GetSafeId('dashlet_iframe_'.($bEditMode? 'edit_' : '').$this->sId);
        $oPage->add('<iframe id="'.$sId.'" width="'.$iWidth.'" height="'.$iHeight.'" frameborder="0" src="'.$sUrl.'"></iframe>');

        if($bEditMode)
        {
            $oPage->add('<div style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; cursor: not-allowed;"></div>');
        }

        $oPage->add('</div>');
    }

    public function GetPropertiesFields(DesignerForm $oForm)
    {
        $oField = new DesignerLongTextField('url', Dict::S('UI:DashletIframe:Prop-Url'), $this->aProperties['url']);
        $oField->SetMandatory();
        $oForm->AddField($oField);

        $oField = new DesignerIntegerField('width', Dict::S('UI:DashletIframe:Prop-Width'), $this->aProperties['width']);
        $oField->SetMandatory();
        $oForm->AddField($oField);

        $oField = new DesignerIntegerField('height', Dict::S('UI:DashletIframe:Prop-Height'), $this->aProperties['height']);
        $oField->SetMandatory();
        $oForm->AddField($oField);
    }

    static public function GetInfo()
    {
        return array(
            'label' => Dict::S('UI:DashletIframe:Label'),
            'icon' => 'env-'.utils::GetCurrentEnvironment().'/itop-iframe-dashlet/images/iframe.png',
            'description' => Dict::S('UI:DashletIframe:Description'),
        );
    }
}
```

## 验证修改

使用工具包验证修改：访问 `http://your_itop/toolkit`，修复所有错误后，点击 **Update iTop Code and Database!** 应用修改。

此时在 iTop 欢迎页面点击 **Edit this page**，可在仪表盘组件列表中看到 "iFrame" 选项。

## 添加元信息

编辑 `datamodel.sample-add-dashlet.xml`，添加仪表盘元信息，使其可在 ITSM Designer 中使用：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
  <meta>
    <dashlets>
      <dashlet id="DashletIFrame" _delta="define">
        <label>iFrame</label>
        <icon>itop-iframe-dashlet/images/iframe.png</icon>
        <description>Embed external web page as a dashlet.</description>
        <configuration>
          <url>http://via.placeholder.com/600x300</url>
          <width>600</width>
          <height>300</height>
        </configuration>
      </dashlet>
    </dashlets>
  </meta>
</itop_design>
```

## 部署

将 `sample-add-dashlet` 文件夹复制到目标 iTop 实例的 `extensions` 目录，重新运行安装向导即可。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashlet-sample)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashlet-sample>

版本：3_2_0/customization/add-dashlet-sample.txt · Last modified: 2026/03/16 14:02 by 127.0.0.1
