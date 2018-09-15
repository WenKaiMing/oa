<#include "/${parameters.templateDir}/wwfull/form-validate.ftl" />
<#include "/${parameters.templateDir}/simple/form.ftl" />
<table width="90%" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" class="message">用户列表</td>
          <td align="right">
            <input type="button" class="button-cmd" alt="提交" value="提交" onclick="formItem.action='save.action';formItem.submit()" /> 
	    <input type="button" class="button-cmd" alt="返回" value="返回" onclick="formItem.action='list.action';formItem.submit()" />
	  </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" class="${parameters.cssClass?default('content-table')?html}"<#rt/>
<#if parameters.cssStyle?exists> style="${parameters.cssStyle?html}"<#rt/>
</#if>
>
