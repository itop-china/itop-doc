
---
title: "iTop 3.0 新特性"
linkTitle: "iTop 3.0 新特性"
date: 2022-09-13
description: >
  
---


iTop 3.0 Community
==================

*   Beta version 3.0.0 release date: _April 2021_
    
*   3.0.0 release date: _January 2022_
    
*   3.0.1 release date: _April 2022_
    
*   3.0.2 release date: _September 2022_
    

*   [Download link](https://sourceforge.net/projects/itop/files/itop/3.0.0/ "https://sourceforge.net/projects/itop/files/itop/3.0.0/")
    
*   Read before upgrading: [Migration notes](https://www.itophub.io/wiki/page?id=3_0_0:install:270_to_300_migration_notes "3_0_0:install:270_to_300_migration_notes")
    
*   List of changes across iTop history: [Cumulative Change Log](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log "3_0_0:release:change_log")
    
*   List of [Known Issues in 3.0.0](https://www.itophub.io/wiki/page?id=3_0_0:release:beta-known-issues "3_0_0:release:beta-known-issues") version
    
*   Check [Extensions 3.0 compatible version](https://www.itophub.io/wiki/page?id=3_0_0:release:extensions "3_0_0:release:extensions")
    

What's new in iTop Community
============================

<table class="inline"><tbody><tr class="row0"><td class="col0 centeralign">This version focused on improving the <strong>Look</strong> and the <strong>Usability</strong> of iTop</td></tr></tbody></table>

[![Welcome page](https://www.itophub.io/wiki/media?w=600&tok=0bcd25&media=3_0_0:user:fullmoon-welcome.png "Welcome page")](https://www.itophub.io/wiki/media?media=3_0_0:user:fullmoon-welcome.png "3_0_0:user:fullmoon-welcome.png")

* * *

Homepage
--------

[![Homepage](https://www.itophub.io/wiki/media?w=600&tok=1e551a&media=3_0_0:user:welcome.png "Homepage")](https://www.itophub.io/wiki/media?media=3_0_0:user:welcome.png "3_0_0:user:welcome.png")

Main thing that you cannot miss: **the layout, the colors, the icons, the menus,…** all this has totally changed, to make it more readable, leave more space to the important information, highlight the things that matter to you, so you can be more efficient.

Main changes on the possible actions:

*   One click access to the [Welcome dashboard](about:blank#menus "3_0_0:release:3_0_whats_new ↵") from anywhere in iTop
    
*   A new [Quick Creation](about:blank#quick_create "3_0_0:release:3_0_whats_new ↵") action has been added, to avoid searching for the corresponding class creation menu.
    
*   The [Quick search](about:blank#quick_search "3_0_0:release:3_0_whats_new ↵") has moved from right to left, on the upper part of the screen.
    
*   The [Menus](about:blank#menus "3_0_0:release:3_0_whats_new ↵") can de reduced to their icons, thus freeing space for real data.
    
*   The [User menu](https://www.itophub.io/wiki/page?id=3_0_0:user:main#user_menu "3_0_0:user:main") has moved at the opposite corner of the screen!
    

* * *

Quick Search
------------

![Quick search icon](https://www.itophub.io/wiki/media?w=350&tok=940c75&media=3_0_0:user:quick-search-tooltip.png "Quick search icon") [![Quick search result](https://www.itophub.io/wiki/media?w=500&tok=74500f&media=3_0_0:user:quick-search-result.png "Quick search result")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-search-result.png "3_0_0:user:quick-search-result.png")

The Quick search is now on the left.

*   The main new feature is that **it remembers your past searches**
    
*   As before, when you reopen the Quick search, your last search is still there, so if you made a typo, you can fix it without reentering the whole string.
    

This feature can now be configured through new configuration parameters [global\_search.xxx](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#f-l "3_0_0:admin:itop_configuration_file"), which allow to:

*   disable completely the feature
    
*   remove the tracking and display of the past searches
    
*   fine-tuned the number of past searches which are kept (default 10)
    

* * *

Quick Create
------------

[![Quick create button](https://www.itophub.io/wiki/media?w=300&tok=7baa36&media=3_0_0:user:quick-creation-tooltip.png "Quick create button")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-creation-tooltip.png "3_0_0:user:quick-creation-tooltip.png") [![Quick creation dropdown](https://www.itophub.io/wiki/media?w=300&tok=7b3ee3&media=3_0_0:user:quick-creation-dropdown.png "Quick creation dropdown")](https://www.itophub.io/wiki/media?media=3_0_0:user:quick-creation-dropdown.png "3_0_0:user:quick-creation-dropdown.png")

Brand new feature:

It allows you to quickly create any object without knowing where is the menu to do it, if even there is one.  
Just type the beginning of the class you want, and you are proposed with the matching classes.

*   If there is just one matching class, just press enter and the creation form for that class is displayed.
    
*   You can use the arrow-keys from your keyboard to navigate in the proposed list
    

This feature can be configured through configuration parameters [quick\_create. .xxx](https://www.itophub.io/wiki/page?id=latest:admin:itop_configuration_file#o-r "latest:admin:itop_configuration_file"), which allow to:

*   disable completely the feature
    
*   remove the tracking and display of the past creations
    
*   fine-tuned the number of past creations which are kept (default 10)
    
*   fine-tuned the number of results displayed by the autocomplete feature (default 10)
    

* * *

Object display
--------------

The version 3.0 has improved how an [object is displayed](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification "3_0_0:user:display_and_modification"):

[![](https://www.itophub.io/wiki/media?w=500&tok=5fd63e&media=3_0_0:customization:class-icon-instance.png)](https://www.itophub.io/wiki/media?media=3_0_0:customization:class-icon-instance.png "3_0_0:customization:class-icon-instance.png") [![UserRequest transitions](https://www.itophub.io/wiki/media?w=500&tok=383a31&media=3_0_0:release:object-details-banner-scrolled.png "UserRequest transitions")](https://www.itophub.io/wiki/media?media=3_0_0:release:object-details-banner-scrolled.png "3_0_0:release:object-details-banner-scrolled.png")

### Header & actions

The header part has been totally reworked:

*   Highlighting important information, such as the object status
    
*   Using a specific color for each class of object, to make it clearer where you are at any time.
    
*   Locking the top bar, so actions remain accessible even when you scroll down an object which does not fit all in the browser window
    
*   Replacing textual menus by meaningful icons, to free space for important data
    
*   Separating the transitions actions from the rest, so they are easier to retrieve
    
*   Displaying an object icon with can be specific to the displayed instance, for better identification
    

* * *

### Navigation

[![Horizontal & Scrollable in read mode](https://www.itophub.io/wiki/media?w=400&tok=f9468a&media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "Horizontal & Scrollable in read mode")](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-scrollable-not-loaded-tab.png "3_0_0:user:tabs-scrollable-not-loaded-tab.png") [![Vertical tabs](https://www.itophub.io/wiki/media?w=450&tok=c650f0&media=3_0_0:user:tabs-vertical-classic-read.png "Vertical tabs")](https://www.itophub.io/wiki/media?media=3_0_0:user:tabs-vertical-classic-read.png "3_0_0:user:tabs-vertical-classic-read.png")

New modes to display the contents of an object, defining how you can switch from one tab to another:

_Classic_: this mode behave as before:

*   only one tab at a time is displayed.
    
*   You click on a tab title to switch to that other tab.
    

_Scrollable_: this mode is new:

*   all tabs are displayed in the same page
    
*   you can scroll through them with your mouse or click on the tab title
    
*   asynchronous tabs such as dashboard are not loaded, until you click to get them displayed.
    

* * *

Activity Panel
--------------

### Caselog edition alone

[![Icon to switch to log edition](https://www.itophub.io/wiki/media?w=400&tok=d66212&media=3_0_0:user:activity-panel-entry-form-icon.png "Icon to switch to log edition")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-entry-form-icon.png "3_0_0:user:activity-panel-entry-form-icon.png") [![Editing a log](https://www.itophub.io/wiki/media?w=350&tok=0f5c79&media=3_0_0:user:activity-panel-save-transition.png "Editing a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-save-transition.png "3_0_0:user:activity-panel-save-transition.png")

A new panel has been added, to speed-up a pretty common situation in which the agent just need to provide a reply within a log entry and maybe apply a transition.

*   For this, instead of modifying the Ticket, he can directly enter his reply and send it, while applying in a single click a transition if required.
    
*   This new option exists within the console only, for all objects having a caselog.
    
*   The caselogs ordering can now be controlled through the XML object presentation
    

_More details in the [User's Manual](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification#activity_panel "3_0_0:user:display_and_modification")_

* * *

### History filtering

[![Activity history](https://www.itophub.io/wiki/media?w=300&tok=3dcd4f&media=3_0_0:user:activity-panel-history-format.png "Activity history")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-history-format.png "3_0_0:user:activity-panel-history-format.png") [![Log history](https://www.itophub.io/wiki/media?w=300&tok=8392c1&media=3_0_0:user:activity-panel-caselogs.png "Log history")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-caselogs.png "3_0_0:user:activity-panel-caselogs.png") [![Filter History](https://www.itophub.io/wiki/media?w=300&tok=20e144&media=3_0_0:user:activity-panel-mixed.png "Filter History")](https://www.itophub.io/wiki/media?media=3_0_0:user:activity-panel-mixed.png "3_0_0:user:activity-panel-mixed.png")

In this part of the screen, that we have named the “activity panel”, you retrieve the logs and the history, all merged in a single timeline, which makes it more efficient to understand the full history.

*   You can filter this panel, to view any of those type of entries
    
    *   **log** entries, which you can filter more, to view only the public or the private log
        
    *   **state changes** whenever the object has changed state
        
    *   **edit** when the object was created or modified (includes notification sent as well)
        
*   Next to the entry, the user picture, if they have one, is displayed, otherwise it is their initials.
    

The history timestamps are **relative when recent** and **absolute above** a specified delay.

History display can be configured with new [Activity Panel parameters](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#a "3_0_0:admin:itop_configuration_file").

* * *

### Mention user

[![Mention someone in a log](https://www.itophub.io/wiki/media?w=350&tok=37d12e&media=3_0_0:user:mention-user-in-caselog.png "Mention someone in a log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog.png "3_0_0:user:mention-user-in-caselog.png") [![Result of a mention in log](https://www.itophub.io/wiki/media?w=350&tok=783385&media=3_0_0:user:mention-user-in-caselog-result.png "Result of a mention in log")](https://www.itophub.io/wiki/media?media=3_0_0:user:mention-user-in-caselog-result.png "3_0_0:user:mention-user-in-caselog-result.png")

In the console an agent may want to quickly notify someone within a caselog to get their attention.

*   That person may not be linked to the Ticket, but still we want to notify them.
    
*   Just type **@** and the beginning of the person name, you will be prompt with available persons.
    
*   Then at submission of the caselog entry containing a `mention`, the person will receive an email notification.
    
*   Multiple persons can be mentioned in the same caselog.
    

*   The proposed persons to be mentioned on a Ticket are by default those belonging to
    
    *   the customer organization of the Ticket
        
    *   or to same organization as the current user.
        
*   That logic can be changed by modifying the [Notification](https://www.itophub.io/wiki/page?id=3_0_0:admin:notifications#on_mention "3_0_0:admin:notifications")
    

* * *

List
----

Do you remember how painful it was to loose the column titles when scrolling within a list? This is over, now they remains visible while you scroll down.  
At the same time the search criterion used to filter the list remains on the screen.  
Note also the colored circles associated with status value.  
[User Manual for managing list](https://www.itophub.io/wiki/page?id=3_0_0:user:lists "3_0_0:user:lists").

[![](https://www.itophub.io/wiki/media?w=500&tok=47260b&media=3_0_0:user:search-list-with-header.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-list-with-header.png "3_0_0:user:search-list-with-header.png")[![](https://www.itophub.io/wiki/media?w=500&tok=7cd4fa&media=3_0_0:user:search-list-header-locked.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:search-list-header-locked.png "3_0_0:user:search-list-header-locked.png")

* * *

Dashboard
---------

Dashboard look has been improved, with new icons and graphical chart

*   Dashlet header statistics based on status is using the colors associated with each value, to make it easier to read
    
*   Dashlet badge has been simplified to highlight better the count and class name and remove useless duplicated text in the links
    

[![Dashlet Hearder Statistic](https://www.itophub.io/wiki/media?w=500&tok=ef6e1a&media=3_0_0:release:dashlet-header-stat2.png "Dashlet Hearder Statistic")](https://www.itophub.io/wiki/media?media=3_0_0:release:dashlet-header-stat2.png "3_0_0:release:dashlet-header-stat2.png")[![Dashlet Badge](https://www.itophub.io/wiki/media?w=500&tok=7f67bf&media=3_0_0:release:dashlet-badge2.png "Dashlet Badge")](https://www.itophub.io/wiki/media?media=3_0_0:release:dashlet-badge2.png "3_0_0:release:dashlet-badge2.png")

*   Dashboard specific menus have been harmonized, so it's easier to understand that when looking at the standard version of a dashboard, the edition mode will apply to the custom version as soon as you have one.
    
*   Check for details [here](https://www.itophub.io/wiki/page?id=3_0_0:user:dashboards "3_0_0:user:dashboards")
    

* * *

Bubble caselogs
---------------

The display of caselogs in the User Portal is more trendy:

[![Buble caselog in Portal](https://www.itophub.io/wiki/media?w=600&tok=56b906&media=3_0_0:user:portal-bubble-caselog.png "Buble caselog in Portal")](https://www.itophub.io/wiki/media?media=3_0_0:user:portal-bubble-caselog.png "3_0_0:user:portal-bubble-caselog.png") —-

Menus
-----

[![Search in Menus](https://www.itophub.io/wiki/media?w=200&tok=ead4c4&media=3_0_0:user:menubar-searchmenu.png "Search in Menus")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-searchmenu.png "3_0_0:user:menubar-searchmenu.png")

The [menus](https://www.itophub.io/wiki/page?id=3_0_0:user:main#the_menu_bar "3_0_0:user:main") have been enriched with icons and can be shrunk to display just the icons, thus gaining space for the valuable information

### Welcome

A quick way to go back to iTop homepage!

*   This top left icon ![Back to Homepage](https://www.itophub.io/wiki/media?w=40&tok=11b32f&media=3_0_0:user:welcome-icon.png "Back to Homepage") was never going where you wanted, I bet,
    
*   Now it will bring you back to iTop homepage, by default it is the Welcome dashboard!
    
*   This icon can be customized in XML as part of the `branding`
    

[![Count in query menus](https://www.itophub.io/wiki/media?w=250&tok=c0dad9&media=3_0_0:user:menubar-second-level.png "Count in query menus")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-second-level.png "3_0_0:user:menubar-second-level.png")

### Objects count

Number of objects in predefined queries

*   Exact number of objects is displayed in the menu itself,
    
*   `99+` indicates that they are more than 99.
    

### Search in menus

*   Shortcut `Alt+M` on Chrome to search in menus without the mouse
    
*   Then enter some characters to filter the menus containing that string
    
*   A **white-space** character, displays **all** menus
    

### Expand & Collapse

[![Collapsed menus and filtered organization](https://www.itophub.io/wiki/media?w=300&tok=922a53&media=3_0_0:user:menubar-filtered-on-organization.png "Collapsed menus and filtered organization")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-filtered-on-organization.png "3_0_0:user:menubar-filtered-on-organization.png")

*   Use the hamburger icon [![Expending menu icon](https://www.itophub.io/wiki/media?w=30&tok=cbb519&media=3_0_0:user:menubar-expand-icon.png "Expending menu icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-expand-icon.png "3_0_0:user:menubar-expand-icon.png") to expand and collapse the first level of menus.
    
*   When the menubar is expended, it displays a text along with the group icons.
    
*   To collapse the menubar, press the [![> sign](https://www.itophub.io/wiki/media?w=30&tok=fd7c80&media=3_0_0:user:menubar-expanded-icon.png "> sign")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-expanded-icon.png "3_0_0:user:menubar-expanded-icon.png") icon.
    
*   When the menubar is collapsed, a red circle is displayed [![Filtered menu collapse icon](https://www.itophub.io/wiki/media?w=30&tok=c4af09&media=3_0_0:user:menubar-filtered-on-organization-icon.png "Filtered menu collapse icon")](https://www.itophub.io/wiki/media?media=3_0_0:user:menubar-filtered-on-organization-icon.png "3_0_0:user:menubar-filtered-on-organization-icon.png") if you have filtered on an organization.
    

* * *

Relations
---------

[![](https://www.itophub.io/wiki/media?w=600&tok=42fb18&media=3_0_0:user:relation-display.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-display.png "3_0_0:user:relation-display.png") [![](https://www.itophub.io/wiki/media?w=600&tok=2393dd&media=3_0_0:user:relation-edition.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:relation-edition.png "3_0_0:user:relation-edition.png")

[Display of relationships](https://www.itophub.io/wiki/page?id=3_0_0:user:display_and_modification#managing_objects_relations "3_0_0:user:display_and_modification") in read and edit mode are now identical in terms of displayed fields.  
It's much faster now to replace a team member by another one, just by editing their name. This new logic is available on all many to many relationships.

* * *

User Preference
---------------

[![](https://www.itophub.io/wiki/media?w=500&tok=a76041&media=3_0_0:user:user-preferences.png)](https://www.itophub.io/wiki/media?media=3_0_0:user:user-preferences.png "3_0_0:user:user-preferences.png")

The version 3.0 brings new user preferences to control the behavior of iTop, so you can choose the modes that suits best your habits.  

You can control when an iTop object is displayed:

*   the tabs titles **layout**, which can be displayed on top (_as before_) or on the left side.
    
*   the **navigation**: only the content of a single tab is displayed (_as before_) or all tabs are displayed at once, one under the others, allowing to navigate with a simple mouse scroll
    
*   New option to have the toolbar open each time you edit an HTML field
    
*   New option so you directly have the possibility to enter something in the caselog of a Ticket and sent it without modifying the Ticket it-self.
    

If you like to navigate quickly just with the keyboard, we have added shortcut for frequent actions.

Check here for [how to manage your User Preferences](https://www.itophub.io/wiki/page?id=3_0_0:user:main#managing_your_preferences "3_0_0:user:main").

### Fullmoon or Darkmoon

Choose your theme, Full or Dark, aligned with your mood.

[![Darkmoon preference](https://www.itophub.io/wiki/media?w=400&tok=703bd5&media=3_0_0:release:darkmoon-preference.png "Darkmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-preference.png "3_0_0:release:darkmoon-preference.png")[![Fullmoon preference](https://www.itophub.io/wiki/media?w=400&tok=6f8336&media=3_0_0:release:fullmoon-preference.png "Fullmoon preference")](https://www.itophub.io/wiki/media?media=3_0_0:release:fullmoon-preference.png "3_0_0:release:fullmoon-preference.png")

[![Darkmoon Homepage](https://www.itophub.io/wiki/media?w=800&tok=b91a02&media=3_0_0:release:darkmoon-homepage.png "Darkmoon Homepage")](https://www.itophub.io/wiki/media?media=3_0_0:release:darkmoon-homepage.png "3_0_0:release:darkmoon-homepage.png")

* * *

Predefined OQL queries
----------------------

#### On Setup

*   On Setup (new installation or version upgrade), a set of OQL queries usable in Notifications are automatically loaded.
    
*   Queries label and description are in iTop default language, when translation exist (`EN US`, `FR FR` and `DE DE`)
    
*   For each query to load, iTop searchs for OQLQuery flagged as `Template for OQL fields` and having the exact same `Expression` (_OQL_).
    
    *   If one and one only exists already, then no new query is loaded and the existing one is **not updated**.
        
    *   If none are found, a new OQLQuery is created
        
    *   If more than one is found, then a new one is created (_known iTop limitation_)
        

[![Notification icon to search for predefined queries](https://www.itophub.io/wiki/media?w=400&tok=e32a99&media=3_0_0:user:predefined-query-search.png "Notification icon to search for predefined queries")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search.png "3_0_0:user:predefined-query-search.png") [![Search a predefined OQL](https://www.itophub.io/wiki/media?w=400&tok=b125b7&media=3_0_0:user:predefined-query-search-popup.png "Search a predefined OQL")](https://www.itophub.io/wiki/media?media=3_0_0:user:predefined-query-search-popup.png "3_0_0:user:predefined-query-search-popup.png")

#### Usage in Notification

*   OQL Queries flagged as `Template for OQL fields`, are proposed when editing any iTop field of type `OQL`, as a new action to retrieve existing queries and easily copy the OQL from the selected OQL Query.
    

*   You can create your own template queries,
    
*   You can modify the label and description of the template OQL queries automatically loaded.
    
*   A modification of the OQL in a template OQL Query has no effect on Notifications which in the past, have used that OQL Query as source. Those notifications keep the old version of the query.
    

* * *

User management
---------------

#### Multi LDAP

iTop now supports natively the possibility to connect to [multiple LDAP](https://www.itophub.io/wiki/page?id=extensions:authent-ldap "extensions:authent-ldap") servers

#### Admin suicide

[![](https://www.itophub.io/wiki/media?w=400&tok=5644c4&media=3_0_0:release:disabling-user-account.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:disabling-user-account.png "3_0_0:release:disabling-user-account.png")

The following modifications was made in order to **prevent admins** or users **to commit suicide**.

*   A user cannot disable his own account
    

[![](https://www.itophub.io/wiki/media?w=600&tok=df8ab3&media=3_0_0:release:removing-admin-profile.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:removing-admin-profile.png "3_0_0:release:removing-admin-profile.png")

*   A user cannot remove his last profile allowing him to edit users accounts.
    
*   If a user has at least one allowed organization, then its contact must have his organization in the list of the user's allowed orgs.
    

[![Deletion of admin user](https://www.itophub.io/wiki/media?w=500&tok=e03a1b&media=3_0_0:release:deletion-of-admin.png "Deletion of admin user")](https://www.itophub.io/wiki/media?media=3_0_0:release:deletion-of-admin.png "3_0_0:release:deletion-of-admin.png")

*   A user cannot delete his own account.
    
*   A user cannot remove the contact linked to his own user account.
    
*   A user allowed to acces the backoffice cannot add to his own user account a “Portal profile” or any other profile which would prevent him to access the backoffice anymore.
    

_If any of the above actions must be done, then another user must do it_.

If you have implemented [user delegation](https://www.itophub.io/wiki/page?id=3_0_0:customization:delegate_rights "3_0_0:customization:delegate_rights"), then a new configuration parameter allow to improve those users experience by preventing them from editing Administrators and getting after that, an error message, by simply hiding to them those Administrator users. See [security.hide\_administrators](https://www.itophub.io/wiki/page?id=3_0_0:admin:itop_configuration_file#s-t "3_0_0:admin:itop_configuration_file") configuration parameters.

* * *

Integration
-----------

### Webhooks

Allow on any existing triggers to

*   send chat notifications to Google Chat, Rocket.chat & Slack, with the same placeholders as email notification.
    
*   replicate / mirror part of an object on another itop, through a simple configuration in json in an action and update local triggering object with remote information
    
*   call any third party application offering webservices
    

More details about this feature included in 3.0.0 Products and as extension on iTop 2.7.x

* * *

System
------

#### Setup

*   As Views were generating more issues than it was bringing value (_table name of view exceeding MySQL limit for eg._), they were removed since version 3.0.0
    
*   All the views corresponding to a defined bizmodel class named with the following convention `view__ClassName_` are now systematically removed during Setup.
    

#### REST/JSON

In CLI mode the JSON data structure can now be put in a separate file and in the command line, you just provide the path of the file, like this **json-data@<path>**.

#### Monitoring

*   [Monitoring](https://www.itophub.io/wiki/page?id=3_0_0:admin:monitoring:healthcheck "3_0_0:admin:monitoring:healthcheck"): allow to monitor itop status without any authentication via http
    

* * *

New customizations
------------------

#### Icon on Group Menu

*   Define an [Icon on Menu](https://www.itophub.io/wiki/page?id=3_0_0:customization:menu-icon "3_0_0:customization:menu-icon"). Without an icon, the first letter of the label is used.
    

#### Set color and icon on class

With iTop 3.0 it's now possible with an iTop extension or through the ITSM Designer to

*   Define a [color on Class](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors "3_0_0:customization:class-colors"): this color is used for the top bar of a object detail, a list and some dashlets.
    
*   Define a [class icon](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#class_icon "3_0_0:customization:class-colors") for one of your custom class or changing the one of an existing class
    
*   For some class, like Person, the icon displayed on the object header can be specific per object. For this just define a [Instance icon](https://www.itophub.io/wiki/page?id=3_0_0:customization:class-colors#object_icon "3_0_0:customization:class-colors"), specifying the object AttributeImage field to use.
    

#### Set colors on enum values

*   With iTop 3.0 it's now possible to [define colors and fontawesome](https://www.itophub.io/wiki/page?id=3_0_0:customization:enum-colors "3_0_0:customization:enum-colors") icon for each value of any Enumeration field.
    

#### Create your own theme

*   With iTop 3.0 it's even easier to [define your own iTop theme](https://www.itophub.io/wiki/page?id=3_0_0:customization:theme "3_0_0:customization:theme"), on top of the existing one or in place.
    
*   Every user can select the theme he wants, among those installed.
    

#### Enrich object friendlyname

Sometimes a friendlyname is not enough to differentiate 2 objects, especially when you want to select it within a drop-down list. In order to cope with this, iTop 3.0 brings a new concept, to [differentiate homonyms](https://www.itophub.io/wiki/page?id=3_0_0:customization:longname "3_0_0:customization:longname").

* * *

For developpers
---------------

#### New methods on DBObject

*   We have added new methods on DBObjects, available on all classes
    
*   _mainly useful for XML developers and ITSM Designer users to modify attributes on transitions without coding_
    
*   **SetCurrentDateIfNull**, **AddValue**, **SetComputedDate**, **SetComputedDateIfNull**
    

Check that new page for details on [methods available](https://www.itophub.io/wiki/page?id=3_0_0:customization:actions-on-transitions "3_0_0:customization:actions-on-transitions"), usable as action on transitions.

#### Log calls to deprecated files / PHP methods

A new log file is added in 3.0.0 : `log/deprecated-calls.log`.

This will contains logs of calls to deprecated files or PHP methods, and will help developers to migrate their code. Actually parts of the iTop API marked with `[@deprecated](https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated "https://docs.phpdoc.org/3.0/guide/references/phpdoc/tags/deprecated.html#deprecated")` are usually removed in the next iTop major version : ie a method marked as `@deprecated` in iTop 3.0.0 will certainly be removed in iTop 3.1.0.

By default those logs are disabled, but you can enabled them using the `log_level_min` config parameter for the appropriate log channels. Also, the logger will have a different behavior if used on a GitHub clone.

See the [corresponding documentation](https://www.itophub.io/wiki/page?id=3_0_0:admin:log:channels#deprecated_calls "3_0_0:admin:log:channels") for reference.

#### Themes precompilation at wizard setup

This feature is an optimization of the setup to spare significant time with themes (about 30 seconds per theme).

for more details see [theme precompilation](https://www.itophub.io/wiki/page?id=3_0_0:advancedtopics:setup_theme_precompilation "3_0_0:advancedtopics:setup_theme_precompilation").

#### New developer\_mode.enabled config parameter

Some iTop behaviors intended for extensions and core developers are triggered by the \\utils::IsDevelopmentEnvironment method : Twig cache reset, setup symlinks, DeprecatedCallsLog, …

This method was returning true only for Github clones.

Now the new `developer_mode.enabled` config parameter allows to control the method returned value : if the parameter has a boolean value then it will be used as the method return value, otherwise the existing behavior will be kept.  
Default config parameter value is `null` so that nothing changes unless an explicit value is set.

#### Generate symlinks flag

This option is available only if all of the following conditions are met :

*   we are running on a dev environment (either when using directly a iTop GitHub repo clone, or when the `developer_mode.enabled` [configuration parameter](https://www.itophub.io/wiki/page?id=latest:admin:itop_configuration_file "latest:admin:itop_configuration_file") is set to true)
    
*   the `symlink` PHP function is available
    

If the setup is launched in such environment,a new option is displayed in the setup, in the “Miscellaneous Parameters” wizard step:

[![](https://www.itophub.io/wiki/media?w=600&tok=a94d5d&media=3_0_0:release:symlink.png)](https://www.itophub.io/wiki/media?media=3_0_0:release:symlink.png "3_0_0:release:symlink.png")

When the compilation is done with the option checked, a `/data/.compilation-symlinks` file is created.  
Also if this file is present the setup checkbox will be checked. It will be the same in the 3.0.0 toolkit for the corresponding option.

Note that this file will be used to generate symlinks when compilation is launched from any client that aren't providing the `useSymLinks` parameter to the compiler (`\MFCompiler::Compile`). Eg. ITSM Designer connector, Hub connector, custom script calling RuntimeEnvironment.

This is a gain for extension developers : if you are developing using the toolkit with the symlinks option, and if you need to launch the setup, you will get directly symlinks. Before it was mandatory to compile again using the toolkit to get back symlinks.

#### Compiler always generate new model.\*.php

Since commit [c5d265f6](https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26# "https://github.com/Combodo/iTop/commit/c5d265f66bb25b0184f82cad40115597cae01b26#") in iTop 3.0.0 the compiler now will always remove the previous file when it needs to write a `model.*.php` file. This implies the `model.*.php` files won't ever be generated as a symlink.

If the compilation was done with the symlink option, below is a short summary of this behavior change consequences:

| Has model.\*.php | Has datamodel.\*.xml | Consequence |
| --- | --- | --- |
| ✔ | ❌ | ➖ Modification done in the original model file will need a new compilation to be pushed in iTop |
| ✔ | ✔ | ➖ Same as above  
➕ If your module is versionned (Git, Svn, …), you won't get the compiled code in model.\*.php |
| ❌ | ✔ | ➕ Same as above |

3\_0\_0/release/3\_0\_whats\_new.txt · Last modified: 2022/09/13 14:25 (external edit)