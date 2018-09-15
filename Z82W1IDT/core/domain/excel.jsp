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

function doExcelExport(){
	
	var domainId = parent.OBPM.dialog.getArgs()['domain'];
	var url = "<s:url value='/core/domain/excelExportUserAndDept.action'/>";
	    url += "?domainid="+domainId+"";
	window.open(url);
}

function doExcelImport(){
	var url = contextPath + '/core/domain/importbyid.jsp';
	
	var domainId = parent.OBPM.dialog.getArgs()['domain'];
	OBPM.dialog.show({
		opener:window.parent.parent,
		width: 780,
		height: 560,
		url: url,
		title: "EXCEL用户导入",
		args : {domain:domainId},
		close: function(result){
		}
	});
}

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
	<s:form name="exportandimportform" action="" method="post">
		<table border="0">
		<tr>
			<td width="200px" align="center">
			<!-- Export Module -->
			<label>{*[Export]*}{*[Data]*}</label>
			<div>
			<input type="image" src='<s:url value="/resource/image/exp_module.gif" />' 
				onclick="doExcelExport()"width="100" height="75" /></div>
			</td>
		
			<td>
			<!-- Import Module -->
			<label>{*[Import]*}{*[Data]*}</label>
			<div>
			<input type="image" src='<s:url value="/resource/image/imp_module.gif" />' 
				onclick="doExcelImport()"width="100" height="75" /></div>
			</td>
		</tr>
		</table>
	</s:form>
</body>
</o:MultiLanguage></html>
