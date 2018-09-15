<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.util.Security" %>
<%@ page import="cn.myapps.util.WebCookies" %>
<%@ page import="java.util.Calendar" %>
<%
String handleUrl = (String) request.getAttribute("handleUrl");
WebCookies webCookies=new WebCookies(request,response,WebCookies.ENCRYPTION_URL);
Object obj = request.getAttribute("showCode");
String rt_domainname = request.getParameter("domainName");
String rt_username = request.getParameter("_ac");
String failtoLogin = (String)request.getAttribute("failtoLogin");
boolean showCode = false;
if (obj != null) {
	showCode = ((Boolean)obj).booleanValue();
}

Cookie[] cookies = request.getCookies();

Cookie domainName = null;
Cookie account = null;
Cookie password = null;
Cookie keepinfo = null;

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().equals("domainName")) {
			domainName = cookies[i];
		} else if (cookies[i].getName().equals("account")) {
			account = cookies[i];
		} else if (cookies[i].getName().equals("password")){
			password= cookies[i];
		}else if (cookies[i].getName().equals("keepinfo")) {
			keepinfo = cookies[i];
		}
	}
}
String dn = "";
String ac = "";
String pw = "";
String ki = "";
if (rt_domainname != null) {
	dn = rt_domainname;
}else if (domainName != null) {
	dn = webCookies.getValue(domainName.getName());
}
if (rt_username != null){
	if(rt_username!=null && rt_username.length()>2){
		String lp = rt_username.substring(0, rt_username.length()-2);
		String rp = rt_username.substring(rt_username.length()-2,rt_username.length()); 
		rt_username = Security.decodeBASE64(rp+lp);
	}
	ac = rt_username;
}else if (account != null) {
	ac = webCookies.getValue(account.getName());
}
if(failtoLogin == null){
	if (password != null) {
		pw = webCookies.getValue(password.getName());
	}
}
if (keepinfo != null) {
	ki =webCookies.getValue(keepinfo.getName());
}
%>

<s:bean name="cn.myapps.core.security.action.LoginHelper" id="lh" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<s:bean name="cn.myapps.core.security.action.LoginHelper" id="lh" />
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<title>登录</title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link href='<s:url value="/portal/phone/resource/css/ratchet.min.css"/>' rel="stylesheet">
<link href='<s:url value="/portal/phone/resource/css/animate.css"/>' rel="stylesheet">
<link href='<s:url value="/portal/phone/resource/css/global.css"/>' rel="stylesheet">
<script src='<s:url value="/portal/phone/resource/js/jquery-1.11.3.min.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/ratchet.min.js"/>'></script>
<script src='<s:url value="/portal/share/script/login.js"/>'></script>
<script type="text/javascript">
function getBrowserInfo(){
	var agent = navigator.userAgent.toLowerCase() ;
	var regStr_ie = /msie [\d.]+;/gi ;
	var regStr_ff = /firefox\/[\d.]+/gi
	var regStr_chrome = /chrome\/[\d.]+/gi ;
	var regStr_saf = /safari\/[\d.]+/gi ;
	//IE
	if(agent.indexOf("msie") > 0){
		return agent.match(regStr_ie) ;
	}

	//firefox
	if(agent.indexOf("firefox") > 0){
		return agent.match(regStr_ff) ;
	}

	//Chrome
	if(agent.indexOf("chrome") > 0){
		return agent.match(regStr_chrome) ;
	}

	//Safari
	if(agent.indexOf("safari") > 0 && agent.indexOf("chrome") < 0){
		return agent.match(regStr_saf) ;
	}
}

/*错误提醒*/
function errorHide(){
	var errorText =  $('#errorMessage').text();
	if(errorText != ""){
		$('#errorCon').attr("style","");
		$('#errorCon').css("dispaly","block");
		setTimeout(function(){
			$('#errorCon').removeClass("bounceInDown").addClass("fadeOutUp");
		},5000)
	}
}

function CheckForm(){
   return true;
}

$(function(){
	var browser = window.navigator.userAgent.toLowerCase();
	var verinfo = (browser+"").replace(/[^0-9.]/ig,""); 
	errorHide();
});
</script>
<style type="text/css">
body,html{
    background: url('<s:url value="/portal/phone/resource/images/login-bg.jpg"/>');
    background-size: cover; 
    background-attachment: fixed; 
}
.errorCon{
	color: #fff;
    background: rgba(0, 0, 0, 0.55);
}

.errorMsg{
	padding: 10px;
}
</style>
</head>
<body onload="javascript:document.form1._ac.focus();" scroll="auto" class="login">
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<s:form name="form1" method="post" action="/portal/login/loginWithCiphertext.action" autocomplete="off" onsubmit="return CheckForm();" theme="simple" role="form">
<div class="errorCon animated bounceInDown" id="errorCon" style="display:none;">
    <div class="errorMsg">
		<s:if test="hasFieldErrors()">
			<span class="errorMessage" id="errorMessage"> 
			<b style="display:block;">
			<s:iterator value="fieldErrors">
				<s:property value="value[0]"/><br/>
				<s:if test="value[0] == '{*[core.domain.notexist]*}'">
					<script>
						//focusOn(document.getElementsByName('domainName')[0]);
					</script>
				</s:if>
				<s:elseif test="value[0] == '{*[core.user.notexist]*}'">
					<script>
						//focusOn(document.getElementsByName('_ac')[0]);
					</script>
				</s:elseif>
				<s:elseif test="value[0] == '{*[core.security.character.error]*}'">
					<script>
						//focusOn(document.getElementsByName('checkcode')[0]);
					</script>
				</s:elseif>
				<s:else>
					<script>
						//focusOn(document.getElementsByName('password')[0]);
					</script>
				</s:else>
			</s:iterator>
			</span>
		</s:if>
	</div>
</div> 

<div class="box">
	<div class="logo"><img src="../share/images/logo/logo-phone.png" /></div>
	<div class="login-title">天翎办公系统</div>
	<div class="login-content">
		
			<input type="hidden" id="_skinType" name="_skinType" value="" />
			<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
			<s:hidden name="_showCode" value="%{#request.showCode}" />
			<s:if test="#parameters.debug">
			<s:hidden name="debug" value="%{#parameters.debug}" id="debug" />
			</s:if>
			<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>
			<input type="hidden" name="domainName"  value="<s:property value='#lh.getDomainNameList().get(0)'/>">
			<!-- FIXME 临时解决方案 -->
			<input type="hidden" name="browserType" value="phone" />
	
			<div class="form-group">
				<i class="icon iconfont">&#xe600;</i>
				<input type="text" name="_ac" onmouseover="this.focus()" onfocus="this.select()" value="" class="form-control username" />
			</div>
			<div class="form-group">
				<i class="icon iconfont">&#xe601;</i><input type="password" class="form-control password" name="_pd" onmouseover="this.focus()" onfocus="this.select()" value="" />
	  		</div>
		 	<!--  <div class="form-group">
		    	<i class="vcode-icon">码</i><img src="./resource/images/t005.png"><input type="text" class="form-control vcode" >
		 	</div> -->
	  		<button onclick="login_ing(this)" type="submit" class="btn btn-login">登 录</button>
			<!-- <div class="checkbox text-center">
				<label><input type="checkbox" value="">记住密码</label>
			</div> -->
		
	</div>
</div>
<div class="copyright">Copyright © 2013 TEEMLINK<br/>广州市天翎网络科技有限公司 版权所有</div>
</s:form>
</body>
</html>
</o:MultiLanguage>