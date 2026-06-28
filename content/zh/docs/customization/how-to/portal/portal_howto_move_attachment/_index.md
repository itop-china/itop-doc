---
title: "门户 - 在表单中定位附件"
linkTitle: "门户 - 在表单中定位附件"
date: 2025-06-27
weight: 100
description: >
    自 iTop 3.2.1 起，可在门户表单中更改附件的位置。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 门户表单中自定义附件的位置。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_move_attachment)。
{{% /pageinfo %}}

## 实现方法

在表单的 twig 中定义一个额外字段，该字段将被识别为放置附件的位置：

```html
<div class="form_field" data-field-id="attachments_plugin" data-field-plugin="AttachmentPlugIn" data-field-opened="true"/> 
```

注意 `data-field-opened="true"` 参数，用于强制附件默认打开或关闭。

## 完整 twig 示例

```xml
<module_designs>
  <module_design id="itop-portal">
    <forms>
      <form id="ticket-edit" _delta="must_exist">
        <twig _delta="redefine">
          <div class="row">
            <div class="col-sm-7">
              <fieldset>
                <legend>{{'Ticket:baseinfo'|dict_s}}</legend>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="title" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="service_id" data-field-flags="read_only"/>
                </div>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="caller_id" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="servicesubcategory_id" data-field-flags="read_only"/>
                </div>
                <div class="col-sm-12">
                  <div class="form_field" data-field-id="description" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="solution" data-field-flags="read_only"/>
                </div>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="user_satisfaction" data-field-flags="read_only"/>
                </div>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="user_comment" data-field-flags="read_only"/>
                </div>
              </fieldset>
            </div>
            <div class="col-sm-5">
              <fieldset>
                <legend>{{'Ticket:Type'|dict_s}} &amp; {{'Ticket:date'|dict_s}}</legend>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="status" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="impact" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="urgency" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="priority" data-field-flags="read_only"/>
                </div>
                <div class="col-sm-6">
                  <div class="form_field" data-field-id="start_date" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="last_update" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="resolution_date" data-field-flags="read_only"/>
                  <div class="form_field" data-field-id="agent_id" data-field-flags="read_only"/>
                </div>
              </fieldset>
            </div>
          </div>
          <div>
            <div class="form_field" data-field-id="attachments_plugin" data-field-plugin="AttachmentPlugIn" data-field-opened="true"/>
            <div class="form_field" data-field-id="contacts_list"/>
            <div class="form_field" data-field-id="public_log"/>
          </div>
        </twig>
      </form>
    </forms>
  </module_design>
</module_designs>
</itop_design>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_move_attachment>

版本：3_2_0/customization/portal_howto_move_attachment.txt · Last modified: 2025/10/10 15:21 by 127.0.0.1
