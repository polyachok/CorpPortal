<#import "parts/common1.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "parts/macro/contract.ftl" as contractMacro>
<@c.page>

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Карточка договора</h1>
                </div>
                <div class="col-sm-6">

                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- Main content -->
                    <div class="invoice p-3 mb-3">
                        <!-- title row -->
                        <div class="row">
                            <div class="col-12">
                                <h4>${(contract.name)!""}</h4>
                            </div>
                            <!-- /.col -->
                        </div>
                        <div class="row">
                            <div class="col-12">
                               <p>${(contract.description)!""}</p>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- info row -->
                        <div class="row invoice-info">
                            <div class="col-sm-4 invoice-col">
                                <strong>Контрагент</strong>
                                <address>
                                    <h5><a href="/company/${contract.company1.id}"><strong>${contract.company1.name}</strong></a></h5>
                                </address>
                                <strong>№ договора</strong> - ${(contract.number)!"-"}<br>
                                <strong>Дата подписания</strong> - ${(contract.date_start)!"-"}<br>
                                <strong>Дата окончания</strong> - ${(contract.date_end)!"-"}<br>

                            </div>
                            <!-- /.col -->
                            <div class="col-sm-4 invoice-col">
                                <strong>&emsp;</strong>
                                <address>
                                    <h5> &emsp;</h5>
                                </address>
                                <strong>Пролонгация</strong> - ${(contract.extension)!"-"}<br>
                                <strong>Предмет договора</strong> - ${(contract.description)!"-"}<br>
                                <strong>Условия поставки</strong> - ${(contract.shipment)!"-"}<br>
                                <strong>Спецификация</strong> - ${(contract.spec)!"-"}<br>

                            </div>
                            <div class="col-sm-4 invoice-col">
                                <strong>Подписант</strong>
                                <address>
                                    <h5><a href="/company/${contract.company2.id}"><strong>${contract.company2.name}</strong></a></h5>
                                </address>
                                <strong>Ответственный</strong> - ${(contract.author.surname)!"-"} ${(contract.author.firstName)!"-"}<br>
                            </div>
                            <!-- /.col -->

                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <!-- Table row -->
                        <div class="row">
                            <div class="col-12 table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Qty</th>
                                        <th>Product</th>
                                        <th>Serial #</th>
                                        <th>Description</th>
                                        <th>Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#list contract.file as file>
                                    <tr>
                                        <td>${file.name}</td>
                                        <td>Call of Duty</td>
                                        <td>455-981-221</td>
                                        <td>El snort testosterone trophy driving gloves handsome</td>
                                        <td>$64.50</td>
                                    </tr>
                                    </#list>

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <div class="row">
                            <!-- accepted payments column -->
                            <div class="col-6">
                                <p class="lead">Payment Methods:</p>
                                <img src="../../dist/img/credit/visa.png" alt="Visa">
                                <img src="../../dist/img/credit/mastercard.png" alt="Mastercard">
                                <img src="../../dist/img/credit/american-express.png" alt="American Express">
                                <img src="../../dist/img/credit/paypal2.png" alt="Paypal">

                                <p class="text-muted well well-sm shadow-none" style="margin-top: 10px;">
                                    Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles, weebly ning heekya handango imeem
                                    plugg
                                    dopplr jibjab, movity jajah plickers sifteo edmodo ifttt zimbra.
                                </p>
                            </div>
                            <!-- /.col -->
                            <div class="col-6">
                                <p class="lead">Amount Due 2/22/2014</p>

                                <div class="table-responsive">
                                    <table class="table">
                                        <tr>
                                            <th style="width:50%">Subtotal:</th>
                                            <td>$250.30</td>
                                        </tr>
                                        <tr>
                                            <th>Tax (9.3%)</th>
                                            <td>$10.34</td>
                                        </tr>
                                        <tr>
                                            <th>Shipping:</th>
                                            <td>$5.80</td>
                                        </tr>
                                        <tr>
                                            <th>Total:</th>
                                            <td>$265.24</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <!-- this row will not appear when printing -->
                        <div class="row no-print">
                            <div class="col-12">
                                <a href="invoice-print.html" rel="noopener" target="_blank" class="btn btn-default"><i class="fas fa-print"></i> Print</a>
                                <button type="button" class="btn btn-success float-right"><i class="far fa-credit-card"></i> Submit
                                    Payment
                                </button>
                                <button type="button" class="btn btn-primary float-right" style="margin-right: 5px;">
                                    <i class="fas fa-download"></i> Generate PDF
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- /.invoice -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </section>
    <#if user.id == contract.author.id>
        <@contractMacro.editContract/>
    </#if>

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
