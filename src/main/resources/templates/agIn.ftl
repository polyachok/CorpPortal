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
                            <h4>${agType}</h4>
                            <!--<a class="btn btn-app" style="height: 40px; min-width: 40px; padding: 10px 5px; margin: 0px 0px 0px 8px;" href="/task/add">
                                <i class="fas fa-plus"></i>
                            </a>-->
                        </div>
                            <div class="card-body">
                                <table id="project-table" class="table table-sm table-hover table-borderless">
                                    <thead>
                                    <tr style="font: status-bar;">
                                        <th>Название</th>
                                        <th>Дата начала</th>
                                        <th>Дедлайн</th>
                                        <th>Статус</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#if agreements ??>
                                    <#list agreements as ag>
                                        <tr>
                                            <td><a href="/task/${ag.id}"><b>${ag.name}</b></a></td>
                                            <td>${ag.datecreate}</td>
                                            <td>${ag.deadline}</td>
                                            <td>${ag.status}</td>
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
