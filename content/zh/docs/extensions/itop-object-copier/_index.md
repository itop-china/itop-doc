---
title: "用户操作配置器"
linkTitle: "用户操作配置器"
date: 2025-06-27
weight: 15
description: "用户操作配置器（Object Copier）扩展，用于配置用户操作以简化和自动化流程，例如从配置项创建工单。"
---

{{% pageinfo %}}
本文档介绍用户操作配置器（Object Copier）扩展。该扩展旨在提高终端用户的工作效率，支持从现有对象快速创建预填充信息的新对象。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=extensions:itop-object-copier)。
{{% /pageinfo %}}

## 功能特性

此扩展旨在提高终端用户的工作效率。它添加了一个菜单，用于创建从现有对象预填充信息的新对象。

在可能的用途中，您可以：

- 提供快速克隆配置项的方法（克隆所有属性，但仍强制用户输入新名称）
- 提供从联系人创建工单的快捷方式，该联系人将作为工单的请求者
- 提供创建父工单的快捷方式（并在子工单中记录信息）
- 提供从配置项创建工单的快捷方式（并在子工单中记录信息）
- 提供从用户请求创建变更工单的快捷方式（并在用户请求中记录信息）

让我们使用最后一个示例来说明该模块的功能：

用户在用户请求的 **其他操作** 下拉菜单中看到一个选项：

点击菜单后，将打开标准创建表单，并预填充数据：

用户可以调整值，然后创建对象。除了标准报告外，还会显示一条消息，指示某些信息已回写到**源**对象。

### 工作原理

快捷方式由**规则定义**控制。

当满足一系列条件时，菜单才会可见：

- 正在查看的对象在规则范围内（由 OQL 给出）。例如，您可能只想为已分配或待处理的用户请求提供快捷方式：`SELECT UserRequest WHERE status IN ('assigned', 'pending')`
- 当前用户拥有规则允许的权限（可以是任何人）

对于单个**源对象**，可以共存多个规则：满足条件的规则有多少个，就会显示多少个菜单项。

规则定义要创建的对象类型：

- 可以是特定类（可以是抽象类，用户需要选择子类）
- 或者与**源**对象完全相同的类

规则指定了如何**预设**或**预填充**表单。这通过**操作**来实现。以下类型的操作可用：

- 根据**源**对象的一个或多个属性值设置属性的值
- 复制 N-N 链接（例如，克隆工单时的文档。文档不会被复制，只复制链接）
- 通过复制 1-N 链接对象来复制 1:N 链接（例如，服务器接口、变更上的工作单）
- 向**源对象**或**源对象**的外部键添加 N-N 链接

此外，规则还指定了如何将**创建的对象**中的某些信息**回写**到**源对象**。

## 限制

以下类型的属性目前无法处理，因此无法预设（且不会给出错误消息）：

- Blob（二进制大对象）
- 秒表（Stop watches）
- TagSet（可预设但无法保存）
- EnumSet（可预设但无法保存）

如果在 `preset` 中使用 `apply_stimulus()`，表单会显示对象 ID 和新状态对应的相关按钮，但随后无法"创建"对象，因为在触发器处理期间对象已经创建。

如果您在创建表单中复制或设置不一致的数据，这将不会被检测到。例如，与 XML 筛选条件不匹配的值、用户请求上请求者与组织不一致的情况。由对象复制规则的创建者来遵守规则。其根本原因是 iTop 始终将已设置的值和筛选返回的值视为有效值。原因是我们不想在用户不知情的情况下删除现有值。一个常见的例子是相关变更，它应该是一个开放的变更，但当该变更关闭时，我们不希望丢失关系（这在 2.4 或 2.5 中已修复）。

## 修订历史

| 发布日期 | 版本 | 说明 |
|----------|------|------|
| 2025-02-11 | 1.4.6 | N°7758 - 减少因无效规则导致的日志污染；N°7932 - 为 iTop 添加英式英语翻译 |
| 2024-01-30 | 1.4.5 | N°6893 - 感谢 @bdejin 更新中文翻译；N°5474 - 修复 DoCheckToWrite 失败后对象复制器损坏的 Bug；N°6276 - 对象复制器：直接创建已解决状态工单时出错；N°7301 - 创建对象时修复无效的 JS 文件 URI；N°7396 - 移除 WebPage::add_linked_script 方法；N°7614 - 对象复制器错误地强制将显示为属性的 AttributeLinksetIndirect 字段设为必填 |
| 2022-05-23 | 1.4.4 | N°5447 - 弃用未引用的旧 @deprecated 方法：对象复制器 |
| 2022-07-11 | 1.4.3 | 兼容 3.1 - 移除 import(application/itopwebpage.class.inc.php)；添加将标准邮箱复制到 OAuth 邮箱的配置 |
| 2022-03-22 | 1.4.2 | 从 iTop 扩展中移除所有已弃用函数 |
| 2021-12-21 | 1.4.1 | 添加西班牙语翻译 |
| 2021-09-29 | 1.4.0 | 支持 iTop 3.0；支持为"操作"菜单项添加图标和工具提示 |
| 2020-12-15 | 1.3.5 | 恢复 caselog 和 1:n 关系的复制，该功能在 1.3.2 中被破坏 |
| 2020-03-06 | 1.3.4 | 更新德语翻译 |
| 2019-06-12 | 1.3.3 | copy_scalar 现在正确复制生命周期状态属性；对象复制器兼容 iTop 2.6 之前版本 |
| 2019-03-26 | 1.3.2 | 修复使用对象复制器复制列表时的问题；修复 Stencils 操作中自定义日期格式 |
| 2019-01-16 | 1.3.1 | 安全加固 |
| 2018-12-19 | 1.3.0 | 新功能：复制附件（需要 iTop 2.6.0 或更高版本） |
| 2018-06-26 | 1.2.1 | 西班牙语翻译 |
| 2018-01-26 | 1.2.0 | 添加 copy_head 动词用于 CaseLog 属性 - 允许从最新日志创建新工单 |
| 2017-11-13 | 1.1.9 | 修复错误消息或工具提示中关于只读属性被设置的显示错误 |
| 2017-09-29 | 1.1.8 | 仅在目标类可写时显示操作 |
| 2017-04-04 | 1.1.7 | 案例日志：使用 set 时条目被设置两次，HTML 格式丢失，如果从源复制日志则会被破坏 |
| 2017-03-27 | 1.1.6 | 某些自定义（预设工单日期）时，依赖字段的刷新被破坏。iTop 2.3 引入的回归问题 |
| 2017-03-23 | 1.1.5 | 修复 XSS 漏洞 |
| 2016-08-09 | 1.1.4 | 兼容 iTop 2.3.0（仍向后兼容）：正确处理面包屑 + 修复使用隐藏字段和案例日志时的 Bug |
| 2015-10-05 | 1.1.3 | 兼容 iTop 2.2.0（仍向后兼容） |
| 2015-09-30 | 1.1.2 | 新动词：nullify。用于将日期或日期时间留空（与 reset 不同，因为此类属性的默认值是"现在"） |
| 2015-07-01 | 1.1.1 | 新动词：call_method。允许对目标对象（和/或源对象）进行任何修改 |
| 2015-02-03 | 1.1.0 | 添加占位符 `$current_date$` 和 `$current_time$`。添加动词 apply_stimulus。公开一些 API 以允许在其他模块（如 itop-stencils）中重用操作 |
| 2014-12-18 | 1.0.3 | 将默认配置翻译为法语（同时保留英语版本作为默认） |
| 2014-07-18 | 1.0.2 | 为 set() 和 append() 添加占位符：`$current_contact_id$`（已文档化）和 `$current_contact_friendlyname$`（新增） |
| 2014-04-03 | 1.0.1 | 修复链接集问题：链接在克隆中正确创建，但会从源对象中删除 |
| 2014-03-04 | 1.0.0 | 第一个正式发布的版本 |

## 安装

对此扩展使用[标准安装流程](https://www.itophub.io/wiki/page?id=extensions:installation)。

## 配置

### 字段

| 设置名称 | 说明 | 示例 |
|----------|------|------|
| `source_scope` | 定义**源对象**的 OQL。唯一可用的参数是 `current_contact_id` | `"SELECT UserRequest WHERE status = 'assigned'"` |
| `allowed_profiles` | 允许使用快捷方式的角色 CSV 列表。用户必须至少拥有一个角色才能使用快捷方式。错误的角色名称将被忽略。设置为空字符串以允许任何人使用。 | `"Administrator,Support Agent"` |
| `menu_label` | 可选：新菜单项的标签或字典条目。可选，默认为 "Clone…" | |
| `icon` | 1.4.0 新增：可选，Font Awesome 图标代码。详见下文关于图标的说明。 | |
| `menu_tooltip` | 1.4.0 新增：可选，操作菜单项的工具提示。可本地化 - 见下文说明。 | |
| `form_label` | 可选：表单标题的标签或字典条目。可选，默认为 "Cloning %1$s" | |
| `report_label` | 可选：对象创建后报告的标签或字典条目。可选，默认为 "Cloned from %1$s" | |
| `dest_class` | 要创建的对象类。如果为空，则默认为源对象的类 | `"Change"` |
| `preset` | 用于在创建表单中预设对象的**操作**数组。更多信息见下文。 | `array()` |
| `retrofit` | 用于将创建的对象中的某些信息回写到源对象的**操作**数组。更多信息见下文。 | `array()` |

### 操作

操作以字符串格式指定为 `verb(arg1[,arg2[…]])`。同一操作可以请求多次。

以下**动词**可用：

| 动词 | 参数 | 说明 |
|------|------|------|
| `clone_scalars` | `<none>` | 复制所有标量属性 |
| `clone` | `attcode1,attcode2, …` | 复制给定属性 |
| `reset` | `attcode` | 将属性重置为其默认值 |
| `nullify` | `attcode` | 1.1.2 新增 - 将属性重置为其空值（从终端用户角度看将显示为**未定义**） |
| `copy` | `att_to_read,att_to_write` | 从 `att_to_read` 复制到 `att_to_write` |
| `copy_head` | `att_to_read,att_to_write` | 1.1.11 新增 - 将 `att_to_read` 案例日志属性中的最后一条记录复制到 `att_to_write`。如果 `att_to_read` 不是案例日志，则抛出异常（非阻塞） |
| `append` | `attcode,string` | 将字符串追加到属性。字符串可以包含占位符，如 `$this->attcode$`（或 `$current_contact_id$`、`$current_contact_friendlyname$`、`$current_date$`、`$current_time$`）。逗号必须用反斜杠转义。允许使用换行符（`\n`）。字符集必须是 UTF-8。 |
| `set` | `attcode,value` | 设置一个值。如果值是字符串，则可以包含占位符，如 `$this->attcode$`（或 `$current_contact_id$`、`$current_contact_friendlyname$`、`$current_date$`、`$current_time$`）。逗号必须用反斜杠转义。允许使用换行符（`\n`）。字符集必须是 UTF-8。 |
| `add_to_list` | `attRead,attWrite,attLink,value` | `attRead` 是读取对象上的外部键，`attWrite` 是写入对象上的 N-N 链接集（AttributeLinkedSetIndirect），`attLink` 是链接类上的属性，将被设置为 `<value>` |
| `apply_stimulus` | `stimulus code` | 应用给定的触发器（保存对象）。**仅在 retrofit 中使用。** 最佳实践：强烈建议同时设置转换的必填字段，否则它们将保持为空，可能会破坏报告。 |
| `call_method` | `function name` | 1.1.1 新增 - 在写入对象上调用提供的方法。其原型必须是 `public function xxxx($oSource)`。函数可以在失败时抛出异常。在这种情况下，错误消息将显示在 `log/error.log` 文件中 |
| `clone_attachments` | `<none>` | 1.3.0 新增 - 需要 iTop 2.6+ - 将**源**的所有附件复制到**目标** |

### 示例

```php
'itop-object-copier' => array(
    'rules' => array(
        0 => array(
                'source_scope' => 'SELECT UserRequest WHERE status IN ("assigned", "pending")',
                'allowed_profiles' => 'Administrator,Support Agent',
                'menu_label' => 'Issue a change ticket...',
                'form_label' => 'Issue a change from request %1$s [...]',
                'report_label' => 'Issued from the request %1$s. The request has been updated.',
                'dest_class' => 'Change',
                'preset' => array(
                        'clone(contacts_list,functionalcis_list,org_id,title,caller_id)',
                        'set(description,Original description: $this->description$)',
                ),
                'retrofit' => array(
                        'copy(id, parent_change_id)',
                        'set(private_log,Issued change $this->ref$)',
                ),
        ),
        1 => array(
                'source_scope' => 'SELECT FunctionalCI',
                'allowed_profiles' => '',
                'dest_class' => '',
                'preset' => array(
                        'clone_scalars(*)',
                        'reset(name)',
                ),
                'retrofit' => array(
                ),
        ),
    ),
),
```

在上面的示例中，`0` 和 `1` 是规则的标识符。

- 您可以使用字符串而不是数字来标识对象复制规则（允许字符：空格、`A-Za-z0-9_=-`）。
- 内部菜单 UID 将按以下方式构建：`object_copier_` + 您给出的规则 ID。
- 因此，上述菜单的 UID 将是：`object_copier_0` 和 `object_copier_1`

### 默认配置

```php
    'itop-object-copier' => array (
       'rules' => array (
          'clone_location' => array (
            'source_scope' => 'SELECT Location',
            'allowed_profiles' => 'Administrator,Configuration Manager',
            'menu_label' => 'Clone...',
            'menu_label/FR FR' => 'Cloner...',
            'menu_tooltip' => 'Clone this location...',
            'menu_tooltip/FR FR' => 'Cloner ce lieu...',
            'icon' => 'fas fa-clone',
            'form_label' => 'Cloning %1$s',
            'form_label/FR FR' => 'Clonage de %1$s',
            'report_label' => 'Cloned from %1$s',
            'report_label/FR FR' => 'Cloné depuis %1$s',
            'dest_class' => 'Location',
            'preset' => array (
              0 => 'clone_scalars(*)',
              1 => 'reset(name)',
            ),
            'retrofit' => array (
            ),
          ),
          'child_userrequest' => array (
            'source_scope' => 'SELECT UserRequest WHERE status NOT IN (\'resolved\',\'closed\')',
            'allowed_profiles' => 'Support Agent,Administrator',
            'menu_label' => 'Create a child request...',
            'menu_label/FR FR' => 'Créer une demande fille...',
            'menu_tooltip' => 'Create a child request of this request...',
            'menu_tooltip/FR FR' => 'Créer une demande fille de cette demande...',
            'icon' => 'fas fa-comment-alt',
            'form_label' => 'Create a child request from %1$s',
            'form_label/FR FR' => 'Créer une demande fille depuis %1$s',
            'report_label' => 'Created from %1$s',
            'report_label/FR FR' => 'Créée depuis %1$s',
            'dest_class' => 'UserRequest',
            'preset' => array (
              0 => 'clone(caller_id,org_id,contacts_list,functionalcis_list)',
              1 => 'copy(id,parent_request_id)',
            ),
            'retrofit' => array (
            ),
          ),
          'userrequest_from_person' => 
          array (
            'source_scope' => 'SELECT Person',
            'allowed_profiles' => 'Support Agent,Administrator',
            'menu_label' => 'Create a user request...',
            'menu_label/FR FR' => 'Créer une demande utilisateur...',
            'menu_tooltip' => 'Create a user request for this person...',
            'menu_tooltip/FR FR' => 'Créer une demande utilisateur pour cette personne...',
            'icon' => 'fas fa-comment-alt',
            'form_label' => 'Create a user request from %1$s',
            'form_label/FR FR' => 'Créer une demande utilisateur pour %1$s',
            'report_label' => 'Created from %1$s',
            'report_label/FR FR' => 'Créée depuis %1$s',
            'dest_class' => 'UserRequest',
            'preset' => 
            array (
              0 => 'copy(org_id,org_id)',
              1 => 'copy(id,caller_id)',
            ),
            'retrofit' => array (
            ),
          ),
          'userrequest_from_ci' => array (
            'source_scope' => 'SELECT FunctionalCI',
            'allowed_profiles' => 'Support Agent,Administrator',
            'menu_label' => 'Create a user request...',
            'menu_label/FR FR' => 'Créer une demande utilisateur...',
            'menu_tooltip' => 'Create a user request for this CI...',
            'menu_tooltip/FR FR' => 'Créer une demande utilisateur pour cet objet...',
            'icon' => 'fas fa-comment-alt',
            'form_label' => 'Create a user request from  %1$s',
            'form_label/FR FR' => 'Créer une demande utilisateur pour %1$s',
            'report_label' => 'Created from %1$s',
            'report_label/FR FR' => 'Créée depuis %1$s',
            'dest_class' => 'UserRequest',
            'preset' => 
            array (
              0 => 'copy(org_id,org_id)',
              1 => 'add_to_list(id,functionalcis_list,impact,Impacted CI)',
            ),
            'retrofit' => array (
            ),
          ),
          'clone_ci' => array (
            'menu_tooltip' => 'Clone this CI...',
            'menu_tooltip/FR FR' => 'Cloner cet élément...',
            'icon' => 'fas fa-clone',
            'source_scope' => 'SELECT FunctionalCI',
            'allowed_profiles' => 'Administrator,Configuration Manager',
            'dest_class' => '',
            'preset' => array (
              0 => 'clone_scalars(*)',
              1 => 'reset(name)',
            ),
            'retrofit' => array (
            ),
          ),
          'userrequest_from_log' => array (
            'source_scope' => 'SELECT UserRequest WHERE status IN (\'closed\')',
            'allowed_profiles' => 'Support Agent,Administrator',
            'menu_label' => 'Create ticket with last log...',
            'menu_label/FR FR' => 'Créer une demande depuis le journal...',
            'menu_tooltip' => 'Create a ticket based on last log entry...',
            'menu_tooltip/FR FR' => 'Créer une demande basée sur la dernière entrée du journal...',
            'icon' => 'far fa-comment-alt',
            'form_label' => 'Create new request from %1$s',
            'form_label/FR FR' => 'Nouvelle demande depuis %1$s',
            'report_label' => 'Created from %1$s',
            'report_label/FR FR' => 'Créée depuis %1$s',
            'dest_class' => 'UserRequest',
            'preset' => array (
              0 => 'clone(caller_id,org_id,contacts_list,functionalcis_list)',
              1 => 'copy(id,parent_request_id)',
              2 => 'copy_head(public_log,description)',
            ),
            'retrofit' => array (
            ),
          ),
        ),
      ),
```

### 使用 call_method 的示例

这里我们想要复制一个 n:n 关系，它来自两个不同类别的链接，但性质相似。例如，您想从 FunctionalCI 创建一个变更工单，并自动检索与 CI 关联的联系人，然后将他们链接到变更。

```php
public function CopyContactsFromCI($oSource)
{
 
   $sEXPECTED_SOURCE_CLASS = "FunctionalCI";
   $sSOURCE_LNK_OQL = "SELECT lnkContactToFunctionalCI AS l WHERE l.functionalci_id = :id ";
   $sSOURCE_LNK_EXTKEY_TO_REMOTE = "contact_id";
 
   $sDEST_LNK_CLASS = "lnkContactToTicket";
   $sDEST_LNK_EXTKEY_TO_REMOTE = "contact_id";
   $sDEST_LNK_EXTKEY_TO_CURRENT = "ticket_id";
   $sDEST_LNK_ATTCODE = "contacts_list";
 
 
   // 此方法应由从 $sEXPECTED_SOURCE_CLASS 或其子类触发的对象复制操作调用。
   $sSourceClass = get_class($oSource);
   if (!MetaModel::IsParentClass($sEXPECTED_SOURCE_CLASS, $sSourceClass))
   {
      throw new Exception("Wrong source class '$sSourceClass' : 
        CopyContactsFromCI method should be called by a user action associated to a ".$sEXPECTED_SOURCE_CLASS." or one of its children classes");
   }        
   // 方法被调用两次：新创建对象显示时和保存时，导致代码执行两次。
   // 决定何时执行："apply_new" 表示对象正在保存，否则是在创建表单显示之前
   // $sOperation = utils::ReadPostedParam('operation');
   // if ($sOperation == 'apply_new') {  return;  }
 
   $id = $oSource->GetKey();
   $oSetSrc = new CMDBObjectSet(DBObjectSearch::FromOQL($sSOURCE_LNK_OQL), array(), array('id' => $id));
   // 确保也获取已废弃的对象，以防用户首选项隐藏了它们
   $oSetSrc->SetShowObsoleteData(utils::ShowObsoleteData());
   $oSetDst = $this->Get($sDEST_LNK_ATTCODE );
   if ($oSetDst->Count() > 0) { return; } // 保留用户的选择
 
   // 逐个复制链接对象
   while ($oLnkSrc = $oSetSrc->Fetch())
   {
       $oLnkDst = MetaModel::NewObject($sDEST_LNK_CLASS, [ 
           $sDEST_LNK_EXTKEY_TO_REMOTE => $oLnkSrc->Get($sSOURCE_LNK_EXTKEY_TO_REMOTE),
           // $sDEST_LNK_EXTKEY_TO_CURRENT => $this->GetKey(), // 在创建时键尚不可用，提交表单时会设置
       ]);
       $oSetDst->AddItem($oLnkDst);
   }
   $this->Set($sDEST_LNK_ATTCODE, $oSetDst);
}
```

```php
  3 => array (
    'source_scope' => 'SELECT FunctionalCI',
    'allowed_profiles' => 'Support Agent,Administrator',
    'menu_label' => 'Create a change...',
    'form_label' => 'Create a user request from  %1$s',
    'report_label' => 'Created from %1$s',
    'dest_class' => 'Change',
    'preset' => array (
         0 => 'copy(org_id,org_id)',
         1 => 'add_to_list(id,functionalcis_list,impact,Impacted CI)',
         2 => 'call_method(CopyContactsFromCI)',
         ),
    'retrofit' => array (),
),
```

### 将菜单显示为按钮

示例：要在工具栏中 **新建...** 和 **修改...** 按钮之后显示 **Clone…** 菜单（规则 ID=1），请设置：

```php
  'shortcut_actions' => 'UI:Menu:Modify,UI:Menu:New,object_copier_1',
```

如果指定菜单对给定类不可用，它将静默不显示。

## 故障排除

所有错误都记录到 `log/error.log` 文件中。

从终端用户的角度来看，行为如下：

- 当 `source_scope` 参数错误时，规则被忽略
- 当 `dest_class` 不是有效类时，规则被忽略
- 当 `source_scope`/`dest_class`/`allowed_profiles`/`preset`/`retrofit` 缺失时，规则被忽略
- 当角色列表包含错误名称时，这些名称将被忽略，如果列表中所有名称都错误，则没有人会有克隆对象的菜单
- 当预设操作错误（语法或语义）时，预设在该点停止，表单显示并附带说明问题的消息："在预设要创建的对象时遇到错误：`<error message>`。请联系您的管理员。" 用户可以继续创建对象。
- 当回写操作错误时，回写在该点停止，操作完成（对象按预期创建），报告中包含："在将某些信息回写到源对象时遇到错误：`<error message>`。请联系您的管理员。"

## 常见问题

**Q：当我尝试将 LinkedSet 属性（如 `contacts_list`）从工单复制到 FunctionalCI 时失败，为什么？**

**A：** 虽然 `contacts_list` 属性在工单和 FunctionalCI 上看起来相似，但实际上这些集合包含的对象完全不同，它们不属于同一个类：`lnkContactToTicket` 与 `lnkContactToFunctionalCI`，这是 `copy` 工作的强制性要求。

将链接到工单的所有联系人关联到正在创建的 FunctionalCI 的变通方法是使用上面解释的 **PHP 方法**。

**Q：当我尝试从一个工单创建另一个工单时，表单先预填充，但提交时失败并清空所有字段，为什么？**

**A：** 一个可能的原因是您尝试 `set` 控制所创建工单生命周期的 `status` 字段。这是不允许的，因为此字段是只读的，只能通过应用触发器来更改，触发器将执行与该转换关联的控制和操作。错误消息不是很明确。

**Q：我可以将当前对象添加到创建对象的 LinkedSet 属性中吗？**

**A：** 是的，这可以在回写中完成。

以下是在简单请求管理中的示例，它从用户请求创建一个事件并在第 14 行将它们链接在一起：

```php
10=>array(
    'source_scope'=>'SELECT UserRequest WHERE status NOT IN (\'resolved\',\'closed\')',
    'allowed_profiles'=>'Support Agent,Administrator',
    'menu_label'=>'Create incident from user request...',
    'form_label'=>'Create new incident from %1$s',
    'report_label'=>'Created new incident from %1$s',
    'dest_class'=>'Incident',
    'preset'=>array(
        0=>'clone(description,title,org_id,caller_id,team_id,agent_id,service_id)',
        1=>'clone(servicesubcategory_id, contacts_list,functionalcis_list,workorders_list)',
    ),
    'retrofit'=>array(
        0=>'set(private_log,Converted to incident $this->hyperlink()$.)',
        1=>'set(parent_request_id,$this->id$)',
        2=>'apply_stimulus(ev_autoresolve)',
        3=>'apply_stimulus(ev_close)',
    ),
),
```

**Q：克隆后我可以删除源对象吗？**

**A：** 您可以在回写中调用一个方法来删除源对象，它会完成工作，**但会显示一个红色顶部错误栏**，因为回写过程不期望源对象在其工作过程中消失。没有真正的问题，但错误可能会误导阅读它的用户。

```php
public function DeleteSource($oObject) 
{  $this->DBDelete(); }
```

```php
        'retrofit' => array (
          0 => 'call_method(DeleteSource)',
        ),
```

**Q：克隆用户请求时我可以复制请求模板（`service_details`）吗？**

**A：** 不可以。目前无法正确工作。

**Q：克隆工单时我可以复制案例日志吗？**

**A：** 此扩展支持该功能，但 1.3.2 到 1.3.4 版本除外。在 1.3.5 中，有一个已知问题：它会复制在克隆对象创建期间制作的条目。

**Q：克隆工单时我可以复制工作单吗？**

**A：** 此扩展支持该功能，但 1.3.2 到 1.3.4 版本除外。

变通方法：您可以编写一个方法来实现。

- 限制：子对象在表单提交时在后台复制。您之后需要修改或删除不适用的那些。

```php
public function CloneWorkorders($oSource)
{
    // 由 Object-Copier 调用的方法
    // 修改以下两个字符串以匹配您的需求
    $sAllowedSourceClass = 'Ticket'; // 源对象的类
    $sSetAttCode = 'workorders_list'; // 要复制的 n-1 关系属性代码
 
    if (!MetaModel::IsValidAttCode(get_class($this), $sSetAttCode))
    {
        throw new Exception(__METHOD__.":Unknown attribute ".get_class($this)."::".$sSetAttCode);
    }
    if (!MetaModel::IsParentClass($sAllowedSourceClass, get_class($oSource)))
    {
        throw new Exception(__METHOD__.":Wrong source class 'get_class($oSource)' : 
            This method should be called by a user action associated to a '$sAllowedSourceClass'");
    }
    // 检查 AttributeDef 是否为 AttributeLinkedSet
    $oSourceAttDef = MetaModel::GetAttributeDef(get_class($oSource), $sSetAttCode);
    if (is_object($oSourceAttDef) && !$oSourceAttDef->IsLinkSet())
    {
        throw new Exception(__METHOD__.":Attribute ".$sSetAttCode
                ." is not a LinkSet on class ".get_class($this));
    }
    // 为避免混淆用户，我们仅在提交时应用此操作
    // 否则复制的对象似乎会出现在表单上，但添加或删除一些会被忽略。
    $sOperation = utils::ReadPostedParam('operation');
    if ($sOperation != 'apply_new')
    {
        return;
    }
 
    $oDestSet = $this->Get($sSetAttCode);       
    $oSet = $oSource->Get($sSetAttCode);
 
    while($oSourceObject = $oSet->Fetch())
    {         
        $sClass = get_class($oSourceObject);
        $oClone = MetaModel::NewObject($sClass);
        foreach(MetaModel::ListAttributeDefs($sClass) as $sAttCode => $oAttDef)
        {
            // 目前，忽略非标量属性
            if ($oAttDef->IsScalar() && $oAttDef->IsWritable())
            {
                $oClone->Set($sAttCode, $oSourceObject->Get($sAttCode));
            }
        }
        $oDestSet->AddItem($oClone);
    }
    $this->Set($sSetAttCode,$oDestSet);
}
```

---
原文：<https://www.itophub.io/wiki/page?id=extensions:itop-object-copier>

版本：extensions/itop-object-copier.txt · Last modified: 2025/06/13 11:45 by 127.0.0.1
