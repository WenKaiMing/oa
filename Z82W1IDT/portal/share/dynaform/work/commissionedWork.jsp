<%@ page pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String docid = request.getParameter("docid");
	String applicationId=request.getParameter("application");
%>

<%@page import="java.util.ArrayList"%>
<%@page import="cn.myapps.core.macro.runner.IRunner"%>
<%@page import="cn.myapps.core.macro.runner.JavaScriptFactory"%>
<%@page import="java.net.URLDecoder"%><o:MultiLanguage
	value="FRONTMULTILANGUAGETAG">
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<o:Url value='/resource/css/style.jsp'/>" />
	<link rel="stylesheet" href="<o:Url value='/resource/css/dialog.css'/>"
		type="text/css" media="all" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<link rel="stylesheet"
		href='<s:url value="/resource/css/dtree.css" />' type="text/css">
	<script src='<s:url value="/portal/share/script/util.js"/>'></script>
	<script src='<s:url value="/portal/share/script/dtree.js"/>'></script>
	<script language="JavaScript">
var contextPath = '<s:url value="/" />';

//用户确定事件
function doConfirm(){
	var _newActors = document.getElementById("_newActors").value;
	if (_newActors && _newActors.length > 0) {
		OBPM.dialog.doReturn(_newActors);
	} else {
		alert("{*[Choose]*}{*[User]*}");
	}
}


function doCancel(){
	window.close();
}

function init(){
	//OBPM.dialog.resize(document.body.scrollWidth+20, document.body.scrollHeight+70);
	var info = OBPM.dialog.getArgs().info;
	document.getElementById("info_stateLabel").innerHTML = info.stateLabel;
	document.getElementById("info_subject").innerHTML = info.subject;
}

</script>

	<style>
	
A.orgAdd:link, A.orgAdd:visited{
   color:#207BD6;
   padding-left:12px;
   background:url("/resource/images/org_select.png") no-repeat;
   background-position:0px 0px;
}
A.orgAdd:hover, A.orgAdd:active{
   color:#207BD6;
   text-decoration: underline;
}	
	
	
	
.btn-ul {
	list-style-image: none;
	margin-left: 0;
	padding-left: 0;
}

.btn-ul li {
	float: left;
	display: inline;
	word-break: keep-all;
	margin-right: 5px;
	margin-bottom: 3px;
}
</style>
	<title>工作委托</title>
	</head>
	<body onload="init()">
	<s:form id="commissionedWork" name="commissionedWork" action="commissionedWork" method="post" theme="simple">
	<s:token name="token" />
	<s:hidden id="_newActors" name="_newActors" value=""></s:hidden>
	<s:hidden id="applicationid" name="application" value="%{#parameters.application}"></s:hidden>
	<table width="100%" height="100%">
		<tr>
			<td align="center"><input type="button" value="{*[Confirm]*}"
						onClick="doConfirm()" /> <input type="button"
						value="{*[Cancel]*}" onClick="OBPM.dialog.doExit()" />
			</td>
		</tr>
		<tr><td>
				<table width="90%" align="center">
					<tr>
						<td nowrap align="center" class="Big" colspan="2"><b><font id="info_subject"></font> </b></td>
					</tr>
					<tr>
						<td nowrap><font id="info_stateLabel"></font> ({*[core.dynaform.work.label.entrust.current.step]*})</td>
						<td><span style="color: red; font-weight: bold">{*[core.dynaform.work.label.entrust.to]*}：</span>
						<input type="text" name="_newActors_tmp" id="_newActors_tmp" size="10" 
							readonly/>&nbsp; <a href="javascript:;" class="orgAdd"
							onClick="showUserSelectNoFlow('actionName', {textField:'_newActors_tmp', valueField:'_newActors'},'')" title="{*[core.workflow.storage.runtime.proxy.chooseUser]*}">{*[Choose]*}</a></td>

					</tr>
				</table></td></tr>
	</table>
	</s:form>
	</body>
	<script language="JavaScript">
	
</script>
	</html>
</o:MultiLanguage>
