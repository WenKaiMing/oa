<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String action = request.getParameter("action");
String _mode = request.getParameter("mode");	//模式--值为select时为用户选择模式
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>通讯录</title>
<link href="css/weui.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/global.css" rel="stylesheet">
<link href="css/contacts.css" rel="stylesheet">
</head>
<body ontouchstart>
<div id="toast" style="display: none;">
    <div class="weui_mask_transparent" style="z-index: 1000;"></div>
    <div class="weui_toast">
        <i class="weui_icon_toast"></i>
        <p class="weui_toast_content"></p>
    </div>
</div>
<div id="loadingToast" class="weui_loading_toast" style="display:none;">
	<div class="weui_mask_transparent" style="z-index: 1000;"></div>						
	<div class="weui_toast">
		<div class="weui_loading">							
		<div class="weui_loading_leaf weui_loading_leaf_0"></div>
		<div class="weui_loading_leaf weui_loading_leaf_1"></div>
		<div class="weui_loading_leaf weui_loading_leaf_2"></div>
		<div class="weui_loading_leaf weui_loading_leaf_3"></div>
		<div class="weui_loading_leaf weui_loading_leaf_4"></div>
		<div class="weui_loading_leaf weui_loading_leaf_5"></div>
		<div class="weui_loading_leaf weui_loading_leaf_6"></div>
		<div class="weui_loading_leaf weui_loading_leaf_7"></div>
		<div class="weui_loading_leaf weui_loading_leaf_8"></div>
		<div class="weui_loading_leaf weui_loading_leaf_9"></div>
		<div class="weui_loading_leaf weui_loading_leaf_10"></div>
		<div class="weui_loading_leaf weui_loading_leaf_11"></div>
		</div>
		<p class="weui_toast_content">数据加载中</p>
	</div>
</div>
<div id="contacts" class="contacts"></div>
<div id="contacts-select-panel" style="display:none">
	<div id="contacts-select-list" class="select-list text-center"></div>
	<div class="select-btn">
		<a id="deleteAll" class="weui_btn weui_btn_plain_warn">清空</a>
		<a id="doReturn" class="weui_btn weui_btn_primary">确认<span class="count"></span></a>
	</div>
</div>


<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/weui.router.js"></script>
<script src="js/template.js"></script>
<script src="js/common.js"></script>
<script src="js/contact.core.js"></script>
<script src="js/contact.util.js"></script>
<script src="js/contact.service.js"></script>
<script src="js/contact.router.js"></script>
<script src="js/contact.user.js"></script>
<script>
var action = "<%=action%>";
var _mode = "<%=_mode%>";

//微信url不支持#
if(action && action == "favoriteContacts"){
	window.location.href = '#/:favorite'; 
}else if(window.location.hash == ""){
	window.location.href = '#/:main';
}
$(function(){
	setTimeout(function(){
		Contacts.config.select = (_mode == "select");
		if(Contacts.config.select){
			if(typeof top.hideLoadingToast == "function"){
				top.hideLoadingToast();
			}
			Contacts.Util.controlLoading("show");
			Contacts.User.init();	//用户选择框配置
		}else{
			Contacts.Util.controlLoading("show");
		}

		Contacts.Router.main();
	},300);
	
	if (/Android/gi.test(navigator.userAgent)) {
	    window.addEventListener('resize', function () {
	        if (document.activeElement.tagName == 'INPUT' || document.activeElement.tagName == 'TEXTAREA') {
	            window.setTimeout(function () {
	                document.activeElement.scrollIntoViewIfNeeded();
	            }, 0);
	        }
	    })
	}
})
</script>
<%@include file="./template.jsp" %>
</body>
</html>