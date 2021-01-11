<#import "parts/common.ftl" as c>

<@c.page>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal-lg">
                        Новый проект
                    </button>
                </div>
                <!-- ./card-header -->
                <div class="card-body p-0">
                    <table class="table table-hover">
                        <thead>
                        <th>Название</th>
                        <th>Дата начала</th>
                        <th>Ответственный</th>
                        <th>Статус</th>
                        </thead>
                        <tbody>
                        <#list projects as project>
                        <tr>
                            <td class="border-0">${project.name}</td>
                            <td >${project.dateCreate}</td>
                            <td >${project.author.username}</td>
                            <td >${project.status}</td>
                        </tr>
                        <tr data-widget="expandable-table" aria-expanded="true">
                            <td>
                                <i class="fas fa-caret-right fa-fw"></i>
                                219
                            </td>
                        </tr>
                        <tr class="expandable-body">
                            <td>
                                <div class="p-0">
                                    <table class="table table-hover">
                                        <tbody>
                                        <tr data-widget="expandable-table" aria-expanded="false">
                                            <td>
                                                <i class="fas fa-caret-right fa-fw"></i>
                                                219-1
                                            </td>
                                        </tr>
                                        <tr class="expandable-body">
                                            <td>
                                                <div class="p-0">
                                                    <table class="table table-hover">
                                                        <tbody>
                                                        <tr>
                                                            <td>219-1-1</td>
                                                        </tr>
                                                        <tr>
                                                            <td>219-1-2</td>
                                                        </tr>
                                                        <tr>
                                                            <td>219-1-3</td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>219-2</td>
                                        </tr>
                                        <tr>
                                            <td>219-3</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
    </div>
    <!-- /.row -->
    </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
    </div>
    <div class="modal fade" id="modal-lg">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="/project" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Новый проект</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputName">Название проекта</label>
                                <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputName">Описание</label>
                                <textarea name="description" class="form-control" row="3" placeholder="Описание"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Вложен в ...</label>
                                <select name="parent" class="form-control">
                                    <option value="0">-</option>
                                    <option value="1">option 2</option>
                                    <option value="2">option 3</option>
                                    <option value="3">option 4</option>
                                    <option value="4">option 5</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Статус</label>
                                <select name="status" class="form-control">
                                    <option >Активный</option>
                                    <option >Архивный</option>
                                </select>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        </div>

                </div>
                <div class="modal-footer justify-content-between">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</@c.page>
