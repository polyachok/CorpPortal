<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    List Users
<table>
<#list users as user>
    <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>${user.username}</td>
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td><a href="/user/${user.id}">Edit</a> </td>
        </tr>
    </tbody>
</#list>
</table>
</@c.page>