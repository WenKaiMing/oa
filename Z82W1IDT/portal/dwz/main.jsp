<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=100" />
<meta name="renderer" content="webkit">
<!-- webkit|ie-comp|ie-stand : chrome内核|ie兼容内核|ie标准内核 -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/portal/share/common/head.jsp"%>
<% 
	SSOUtil.doRedirect(request,response);
%>

<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.sso.SSOUtil"%><o:MultiLanguage value="FRONTMULTILANGUAGETAG">

	<title><s:if test="#session.FRONT_USER.getDomain().getSystemName().length()>0"><s:property value="#session.FRONT_USER.getDomain().getSystemName()"/></s:if><s:else>{*[page.title]*}</s:else></title>
	<script src="<s:url value='/portal/share/script/drag.js'/>"></script>
	<link rel="shortcut icon" type="images/x-icon" href="<s:url value='../share/images/logo/logo32x32.ico'/>" media="screen" />
	<link rel="stylesheet"
		href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
	<script type="text/javascript">
 function IsResize() {
	if(!document.frames['main_iframe'] || !document.frames['main_iframe'].document.getElementById("fraset2")) return;
	if(document.frames['main_iframe'].document.getElementById("fraset2").cols=="210,0,*"){
		document.frames['main_iframe'].document.getElementById("fraset2").cols="0,15,*";
	} else if (document.frames['main_iframe'].document.getElementById("fraset2").cols=="0,15,*") {
		document.frames['main_iframe'].document.getElementById("fraset2").cols="210,0,*";
	}
}

function hideMenu() {
	document.frames['main_iframe'].document.getElementById("fraset2").cols="0,15,*";
}

function showMenu() {
	document.frames['main_iframe'].document.getElementById("fraset2").cols="210,0,*";
}

function switchWindow(winName) {
	document.getElementById("client").style.display = "none";
	document.getElementById("debug").style.display = "none";
	document.getElementById("console").style.display = "none";

	if (winName =='client') {
		document.getElementById("client").style.display = "";
	}
	else if (winName == 'debug') {
		document.getElementById("debug").style.display = "";
		window.frames["iframe_debug"].refresh();
	}
	else if (winName == 'console') {
		document.getElementById("console").style.display = "";
	}
	
}

//设置主体内容高度
function setMainHeight(){
	var documentH = jQuery(window).height();
	var actTableH = jQuery("#actTable").height();
	jQuery("#client").height(documentH - actTableH);
	jQuery("#debug").height(documentH - actTableH);
	jQuery("#console").height(documentH - actTableH);
}

window.onload = function (){
	setMainHeight();//设置主体内容高度
};

jQuery(window).resize(function(){
	setMainHeight();//设置主体内容高度
});
</script>
<style type="">
#header .logo {
background:url(../share/images/logo/logo-dwz.png) no-repeat;
}
</style>
	</head>
	<body style="margin: 0px; overflow: hidden">
	<!-- 主页面 -->
	<div id='client'><iframe src='mainFrame.jsp?application=<s:property value="#parameters.application" />&uuid=<s:property value="#parameters.uuid" />' id="main_iframe"
		name="main_iframe" width="100%" height="100%" align="top"
		scrolling="no" frameborder="0" style="overflow: hidden"></iframe></div>
	<div id="PopWindows_dialog" class="front-div-dialog-popWindows"></div>

	<input type="hidden" id="mappStr" />

	<div id="closeWindow_DIV" class="front-div-dialog-black_overlay"></div>

	<div id="PopWindows" class="front-div-dialog-white_content">
	<div id="dheader" class="front-div-dialog-dheader">
	<div id="dheader_title" class="front-div-dialog-title">{*[]*}</div>
	<div id="close" class="front-div-dialog-close"></div>
	</div>
	<div id="dbody" class="front-div-dialog-dbody"></div>
	</div>
	<DIV ID="loadingDiv"
		STYLE="position: absolute; z-index: 100; width: 60%; height: 60%; left: 40%; top: 40%; display: none;">
	<table>
		<tr>
			<td><img src="<s:url value="/portal/share/images/imgnew/loading.gif"/>"></td>
			<td><b><font size='3'>{*[page.loading]*}...</font> </b></td>
		</tr>
	</table>
	</DIV>
	<div id="loadingDivBack"
		style="position: absolute; z-index: 50; width: 104%; height: 100%; top: 15px; left: 0px; display: none; background-color:#DED8D8; filter: alpha(opacity = 20); opacity: 0.20;">
	</div>
	</body>
	</html>
</o:MultiLanguage>
