<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.util.Security" %>
<%@ page import="cn.myapps.util.WebCookies" %>
<%@ page import="java.util.Calendar" %>
<%
String handleUrl = (String) request.getAttribute("handleUrl");
WebCookies webCookies=new WebCookies(request,response,WebCookies.ENCRYPTION_URL);
Object obj = request.getAttribute("showCode");
String rt_username = request.getParameter("username");
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
		if (cookies[i].getName().equals("_dn")) {
			domainName = cookies[i];
		} else if (cookies[i].getName().equals("_ac")) {
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
if (domainName != null) {
	dn = webCookies.getValue(domainName.getName());
}
if (rt_username != null){
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
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE HTML>
<html>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<s:bean name="cn.myapps.core.security.action.LoginHelper" id="lh" />
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<title>{*[page.title]*}</title>
<link rel="stylesheet" href='<s:url value="/portal/share/css/loginInDialog.css"/>'	type="text/css" />
<style type="text/css">

</style>

<script type="text/javascript">
	var contextPath = '<%=request.getContextPath()%>';
	function getSecurityCode() {
		var numkey = Math.random();
		document.getElementById("checkCodeImg").src = '<s:url value="/checkCodeImg"/>?num=' + numkey;
	}
	var showCode = '<%=showCode%>';
	function init(){
		if(showCode==true || showCode =="true"){
			getSecurityCode();
		}
	}

	function changeusername(val){
		if(val == '<%=ac%>'){
			if('' != '<%=pw%>'){
				document.getElementsByName("password")[0].value = '<%=pw%>';
			}
		}else {
			document.getElementsByName("password")[0].value = "";
		}
	}
</script>
<script src='<s:url value="/portal/share/script/login.js"/>'></script>
<script src='<s:url value="/portal/share/script/iepngfix_tilebg.js"/>'></script><!--png24图片兼容ie6 -->
</head>
<body id="bodyid" onload="init()">
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<s:form id="loginform" action="/portal/login/loginInDialog.action" method="POST" theme="simple" autocomplete="off">
<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
<s:hidden name="_showCode" value="%{#request.showCode}" />
<s:hidden name="debug" value="%{#parameters.debug}" id="debug" />
<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>

<table class="container ">
	<tr>
		<td align="center">
		    <div class="login-box animated fadeInDown">
			    <div class="login">
			        <div class="logo">
						<div class="logo-pic loginBg"></div>
						<p class="title">开启微信办公新时代</p>
					</div>
			    	<!--<ul class="titleName">
			        	<li class="english">myApps|OBPM</li>
			            <li class="chinese">流程管理平台</li>
			        </ul>-->
			        <ul class="loginInfo">
			        	<li class="domainLi">
			        		<div class="form-group">
			        			<i class="icon iconfont" style="font-size:18px;">&#xe616;</i>
					        	<!--<span>{*[Domain]*}：</span>-->
					        	 <div class="selectdoMain">
					        	 	<input class="form-control" placeholder="{*[Domain]*}" type="text"  value="<%=dn %>" name="domainName" readonly="readonly"/>
					        	 </div>       	 
				        	 </div>
			        	</li>
			        	 
			            <li class="zIndex98">
			           		<div class="form-group">
								<i class="icon iconfont">&#xe600;</i>
								<input type="text" class="form-control userName" placeholder="{*[Account]*}"  value="<%=ac %>" name="username" readonly="readonly" onkeyup="changeusername(this.value);"/>
							</div>
							<div class="tipsdiv_name" id="tipsdiv_name"><div class="easytip-text" id="easytip-text"></div><div class="easytip-arrow"></div></div>
			            </li>
			            <li class="zIndex98">
			            	<div class="form-group">
								<i class="icon iconfont">&#xe601;</i>
								<!--<span></span><input type="password"  id="signup_password" placeholder="密码" class="form-control password" name="password" type="password" id="psw1" easyform="length:6-16;" message="密码必须为6—16位" easytip="disappear:lost-focus;theme:blue;" value="<%=pw %>" autocomplete="off"/>-->			
								<input class="form-control password" placeholder="{*[Password]*}" type=password name=password  value="<%=pw %>" name="password" autocomplete="off"/>
							</div>
			            </li>
			           	<%if (showCode) { %>
							<li class="checkCode zIndex98">
								<div class="form-group" style="positon:relative;overflow:hidden;">
									<span>{*[Character]*}：</span>
									<s:textfield theme="simple" onblur="disableCodeTips(this)" name="checkcode" />
									<img src="<s:url value="/checkCodeImg"/>" align="absmiddle" onclick="getSecurityCode();" width="70" height="26" id="checkCodeImg" />
									<span class="invisibility" onclick="getSecurityCode()">看不清</span>
								</div>
								<div class="tipsdiv-code" id="tipsdiv_code"><div class="easytip-text" id="easyCodetip-text"></div><div class="easytip-arrow"></div></div>
							</li>
						<%}else{ %>
							<li class="notcheckCode">
							</li>
						<%} %>
			            <li class="keepInfo zIndex98">

			            	<%if(ki.equals("yes")){ %><input type="checkbox" name="keepinfo" value="yes" checked="checked" /><%} else { %><input type="checkbox" name="keepinfo" value="yes"/><%} %>{*[page.login.keeppwd]*}
			            </li> 
			            <!--<li class="tipsArea"><div id="tipsArea">&nbsp;</div></li>-->           
			            <li class="btnOk"><input type="submit"  onclick="login_ing(this)" id="tijiao" alt="{*[Login]*}" value="{*[Login]*}" class="btn-login loginBg" easyform="length:6-16;" message="请输入密码" easytip="disappear:lost-focus;theme:blue;"/></li>
			        </ul>
			    </div>
			</div>
		    <div class="errorMsg">
				<s:if test="hasFieldErrors()">
					<span class="errorMessage"> 
					<b>{*[Errors]*}:</b><br />
					<s:iterator value="fieldErrors">
						*<s:property value="value[0]" />;<br/>
						<s:if test="value[0] == '{*[page.login.infoerror]*}'">
							<script>
								focusOn(document.getElementsByName('password')[0]);
							</script>
						</s:if>
						<s:if test="value[0] == '{*[core.user.notexist]*}'">
							<script>
								focusOn(document.getElementsByName('username')[0]);
							</script>
						</s:if>
						<s:if test="value[0] == '{*[core.domain.notexist]*}'">
							<script>
								focusOn(document.getElementsByName('domainName')[0]);
							</script>
						</s:if>
						<s:if test="value[0] == '{*[core.user.noteffective]*}'">
							<script>
								focusOn(document.getElementsByName('domainName')[0]);
							</script>
						</s:if>
					</s:iterator>
					</span>
				</s:if>
			</div>
    	</td>
	</tr>
</table>
</s:form>
</body>
</html>
</o:MultiLanguage>
