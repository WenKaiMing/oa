<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.util.Security" %>
<%@ page import="cn.myapps.util.WebCookies" %>
<%
String handleUrl = (String) request.getAttribute("handleUrl");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{*[page.title]*}</title>
<link rel="stylesheet" href='<s:url value="/portal/share/css/smsAuth.css"/>'	type="text/css" />
<script>
	var secs = <s:property value="timeout"/>;
	function ev_save() {
		document.forms[0].submit();
	}
	function ev_init() {
		document.getElementById("resent").disabled = true;
		for (var i = 1; i <= secs; i++) {
			setTimeout("update( " + i + ") ", i * 1000);
		}
	}

	
	function update(num) {
		if (num ==0 || num == secs) {
			document.getElementById("resent").innerHTML = "<span style='color:#009fe5;'>{*[page.function.info.sms.resent]*}</span>";
			document.getElementById("resent").disabled = false;
		} else {
			printnr = secs - num;
			document.getElementById("resent").innerHTML = "&nbsp;"+printnr+"&nbsp;";
		}
	}
	
	function ev_resent(){
		var url = '<s:url value="/portal/login/smsauth.action" />';
		document.forms[0].action = url;
		document.forms[0].submit();
	}
</script>
<script src='<s:url value="/portal/share/script/smsAuth.js"/>'></script>
<script src='<s:url value="/portal/share/script/iepngfix_tilebg.js"/>'></script><!--png24图片兼容ie6 -->
</head>
<body id="bodyid" onload="ev_init()">
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<s:form id="loginform" action="/portal/login/loginSMS.action" method="POST" theme="simple">
<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
<s:hidden name="signText" value="" />
<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>
<div class="errorCon">
           	<div class="smserrorMsg">
           		<span class="errorMessage" id="errorMessage" style="text-align: left;">{*[page.function.info.sms.message]*}</span>
            </div>
        </div>
<table align="center" class="container">
	<tr><td>
    <div class="login">
    	<!-- <ul class="titleName">
        	<li class="english">myApps|OBPM</li>
            <li class="chinese">流程管理平台</li>
        </ul> -->
        
        <div class="logo">
			<div class="logo-pic loginBg"></div> 
		</div>
        <div id="ul_loginInfo" >
            <table align="center" style="width:375px;margin:0 auto;">
	            <tr align="left">
	            	<!-- <td><span style="font-size: 14">{*[page.function.info.sms.code]*}:</span></td> -->
		            <td valign="centet" class="smsIput">
		            	<i class="smsicon icon iconfont" style="font-size:18px;">&#xe61a;</i>
			            <s:textfield name="smsCheckCode" cssStyle="background:#ffffff;display:;float:;margin-top:0px;  border:1px solid #A9BAC9; width:260px; padding:;padding-left:40px;padding-right:108px; height:40px; line-height:40px; _vertical-align:;" placeholder="验证码" theme="simple" value="" />
			            <button onclick="ev_resent();" name="resent" id="resent" ></button>
		            	<div class="btnOk" id="li_btn_verify"><input
										type="button" id="save_btn" alt="" onclick="ev_save();"
										value="{*[OK]*}" class="loginBtn loginBg"  /></div>
		            </td>
	            </tr>
	            <tr><div class="tipsArea"><div id="tipsArea">&nbsp;</div></div></tr>
            </table>
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
    
    </td></tr>      
</table>
<div class="copyright loginBg">
    	<span>Copyright © 2012 TEEMLINK</span>　{*[company.name]*}　{*[copyright]*} 
    </div> 
</s:form>
</body>
</html>
</o:MultiLanguage>
