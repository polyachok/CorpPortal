<#import "parts/common.ftl" as c>
<@c.page>
    ${message?if_exists}

    <form method="post">
        <div class="form-group row">
            <label for="inputPassword" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputEmail" class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" id="inputEmail" value="${email!""}"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</@c.page>