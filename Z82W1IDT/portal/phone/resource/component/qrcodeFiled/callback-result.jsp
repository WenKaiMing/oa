<%@page import="cn.myapps.core.macro.runner.JsMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
JsMessage message = (JsMessage)request.getAttribute("message");
String icon = "weui_icon_success";
String msg = "";
String title = "";
if(message !=null){
	if(JsMessage.TYPE_SUCCESS == message.getType()){
		icon = "weui_icon_success";
		title = "操作成功";
	}else if(JsMessage.TYPE_INFO == message.getType()){
		icon = "weui_icon_info";
		title = "温馨提示";
	}else if(JsMessage.TYPE_WARNING == message.getType()){
		icon = "weui_icon_warn";
		title = "温馨提示";
	}else if(JsMessage.TYPE_DANGER == message.getType()){
		icon = "weui_icon_warn";
		title = "操作失败";
	}else{
		icon = "weui_icon_info";
		title = "温馨提示";
	}
	msg = message.getContent();
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<script type="text/javascript" src='<s:url value="/portal/phone/resource/js/jquery-1.11.3.min.js"/>'></script>
<link rel='stylesheet' href='<s:url value="/portal/phone/resource/css/weui.min.css"/>'/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微OA365</title>
</head>
<body>
	<div class="page">
		<div class="weui_msg">
			<div class="weui_icon_area"><i class="<%=icon %> weui_icon_msg"></i></div>
			<div class="weui_text_area">
				<h2 class="weui_msg_title" id="msg_title"><%=title %></h2>
				<p class="weui_msg_desc" id="close_msg"><%=msg %></p>
			</div>
			
			<div class="weui_extra_area">
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a class="weui_btn weui_btn_default close_msg" id="close_btn">我知道了</a>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function onBridgeReady() {
	WeixinJSBridge.invoke('hideOptionMenu');
}

if (typeof WeixinJSBridge == "undefined") {
	if (document.addEventListener) {
		document.addEventListener('WeixinJSBridgeReady', onBridgeReady,false);
	} else if (document.attachEvent) {
		document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
		document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	}
} else {
	onBridgeReady();
}

$(document).ready(function(){
	$("#close_btn").on("click",function(){
		WeixinJSBridge.invoke('closeWindow',{},function(res){
			//alert('关闭微信页面');
		});
	});
});
</script>
</html>