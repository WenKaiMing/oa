<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
	String changeUserName = (String)request.getAttribute("changeUserName");
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.editPersonal.user_management]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value='/script/help.js'/>"></script>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/dtree.js"/>'></script>
<script type="text/javascript">
	jQuery(document).ready(function(){
		window.top.toThisHelpPage("superuser_info");

		var changeUserName = '<%=changeUserName%>';
		if(changeUserName == 'true'){
			var tempName = document.getElementsByName("content.name")[0].value;
			window.parent.document.getElementById("username").innerText = tempName;
		}
	});

	function ev_exit(){
		var url = '<%=basePath%>';
		url = url + 'admin/detail.jsp';
		location.href = url;
	}

	//function changeUserName(){
	//	alert(1);
	//	var tempName = document.getElementsByName("content.name")[0].value;
	//	window.parent.document.getElementById("username").innerText = tempName;
	//}
</script>
</head>
	
<body id="superuser_info">
<s:form name="formItem" action="savePersonal" method="post" validate="true" theme="simple">
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.superuser.super_user_information]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="btnSave" title="{*[Save]*}" class="justForHelp button-image" onClick="forms[0].submit();">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" class="ustForHelp button-image" title="{*[Exit]*}" onClick="ev_exit()">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>" align="top">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<div id="contentMainDiv" class="contentMainDiv">
		<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
		<input type="hidden" name="_currpage" value='<s:property value="#parameters['_currpage']"/>' />
		<input type="hidden" name="_pagelines" value='<s:property value="#parameters['_pagelines']"/>' />
		<input type="hidden" name="_rowcount" value='<s:property value="#parameters['_rowcount']"/>' />
		<s:hidden name="content.id" />
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<table width="100%" border="0" class="id1">
			<tr>
				<td class="label-td">{*[User_Name]*}: </td>
				<td class="label-td">{*[Account]*}: </td>
			</tr>	
			<tr>	
				<td id="SuperUser_Name" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_name]*}" class="justForHelp"> 
					<s:textfield cssClass="input-cmd" label="%{getText('core.user.username')}" name="content.name" /></td>
				<td id="SuperUser_Account" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_account]*}" class="justForHelp">
					<s:textfield cssClass="input-cmd" readonly="true" label="%{getText('core.user.loginno')}" name="content.loginno" /></td>
			</tr>
			<tr>
				<td class="label-td">{*[Password]*}: </td>
				<td class="label-td">{*[Email]*}: </td> 
			</tr>
			<tr>
				<td class="label-td" id="SuperUser_Password" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_password]*}">
					<s:password cssClass="input-cmd" label="%{getText('core.user.loginpwd')}" name="_password"  show="true"/></td>
				<td class="label-td" id="SuperUser_Email" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_email]*}" class="justForHelp">
					<s:textfield cssClass="input-cmd" label="%{getText('core.user.email')}" name="content.email" /></td>	
			</tr>
    	</table>  
	</div>            
</s:form>
</body>
</o:MultiLanguage></html>
