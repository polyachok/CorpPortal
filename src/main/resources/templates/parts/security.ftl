<#assign
    known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
  <#assign
      user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
      name = user.getUsername()
      firstname = user.getFirstName()
      surname = user.getSurname()
      isAdmin = user.isAdmin()
  >
<#else>
    <#assign
        name = "Гость"
        isAdmin = false
    >
</#if>