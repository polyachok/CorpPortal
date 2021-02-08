<#import "parts/common1.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>

<section class="content" style="padding-top: 10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Новая задача</h3>
                        </div>
                        <div class="card-body">
                            <form action="/task" method="post">
                                <div class="form-group">
                                    <label for="exampleInputName">Название задачи</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote" name="description"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Надпроект</label>
                                    <select name="parentP" class="select2bs4" style="width: 100%;">
                                                <option value="0">-</option>
                                     <#if projectList ??>
                                         <#list projectList as project>
                                             <option value="${project.id}">${project.name}</option>
                                         </#list>
                                     </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Надзадача</label>
                                    <select name="parentT" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if taskList ??>
                                            <#list taskList as task>
                                                <option value="${task.id}">${task.name} - ${task.author.firstName} ${task.author.surname}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Ответственный</label>
                                    <select name="responsible" class="select2bs4" style="width: 100%;">
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
                                <div class="form-group">
                                    <label>Команда</label>
                                    <select name="team" class="select2bs4" multiple="multiple" style="width: 100%;">
                                        <#if userList ??>
                                        <#list userList as usr>
                                            <#if usr.surname != "user">
                                                <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                            </#if>
                                        </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Дата начала</label>
                                    <input type="text" name="datecreate" class="form-control datetimepicker-input" id="datetimepicker5" data-toggle="datetimepicker" data-target="#datetimepicker5"/>
                                </div>
                                <div class="form-group">
                                    <label>Дедлайн</label>
                                    <input type="text" name="deadline" class="form-control datetimepicker-input" id="datetimepicker6" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                                </div>

                                <div class="form-group">
                                    <label>Статус</label>
                                    <select name="status" class="form-control">
                                                <option >Активный</option>
                                                <option >Архивный</option>
                                    </select>
                                </div>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </div>
                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Сохранить</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</@c.page>
<script type="text/javascript" src="../static/js/summernote.min.js"></script>
<script type="text/javascript" src="../static/js/select2.full.min.js"></script>
<script type="text/javascript" src="../static/js/moment.min.js"></script>
<script type="text/javascript" src="../static/js/daterangepicker.js"></script>
<script type="text/javascript" src="../static/js/tempusdominus-bootstrap-4.min.js"></script>

<script>

    $(document).ready(function() {
        $('#summernote').summernote();
    });

    $(function () {
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        });


    })
    $(function () {
        $('#datetimepicker5').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
        $('#datetimepicker6').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
    });
</script>
