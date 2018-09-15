<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
String handleUrl = (String) request.getAttribute("handleUrl");
Object obj = request.getAttribute("showCode");
boolean showCode = false;
if (obj != null) {
	showCode = ((Boolean)obj).booleanValue();
}

Cookie[] cookies = request.getCookies();

Cookie domainName = null;
Cookie account = null;
Cookie keepinfo = null;

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().equals("domainName")) {
			domainName = cookies[i];
		} else if (cookies[i].getName().equals("account")) {
			account = cookies[i];
		} else if (cookies[i].getName().equals("keepinfo")) {
			keepinfo = cookies[i];
		}
	}
}
String dn = "";
String ac = "";
String ki = "";
if (domainName != null) {
	dn = domainName.getValue();
}
if (account != null) {
	ac = account.getValue();
}
if (keepinfo != null) {
	ki = keepinfo.getValue();
}



%>
<o:MultiLanguage>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<head>
<title>{*[page.title]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href='<s:url value="/resource/css/main-front.css"/>'
	type="text/css" />
<style type="text/css">
.login-label {
	font-size: 12px;
	background-image: none;
	text-align: right;
	font-weight: bold;
	padding-right: 8px;
	color: #06547a;
}
.code-input {
	width: 46px;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	margin: 1px;
	padding: 1px;
}

ul{margin:35px;padding:0px;}

#container {margin: auto;}
#header {border:0 solid white;width:100%;background-image:url(<s:url value='/resource/imgv2/front/login/banner.gif' />);background-repeat:repeat-x;}
#content {width: 602px;height: 246px; margin-top:100px; text-align:center;}
#content_login td {vertical-align: middle;}
#content_text {width:329px;background-image: url(<s:url value='/resource/imgv2/front/login/content_text.gif' />);}
#content_login {width:274px;background-image: url(<s:url value='/resource/imgv2/front/login/content_login.gif' />)}
#content_text ul{padding-left:30px; color: #249ed1;}
#content_text li {padding-bottom:5px;}
#copyright {color: 999999; text-align: center;}

#footer {margin-top: 100px;}
.btn_login {
	width: 77px; 
	height: 26px; 
	background-image: url(<s:url value='/resource/imgv2/front/login/btn_back.gif' />);
	border: 0px solid #fff;
	cursor: pointer;
	font-size: 14px;
	color: white;
	font-family: Arial, "黑体" ;
}

.login-tr {
	height:25px;
}

</style>
<script>
function showTips(obj) {
	var tipsArea = document.getElementById("tipsArea");
	obj.style.border = "1px; solid #016BC9";
	var style = "font-size:12px; color:blue;";
	var tips = "";
	switch(obj.name) {
		case "username" : tips = "{*[page.login.account]*}";break;
		case "password" : tips = "{*[page.login.password]*}";break;
		case "domainName" : tips = "{*[page.login.domain]*}";break;
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

function changeLanguage(){
		document.forms[0].action = "<s:url value='/core/multilanguage/change.action' />";
		document.forms[0].submit();
}	

</script>
</head>
<body bgcolor="#ffffff" style="margin:0px; text-align: center; overflow: hidden;">
<s:form id="loginform" action="/login.action" method="POST" theme="simple">
<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>
<div align="center" id="container">
<table cellpadding="0" cellspacing="0" border="0" id="header">
	<tr>
		<td style="width:304px;"><img src="<s:url value='/resource/imgv2/front/login/logo.gif' />" />
		</td>
		<td style="text-align:right; color:white; padding-right:20px;">
			{*[Language]*}:<s:select name = "language" list="#mh.getTypeList()" value="#mh.getType(#session.USERLANGUAGE)" theme="simple" onchange="changeLanguage()" />
		</td>
	</tr>
</table>

<table id="content" cellpadding="0" cellspacing="0">
	<tr>
		<td id="content_text">
			<table cellpadding="0" cellspacing="0" style="width:100%; height:100%">
				<tr style="height: 80px;">
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<ul>
							<li>面向最终用户，简单易用</li>
							<li>并非从零开始，引用成功案例</li>
							<li>自我进化，不断完善</li>
							<li>支持手机等智能设备接入</li>
						</ul>
					</td>
				</tr>
			</table>
		</td>
		<td id="content_login">
			<table cellpadding="0" cellspacing="0" style="height:100%;width:100%;">
				<tr style="height: 56px;">
					<td style="font-size: 14px; color:#1268a5;padding-left:80px;"><b>{*[User]*}{*[Login]*}</b></td>
				</tr>
				<tr>
					<td>
						<table id="login_table"  style="width: 100%;" cellpadding="0" cellspacing="0">
							
							<tr class="login-tr">
								<td  class="login-label">{*[Domain]*}:</td><td><s:textfield cssStyle="width:120px;" theme="simple" onblur="disableTips(this)" onfocus="showTips(this)" value="<%=dn %>" cssClass="login-input" name="domainName" /></td>
							</tr>
							<tr class="login-tr">
								<td  class="login-label">{*[Account]*}:</td><td><s:textfield onblur="disableTips(this)" theme="simple"  onfocus="showTips(this)" value="<%=ac %>" cssStyle="width:120px;" cssClass="login-input" name="username" /></td>
							</tr>
							<tr class="login-tr">
								<td  class="login-label">{*[Password]*}:</td><td><s:password cssStyle="width:120px;" theme="simple"  onblur="disableTips(this)" onfocus="showTips(this)" cssClass="login-input" name="password" /></td>
							</tr>
							<%if (showCode) { %>
							<tr class="login-tr">
								<td class="login-label">{*[Character]*}:</td><td align="left"><s:textfield cssStyle="width:46px;" theme="simple"  onblur="disableTips(this)" onfocus="showTips(this)" cssClass="code-input" name="checkcode" /><img src="<s:url value="/checkCodeImg"/>" align="absmiddle" onclick='this.src="<s:url value="/checkCodeImg"/>"' width="70" height="22" /></td>
							</tr>
							<%} %>
							<tr class="login-tr">
								<td>&nbsp;</td><td style="color:#729db3;"><%if(ki.equals("yes")){ %><input type="checkbox" name="keepinfo" value="yes" checked="checked" /><%} else { %><input type="checkbox" name="keepinfo" value="yes"/><%} %>{*[page.login.keepinfo]*}</td>
							</tr>
							<tr class="login-tr">
								<td colspan="2"><div style="padding-left:40px;" id="tipsArea">&nbsp;</div></td>
							</tr>
							<tr style="vertical-align: top;">
								<td colspan="2" style="text-align: center;">
									<input type="submit" alt="{*[Login]*}" value="{*[Login]*}" class="btn_login" />
									<input type="button" alt="{*[Reset]*}" onClick="reset();" value="{*[Reset]*}" class="btn_login" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div>
	<s:if test="hasFieldErrors()">
		<span class="errorMessage"> 
		<b>{*[Errors]*}:</b><br />
		<s:iterator value="fieldErrors">
			*<s:property value="value[0]" />;<br/>
		</s:iterator>
		</span>
	</s:if>
</div>
<table id="footer">
	<tr>
		<td>
			<p id="copyright"> &copy; 2009. <a href="http://www.teemlink.com" target="_blank" title="广东天翎"><b>{*[page.website]*}</b></a> {*[myapps.All.rights.reserved]*}.</p>
		</td>
	</tr>
</table>
</div>
</s:form>
</body>
</html>
</o:MultiLanguage>
