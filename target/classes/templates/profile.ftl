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
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">

${message?if_exists}
<#include "parts/top_navbar.ftl">
<#include "parts/navbar.ftl">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Profile</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">User Profile</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9">
                        <div class="card">
                            <div class="card-header p-2">
                                <ul class="nav nav-pills">
                                    <li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab">Settings</a></li>
                                </ul>
                            </div><!-- /.card-header -->
                            <div class="card-body">
                                <div class="tab-content">
                                    <div class="tab-pane" id="settings">
                                        <form class="form-horizontal" method="post">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <div class="form-group row">
                                                <label for="inputName" class="col-sm-2 col-form-label">Имя пользователя</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="username" id="inputName" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                                                           value="${user.username}" placeholder="Имя пользователя для входа">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputFirstName" class="col-sm-2 col-form-label">Имя</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="firstName" if="inputFirstName" class="form-control ${(firstNameError??)?string('is-invalid', '')}"
                                                           value="${user.firstName}" placeholder="Имя">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputSurname" class="col-sm-2 col-form-label">Фамилия</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="surname" id="inputSurname" class="form-control ${(surnameError??)?string('is-invalid', '')}"
                                                           value="${user.surname}" placeholder="Фамилия">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputPatronomic" class="col-sm-2 col-form-label">Отчество</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="patronomic" id="inputPatronomic" class="form-control ${(patronomicError??)?string('is-invalid', '')}"
                                                           value="${user.patronomic}" placeholder="Отчество">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
                                                <div class="col-sm-10">
                                                    <input type="email" name="email" id="inputEmail" class="form-control ${(emailError??)?string('is-invalid', '')}"
                                                           value="${user.email}" placeholder="Email">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputmPhone" class="col-sm-2 col-form-label">Моб. телефон</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="mPhone" id="inputmPhone" class="form-control ${(mPhoneError??)?string('is-invalid', '')}"
                                                           value="${user.mPhone}" placeholder="Мобильный телефон">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputPass" class="col-sm-2 col-form-label">Пароль</label>
                                                <div class="col-sm-10">
                                                    <input type="password" name="password" id="inputPass" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                                                           placeholder="Password">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="offset-sm-2 col-sm-10">
                                                    <button type="submit" class="btn btn-danger">Сохранить</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- /.tab-pane -->
                                </div>
                                <!-- /.tab-content -->
                            </div><!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <div class="col-md-3">
                        <!-- Profile Image -->
                        <div class="card card-primary card-outline">
                            <div class="card-body box-profile">
                                <div class="text-center">
                                    <img class="profile-user-img img-fluid img-circle"
                                         src="../../dist/img/user4-128x128.jpg"
                                         alt="User profile picture">
                                </div>

                                <h3 class="profile-username text-center">Nina Mcintire</h3>

                                <p class="text-muted text-center">Software Engineer</p>

                                <ul class="list-group list-group-unbordered mb-3">
                                    <li class="list-group-item">
                                        <b>Followers</b> <a class="float-right">1,322</a>
                                    </li>
                                    <li class="list-group-item">
                                        <b>Following</b> <a class="float-right">543</a>
                                    </li>
                                    <li class="list-group-item">
                                        <b>Friends</b> <a class="float-right">13,287</a>
                                    </li>
                                </ul>

                                <a href="#" class="btn btn-primary btn-block"><b>Follow</b></a>
                            </div>
                            <!-- /.card-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </section>
    </div>
    </div>
    <!-- jQuery -->
    <script src="../static/js/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../static/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../static/js/adminlte.min.js"></script>

</body>
</html>