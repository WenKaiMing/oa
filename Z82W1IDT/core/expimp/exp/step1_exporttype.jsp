<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<script src="<s:url value='export.js'/>"></script>
<script>
	window.onload = function(){
		exportTypeChange();
		ev_download('<s:property value="filename" />');
	}
	
	function exportTypeChange(){
		var oExportType = document.getElementById("exportType");
		document.getElementById("modulelist_tr").style.display = "none";
		document.getElementById("next_b").style.display = "none";
		document.getElementById("finish_b").style.display = "none";
		
		switch(oExportType.value){
			case "1":
			document.getElementById("finish_b").style.display = "";
			break;
			case "16":
			document.getElementById("modulelist_tr").style.display = "";
			document.getElementById("finish_b").style.display = "";
			break;
			case "256":
			document.getElementById("modulelist_tr").style.display = "";
			document.getElementById("next_b").style.display = "";
			break;
			default:
			break; 
		}
		if (!oExportType.onchange) {
			oExportType.onchange = this.exportTypeChange;
		}
	}
	
	function ev_next(){
		document.forms[0].action = '<s:url action="next" />';
		document.forms[0].submit();
	}
	
	function ev_exp(){
		document.getElementById("loading").style == "display:block";
		document.forms[0].action = '<s:url action="step1exp" />';
		document.forms[0].submit();
		showload();
	}
	
	function ev_back(){
		document.forms[0].action = '<s:url value="/core/expimp/exporimp.jsp" ><s:param name="applicationid" value="%{applicationid}" /></s:url>';
		//alert(document.forms[0].action);
		document.forms[0].submit();
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
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="loading" style="display:none">
		<div class="loading-indicator">
			Loading...
		</div>
	</div>
	<s:form id="formExport" name="formExport" action="exp" method="post">
		<table class="table_noborder" width=97%>
			<tr>
				<td width="20%;" align="right">{*[Export]*}{*[Type]*}：</td>
				<td>
				<s:select id="exportType" cssStyle="width:280px;" theme="simple" name="exportType"
					list="expSelect.exportTypeNameMap" /></td>
			</tr>
			<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" />
			<tr id="modulelist_tr">
				<td align="right">{*[cn.myapps.core.expimp.module_list]*}：</td>
				<td><s:select cssStyle="width:280px;" theme="simple" name="moduleid"
					list="#moduleHelper.getModuleSel(applicationid)" /></td>
			</tr>
			<tr>
			<tr>
				<td colspan="2" height="30px"></td>
			</tr>
			<tr>
				<td></td>
				<td align="left" valign="top">
					<button type="button" onClick="ev_back();">{*[Back]*}</button>
					&nbsp;
					<button type="button" id="next_b" onClick="ev_next();">{*[Next]*}</button>
					<button type="button" id="finish_b" onClick="ev_exp();" >{*[Export]*}</button>
				</td>
			</tr>
		</table>
	</s:form>
</body>
</o:MultiLanguage></html>
