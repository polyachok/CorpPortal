<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
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
</head>
<body  class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <#include "parts/top_navbar.ftl">
    <#include "parts/navbar.ftl">
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid" style="padding-top: 15px;">
            <!-- Default box -->
            <div class="row">
                <div class="col-md-9">
                        <div class="card card-primary card-outline">
                            <div class="card-body box-profile">
                                <div class="post">
                                    <div class="row">
                                        <div class="col-md-11">
                                            <h4><strong>${project.name}</strong>&emsp;<#if user.id == project.author.id ><a class="btn" data-toggle="modal" data-target="#myModal" style="color: #666;"><i class="fas fa-edit"></i></a></#if></h4>
                                        </div>
                                        <div class="col-md-1"></div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-12 col-sm-12">
                                                <p>${project.description}</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-12">
                                                <#if childProject ??>
                                                <div id="accordion">
                                                    <div class="card card-primary card-outline">
                                                        <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseOne">
                                                            <div class="card-header">
                                                                <h4 class="card-title w-100">
                                                                    Проекты
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
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                <#list childProject as child>
                                                                    <tr>
                                                                        <td><a href="/project/${child.id}"><b>${child.name}</b></a></td>
                                                                        <td>${child.author.surname} ${child.author.firstName}</td>
                                                                    </tr>
                                                                </#list>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                </#if>
                                                <#if childTask ??>
                                                <div id="accordion">
                                                    <div class="card card-success card-outline">
                                                        <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseTwo">
                                                            <div class="card-header">
                                                                <h4 class="card-title w-100">
                                                                    Задачи
                                                                </h4>
                                                            </div>
                                                        </a>
                                                        <div id="collapseTwo" class="collapse show" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <table class="table table-sm text-nowrap table-borderless table-hover">
                                                                    <thead>
                                                                    <tr style="font: status-bar;">
                                                                        <th>Название</th>
                                                                        <th>Автор</th>
                                                                        <th>Ответственный</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <#list childTask as child>
                                                                        <tr <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if>>
                                                                            <td><a <#if child.deadLineStatus == true>style="color:#f90606; font-weight: bold;"</#if> href="/task/${child.id}"><b>${child.name}</b></a></td>
                                                                            <td>${child.author.surname} ${child.author.firstName}</td>
                                                                            <td>${child.responsible.surname} ${child.responsible.firstName}</td>
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
                                                <h4>Комментарии к проекту</h4>
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
                                                                <a href="/project/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
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
                                                <form enctype="multipart/form-data" action="/project/comment" method="post">
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
                                                                <input type="hidden" name="project_id" value="${project.id}" />
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
                        <!-- /.card-body -->
                        </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <h3 class="profile-username text-center">Команда проекта</h3>
                            </div>
                            <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                <#list project.team as team>
                                    <li class="list-group-item">
                                        <img style="width: 20px; padding-bottom: 5px;" src="../static/img/avatar.jpg" alt="image"> ${team.surname} ${team.firstName}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <h3 class="profile-username text-center">Файлы проекта</h3>
                            </div>
                            <ul class="list-group list-group-unbordered list-unstyled mb-3">
                                <#if comments ??>
                                    <#list comments as comment>
                                        <#if comment.file??>
                                            <#list comment.file as file>
                                                <li>
                                                    <a href="/project/file/${file.name}?id=${file.id}" class="class="btn-link text-secondary""><i class="far fa-file"></i> ${file.name}</a>
                                                </li>
                                            </#list>
                                        </#if>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- /.card -->
            <#if user.id == project.author.id>
            <div class="modal" tabindex="-1" role="dialog" id="myModal">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form action="/project/update" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Редактирование проекта</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                                <div class="form-group">
                                    <label for="exampleInputName">Название проекта</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" value="${project.name}">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote1" name="description" value="">${project.description}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Надпроект</label>
                                    <select name="parent" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if projects ??>
                                            <#list projects as pr>
                                                <#if project.parent == pr.id>
                                                    <#assign selected="selected">
                                                <#else>
                                                    <#assign selected="">
                                                </#if>
                                                <option <#if selected == "selected">${selected}</#if> value="${pr.id}">${pr.name}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Команда проекта</label>
                                    <select name="team" class="select2bs4" multiple="multiple" style="width: 100%;">
                                        <#list userList as usr>
                                            <#if usr.surname != "user">
                                                <#if team ??>
                                                    <#list team as one>
                                                        <#if one.id == usr.id>
                                                            <#assign selected="selected">
                                                            <#else>
                                                            <#assign selected="">
                                                        </#if>
                                                    </#list>
                                                </#if>
                                                <option <#if selected == "selected">${selected}</#if> value="${usr.id}">${usr.surname} ${usr.firstName}</option>

                                            </#if>
                                        </#list>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Статус</label>
                                    <select name="status" class="form-control">
                                        <option >Активный</option>
                                        <option >Архивный</option>
                                    </select>
                                </div>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <input type="hidden" name="id" value="${project.id}" />
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

<script>
    $('#myModal').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })

$(document).ready(function() {
    $('#summernote').summernote();
    $('#summernote1').summernote();
});

$(function () {
    bsCustomFileInput.init();
    $('.select2bs4').select2({
        theme: 'bootstrap4'
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