<#import "parts/macro/task.ftl" as taskMacro>
<#import "parts/macro/comments.ftl" as commentsMacro>

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
                                                                        <a class="btn btn-outline-danger" href="" data-toggle="modal" data-target="#myModal3">Не согласовано</a>
                                                                    <#break>
                                                                <#default>
                                                            </#switch>
                                                        </#if>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <#if task.goal ??>
                                <div class="post">
                                    <div class="row">
                                        <div class="col-12 col-sm-12">
                                            <h5>${(task.goal)!""}</h5>
                                        </div>
                                    </div>
                                </div>
                                </#if>
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
                                                <#if task.agComment ??>
                                                    <@commentsMacro.atc/>
                                                </#if>
                                                <#if parentCommentList ??>
                                                    <@taskMacro.pc/>
                                                </#if>
                                                <hr />
                                                <#if agCommentsList ??>
                                                    <@taskMacro.agc/>
                                                </#if>
                                                <#if comments ??>
                                                   <@taskMacro.tc/>
                                                </#if>
                                            </div>
                                        </div>
                                        <#if task.status != "Согласовано">
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
                                        </#if>
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
                                                    <a href="/task/file/${file.name}?id=${file.id}&type=1" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                                    <p class="text-muted text-xs">${file.datecreate} &emsp; ${file.author.firstName} ${file.author.surname}</p>
                                                </div>
                                            </#list>
                                            <#if contract ??>
                                                <#list contract.file as file>
                                                    <a href="/contract/file/${file.name}?id=${file.id}&type=1" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                                    <p class="text-muted text-xs">${file.datecreate}&emsp; ${file.author.firstName} ${file.author.surname}</p>
                                                </#list>
                                            </#if>
                                        </#if>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <#if user.id == task.author.id>
               <@taskMacro.editTask/>
            </#if>
            <#if task.type != 0>
                <@taskMacro.tma1/>
                <@taskMacro.tma2/>
            </#if>

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