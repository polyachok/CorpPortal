<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>CorpPortal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../static/css/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../static/css/adminlte.min.css">
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <link href="../static/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../static/css/select2-bootstrap4.min.css" >
    <link rel="stylesheet" href="../../static/css/tempusdominus-bootstrap-4.min.css" >
</head>
<body  class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <#include "parts/top_navbar.ftl">
    <#include "parts/navbar.ftl">
    <div class="content-wrapper">
        <#if parent??>
        <section class="content-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12">
                        <ol class="breadcrumb float-sm-left">
                            <li class="breadcrumb-item"><a href=<#if parentT ??>"task/"<#else>"../project/"${parent.id}</#if> class="link-black text-lg"><i class="far fa-folder-open"></i> ${parent.name}</a></li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
        </#if>
        <section class="content">
            <div class="container-fluid" style="padding-top: 15px;">
            <!-- Default box -->
                <div class="row">
                    <div class="col-md-9">
                        <div class="card card-success card-outline">
                            <div class="card-body box-profile">
                                    <div class="post">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h4><strong>${task.name}</strong><#if user.id == task.author.id ><a class="btn" data-toggle="modal" data-target="#myModal" style="color: #666;"><i class="fas fa-edit"></i></a></#if></h4>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <h6>Статус задачи - ${task.status}</h6>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="float-right">
                                                    <#if task.type == 0>
                                                        <#if taskAction != 0>
                                                            <#switch taskAction>
                                                                <#case 1>
                                                                        <a class="btn btn-outline-success" href="/task/${task.id}?action=close">Завершить</a>
                                                                    <#break>
                                                                <#case 2>
                                                                        <a class="btn btn-outline-warning" href="/task/${task.id}?action=begin">Начать</a>
                                                                    <#break>
                                                                <#case 3>
                                                                        <a class="btn btn-outline-success" href="/task/${task.id}?action=accept">Принять</a>
                                                                        <a class="btn btn-outline-danger" href="/task/${task.id}?action=deny">Отказать</a>
                                                                    <#break>
                                                                <#case 5>
                                                                        <a class="btn btn-outline-success" href="/task/${task.id}?action=accept">Принять</a>
                                                                        <a class="btn btn-outline-danger" href="/task/${task.id}?action=deny">Отказать</a>
                                                                    <#break>
                                                                <#case 8>
                                                                        <a class="btn btn-outline-danger" href="/task/${task.id}?action=complete">Завершить</a>
                                                                    <#break>
                                                                <#default>
                                                            </#switch>
                                                        </#if>
                                                    </#if>
                                                    <#if task.type == 1>
                                                        <#if taskAction != 0>
                                                            <#switch taskAction>
                                                                <#case 9>
                                                                        <a class="btn btn-outline-success" href="" data-toggle="modal" data-target="#myModal2">Согласовать</a>
                                                                    <#break>
                                                                <#default>
                                                            </#switch>
                                                        </#if>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <div class="post">
                                <div class="row">
                                    <div class="col-12 col-sm-12">
                                        <h5>${(task.goal)!""}</h5>
                                    </div>
                                </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-12 col-sm-12">
                                                <p>${task.description}</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-12">
                                                <#if task.type == 0>
                                                <#if childTask ??>
                                                    <div id="accordion">
                                                        <div class="card card-success card-outline">
                                                            <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseOne">
                                                                <div class="card-header">
                                                                    <h4 class="card-title w-100">
                                                                        Вложенные задачи
                                                                    </h4>
                                                                </div>
                                                            </a>
                                                            <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                                                <div class="card-body">
                                                                    <table class="table table-sm text-nowrap table-borderless table-hover">
                                                                        <thead>
                                                                        <tr style="font: status-bar;">
                                                                            <th>Название</th>
                                                                            <th>Автор</th>
                                                                            <th>Срок исполнения</th>
                                                                        </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        <#list childTask as child>
                                                                            <tr <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if>>
                                                                                <td><a <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if> href="/task/${child.id}"><b>${child.name}</b></a></td>
                                                                                <td>${child.responsible.surname} ${child.responsible.firstName}</td>
                                                                                <td>${child.deadline}</td>
                                                                            </tr>
                                                                        </#list>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </#if>
                                                    <#if childAg ??>
                                                        <div id="accordion">
                                                            <div class="card card-success card-outline">
                                                                <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseOne">
                                                                    <div class="card-header">
                                                                        <h4 class="card-title w-100">
                                                                            Вложенные согласования
                                                                        </h4>
                                                                    </div>
                                                                </a>
                                                                <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                                                    <div class="card-body">
                                                                        <table class="table table-sm text-nowrap table-borderless table-hover">
                                                                            <thead>
                                                                            <tr style="font: status-bar;">
                                                                                <th>Название</th>
                                                                                <th>Автор</th>
                                                                                <th>Срок исполнения</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <#list childAg as child>
                                                                                <tr style="font-weight: bold;">
                                                                                    <td><a href="/agreement/${child.id}"><b>${child.name}</b></a></td>
                                                                                    <td>${child.author.surname} ${child.author.firstName}</td>
                                                                                    <td>${child.deadline}</td>
                                                                                </tr>
                                                                            </#list>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </#if>
                                                </#if>
                                                <#if parentCommentList ??>
                                                    <#list parentCommentList as t>
                                                        <#if t.id != task.id>
                                                            <div id="accordion">
                                                                <div class="card card-success card-outline">
                                                                    <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapse${t.id}">
                                                                        <div class="card-header">
                                                                            <h4 class="card-title w-100">
                                                                                ${t.name} &ensp;&mdash;&ensp; ${t.status} &ensp; ${t.responsible.surname} ${t.responsible.firstName} &ensp; ${(t.dateclose)!""}
                                                                            </h4>
                                                                        </div>
                                                                    </a>
                                                                    <div id="collapse${t.id}" class="collapse" data-parent="#accordion">
                                                                        <div class="card-body">
                                                                            <#list t.comment as comment>
                                                                            <div class="post" style="border-bottom: 1px solid #adb5bd;">
                                                                                <div class="user-block">
                                                                                    <img class="img-circle img-bordered-sm" src="../static/img/avatar.jpg" alt="user image">
                                                                                    <span class="username"><a href="#">${comment.author.surname} ${comment.author.firstName}</a></span>
                                                                                    <span class="description">${comment.datecreate}</span>
                                                                                </div>
                                                                                <!-- /.user-block -->
                                                                                <div class="click2edit">
                                                                                    ${comment.description}
                                                                                </div>
                                                                                <p>
                                                                                    <#if comment.file??>
                                                                                        <#list comment.file as file>
                                                                                            <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
                                                                                        </#list>
                                                                                    </#if>
                                                                                </p>
                                                                            </div>
                                                                            </#list>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </#if>
                                                    </#list>
                                                </#if>
                                                <hr />
                                                <h4>Комментарии к задаче</h4>
                                                <#if comments ??>
                                                <#list comments as comment>
                                                <div class="post" style="border-bottom: 1px solid #adb5bd;">
                                                    <div class="user-block">
                                                        <img class="img-circle img-bordered-sm" src="../static/img/avatar.jpg" alt="user image">
                                                        <span class="username">
                                                          <a href="#">${comment.author.surname} ${comment.author.firstName}</a>
                                                        </span>
                                                        <span class="description">${comment.datecreate}</span>
                                                    </div>
                                                    <!-- /.user-block -->
                                                    <div class="click2edit">
                                                        ${comment.description}
                                                    </div>
                                                    <p>
                                                        <#if comment.file??>
                                                            <#list comment.file as file>
                                                                <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
                                                            </#list>
                                                        </#if>
                                                    </p>
                                                </div>
                                                </#list>
                                                </#if>
                                            </div>
                                        </div>
                                        <div class="row" style="margin-top: 20px;">
                                            <div class="col-md-12">
                                                <h4>Написать комментарий</h4>
                                                <form enctype="multipart/form-data" action="/task/comment" method="post">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <textarea id="summernote" name="editordata"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12" id="result">

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <div class="custom-file" style="margin-top: 10px;">
                                                                <input type="file" name="file" multiple id="js-file" >
                                                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                                <input type="hidden" name="task_id" value="${task.id}" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <button type="submit" class="btn btn-success" style="margin-top: 10px;">Отправить</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card card-success card-outline">
                            <div class="card-body box-profile">
                                <dl class="row">
                                    <dt class="col-sm-6">Автор</dt>
                                    <dd class="col-sm-6">${task.author.surname} ${task.author.firstName}</dd>
                                    <dt class="col-sm-6">Ответственный</dt>
                                    <dd class="col-sm-6">${task.responsible.surname} ${task.responsible.firstName}</dd>
                                    <dt class="col-sm-6">Дата начала</dt>
                                    <dd class="col-sm-6">${task.datecreate}</dd>
                                    <dt class="col-sm-6">Срок исполнения</dt>
                                    <dd class="col-sm-6">${task.deadline}</dd>
                                </dl>
                            </div>
                        </div>
                        <#if type == "task">
                            <div class="card card-success card-outline">
                                <div class="card-body box-profile">
                                    <dl>
                                        <dt>Команда</dt>
                                        <#list task.team as team>
                                            <dd>${team.surname} ${team.firstName}</dd>
                                        </#list>
                                    </dl>
                                </div>
                            </div>
                        </#if>
                        <div class="card card-success card-outline">
                            <div class="card-body box-profile">
                                <dl>
                                    <dt>Файлы</dt>
                                    <dd>
                                        <#if task.type == 0>
                                            <#if comments ??>
                                                <#list comments as comment>
                                                    <#if comment.file??>
                                                        <#list comment.file as file>
                                                            <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                                            <p class="text-muted text-xs">${file.datecreate}&emsp; ${file.author.firstName} ${file.author.surname}</p>
                                                        </#list>
                                                    </#if>
                                                </#list>
                                            </#if>
                                        </#if>
                                    </dd>
                                    <dd>
                                        <#if parentFileList ??>
                                            <#list parentFileList as comment>
                                                <#if comment.file??>
                                                    <#list comment.file as file>
                                                        <div style="padding: 0.2rem;">
                                                            <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                                            <p class="text-muted text-xs">${file.datecreate}&emsp; ${file.author.firstName} ${file.author.surname}</p>
                                                        </div>
                                                    </#list>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </dd>
                                    <dd>
                                        <#if type == "agTask">
                                            <#list files as file>
                                                <div style="padding: 0.2rem;">
                                                    <a href="/task/file/${file.name}?id=${file.id}&type=0" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                                    <p class="text-muted text-xs">${file.datecreate} &emsp; ${file.author.firstName} ${file.author.surname}</p>
                                                </div>
                                            </#list>
                                        </#if>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <#if user.id == task.author.id>
            <div class="modal" tabindex="-1" role="dialog" id="myModal">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form action="/task/update" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Редактирование задачи</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="exampleInputName">Название задачи</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" value="${task.name}">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote1" name="description" value="">${task.description}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Надпроект</label>
                                    <select name="parent" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if projects ??>
                                            <#list projects as project>
                                                <#if task.parentP == project.id>
                                                    <#assign selected="selected">
                                                <#else>
                                                    <#assign selected="">
                                                </#if>
                                                <option <#if selected == "selected">${selected}</#if> value="${project.id}">${project.name}</option>
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
                                                <#if task.parentT == task.id>
                                                    <#assign selected="selected">
                                                <#else>
                                                    <#assign selected="">
                                                </#if>
                                                <option <#if selected == "selected">${selected}</#if> value="${task.id}">${task.name} - ${task.author.firstName} ${task.author.surname}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Ответственный</label>
                                    <select name="responsible" class="select2bs4_1" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if userList ??>
                                            <#list userList as usr>
                                                <#if task.responsible.id == usr.id>
                                                    <#assign selected1="selected">
                                                <#else> <#assign selected1=" ">
                                                </#if>
                                                <#if usr.surname != "user">
                                                    <option <#if selected1 == "selected">${selected1}</#if> value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Команда проекта</label>
                                    <select name="team" class="select2bs4" multiple="multiple" style="width: 100%;">
                                        <#list userList as usr>
                                            <#if usr.surname != "user">
                                                <#if task.team ??>
                                                    <#list task.team as one>
                                                        <#if one.id == usr.id>
                                                            <#assign selected="selected">
                                                        </#if>
                                                    </#list>
                                                </#if>
                                                <option <#if selected??>${selected}</#if> value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                            </#if>
                                        </#list>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Дата начала</label>
                                    <input type="text" name="datecreate" value="${task.datecreate}" class="form-control datetimepicker-input" id="datetimepicker1" data-toggle="datetimepicker" data-target="#datetimepicker5"/>
                                </div>
                                <div class="form-group">
                                    <label>Дедлайн</label>
                                    <input type="text" name="deadline" value="${task.deadline}" class="form-control datetimepicker-input" id="datetimepicker2" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                                </div>
                                <div class="form-group">
                                    <label>Статус</label>
                                    <select name="status" class="form-control">
                                        <option >Активный</option>
                                        <option >Архивный</option>
                                    </select>
                                </div>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <input type="hidden" name="id" value="${task.id}" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            </#if>
            <div class="modal" tabindex="-1" role="dialog" id="myModal2">
                <form action="/task/approve" method="POST">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Комментарий к согласованию</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <textarea class="form-control" name="agComment" value="Напишите комментарий к согласованию"></textarea>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <input type="hidden" name="id" value="${task.id}" />
                                <input type="hidden" name="action" value="approve" />
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                                <button type="submit" class="btn btn-primary">Сохранить</button>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </section>
    </div>
</div>

<!-- jQuery -->
<script src="../static/js/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../static/js/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="../static/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../static/js/adminlte.min.js"></script>
<script src="../static/js/summernote.min.js"></script>
<script src="../static/js/bs-custom-file-input.min.js"></script>
<script type="text/javascript" src="../static/js/select2.full.min.js"></script>
<script type="text/javascript" src="../static/js/moment.min.js"></script>
<script type="text/javascript" src="../static/js/daterangepicker.js"></script>
<script type="text/javascript" src="../static/js/tempusdominus-bootstrap-4.min.js"></script>

<script>
    $('#myModal1').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })

    $('#myModal2').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })

$(document).ready(function() {
    $('#summernote').summernote();
    $('#summernote1').summernote();
});

    $(function () {

        $('.select2bs4_1').select2({
            theme: 'bootstrap4'
        });
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        });
        $('#datetimepicker1').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
        $('#datetimepicker2').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
    });
$(function () {
    bsCustomFileInput.init();
});

$("#js-file").change(function(){
    if (window.FormData === undefined){
        alert('В вашем браузере FormData не поддерживается')
    } else {
        var formData = new FormData();
        $.each($("#js-file")[0].files,function(key, input){
            formData.append('file[]', input);
        });
        $.ajax({
            type: "POST",
            url: 'uploadFile',
            headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
            cache: false,
            contentType: false,
            processData: false,
            data: formData,
            dataType : 'json',
            success: function(data){
               // data.forEach(function(msg) {
                    $('#result').append(data);
               // });
            }
        });
    }
});
</script>
</body>
</html>