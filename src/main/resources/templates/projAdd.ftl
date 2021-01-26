<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | User Profile</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../static/css/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../static/css/adminlte.min.css">
    <link rel="stylesheet" href="../static/css/bootstrap-duallistbox.min.css">

</head>

<body  class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <#include "parts/top_navbar.ftl">
    <#include "parts/navbar.ftl">
    <div class="content-wrapper">
    <section class="content" style="padding-top: 10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Новый проект</h3>
                        </div>
                        <div class="card-body">
                            <form action="/project" method="post">
                                <div class="form-group">
                                    <label for="exampleInputName">Название проекта</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea name="description" class="form-control" row="3" placeholder="Описание"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Надпроект</label>
                                    <select name="parent" class="form-control">
                                                <option value="0">-</option>
                                     <#if projects ??>
                                         <#list projects as project>
                                             <option value="${project.id}">${project.name}</option>
                                         </#list>
                                     </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                    <label>Команда проекта</label>
                                    <select name="team" class="duallistbox" multiple="multiple">
                                        <#list userList as usr>
                                            <#if usr.surname != "user">
                                                <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                            </#if>
                                        </#list>
                                    </select>
                                    </div>
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
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</div>
</div>

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
<script type="text/javascript" src="../static/js/jquery.bootstrap-duallistbox.min.js"></script>

<script>
    $(function () {
        $('.duallistbox').bootstrapDualListbox()
    });
</script>
</body>
</html>