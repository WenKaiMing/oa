<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/portal/share/common/head.jsp"%>
<% 
SSOUtil.doRedirect(request,response);
%>
<%@page import="cn.myapps.core.sso.SSOUtil"%>

<%@page import="cn.myapps.util.StringUtil"%><o:MultiLanguage
	value="FRONTMULTILANGUAGETAG">
	<head>
<title>{*[page.title]*}</title>
<script src="<s:url value='/portal/share/script/drag.js'/>"></script>
<link href="<s:url value='/portal/share/css/base.css'/>" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function IsResize() {
		if (document.frames['main_iframe'].document.getElementById("fraset2").cols == "210,0,*") {
			document.frames['main_iframe'].document.getElementById("fraset2").cols = "0,15,*";
		} else if (document.frames['main_iframe'].document
				.getElementById("fraset2").cols == "0,15,*") {
			document.frames['main_iframe'].document.getElementById("fraset2").cols = "210,0,*";
		}
	}

	function hideMenu() {
		document.frames['main_iframe'].document.getElementById("fraset2").cols = "0,15,*";
	}

	function showMenu() {
		document.frames['main_iframe'].document.getElementById("fraset2").cols = "210,0,*";
	}

	function switchWindow(winName) {
		document.getElementById("client").style.display = "none";
		document.getElementById("debug").style.display = "none";
		document.getElementById("console").style.display = "none";

		if (winName == 'client') {
			document.getElementById("client").style.display = "";
		} else if (winName == 'debug') {
			document.getElementById("debug").style.display = "";
			window.frames["iframe_debug"].refresh();
		} else if (winName == 'console') {
			document.getElementById("console").style.display = "";
		}

	}

	//设置主体内容高度
	function setMainHeight() {
		var documentH = jQuery(window).height();
		var actTableH = jQuery("#actTable").height();
		jQuery("#client").height(documentH - actTableH);
		jQuery("#debug").height(documentH - actTableH);
		jQuery("#console").height(documentH - actTableH);
	}

	jQuery(function(){
		setMainHeight();//设置主体内容高度
	});

	jQuery(window).resize(function() {
		setMainHeight();//设置主体内容高度
	});
</script>
	</head>
	<body style="margin: 0px; overflow: hidden;">
		<s:if test='#session.DEBUG !=null && #session.DEBUG !="" '>
			<table id="actTable" cellpadding="0" cellspacing="0" border="0"
				bgcolor="#000000" width="100%">
				<tr>
					<td>&nbsp;&nbsp;<span> <a href="#"
							onclick="switchWindow('client')"
							style="color: #ffffff; font-size: 14px; font-family: Arial">
								<img src="./images/debugger/debuger.gif" border="0" />
								{*[Client]*} </a> </span> &nbsp;&nbsp;<span><a href="#"
							onclick="switchWindow('debug')"
							style="color: #ffffff; font-size: 14px; font-family: Arial">
								<img src="./images/debugger/debuger.gif" border="0" />
								{*[Debug]*} </a> </span> &nbsp;&nbsp;<span><a href="#"
							onclick="switchWindow('console')"
							style="color: #ffffff; font-size: 14px; font-family: Arial">
								<img src="./images/debugger/console.gif" border="0" />
								{*[Console]*} </a> </span></td>
				</tr>
			</table>
			<!-- 调试器 -->
			<div id='debug' style="display: none">
				<iframe
					src="<s:url value='/core/macro/debuger/debuger.jsp'><s:param name="application" value="#parameters.application" /></s:url>"
					id="iframe_debug" name="iframe_debug" width="100%" height="100%"
					align="top" scrolling="no" frameborder="0" style="overflow: hidden"></iframe>
			</div>
			<!-- 控制台 -->
			<div id='console' style="display: none">
				<iframe
					src="<s:url value='/core/macro/debuger/console.jsp'><s:param name="application" value="#parameters.application" /></s:url>"
					id="iframe_console" name="iframe_console" width="100%"
					height="100%" align="top" scrolling="no" frameborder="0"
					style="overflow: hidden"> </iframe>
			</div>
		</s:if>
		<!-- 主页面 -->
		<div id='client'>
			<iframe
				src='<o:Url value="/main.jsp"/>?application=<s:property value="#parameters.application" />&uuid=<s:property value="#parameters.uuid" />'
				id="main_iframe" name="main_iframe" width="100%" height="100%"
				align="top" scrolling="no" frameborder="0" style="overflow: hidden;"></iframe>
		</div>
		<div id="PopWindows_dialog" class="front-div-dialog-popWindows"></div>

		<input type="hidden" id="mappStr" />

		<div id="closeWindow_DIV" class="front-div-dialog-black_overlay"></div>

		<div id="PopWindows" class="front-div-dialog-white_content">
			<div id="dheader" class="front-div-dialog-dheader">
				<div id="dheader_title" class="front-div-dialog-title">{*[]*}</div>
				<%-- <div id="close" class="front-div-dialog-close">
					<img align="middle" onClick="closeParentDiv()" id="closeImg"
						title="{*[Close]*}"
						src="<o:Url value='/resource/imgv2/front/main/close_06.gif'/>" />
				</div> --%>
			</div>
			<div id="dbody" class="front-div-dialog-dbody"></div>
		</div>
		<DIV ID="loadingDiv"
			STYLE="position: absolute; z-index: 100; width: 60%; height: 60%; left: 40%; top: 40%; display: none;">
			<table>
				<tr>
					<td><img src="<s:url value="/resource/imgnew/loading.gif"/>">
					</td>
					<td><b><font size='3'>{*[page.loading]*}...</font> </b>
					</td>
				</tr>
			</table>
		</DIV>
		<div id="loadingDivBack"
			style="position: absolute; z-index: 50; width: 104%; height: 100%; top: 15px; left: 0px; display: none; background-color: #DED8D8; filter: alpha(opacity =   20); opacity: 0.20;">
		</div>
	</body>
</html>
</o:MultiLanguage>
