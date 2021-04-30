<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>CorpPortal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../static/css/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../static/css/adminlte.min.css">
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <link href="../../static/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../static/css/select2-bootstrap4.min.css" >
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
                            <li class="breadcrumb-item"><a href="../task/${parent.id}" class="link-black text-lg"><i class="far fa-folder-open"></i> ${parent.name}</a></li>
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
                                                <h4><strong>${agreement.name}</strong><#if user.id == agreement.author.id ><a class="btn" data-toggle="modal" data-target="#myModal" style="color: #666;"><i class="fas fa-edit"></i></a></#if></h4>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <h5>Статус - ${agreement.status}</h5>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="float-right">
                                                    <a class="btn btn-outline-success" id="print" >Распечатать</a>
                                                </div>
                                            </div>
                                                <#if agAction != 0>
                                                    <#switch taskAction>
                                                        <#case 1>
                                                        <div class="col-md-2">
                                                        </div>
                                                         <div class="col-md-2">
                                                             <a class="btn btn-outline-success" href="/task/${task.id}?action=close">Завершить</a>
                                                         </div>
                                                             <#break>
                                                        <#case 2>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <a class="btn btn-outline-warning" href="/task/${task.id}?action=begin">Начать</a>
                                                        </div>
                                                            <#break>
                                                        <#case 3>
                                                        <div class="col-md-2">
                                                            <a class="btn btn-outline-success" href="/task/${task.id}?action=accept">Принять</a>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <a class="btn btn-outline-danger" href="/task/${task.id}?action=deny">Отказать</a>
                                                        </div>
                                                            <#break>
                                                        <#case 5>
                                                        <div class="col-md-2">
                                                            <a class="btn btn-outline-success" href="/task/${task.id}?action=accept">Принять</a>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <a class="btn btn-outline-danger" href="/task/${task.id}?action=deny">Отказать</a>
                                                        </div>
                                                        <#break>
                                                        <#case 8>
                                                            <div class="col-md-2">
                                                            </div>
                                                            <div class="col-md-2">
                                                                <a class="btn btn-outline-danger" href="/task/${task.id}?action=complete">Завершить</a>
                                                            </div>
                                                            <#break>
                                                        <#default>
                                                    </#switch>
                                                </#if>
                                        </div>
                                    </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-12 col-sm-12">
                                                <p>${(agreement.description)!""}</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-12">
                                                <#if agTask ??>
                                                <div id="accordion">
                                                    <div class="card card-success card-outline">
                                                        <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseOne">
                                                            <div class="card-header">
                                                                <h4 class="card-title w-100">
                                                                   Этапы согласования
                                                                </h4>
                                                            </div>
                                                        </a>
                                                        <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <table class="table table-sm text-nowrap table-borderless table-hover">
                                                                    <thead>
                                                                    <tr style="font: status-bar;">
                                                                        <th>Название</th>
                                                                        <th>Согласовывающий</th>
                                                                        <th>Статус</th>
                                                                        <th>Датат согласования</th>
                                                                        <th>Активность</th>
                                                                        <th>Срок исполнения</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                <#list agTask as child>
                                                                    <tr <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if>>
                                                                        <td><a <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if> href="/task/${child.id}"><b>${child.name}</b></a></td>
                                                                        <td>${child.responsible.surname} ${child.responsible.firstName}</td>
                                                                        <td>${child.status}</td>
                                                                        <td>${(child.dateclose)!""}</td>
                                                                        <td>${(child.lastActive)!""}</td>
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
                                                <hr />
                                                <h4>Комментарии</h4>
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
                                                                <a href="/task/file/${file.name}?id=${file.id}&type=1" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
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
                                                <form enctype="multipart/form-data" action="/agreement/comment" method="post">
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
                                                               <!-- <label class="custom-file-label" for="customFile">Выбрать файлы</label>-->
                                                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                                <input type="hidden" name="task_id" value="${agreement.id}" />
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
                                            <dd class="col-sm-6">${agreement.author.surname} ${agreement.author.firstName}</dd>
                                            <dt class="col-sm-6">Ответственный</dt>
                                            <dd class="col-sm-6">${(agreement.responsible.surname)!""} ${(agreement.responsible.firstName)!""}</dd>
                                            <dt class="col-sm-6">Дата начала</dt>
                                            <dd class="col-sm-6">${agreement.datecreate}</dd>
                                            <dt class="col-sm-6">Срок исполнения</dt>
                                            <dd class="col-sm-6">${agreement.deadline}</dd>
                                        </dl>
                                    <!--    <div class="row">
                                            <div class="col-md-6">
                                                <div >
                                                    <h4 class="profile-username">Автор</h4>
                                                </div>
                                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                                        <li class="text-muted">
                                                            <img style="width: 20px; padding-bottom: 5px;" src="../static/img/avatar.jpg" alt="image"> ${agreement.author.surname} ${agreement.author.firstName}</a>
                                                        </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <div >
                                                    <h4 class="profile-username">Ответственный</h4>
                                                </div>
                                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                                    <li class="text-muted">
                                                        <img style="width: 20px; padding-bottom: 5px;" src="../static/img/avatar.jpg" alt="image"> </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div >
                                                    <h4 class="profile-username">Дата начала</h4>
                                                </div>
                                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                                    <li class="text-muted">
                                                         ${agreement.datecreate}
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <div >
                                                    <h4 class="profile-username">Дедлайн</h4>
                                                </div>
                                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                                    <li class="text-muted">
                                                        ${agreement.deadline}
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>-->
                                    </div>
                                </div>

                        <div class="card card-success card-outline">
                            <div class="card-body box-profile">
                                <dl>
                                    <dt>Маршрут согласования</dt>
                                    <#list sequence as seq>
                                        <dd>${seq.user.surname} ${seq.user.firstName}</dd>
                                    </#list>
                                </dl>
                              <!--  <div class="text-center">
                                    <h4 class="profile-username text-center">Маршрут согласования</h4>
                                </div>
                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                    <#list sequence as seq>
                                        <li class="text-muted">
                                            <img style="width: 20px; padding-bottom: 5px;" src="../static/img/avatar.jpg" alt="image"> ${seq.user.surname} ${seq.user.firstName}</a>
                                        </li>
                                    </#list>
                                </ul>-->
                            </div>
                        </div>
                        <div class="card card-success card-outline">
                            <div class="card-body box-profile">
                                <dl>
                                    <dt>Файлы</dt>
                                    <dd>
                                        <#list agreement.file as file>
                                            <a href="/task/file/${file.name}?id=${file.id}&type=1" class="link-black text-sm"><i class="far fa-file"></i> ${file.name}</a>
                                            <p class="text-muted text-xs">${file.datecreate}&emsp; ${file.author.firstName} ${file.author.surname}</p>
                                        </#list>
                                    </dd>
                               <!-- <div class="text-center">
                                    <h4 class="profile-username text-center">Файлы</h4>
                                </div>
                                <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                    <#list agreement.file as file>
                                        <li>
                                            <a href="/task/file/${file.name}?id=${file.id}&type=1" class="btn-link text-secondary"><i class="far fa-file"></i> ${file.name}</a>
                                        </li>
                                    </#list>
                                </ul>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <#if user.id == agreement.author.id>
            <div class="modal" tabindex="-1" role="dialog" id="myModal">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form action="/task/update" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Редактирование согласования</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="exampleInputName">Название согласования</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" value="${agreement.name}">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote1" name="description" value="">${(agreement.description)!""}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Маршрут</label>
                                    <select name="team" class="select2bs4" multiple="multiple" style="width: 100%;">

                                        <#list routeList as route>
                                            <#if route.id == agreement.route.id>
                                                <#assign selected="selected">
                                            </#if>
                                        </#list>
                                        <option <#if selected??>${selected}</#if> value="${agreement.route.id}">${agreement.route.name} </option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Дедлайн</label>
                                    <input type="text" name="deadline" value="${agreement.deadline}" class="form-control datetimepicker-input" id="datetimepicker2" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                                </div>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <input type="hidden" name="id" value="${agreement.id}" />
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

    $("#print").click(function(){
        var agreement = ${agreement.id};
        $.ajax({
            type: "GET",
            url: 'fileApprove',
            headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
            data: {"agreement" : agreement},
            xhrFields: {
                'responseType': 'blob'
            },
            success: function(data, status, xhr){
                var blob = new Blob([data], {type: xhr.getResponseHeader('Content-Type')});
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.setAttribute('download', 'file.pdf');
                link.click();
            }
        });

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