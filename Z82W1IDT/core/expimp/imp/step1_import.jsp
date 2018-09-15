<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.expimp.imp.ejb.ImpSelect" id="impSelect" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[Import]*}</title>
<script>
	function ev_back(){
		document.forms[0].action = '<s:url value="/core/expimp/exporimp.jsp"><s:param name="applicationid" value="%{applicationid}" /></s:url>' ;
		document.forms[0].submit();
	}
	
	function importTypeChange(){
		var oImportType = document.getElementById("importType");
		document.getElementById("modulelist_tr").style.display = "none";
		document.getElementById("finish_b").style.display = "none";
		var tr_handle_mode = document.getElementById("tr_handle_mode");
		tr_handle_mode.style.display='none';
		
		switch(oImportType.value){
			case "1":
			document.getElementById("finish_b").style.display = "";
			tr_handle_mode.style.display='';
			break;
			case "16":
			document.getElementById("modulelist_tr").style.display = "";
			document.getElementById("finish_b").style.display = "";
			break;
			case "256":
			document.getElementById("modulelist_tr").style.display = "";
			document.getElementById("finish_b").style.display = "";
			break;
			default:
			break; 
		}
		if (!oImportType.onchange) {
			oImportType.onchange = this.importTypeChange;
		}
	}
	
	window.onload = function(){
		importTypeChange();
		refreshApplicationTree("refreshid"); // util.js
	}

	function importXml(){
		document.forms[0].submit();
		var temp = document.getElementById('_bar');
		temp.style.display="";
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
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
	</table>

<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:form name="uploadForm" enctype="multipart/form-data" action="imp" method="post" theme="simple">
	<s:hidden name="applicationid" value="%{#parameters.applicationid}"/>
	<s:hidden id="refreshid" name="refresh"/>
	
	<table id="imp_table" class="table_noborder" width=97%>
		<tr>
			<td width="20%;" align="right">{*[Import]*}{*[Type]*}：</td>
			<td>
				<s:select id="importType" cssStyle="width:280px;" theme="simple" name="importType"
					list="#impSelect.getImportTypeNameMap()" /></td>
		</tr >
			<tr id="tr_handle_mode" style="display:none;">
			<td width="20%;" align="right">{*[cn.myapps.core.expimp.handleMode]*}：</td>
			<td>
				<s:select id="handleMode" cssStyle="width:280px;" emptyOption="false" theme="simple" name="handleMode"
					list="#{'update':'{*[cn.myapps.core.expimp.handleMode.update]*}','copy':'{*[cn.myapps.core.expimp.handleMode.copy]*}'}" /></td>
		</tr>
			<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" />
		<tr id="modulelist_tr">
			<td align="right">{*[cn.myapps.core.expimp.module_list]*}：</td>
			<td><s:select cssStyle="width:280px;" theme="simple" name="moduleid"
				list="#moduleHelper.getModuleSel(#parameters.applicationid)" /></td>
		</tr>
		<tr>
			<td align="right">{*[Import]*}{*[File]*}：</td>
			<td><s:file name="impFile" cssStyle="width:280px;"/></td>
		</tr>
		<tr>
			<td colspan="2" height="30px"></td>
		</tr>
		<tr>
			<td height="30px">
			<td align="left" valign="top">
				<button type="button" onClick="ev_back()">{*[Back]*}</button>
				&nbsp;
				<button type="button" id="finish_b" onClick="importXml()">{*[Import]*}</button>
			</td>
		</tr>
	</table>
	<table width="100%" style=display:none id='_bar'>
	<tr><td height="50px"></td></tr>
	<tr align="center"><td>正在导入数据：<s:include value="bar.jsp"/></td></tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>