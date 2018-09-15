<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@include file="/common/tags.jsp"%>
<html><o:MultiLanguage>
<head><title>{*[page.title]*}</title></head>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>'
	type="text/css">

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<s:form action="/core/wizard/application/step1_login.action" method="POST" theme="simple">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" bgcolor="#8B8B8B"></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="60px"></td></tr>
  <tr>
    <td align="center" valign="middle">
	<table width="100%">
		<tr>
			<td colspan="2" class="message">{*[STEP1, Input system administrator's loginno & password! Default is "admin/teemlink".]*}</td>
		</tr>
	    <tr>
	 	    <td height="10px"></td></tr>
	 	<tr>
	 	<td colspan="2" align="center">
	 	<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
</s:if>
	 	</td></tr>
	 	   
		<tr>
			<td align="right" width="5%"><label>{*[Account]*}:</label></td>
			<td ><s:textfield cssClass="login-input" name="username" /></td></tr>
		<tr>
			<td  align="right" width="5%"><label>{*[Password]*}:</label></td>
			<td><s:password cssClass="login-input"  name="password" /></td></tr>		
	        <td height="10"></td></tr>
	    <tr>
	  
			<td colspan="2">
			  <input type="button" name="back" value="Back" class="button-cmd" onclick="window.location='<s:url value="/"/>'"/>
			  <s:submit name="submit" value="{*[Next]*}" theme="simple" cssClass="button-cmd"/>&nbsp;
			</td></tr>
	</table>
    </td>
  </tr>
</table>
	
</s:form>
</body>
</o:MultiLanguage></html>
</http>

