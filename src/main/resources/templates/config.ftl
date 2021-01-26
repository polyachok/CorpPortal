<#import "parts/common.ftl" as c>

<@c.page>
    <div>
        <h3>Config page</h3>
    </div>
    <a href="/main">Main</a>
    <div>
        <#list config as conf>
            <ul>
                <li>${conf.getConfigname()} | ${conf.paramname} - ${conf.getParam()}</li>
            </ul>
        </#list>
    </div>

    <form action="/config" method="post">
        <div>
            <label> name <input type="text" name="configname"/> </label>
            <label> name <input type="text" name="paramname"/> </label>
            <label> param <input type="text" name="param"/> </label>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit">Save</button>
    </form>

</@c.page>