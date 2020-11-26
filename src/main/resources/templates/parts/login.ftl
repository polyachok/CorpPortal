<#macro login path isRegisterForm>
    <form  action="${path}" method="post">
        <div class="form-group row">
            <label for="exampleFormControlInput1" class="col-sm-2 col-form-label"> User Name :</label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" id="exampleFormControlInput1" placeholder="User name"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputPassword" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password"/>
            </div>
        </div>
        <#if isRegisterForm>
        <div class="form-group row">
            <label for="inputEmail" class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Email"/>
            </div>
        </div>
        </#if>>
        <#if !isRegisterForm><a href="/registration">Registration</a></#if>
         <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">Sign In</button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Log Out</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</#macro>