<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@page  import="java.util.*,cn.myapps.util.*,cn.myapps.core.deploy.module.action.ModuleHelper,cn.myapps.core.deploy.module.ejb.ModuleVO,cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.deploy.module.statistics]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<script>
  function on_submit()
  {
    var Attr = new Object();
    Attr.iscommit = true;
    window.returnValue = Attr;
    window.close();
  }
</script>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<s:form action="edit" method="post" theme="simple">	

	<table width="98%" class="list-table">
	<tr class="list-toolbar">
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="80" class="text-label">{*[cn.myapps.core.deploy.module.statistics]*}</td>
		
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position">
			<tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class" onClick="on_submit()">
					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Commit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	
	
	<s:hidden name="committedModuleId" value="%{content.id}"/>
	
	<s:if test="hasFieldErrors()">
		<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
		<s:iterator value="fieldErrors">
			*<s:property value="value[0]" />;
		</s:iterator> </span>
	</s:if>
	
	<%
		ModuleVO module  = (ModuleVO)(request.getAttribute("content"));
	  //  String module = (String)request.getAttribute("content");
		String applicationid = (String)request.getSession().getAttribute("APPLICATION");
	    String  str =  ModuleHelper.listAllElement(module,applicationid);
	%>		
	<%= str %>
</s:form>
</body>
</o:MultiLanguage></html>