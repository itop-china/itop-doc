---
title: "iTop 变更日志"
linkTitle: "变更日志"
date: 2025-06-27
weight: 10
description: >
  iTop 各版本的完整变更日志，包括 3.2.x、3.1.x、3.0.x、2.7.x 等所有版本的变更记录。
---

{% pageinfo %}
本文档为 iTop 各版本的完整变更日志。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log)。
{% /pageinfo %}

# iTop 变更日志

# 3.2.x

## 3.2.3-1

#### 用户体验

- N°5228 - Unable to customize Darkmoon using
designer

- N°7909 - Fix spacing between fields when columns
collapse

- N°7939 - Improve activity panel tab togglers when
there's more than 2 log attributes

- N°7982 - Customize the size of drop-down
menus.

- N°8006 - Rich text editor : list of fonts partially
hidden

- N°8178 - Creation cancellation respects
“high_cardinality_classes” flag in search

- N°8524 - incorrect display for grant matrix and
dark moon theme (+/-compact)

- N°8570 - Allow @ as part of url

- N°8576 - [RequestTemplate] Slowness during the
selection of drop-down list field

- N°8597 - Fix special characters being escaped for
BrowseBrick items in “Tree” mode

- N°8737 - Search: Fix criteria dropdown overflowing
vertically on small screens

- N°8748 - Implement horizontal scroll for Long Text
attributes

- N°8758 - Log must_prompt and mandatory - requires
double-click to confirm

- N°8766 - Wrong log author on portal after author
user is disabled

- N°8954 - Fix lost of linkedset additional
information during host object modification

- N°9043 - Search: Fix automatic search not following
high cardinality setting

- N°9121 - CSV Import : The advanced mode option no
longer works as before.

- N°9177 - Blockquote inHTMLfield are unreadable in
darkmoon

- N°9223 - Portal - AttributeExternalKey or
AttributeEnum are not displayed after adding a link.

- N°9468 - Fix double scroll down bars in user
profiles selection

#### 稳定性

- N°2683 - EnhancedSLAComputation: use common
extension mechanism

- N°4058 - Fix Setup with an un-initialized encrypted
fields

- N°4250 - Fix unencryption when the attribute is
empty

- N°8234 - Event sub-classes secured, must be granted
by profile

- N°8663 - Fix DoCheckToWrite in portal

- N°8673 - Avoid server overload when user access
news page with a lot of unread news

- N°8681 - Fix deprecated: preg_match_all(): Passing
null to parameter #2 ($subject)

- N°8692 - Fix AttributeSubitem placeholder in
Notification

- N°8693 - Limitation: archived objects cannot be
imported

- N°8834 - [US] Add compatibility with PHP 8.4

- N°8838 - Fix 3.2.2 regression: backup status HS if
'mysql_bindir' has a value

- N°9101 - ImproveHTMLmarkup for end-to-end tests
automation

#### 安全性

- 32 security issues have been resolved and will be
revealed after the CVE publication in 3 months in line with ourpolicy

## 3.2.2-1

#### Improvements

- N°8419 - No update of the attachment table at Setup
when contact_id is already set (performance)

- N°8351 - Add friendlyname in every list in pdf
export of impact analysis

- N°6925 - Add on any search result, a link to edit
the OQL query (Run queries)

- N°2583 - SuperUser can “CSV import” and “Universal
search” classes such as User, Audit, Query,…

- N°7922 - Add capability to import trigger and
notification for SuperUSer

#### Fixes

- N°7900 - Export v2 does not work with auth-token
and format=html : limitation added to documentation

- N°8460 - Remove outdated or duplicated
elements

- N°8456 - Fix friendly name on
lnkErrorToFunctionalCI

- N°8436 - Fix CreateBrick when used with an abstract
class

- N°8406 - Fix typo in two french translations

- N°8377 - Fix missing rights on change ITIL for
SuperUser

- N°8367 - Add helper method to create an
ObjectResult from a DBObject

- N°8308 - Change Laminas email message encoding (Fix
brokenURL)

- N°8293 - Make multiple modal in portal place
correctly stack the backdrop

- N°8286 - Be able to add metadata in iTop json
session files via custom classes

- N°8260 - Change format of REST logs when they are
close to the SQL field size limit

- N°8251 - User Rights PHP 8.3 deprecation fix when
bulk assign

- N°8148 - Fix CAS problem by not sending links
ending with &

- N°8028 - Fix MySQL (8+) error during the
downloading of the system report

- N°8167 - Fix core update not working for modules
magically selected at setup

- N°8395 - Fix php8.1 compatibility in class extended
Exception

- N°8399 - Portal: no screen is displayed during a
transition with no field to display (attachments ignored)

- N°8365 - Portal: do not apply impact analysis
otherwise Ticket cannot be created due to CIs not allowed to the
user

- N°8340 - Improve ckeditor integration performances
with large texts

- N°8232 - Improve CKEditor block code edition, fix
lines repeatedly added after blocks

- N°8076 - Fix cancel and close buttons in a modal
blocking all buttons for the underlying object

- N°7960 - Log silent errors when translations have
argument number disparities

- N°7887 - Fix invalid value for unchanged warning in
synchro_import summary response

#### 安全性

- N°8379 - CVE-2025-47286 - Remote Code Execution in
the backup creation functionality

- N°8356 - CVE-2025-64167 - Reflected XSS in
webservices/export.php

- N°8355 - CVE-2025-47932 - Reflected XSS in
ajax.render.php render_dashboard

- N°8316 - CVE-2025-49145 - Webhooks: check that
callbacks signatures meet the documented expectation

- N°8315 - CVE-2025-48055 - XSS in user portal browse
brick

- N°8313 - CVE-2025-47773 - XSS vulnerability in the
/pages/ajax.render.php

- N°8205 - Fix stored XSS in manage brick's
table

- N°8201 - CVE-2025-48065 - Fix XSS reflected at the
name=“attr_installed” (Low or Medium)

- N°8198 - CVE-2025-48878 - IDOR with
ModuleInstallation object

- N°8168 - Fix stored XSS in portals lnk

## 3.2.1-1

#### Regression & security

- N°8242 - Fix of dashlet edition with dependent
parameters, values not refreshed immediately

- N°8272 - Portal: fix saving of date in French
format

- N°8245 - Fix edition of ExternalKey being a field
of an n:n relation (eg. SLA in CustomerContracts of a
Service)

- N°8305 - Fix missing SSO Buttons displayed on login
screen with multiple OpenID providers

- N°8278 - Fix re-declaration of
ComposerAutoloaderInitxxxxxx class

- N°8231 - Sensitive attributes are now sanitized
(replaced by “*”) in rest service logs.

- N°8174 - Fixed by replacing password values by “*”
in REST logs

## 3.2.1

#### 用户相关

- N°5079 - Fix misleading “leave confirmation” alert
after creating a Global Request

- N°6613 - Save user image only when image is
valid.

- N°7219 - Fix broken dashboard having special
caracters in their title

- N°7633 - Fix object display slowness in case of
long history

- N°7639 - Switching tab without reloading the data
table

- N°7658 - Changed FR labels on date search by “Du” —
“au” — to make them shorter

- N°7746 - Disable the Case Log edition button when
the user is not allowed to edit the object

- N°7759 - Add EN/FR tooltips on Organization and
Delivery Model classes

- N°7774 - Improve in News center, the tooltip to
navigate to Notification subscription

- N°7792 - CAS : Fix white page when navigating after
a long pause

- N°7820 - Fix Newsroom Tooltips

- N°7874 - Fix inline images deleted by garbage
collector in some cases

- N°7898 - Inserted precanned reply andFAQadvanced at the cursor
position. Thanks to @jbostoen

- N°7903 - Fix on-going demand brick broken with
Global Demand 1.5+

- N°8134 - Fix Portal user profil brick edition

- N°8144 - Issue using Organization filtering
box

#### For administrator

- N°5039 - DataSynchro : Change column type to
MEDIUMTEXT for importing linkset with the object

- N°7111 - Removed misleading link presented at the
end of the setup

- N°7206 - Fix TriggerOnStateEnter not called on
transition without change of state

- N°7228 - Webhook JSON: Fix double quotes, new
lines, tabs, etc in object data. Format without double-quotes is
abandoned.

- N°7664 - Add support for PowerAutomate

- N°7721 - Add default configuration to authent-token
module

- N°7728 - Fix add_linked_script /
add_linked_stylesheet flooding error.log

- N°7750 - Display OQL shortcut page just like “run
queries”.

- N°7777 - Hide tab “Last executions” in Action
creation

- N°7803 - Fix installation issue (either an
extension from iTop Hub or a new component from the Designer)

- N°7852 - Class tree display in “User Rights” tab
fixed for classes with non displayed parent.

- N°7858 - Fix Backup not performed on first
execution

- N°7871 - Fix migration to itop3.2.1 with trigger
“on object mention” without “mentioned filter”

- N°7906 - UserPreference class: add list, search
criteria and reconciliation

- N°7916 - Fix missing charset when sending emails
with attachments

- N°7917 - Fix emails classified as spam due to
incorrect `Message-ID` thanks to @vlk-charles

- N°7925 - Fix incorrectly formatted In-Reply-To
email header

- N°7997 - Fix Sharing Base compatible with iTop
>= 3.1+

- N°8001 - Fix issue with TriggerOnObjectMention on
News without icon

- N°8008 - Webhooks: Fix update of triggering object
on process response callback

- N°8047 - New SuperUser iTop Profile, similar to an
Administrator without Configuration and Backup

#### For iTop designers

- N°1000 - Harmonize filters results in portal browse
brick

- N°5791 - Allow more syntaxes on obsolescence
condition: IN, NOT IN, LIKE, NOT LIKE

- N°7145 - Support XML default DateTime value. New
default empty instead of now!

- N°7383 - FilterBrick on ManageBrick: enable
changing criteria even if nothing found

- N°7756 - Allow AttributeClass to declare
“class_category” empty in XML

- N°7762 - Improved the feedback when a deprecated
function of PHP is called

- N°7845 - Preventive fix of wrong date computation
with PHP 8.2+, but not an issue apparently

- N°7847 - Fix regression preventing an extension to
define an PHP interface

- N°7873 - Fix brick visibility despite XML security
tag “allowed profiles”

- N°7886 - Remove deprecated datamodel methods
(SetAssignmentDate)

- N°7927 - Added context “Setup” to Hub connector,
Designer connector and unattended install

- N°7987 - Enable customization of manage brick page
template

- N°7995 - Allow to redefine portal twig template for
all bricks in a portal

- N°8019 - Enrich 4 events with transition
information “stimulus_applied”

- N°8031 - Make all portal bricks use custom
templates for all templates

- N°8050 - Allow any external libraries imported by
composer in iTop extensions

- N°8108 - EVENT_DB_AFTER_WRITE: add previous values
in $oEventData→Get('changes')

- N°8129 - Dont crash if date/time default value has
a bad format

- N°8131 - Protect event DB_LINKS_CHANGED on deleted
object

- N°8139 - Avoid double writing in lifecycle action
(DBUpdate in actions are no more executed)

#### Localization

- N°7735 - Improve Spanish translations for iTop
3.2

- N°7824 - Update czech translations for iTop3.2
thanks to @Stetinac

- N°7859 - Add missing French translation on
newsroom

- N°7932 - Add english (GB) translation to iTop

- N°7954 - Update Chinese translations

#### 安全性

Severity High

- N°7730 - Fix XSS on parameters leading to CSRF
breach

- N°7770 - CVE-2024-52601 - Secure Direct Object
Reference + prevent Mass Data Leak

- N°7776 - CVE-2025-24021 - Prevent mass assignment
of fields not present in form

- N°7810 - CVE-2025-24022 - Prevent Portal code
injection

- N°7854 - Bump twig lib to version v3.16.0 for
security

Severity Medium

- N°6282 - Fix XSS in Functions (snyk.io)

- N°6283 - Fix XSS in webservice (snyk.io)

- N°6284 - CVE-2025-24026 - Fix redos in regex
(snyk.io)

- N°6617 - Fix “Denial of Service”
vulnerability

- N°7980 - CVE-2024-56157 Fix self XSS in CSV
Import

- N°8007 - On OQL error (wrong class), list only
allowed classes for the current user (read access).

- N°8150 - Check if hash inURLis the same that one of the
image

## 3.2.0

- 3.2.0-2:N°7801 - Fix erratic behavior on organization
filterN°7803 - Fix MTP from iTop Hub and Designer failing
with warnings

- N°7801 - Fix erratic behavior on organization
filter

- N°7803 - Fix MTP from iTop Hub and Designer failing
with warnings

#### 用户相关

- N°6218 - 1:n & n:n - Read mode: Refresh of tab
count on Add/Remove in pop-up

- N°6303 - Add a search brick on all Tickets of a
User Portal

- N°6555 - Add class description in tooltip of
Dashlet badge

- N°7157 - Allow users to unsubscribe from
notification channels

- N°7379 - Add search criterion to Workorder and
'status' to Contact search

- N°7391 - Add color blind themes to iTop
backoffice

- N°7392 - Add high contrast theme to iTop
backoffice

- N°7484 - “solution” field of classes Incident and
UserRequest is now anHTMLfield

- N°7644 - Add Brand logo and Model picture

- N°3767 - Impact analysis: Display filtering box on
CIs list and groups

- N°4494 - Fix auto-locking on log save and
transition, by waiting

- N°4511 - CKEditor : Fix links made on all the
leading text in Firefox

- N°4631 - Fix a display issue when description field
is fullscreen while using vertical tabs

- N°4894 - Improve AttributeDecimal validation during
CSV import

- N°5136 - Relations: Fix “Select All objects” adding
obsolete objects even if “show obsolete data” param. not
activated

- N°5786 - Fix text color in public log and in
AttributeHTML

- N°6152 - Fix criteria & object list loaded
twice

- N°6438 - Fix expensive reloading of each displayed
ticket when displaying a ticket list (no more highlight)

- N°6847 - Position of label in configuration of pdf
export

- N°6861 - Display warning when creating/editing a
mandatory blob in modal

- N°6903 - Fix crash when emptying file attribute
(eg. picture of a contact)

- N°6993 - Fix bulk transition on object containing a
null blob

- N°7023 - Fix check to write error when adding an
item on a n:n relation (eg. contact) on a new object (eg. user
request) on the end-users portal

- N°7047 - Fix unwanted Attachment on Unitary
requests forms in Global Request management

- N°7122 - Portal: Hide log off button when user
can't actually log off (eg. SSO using SAML or other
providers)

- N°7163 - Avoid having an empty list when “items per
page” set to 0

- N°7232 - Run query : Clearer message when querying
unknown class

- N°7255 - Fix misc. stylesheets not working in
portal since N°7047

- N°7288 - Fix page crash due to unescaped characters
in relations row actions

- N°7292 - Improve Clear function in
ExtKeyWidget

- N°7302 - SetupUtils::HumanReadableSize : fix units
returned

- N°7313 - Fix bad display of single quotes in
charts

- N°7491 - Fix email-reply trigger not executed in
some cases

- N°938 - Improve print of portal object page and
portal dashboard page

- N°7397 - Update welcome popup content for iTop
3.2

#### For administrator

- N°3465 - Fix attachment file name hardcoded to
“uploaded-file” when imported from CSV import

- N°5472 - Notification action : add a last
executions tab

- N°5775 - Allow configuration of OAuth client on MS
Azure with single tenant

- N°6619 - Attachment: changed contact_id from an
ExternalField into an ExternalKey

- N°7194 - Add link to datamodel class schema on
object details

- N°7425 - Add Warning when a user has no contact or
no allow org

- N°7447 - Ease User Dashboard clean-up for iTop
administrator

- N°2039 - Feed Newsroom from an Action

- N°7298 - Allow each Action to be asynchronous or
not

- N°7533 - Warning at setup if installed on Galera
clusters

- N°1112 - DataSynchro: Replica failing to
synchronize says 'Organization' instead of 'undefined' ???

- N°2572 - Improve error message “Nowhere to go??”
with root cause

- N°2732 - DataSynchro: cap memory peak value to 2Gb
before storing it in priv_sync_log field

- N°3062 - Update SetupCssIntegrityChecklistTest to
fail build if setup.css wasn't recompiled

- N°3677 - Fix AttributeImage.default_image URLs not
up to date after app_root_url change

- N°3715 - Export above 1000 entries ignore obsolete
data from user preference

- N°4342 - Improve generic bulk deletion function
with memory limit handling

- N°5194 - Enable webhook actions to be asynchronous
in order to save response callback value

- N°5218 - Fix toolkit error on enum since
3.0.0

- N°6086 - CSV import: Treat first line as a
header

- N°6361 - Change query examples order to highlight
the one working on an empty iTop

- N°6618 - Fix crash due to router's cache containing
an integer instead of an array

- N°6659 - Ticket: attribut “team_name” now contains
the name, “team_email” attribut added.

- N°6808 - Rank management (order) in iTop
actions

- N°6826 - Fix error on file attribute of
DocumentFile class in Designer (No SQL value)

- N°6852 - Missing configuration
'forgot_password_from'

- N°6874 - Fix encoding issue in out-going
emails

- N°6887 - Fix excessive OQL requests to display
user's grant matrix

- N°6889 - MariaDB >= 10.6.1 since iTop 2.7.9
Backup mysqldump call : restore ability to connect on localhost
using the socket protocol

- N°7017 - Fix with a lock the fatal error occuring
when rebuilding expression-cache

- N°7021 - Fix error log and useless compilation time
due to SCSS file unnecessary compilation

- N°7039 - Fix regression: placeholder
:current_contact→id not working in OQL in iTop 3.1

- N°7052 - Fix PHP notices in synchro_import.php
(3.0.1 regression) (thanks to Gilbert Breton !)

- N°7082 - Allow to force asynchronous send of
emails

- N°7085 - Fix infinite loop in login page until
fatal error occurs

- N°7130 - Allows to ignore existing column field in
setup's data migration method

- N°7212 - PHP 8.1: Migrate remaining usages of
strlen() with null value

- N°7213 - PHP 8.1: Migrate remaining usages of md5()
with null value

- N°7217 - Fix link creation between “Audit Domain”
and “Audit category” with an “Audit Manager” profile

- N°7231 - PHP 8.1: Migrate deprecated usages of
rawurlencode() with null value

- N°7244 - Fix ContextTag init in setup

- N°7245 - Better log error occuring in
RunTimeEnvironment::CallInstallerHandlers

- N°7312 - Fix JS crash on Windows server when
creating a custom version of 'UserRequest Overview' Dashboard

- N°7336 - Fix warning from
\DeprecatedCallsLog::NotifyDeprecatedPhpMethod with PHP 8.3

- N°7343 - Better error message when compiling a PHP
invalid dict file during setup

- N°7416 - Setup: Add warning for optionnal PHP
extension “APCu”

- N°7474 - Fix setup crash when the last profile of a
user is removed from the datamodel

- N°7477 - Fix DataSynchro made without administrator
profile to create SynchroLog

- N°7480 - Fix test-red and light-grey css related
setup warning

- N°797 - DataSynchro deletion includes replica
cleaning

#### For iTop designers

- N°2443 - Fix AttributBoolean doesn't accept yes/no
value

- N°2909 - Fix search on Enum, Date, TagSet,… with
index

- N°3236 - Fix trackinfo in CMDBChange when using
core/update with REST

- N°3363 - Add three favicons in branding

- N°4314 - Uniqueness rules can report duplicates
that user cannot see due to Silo

- N°6228 - Prevent removing last user Profil:
AttributLinkSet property “with_php_constraint” allows to propagate
CheckToWrite() to target object.

- N°6695 - Allow multilines dict entries in portal
tooltips

- N°6964 - AddAPIto allow modules to
register files to include in the backup

- N°7067 - Add setting to change the default
“password change”URL

- N°7136 - Portal: Add JSAPIto enable
attachments IDs retrieval in an object form

- N°7242 - Allow to mention new user IDs in Slack
messages

- N°7243 - Add non blocking feedback/notifications
(toasts)API

- N°7294 - Events when adding or removing an
attachment are sent on the object instead of on the
attachment

- N°7310 - New event to conditionally remove
transitions on an object

- N°7345 - Allow to use a DateTime php object on
Set() call on an AttributeDateTime

- N°7410 - IntroduceAPIfor Welcome Popup in
the backoffice

- N°5145 - Fix attachments missing in new ticket when
clone from an old ticket with object copier

- N°5170 - Fix case where in a transition
DoCheckToWrite returned error

- N°5547 - Fix object deletion failing when
friendlyname was too long

- N°6543 - Fix display of AttributeText with width
parameter

- N°6643 - Fix \CMDBSource::LogDeadLock generating a
TypeError

- N°6647 - Fix JSON validation only accepting arrays
as result + replace params done after validation

- N°6660 - Fix define_if_not_exists flag not working
on class nodes

- N°6733 - Fix prompting of mandatory
AttributeDateTime in transition forms

- N°6766 - Fix dependent fields not updated due to
WizardHelper.UpdateFields() being triggered too early

- N°6767 - Fix error in ajax request when there's
dict to load and no onready scripts

- N°6960 - Fix “Unknown class XXX” when clicking on a
class external key or n:n linkset

- N°7008 - Fix missing background tasks in CRON when
autoloaded and not in “developer_mode”

- N°7042 - Fix check to write error when setting a
ext. key programatically on the end-users portal

- N°7046 - Fix “CAS_ServiceBaseUrl_Static” not
found

- N°7055 - Apply better default value for portal copy
object link

- N°7068 - Add emulation for apc_exists
function

- N°7079 - Fix event not fired when creating/updating
a user with profiles

- N°7133 - Fix linkset displayed as property, failing
when OQL filter contains single quote or new line

- N°7134 - Fix retrieving list of changes when
editing URP_UserProfile

- N°7268 - Fix method SetComputedDate failling on
Date only attribute

- N°7279 - Fix compilation issue with AttributeClass
field defined in XML

- N°7344 - rest.php : better error message when
cannot execute OQL query (key param for core/get verb)

- N°7399 - Remove deprecated Ticket methods from iTop
Datamodel

- N°7417 - Improve logged message when a Root Menu is
not a MenuGroup

- N°7693 - Update polish translations thanks to
@DudekArtur

- N°7687 - Update german translations thanks to
@Attila0428

- N°7686 - Update dutch translations thanks to
@Hipska

- N°7652 - Update italian translations thanks to
@DarkNight97boss

#### Technical changes

- N°4897 - Add method to improve deprecated PHPAPIlogs
(eg. for \iPageUIExtension)

- N°5298 - Upgrade CKEditor to version 5

- N°5580 - Audit JS libs and see if they are
available on NPM

- N°5621 - Add not managed JS dependencies to NPM to
get updates on vulnerabilities

- N°5808 - Update symfony version to next Symfony LTS
6.4

- N°5809 - Update PHP libraries versions

- N°5810 - Update JS librairies (iTop 3.2)

- N°6050 - Add compatibility with MariaDB 10.11

- N°6097 - Enable PHP unit tests on a custom
DataModel

- N°6103 - Remove jQuery Hotkeys plugin

- N°6558 - Add test to check
iTopDesignFormat::$aVersions consistency

- N°6599 - Update moment.js (known vulnerabilities
with high CVSS scores)

- N°6632 - ItopDataTestCase : replace annotations by
setting options in PHP

- N°6658 - Boost PHPUnit tests execution

- N°6752 - PHP unit tests: Migrate usages of
unitestautoload.php to composer autoloader in the core

- N°6754 - PHP unit tests: Add local PHPUnit XML
files to .gitignore

- N°6805 - Add reference to classes implementing
\iWorkingTimeComputer in the datamodel (meta tag)

- N°6886 - Add OAuth tests folder to removable
directories list

- N°6937 - Symfony 6.4 - Handle Symfony configuration
files

- N°6967 - Deprecated
\cmdbAbstractObject::DBDeleteTracked_Internal

- N°7044 - Move language attribute from ActionEmail
to ActionNotification

- N°7054 - Rework the UpdateImpactedItems calls on
Tickets

- N°7062 - Add unit test to ensure that setup SCSS is
compiled correctly

- N°7170 - PHP 8.3: Fix usages of get_class() without
argument

- N°7179 - Remove unused code in Action

- N°7246 - New dict tests on duplicate definitions in
same file + translated keys with tildes

- N°7251 - Deprecate unused JS libs (iTop 3.2)

- N°7264 - Update unmaintained JS libs to their
latest versions (iTop 3.2)

- N°7297 - Doing npm install removes web.config file
and changes package name

- N°7314 - Add Symfony Response alternative to
Webpage::output()

- N°7315 - Add new predictibleAPIto add JS /CSSfiles to a
\WebPage

- N°7328 - Deprecate js/jquery.autocomplete.js

- N°7331 - Add cleanup script for NPM
dependencies

- N°7355 - Update JS libraries managed via NPM (iTop
3.2)

- N°7407 - Ease iTop installation via unattended CLI
by using installation.xml choices

- N°7494 - Select languages that “highlightjs”
supports

- N°7697 - Add method to rename DB table during
setup

- N°7619 - Restore cascading in object deletion for
legacy extensions

- N°7588 - Fix .env.local not working for the portal
since Symfony 5.4 migration

- N°7146 - Fix style not applied in list in the
end-users portal in iTop 3.0+

- N°7142 - Compiler issue - enum value modification :
…DOMNode::removeChild() …

- N°7131 - Changing the Org of a Person having User
with Allowed Orgs, breaks with Synchro LDAP

- N°7127 - Upgrade handlebars.js to v4.7.8

- N°7024 - Fix opening an object with abstract class
indirect linked set in Portal

- N°6992 - Fix “add lnk” popup title: replaced class
name by its label

- N°4342 - Improve generic bulk deletion function
with memory limit handling

- N°7410 - Introduce a new welcome popupAPI

#### 安全性

- N°7423 - Align UserTokens to PersonalToken with
allowed contexts

- N°7075 - Add check for Content Security Policies
(CSP) in the setup

- N°7364 - Full path disclosure when graphviz is not
installed

- N°4368 - iTop pages include security
X-Content-Type-Options HTTP header

- N°6455 - Update JQuery UI from 1.12.1 to 1.13.2
(fixes vulnerabilities)

- N°6600 - Portal attachment download : whole SQL
query displayed on non existing attachment id error

- N°6777 - Fix XSS vulnerability in dashboard
title

- N°6948 - CVE-2023-46734: Potential XSS
vulnerabilities in TWIG CodeExtension filters

- N°6458 - CVE-2023-45808 Can create objects in non
allowed org by forging http query in both Console and Portal

- N°6560 - CVE-2023-43790 XSS in friendlyname in
object details

- N°6606 - CVE-2023-44396 XSS vulnerabilities in
dashlet ajax operations

- N°6800 - CVE-2023-47626 Fix stored XSS in authent
token

- N°6951 - CVE-2023-48709 Fix CSV injection in Excel
from an iTop CSV export file

- N°6989 - CVE-2023-48710 Limit pages/exec.php script
to PHP files

- N°7124 - Applied OWASP recommendations on Ajax
calls against CSRF

- N°7374 - CVE-2024-31448 - Fix XSS vulnerability in
link CSV import

- N°7448 - Forbid user enumeration through RestAPI

- N°7449 - CVE-2024-32870 - itop hub connector
Information disclosure

- N°7455 - Fix SSRF through arbitrary PHP class
instantiation

- N°7542 - Security hardening: only route if no
operation is present.

- N°7603 - Fix XSS injection in run queries
page

#### Localization

- N°6641 - Update czech translations (thanks to
@Stetinac !)

- N°6869 - Update chinese translations for
ProfilesMenu thanks to @chileeb

- N°6954 - Update english translations thanks to
@jkoch22

- N°7077 - iTop hungarian translations

- N°7143 - Fix inconsistencies in datamodels/2.x
dictionaries

- N°7247 - Update italian translations thanks to
@DarkNight97boss

- N°7428 - Fix spelling typo in FR dictionary on
lnkxxxToFunctionalCI classes

# 3.1.x

This branch is about to enterSecurity fixes
only. Version 3.1.3 could be the last one in this
branch

## 3.1.3

#### For Users

- N°7219 - Fix broken dashboard having special
caracters in their title

- N°8134 - Fix Portal user profil brick edition

#### For Administrators

- N°7916 - Fix missing charset when sending emails
with attachments

- N°7917 - Fix emails classified as spam due to
incorrect `Message-ID` thanks to @vlk-charles

- N°7925 - Fix incorrectly formatted In-Reply-To
email header

#### For iTop designers

- N°8131 - Protect event DB_LINKS_CHANGED on deleted
object

#### 安全性

- N°7770 - CVE-2024-52601 - Secure Direct Object
Reference + prevent Mass Data Leak

- N°7776 - CVE-2025-24021 - Prevent mass assignement
of fields not present in form

- N°7810 - CVE-2025-24022 - Prevent Portal code
injection

- N°7980 - CVE-2024-56157 Fix self XSS in CSV
Import

## 3.1.2

#### New

- N°7310 - New EVENT_ENUM_TRANSITIONS to hide on the
fly some Transitions

- N°7294 - Send EVENT_XXX_ATTACHMENT_TO_OBJECT on the
target object instead of the attachment object

#### Fixes

- N°7217 - Fix user rights to create a link between
“Audit Domain” and “Audit category” with an “Audit Manager”
profile

- N°7137 - DataSynchro: Remove “Organization” as
default value for SynchroReplica→dest_class

- N°7122 - Portal: Hide log off button when user
can't actually log off (eg. SSO using SAML or other
providers)

- N°4314 - Fix Uniqueness rules not working with
Silo

- N°6993 - Fix bulk transition on object containing a
blob

- N°7491 - Fix Email-reply trigger is not executed in
some cases

- N°7645 - PHP 8.1: Fix usage of strpos() &
str_replace() with null value when compiling empty dictionary
entries

- N°7619 - Fix object deletion not cascaded for
legacy extensions: OnDelete() called again

- N°7526 - Fix profile input: persistent filters even
after blur

- N°7405 - Cache files access is more protected
against concurrent access

- N°7344 - rest.php : better message when cannot
execute OQL query

- N°7343 - Better error message when compiling a PHP
invalid dict file during setup

- N°7336 - Fix warning in
\DeprecatedCallsLog::NotifyDeprecatedPhpMethod with PHP 8.3

- N°7302 - Fix wrong unit name in
\SetupUtils::HumanReadableSize

- N°7288 - Fix page crash due to unescaped characters
in relations row actions

- N°7268 - Fix method SetComputedDate failling on
Date only attribute

- N°7255 - Fix misc. stylesheets not working in
portal since N°7047

- N°7245 - Bettor logs on
RunTimeEnvironment::CallInstallerHandlers exceptions

- N°7232 - Fix UI:RunQuery:Error containing a
placeholder

- N°7231 - PHP 8.1: Migrate deprecated usages of
rawurlencode() with null value

- N°7213 - PHP 8.1: Migrate remaining usages of md5()
with null value

- N°7212 - PHP 8.1: Migrate remaining usages of
strlen() with null value

- N°7172 - AddingHTMLmarkup for n:n set
properties in 3.1 (for Behat)

- N°7147 - Fix error HTTP 500 due to access_token notURLdecoded

- N°7143 - Fix inconsistencies in datamodels/2.x
dictionaries

- N°7142 - Fix compiler issue - enum value
modification : …DOMNode::removeChild() …

- N°7134 - Fix list of changes for class
URP_UserProfile

- N°7133 - Fix Linkset displayed as property failling
when filter contains single quote or new line

- N°7127 - Upgrade handlebars.js to v4.7.8

- N°7118 - Act on guaranteed object deletion, with
the object still accessible

- N°7085 - Fix infinite loop in login page until
fatal error occurs

- N°7080 - Fix EVENT_DB_LINKS_CHANGED not fired when
deleting a user

- N°7079 - Fix EVENT_DB_LINKS_CHANGED not fired when
creating/updating a user with profiles

- N°7077 - iTop hungarian translations

- N°7052 - Fix PHP notices in synchro_import.php
(3.0.1 regression) (thanks to Gilbert Breton !)

- N°7047 - Fix unwanted Attachment fields on Unitary
requests forms in Global Request management

- N°7042 - Fix check to write error when setting a
ext. key programatically on the end-users portal

- N°7039 - Fix placeholder :current_contact→id not
working in OQL in iTop 3.1

- N°7024 - Fix opening an object with abstract class
indirect linked set in Portal

- N°7021 - Fix error log and useless compilation time
due to SCSS file unnecessary compilation

- N°7017 - Fix rebuilding expression-cache causing a
PHP fatal error

- N°6968 - Improve audit performance

- N°6889 - Fix backup on localhost with MariaDB >=
10.6.1 since iTop 2.7.9

- N°6826 - Fix sql value on file attribute of
DocumentFile class

- N°6660 - Fix define_if_not_exists flag not working
on class nodes

- N°6543 - Fix display of AttributeText with width
parameter

- N°5775 - Allow configuration of OAuth client on MS
Azure with single tenant

- N°5547 - Fix object deletion failling if
friendlyname too long

- N°4631 - Fix display issue when description field
is totally open in vertical layout

- N°4164 - SAML - Hide logoff from portal

- N°3448 - Framework field size check not correctly
implemented for multibytes languages/strings

#### 安全性

- N°4368 - iTop now sends the X-Content-Type-Options
HTTP header (See wiki)

- N°6455 - Update JQuery UI from 1.12.1 to 1.13.2
(fixes vulnerabilities)

- N°7075 - Add check for Content Security Policies
(CSP) in the setup

- N°7603 - Fix XSS injection in run queries
page

- N°7548 - Fix Stored Self XSS in preferences

- N°7545 - Fix Self XSS in portal picture upload by
following owasp recommendations

- N°7455 - Fix SSRF through arbitrary PHP class
instantiation

- N°7449 - CVE-2024-32870 - itop hub connector
Information disclosure

- N°7448 - Forbid user enumeration through RestAPI

- N°7375 - CVE-2024-31998 - Fix XSS and CSRF combined
security issue on CSV import

- N°7374 - CVE-2024-31448 - Fix XSS vulnerability in
link CSV import

- N°7364 - Full path disclosure when graphviz is not
installed

- N°7124 - Following the OWASP recommendations about
Ajax calls to secure them against CSRF attack

## 3.1.1

- 3.1.1-1: Fix regression from
3.0.0 in CAS authentication: class ServiceBaseUrl missing

#### 用户相关

- N°938 - Improve print of portal object page and
portal dashboard page

- N°6555 - Add class description in tooltip of
Dashlet badge

- N°6861 - Display warning when creating/editing a
mandatory blob in modal

- N°5145 - Object-copier : Fix attachments missing in
new ticket when clone from an old ticket with object copier

- N°5786 - Restore color on bold text in logs and
description (HTMLfields)

- N°3767 - Impact analysis: Display filtering box on
CIs list and groups

- N°3715 - Export above 1000 entries takes into
account obsolete data user preference

- N°6557 - Fix adding a contact to ticket on ticket
creation in portal with PHP 8.1

- N°5136 - Fix object selection ignoring “show
obsolete data” user parameter

- N°6903 - Fix crash when emptying file attribute
(eg. picture of a contact)

- N°7005 - Fix portal stylesheets not being
re-compiled when outdated

- N°6766 - Fix dependent fields not updated while
editing an object

- N°6734 - Fix “Unable to render this dashlet.” when
adding a new dashlet on a dashboard

- N°6733 - Restore prompting of mandatory
AttributeDateTime in transition

- N°6421 - [iTop 3.0.3] Flag mandatory and read_only
is prompted

- N°6651 - Fix bulk modify of objects with an n:n
displayed as property (3.1.0)

- N°6452 - Improve Personal Token to avoid
auto-lock

- N°6451 - Improve Personal Token creation to align
to iTop standards

- N°6450 - Fix useless message when moving outside of
“My account” page

- N°6152 - Fix criteria & object list loaded twice in
object search

- N°5948 - Fix dashlet list crashing when User set a
“number of objects per page” which is not a number

- N°4494 - Fix auto-locking when combining a log save
and a transition (Firefox?)

- N°3441 - Portal: Fix failure to open an object
containing a link to an archived object

- N°6905 - Typo on EN User deletion feedback

- N°6706 - Wrong dictionary entry for FR - Lnk
Provider Contract / Service

- N°6646 - Wrong dictionary entry for FR - Lnk
Contact / Contrat

- N°6598 - Improve ZH-CN translations

- N°5491 - Fix inconsistent dictionary entries
regarding arguments to pass to Dict::Format

#### 管理员相关

- N°6531 - Trigger on Update on LinkedSet attributes,
activated as soon as a remote object is added, updated or
removed

- N°6133 - Allow to add extra files to backup and
restore

- N°6436 - Add performance Audit probes and reports
download capability

- N°6901 - Monitoring: Enable tracking of iTop active
sessions

- N°6831 - Prevent links modification when locked by
a synchro data source

- N°6874 - Fix encoding issue in out-going
emails

- N°6340 - Fix permission refused when sending an
email and renewing Auth token in synchronous mode

- N°6677 - Fix notification in test status send only
to test recipient and no more all mail addresses

- N°6824 - Fix notification with current_contact
placeholder trigger hundred of email sent

- N°3465 - Fix attachment file name hardcoded to
“uploaded-file” when imported from CSV import

- N°6123 - Add warning when launching a backup on
MariaDB > v10.6.1 with localhost

- N°6963 - Setup: Add warning: “PHP min 8.1 required
for iTop version 3.2.0”

- N°6887 - Fix excessive OQL requests to display
user's grant matrix

#### For customization

- N°3506 - Creation in pop-up from external key
widget, allowed to users with write access and no more bulk
write.

- N°6546 - XML filter is taken into account by n:n
displayed as property (tagset widget)

- N°6385 - Allow to disable LinkedSet (1:n & n:n)
edition by XML

- N°6228 - Prevent 1:n and n:n edition on host
constrains (eg. Prevent removal of last User Profile,…)

- N°6547 - Prevent n-n link edition if read-only in a
lifecycle state

- N°6228 - Allow easy LinkedSet computation (count,
sum,…) on the fly, as soon as a remote object is added, modified or
removed

- N°6667 - Trigger Apply stimulus filter is executed
on resulting object after update

- N°6849 - Setup: improved message in case of unmet
module dependencies

- N°6815 - DataModel: change attribute type of
SLA.customercontracts_list

- N°6814 - Datamodel: remove
lnkConnectableCIToNetworkDevice uniqueness rule

- N°6747 - Fix presentation error in Designer during
MTP after UserLDAP customization

- N°6682 - Allow delegation of Audit Domain, Category
and Rule classes access

- N°6695 - Support multi-lines dictionary entries in
portal tooltips

- N°6810 - Cautious: semantic attributes are visible
by design to anyone, as friendlyname on relations.

- N°6774 - Fix display n:n relations in portal when
no remote object fields is requested

- N°6866 - Fix display issue when defining fields
with apostrophe in their label

- N°2909 - Fix search on Enum, Date, TagSet,… with
index

- N°6795 - Fix GetOriginalAPIbroken from 3.0.0 to
3.1.0 when used in AfterUpdate / OnDBUpdate

- N°6647 - Fix JSON validation only accepting arrays
as result + replace params done after validation

- N°6767 - Fix ajax request error when there's dict
to load and no onready scripts

- N°6976 - Restore log of
\DeprecatedCallsLog::ENUM_CHANNEL_PHP_LIBMETHOD

- N°6967 - Deprecates
\cmdbAbstractObject::DBDeleteTracked_Internal

- N°6966 - Deprecates
cmdbAbstractObject::DBCloneTracked_Internal

#### 安全性

- N°6989 - CVE-2023-48710 Restrict pages/exec.php to
PHP files

- N°6951 - CVE-2023-48709 Fix CSV injection in Excel
from an iTop CSV export file

- N°6948 - CVE-2023-46734 Fix potential XSS
vulnerabilities in TWIG CodeExtension filters

- N°6917 - CVE-2023-47123 Fix XSS vulnerability in
n:n relations “tagset” widget

- N°6908 - CVE-2023-47622 Fix XSS vulnerabilities in
ajax operations

- N°6801 - Fix access to backup file without
authentication

- N°6800 - CVE-2023-47626 Fix XSS vulnerabilities in
authent token

- N°6778 - Fix XSS vulnerability in shortcut
creation

- N°6777 - Fix XSS vulnerability in dashboard
title

- N°6618 - Fix crash due to router's cache containing
an integer instead of an array

- N°6614 - XML ENTITY EXPANSION - Deny of Service
attack not exploitable

- N°6606 - CVE-2023-44396 Fix XSS vulnerabilities in
dashlet ajax operations

- N°6600 - Portal attachment download : remove SQL
query display on non existing attachment id error

- N°6581 - Dashboard: Use relative path when editing
to avoid full path disclosure vulnerability

- N°6560 - CVE-2023-43790 Fix XSS vulnerabilities in
friendlyname in object details

- N°6552 - CVE-2023-38511 Fix dashboard allowing to
load multiple files and urls

- N°6548 - Hide DBHost and DBUser in log

- N°6458 - CVE-2023-45808 Fix object creation in non
allowed org by forging http query in both Console and Portal

- N°6457 - Fix possibility for attackers to upload
files to any organization

## 3.1.0

- 3.1.0-3: N°6710 - 6716 -
Performance issue and high memory consumption on operation on
Persons and Ticket classes (ex data synchronisation)

- 3.1.0-2: N°6618 - Fix crash due
to router's cache containing an integer instead of an array

- 3.1.0-1: official release number,3.1.0was never published.

#### 用户相关

- N°3200 - New “Filter list…” icon on datatables
widgets

- N°6147 - Filter list : tooltip and new action

- N°3190 - Edit n:n LinkedSetIndirect in object
details using a tagset-like widget

- N°1212 - Bulk actions on links attributes of an n:n
relation

- N°803 - Allow display & edition of attributes on
n:n relations on Portal

- N°6398 - Portal: Allow linkset visible attributes
to be limited to attributes defined in a zlist

- N°5972 - Allow User creation in Pop-up from details
of a Person

- N°6347 - 1:n Add nice french dico entry on standard
1:n relationship

- N°6339 - n:n Add nice french dico entry on standard
lnk

- N°6223 - 1:n & n:n - Pop-up creation/edit: set key
to host in read-only

- N°6219 - 1:n Read: tooltip, modal title and message
on Add-Edit-Remove-Delete

- N°6212 - Report Target class info on Trigger, so it
can be displayed in complementary_name

- N°6154 - n:n Read - tooltip, confirmation title and
message on Add-Edit-Remove

- N°6153 - n:n - Polish edition in Tagset

- N°5976 - Add modal creation for linksets displayed
with tagset-like widget

- N°6148 - Add icon on Ticket class standard
datamodel and other classes

- N°5920 - Add linkset's description as corresponding
tab's tooltip in object details

- N°3213 - Order transition attributes as in the
“details”

- N°6200 - Harmonize menu entries

- N°5042 - “Problem” tickets display is inconsistent
with other types of tickets

- N°6392 - New icon for adding a search
criteria

- N°6203 - Improve standard DM to use overcard and
complementary name

- N°6159 - Improve Mail Notification display
(columns, status, fieldset, tooltips)

- N°5908 - Add a description on “known error” tab on
UserRequest and Incident

- N°6357 - Prevent entering same password on change
user password

- N°4838 - Redirect to login page automatically on
logoff

- N°6240 - Improve display of picture in read or edit
mode

- N°5971 - Prevent changing the Org of a Person
having Portal User with Allowed Orgs

- N°6338 - Add organization and location on standard
classes: all Interfaces, LogicalVolume & NASFileSystem

- N°6331 - Add Service tab in Provider Contract

- N°4703 - Add “chat” / “in person” as possible
“origin” value for tickets

- N°3889 - Add default search criterion on SLA and
SLT

- N°4702 - DataModel : fix attribute type for
SLA.customercontracts_list

- N°5822 - Do not display the tab separator in scroll
mode when there is only one tab

- N°5335 - Inactive hyperlink attributs on list with
radio or checkbox displayed within an object in edition

- N°681 - Fix multi-lines attribut not supported in
n:n edition

- N°3067 - LinkedSet multilines attributes are
editable in pop-up

- N°6188 - Fix cancellation of creation in pop-up
from parent object edition, no more returns to object list

- N°6169 - Prevent Profile creation from Link
object

- N°5923 - Align panel's header within another panel
when it has no icon

- N°5529 - Fixed notification on object creation with
$this→xxxx_list$ placeholders

- N°4148 & N°5350 - Fix in 1:n in place edition,
deleted object re-appears

- N°2250 - Fix DisplayObject with ormLinkSet ignoring
Removed

- N°2212 - Fix tracking level on
AttributeLinkedSetIndirect (probably fixed in 2.7.x)

- N°6054 - Fix display of LinkedSet indirect with an
UNION OQL using different aliases

- N°5609 - Fix regression when displaying a list in a
transition

- N°1876 - Fix regression on LinkedSet, new object
and prefill of read_only attribute

- N°5906 - Fix Impact Analys not updated after link
class modification in details mode (EVENT_DB_LINKS_CHANGED)

- N°5825 - Add label, friendlyname, details view,
uniqueness rules on Link classes

- N°5871 - Navigation menu: Show ellipsis on long
menu group labels

- N°5872 - Navigation menu: Wrap menu group label
instead of ellipsis in drawer

- N°5681 - Add support for “Ctrl + Enter” and “Meta
(Cmd) + Enter” submit on multi-line fields

- N°5575 - Mouseover Tooltips for tabs

- N°4852 - iTop menu : use “+” dict entries

- N°4737 - Adjust button position in iTop hub
connector

- N°4798 - Change attribute “description” of Service
class, from string to text

- N°5124 - Fix edition of relation between a
NetworkDevice and a ConnectableCI

- N°5703 - Fix navigation menu drawer under dashlets
on Safari

- N°5174 - Fix tagset edition on small window & too
many tags

- N°6174 - Fix download from the portal of
attachments on objects without org_id

- N°6250 - Fix PHP 8 issue on datatable when one or
more column are before the friendlyname

- N°6216 - Fix line-height being too big in the
attachments table

- N°5423 - Fix invalid value on AttributeURL with
custom validation pattern

- N°1608 - Fix organization attachments not visible
for some users

- N°5671 - Fix Excel export of query phrase

- N°5834 - Fix activity panel disappearing when
creating a Ticket in 'resolved' state

- N°6077 - Attachments: set values for creation_date
and user_id fields if not provided

#### For Administrators

- N°5960 - Configurable Login Screen

- N°6370 - Replace Audit Category menu by a
dashboard

- N°1350 - Audit: Introduce audit domains and ability
to choose one before running the audit

- N°918 - Translate placeholder in
notifications

- N°6320 - Add Password Expiration Enforcement and
User authentication by token

- N°5873 - Audit : Set threshold level and colors by
Rule

- N°2199 - Request history tables without the Admin
profile

- N°5559 - Enable User anonymization created then
obsoleted by a DataSynchro

- N°4010 - MTT: prevent production configuration file
overwritte with test version

- N°2889 - Add counter & triggers on file attributes
/ attachments downloads

- N°6311 - User management, add a Caselog on User
class

- N°5993 - Add purge mechanism for log files

- N°2639 - Improve tooltips dictionnary entries and
details of technical classes

- N°4921 - Add support for attcode & attvalue
parameters inURLto
access an object

- N°4454 - Measuring the use of the query phrase
book

- N°5915 - Display n:n in Trigger and Action using
tagset widget

- N°5841 - Non-admin managing User can't see
Administrator Users

- N°5106 - New Users tab on Person, visible to User
manager only

- N°4919 - Application upgrade: new 'Launch iTop
setup“ button

- N°6305 - Fix export of RemoteApplicationConnection
and ActionWebhook classes

- N°5897 - Improve deprecated logs relevance for PHP
“trigger_deprecation”

- N°2013 - Setup: Cannot execute if existing config
file contains an inaccessible MySQL server

- N°6198 - Trigger OnObjectUpdate is not executed
when attribute is updated via OnUpdate

- N°6009 - Fix click twice to restore a backup

#### For customization

- N°6213 - Enable iTop User to suscribe or unsuscribe
to a Ticket Notifications

- N°3191 - Introduce summary cards for objects
hyperlinks

- N°6381 - Add rank on Enums of default
DataModel

- N°5968 - Add structural data for Brand, OSFamily
and OSVersion

- N°6236 - Read Request template data though the
REST/JSONAPI

- N°5368 - Allow all HTTP methods (not just GET /
POST)

- N°5366 - Add “path” field to ActionWebhook

- N°1646 - Add possibility to sort
Attribute[Meta]Enum either by code (default), rank or label

- N°1345 - Add possibility to sort transitions
automatically

- N°4756 - Ease extensibility forCRUDoperations : Event
Service

- N°6324 -CRUDEvent for one time
treatment before creation and before update

- N°5916 - Generic message on Link Uniqueness
rules

- N°6385 - New optional “edit_mode” XML tag on
AttributeLinkedSet (n:n) actions/none defaut action

- N°6384 - Flag LinkedSet (Indirect) when the
attribute is concerned by CheckToWrite

#### Technical bugs

- N°2883 - Improve XML compiler robustness on
branding logos

- N°3070 - Menu creation fails when parent menu has
also a parent menu

- N°3141 - Deprecate legacy SQL build

- N°3769 - Add missingHTMLmeta data on attributes in
transition forms

- N°3824 - History: Remove deprecated APIs from 2.7
and older

- N°4280 - Fix module loading crash when 'datamodel'
file doesn't exists (model.*.php)

- N°4287 - Portal: Factorize TWIG extensions between
portal and backoffice

- N°4527 - Cleanup utils::GetImageSize()

- N°4577 - Move service dependencies from
“itop-bridge-cmdb-ticket” to another module

- N°4621 - Fix naming inconsistencies of dirs inside
/sources

- N°4837 - Fix wrong date conversion in approval base
on reject messages

- N°4875 - Compiler : do not force the model.*.php
file to be present in the module.*.php file ('datamodel' key)

- N°4978 - Check incorrect condition in Action
class

- N°5066 - Clean CMDBSource methods

- N°5072 - Fix default priority to undefined (not
fixed if ComputePriority is overloaded)

- N°5073 - Implements line actions in a
datatable

- N°5085 - Fix moving menu - compilation handle
parent menu hierarchy

- N°5172 - Add internal helpers to keep usage of null
value in native PHP methods

- N°5367 - Fix non-string values (boolean, null)
converted into empty string

- N°5369 - Fix BrowseBrick tree “opening_target” mode
for “self” and “new” values

- N°5391 - Incoherent UTF8 data length control

- N°5410 - Handle non existing auloader files

- N°5473 - Better logs when invalid JSON

- N°5496 - Add <constants/> in
itop-structure

- N°5522 - Fix session storage (breadcrumbs) not
cleared on logout

- N°5551 - System information database size is way
off

- N°5622 - Fix backup cannot be done if TLS enabled
with no CA

- N°5659 - Introduce modal helper for the
backoffice

- N°5766 - Fix linkset not iterable as intended in
DBObject::AfterUpdate

- N°5779 - update-xml : ease XML migrations

- N°5793 -HTMLSanitizer: Allow 'start',
'type', 'reversed' attributes in 'ol' tag and 'value' attribute in
'li' tag

- N°5796 - Fix typo in method name

- N°5944 - Fix new install error: Event
APPLICATION_EVENT_METAMODEL_STARTED is not registered

- N°6040 - Extensibility: Add prerequisites for
future attribute type - Compilation & Designer extensibility

- N°6041 - Extensibility: Add prerequisites for
future attribute type - Portal extensibility

- N°6042 - Extensibility: Add prerequisites for
future attribute type - Console extensibility

- N°6055 - Fix undefined offset error in
synchro_exec.php

- N°6100 - ObjectFormManager::OnSubmit : better log
for DBWrite exceptions

- N°6104 - Fix exception when silo attcode is not
'org_id'

- N°6105 - Cleanup unnecessary use of
dirname(FILE)

- N°6125 - Issue with GetAttributeFlags and
GetInitialStateAttributeFlags within iTop 3.0.2

- N°6131 - Improve robustness of tooltips helper when
no DOM element passed to
CombodoTooltip::InitTooltipFromMarkup()

- N°6139 - AddHTMLmetadata on activity panel
to be aligned with regular fields

- N°6140 - AddHTMLmetadata on custom fields
to be aligned with regular fields

- N°6172 - Remove fallback when no curl
available

- N°6179 - Tooltip attribute in field component (in
Twig)

- N°6265 - Improve performance due to too many call
to current person in DB

#### 维护

Deprecation and libraries upgrade

- N°3717 - HistoryAPI: allow to set a non
persisted current change

- N°6388 - Fix MetaModel::IsValidClass on classes
without fields and a php parent

- N°6135 - Booking : hide / display on
conditions

- N°6132 - Add capability to disable/enable tabs
dynamically

- N°2783 - Add support for custom zlists

- N°6261 - Deprecate
\DataTableUIBlockFactory::MakeForRenderingObject() method

- N°6102 - Deprecate JQuery Hotkeys plugin

- N°5311 - Deprecate old backoffice stylesheets

- N°5302 - Replace deprecated php strlen usages

- N°5232 - Deprecate
\CMDBObject::DBCloneTracked

- N°4690 - Deprecate “FilterCodes” and remove some
unused methods

- N°4415 - Remove SetupPage::log*

- N°3607 - Improve SCSS compiler method to include
current variables so they can be used by extension's
stylesheets

- N°3357 - Deprecate
core/expression.class.inc.php

- N°2779 - Introduce auto-routing mechanism for
backoffice pages

- N°2363 -API: deprecate old
linkedset update pattern

- N°5412 - Upgrade to PHPUnit 9 to fix PHPUnit 8.5
error with PHP 8.1

- N°5618 - Setup : Compatibility PHP 8.1

- N°6101 - run_query : change ctrl+enter shortcut
detection

- N°3795 - Replace JS alert native calls with
centralized informative modals

- N°5985 - PHP 8.1: Fix
FunctionExpression::Evaluate() “TO_DAYS” misalignment due to PHP
8.1 bug fix

- N°4985 - Bugs PHP 8.0 on support/2.7 branch

- N°4307 - Replace SwiftMailer by laminas-mail

- N°4224 - Handle phpunit/phpunit-mock-objects
E_DEPRECATED notices

- N°5281 - Symfony 5.4 extensions controllers
registration

- N°3091 - Update unmaintained PHPUnit 6 to PHPUnit
8.5

- N°5651 - Fix GetAbsoluteUrlModulePage() JS method
not reporting parameters values

- N°5279 - PHP 8.1: Migrate usages of deprecated
strftime() function

- N°5270 - Move “apereo/phpcas” lib from
“authent-cas” module to core composer.json

- N°5108 - Update embedded libs for PHP 8.0 (3.0
branch)

- N°4822 - unattended_install : warning thrown in PHP
8.1

- N°4628 - Upgrade bulma lib to avoid hack from
N°4481

- N°4517 - PHP 8.1 compatibility

- N°4072 - Deprecate ajax.render.php xlsx_*
operations

- N°4034 - Deprecate duplicated TWIG extensions
class

- N°3950 - Deprecate old unreferenced methods that
are @deprecated

- N°3895 - Remove tests on “apc_xxx” methods
presence

- N°3390 - Upgrade from Symfony 3.4 to Symfony
5.4

- N°2743 - Upgrade libraries

#### Localization

- N°5947 - Error in a french translation - incident
status

- N°5946 - Error in a french translation - user
preference

- N°5792 - Update dutch translations thanks to
@jbostoen

- N°5625 - Dict error when opening a DocumentFile
with the ES language

- N°5571 - Fix some unused translations

- N°5550 - Add missing french translation for “Other
Transitions” button

- N°5507 - Impact analysis: title of pages that
display the dependencies is wrong

- N°6419 - Update hungarian translations thanks to
@tacsaby

- N°6417 - Update chinese translations thanks to
@purplegrape

- N°6376 - Portal french menu naming (Requête ⇒
Demande)

- N°6121 - Update hungarian translations (thanks to
@tacsaby)

- N°6013 - Update hungarian translations thanks to
@tacsaby

- N°5929 - Update hungarian translations thanks to
@tacsaby

- N°5706 - Update polish translations thanks to
@DudekArtur !

- N°4765 - Update brazilian translations thanks to
@eduardomozart

- N°6418 - Fix dutch translations on impact relation
view

#### 安全性

- N°6396 - CVE-2023-34443 CSRF vulnerability in the
run_query.php page

- N°6359 - Cross-site Scripting (XSS) - DOM XSS in
activity panel

- N°6358 - CSRF (Cross Site Request Forgery).onAPIRest

- N°6350 - CVE-2023-34445 XSS vulnerability on
pages/ajax.render.php

- N°6349 - CVE-2023-34446 XSS vulnerability on
pages/preferences.php

- N°6348 - CVE-2023-34447 XSS vulnerability on
pages/UI.php

- N°6002 - CVE-2022-24894 Prevent storing cookie
headers in HttpCache (Symfony framework vulnerability)

- N°5722 - CVE-2022-31402 XSS vulnerability via
/itop/webservices/export-v2.php

- N°5564 - CVE-2022-39261 Twig lib
vulnerability

- N°6238 - guzzlehttp/psr7 vulnerability

- N°3863 - exec.php : security eforcementr

# 3.0.x

This branch isno more maintained. Version
3.0.4 is the last one in this branch

## 3.0.4

- N°7077 - Add hungarian translations, many thanks
Csaba TARJÁNYI (@tacsaby)

- N°7062 - Add unit test to ensure that setup SCSS is
compiled correctly

- N°7042 - Fix check to write error when setting a
ext. key programatically on the end-users portal

- N°7023 - Fix check to write error when adding an
item on a n:n relation (eg. contact) on a new object (eg. user
request) on the end-users portal

- N°7005 - Fix portal stylesheets not being
re-compiled when outdated

- N°6989 - CVE-2023-48710 Limit pages/exec.php script
to PHP files

- N°6976 - No more log of
\DeprecatedCallsLog::ENUM_CHANNEL_PHP_LIBMETHOD

- N°6951 - CVE-2023-48709 Fix CSV injection in Excel
from an iTop CSV export file

- N°6908 - CVE-2023-47622 Fix XSS vulnerabilities in
ajax operations

- N°6889 - Backup mysqldump call : restore ability to
connect on localhost using the socket protocol

- N°6887 - Fix excessive OQL requests to display
user's grant matrix

- N°6886 - Add OAuth tests folder to removable
directories list

- N°6878 - Modifications of core code for unit tests
optimizations

- N°6866 - Fix issue when creating new fields with
apostrophe in label

- N°6810 - Fix IDOR vulnerability in portal

- N°6801 - Fix access to backup file without
authentication

- N°6791 - Remove setup/install directory from iTop
package

- N°6778 - Fix XSS vulnerability in shortcut
creation

- N°6777 - Fix XSS vulnerability in dashboard
title

- N°6766 - Fix dependent fields not updated due to
WizardHelper.UpdateFields() being triggered too early

- N°6765 - Behat : loading issue on UserRequest
ReOpen transition in portal modal

- N°6754 - PHP unit tests: Add local PHPUnit XML
files to .gitignore

- N°6738 - UI:RunQuery:Error uses inconsistencies
with Dict::Format

- N°6658 - Boost PHPUnit tests execution

- N°6643 - Fix CMDBSource::LogDeadLock generates an
error

- N°6606 - CVE-2023-44396 XSS vulnerabilities in
dashlet ajax operations

- N°6600 - Portal attachment download : whole SQL
query displayed on non existing attachment id error

- N°6581 - Dashboard: Use relative path when editing
to avoid full path disclosure vulnerability

- N°6560 - CVE-2023-43790 XSS in friendlyname in
object details

- N°6552 - CVE-2023-38511 Dashboard: Fix editor
allowing to load multiple files and urls

- N°6548 - Hide DBHost and DBUser in log

- N°6532 - TemplateFieldValueTest crashing on iTop
3.0.0+

- N°6483 - XSS in search criterions when values
displayed have an additional field

- N°6458 - CVE-2023-45808 Can create objects in non
allowed org by forging http query in both Console and Portal

- N°6436 - Integrate Performance Audit pre requisite
in iTop Pro 2.7.9

- N°6431 - CSV bulk export text delimiter option not
initialized correctly

- N°6427 - PHPMail can misfunction in function of
SMTP software used

- N°6396 - CVE-2023-34443 CSRF vulnerability in the
run_query.php page

- N°6359 - Cross-site Scripting (XSS) - DOM XSS in
activity panel

- N°6358 - CSRF (Cross Site Request Forgery).onAPIRest

- N°6351 - CVE-2023-34444 XSS vulnerability on
pages/ajax.searchform.php

- N°6350 - CVE-2023-34445 XSS vulnerability on
pages/ajax.render.php

- N°6349 - CVE-2023-34446 XSS vulnerability on
pages/preferences.php

- N°6348 - CVE-2023-34447 XSS vulnerability on
pages/UI.php

- N°6340 - Permission refused on class
OAuthClientAzure when update renewal token

- N°6330 - PHP 8.0 compatibility in combodo-saml :
Update librairie one-login/php-saml

- N°6274 - PHPUnit : test throwing PHP warnings not
failing in PHPStorm, though failing on Jenkins

- N°6254 - ItopDataTestCase::CreateUserRequest :
specify fields as an array

- N°6247 - Add accessibility meta data for title on
“Actions” and “Toolkit” menus

- N°6238 - Fix guzzlehttp/psr7 vulnerability

- N°6216 - Fix line-height being too big in the
attachments table

- N°6204 - Fix REST/JSONAPIcrash when using
JSON-P and iBackofficeDictXXX interfaces

- N°6139 - AddHTMLmetadata on activity panel
to be aligned with regular fields

- N°6131 - Improve robustness of tooltips helper when
no DOM element passed to
CombodoTooltip::InitTooltipFromMarkup()

- N°6125 - Issue with GetAttributeFlags and
GetInitialStateAttributeFlags within iTop 3.0.2

- N°6123 - Fix warnings when launching a backup on
MariaDB >= v10.6.1 with localhost

- N°6112 - Dashboard: Improve robustness by trimming
dashlet ID returned by server

- N°6100 - ObjectFormManager::OnSubmit : better log
for DBWrite exceptions

- N°6099 - DeadLockLog : improve documentation

- N°6098 - updateLicenses.php : check requirements
before launch

- N°6097 - Enable PHP unit tests on a custom
DataModel

- N°6009 - Fix restore backup button needs to be
clicked twice

- N°5647 - Dashboard : dynamic dashlet total counter
not updated when user filter on an organization

- N°5621 - Add not managed JS dependencies to NPM to
get updates on vulnerabilities

- N°5491 - Fix UI crash in case of missing
placeholders in dictionaries entries

- N°5136 - Relations: Fix “Select All objects” adding
obsolete objects even if “show obsolete data” param. not
activated

- N°4698 - setup/phpinfo.php : handle iTop not yet
installed

- N°4368 - Send security HTTP headers

- N°3715 - Export above 1000 entries ignore obsolete
data from user preference

- N°2909 - Search on Enum, Date, TagSet,… with index
fails

- N°541 - Dashlets: Improve readability when to much
labels (pie chart) or too long labels (bar chart)

## 3.0.3

- 3.0.3-1N°6124 - Workaround performance problem on the
modification of an object with an n:n relation having a large
volumeN°6085 - Fix UNION not supported in
UserRightsProfile::GetSelectFilter

- N°6124 - Workaround performance problem on the
modification of an object with an n:n relation having a large
volume

- N°6085 - Fix UNION not supported in
UserRightsProfile::GetSelectFilter

#### 用户相关

- N°5919 - Add missing linkset descriptions in french
and other languages

- N°5849 - Fix wrong encoding of external keys in
“Header with statstics” dashlet

- N°5317 - Handle overlapping tables when table cells
have fixed widths

- N°6068 - Setup : restore formatting of error
messages

- N°6023 - Restore upload of SVG file in
AttributeImage

- N°5918 - Restore activity panel display when
DoCheckToWrite fails

- N°5865 - Restore DoCheckToWrite error messages in
portal

- N°5834 - Restore activity panel display when
creating a Ticket in 'resolved' state

- N°5784 - PHP 8.0: restore mandatory attribute in
transition form, fixing emptiness test

- N°5729 - Fix disabled button in bulk
update/transition when picking a value in a drop-down list

- N°5603 - Restore autocomplete for an external key
pointing to an abstract class with no friendlyname

- N°5530 - Fix list of impacted elements (Impact
Analysis) due to mixup in async JS files loading

- N°5922 - Ext. key widget: Add class selection on
”+“ button if child classes exist

- N°2916 - Fix CSV import of IPv6 addresses failing
when reconciliation is done on the IP

- N°5428 - Request template: fix autocomplete fields,
which could not be master field

- N°6014 - AttributeURL : default validation pattern
not handling PRTGURL(containing commas)

- N°5423 - Fix AttributeURL when changing the
validation pattern, with a not compliant old value

- N°5625 - Fix dict error when opening a DocumentFile
with the ES language

- N°2244 - Fix image attributes not being visible in
PDF exports

- N°5588 - Improve PDF export robustness when
AttributeImage dimensions cannot be determined

#### 管理员相关

- N°5553 - OAuth 2 : secure Client Secret in DB and
any change force token regeneration

- N°5430 - OAuth authentication : customize redirect
landingURL

- N°5333 - OAuth2: RedirectURL, Client ID or Client Secret
changes trigger a message as the token must be regenerated

- N°5867 - Display binary data size in SynchroReplica
details

- N°5727 - Fix RESTAPI/get_related when
using [impacts, up] with [redundancy: true]

- N°6019 - Increase PHP min version to 7.1.3 to
enable dependencies update

- N°5535 - Fix PHP 8.0.x wrongly repported as not
supported in iTop 3.0.2+

- N°5490 - PHP 8.0: Fix crash of bulk modify with
email notification / email approval request

- N°5216 - Error “Invalid ID given” when sending
ActionEmail using cron on a system with french locale

- N°4974 - Avoid session fixation in login

- N°5414 - Log invalid placeholders in
Notification

- N°5893 - Log more information when a trigger fails
and raises an exception

- N°5897 - Improve deprecated logs relevance for PHP
“trigger_deprecation”

- N°5611 - Fix missing composer files in
itop-oauth-client

- N°3805 - Fix collectors not working on itop 3.0 in
seldom situations

- N°5944 - Fix error on fresh install:
APPLICATION_EVENT_METAMODEL_STARTED not registered

- N°5765 - Setup: Never cache folder permissions test
response

- N°6016 - Setup : improve missing dependencies
log

- N°5235 - Setup : check temp dir permissions

- N°5758 - Change setup test for GDPR consent

- N°5523 - Setup wizard : use the ITOP_APPLICATION
constant instead of hardcoded “iTop” string

- N°5543 - Fix Warning on empty case log

- N°5901 - Fix warnings in file system tab

- N°5797 - Use LoadConfig method in all Email
children classes

- N°6020 - Decode method for \utils::EscapeHtml

- N°5608 - Reorganize tests folders for better
maintenance and contribution

- N°5496 - Add <constants/> in
itop-structure

- N°4660 - Fix data synchro unit test failure due to
another setting incorrect permissions on iTop conf file

#### WebHook 1.2.0

- N°5368 - Allow all HTTP methods (not just GET /
POST)

- N°5589 - Fix sent request incorrect HTTP method due
to new cURL options

- N°5366 - Add “path” attribute in generic
“ActionWebhook” for better compatibility with third-party
webservices

- N°5796 - Fix typo in
ActionWebhook::GetRemoteApplicationConnectionFromActionWebhok()

- N°5774 - De-hardcode webhooks configuration
rights

- N°5252 - Added Other/Generic type of Remote
Application Connection

- N°5367 - Fix non-string values (boolean, null)
converted into empty string

- N°5179 - Add chinese translations (thanks to
@bdejin)

- N°5266 - Add dutch translations (thanks to
@jbostoen)

- N°5050 - Add spanish translations (thanks to Miguel
Turrubiates)

- N°5473 - On JSON format exception, more context log
and specific Exception impl (InvalidJsonValueException)

#### 安全性

- N°6017 - CVE-2021-46743: Firebase PHP-JWT
key/algorithm type confusion

- N°5741 - Deny use of get_config_parameter in
Twigs

- N°5725 - Prevent Twig privilege elevation to run
system commands

- N°5724 - CVE-2022-31403 : XSS vulnerability via
/itop/pages/ajax.render.php

- N°5722 - CVE-2022-31402 : XSS vulnerability via
/itop/webservices/export-v2.php

- N°5685 - Upgrade apereo/phpcas lib to fix
vulnerability

#### 开发者相关

- N°3769 - Add missingHTMLmeta data on attributes in
transition forms

- N°4947 - Fix Email always picking “production” env
config file

- N°4449 - Console dashboard export : use relative
path (full path disclosure)

## 3.0.2

- 3.0.2-1N°5394 - CVE-2022-39214 Authenticated users can
takeover any account

- N°5394 - CVE-2022-39214 Authenticated users can
takeover any account

#### 用户相关

- N°5138 - Fix not being able to click on hyperlinks
in tooltips

- N°5408 - Enable mentions on classes with no image
attribute

- N°4834 - Mentions works with any alphabet
(cyrillic, asian, corean…) thanks to Vladimir Kunin

- N°5192 - Restore Green color to highlight OK
objects

- N°5071 - Fix properties tab on objects popup hiding
in ”…“ overflowing button. Fix objects popup shrinking when
scrolling.

- N°4966 - Refresh the page after dashboard creation,
to display the switch button

- N°4927 - Hide date picker widget displayed in a new
temporary column on the right

- N°4918 - Fix “other tabs” pop-up menu displayed
behind some others elements and so not readable

- N°4739 - Add semantic on state for User classes
(class icon, state)

- N°5198 - Fix external key combo-box behavior when
more than 150 results

- N°5088 - Fix audit displaying only 10 rules per
category

- N°5060 - Fix long history display.
“max_history_length” moved from 50 to 200.

- N°5027 - Fix AttributeUrl default validation
pattern not handling anchors starting with a digit

- N°5024 - Fix missing entries in object search
banner for external key criteria

- N°4792 - Improve performance when editing an
external key

- N°5397 - Update Dutch translations

- N°5050 - Update Spanish translations for 3.0
(thanks to Miguel Turrubiates)

- N°5179 - Add Chinese translations thanks to
@bdejin

- N°5266 - Dutch translations for the webhooks
extension

#### 管理员相关

- N°5315 - Support ofOAuth2 authentication
protocolto send and receive emails

- N°5373 -PHP 8.0 compatibilityfor
iTop Community -Be cautious extensions might not be
compatible

- N°5395 - OAuthServer error messages, added to iTop
error log

- N°5389 - Restore linkset placeholder in
notification (3.0.0 regression)

- N°4888 - New url() placeholder in Notification,
similar to hyperlink() but not clickable

- N°5341 - Add tool to repair misalignment between
Caselog and caselog index

- N°3024 - Any class can be archive (no more limited
to Ticket, Contact and FunctionalCI)

- N°5318 - Fix error messages beingHTMLencoded when not
necessary

- N°5462 - Setup warning if the web server allows
unauthenticated user to browse restricted folders

- N°5393 - CVE-2022-39216 - Security hardening
against brute force attacks

- N°4975 - Security hardening against server files
read access

#### 开发者相关

- N°5389 - TriggerOnObjectUpdate has been moved after
the reload, done if a linkset is modified

- N°5383 - DBObject::EnumTransitions() is now an
“overwritable hook”

- N°5375 - Fix XML custo on Semantic field with
hierarchy, breaking at compilation

- N°5343 - Menu displayed under an user hidden parent
menu, are hidden without crash

- N°5143 - Fix FunctionExpression for DATE_FORMAT and
formats %j, %k and %l

- N°5033 - Add model file to
'itop-bridge-virtualization-storage' module to avoid compilation
crash when lnkVirtualDeviceToVolume class is removed

- N°4910 - Removed format control of old value of
AttributeURL (new value must still be compliant to defaultURLpattern)

- N°4715 - Remove deprecated legacy SQL build

- N°5009 - Move empty “icon” tag under
“class/properties/style” tag in XML 3.0 datamodel of all standard
classes

- N°4903 - Fix dynamic “app_root_url” conf. param.
not used properly for the app. icon

- N°5101 - Add an explicit message on setup when the
state attribute, declared in semantic field property, referred to a
non existing field.

## 3.0.1

- 3.0.1-1: Fix regression introduced
by 3.0.0:N°5229: Caselog inline images lost afterchanging app-root url in 3.0.x

- N°5229: Caselog inline images lost afterchanging app-root url in 3.0.x

#### 用户相关

- N°4448 - Allow to easily unselect an Organization
(top left menu)

- N°4741 - Fix On mention trigger not working on
object creation

- N°4312 - Activity panel: Keep selected tab when
switching between object details and edit

- N°4479 - Impact analysis : Display and apply filter
before display impact analysis graphical

- N°4913 - Avoid object initials to overflow in
medallions, by limiting them to 3 characters

- N°4777 - UserRequest: fix selecting organization
through hierarchy tree

- N°4740 - Restore support of Dashboard attribute on
abstract class

- N°4705 - Fix newsroom messages not formatted
correctly

- N°4696 - Improve spacing between a fieldset and
fields without fieldset

- N°4694 - Fix wrong icon path for ServiceSubcategory
in XML definition

- N°4674 - CKEditor : fix different colors for PHP
Snippet in edit and view

- N°4671 - Dark Theme : fix additional tabs
color

- N°4619 - Fix line selection in tables

- N°4582 - Improve look of Widget ExternalKey in
drop-down mode with value selected

- N°4576 - Fix search date widget wrongly displayed
on the right, when entering directly a date

- N°4977 - Fix search widget on ExternalField
pointing to an ExternalKey, returning wrong values.

- N°4570 - Harmonize inputs font size/weight

- N°4564 - Refresh Tooltip for switching from
standard dashboard to custo dashboard

- N°4553 - Fix label size for “Greater/equals” in
search for numeric attributes

- N°4550 - Fix scroll bar in search for date
attribute

- N°4482 - Polishing : Export page

- N°4311 - Bubble caselog: align console and portal
for user name

- N°4849 - Improve email notifications reading
comfort (better flagging of conversation)

- N°4814 - Improve image attribute placeholder when
no default image

- N°4787 - Object details: hide field tooltip when
identical to the field label

- N°4565 - Add a message indicator to caselog tabs
toggler

- N°3541 - Button: Improve user feedback during
execution of the pressed button

- N°2643 - Dropdown menu unusable in new SLA/customer
contract

- N°4513 - Prevent Portal User to apply a transition
on an object not in his scope

- N°4806 - Add text for dictionary entry
UI:WelcomeMenu:Text

- N°4934 - Improve German translations

- N°4397 - update Turkish dictionnaries

#### For Admins

- N°4766 - DataSynchro: Supports files and images
data in the synchro_import.php

- N°4515 - AttributeURL default validation pattern
handles Sharepoint and AlfrescoURL

- N°4654 - Add license information in About iTop for
non admin users

- N°4525 - Fix french translation of extension source
(Data or Hub) in System information and About iTop

- N°4664 - Core Update : block zip file upload until
files check returns OK

- N°4642 - Core Update : limit the usage of this
function to version which do not bring any new module

- N°2884 - Core update: Fix Database version
display

- N°4764 - Remove iTop version from
webservices/status.php

- N°4665 - Fix notice in logs when uploading an SVG
image in an AttributeImage

- N°4652 - When XML compilation fails on a node which
already exist, it specifies where it exist

#### 开发者相关

- N°4999 - Align internal saving process of new
caselog entries to UI to fix CaseExchange inline images

- N°4905 - Fix usage of ITOP_APPLICATION constant in
dictionaries

- N°4856 - Add backward compatibility parameters for
extension developers

- N°4836 - Fix dashlet editor if any implementation
of iBackofficeDictEntriesExtension exists

- N°4771 - Fix .make/composer/rmDeniedTestDir.php
script issues

- N°4761 - Fix license.xml content not displayed in
setup with multi modules extensions

- N°4725 - Fix
DeprecatedCallsLog::NotifyDeprecatedFile doesn't handle
ConfigException

- N°4667 - Remove call to tooltip function

- N°4578 - Dict::CloneString no more overwrite an
existing entry

- N°4541 - Allow exit code capture in CLI for CSV
import script

- N°4438 - Disable (temporarly) copy of precompiled
stylesheets after setup

- N°4433 - Fix “date_format” TWIG filter not working
for date without time

- N°4558 - Fix PHP notice in startTansaction and
commit functions

- N°4488 - Remove
cmdbAbstractObject::GetSetAsHTMLSpreadsheet() from usableAPImethods

- N°4760 - TwigBase : add possibility to control
BreadCrumb

## 3.0.0

#### 新行为

#### 用户相关

- N°2847: Redesign iTop Console look and feel

- N°2844: Redesign of Ticket Pages with Logs and
Details

- N°994: Integrated view of private and public
caselogs

- N°2836: Introduce bubbles conversation as default
caselog rendering

- N°3208: Add a Quick create feature (except for
attachment and n:n relations)

- N°3207: Global search now remembers past
searches

- N°3560: New object display mode “all tabs in one
page”

- N°1957: Add a filter box for quick retrieval of a
menu

- N°3294: Introduce counters in OQL menu
entries

- N°3198: Simplify edition of n:n relations (less
clicks)

- N°2875: Add possibility to mention people in
caselogs

- N°580: Autocomplete in case of namesake, displays
other (configurable) information

- N°923: Add user id to history

- N°3712: Activity panel “edits” entries now show an
icon to explain their origin (csv import, webservices, …) when not
done by the user in theGUI

- N°988: Object display hide automatically empty
fieldsets

- N°1004: View and Edit display of n:n relations are
now identical

- N°2508: Include Obsolescence icon within list and
autocomplete

- N°2390: Auto-complete “starting with” are displayed
first

- N°2907: Keep read-only tabs visible in object edit
mode

- N°1731: Allow Transitions without unnecessary
confirmation

- N°1836: On cancel, console user is redirected to
the current class search page

- N°2629: Allow user to choose default
expanded/collapsed toolbar for richtext editors

- N°3495: WorkOrder fields 'ticket' and 'end date'
optionals

- N°3837: Add missing title to standard datamodel
dashboards

- N°2639: Increase fields tooltip visibility and
pertinence

- N°2224: Portal: Enable tooltips for object's
attributes description

- N°3583: Change default max items per list from 10
to 20

- N°3524: Add keyboard shortcuts to main
actions

- N°3274: Add “Service family” menu in 'Service
Management for Providers' installation option, as it exists in
other mode.

#### 管理员相关

- N°463: Queries from Phrasebook usable in
Notifications

- N°3287: Notifications: Set sender (from) display
name / label in action email

- N°3455: Add option to pass json_data as file to
RESTAPI

- N°3381: A healthpage is now available that returns
a json status without any authentication required:https://iTOP_URL/webservices/status.php”

- N°4096: In case of error when sending emails in the
background, iTop can be configured totry again
sending.

- N°4261: Portal: in case of uncatched Exceptions,
iTop can now write logs into the EventIssue class on an opt-in
basis.

- N°4354: Administrator accounts can be hidden with
configuration parameter “security.hide_administrators”

- N°4095: Add one time password user, which can only
connect once into iTop

- N°4036: An iTop user with a contact and Allowed
organizations, must be allowed on his contact's organization.
No-one can disable his own user, nor remove contact from its user,
nor remove the profile which allow him to edit users, nor add a
profile which would prevent him from editing users (such as 'Portal
User' which deny access to the Console).

- N°2699: Profile SynchroData Manager can see
SynchroReplica

- N°2713: Allow read access to synchro errors for
non-administrator users

- N°2330: Upgrade minimum PHP/MySQL version
supported/required for iTop

- N°3253: Disallow setup if PHP version not
compatible

- N°4332: include multi-LDAP into iTop
Community

- N°2527: Add Hierarchy key restoration as a
DBTools

- N°3625: Remove n:n classes from the “quick create”
autocomplete based on the “is_link” tag of the XML

- N°3575: Add curl as optional PHP module (required
for Impact analyses)

- N°3724: synchro_exec.php : now outputs the
processed datasource

Customization

- N°3185: Datamodel adds compact logo in
branding

- N°3182: Datamodel allows to redefine MenuGroup
icons

- N°3203: Datamodel: Add semantic for image & state
attributes

- N°2677: Datamodel: Add style definition for class &
enum

- N°3018: Add possibility for an object to have a
specific image instead of the generic class icon

- N°3822: Allow caselog ordering within datamodel
XML

- N°3245: Trigger OnObjectUpdate filters objects
after their update

- N°3217: Change iTop internal modules, add:
itop-structure, itop-bridge-cmdb-tickets, itop-faq-light,
itop-knownerror-light, remove: itop-knownerror-mgmt

- N°2370: remove MySQL views in iTop, moved to an
extension

UI

- N°1447: Setup screens have fixed height, so the
Next button remains under user's mouse

- N°3722: Hide field description tooltip if it has
the same content as field label

- N°4336: When a tooltip of an action is identical to
the label, do not display the tooltip (on console).

- N°4078: Display in console object details, for
custom shortcut actions, the icon (without label) if there is an
icon specified.

- N°4178: Stay on the same page when logging again
from the “Login again” prompt

- N°4082: Update German translations thanks to
Itomig

- N°3640: Update Spanish translations thanks to
Miguel Turrubiates

- N°3887: Max. number of displayed results now uses
the 'max_autocomplete_results' configuration parameter.

- N°3620: Add config. parameter
“quick_create.show_history”

- N°3621: Add config. parameter to disable “global
search” history

- N°3649: Add config. parameters:
activity_panel.lock_watcher_period &
activity_panel.entry_form_opened_by_default

- N°3662: Add config. parameter to choose
OneWayPassword hash algorithm

- N°3894: Add config. parameter
“activity_panel.prefilter_only_current_log”

- N°3896: Add CKeditor icon for enhance WikiText URLs
syntax, in console only.

- N°3936: Add user preference to choose backoffice
theme + “user_preferences.allow_backoffice_theme_override” config.
param. to disable it

#### Bug 修复

- N°1964: Fix: Focus stays on current tab when
switching to edit mode

- N°2560: Ignore double form submission, remove error
“invalid stimuli in current state”

- N°4050: Fix: When adding only an inline image to
the caselog, the notification is triggered

- N°331: Fix sort order of list during auto reloading
in dashlet and menu

- N°891: Make Ticket printing independent of
browser

- N°3821: UserRequest:OnInsert in full ITIL call the
parent's method

- N°3325: new version of CKEditor to fix display
bugs

- N°2950: Fix syntax highlighting (CKEditor) not
working on AttributeHTML

- N°3810: Avoid syntax highlighting that shouldn't
take place

- N°2534: Fix dashboard autorefresh to keep filtering
on organizations

- N°1634: List with “Autorefresh”, sum of items
refreshed after object deletion

- N°2511: Fix display of class with 2 dashboard
attributes

- N°3290: Fix attachments filename headers when
downloading

- N°3785: Fix corrupted attribute file on
download

- N°3166: Fix crashes if a “name” expression contains
a quote

- N°2946: Fix name displayed for field from a foreign
class

- N°2870: Portal: Fix “Notice: Undefined index:
UI:PropertiesTab” on object form

- N°2841: Prevent user deletion with not enough
rights

- N°2326: Zoom > 100% - tabs in second row not
properly aligned

- N°2251: Fix truncated tooltips

- N°2225: Fix tooltips containing a quote

- N°1397: Tooltip on Datasynchro no more
truncated

- N°2127: Fix field content overlapping outside of
the object details

- N°2788: FixHTMLfields/caselogs content
overlapping with a big table or unbreakable word

- N°3267: Webservices: Fix optional headers not being
taken into account

- N°3171: Friendly name and obsolescence flag now
refreshed

- N°4131: Always use the same dialog for this message
instead of creating a new one every time we detect the user is
logged off.

- N°1056: Look: empty field not as high as others in
object details

- N°1505: Fix “Paste” button in iTop Ckeditor not
working in all browsers

- N°1745: Prevent malformed caselog entries from
breaking activity panel

- N°2007: Portal: Tooltips that do not contain text
(empty tooltips) are no longer display on BrowseBrick items.

- N°2852: Fix autocomplete selector error when
selecting an object containing special characters

- N°3680: Advanced search: Fix string criterion
contains '0' returning all results

- N°3944: Prevent a PHP “notice” when the log level
is configured per-channel, but not all channels are listed in the
config.

- N°3987: Fix circular reference failures when
creating Configuration items.

- N°4029: Fix caching images in Chrome

- N°4079: Typo in french dictionary on
lnkApplicationSolutionToBusinessProcess

- N°4105: Fix decimal number being truncated in
GroupBy dashlet

- N°4132: Look: Fix sizes being displayed as bits
instead of bytes in Setup

- N°4327: Fix JS “ReferenceError” in Application
Upgrade

- N°4385: Fix DBObject→GetRelatedObjectsUp
behavior

- N°4173: Reduce AttributeBlob memory footprint

#### 安全性

- N°4362: Security: CVE-2021-41162

- N°4129: Security: HTTP header
“Content-Security-Policy: sandbox;” is send when displaying an
AttributeFile directly in a browser's tab.This can be removed with
“security.disable_inline_documents_sandbox” config.
parameter.

#### Modernizations

Those changes can have an impact on extension developers:

#### Enhancements

- MetaModel::GetStateAttributeCode($sClass) now
returns the state code of class with states but no transition (eg.
Person, Organization, PhysicalDevice, …)

- N°3735: New method AddValue on DBObject for ITSM
Designer users

- N°3721: Toolkit: Restore previous behavior on “iTop
update”: Delete all env-production folder

- N°3657: Replace deprecate calls to jQuery event
listeners (eg. “.click”, “.bind”, …)

- N°3184: Upgrade JQuery UI (iTop 3.0)

- N°2956: Upgrade jQuery to v3.5.1

- N°3199: Add dependencies management system for
JS/CSS

- N°3010: IE11 not supported anymore

- N°3009: PHP Minimum version raised to 7.1

- N°2969: Add support for dictionaries folder in
modules

- N°2957: PHP namespace management through XML

- N°2899: Setup: Add mbstring as mandatory PHP
extension

- N°2214: Add a PHP version check in CLI PHP
scripts

- N°2284: Replace JQuery Autocompleter plugin by
JQuery UI Autocomplete widget

- N°3811: UI.php : log stacktrace with debug
level

- N°2986: Reintegrate application menus from “welcome
itil” into application

- N°2738: Remove unused dict keys

- N°2286: Remove usages of js/jquery.layout.js
lib.

- N°2737: Migrate table to DataTables plugin to be
iso with the end-users portal

- N°2766: Optimize columns load when using REST/JSONAPIcore/get

- N°2999: Optimize OQL

- N°3123: Update the list of required PHP
extensions

- N°3154: Sample data Contacts : integrate new
Combodo employees

- N°3215: Internal: Refactor renderer files to be
part of the autoloader instead of being load manually

- N°3216: Internal: Refactor form files to part of
the autoloader instead of being load manually

- N°3231: Allow browser access to static resources
files in the /lib folder

- N°3251: Internal : Automated tests + refactoring
for robustness of the code against SQL injection

- N°3389: Change XML version from 1.7 to 3.0. From
now on, the XML version will be aligned with iTop core
version

- N°3588: SCSS included/cascaded are used in
compilation, on top of those declared in XML.

- N°3663: Move exceptions to the same directory

- N°3731: Add log of calls to deprecated files / PHP
methods

- N°3828: Remove MPDF coupling from iTop code

- N°4024: Protect
\iApplicationUIExtension::EnumAllowedActions uses

- N°4158: New developer_mode.enabled config
parameter

- N°4246: MetaModel::GetPrerequisiteAttributes now
provides $sClass parameter when calling
AttributeDefinition::GetPrerequisiteAttributes() method

- N°1047: “iTop” occurences in the dictionnaries have
been replaced with the ITOP_APPLICATION_SHORT constant

- N°3433: Remove useless data in DataModel when
itop-portal is not present

- N°3349: Clean references to the old Flash
resources

- N°3379: Introduce more modern tooltip lib. in the
backoffice

- N°4092: New data/.compilation-symlinks compilation
flag and setup option

- N°4155: Add ability to modify the content of
MenuBlocks from outside the class

- N°3617: Use user pref instead of localStorage for
collapsible elements state saving

#### Deprecations

- N°2393: Font Awesome remove v4 compatibility

- N°2573: Remove MetaModel::GetNextKey et
CMDBSource::GetNextInsertId

- N°2548: Remove deprecated
\DBObject::GetRelationQueries

- N°2440:API: remove
CMDBSource::GetNextInsertId

- N°2591:API: deprecate
\CMDBObject::CheckUserRights

- N°2522:API: Deprecate
SetupPage:log*

- N°2372:API: remove
\MetaModel::EnumLinksClasses and
\MetaModel::EnumLinkingClasses

- N°2362:API: remove
DBInsertTracked / DBUpdateTracked

- N°3792: Deprecate “buttons_position” configuration
paramter

- N°852: Cleanup: remove deprecated impact analysis
algorithm

- N°3748: Deprecation: old tooltip libs in the
backoffice and the portal

- N°3233: Remove “display template” feature from
MetaModel

- N°4176: Portal: Deprecate “AddParameterToUrl”
function

# 2.7.x

## 2.7.13

- N°8379 - CVE-2025-47286 - Remote Code Execution in
the backup creation functionality

- N°8355 - Fix reflected XSS in ajax.render.php
render_dashboard

- N°8313 - Fix XSS vulnerability in the
/pages/ajax.render.php

- N°8281 - Customized Request Form: Fix search field
button with multiple request templates

- N°8231 - Hide password fields stored byAPIin
EventRestService

- N°8215 - Fix compatibility with Global Request when
PHP warning are enabled

- N°8201 - FixCSSReflected, XSS Reflected at the
name=“attr_installed” (Low or Medium)

- N°8168 - Add protection against XSS in portals
lnk

## 2.7.12

- N°7219 - Fix broken dashboard having special
caracters in their title

- N°7770 - CVE-2024-52601 - Secure Direct Object
Reference + prevent Mass Data Leak

- N°7776 - CVE-2025-24021 - Prevent mass assignement
of fields not present in form

- N°7810 - CVE-2025-24022 - Prevent Portal code
injection

## 2.7.11

- N°4164 - SAML - Hide logoff from portal

- N°4314 - Fix Uniqueness rules not working with
Silo

- N°5775 - Allow configuration of OAuth client on MS
Azure with single tenant

- N°6968 - Improve audit performance

- N°6993 - Fix bulk transition on object containing a
blob

- N°7075 - Add check for Content Security Policies
(CSP) in the setup

- N°7085 - Fix infinite loop in login page until
fatal error occurs

- N°7122 - Portal: Hide log off button when user
can't actually log off (eg. SSO using SAML or other
providers)

- N°7127 - Upgrade handlebars.js to v4.7.8

- N°7137 - DataSynchro: Remove “Organization” as
default value for SynchroReplica→dest_class

- N°7245 - Bettor logs on
RunTimeEnvironment::CallInstallerHandlers exceptions

- N°7255 - Fix misc. stylesheets not working in
portal since N°7047

- N°7302 - Fix wrong unit name in
\SetupUtils::HumanReadableSize

- N°7343 - Better error message when compiling a PHP
invalid dict file during setup

- N°7344 - rest.php : better message when cannot
execute OQL query

- N°7448 - Forbid user enumeration through RestAPI

- N°7455 - Fix SSRF through arbitrary PHP class
instantiation

- N°7545 - Fix Self XSS in portal picture upload by
following owasp recommendations

- N°7548 - Fix Stored Self XSS in preferences

## 2.7.10

- N°7062 - Add unit test to ensure that setup SCSS is
compiled correctly

- N°7056 - Limit unnecessary unsafe-inline content in
content-security-policy http header

- N°7042 - Fix check to write error when setting a
ext. key programmatically on the end-users portal

- N°7023 - Fix check to write error when adding an
item on a n:n relation (eg. contact) on a new object (eg. user
request) on the end-users portal

- N°7005 - Fix portal stylesheets not being
re-compiled when outdated

- N°6989 - CVE-2023-48710 Limit pages/exec.php script
to PHP files

- N°6951 - CVE-2023-48709 Fix CSV injection in Excel
from an iTop CSV export file

- N°6889 - Cannot backup on localhost with MariaDB
>= 10.6.1 since iTop 2.7.9 as iTop is now forcing tcp connection
instead of socket

- N°6887 - Fix excessive OQL requests to display
user's grant matrix

- N°6886 - Add OAuth tests folder to removable
directories list

- N°6791 - Remove setup/install directory from iTop
package

- N°6777 - Fix XSS vulnerability in dashboard
title

- N°6754 - PHP unit tests: Add local PHPUnit XML
files to .gitignore

- N°6738 - UI:RunQuery:Error uses inconsistencies
with Dict::Format

- N°6606 - CVE-2023-44396 XSS vulnerabilities in
dashlet ajax operations

- N°6600 - Portal attachment download : whole SQL
query displayed on non existing attachment id error

- N°6560 - CVE-2023-43790 XSS in friendlyname in
object details

- N°6458 - CVE-2023-45808 Prevent objects creation in
non allowed org by forging http query in both Console and
Portal

- N°6097 - Enable PHP unit tests on a custom
DataModel

- N°5621 - Add not managed JS dependencies to NPM to
get updates on vulnerabilities

- N°5491 - Fix UI crash due to missing placeholders
in dictionaries entries

- N°5136 - Fix “Select All objects” adding obsolete
objects even if “show obsolete data” param. not activated

- N°4368 - Send X-Content-Type-Options in HTTP
headers

- N°3715 - Fix export above 1000 entries with
obsolete data

- N°2909 - Fix search on Enum, Date, TagSet,… with
index

- N°938 - Improve print of portal object page and
portal dashboard page

## 2.7.9

#### 新行为

- N°541 - Dashlets: Improve readability when to much
labels (pie chart) or too long labels (bar chart)

- N°6039 - OAuth: Adapt internal mechanism to support
Microsoft Graph instead of Azure AD Graph

- N°6019 - Increase PHP min version to 7.1.3 to
enable dependencies update

- N°6247 - Add accessibility meta data for title on
“Actions” and “Toolkit” menus

- N°6217 - Add accessibility meta data for title on
“Power menu”

- N°6436 - Integrate Performance Audit pre requisite
in iTop Pro 2.7.9

- N°5893 - Implement error handling on triggers part
I (minor version branches)

#### Bug 修复

- N°6098 - updateLicenses.php : check requirements
before launch

- N°4698 - setup/phpinfo.php : handle iTop not yet
installed

- N°6427 - PHPMail can misfunction in function of
SMTP software used

- N°6340 - Fix permission refused when sending an
email and renewing Auth token in synchronous mode

- N°6173 - \HTMLSanitizer::Sanitize : Fix handling
only svg_sanitizer

- N°6123 - Warnings when launching a backup on
MariaDB > v10.6.1 with localhost

- N°6112 - Dashboard: Improve robustness by trimming
dashlet ID returned by server

- N°5797 - Use LoadConfig method in all Email
children classes

- N°5865 - DoCheckToWrite does not have the same
behaviour in the console and the portal

- N°5729 - Fix disabled button in bulk
update/transition when picking a value in a drop-down list

- N°5765 - Setup: Never cache folder permissions test
response

#### 安全性

- N°6548 - Hide DBHost and DBUser in log

- N°6396 - CVE-2023-34443 CSRF vulnerability in the
run_query.php page

- N°6359 - Cross-site Scripting (XSS) - DOM XSS in
activity panel

- N°6358 - CSRF (Cross Site Request Forgery) onAPIRest

- N°6351 - CVE-2023-34444 XSS vulnerability on
pages/ajax.searchform.php

- N°6350 - CVE-2023-34445 XSS vulnerability on
pages/ajax.render.php

- N°6238 - guzzlehttp/psr7 vulnerability

- N°6017 - CVE-2021-46743: Firebase PHP-JWT
key/algorithm type confusion

## 2.7.8

#### 新行为

- N°5758 - Change setup test for GDPR consent

- N°5523 - Setup wizard : use the ITOP_APPLICATION
constant instead of hardcoded “iTop” string

- N°5235 - Setup : check temp dir permissions

- N°5553 - OAuth authentication : Hide Client
Secret

- N°5430/N°5333 - OAuth authentication : add
capability to customize redirect landingURL

- N°5414 - Improve debug log for invalid notification
placeholders

- N°5155 - Allow to send email by SMTP with
self-signed certificate

- N°5685 - Upgrade apereo/phpcas lib to fix
vulnerability

#### Bug 修复

- N°5431 - OAuth authentication : fix dict key
missing in redirect page

- N°5611 - OAuth authentication : Fix missing
composer files

- N°5216 - Fix Error “Invalid ID given” when sending
ActionEmail using cron on a system with french locale

- N°4947 - Fix Email always picking “production” env
config file

- N°5356 - Fix “fieldForm is null” JS error when
modifying Server.location

- N°2244 - Fix image attributes not being visible in
PDF exports

- N°5724 - CVE-2022-31403 : XSS vulnerability via
/itop/pages/ajax.render.php

#### 安全性

- N°5741 - Portal security improvement

- N°5725 - Portal security improvement

- N°4449 - Export security fix

## 2.7.7

#### 新行为

- N°5102 - Allow to send emails (eg. notifications)
using GSuite SMTP and Office365 SMTP withOAuth2

- N°5129 - Disable buttons in transition form while
loading AttributeExternalFields

- N°4479 - Impact analysis : Display and apply filter
before display impact analysis graphical

- N°5114 - Increase file access protection in iTop
packages

- N°5037 - Setup: Request user agreement at
installation for personal data collection.

- N°5035 - Setup: Remove tracking image at the end of
the setup

- N°5090 - Setup: Improve missing dependencies
message

- N°4666 - Core update now install new mandatory
modules (specified in install.xml)

- N°4642 - Core Update : limit the usage of this
function to minor version upgrade

- N°5109 - PHP min version jumped from 5.6 to 7.0.8
for iTop 2.7.7

#### Bug 修复

- N°4530 - Fix regression with multi-classes OQL,
working for admin only.

- N°4284 - Fix regression: Object modification:
Attribute value lost if not allowed to be seen

- N°4057 - Fix regression: Custom Translation for
Custom Tab is not inherited by instanciable Classes

- N°4898 - Reflected XSS on enums modification

- N°4867 - Fix “Twig content not allowed” error with
“extkey search icon” in user portal

- N°5215 - Portal security improvement

- N°5211 - Application upgrade install new modules in
datamodel/2.x

- N°5168 - Portal security hardening for self profil
modification

- N°5002 - Fix memory leak after object creation in
popup

- N°4998 - Fix display of AttributeDuration in
transition forms

- N°4976 - Add CSRF token in the csv import
page

- N°4920 - Fix “undefined index” notice in user
rights

- N°4900 - Sanitize dashlets to prevent XSS
injection

- N°4899 - Reflected XSS on revert_dashboard
operation

- N°4872 - Fix ticket creation in resolved status,
loosing its Inline images

- N°4558 - Remove PHP notice in
\CMDBSource::StartTransaction

- N°4538 - Fix display on dashlet Groupby an
ExternalKey with special character

- N°4488 - Remove
cmdbAbstractObject::GetSetAsHTMLSpreadsheet() from usableAPImethods

- N°4714 - New ITOP_CORE_VERSION constant

## 2.7.6

- N°4486: Fix DataSynchro replica errors due to
CMDBChange not found

- N°4213: EnumSet can be displayed in read mode in
user portal

- N°2510: Fix expand Log entry in list view in
console

- N°4463: Enable trigger even on objects that the
user cannot see

#### 稳定性

- N°4399: Fix memory error on setup when lots of
attachments in DB

- N°4335: Fix export crashing on PHP < 7.0

- N°4298: Fix .maintenance file isn't removed anymore
by setup

- N°4286: Can download again backup at the end of the
setup

#### Supportability

- N°4162: Portal exception page : restore exception
message

- N°4202: Setup memory_limit check : clearer
message

- N°4126: Improve `max_allowed_packet` checks
messages

- N°4125: When apcu cache does not return what is
expected, an error is added to the error_log in a dedicated
channel. The cache is not emptied, the error is user visible on
purpose as the administrator must fix the wrong APCU version.

#### 安全性

#### 安全性

- N°4231: CVE-2021-32610 Update pear/archive_tar lib
to 1.4.14

- N°4289: CVE-2021-41245 : CSRF tokens aren't locked
to one session

- N°4304: Can browse all of the server
InlineImage

- N°4356: Portal : attachment downloads are opened in
the browser

- N°4359: Dashboard export : can load multiple files
andURL

- N°4360: XSS by uploading malicious SVG file as user
portal profile picture

- N°4363: RCSS in
ajax.render.php?operation=save_dashboard

- N°4365: RCSS in the dashboard editor

- N°4367: RCSS in
/pages/ajax.render.php?operation=objectSearchForm

- N°4384: CVE-2022-24780 - “Twig content not allowed”
error when use the extkey widget search icon in the user
portal

- N°4414: Security issue with Database Error

- N°4478: Update dataTables lib. to 1.11.3 in iTop
2.7

- N°4491: XSS in “Header with statistics”
dashlet

- N°4492: XSS in Advanced search locked
criteria

- N°4493: XSS in tagset spreadsheet export

- N°4495: XSS in Advanced search external key
criteria

- N°4499: XSS in export-v2 on OQL error

- N°4501: XSS in attachment list on uploader
name

## 2.7.5

- 2.7.5-2: Fix setup wizard when DB
connection is using TLS

- 2.7.5-1: official release number,2.7.5was not published.

#### 稳定性

- Increase nb of supported UNION in OQL query from
~40 to more than 450

- Add ability to skip the rebuild of hierarchical key
during setup

- An echo command present in the code, has been
removed.

- Loader is now displayed immediately before building
the items for the tree/mosaic modes, to ensure it is
displayed.

- Fix mutex being silently released after connection
timeout, it's no more released.

- During setup, separate “modify fields” and “create
index” in db request.

- Add \utils::SetMinMemoryLimit

- Portal database transaction removed.

- Portal: fix the Notice “Undefined index:
max_display_limit” (bug introduced in 2.7.1)

#### Supportability

- Specific traces added (option) on cmdbsource log
channel. UserId added in the error.log file.

- New error messages added in case of failure of
object creation or update“

- Add test if ajax call is canceled

- Portal : fix modification of field in order to hide
another one

- Better formatting of the details and reports (1
line requests)

- Add new logs for object lists in portal (debug
level, 'portal' channel)

- List order : add a log when data are invalid

#### 安全性

- CVE-2021-32664 - Reflected XSS with Administrator
credentials]]

- Update pear/archive_tar lib to 1.4.13

- The file index.php is now protected with a token
that prevent accessing the setup in an uncontrolled way.

- Mask the Password database in the setup
process

- Prevent the mysql password to appear on
misconfigured servers

## 2.7.4

#### Reverse Proxy

- Products only: explicit message in case of
misconfigured proxies for ITSM Designer connection.

- Fix improper redirection to the homepage when iTop
is behind a reverse proxy:Check thereverse proxy recommended
settingsfor iTop compatibilitySet the new configuration parameter
'behind_reverse_proxy' ⇒ 'true' if you have reverse proxies.

- app_root_url: now handle reverse proxies during the
setup and preserve existing configuration during an upgrade,

- Check thereverse proxy recommended
settingsfor iTop compatibility

- Set the new configuration parameter
'behind_reverse_proxy' ⇒ 'true' if you have reverse proxies.

#### Setup & performance

- Setup: Prevent usage of “Application upgrade” if a
file integrity problem is detected

- Setup: support for 'auto_select' and extension.xml
has been fixed,

- Setup performance: clean orphan CMDBChange records
limited to 100K,

- Setup performance: orphan attachments deletion is
limited to 30s max,

- Garbage collection of used transaction id, done
less often (new config parameter: transactions_gc_threshold)

#### Misc

- Restore Portal headers labels on CSV export
(regression introduced in 2.7.2)

- Support parenthesis in enumeration codes,

- OQL: Fix join on another class than the
corresponding external key target,

- OQL: Fix count on union with conditions on
multi-column attributes,

- Customization: FixHTMLdisplayed in Login
window

- Dictionary: missing translation when
initial_state_path is used

- Dictionary: missing translation for background
tasks status and errors on asynchronous tasks

#### 安全性

- Security: fix validation of CSRF token in the
portal

- Security: fix command injection vulnerability in
the Setup Wizard

- Security: Fixed a bug preventing deletion of used
token on windows servers,

- Security on “group by” dashlets : access right is
controlled and password attributes are not usable

## 2.7.3

- 2.7.3-1Portal: fix the Notice
“Undefined index: max_display_limit” (bug introduced in
2.7.1)

#### Regressions fixes

- Restore support of:current_contact→codein OQL queries (bug
introduced in 2.7.2)

- Restore preview of Document file (bug
introduced in 2.7.2)

- Restore UI behavior: first tab is selected when
mandatory field is missing (bug introduced in 2.7.0)

- Fix setup with Chrome v87 (bug generated by a
Chrome upgrade)

- Fix modal created without an ID in the Portal
(bug introduced in 2.7.0)

- Fix crash when login on with a admin user in admin
only mode

## 2.7.2

- 2.7.2-1Fix 2.7.2 regression:
console exports failing with “missing token” error.

#### 新行为

- Enable CSV import of iTop Users by non admin users
(as long as they are allowed by Admin Tools Delegation)

- Background task: fix issue with tasks not always
executed (Notify on Expiration for eg.)

- Add Trigger information to the error log when an
Action fails

- Fix creation of objects containing AttributeImage
on PHP 7.4 with warnings activated

- Avoid PHP notices on DBObject core code, during
transitions

- PHP notice has been removed when creating a new
FULLTEXT index in the database (TagSet attribute)

- Removed default admin phone number which was
invalid for mysql in strict mode

- Changing Color of Brick Search on Portail with
extension Custom is now easier

- Fix alias problem in portal scopes. Warning: If you
have duplicateitop-portal-base,
BrowseBrickController.php code must be updated, cf commit on
Git.

#### Translations

- Fixes two typos in German translations

- Fix spelling typo on iTop welcome page

- Spelling mistakes fixed

- Fix use of application constants in Dutch
translations

#### 安全性 fixes

- Fix session fixation issue - CVE-2020-15220

- Sanitize breadcrumb entries - CVE-2020-15221

- Don't display error details (error details remain
logged) - CVE-2020-15219

- HTTP headers have been added - CVE-2020-15218

- Better control of the transaction_id parameter -
CVE-2020-16842

- Portal user could export more datas than his portal
scope (CVE-2020-4079)

- Hide MySQL Password from error.log in case of MySQL
connection error

#### Regressions fixes

- import csv : Fix display, previousely showning
confusing html tags

- Fixed OQL: Fix malformed UNION queries in portal
scopes

- Fix standard Global Search feature which was only
searching on last word

- Fix bug on mass update: blocking message “Please
wait while updating fields”

- Fix regression in notification when using
placeholder like$current_user→attribute_code$

- Fix internal regexp no more compatible starting
from PHP 7.3

- Restore log KPI calls in Portal

- Fix notifications on threshold not sent when
trigger is created on iTop 2.7.1

- Portal: fix incompatibility betweenignore_silo=trueand nested query in scopes

- Portal: Multi-word search has been fixed for
ManageBrick in lazy mode.

- Portal Filters is now executed on visible values
and not on html code of cells

- Fix empty tabs being displayed (misuse of theAPIor user
rights)

- Fix rendering of an ExternalField on a Text with
XML content

- Configure this list : missing sort icon, replaced
by fontawesome character

- Fix backup download: Stop capturing output before
sending backup file (avoid memory problem)

- Fix corrupted backups when a file has a size which
is a multiple of 512 bytes

- Dashlet: fix invalid filter parameter, when using &
(ampersand) in the query

- Fix cron.php creating a new CMDBChange for every
BackgroundProcess

- Login screen supportHTMLfor dictionary entry:
'UI:Login:About'

- DataModel - LifeCycle visualization: fix open and
close buttons no more working

- Fix wrong count of related objects due to Obsolete
& Archived

- Fix variable evaluation in ListExpression to avoid
double parenthesis.

## 2.7.1

#### 新行为

- Portal: Total count on Managed Brick is now
accurate even when objects are in multiple tabs.

- An attribute File can now be emptied by the
user.

- Auto-complete on external key takes into account
obsolescence user preference

- Search on Text containing “_” now possible without
being used as a wildcard.

- End user Wiki explains how to search for ”%“
character using “\%”, otherwise ”%“ matches any string

- Dashlet Header statistic on ExternalKey, now
displays friendlynames and no more ids

- All Dashlet Title uses now Left alignment.

- “Configure this list” shows obsolete data only if
required by user preferences.

- Providing an empty file as attachment is no more
allowed (it was crashing iTop)

- Improve user feedback on invalid transition: Silent
or simple warning -yellow banner-, rather than error. A double
click on a transition, or a browser back and force, no more
generates any fatal error.

- Limit searchable classes in a tree, to those
allowed to the user, in a SearchMenuNode

- Files integrity is controlled in the first screen
of “Application upgrade” and a warning is displayed when the
install is not conform

- Align creation and update message on portal to
console message

- Allow to set return-path with
\EMail::AddToHeader

#### Bug 修复

- Fix “cron” case in labels

- Fix Export of html fields such as in Notification
Actions

- Portal : autocomplete keep selected value and use
'max_display_limit' instead of 'max_combo_length'.

- Prevent object form submission while a filter on
depending field is under computation (to prevent saving of
incoherent object)

- Fix search on external key, when using the
magnifier and a filter in the pop-up

- Export of EventIssue object is now possible

- History of AttributeEncryptedString no more
interpretsHTMLtags

- Fix OQL scopes generating malformed SQL query
(corner case with UNION)

- Add TLs Options on database restore command

- Add mbstring as optional extension in setup

- Fix infinite loops when logging with a Contact
having a non empty TagSet field

- Copy characters after a ”<“ character in a Copy
operation on a Transition

- dbClick to exit the “description” field when
creating an incident on the portal

- Fatal errors now log into error.log instead of
setup.log

#### Developper

- Backoffice theme: Add variable for menu group
background color

- ApplyStimulus: Rollback the object values when an
action fails

- GetAttributeFlag taken into account on form refresh
with dependent field

- Fix: GetTrackOrigin() now returns 'csv-interactive'
value during csvimport

- Fix error in file light-gray.scss

- Clearer messages when an object update fails

#### Login

- Provisioning for hybrid auth fails

- Fix “Undefined index: login_mode” Notice

- Added support for REDIRECT_HTTP_AUTHORIZATION in
basic authentication.

#### 安全性 Fixes

- CVE-2020-12777

- CVE-2020-12778

- CVE-2020-12779

- CVE-2020-12780

- CVE-2020-12781

#### Compatibility IE11

- Third dashlet added in the same dashboard cell
underIEwas crashing

- Portal Filter Brick input was ignored under
IE11

- Applying a transition no more ends with blank page
underIE

#### Fix regressions

- Portal can again display more 10 attachments

- OQL syntax error displayed in place of the widget
(no more fatal error)

- Fix syntax error with PHP 5.6 and TCPDF 6.3.4

- Fix missing fulltext index for all AttributeSet on
table creation (i.e. install from scratch) and update
(migration).

- Fix setup crash when having enum with values
containing parenthesis

- Fix filtering of unions with parent class

- Fix backup not executed anymore

- The AttributeDefinition::IsSearchable() method has
been fixed to check complex attributes like External Fields.

- Fix unsaved dashlet added on a dashboard

- Fix alias renaming when already exists in one OQL
of an UNION

- “Printer Friendly Version” screen: Tabs now display
labels instead of codes

- Fix deletion of a single replica within a
list

## 2.7.0

- 2.7.0-2: Fix regressions
introduced by 2.7.0:Fix:RenameAlias: alias 'L-1-1' already
usedin one OQL of an UNIONFix: Dashlet added on a dashboard are gone when
coming back to the dashboardFix: Provisioning for hybrid auth fails, fixed by
changing the Tracked OriginFix: Can't send attachment added before saving
using “Send updates by email”Fix: Global Search doesn't search in external
fieldsFix: Backup triggered by cron were not executed
anymore

- Fix:RenameAlias: alias 'L-1-1' already
usedin one OQL of an UNION

- Fix: Dashlet added on a dashboard are gone when
coming back to the dashboard

- Fix: Provisioning for hybrid auth fails, fixed by
changing the Tracked Origin

- Fix: Can't send attachment added before saving
using “Send updates by email”

- Fix: Global Search doesn't search in external
fields

- Fix: Backup triggered by cron were not executed
anymore

- 2.7.0-1: Fix regressions
introduced by 2.7.0:Fix: iTop not working with MYSQL 5.6Fix: Fix DataModel Viewer not supporting special
chars in class name (eg. ”)

- Fix: iTop not working with MYSQL 5.6

- Fix: Fix DataModel Viewer not supporting special
chars in class name (eg. ”)

#### 新行为

- During Setup, Move to production, Hub installation…
iTop is set in ACCESS_READONLY

- After Setup, the configuration parameter
access_mode is set to ACCESS_FULL

- Debug OQL for search is accessible directly for the
administrators

- Replaced first name by last name in default person
list view

- Don't display organization name in menu bar if it's
the only one

- Prevent trigger creation without friendlyname

- Add applicable contexts on Trigger

- Track field Comment in core/delete -APIREST

#### Authentication & security

- Authentication extensibility: Allow login, logoff
screens customization through an extension

- Security extensibility: Add hooks for iTop login
security hardening

- Security extensibility: New fields on UserLocal for
an extension to handle password expiration

- Security: Add a user password complexity constrains
on new users and password change

- Security: Every OQL selected classes are checked
against allowed organizations.

- Security: Fix issue with user creation by a non
administrator

- Security: Prevent search to retrieve users
belonging to not allowed Org

- Security: Global search now ignore fields of type
“AttributePassword”

- Security: Prevent Password Autocomplete in Browser.
But most browsers ignore this tag.

- Security: Restrict access to assets into env-*,
extensions and datamodels

- Security: config.php access rights have been forced
to 0440 in creation instead of 0444.

- Security: Fix CVE-2019-19821

- Password policy: change password page: add feedback
during the password typing

- Password policy: Enable password expiry

#### Look & Feel

- Markup extensibility: Add meta informations and
hooks

- Markup extensibility: Introduce custom themes for
iTop's console

- Markup extensibility: Add markup hooks on
BrowseBrick and ManageBrick tables

- Markup extensibility: Add support for both code AND
title in admin. console tabs

- Markup extensibility: Add password attributes to
exclude list in metadata

- Markup extensibility: Rework some SCSS
variables

- Markup extensibility: Add one additional theme for
the backoffice, for test instances

- Change breadcrumb icons color to black instead of
Combodo's orange

- Fix style for input's feedback on “change password”
page

- Login page : add autofocus attribute to the id
field

- Attachments: Update MS Office and OpenOffice file
icons with more modern versions

#### OQL & ORM

- OQL: Supports nested queries such as: SELECT Team
WHERE id NOT IN (SELECT…)

- OQL: Supports: ISNULL(NULL) OR
(`ServiceSubcategory`.`request_type` = NULL)

- OQL: Enhance performance of Count() by ignoring
external keys

- OQL: Improve OQL performance

- OQL: Optimize generation of SQL from OQL, removing
useless JOIN.

- OQL: Spread the finalclass column on all the DB
tables except finalclass table it-self. Migration done
automatically at Setup.

- OQL: Transactions added to fix deadlock during
concurrent access and guarantee Database integrity

- OQL: Transactions used for creation of object with
class hierarchy, as it generate entries in multiple tables.

- OQL: Export DBSearch to JSON (for a future OQL
graphical editor)

- ORM: Allow to force a WebPageMenu to open its url
in a new window

- ORM: Access to object modifications in
\iApplicationObjectExtension::OnDBUpdate and in
\DBObject::AfterUpdate

- ORM: Delegate definition of the ticket reference
format to each sub-classes

- ORM: Change visibility of
\DBObject::GetReferencingObjects internal method from public to
protected

- Allow params “limit” and “page” in
REST-API(Dennis Lassiter)

- Updated wiki for \DBBackup::CreateZip removal

#### Portal

- Portal: Show confirmation dialog when closing forms
with unsaved data

- Portal: Add an icon to copy object name and url
next to the form title

- Portal: Add support for abstract classes creation
in browse brick

- Portal: Add support for columns sorting in
ManageBrick's “lazy” mode

- Portal: Hide silently sub-bricks not allowed to the
user, when displaying an Aggregate Brick .

- Portal: External keys in form allow to open the
associated object if user scopes allows it.

- Portal: Introduce navigation rules in Portal, to
specify where to go on closing a form

- Portal: action_rules query without filter will now
throw an exception

- Portal: Add option to display ManageBrick's current
tab description as the brick subtitle.

- Portal: Every brick can display a subtitle if they
populate the sBrickSubtitle variable in the template.

- Portal: Add option to show/hide linkedsets out of
user's scopes in portal

- Portal: Add parameter to set default list length in
ManageBrick and BrowseBrick

- Portal: Allow n:n links for Browse Brick's
levels

- Portal: Browse brick actions are now ordered
following a rank tag

- Portal: Filter linkedsets on remote object
scopes

- Portal: Form submission do NOT include hidden
fields anymore, unless they have a dependency to an editable
field.

- Portal: Enable use of a dedicated end-users portal
without having to install the standard portal

- Portal: Make portal denial based on user profiles
work again

- Portal: Manage and Browse brick filters apply on
subclasses fields in lazy mode

- Portal: Migrate end-users portal framework from
Silex to Symfony 3.4 🚀 .

- Portal: Fix filter on external key when coming from
filter brick

- Portal: Increase navigation rules checks
robustness

- Portal: Display attachments count in section title,
updated on each add/delete

- Portal: Fix origin modal not closing when switching
to editing of an object

- Portal: Better display of success messages on form
validation

- Portal: Support for AttributeEnumSet

- Improve modal backdrop UX

- Introduce “CombodoPortalToolbox”, helpers to ease
JS manipulations especially through the iPopupMenuExtension

- Increase blur effect on portal modal backdrop

- Warning: Remove legacy end-user portal

- Warning: All your portal extensions needs to be
migrated, see migration notes

#### Setup & system

- Setup: New feature to allow micro versions update,
as long as the module list does not change.

- Setup: New file .maintenance in data directory to
prevent iTop or cron to interfer with an application upgrade

- Setup: hide table prefix option by default.

- Setup: php-gd is now mandatory on setup

- Setup: Remove useless alter table queries generated
by setup & Toolkit on MariaDB >= 10.2

- Setup: Add real autoloader for framework files in
/core and /application

- Setup: iTop classes are now loaded with an
autoloader

- Supportability: Maintenance mode (Better setup,
CRON, REST and export message)

- Backup: archive creation errors are now
displayed

- Backup during Setup are stored in
data/backups/manual/setup-YYYY-MM-DD-HH-mm.tar.gz (thanks to Hipska
- PR #61)

- System: Change cron.cmd to use arguments instead of
fixed paths

- System: Generic method to check path validity

- System: New log level “debug” and logs
filterable

- System: PHP dependencies managed by a
composer.json

#### User interface

- UI: Reorganize admin console menus

- UI: Attachments are displayed as table with their
meta data

- UI: Add code snippets with syntax highlighting to
CaseLog/HTMLfields

- UI: Autocomplete: Harmonize accents handling for
better robustness

- UI: New DroidSansFallback font and
'export_pdf_font' config param for PDF export

- UI: Trigger description is now required because it
is used as friendlyname

- UI: Center tag is back in default sanitizer white
list

#### Code upgrade

- Upgrade Archive_Tar lib from 1.4.4 custom to
1.4.7

- Upgrade bootstrap to v3.4.1

- Upgrade CKEditor to v4.11.4

- Upgrade Font Awesome from v4 to v5.12.0

- Upgrade jQuery to v3.4.1

- Upgrade ScssPHP to v1.0.6

- Upgrade SwiftMailer to v5.4.12

- Upgrade ArchiveTar to v1.4.9

#### Misc

- Update cron.cmd to have better defaults and remove
references to old php version

- Make setup backup location and name similar as
other backups (Thomas Casteleyn)

- Add status.php for getting iTop's status (Guy
Couronné)

- Add support to optionally mention username in
password reset mail (Thomas Casteleyn)

- Make ticket reference generation working with new
sub-classes

- Add KPI onAPIRest (Guy
Couronné)

- Only set Ticket ref if not yet present via import
or synchro (Thomas Casteleyn)

- Move expression cache files in a dedicated
directory

- Add bootstrap.inc.php

- Handle nested transactions

- apc_clear_cache & opcache_reset are both called
when resetting the cache

- Integratedatabase integritymodule

#### Translations

- NL Dictionaries and messages (Thomas
Casteleyn)

- CN @purplegrape

- SK Martin Kincel

- Chinese translations

- Spanish translations

#### Bug 修复

- UI: Fix blank page when displaying a synchronized
object. Simple quote not escaped before giving content to qTip
lib.

- UI: Fix dashlet edition due to duplicate ids of
dashlets, by renumbering them when building in iTop pages.

- UI: Fix 'G', 'd', 'j' DateTime format in regexp
generation

- UI: Fix GroupBy dashlet on classes with
ExternalField to ExternalField

- UI: Fix missing scroll bar in DataModel Viewer for
class with large number of attributs

- UI: Fix missing scroll bar missing in modal window
“Create a new field” from Request Template

- UI: Fix non editable dashboard when wrong attribute
code used in its definition

- UI: Fix regression on mandatory external field with
only 1 possible value

- UI: Fix regression when creating ticket in
“resolved” with lnk objects

- UI: Fix search equals 0 for integer

- UI: Fix truncated caselog entry with largeHTMLtable or
word

- Portal: Fix column sorting on date attributes (eg.
french format)

- Portal: Fix crash in object form having empty
AttributeBlob field

- Portal: Fix crash when having comments in some
parts of the XML

- Portal: Fix error on form submit “Attempting to set
the value on the read-only attribute”

- Portal: Fix hyperlink placeholder not working in
notifications for other portals

- Portal: Fix list tabs and on charts click when a
Manage brick has a chart as default display mode

- Portal: Fix missing scrollbar in tall form
modals

- Portal: Fix wrong “apply stimulus” form being used
in a branch of classes

- Portal: Correctly display external fields targeting
an enum field

- Setup: Fix MySQL8 incompatibilities in setup and
backup

- Setup: Fix setup crash when class has an empty
zlist tag

- Setup: fix typo in warning due to non-matching
products.

- Setup: Fix graphiz detection feedback message on
Windows systems

- Setup: Fix extremely slow page load for first user
after setup

- Setup: Fix MySQL TLS wikiURL

- ORM: Fix “invalid numeric value” when
inserting/updating AttributeDecimal

- REST/JSON fix must_exists flag for remote object of
indirect linkedset

- Fix support of expressions (friendlyname) in
different language contexts

- Fix apc-emulation

- Fix datepicker locale not set correctly for ZH CN
and PT BR (@annProg)

- Fix cron crash when MySQL connection lost (Thomas
Casteleyn)

- Fix images being too large in icon selector
(dashboards and Designer)

- Fix ticket ref uniqueness rule declaration
(@jbostoen)

- Fix count with Archive mode

- Fix compiler crashing on setup due to comment in
XML

- Support Microsoft Outlook encoding of non breaking
line in UTF-8

- Fix DBSearch::Intersect (de-duplicate
aliases)

- Fix error when no cache is configured

- Add more logs

- Fix run_query error handling incompatible with PHP
< 7.3.0

- Fix some more PHP 7.4 incompatibilities

- Fix AdminTools DataSynchro creation

- Fix apply stimulus returning true when stimuli is
not applicable

- Fix ticket ref sometimes being a duplicate

#### Misc

- Filterable logs using log_level_min optionally per
channels

- Improve unit tests

- Security hardening

- Change AttributeImage methods visibility to allow
overrides

- Setup wizard backup path : larger input
widget

- Many small UI improvements

- autoload rework for application and core
directories

- Export a DBSearch as an array/JSON structure

- Abstract implementation for iScheduledProcess

- Add Alexandre, Anne-Catherine, Olivier,
Marie-Annette and Dimitri to the sample data to welcome them!
👋

#### Deprecations

- Remove Config deprecatedGetDB…()methods

- Deprecated stopwatch extensivity

- Deprecated DBObject::DB*Tracked methods
(DBInsertTracked, DBInsertTrackedNoReload, DBUpdateTracked,
DBDeleteTracked)

- Removed \DBObject::RegisterCallback

- Removed DB Config getters and charset/collation
config params

- Removed DBBackup::CreateZip

- ORM: Deprecate \MetaModel::EnumLinksClasses and
\MetaModel::EnumLinkingClasses

- ORM: Deprecate all Config::GetDB* methods, that
need to be replaced by Config::Get() calls

- ORM: MetaModel::GetNextKey($sClass) is now
deprecated in favor of ItopCounter::IncClass($sClass)

- FontAwesome: FontAwesome v4 is deprecated, use
FontAwesome v5CSSclasses instead

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:release:change_log>

版本：3_2_0/release/change_log.txt · Last modified: 2026/06/04 11:27 by 127.0.0.1
