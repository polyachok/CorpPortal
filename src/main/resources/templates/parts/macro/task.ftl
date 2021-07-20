<#-- edit task -->
<#macro editTask>
    <div class="modal" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <form action="/task/update" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Редактирование задачи</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="exampleInputName">Название задачи</label>
                        <input type="text" name="name" class="form-control" id="exampleInputName" value="${task.name}">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputName">Описание</label>
                        <textarea id="summernote1" name="description" value="">${task.description}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Надпроект</label>
                        <select name="parent" class="select2bs4" style="width: 100%;">
                            <option value="0">-</option>
                            <#if projects ??>
                                <#list projects as project>
                                    <#if task.parentP == project.id>
                                        <#assign selected="selected">
                                    <#else>
                                        <#assign selected="">
                                    </#if>
                                    <option <#if selected == "selected">${selected}</#if> value="${project.id}">${project.name}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Надзадача</label>
                        <select name="parentT" class="select2bs4" style="width: 100%;">
                            <option value="0">-</option>
                            <#if taskList ??>
                                <#list taskList as task>
                                    <#if task.parentT == task.id>
                                        <#assign selected="selected">
                                    <#else>
                                        <#assign selected="">
                                    </#if>
                                    <option <#if selected == "selected">${selected}</#if> value="${task.id}">${task.name} - ${task.author.firstName} ${task.author.surname}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Ответственный</label>
                        <select name="responsible" class="select2bs4_1" style="width: 100%;">
                            <option value="0">-</option>
                            <#if userList ??>
                                <#list userList as usr>
                                    <#if task.responsible.id == usr.id>
                                        <#assign selected1="selected">
                                    <#else> <#assign selected1=" ">
                                    </#if>
                                    <#if usr.surname != "user">
                                        <option <#if selected1 == "selected">${selected1}</#if> value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Команда проекта</label>
                        <select name="team" class="select2bs4" multiple="multiple" style="width: 100%;">
                            <#list userList as usr>
                                <#if usr.surname != "user">
                                    <#if task.team ??>
                                        <#list task.team as one>
                                            <#if one.id == usr.id>
                                                <#assign selected="selected">
                                            </#if>
                                        </#list>
                                    </#if>
                                    <option <#if selected??>${selected}</#if> value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                </#if>
                            </#list>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Дата начала</label>
                        <input type="text" name="datecreate" value="${task.datecreate}" class="form-control datetimepicker-input" id="datetimepicker1" data-toggle="datetimepicker" data-target="#datetimepicker5"/>
                    </div>
                    <div class="form-group">
                        <label>Срок исполнения</label>
                        <input type="text" name="deadline" value="${task.deadline}" class="form-control datetimepicker-input" id="datetimepicker2" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                    </div>

                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <input type="hidden" name="id" value="${task.id}" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</div>
</#macro>
<#-- Agreement comment list -->
<#macro agc>
    <h4>Комментарии к согласованию</h4>
    <#list agCommentsList as comment>
        <div class="post" style="border-bottom: 1px solid #adb5bd;">
            <div class="user-block">
                <img class="img-circle img-bordered-sm" src="../static/img/avatar.jpg" alt="user image">
                <span class="username">
                                                          <a href="#">${comment.author.surname} ${comment.author.firstName}</a>
                                                        </span>
                <span class="description">${comment.datecreate}</span>
            </div>
            <!-- /.user-block -->
            <div class="click2edit">
                ${comment.description}
            </div>
            <p>
                <#if comment.file??>
                    <#list comment.file as file>
                        <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
                    </#list>
                </#if>
            </p>
        </div>
    </#list>
</#macro>
<#-- Task  comment list -->
<#macro tc>
    <h4>Комментарии к задаче</h4>
    <#list comments as comment>
        <div class="post" style="border-bottom: 1px solid #adb5bd;">
            <div class="user-block">
                <img class="img-circle img-bordered-sm" src="../static/img/avatar.jpg" alt="user image">
                <span class="username">
                                                          <a href="#">${comment.author.surname} ${comment.author.firstName}</a>
                                                        </span>
                <span class="description">${comment.datecreate}</span>
            </div>
            <!-- /.user-block -->
            <div class="click2edit">
                ${comment.description}
            </div>
            <p>
                <#if comment.file??>
                    <#list comment.file as file>
                        <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
                    </#list>
                </#if>
            </p>
        </div>
    </#list>
</#macro>


<#-- Task Parent comment list -->
<#macro pc>
    <#list parentCommentList as t>
        <#if t.id != task.id>
            <div id="accordion">
                <div class="card card-success card-outline">
                    <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapse${t.id}">
                        <div class="card-header">
                            <h4 class="card-title w-100">
                                ${t.name} &ensp;&mdash;&ensp; <strong>${t.status}</strong> &ensp; ${t.responsible.surname} ${t.responsible.firstName} &ensp; ${(t.dateclose)!""} &ensp;<#if t.deadLineStatus == true><font style="color:#ed1414;"><strong>срок исполнения - ${t.deadline}</strong></font></#if>
                            </h4>
                        </div>
                    </a>
                    <div id="collapse${t.id}" class="collapse" data-parent="#accordion">
                        <div class="card-body">
                            <#if t.agComment ??>
                                <div class="post" style="border-bottom: 1px solid #adb5bd;">
                                    <div class="position-relative p-3 bg-Light" style="height: 180px">
                                        <div class="ribbon-wrapper ribbon-xl">
                                            <div class="ribbon bg-warning text-lg">
                                                ${t.status}
                                            </div>
                                        </div>
                                        <h4>Финальный комментарий</h4>
                                        <p><small>от </small><strong> ${t.responsible.surname} ${t.responsible.firstName}</strong></p>
                                        <p>${t.agComment} <br>
                                            <small>${t.dateclose}</small></p>
                                    </div>
                                </div>

                            </#if>
                            <#list t.comment as comment>
                                <div class="post" style="border-bottom: 1px solid #adb5bd;">
                                    <div class="user-block">
                                        <img class="img-circle img-bordered-sm" src="../static/img/avatar.jpg" alt="user image">
                                        <span class="username"><a href="#">${comment.author.surname} ${comment.author.firstName}</a></span>
                                        <span class="description">${comment.datecreate}</span>
                                    </div>
                                    <!-- /.user-block -->
                                    <div class="click2edit">
                                        ${comment.description}
                                    </div>
                                    <p>
                                        <#if comment.file??>
                                            <#list comment.file as file>
                                                <a href="/task/file/${file.name}?id=${file.id}" class="link-black text-sm"><i class="fas fa-link mr-1"></i> ${file.name}</a>
                                            </#list>
                                        </#if>
                                    </p>
                                </div>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
    </#list>
</#macro>

<#-- Task agreement modal approve -->
<#macro tma1>
    <div class="modal" tabindex="-1" role="dialog" id="myModal2">
        <form action="/task/approve" method="POST">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Комментарий к согласованию</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" name="agComment" value="Напишите комментарий к согласованию"></textarea>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <input type="hidden" name="id" value="${task.id}" />
                        <input type="hidden" name="action" value="approve" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</#macro>
<#macro tma2>
    <div class="modal" tabindex="-1" role="dialog" id="myModal3">
        <form action="/task/approve" method="POST">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Комментарий</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" name="agComment" value="Напишите комментарий "></textarea>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <input type="hidden" name="id" value="${task.id}" />
                        <input type="hidden" name="action" value="not-approve" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</#macro>