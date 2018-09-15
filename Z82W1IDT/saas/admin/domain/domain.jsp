<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String username = user.getName();
	boolean isSuperAdmin = user.isSuperAdmin();
	String id=request.getParameter("id");
%>

<html><o:MultiLanguage>
<head>
<title>{*[Domain_Definition]*}</title>

<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css">

</head>
<script>

var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';


function change(display) {
	document.getElementsByName('btnBasicInfo')[0].className = "btcaption";
	document.getElementsByName('btnUser')[0].className = "btcaption";
	document.getElementsByName('btnDept')[0].className = "btcaption";
	//document.getElementsByName('btnApps')[0].className = "btcaption";
	//document.getElementsByName('btnAdns')[0].className = "btcaption";
	//document.getElementsByName('btnMltLng')[0].className = "btcaption";
	//document.getElementsByName('btnWkCld')[0].className = "btcaption";
	//document.getElementsByName('btnUserFormExtends')[0].className = "btcaption";
	//document.getElementsByName('btnNetworkDisk')[0].className = "btcaption";
	//document.getElementsByName('btnLog')[0].className = "btcaption";
	//document.getElementsByName('btnFlowIntervention')[0].className = "btcaption";
	
	display.className = "btcaption-selected";
	switch (display.name){ 
		case "btnBasicInfo": frames["frame"].location.href="<s:url value='/saas/admin/domain/basicInfo.action'/>?id=<%=request.getParameter("id") %>&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>";break;
		case "btnUser": frames["frame"].location.href="<s:url value='/saas/admin/user/list.action'/>?domain=<%=request.getParameter("id") %>&_orderby=orderByNo";break;
		case "btnDept": frames["frame"].location.href="<s:url value='/saas/admin/department/list.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnApps": frames["frame"].location.href="<s:url value='/saas/admin/domain/holdApp.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnAdns": frames["frame"].location.href="<s:url value='/saas/admin/domain/holdAdmin.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnWkCld": frames["frame"].location.href="<s:url value='/saas/admin/calendar/calendarlist.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnMltLng": frames["frame"].location.href="<s:url value='/saas/admin/multilanguage/list.action'/>?domain=<%=request.getParameter("id") %>&s_domainid=<%=request.getParameter("id") %>";break;
		//case "btnUserFormExtends": frames["frame"].location.href="<s:url value='/saas/admin/fieldextends/list.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnNetworkDisk": frames["frame"].location.href="<s:url value='/saas/admin/networkdisk/networkList.action'/>?domain=<%=request.getParameter("id") %>&s_domainid=<%=request.getParameter("id") %>";break;
		//case "btnLog": frames["frame"].location.href="<s:url value='/saas/admin/logger/list.action'/>?domain=<%=request.getParameter("id") %>";break;
		//case "btnFlowIntervention": frames["frame"].location.href="<s:url value='/saas/admin/workflow/storage/runtime/intervention/list.action'/>?domain=<%=request.getParameter("id") %>";break;
	} 
}

jQuery(document).ready(function(){
	var id='<%=id %>';
	jQuery("#frame").attr("src","<s:url value='/saas/admin/domain/basicInfo.action'/>?id="+id + '&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>&sm_name=<s:property value="%{#parameters.sm_name}"/>&sm_users.loginno=<s:property value="%{#parameters[\'sm_users.loginno\']}"/>');
	//adjustContentTable();
	
	//调用函数
	var pagestyle = function() {
		var iframe = jQuery("#frame"); 
		var w = jQuery(document).width(); 
		var documentH = jQuery(document).height();
		iframe.width(w); 
		iframe.height(documentH - 27 ); 
	}
	//注册加载事件 
	jQuery("#frame").load(pagestyle); 
	//注册窗体改变大小事件 
	jQuery(window).resize(pagestyle); 

});

</script>
<body style="vertical-align: top; margin: 0;padding: 0;">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	<tr valign="top" style="height:27px;">
			<td align="left" valign="bottom" >
			<table cellpadding="0" border="0" cellspacing="0" width="100%">
				<tr style="height:27px;" valign="bottom">
				<td  align="left" valign="bottom" class="nav-td">
				<div id="container">
				<div id="rollbox" class="rollbox">
				<div id="content">
				<div class="listContent" style="padding-left: 5px;"><input type="button"  name="btnBasicInfo" class="btcaption-selected" onClick="change(this)" value="{*[BasicInfo]*}"/></div>
				<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
				<div class="listContent"><input type="button"  name="btnDept" class="btcaption" onClick="change(this)" value="{*[Departments]*}"/></div>
				<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
				<div class="listContent"><input type="button"  name="btnUser" class="btcaption" onClick="change(this)" value="{*[Users]*}"/></div>
				<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>
				
				<!-- div class="listContent"><input type="button"  name="btnApps" class="btcaption" onClick="change(this)" value="{*[Applications]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div -->
				<!-- div class="listContent"><input type="button"  name="btnAdns" class="btcaption" onClick="change(this)" value="{*[Administrators]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div -->
				<!-- div class="listContent"><input type="button"  name="btnMltLng" class="btcaption" onClick="change(this)" value="{*[MultiLanguages]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div-->
				<!-- div class="listContent"><input type="button"  name="btnWkCld" class="btcaption" onClick="change(this)" value="{*[WorkCalendar]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div -->
				<!-- div class="listContent"><input type="button"  name="btnUserFormExtends" class="btcaption" onClick="change(this)" value="{*[field.extends.menu]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div -->
				
				<!--<div class="listContent"><input type="button"  name="btnNetworkDisk" class="btcaption" onClick="change(this)" value="{*[NetworkDisk]*}"/></div>-->
				<!--<div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div>-->
				<!-- div class="listContent"><input type="button"  name="btnLog" class="btcaption" onClick="change(this)" value="{*[log.operation.log]*}"/></div -->
				<!-- div class="listContent nav-seperate"><img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" /></div -->
				<!-- div class="listContent"><input type="button"  name="btnFlowIntervention" class="btcaption" onClick="change(this)" value="{*[core.workflow.storage.runtime.intervention.name]*}"/></div -->
				</div>
				</div>
				</div>
				</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<iframe scrolling="auto" style="overflow: auto;height:100%; width: 100%;" id="frame" name="frame" onload="this.width=frame.document.body.scrollWidth"
					src="" frameborder="0"></iframe>
			</td>
		</tr>
</table>
</body>
</o:MultiLanguage></html>
