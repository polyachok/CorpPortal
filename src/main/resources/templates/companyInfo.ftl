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
        <section class="content-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12">
                        <ol class="breadcrumb float-sm-left">
                            <li class="breadcrumb-item"><a href="/company" class="link-black text-lg"><i class="far fa-folder-open"> Контрагенты</i></a>

                                </li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
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
                            <div class="col-12">
                                <!-- Main content -->
                                <div class="invoice p-3 mb-3">
                                    <!-- title row -->
                                    <div class="row">
                                        <div class="col-12">
                                            <h4>
                                                <i class="fas fa-globe"></i> Реквизиты
                                            </h4>
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <!-- info row -->
                                    <div class="row invoice-info">
                                        <div class="col-sm-3 invoice-col">
                                            <address>
                                                <strong>ИНН</strong> - ${(company.inn?string.computer)!""}<br>
                                                <strong>КПП</strong> - ${(company.kpp?string.computer)!""}<br>
                                                <strong>Дата регистрации</strong> - ${(company.registration)!""}<br>
                                                <strong>Статус</strong> - ${(company.status)!""}<br>
                                                <strong>Дата актуальности</strong> - ${(company.actuality)!""}<br>
                                            </address>
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-4 invoice-col">
                                            <address>
                                                <strong>Адрес</strong><br>
                                                ${(company.address)!""}
                                            </address>
                                            <address>
                                                <strong>Генеральный директор</strong><br>
                                                ${(company.director)!""}
                                            </address>
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-2 invoice-col">
                                            <address>
                                                <strong>ЭДО</strong> - ${(company.edo)!""}<br>
                                                <strong>Налогообложение</strong> - ${(company.nalog)!""}<br>
                                            </address>
                                        </div>
                                        <div class="col-sm-3 invoice-col">
                                            <address>
                                                <strong>Контактное лицо</strong><br>
                                                ${(company.contact)!""}
                                            </address>
                                            <address>
                                                <strong>Email</strong> - ${(company.email)!""}<br>
                                                <strong>Телефон</strong> - ${(company.phone)!""}<br>
                                            </address>
                                        </div>                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->
                                    <hr>
                                    <div class="row">
                                        <div class="col-12">
                                            <h4>
                                                <i class="fas fa-globe"></i> Налоговая осмотрительность
                                            </h4>
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <div class="row invoice-info">
                                        <div class="col-sm-4 invoice-col">
                                            <address>
                                                <strong>Период работы</strong> - ${(company.date_work)!"-"}<br>
                                                <strong>Уставной капитал</strong> - ${(company.capital?string("##0.00"))!"-"}<br>
                                                <strong>Численность чел.</strong> - ${(company.size)!"-"}<br>
                                            </address>
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-4 invoice-col">
                                            <address>
                                                <strong>Валюта баланса / стоимость имущества</strong> - ${(company.balance)!"-"}<br>
                                                <strong>Выручка / НДС</strong> - ${(company.money)!"-"}<br>
                                                <strong>Основные средства</strong> - ${(company.assets)!"-"}<br>

                                            </address>
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-4 invoice-col">
                                            <strong>Налоговая нагрузка</strong> - ${(company.tax_burden)!"-"}<br>
                                            <strong>Уплаченный НДС / Выручка</strong> - ${(company.tax_payment)!""}<br>
                                            <strong>Массовые адреса</strong> - ${(company.mass_address)!""}<br>
                                        </div>

                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->
                                    <!-- Table row -->
                                    <hr>
                               <h4>Договора</h4>
                                    <div class="row">
                                        <div class="col-12 table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th>№ Договора</th>
                                                    <th>Дата подписания</th>
                                                    <th>Дата окончания</th>
                                                    <th>Пролонгация</th>
                                                    <th>Предмет договора</th>
                                                    <th>Условия оплаты</th>
                                                    <th>Условия поставки</th>
                                                    <th>Спецификация</th>
                                                    <th>Ответственный</th>
                                                </tr>
                                                </thead>
                                                <tbody>

                                                <#if contractList ??>
                                                    <#list contractList as contract>
                                                        <tr>
                                                            <td><a href="/contract/${contract.id}">${(contract.number)!"-"}</td>
                                                            <td>${(contract.date_start)!"-"}</td>
                                                            <td>${(contract.date_end)!"-"}</td>
                                                            <td>${(contract.extension)!"-"}</td>
                                                            <td>${(contract.description)!"-"}</td>
                                                            <td>${(contract.payment)!"-"}</td>
                                                            <td>${(contract.shipment)!"-"}</td>
                                                            <td>${(contract.specification)!"-"}</td>
                                                            <td>${(contract.author.surname)!"-"}</td>
                                                        </tr>
                                                    </#list>
                                                </#if>

                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->
                                    <hr>

                                    <div class="row">
                                        <!-- accepted payments column -->

                                        <!-- /.col -->
                                        <div class="col-12">

                                            <h4>Документы</h4>
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <tr>
                                                        <th style="width:50%">-</th>
                                                        <td>-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>-</th>
                                                        <td>-</td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->

                                    <!-- this row will not appear when printing -->
                                    <div class="row no-print">
                                        <div class="col-12">
                                            <button type="button" class="btn btn-success float-right">Редактировать</button>
                                            <!--<button type="button" class="btn btn-primary float-right" style="margin-right: 5px;">
                                                <i class="fas fa-download"></i> Generate PDF
                                            </button>-->
                                        </div>
                                    </div>
                                </div>
                                <!-- /.invoice -->
                            </div><!-- /.col -->
                        </div><!-- /.row -->
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