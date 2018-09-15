<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
	String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<title>{*[core.email.transport]*}</title>

<script type="text/javascript">
var agrs = OBPM.dialog.getArgs();
var actid = agrs['_activityid'];
var docid = agrs['docid'];
var formid = agrs['formid'];
var transpond = agrs['transpond'];
var signatureExist = agrs['signatureExist'];

window.onload = function(){
	var application = document.getElementById('application').value;
	var queryString = "_docid=" + docid + "&_formid=" + formid + "&application=" + application + "&signatureExist=" + signatureExist + "&mode=email";
	document.getElementById('handleUrl').value = '<%= contextPath%>' + '/portal/dynaform/document/view.action?' + queryString;
};

function selectUsers(id,name){
	var settings={"valueField":id,"textField":name};
	showUserSelectNoFlow("",settings,"");
} 

function sendemail(){
	if(!validate()){
		return;
	}
	document.forms[0].action = contextPath + '/portal/dynaform/activity/handle.action' + '?_activityid=' + actid + '&_docid=' + docid + '&_formid=' + formid + '&transpond=' + transpond;
	document.forms[0].submit();
}

function validate(){
	var _email = document.getElementsByName('email')[0].checked;
	var _msm = document.getElementsByName('msm')[0].checked;
	var _receivername = document.getElementById('receivername').value;

	if(!_email && !_msm){
		alert("{*[core.dynaform.form.activity.transpond.way]*}");
		return false;
	}

	if(_receivername == ''){
		alert("{*[core.dynaform.form.activity.transpond.people]*}");
		return false;
	}

	return true;
}
</script>
</head>
<body>

<s:form name="sendemailform" action="send" method="post">
<input type="hidden" name="application" id="application" value='<%=request.getParameter("application")%>'/>
<input type="hidden" name="handleUrl" id="handleUrl" value="" />
<table  style="width:100%">
	<tr>
		<td>
			<div style="width: 500px;">
				<div class="button-cmd" style="float:left;">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="sendicon" href="#" onclick="sendemail();">
							{*[Send]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>
				<div class="button-cmd" style="float:left;">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="exiticon" href="#" onclick="OBPM.dialog.doReturn();">
							{*[Exit]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset>
				<table width="100%" height="100%" align="center">
					<tr>
						<td style="width:50px;"><s:checkbox name="email" id="email" value="false" theme="simple"/>{*[E-mail]*}</td>
						<td><s:checkbox name="msm" id="msm" value="false" theme="simple"/>{*[Mobile]*}{*[Message]*}</td>
					</tr>
					<tr>
						<td>{*[Receiver]*}：</td>
						<td>
							<s:textfield id="receivername" name="receivername" cssStyle="width: 530px;" theme="simple"/>
							<s:hidden id="receiverid" name="receiverid"  theme="simple"/>
							<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#receiverid').attr('id'),jQuery('#receivername').attr('id'))" title="{*[Choose]*}{*[User]*}"/>
						</td>
					</tr>
				</table>
			</fieldset>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>