<#import "parts/common.ftl" as c>

<@c.page>
    <form method="get" action="/main">
        <div class="form-row">
            <div class="col">
                <input class="form-control" type="text" name="filter" value="${filter?if_exists}" placeholder="Find by Tag">
            </div>
            <div class="col">
                <button type="submit" class="btn btn-primary">Find</button>
            </div>
        </div>
    </form>
    <p class="mt-3">
        <a class="btn btn-primary" data-toggle="collapse" href="#collapsemsg" role="button" aria-expanded="false" aria-controls="collapsemsg">New message</a>
    </p>
    <div class="collapse" id="collapsemsg">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="tag">Text tag</label>
                <input class="form-control" type="text" name="tag" placeholder="tag" id="tag">
            </div>
            <div class="form-group">
                <label for="Textarea1">Text message</label>
                <textarea class="form-control" name="text" placeholder="Input text" id="Textarea1" rows="3"></textarea>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file"  id="customFile" name="file">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
              <input type="hidden" name="_csrf" value="${_csrf.token}" />
              <button type="submit" class="btn btn-primary">Send</button>
        </form>
    </div>
    <div class="card-columns">
    <#list messages as message>
        <div class="card mb-3">
            <#if message.filename??>
                <img src="/img/${message.filename}"class="card-img-top">
            </#if>
            <div class="card-body">
                <p class="card-text">${message.text}</p>
                <div class="card-footer text-muted">
                    <i>${message.tag}</i> | <strong>${message.authorName}</strong>
                </div>
            </div>
      </div>
    <#else>
        No Messages
    </#list>
    </div>

</@c.page>
