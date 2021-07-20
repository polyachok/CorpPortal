<#import "parts/common1.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>

    <link rel="stylesheet" type="text/css" href="../static/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.23/b-1.6.5/b-colvis-1.6.5/b-print-1.6.5/fh-3.1.7/r-2.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/datatables.min.css"/>

    <section class="content">

        <div class="container-fluid" style="padding-top: 15px;">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>Реестр договоров</h4>
                            <!--<a class="btn btn-app" style="height: 40px; min-width: 40px; padding: 10px 5px; margin: 0px 0px 0px 8px;" href="/task/add">
                                <i class="fas fa-plus"></i>
                            </a>-->
                        </div>
                            <div class="card-body">
                                <table id="project-table" class="table table-sm table-hover table-borderless">
                                    <thead>
                                    <tr style="font: status-bar;">
                                        <th>№</th>
                                        <th>Контрагент</th>
                                        <th>Организация</th>
                                        <th>Дата подписания</th>
                                        <th>Дата окончания</th>
                                        <th>Пролонгация</th>
                                        <th>Статус</th>
                                        <th>Автор</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#if list ??>
                                    <#list list as contract>
                                        <tr>
                                            <td><a href="/contract/${contract.id}"><b>${(contract.number)!""}</b></a></td>
                                            <td>${(contract.company1.name)!""}</td>
                                            <td>${(contract.company2.name)!""}</td>
                                            <td>${(contract.date_start)!""}</td>
                                            <td>${(contract.date_end)!""}</td>
                                            <td>${(contract.extension)!""}</td>
                                            <td><#switch contract.status><#case 0><font style="color: #ed1414;"><strong>Не подписан</strong></font><#break><#case 1><font style="color: #2ec150;"><strong>Подписан</strong></font><#break></#switch></td>
                                            <td>${contract.author.surname} ${contract.author.firstName}</td>
                                        </tr>
                                    </#list>
                                    </#if>
                                    </tbody>
                                </table>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</@c.page>
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
</script>
