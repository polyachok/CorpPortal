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
    <link rel="stylesheet" type="text/css" href="../static/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.23/b-1.6.5/b-colvis-1.6.5/b-print-1.6.5/fh-3.1.7/r-2.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/datatables.min.css"/>

</head>
<body  class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <#include "parts/top_navbar.ftl">
    <#include "parts/navbar.ftl">
    <div class="content-wrapper">

            <div class="container-fluid" style="padding-top: 15px;">
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>${company.name}</h1>
                            </div>
                        </div>
                    </div><!-- /.container-fluid -->
                </section>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-9">
                                <div class="card">
                                    <div class="card-header p-2">
                                        <ul class="nav nav-pills">
                                            <li class="nav-item"><a class="nav-link active" href="#contract" data-toggle="tab">Договора</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#tax" data-toggle="tab">Налоговая осмотрительность</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#files" data-toggle="tab">Общие документы</a></li>
                                        </ul>
                                    </div><!-- /.card-header -->
                                    <div class="card-body">
                                        <div class="tab-content">
                                            <div class="active tab-pane" id="contract">
                                                <table id="project-table" class="table table-sm table-hover table-borderless">
                                                    <thead>
                                                    <tr style="font: status-bar;">
                                                        <th>Номер</th>
                                                        <th>Дата подписания</th>
                                                        <th>Дата окорнчания</th>
                                                        <th>Условия пролонгации</th>
                                                        <th>Предмет договора</th>
                                                        <th>Условия оплаты</th>
                                                        <th>Условия поставки</th>
                                                        <th>Спецификация</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <#if contractList ??>
                                                        <#list contractList as contract>
                                                            <tr>
                                                                <td><a href="/contract/${contract.id}">${contract.number}</td>
                                                                <td>${contract.actuality}</td>
                                                                <td>${contract.date_end}</td>
                                                                <td>${(contract.extension)!"-"}</td>
                                                                <td>${(contract.name)!"-"}</td>
                                                                <td>${(contract.payment)!"-"}</td>
                                                                <td>${(contract.shipment)!"-"}</td>
                                                                <td>${(contract.spec)!"-"}</td>
                                                            </tr>
                                                        </#list>
                                                    </#if>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- /.tab-pane -->
                                            <div class="tab-pane" id="tax">
                                                <!-- The timeline -->

                                            </div>
                                            <!-- /.tab-pane -->

                                            <div class="tab-pane" id="files">

                                            </div>
                                            <!-- /.tab-pane -->
                                        </div>
                                        <!-- /.tab-content -->
                                    </div><!-- /.card-body -->
                                </div>
                                <!-- /.card -->
                            </div>
                            <div class="col-md-3">
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">О копмании</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body">
                                        <strong><i class="fas fa-map-marker-alt mr-1"></i>Адрес</strong>
                                        <p class="text-muted">${(company.address)!"-"}</p>
                                        <hr>
                                        <strong><i class="fas fa-pencil-alt mr-1"></i> Реквизиты</strong>
                                        <p class="text-muted">
                                        <dl class="row">
                                            <dt class="col-sm-6">ИНН</dt>
                                            <dd class="col-sm-6">${company.inn}</dd>
                                            <dt class="col-sm-6">КПП</dt>
                                            <dd class="col-sm-6">${company.kpp}</dd>
                                            <dt class="col-sm-6">Директор</dt>
                                            <dd class="col-sm-6">${company.director}</dd>
                                            <dt class="col-sm-6">Контактное лицо</dt>
                                            <dd class="col-sm-6">${(company.contact)!"-"}</dd>
                                            <dt class="col-sm-6">E-mail</dt>
                                            <dd class="col-sm-6">${(company.email)!"-"}</dd>
                                            <dt class="col-sm-6">Телефон</dt>
                                            <dd class="col-sm-6">${(company.phone)!"-"}</dd>
                                            <dt class="col-sm-6">ЭДО</dt>
                                            <dd class="col-sm-6">${(company.edo)!"-"}</dd>
                                        </dl>
                                        </p>
                                        <hr>
                                        <strong><i class="far fa-file-alt mr-1"></i> Описание</strong>
                                        <p class="text-muted"> ${(company.description)!"-"}</p>
                                        <#if user.id == company.author.id ><button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-block bg-gradient-primary">Редактировать</button></#if>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div><!-- /.container-fluid -->
                </section>
            </div>

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
<script type="text/javascript" src="../static/js/datatables.min.js"></script>
<script>
    $(document).ready( function () {
        $('#project-table').DataTable({
            "language": {
                "lengthMenu": "Показать _MENU_ записей на странице",
                "zeroRecords": "Записей не обнаружено",
                "info": "Показать _PAGE_ из _PAGES_",
                "infoEmpty": "Записей не обнаружено",
                "infoFiltered": "(выбранно _MAX_ записей)",
                "search": "Поиск:"
            }
        });
    } );



$(function () {
    bsCustomFileInput.init();
    $('.select2bs4').select2({
        theme: 'bootstrap4'
    });
});


</script>
</body>
</html>