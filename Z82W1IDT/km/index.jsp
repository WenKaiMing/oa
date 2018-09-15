<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<%
	String _type = request.getParameter("_type");//网盘类型（公有|私有）
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.km_name]*}</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>

</head>
<script type="text/javascript">
	//我的网盘
	function getDimensions(){
		var bodyH = document.documentElement.clientHeight-10;
		var km_headerH = jQuery(".km_header").height();
		jQuery(".diskFrame_box").height(bodyH - km_headerH);
	}
	jQuery(window).resize(function(){
		getDimensions();
	});
	jQuery(document).ready(function(){
		getDimensions();
	});
</script>
<body>
<div id="container" class="container" >
	<div id="km_header" class="km_header" >
		<div id="logo" class="logo"><a href="#"><img src="<s:url value='/km/disk/images/km2_logo.gif'/>"/></a></div>
		<div id="act" class="act" >
			<div class="act_left"></div>
			<div class="act_center">
				<div id="action" class="action">
					<a target="main" href="<s:url value='/km/home.jsp'/>" class="dbank">{*[cn.myapps.km.disk.homepage]*}</a>
					<a target="main" href="<s:url value='/km/disk/view.action?_type=2'/>" class="dbank">{*[cn.myapps.km.disk.my_disk]*}</a>
					<a target="main" href="<s:url value='/km/disk/view.action?_type=1'/>" class="dbank">{*[cn.myapps.km.disk.public_disk]*}</a>
					<a href="<s:url value='/saas/logout.jsp'/>" class="help">{*[Logout]*}</a>
				</div>
			</div>
			<div class="act_right"></div>
		</div>
	</div>
	<div class="diskFrame_box">
		<iframe name="main" id="diskFrame" src="<s:url value='/km/home.jsp'><s:param name='_type' value='%{#parameters._type}'/></s:url>" width="100%" height="100%" frameborder="0" scrolling="no" ></iframe>
	</div>
</div>
</body>
</o:MultiLanguage></html>