<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<title>{*[Import]*}/{*[Export]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<style type="text/css">
<!--
label{ 
	white-space:nowrap;
	}
-->
</style>
<script type="text/javascript">
	jQuery(document).ready(function(){
		window.top.toThisHelpPage("application_popmenu_importexport_info");
	});
</script>
<script src="<s:url value='/script/list.js'/>"></script>
</head>

<body>
	<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[Import]*}/{*[Export]*}</td>
		<td>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
	</table>
	<s:form name="formList" action="list" method="post">
		<s:hidden name="applicationid" value="%{#parameters.applicationid}" />
		<center><table border="0" align="center">
		<tr align="center">
			<td width="200px">
			<!-- Export Module -->
			<label>{*[Export]*}{*[Data]*}</label>
			<div>
			<input type="image" src='<s:url value="/resource/image/exp_module.gif" />' 
				onclick="forms[0].action='<s:url action="start" namespace="/core/expimp/exp"/>';forms[0].submit();"
				width="100" height="75" /></div>
			</td>
		
			<td>
			<!-- Import Module -->
			<label>{*[Import]*}{*[Data]*}</label>
			<div>
			<input type="image" src='<s:url value="/resource/image/imp_module.gif" />' 
				onclick="forms[0].action='<s:url action="start" namespace="/core/expimp/imp"/>';forms[0].submit();"
				width="100" height="75" /></div>
			</td>
		</tr>
		</table></center>
	</s:form>
</body>
</o:MultiLanguage></html>
