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
<link rel="stylesheet" href='<s:url value="/portal/share/css/login.css"/>'	type="text/css" />
<script src='<s:url value="/dwr/interface/UsbKeyUtil.js"/>'></script>
<script type="text/javascript">
function verify(){
	if(!findToken()) return false;
	var r1,r2 ;
	var pw = document.getElementsByName("password")[0].value;
	var signText = document.getElementsByName("signText")[0];
	if(!pw || pw.length<=0){
		alert("{*[page.login.password]*}");
		return false;
	}
	r1 = GDInitCtrl.ReadData(pw, "100", "0");
	DWREngine.setAsync(false);
	if(r1==0){
		UsbKeyUtil.getRandomCode(GDInitCtrl.GetResult,function(randomCode){
			if(randomCode.length>0){
				r2 = GDHidCtrl.SignMsg(pw,randomCode);
				if(r2==0){
					signText.value = GDHidCtrl.GetResult;
					document.forms[0].submit();
				}
			}
		});
	}
	DWREngine.setAsync(true);
}

function findUsbKey(){
	var result = GDInitCtrl.FindToken;
	if(result == 0){
		document.getElementById("li_btn_findUsbKey").style.display = "none";
		document.getElementById("li_btn_verify").style.display = "";
		document.getElementById("password").disabled = false;
	}else {
		document.getElementById("li_btn_findUsbKey").style.display = "";
		document.getElementById("li_btn_verify").style.display = "none";
		document.getElementById("password").disabled = true;
	}
}

/**
**判断是否连接USBKEY
**/
function findToken()
{
	var result = GDInitCtrl.FindToken;
	if (result == 0)
	{
		return true;
	}
	else
	{
		alert("{*[core.usbkey.tip.usbkeyNotfound]*}");
		return false;
	}
}

jQuery(document).ready(function(){
	if(navigator.userAgent.indexOf("MSIE")>0) {
		findUsbKey();
	}else {
		document.getElementById("ul_loginInfo").style.display = "none";
		document.getElementById("ul_broser_note").style.display = "";
	}
});
</script>
<script src='<s:url value="/portal/share/script/login.js"/>'></script>
<script src='<s:url value="/portal/share/script/iepngfix_tilebg.js"/>'></script><!--png24图片兼容ie6 -->
</head>
<body id="bodyid">
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<s:form id="loginform" action="/portal/login/loginUsbKey.action" method="POST" theme="simple">
<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
<s:hidden name="signText" value="" />
<input type="hidden" name="myHandleUrl" id="myHandleUrl" value="<%=handleUrl %>"/>
<div align="center" class="container loginBg">
    <div class="login">
    	<ul class="titleName">
        	<li class="english">myApps|OBPM</li>
            <li class="chinese">流程管理平台</li>
        </ul>
        <ul id="ul_loginInfo" >
            <li>
            	<span style="color:blue">{*[core.usbkey.tip.notice]*}</span>
            </li>
             <li>
            	<span style="color:blue">&nbsp;</span>
            </li>
            <li>
            <table>
            <tr>
            <td><span style="font-size: 14">{*[Password]*}：</span></td>
            <td><input type=password name=password id=password value="" placeholder="{*[core.usbkey.tip.inputPassword]*}" autocomplete="off"/>            </td>
            </tr>
            </table>
            	
            	
            </li>
            <li class="tipsArea"><div id="tipsArea">&nbsp;</div></li>
            <li class="btnOk" id="li_btn_findUsbKey"><input type="button" id="btn_findToken" onclick="findUsbKey()" alt="{*[core.usbkey.tip.findUsbKey]*}" value="{*[core.usbkey.tip.findUsbKey]*}" class="loginBtn loginBg" /></li>           
            <li class="btnOk" id="li_btn_verify"><input type="button" id="btn_verify" onclick="verify()" alt="{*[core.usbkey.tip.verify]*}" value="{*[core.usbkey.tip.verify]*}" class="loginBtn loginBg" /></li>
        </ul>
        <ul id="ul_broser_note" style="display: none">
        <li>
            	<span>&nbsp;</span>
            </li>
            <li>
            	<span>&nbsp;</span>
            </li>
         <li>
            <span style="color:red">USBKey身份验证仅支持IE内核的浏览器！</span>
         </li>
        </ul>
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
    <div class="copyright loginBg">
    	<span>Copyright © 2012 TEEMLINK</span>　{*[company.name]*}　{*[copyright]*} 
    </div>       
</div>
</s:form>
</body>
</html>
</o:MultiLanguage>
