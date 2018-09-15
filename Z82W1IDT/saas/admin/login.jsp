<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="java.util.Calendar" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
Calendar cld = Calendar.getInstance();
int currentYear = cld.get(Calendar.YEAR);
Object obj = request.getAttribute("showCode");
boolean showCode = false;
if (obj != null) {
	showCode = ((Boolean)obj).booleanValue();
}
%>

<%@page import="sun.security.jca.GetInstance"%><html>
<o:MultiLanguage>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<head>
<title>{*[page.title]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>'
	type="text/css" />
<style type="text/css">
.login-label {
	font-size: 12px;
	background-image: none;
}
.code-input {
	width: 46px;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	margin: 1px;
	padding: 1px;
}

</style>
<script type="text/javascript">
function ev_submit() {
	document.getElementById("loginform").submit();
}

function changeLanguage(){
		
		document.forms[0].action = "<s:url value='/saas/multilanguage/changeLanguage.action' />" + "?showCode=" + "<%=showCode %>";
		document.forms[0].submit();
}

function showTips(obj) {
	var tipsArea = document.getElementById("tipsArea");
	
	obj.style.border = "1px; solid #016BC9";
	
	var style = "font-size:12px; color:blue;"
	
	var tips = "";
	
	switch(obj.name) {
		case "username" : tips = "{*[page.login.account]*}";break;
		case "password" : tips = "{*[page.login.password]*}";break;
		case "checkcode" : tips = "{*[page.login.character]*}";break;
		default : tipsArea.innerHTML = "&nbsp;";
	}
	
	tipsArea.innerHTML = "<font style='" + style + "'>" + tips + "</font>"; 
}

function disableTips(obj) {
	obj.style.border = "1px solid #999999";
	
	var tipsArea = document.getElementById("tipsArea");
	tipsArea.innerHTML = "&nbsp;";
}
function getSecurityCode() {
	var numkey = Math.random();
	document.getElementById("checkCodeImg").src = '<s:url value="/checkCodeImg"/>?num=' + numkey;
}
</script>
</head>
<body bgcolor=#FFFFFF>
<s:form id="loginform" action="/saas/admin/login.action" method="POST" theme="simple">
<table style="width:100%; text-align:right">
	<tr style="vertical-align: middle;">
		<td><font style="font-size:12px; padding-right:11px; vertical-align: middle"><img  src='<s:url value="/resource/imgnew/button_arrow.gif"/>' />&nbsp;{*[Language]*}:</font><s:select name = "language" list="#mh.getTypeList()" value="#mh.getType(#session.USERLANGUAGE)" theme="simple" onchange="changeLanguage()" /></td>
	</tr>
</table>
<div align="center">
<table  width="812" border=0 cellpadding=0 cellspacing=0 style="background-image:url(<s:url value='/resource/imgnew/login/background.gif' />)">
	<tr>
		<td colspan="3" align="center" style="height:150px;"><img src="<s:url value='/resource/imgnew/login/logobanner.gif' />" alt="Teemlink.com" /></td>
	</tr>
	<tr style="height:363px;">
		<td width="225">&nbsp;</td>
		<td valign="top">
			<table cellpadding="0" cellspacing="0" border=0 width="363" style="height:228px; margin:0px;background-image:url(<s:url value='/resource/imgnew/login/main_login.gif' />);vertical-align: top;">
				<tr>
					<td colspan="3" style="height:40px;">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td width="25px">&nbsp;</td>
					<td>
					
					<!-- Login table -->
						<table style="width:100%; weight: 100%;text-align: left;" cellpadding="0" cellspacing="0">
							<tr valign="middle">
								<td style="text-align:right;">
								<table style=" margin:20px; padding:0px;text-align: right;" cellpadding="2" cellspacing="0">
									<tr style="margin: 4px;">
										<td class="login-label" style="padding-right:8px;">{*[Account]*}:</td><td colspan="2"><s:textfield onblur="disableTips(this)" onfocus="showTips(this)" cssStyle="height:20px;width:120px;" cssClass="login-input" name="username" /></td>
									</tr>
									<tr style="margin: 4px;">
										<td class="login-label" style="padding-right:8px;">{*[Password]*}:</td><td colspan="2"><s:password onblur="disableTips(this)" onfocus="showTips(this)" cssStyle="height:20px;width:120px;" cssClass="login-input" name="password" /></td>
									</tr>
									<%if (showCode) { %>
									<tr style="margin: 4px;">
										<td class="login-label" style="padding-right:8px;">{*[Characters]*}:</td><td style="text-align:left"><s:textfield onblur="disableTips(this)" onfocus="showTips(this)" cssClass="code-input" cssStyle="height:20px;" name="checkcode" /></td><td><img src="<s:url value="/checkCodeImg"/>" align="absmiddle" onclick="getSecurityCode();" width="70" height="26" id="checkCodeImg" /></td>
									</tr>
									<%} %>
								</table>
								</td>
								<td>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td rowspan="3"><input type="image" src="<s:url value='/resource/imgnew/login/submit.gif' />" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2"><div style="height:20px;padding-left:60px;padding-top: 5px;" id="tipsArea">&nbsp;</div></td>
							</tr>
						</table>
					<!-- End of Login table -->
					</td>
					<td width="29px">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3" style="height:16px;">&nbsp;</td>
				</tr>
			</table>
			<br/>
			
			<!-- Show the Errors -->
			<div align="left">
				<s:if test="hasFieldErrors()">
					<span class="errorMessage"> 
					<table><tr>
					<td valign="top">
						<b>{*[Errors]*}:</b>
					</td>
					<td>
						<s:iterator value="fieldErrors">
							*<s:property value="value[0]" />;<br/>
						</s:iterator>
					</td>
					</tr></table>
					</span>
				</s:if>
			</div>
			
		</td>
		<td width="224">&nbsp;</td>
	</tr>
	<!-- Copy right -->
	<tr>
		<td colspan="3" align="center"><p id="copyright"> &copy; 2009-<%=currentYear %>. <a href="http://www.teemlink.com" target="_blank" title="广东天翎"><b>{*[page.website]*}</b></a> {*[myapps.All.rights.reserved]*}.</p></td>
	</tr>
</table>
</div>
</s:form>
</body>
</o:MultiLanguage></html>