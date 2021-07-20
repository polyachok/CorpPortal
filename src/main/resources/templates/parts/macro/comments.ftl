<#--Final agrement task comment -->
<#macro atc>

        <div class="post" style="border-bottom: 1px solid #adb5bd;">
            <div class="position-relative p-3 bg-Light" style="height: 180px">
                <div class="ribbon-wrapper ribbon-xl">
                    <div class="ribbon bg-warning text-lg">
                        Согласовано
                    </div>
                </div>
                <h4>Финальный комментарий</h4>
                <p><small>от </small><strong> ${task.responsible.surname} ${task.responsible.firstName}</strong></p>
                <p>${task.agComment} <br>
                    <small>${task.dateclose}</small></p>
            </div>
        </div>


</#macro>