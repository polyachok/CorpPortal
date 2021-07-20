<#import "parts/common1.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>

    <section class="content" style="padding-top: 10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Новый договор</h3>
                        </div>
                        <div class="card-body">
                            <form enctype="multipart/form-data" action="/contract" method="post">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label for="exampleInputName">Номер</label>
                                            <input type="text" name="number" class="form-control" id="exampleInputName" placeholder="Номер договора">
                                        </div>
                                    </div>
                                    <div class="col-sm-10">
                                        <div class="form-group">
                                            <label for="exampleInputName">Название договора</label>
                                            <input type="text" name="name" class="form-control" id="exampleInputName" placeholder="Название">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Предмет договора</label>
                                    <textarea id="summernote" name="description"></textarea>
                                </div>
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Дата по договору</label>
                                            <input type="text" name="actuality" class="form-control datetimepicker-input" id="datetimepicker5" data-toggle="datetimepicker" data-target="#datetimepicker5"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Дата окончания</label>
                                            <input type="text" name="date_end" class="form-control datetimepicker-input" id="datetimepicker6" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>Пролонгация</label>
                                        <select name="extension" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="Доп. соглашение">Доп. соглашение</option>
                                            <option value="Переподписание">Переподписание</option>
                                            <option value="Другое">Другое</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <label>Условия оплаты</label>
                                        <select name="payment" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="Предоплата">Предоплата</option>
                                            <option value="Постоплата">Постоплата</option>
                                            <option value="Другое">Другое</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Условия поставки</label>
                                        <select name="shipment" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="Доставка">Доставка</option>
                                            <option value="Самовывоз">Самовывоз</option>
                                            <option value="Другое">Другое</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Спецификация</label>
                                        <select name="specification" class="select2bs4" style="width: 100%;">
                                            <option value="-">-</option>
                                            <option value="Спецификация">Спецификация</option>
                                            <option value="На одну поставку / партию">На одну поставку / партию</option>
                                            <option value="Другое">Другое</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label>Контрагент</label>
                                            <select name="company1" class="select2bs4" style="width: 100%;">
                                                <option value="0">-</option>
                                                <#if companyList1 ??>
                                                    <#list companyList1 as company1>
                                                        <option value="${company1.id}">${company1.name}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label>Организация</label>
                                            <select name="company2" class="select2bs4" style="width: 100%;">
                                                <option value="0">-</option>
                                                <#if companyList2 ??>
                                                    <#list companyList2 as company2>
                                                        <option value="${company2.id}">${company2.name}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="result">

                                    </div>
                                </div>
                                <div class="custom-file" style="margin-top: 10px;">
                                    <label>Файл договора</label>
                                    <input type="file" name="file" multiple id="js-file" >
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
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
</script>
