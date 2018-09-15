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
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE HTML >
<html>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<s:bean name="cn.myapps.core.security.action.LoginHelper" id="lh" />
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="renderer" content="webkit">
<!-- webkit|ie-comp|ie-stand : chrome内核|ie兼容内核|ie标准内核 -->

<title>{*[page.title]*}</title>
<link rel="shortcut icon" type="images/x-icon" href="<s:url value='/portal/share/images/logo/logo32x32.ico'/>" media="screen" />
<link rel="stylesheet" href='<s:url value="/portal/share/css/login.css"/>'	type="text/css" />
<link rel="stylesheet" href='<s:url value="/portal/share/css/animate.min.css"/>' type="text/css" />
<script src='<s:url value="/portal/share/script/bootstrap/script/jquery.min.js"/>' ></script>
<script type="text/javascript">
	var contextPath = '<%=request.getContextPath()%>';
	function getSecurityCode() {
		var numkey = Math.random();
		document.getElementById("checkCodeImg").src = '<s:url value="/checkCodeImg"/>?num=' + numkey;
	}
	var showCode = '<%=showCode%>';
	function init(){
		changeWidth();
		if(showCode==true || showCode =="true"){
			getSecurityCode();
		}
	}

	function changeusername(val){
		if(val == '<%=ac%>'){
			if('' != '<%=pw%>'){
				document.getElementsByName("_pd")[0].value = '<%=pw%>';
			}
		}else {
			document.getElementsByName("_pd")[0].value = "";
		}
	}
	
	function getExplorer() {
		var explorer = window.navigator.userAgent ;
		//ie 
		if (explorer.indexOf("MSIE") >= 0) {
			if (explorer.indexOf("MSIE 10") <= 0) {
				$(".skinSelectTxt").show();
				$(".language").css("top","75px")
				$("#_skinType").val("dwz");
			}
		}
		//firefox 
		else if (explorer.indexOf("Firefox") >= 0) {
		}
		//Chrome
		else if(explorer.indexOf("Chrome") >= 0){
		}
		//Opera
		else if(explorer.indexOf("Opera") >= 0){
		}
		//Safari
		else if(explorer.indexOf("Safari") >= 0){
		}
		//alert(explorer);
	}
	/*错误提醒10秒之后消失*/
	function errorHide(){
		var time = 10;//10s后消失
		var errorText =  $('#errorMessage').text();
		if(errorText != ""){
			$('#errorCon').attr("style","");
			$('#errorCon').css("dispaly","block");
			$('#login-box').removeClass("animated bounceInDown");
			//$('#loginInfo').addClass("animated shake");
			/* var interval = setInterval(function () {
	            --time;
	            if (time <= 0) {
					$('#errorCon').removeClass("bounceInDown");
	                $('#errorCon').addClass("bounceOutUp");
	               // $('#loginInfo').removeClass("animated shake");
	                clearInterval(interval);  
	            }
	        }, 1000); */
		}
	}
	$(function(){
		/*企业域*/
		getExplorer();
		var $domainNum = $("#domain>li").size();
		if($domainNum<=1){
			$(".selectdoMain>.form-control").val($.trim($("#domain>li").eq(0).text()));
			$(".domainLi").hide();
		}
		errorHide();
	})
	
</script>
<!--[if IE 6]> 
	<script type="text/javascript">
		var time = 5;
		var errorText =  $('#errorMessage').text();
		if(errorText != " "){
			$('#errorCon').attr("style","");
			$('#errorCon').css("dispaly","block");
			var interval = setInterval(function () {
	            --time;
	            if (time <= 0) {
	                $('#errorCon').hide();
	                clearInterval(interval);
	            }
	        }, 1000);
		}
	</script>
<![endif]-->
<script src='<s:url value="/portal/share/script/login.js"/>'></script>
<script src='<s:url value="/portal/share/script/iepngfix_tilebg.js"/>'></script><!--png24图片兼容ie6 -->
</head>
<body id="bodyid" onload="init()">
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<s:form id="loginform" action="/portal/login/loginWithCiphertext.action" method="POST" theme="simple" autocomplete="off">
<s:token></s:token>
<input type="hidden" id="_skinType" name="_skinType" value="" />
<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
<s:hidden name="_showCode" value="%{#request.showCode}" />
<s:if test="#parameters.debug">
<s:hidden name="debug" value="%{#parameters.debug}" id="debug" />
</s:if>
<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>
<!--<div align="center" class="container loginBg">-->



<table class="container ">

	<tr class="skinSelectTxt">
		<td>由于当前浏览器版本过低不支持最新H5皮肤，您可以下载<a href="https://www.baidu.com/s?ie=UTF-8&wd=chrome" title="下载Chrome" target="_blank"><img class="upchrome" src='<s:url value="/portal/share/images/login/skinUpChrome.png"/>'></a>登录系统</td>
	</tr>

	<tr>
		<td align="center">
		    <div class="login-box animated fadeInDown" id="login-box">
			    <div class="login">
			        <div class="logo">
						<div class="logo-pic loginBg">
						<!-- <img alt="" src='<s:url value="/portal/share/images/login/login_logo.gif"/>' title="{*[page.title]*}" /> -->
						</div>
						<p class="title"></p>
					</div>
			    	<!--<ul class="titleName">
			        	<li class="english">myApps|OBPM</li>
			            <li class="chinese">流程管理平台</li>
			        </ul>-->
			        <ul class="loginInfo" id="loginInfo">
			        	<li class="domainLi">
			        		<div class="form-group">
					        	<!--<span>{*[Domain]*}：</span>-->
					        	 <div class="selectdoMain">
					        	 	<i class="icon iconfont" style="font-size:18px;">&#xe619;</i>
					        	 	<input class="form-control" placeholder="{*[Domain]*}" type="text"  onmouseover="this.style.cursor='hand'" onmouseout="hideDomain();"  onclick="showDomain();"  value="<%=dn %>" name="domainName" />
					        	 </div>
					        	 	<ul class="domain" id="domain" onmouseout="hideDomain();" onmouseover="hiddendoMainOver();">
					        	 	<s:iterator value="#lh.getDomainNameList()">
					        	 		<li><a href="#" onclick="selectDomain(this);"><s:property /></a></li>
					        	 	</s:iterator>
					        	 </ul>
					        	 
				        	 </div>
				        	 <!-- 输入提醒
				        	 <div class="tipsdiv_Domain animated fadeInDown" id="tipsdiv_Domain">
				        	 	<div class="easytip-arrow"></div>
				        	 	<div class="easytip-text" id="easyDomaintip-text"></div>
				        	 </div> -->
			        	</li>
			        	 
			            <li class="zIndex98">
			           		<div class="form-group">
								<i class="icon iconfont">&#xe600;</i>
								<!--<input type="text"  placeholder="账号" class="form-control username userName" name="username" id="uid" easyform="length:4-16;char-normal;real-time;" message="用户名必须为4—16位的英文字母或数字" easytip="disappear:lost-focus;theme:red;" ajax-message="用户名已存在!" value="<%=ac %>" onkeyup="changeusername(this.value);"/>-->
								<input type="text" class="form-control userName" placeholder="{*[page.login.account]*}" value="<%=ac %>" name="_ac" onkeyup="changeusername(this.value);"/>
							</div>
							<!-- 输入提醒 -->
							<div class="tipsdiv_name animated fadeInDown" id="tipsdiv_name">
								<div class="easytip-arrow"></div>
								<div class="easytip-text" id="easytip-text"></div>
							</div>
			            </li>
			            <li class="zIndex98">
			            	<div class="form-group">
								<i class="icon iconfont">&#xe618;</i>
								<!--<span></span><input type="password"  id="signup_password" placeholder="密码" class="form-control password" name="password" type="password" id="psw1" easyform="length:6-16;" message="密码必须为6—16位" easytip="disappear:lost-focus;theme:blue;" value="<%=pw %>" autocomplete="off"/>-->			
								<input class="form-control password" placeholder="{*[page.login.password]*}" type="password" name=_pd value="<%=pw %>" autocomplete="off"/>
							</div>
							<!-- 输入提醒 -->
							<div class="tipsdiv-pass animated fadeInDown" id="tipsdiv_pass">
								<div class="easytip-arrow"></div>
								<div class="easytip-text" id="easyPasstip-text"></div>
							</div>
			            </li>
			           	
			            <li class="keepInfo">

			            	<%if(ki.equals("yes")){ %><input type="checkbox" name="keepinfo" value="yes" checked="checked" /><%} else { %><input type="checkbox" name="keepinfo" value="yes"/><%} %>{*[page.login.keeppwd]*}
			            </li>
			            
			            <!--<li class="tipsArea"><div id="tipsArea">&nbsp;</div></li>-->           
			            <li class="btnOk zIndex98"><input onclick="login_ing(this)" id="tijiao" type="submit" alt="{*[Login]*}" value="{*[Login]*}" class="btn-login loginBg" easyform="length:6-16;" message="请输入密码" easytip="disappear:lost-focus;theme:blue;"/></li>
			        	<%if (showCode) { %>
							<li class="checkCode">
								<div class="form-group" style="positon:relative;overflow:hidden;">
									<!--<span>{*[Character]*}：</span>-->
									<s:textfield theme="simple" onblur="disableCodeTips(this)" onfocus="showCodeTips(this,'{*[page.login.character]*}')" name="checkcode" placeholder="{*[Character]*}"/>
									<img src="<s:url value="/checkCodeImg"/>" align="absmiddle" onclick="getSecurityCode();" width="70" height="26" id="checkCodeImg" />
									<span class="invisibility" onclick="getSecurityCode()">看不清</span>
								</div>
								<!-- 输入提醒 -->
								<div class="tipsdiv-code animated fadeInDown" id="tipsdiv_code">
									<div class="easytip-arrow"></div>
									<div class="easytip-text" id="easyCodetip-text"></div>
								</div>
							</li>
						<%}else{ %>
							<li class="notcheckCode">
							</li>
						<%} %>
			        </ul>
			        <div style="clear:both;"></div>
			        <div class="remember" style="display:block;">
		            	<div title="{*[page.login.remember.tip]*}" class="low_login" id="p_low_login_box">
		            		<input type="checkbox" id='remember' name="remember" value="true" />
		            		<label for="remember">{*[page.login.remember.label]*}</label>
		            	</div>
		            </div>
			    </div>
			</div>
			<div style="clear:both;"></div>
			
    	</td>
	</tr>
</table>
<div class="errorCon animated bounceInDown" id="errorCon" style="display:none;">
    <div class="errorMsg">
		<s:if test="hasFieldErrors()">
			<span class="errorMessage" id="errorMessage"> 
			<b style="display:block;">
			<s:iterator value="fieldErrors">
				<s:property value="value[0]"/><br/>
				<s:if test="value[0] == '{*[core.domain.notexist]*}'">
					<script>
						focusOn(document.getElementsByName('domainName')[0]);
					</script>
				</s:if>
				<s:elseif test="value[0] == '{*[core.user.notexist]*}'">
					<script>
						focusOn(document.getElementsByName('_ac')[0]);
					</script>
				</s:elseif>
				<s:elseif test="value[0] == '{*[core.security.character.error]*}'">
					<script>
						focusOn(document.getElementsByName('checkcode')[0]);
					</script>
				</s:elseif>
				<s:else>
					<script>
						focusOn(document.getElementsByName('_pd')[0]);
					</script>
				</s:else>
			</s:iterator>
			</span>
		</s:if>
	</div>
</div>  
           
<!--</div>-->
<div class="copyright loginBg">
    	<span>{*[front.page.login.copyright]*}</span>
    </div>
<!-- 语言选择 -->
<div class="language">
    	<!--<span>{*[Language]*}：</span>-->
    	<s:select name = "language" list="#mh.getTypeList()" value="#mh.getType(#session.USERLANGUAGE)" theme="simple" onchange="changeLanguage()" />
</div>
</s:form>

<!-- 提示框 -->
</body>
</html>
</o:MultiLanguage>
