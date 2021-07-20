<#-- edit task -->
<#macro editContract>
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
                                <div class="form-group">
                                    <label for="exampleInputName">Название договора</label>
                                    <input type="text" name="name" class="form-control" id="exampleInputName" value="${(contract.name)!""}">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Номер</label>
                                    <input type="text" name="number" class="form-control" id="exampleInputName" value="${(contract.number)!""}">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName">Описание</label>
                                    <textarea id="summernote" name="description">${(contract.description)!""}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Дата по договору</label>
                                    <input type="text" name="actuality" class="form-control datetimepicker-input" id="datetimepicker5" data-toggle="datetimepicker" data-target="#datetimepicker5" value="${(contract.actuality)!""}"/>
                                </div>
                                <div class="form-group">
                                    <label>Дата окончания</label>
                                    <input type="text" name="date_end" class="form-control datetimepicker-input" id="datetimepicker6" data-toggle="datetimepicker" data-target="#datetimepicker6" value="${(contract.date_end)!""}"/>
                                </div>
                                <div class="form-group">
                                    <label>Контрагент</label>
                                    <input type="text" name="company1" class="form-control" id="exampleInputName"  value="${(contract.company1.name)!""}"/>
                                </div>
                                <div class="form-group">
                                    <label>Организация</label>
                                    <label>Контрагент</label>
                                    <input type="text" name="company2" class="form-control" id="exampleInputName"  value="${(contract.company2.name)!""}"/>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="result">

                                    </div>
                                </div>
                                <div class="custom-file" style="margin-top: 10px;">
                                    <input type="file" name="file" multiple id="js-file" >
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </div>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        </div>
                        <div class="card-footer">
                            <!-- <button type="submit" class="btn btn-primary">Сохранить</button>-->
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</#macro>