<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>

    <link rel="stylesheet" type="text/css" href="../static/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.23/b-1.6.5/b-colvis-1.6.5/b-print-1.6.5/fh-3.1.7/r-2.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/datatables.min.css"/>

    <section class="content" style="padding-top: 15px;">
        <a class="btn btn-app" style="height: 40px; min-width: 40px; padding: 10px 5px; margin: 0px 0px 0px 8px;" href="/user/add">
            <i class="fas fa-plus"></i>
        </a>
        <div class="container-fluid" style="padding-top: 15px;">
            <div class="row">
                <div class="col-12">
                    <table id="user-table" class="table table-sm table-hover table-borderless">
                        <thead>
                        <tr>
                            <th>ФИО</th>
                            <th>Отдел</th>
                            <th>Должность</th>
                            <th>Моб. телефон</th>
                            <th>E-mail</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>

                        <tr >
                            <td><a href="/user/${user.id}">${user.surname} ${user.firstName} <#if user.patronomic ??>${user.patronomic}</#if></a></td>
                            <td><#if user.departament ??>${user.departament}<#else> - </#if></td>
                            <td><#if user.position ??>${user.position}<#else> - </#if></td>
                            <td><#if user.mPhone ??>${user.mPhone}<#else> - </#if></td>
                            <td><#if user.email ??>${user.email}<#else> - </#if></td>
                        </tr>

                        </#list>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>ФИО</th>
                            <th>Отдел</th>
                            <th>Должность</th>
                            <th>Моб. телефон</th>
                            <th>E-mail</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </section>
</@c.page>
    <script type="text/javascript" src="../static/js/datatables.min.js"></script>
    <script>
        $(document).ready( function () {
            $('#user-table').DataTable({
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
    </script>
