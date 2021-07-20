<#macro editAgreement>
    <div class="modal" tabindex="-1" role="dialog" id="myModal">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="/agreement/update" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Редактирование согласования</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputName">Название согласования</label>
                            <input type="text" name="name" class="form-control" id="exampleInputName" value="${agreement.name}">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputName">Описание</label>
                            <textarea id="summernote1" name="description" value="">${(agreement.description)!""}</textarea>
                        </div>

                        <div class="form-group">
                            <label>Дедлайн</label>
                            <input type="text" name="deadline" value="${agreement.deadline}" class="form-control datetimepicker-input" id="datetimepicker2" data-toggle="datetimepicker" data-target="#datetimepicker6"/>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <input type="hidden" name="id" value="${agreement.id}" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>