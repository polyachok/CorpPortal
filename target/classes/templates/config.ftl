<#import "parts/common.ftl" as c>

<@c.page>

    <section class="content">
        <div class="container-fluid" style="padding-top: 15px;">
            <div class="row">
                <div class="col-md-12">
                    <form action="/config" method="post">
                    <div class="card card-warning card-outline">
                        <div class="card-body">
                            <div class="row">

                                <div class="col-md-4">
                                    <ul>
                                    <#list config as conf>
                                    <li>
                                        ${conf.getConfigname()} | ${conf.paramname} | ${conf.getParam()}
                                    </li>
                                    </#list>
                                    </ul>
                                    </div>

                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </div>
                            <div class="row">
                                <h5>Добавить новый параметр</h5>
                            </div>
                            <div class="row">
                                            <div class="col-md-4">
                                                <div class="input-group mb-2">
                                                    <input type="text" name="configname" class="form-control"
                                                           value="" placeholder="Название настройки">
                                                    <div class="input-group-append">
                                                        <div class="input-group-text">
                                                            <span class="fas fa-user"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="input-group mb-2">
                                                    <input type="text" name="paramname" class="form-control"
                                                           value="" placeholder="Название параметра">
                                                    <div class="input-group-append">
                                                        <div class="input-group-text">
                                                            <span class="fas fa-user"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="input-group mb-2">
                                                    <input type="text" name="param" class="form-control"
                                                           value="" placeholder="Параметр">
                                                    <div class="input-group-append">
                                                        <div class="input-group-text">
                                                            <span class="fas fa-user"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">Сохранить</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <form action="/config/route" method="post">
                        <div class="card card-warning card-outline">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <ul>
                                            <#list route as one>
                                                <li>
                                                    ${one.name}
                                                </li>
                                            </#list>
                                        </ul>
                                    </div>

                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </div>
                                <div class="row">
                                    <h5>Маршруты согласования</h5>
                                </div>
                                <div class="row">
                                    <label>Название маршрута</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                                </div>
                                <div class="row">
                                    <label>Этап 1</label>
                                    <select name="stage1" class="select2bs4"  style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if userList ??>
                                            <#list userList as usr>
                                                <#if usr.surname != "user">
                                                    <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="row">
                                    <label>Этап 2</label>
                                    <select name="stage2" class="select2bs4"  style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if userList ??>
                                            <#list userList as usr>
                                                <#if usr.surname != "user">
                                                    <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="row">
                                    <label>Этап 3</label>
                                    <select name="stage3" class="select2bs4"  style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if userList ??>
                                            <#list userList as usr>
                                                <#if usr.surname != "user">
                                                    <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-primary">Сохранить</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


    </section>
</@c.page>


<script>
    $(function () {
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        });
    });
</script>