<#macro login path isRegisterForm>
    <form  action="${path}" method="post">
        <div class="form-group row">
            <label for="exampleFormControlInput1" class="col-sm-2 col-form-label"> User Name:</label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.username}</#if>" id="exampleFormControlInput1"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputPassword" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       id="inputPassword" placeholder="Password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
        <div class="form-group row">
            <label for="inputEmail" class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.email}</#if>" id="inputEmail" placeholder="Email"/>
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </div>
        </#if>
        <#if !isRegisterForm><a href="/registration">Registration</a></#if>
         <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">Sign In</button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
            <button class="btn btn-defaul" type="submit">
                <span style="font-size: 20px; color: white;">
                 <i class="fas fa-sign-out-alt"></i>
                </span>
            </button>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</#macro>