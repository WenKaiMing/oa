<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.deploy.module.module_info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script>
function change(obj) {

	document.getElementsByName('btnBasicInfo')[0].className = "btcaption";
	document.getElementsByName('btnView')[0].className = "btcaption";
	document.getElementsByName('btnForm')[0].className = "btcaption";
	document.getElementsByName('btnWorkflow')[0].className = "btcaption";
	document.getElementsByName('btnExpImp')[0].className = "btcaption";
	//document.getElementsByName('btnTask')[0].className = "btcaption";
	document.getElementsByName('btnReport')[0].className = "btcaption";
	document.getElementsByName('btnCustomizeReport')[0].className = "btcaption";
	document.getElementsByName('btnPrint')[0].className = "btcaption";
	//document.getElementsByName('btnDataMapCfg')[0].className = "btcaption";
	
	obj.className = "btcaption-selected";
	
	var parameters = "?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";
	switch (obj.name){ 
		case "btnBasicInfo":frames["frame"].location.href="<s:url value='/core/deploy/module/edit.action'/>?id=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>";break;
		case "btnForm": frames["frame"].location.href="<s:url value='/core/dynaform/form/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module&_orderby=orderno";break;
		case "btnView": frames["frame"].location.href="<s:url value='/core/dynaform/view/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";break;
		case "btnWorkflow": frames["frame"].location.href="<s:url value='/core/workflow/billflow/defi/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";break;
		case "btnExpImp": frames["frame"].location.href="<s:url value='/core/expimp/exporimp.jsp'/>?s_module=<%=request.getParameter("moduleid") %>&applicationid=<%=request.getParameter("application")%>&mode=module";break;
		//case "btnTask": frames["frame"].location.href="<s:url value='/core/task/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";break;
		case "btnReport": frames["frame"].location.href="<s:url value='/core/report/crossreport/definition/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module&module=<%=request.getParameter("moduleid")%>";break;
		case "btnCustomizeReport": frames["frame"].location.href="<s:url value='/core/report/customizereport/customizereport.jsp'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module&module=<%=request.getParameter("moduleid")%>";break;
		case "btnPrint": frames["frame"].location.href="<s:url value='/core/dynaform/printer/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";break;
		//case "btnDataMapCfg": frames["frame"].location.href="<s:url value='/core/datamap/definition/list.action'/>?s_module=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module";break;
	} 
}
var type = '<%=request.getParameter("type") %>';
function calculateWidth(){
	if(type=="form"){
		change(document.getElementsByName('btnForm')[0]);
	}else if(type=="view"){
		change(document.getElementsByName('btnView')[0]);
	}else if(type=="report"){
		change(document.getElementsByName('btnReport')[0]);
	//}else if(type=="timer"){
	//	change(document.getElementsByName('btnTask')[0]);
	}else if(type=="flow"){
		change(document.getElementsByName('btnWorkflow')[0]);
	}
}
</script>
</head>
<body onLoad="calculateWidth();" class="body-back"> 
<table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" >
	<tr style="height:27px;">
	<td style="width:10px;" align="left" valign="bottom" class="nav-td">
	<td  align="left" valign="bottom" class="nav-td">
		<div id="container">
		<div id="rollbox" class="rollbox">
		<div id="content">
		<div class="listContent"><input type="button"  name="btnBasicInfo" class="btcaption-selected" onClick="change(this)" value="{*[cn.myapps.core.deploy.module.basic_info]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent"><input type="button"  name="btnForm" class="btcaption" onClick="change(this)" value="{*[Form]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent"><input type="button"  name="btnView" class="btcaption"  onclick="change(this)" value="{*[View]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent"><input type="button"  name="btnWorkflow" class="btcaption"   onclick="change(this)" value="{*[Workflow]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent" style="display:none"><input type="button"  name="btnExpImp" class="btcaption"   onclick="change(this)" value="{*[cn.myapps.core.deploy.module.exp_imp]*}"/></div>
		<!-- 
		<div class="listContent"><input type="button"  name="btnTask" class="btcaption"   onclick="change(this)" value="{*[Task]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		 -->
		<div class="listContent"><input type="button"  name="btnReport" class="btcaption"   onclick="change(this)" value="{*[cn.myapps.core.report.crossreport.name]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent"><input type="button"  name="btnCustomizeReport" class="btcaption"   onclick="change(this)" value="{*[cn.myapps.core.resource.customize_report]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<div class="listContent"><input type="button"  name="btnPrint" class="btcaption"   onclick="change(this)" value="{*[Print]*}"/></div>
		<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
		<!-- <div class="listContent"><input type="button"  name="btnDataMapCfg" class="btcaption"   onclick="change(this)" value="{*[数据地图]*}"/></div> -->
		</div>
		</div>
	</td>
	</tr>
<tr><td colspan="2" valign="top">
		<iframe scrolling="no" id="frame" name="frame" style="height:100%;width:100%;" src="<s:url value='/core/deploy/module/edit.action'/>?id=<%=request.getParameter("moduleid") %>&application=<%=request.getParameter("application")%>&mode=module" width="820" height="500" frameborder="0"/></iframe>
	</td></tr>
</table>

</body>
</o:MultiLanguage></html>
