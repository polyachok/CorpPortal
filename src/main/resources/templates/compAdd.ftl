<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Corp Portal</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../static/css/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../static/css/adminlte.min.css">
    <link rel="stylesheet" href="../static/css/tempusdominus-bootstrap-4.min.css" >
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <link href="../static/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../static/css/select2-bootstrap4.min.css" >
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
                            <h3>Новая организация</h3>
                        </div>
                        <div class="card-body">
                            <form action="/company" method="post">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label>ИНН</label>
                                            <input type="text" name="inn" class="form-control" id="party" placeholder="ИНН">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">КПП</label>
                                            <input type="text" name="kpp" class="form-control" id="kpp" placeholder="КПП">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-9">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Название организации</label>
                                            <input type="text" name="name" class="form-control" id="name_short" placeholder="Название">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-9">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Адрес организации</label>
                                            <input type="text" name="address" class="form-control" id="address" placeholder="Адрес">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Генеральный директор</label>
                                            <input type="text" name="director" class="form-control" id="management_name" placeholder="Генеральный Директор">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Контактное лицо</label>
                                            <input type="text" name="contact" class="form-control"  placeholder="Контактное лицо">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">E-mail</label>
                                            <input type="text" name="email" class="form-control"  placeholder="email">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Телефон</label>
                                            <input type="text" name="phone" class="form-control"  placeholder="Телефон">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Тип организации</label>
                                    <select name="type" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <option value="1">Поставщик</option>
                                        <option value="2">Заказчик</option>
                                        <option value="3">Прочее</option>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-sm-2">
                                        <label>Налогообложение</label>
                                        <select name="nalog" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="ОСНО">ОСНО</option>
                                            <option value="УСНО">УСНО</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>ЭДО</label>
                                        <select name="edo" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="Контур">Контур</option>
                                            <option value="СБИС">СБИС</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Статус</label>
                                            <input type="text" name="status" class="form-control" id="status" placeholder="Статус">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Дата регистрации</label>
                                            <input type="text" name="registration" class="form-control" id="date1" placeholder="Дата регистрации">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Дата актуальности</label>
                                            <input type="text" name="actuality" class="form-control" id="actuality" placeholder="Дата актуальности">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label for="exampleInputName">Период работы</label>
                                            <input type="text" name="date_work" class="form-control"  placeholder="Период работы">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label for="exampleInputName">Уставной капитал</label>
                                            <input type="text" name="capital" class="form-control"  placeholder="Уставной капитал">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Численность человек</label>
                                            <input type="text" name="size" class="form-control"  placeholder="Численность человек">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <!-- text input -->
                                        <div class="form-group">
                                            <label for="exampleInputName">Численность водителей</label>
                                            <input type="text" name="driver" class="form-control" id="date1" placeholder="Численность водителей">
                                        </div>
                                    </div>

                                </div>
                                <#if message ??>
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <strong>${message}</strong>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                </#if>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </div>
                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Сохранить</button>
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
<script type="text/javascript" src="../static/js/summernote.min.js"></script>
<script type="text/javascript" src="../static/js/select2.full.min.js"></script>
<script type="text/javascript" src="../static/js/moment.min.js"></script>
<script type="text/javascript" src="../static/js/daterangepicker.js"></script>
<script type="text/javascript" src="../static/js/tempusdominus-bootstrap-4.min.js"></script>
<script>
    var token = "b9aca397fd09fd74d3c57f7253d09f9587f5721d";
    var options = {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    };
    $("#party").change(function(e) {
        var promise = suggest(e.target.value);
        promise
            .done(function(response) {
                showParty(response.suggestions)
                console.log(response);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
                console.log(errorThrown);
            });
    });

    function suggest(query) {
        var serviceUrl = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/party";
        var request = {
            "query": query
        };
        var params = {
            type: "POST",
            contentType: "application/json",
            headers: {
                "Authorization": "Token " + token
            },
            data: JSON.stringify(request)
        }

        return $.ajax(serviceUrl, params);
    }

    function clearParty() {
        $("#name_short").val("");
     //   $("#name_full").val("");
        $("#inn").val("");
        $("#kpp").val("");
        $("#address").val("");
        $("#status").val("");
        $("#date1").val("");
        $("#actuality").val("");
    }

    function showParty(suggestions) {
        clearParty();
        if (suggestions.length === 0) return;
        var party = suggestions[0].data;
        $("#name_short").val(party.name.short_with_opf);
      //  $("#name_full").val(party.name.full_with_opf);
        $("#inn").val(party.inn);
        $("#kpp").val(party.kpp);
        $("#address").val(party.address.value);
        $("#status").val(party.state.status);
        var date1 = new Date(party.state.registration_date);
        var date2 = new Date(party.state.actuality_date);
        $("#date1").val(date1.toLocaleString("ru", options));
        $("#actuality").val(date2.toLocaleString("ru", options));

        showManagement(party);
    }

    function showManagement(party) {
        if (party.management) {
           // $("#management_post").text(party.management.post);
            $("#management_name").val(party.management.name);
        } else {
           // $("#management_post").text("");
            $("#management_name").val("");
        }
    }

    $(document).ready(function() {
        $('#summernote').summernote();
    });

    $(function () {
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        });


    })
    $(function () {
        $('#datetimepicker5').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
        $('#datetimepicker6').datetimepicker({
            locale: 'ru',
            format: 'L'
        });
    });

</script>
</body>
</html>