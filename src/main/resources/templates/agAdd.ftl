<#import "parts/common1.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>

<section class="content" style="padding-top: 10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Новое согласование</h3>
                        </div>
                        <div class="card-body">
                            <form enctype="multipart/form-data" action="/agreement" method="post">
                                <div class="form-group">
                                    <label for="exampleInputName">Название</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                                </div>
                                <div class="form-group">
                                    <label>Предмет согласования</label>
                                    <select name="type" id="type" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <option value="1">Договор</option>
                                        
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote" name="description"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Надзадача</label>
                                    <select name="parentT" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if taskList ??>
                                            <#list taskList as task>
                                                <option value="${task.id}">${task.name} - ${task.author.firstName} ${task.author.surname}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Маршрут согласования</label>
                                    <select name="route" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if route ??>
                                            <#list route as one>
                                                <option value="${one.id}">${one.name}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Ответственный</label>
                                    <select name="responsible" class="select2bs4" style="width: 100%;">
                                        <option value="0">-</option>
                                        <#if userList ??>
                                            <#list userList as usr>
                                                <#if usr.surname != "user">
                                                    <option value="${usr.id}">${usr.surname} ${usr.firstName}</option>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="result">

                                    </div>
                                </div>
                               <div class="form-group">
                                   <div class="custom-file" style="margin-top: 10px;">
                                       <input type="file" name="file" multiple id="js-file" >
                                       <!-- <label class="custom-file-label" for="customFile">Выбрать файлы</label>-->
                                       <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                       <input type="hidden" name="task_id" value="" />
                                   </div>
                                </div>
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
    <div class="modal" tabindex="-1" role="dialog" id="myModal1">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="/task/update" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Новый договор</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputName">Название согласования</label>
                            <input type="text" name="name" class="form-control" id="exampleInputName" value="">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputName">Описание</label>
                            <textarea class="form-control" name="agComment" value="Напишите комментарий к согласованию"></textarea>
                        </div>

                        <input type="hidden" name="_csrf" value="${_csrf.token}" />

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Отменить</button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </section>
</@c.page>
<script type="text/javascript" src="../static/js/summernote.min.js"></script>
<script type="text/javascript" src="../static/js/select2.full.min.js"></script>
<script type="text/javascript" src="../static/js/moment.min.js"></script>
<script type="text/javascript" src="../static/js/daterangepicker.js"></script>
<script type="text/javascript" src="../static/js/tempusdominus-bootstrap-4.min.js"></script>

<script>

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

    $("#js-file").change(function(){
        if (window.FormData === undefined){
            alert('В вашем браузере FormData не поддерживается')
        } else {
            var formData = new FormData();
            $.each($("#js-file")[0].files,function(key, input){
                formData.append('file[]', input);
            });
            $.ajax({
                type: "POST",
                url: 'uploadFile',
                headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                dataType : 'json',
                success: function(data){
                    // data.forEach(function(msg) {
                    $('#result').append(data);
                    // });
                }
            });
        }
    });
    
    $("#type").change(function () {
        $('#myModal1').modal('show');
    });
</script>
