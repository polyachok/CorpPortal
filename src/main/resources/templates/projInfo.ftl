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
</head>
<body  class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <#include "parts/top_navbar.ftl">
    <#include "parts/navbar.ftl">
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid" style="padding-top: 15px;">
            <!-- Default box -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">${project.name}</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12 col-md-12 col-lg-8 ">
                                <div class="row">
                                    <div class="col-12 col-sm-12">
                                        <p>${project.description}</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
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
                                                    <#if childList ??>
                                                        <#list childList as child>
                                                            ${child.name}
                                                        </#list>
                                                    </#if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <h4>Комментарии к проекту</h4>
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
                            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
                                <h4 class="text-primary"><img style="width: 30px;" src="../static/img/team.png" alt="image"> Команда проекта</h4>
                                <ul class="list-unstyled">
                                    <#list project.team as team>
                                    <li class="text-muted">
                                        <img style="width: 20px; padding-bottom: 5px;" src="../static/img/avatar.jpg" alt="image"> ${team.surname} ${team.firstName}</a>
                                    </li>
                                    </#list>
                                </ul>
                                <h5 class="mt-5 text-muted">Файлы проекта</h5>
                                <ul class="list-unstyled">
                                    <#list comments as comment>
                                    <#if comment.file??>
                                        <#list comment.file as file>
                                         <li>
                                            <a href="/project/file/${file.name}?id=${file.id}" class="class="btn-link text-secondary""><i class="far fa-file"></i> ${file.name}</a>
                                         </li>
                                        </#list>
                                    </#if>
                                    </#list>
                                </ul>

                            </div>
                        </div>
                    </div>
                <!-- /.card-body -->
                </div>
            </div>
            <!-- /.card -->

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


<script>
$(document).ready(function() {
$('#summernote').summernote();
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
});``
</script>
</body>
</html>