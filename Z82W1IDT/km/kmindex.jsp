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
<link href='<s:url value="/km/disk/css/kmlayout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>

</head>
<script type="text/javascript">
function ev_openLogs(){
	var url = '<s:url value="/km/logs/query.action"/>';
	OBPM.dialog.show({
		opener : window.top,
		width : 860,
		height : 505,
		url : url,
		args : {},
		title : "{*[cn.myapps.km.logs]*}",
		close : function() {
		}
	});
}

	//我的网盘
	function getDimensions(){
		var bodyH = jQuery(document).height();
		var km_headerH = jQuery(".km_header").height();
		var diskHomeH = jQuery(".diskHome").height();
		jQuery(".diskFrame_box").height(bodyH - km_headerH);
	}
	
	//切换热门分享和最新上传样式
	function switchStyle(obj){
		jQuery("div.diskHome a").css("backgroundColor","");
		var $obj = jQuery("a[name=" + obj +"]");
		$obj.css("backgroundColor","#eee");
	}
	
	//隐藏热门分享
	function hideHotShare(ble){
		if(ble == "hide"){
			jQuery("div.diskHome").css("display","none");
		}else{
			jQuery("div.diskHome").css("display","");
		}
	}
	//突出显示当前选中项
	function switchCurSelected(){
		jQuery("#nav a").click(function(){
			jQuery(this).addClass("cur").siblings().removeClass("cur");
		});
	}
	jQuery(window).resize(function(){
		//getDimensions();
	});
	jQuery(document).ready(function(){
		getDimensions();
		jQuery("div.diskHome a").click(function(){
			switchStyle(this.name);
		});
		switchStyle("hotShare");
		switchCurSelected();//突出显示当前选中项
	});
</script>
<body>
<div id="container" class="container" >
	<div id="km_header" class="km_header" >
		<div id="logo" class="logo"><a href="#"><img src="<s:url value='/saas/resource/img/head-logo.png'/>"/></a></div>
		<div class="clearfix" id="nav">
					<a target="main" href="<s:url value='/km/disk/listHotest.action'/>" class="cur home" onclick="switchStyle('hotShare');hideHotShare('');">{*[cn.myapps.km.disk.homepage]*}</a>
					<a target="main" href="<s:url value='/km/disk/view.action?_type=2'/>" class="mydisk" onclick="hideHotShare('hide')">{*[cn.myapps.km.disk.my_disk]*}</a>
					<a target="main" href="<s:url value='/km/disk/view.action?_type=1'/>" class="pubdisk" onclick="hideHotShare('hide')">{*[cn.myapps.km.disk.public_disk]*}</a>
					<a target="main" href="<s:url value='/km/disk/view.action?_type=5'/>" class="pubdisk" onclick="hideHotShare('hide')">{*[cn.myapps.km.disk.archive_disk]*}</a>
					<s:if test="#session.KM_FRONT_USER.isKmAdmin()">
					<a href="#" class="pubdisk" onclick="ev_openLogs()">{*[cn.myapps.km.logs]*}</a>
					</s:if>
					<a href="<s:url value='/saas/logout.jsp'/>" class="logout">{*[Logout]*}</a>
		</div>
	</div>
	<div class="diskFrame_box" style="padding-top:0;">
		<div class="diskHome">
			<a name="hotShare" target="main" href="<s:url value='/km/disk/listHotest.action'><s:param name='_type' value='%{#parameters._type}'/></s:url>">{*[cn.myapps.km.disk.popular_share]*}</a>
			<span>|</span>
			<a name="newUpload" target="main" href="<s:url value='/km/disk/listNewest.action'><s:param name='_type' value='%{#parameters._type}'/></s:url>">{*[cn.myapps.km.latest_upload]*}</a>
		</div>
		<iframe name="main" id="diskFrame" src="<s:url value='/km/disk/listHotest.action'><s:param name='_type' value='%{#parameters._type}'/></s:url>" width="100%" height="100%" frameborder="0" ></iframe>
	</div>
</div>
<!--[if IE 6]>
<script type="text/javascript" src="../saas/resource/script/Ie6Filter.js"></script>
<script>
	DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
</body>
</o:MultiLanguage></html>