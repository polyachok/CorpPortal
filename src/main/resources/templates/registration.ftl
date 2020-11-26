<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>


Add new User
    ${message?if_exists}
    <@l.login "/registration" true/>
</@c.page>