<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="domainHelper" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[Import]*}</title>
<script type="text/javascript">
function doImport(){
	var impFile = document.getElementById('impFile').value;
	if(impFile == null || impFile == ''){
		alert("请选择导入文件");
		return false;
	}
	document.forms[0].submit();
	document.getElementById('_bar').style.display = "";
}

function ev_back(){
	location.href = 'exportandimport.jsp';
}
</script>

</head>
<body>
	<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[Import]*}</td>
		<td>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dugotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
<s:form name="uploadForm" enctype="multipart/form-data" action="import" method="post" theme="simple">
	<table align="center">
		<tr>
			<td align="right">{*[Import]*}{*[File]*}：</td>
			<td><s:file name="impFile" id="impFile" cssStyle="width:280px;"/></td>
		</tr>
		<tr>
			<td colspan="2" height="30px"></td>
		</tr>
		<tr>
			<td height="30px">
			<td align="left" valign="top">
				<button type="button" onClick="ev_back()">{*[Back]*}</button>
				&nbsp;
				<button type="button" id="finish_b" onClick="doImport()">{*[Import]*}</button>
			</td>
		</tr>
	</table>
	<table width="100%" style=display:none id='_bar'>
	<tr><td height="50px"></td></tr>
	<tr align="center"><td>正在导入数据：<s:include value="/core/expimp/imp/bar.jsp"/></td></tr>
	</table>
	</s:form>
</body>
</o:MultiLanguage></html>