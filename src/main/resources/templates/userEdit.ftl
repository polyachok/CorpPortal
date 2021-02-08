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
                <div class="row">
                    <div class="col-md-12">
                        <form action="/user/update" method="post">
                            <div class="card card-warning card-outline">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <div class="input-group mb-2">
                                                <input type="text" name="username" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                                                       value="${usr.username}" placeholder="Логин">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="input-group mb-3">
                                                <input type="text" name="firstName" class="form-control ${(firstnameError??)?string('is-invalid', '')}"
                                                       value="${usr.firstName}" placeholder="Имя">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="input-group mb-3">
                                                <input type="text" name="surname" class="form-control ${(surnameError??)?string('is-invalid', '')}"
                                                       value="${usr.surname}" placeholder="Фамилия">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="input-group mb-3">
                                                <input type="text" name="patronomic" class="form-control ${(patronomicError??)?string('is-invalid', '')}"
                                                       value="<#if usr.patronomic??>${usr.patronomic}</#if>" placeholder="Отчество">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="input-group mb-3">
                                                <input type="text" name="mPhone" class="form-control ${(mphoneError??)?string('is-invalid', '')}"
                                                       value="<#if usr.mPhone??>${usr.mPhone}</#if>" placeholder="Мобильный телефон">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="input-group mb-3">
                                                <input type="text" name="wPhone" class="form-control"
                                                       value="<#if usr.wPhone??>${usr.wPhone}</#if>" placeholder="Рабочий телефон">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group mb-3">
                                                <input type="email" name="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                                                       value="${usr.email}"  placeholder="Email">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-envelope"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group mb-3">
                                                <input type="password"  value="${usr.password}" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}" placeholder="Password">
                                                <div class="input-group-append">
                                                    <div class="input-group-text">
                                                        <span class="fas fa-lock"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <#list roles as role>
                                                <div class="form-check">
                                                    <input name="${role}" class="form-check-input" type="checkbox" ${usr.roles?seq_contains(role)?string("checked", "")}>
                                                    <label class="form-check-label">${role}</label>
                                                </div>
                                            </#list>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-8">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                        </div>
                                        <div class="col-8">
                                            <input type="hidden" name="userId" value="${usr.id}" />
                                        </div>
                                    </div>
                                </div><!-- /.card-body -->
                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Сохранить</button>
                                </div>
                            </div>




                        </form>
                    </div>
                </div>
            </div>
        </section>

</div>
</body>
</html>