<%@page import="cn.myapps.core.macro.runner.JsMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
String redirect = request.getParameter("redirect");
String title = request.getParameter("title");
String discript = request.getParameter("discript");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<script type="text/javascript"
	src='<s:url value="/portal/phone/resource/js/jquery-1.11.3.min.js"/>'></script>
<link rel='stylesheet'
	href='<s:url value="/portal/phone/resource/css/weui.min.css"/>' />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=title%></title>
</head>
<body>
	<div class="page">
		<div class="weui_msg">
			<div class="weui_icon_area">
				<i class="weui_icon_info weui_icon_msg"></i>
			</div>
			<div class="weui_text_area">
				<h2 class="weui_msg_title" id="msg_title"><%=title%></h2>
				<p class="weui_msg_desc" id="close_msg">{*[phone.core.component.qrcodefield.msg1]*} <%=title %> {*[phone.core.component.qrcodefield.msg2]*}</p>
			</div>
			<div class="weui_extra_area">
				<div class="weui_opr_area">
					<p class="weui_btn_area">
							<a class="weui_btn weui_btn_primary">{*[phone.core.component.qrcodefield.confirm]*}</a> 
							<a class="weui_btn weui_btn_default">{*[phone.core.component.qrcodefield.cancel]*}</a>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$(".weui_btn_primary").on("click", function() {
			window.location.href = '<%=redirect%>';
		});
		$(".weui_btn_default").on("click", function() {
			WeixinJSBridge.invoke('closeWindow', {}, function(res) {
			});
		});
	});
</script>
</html>
</o:MultiLanguage>