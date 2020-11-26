<#import "parts/common.ftl" as c>

<@c.page>
    <div>
        <h3>Config page</h3>
    </div>
    <a href="/main">Main</a>
    <div>
        <#list config as conf>
            <ul>
                <li>${conf.getConfigName()} | ${conf.paramName} - ${conf.getParam()}</li>
            </ul>
        </#list>
    </div>

    <form action="/config" method="post">
        <div>
            <label> name <input type="text" name="configName"/> </label>
            <label> name <input type="text" name="paramName"/> </label>
            <label> param <input type="text" name="param"/> </label>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit">Save</button>
    </form>

</@c.page>