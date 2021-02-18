<!DOCTYPE html>
<html lang="en">
<head>
    <title>CorpPortal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="static/css/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="static/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">

    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>


    <div class="card card-outline card-primary">
        <div class="card-header text-center">
            <a href="/" class="h1"><b>Corp Portal</a>
        </div>
        <div class="card-body">
            <!--<p class="login-box-msg">Sign in to start your session</p>-->
            <form action="/login" method="post">
                <div class="input-group mb-3">
                    <input type="text" name="username" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                           valur="<#if user??>${user.username}</#if>" placeholder="username">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                           placeholder="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-8">
                    </div>
                    <!-- /.col -->
                    <div class="col-4">
                        <button type="submit" class="btn btn-primary btn-block">Войти</button>
                    </div>
                    <!-- /.col -->
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
            </form>
           <!-- <p class="mb-1">
                <a href="forgot-password.html">Восстановить пароль</a>
            </p>
            <p class="mb-0">
                <a href="/registration" class="text-center">Регистрация</a>
            </p>-->
        </div>
        <!-- /.card-body -->
    </div>
    <!-- /.card -->
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="static/js/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="static/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="static/js/adminlte.min.js"></script>
</body>
</html>
