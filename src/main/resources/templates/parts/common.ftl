<#macro page>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>CorpPortal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/css/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/css/adminlte.min.css">
    <link href="/static/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/static/css/select2-bootstrap4.min.css" >


</head>
<body  class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

    <#include "top_navbar.ftl">
    <#include "navbar.ftl">
        <div class="content-wrapper">
            <#nested>
        </div>
    </div>

    <!-- jQuery -->
    <script src="/static/js/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="/static/js/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <script src="/static/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/static/js/adminlte.min.js"></script>
    <script type="text/javascript" src="/static/js/select2.full.min.js"></script>

</body>
</html>
</#macro>