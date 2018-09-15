<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/msg.jsp"%>

<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="domainHelper" />
<html><o:MultiLanguage>
<head>
<title>{*[Import]*}/{*[Export]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<link rel="stylesheet" type="text/css" href='<s:url value="/resource/css/style.css" />' />

<style type="text/css">
<!--
label{ 
	white-space:nowrap;
	}
-->
</style>

<script src="<s:url value='/script/list.js'/>"></script>
<script src="<s:url value='/core/expimp/exp/export.js'/>"></script>
<script>
window.onload = function(){
	ev_download('<s:property value="filename" />');
}

function doExport(){
	var _domainId = document.getElementById('domainId').value;
	if(_domainId == null || _domainId == ""){
		alert("请选择导出类型");
		return false;
	}
	document.forms[0].submit();
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
		<td width="200" class="text-label">{*[Export]*}</td>
		<td>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
	</table>
	<div id="loading" style="display:none">
		<div class="loading-indicator">
			Loading...
		</div>
	</div>
	<s:form id="formExport" name="formExport" action="export" method="post">
		<table align="center">
			<tr align="center">
				<td>{*[Export]*}{*[Domain]*}：</td>
				<td><s:select name="domainId" id="domainId" list="#domainHelper.getAllDomain()" theme="simple" cssStyle="width:280px"></s:select></td>
			</tr>
			<tr>
			<td colspan="2" height="30px"></td>
			</tr>
			<tr>
				<td></td>
				<td align="left">
					<button type="button" onClick="ev_back();">{*[Back]*}</button>
					&nbsp;
					<button type="button" id="finish_b" onClick="doExport();" >{*[Export]*}</button>
				</td>
			</tr>
		</table>
	</s:form>
</body>
</o:MultiLanguage></html>
