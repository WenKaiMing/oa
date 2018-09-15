<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet"
	href="./resource/jquery/layout-default-latest.css">
	<style>
body {margin:0px;border:0px;padding:0px;}

.togglerClass {
	width: 0px;
}

.resizerClass {
	width: 0px;
}

#menu_bar {
	margin: 0px;
	padding: 0px;
}

#menu_bar li {
	width: 100px;
	height: 50px;
	margin: 0px;
	text-decoration: none;
	list-style-type: none;
	display: block;
	float: left;
	text-align: center;
	word-break: break-all;
	text-overflow:ellipsis;
	white-space:nowrap;
	overflow:hidden; 
}

#menu_bar li a {
	cursor: pointer;
}

#menu_bar li a span {
	font-size: 16px;
	font-style: normal;
	line-height: 50px;
	color: #595959;
	text-align: center;
}

#menu_bar li a span.active {
	font-size: 18px;
	font-weight: bold;
	color: #000;
	background: #eeeeee;
}
</style>
	<script src="./resource/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript"
		src="./resource/jquery/jquery.layout-latest.js"></script>

	<script type="text/javascript">
		var $layout;
		$(function() {
			$layout = $('body').layout({
				center__paneSelector : "#center",
				north__paneSelector : "#north",
				togglerClass : "togglerClass",
				resizerClass : "resizerClass",
				spacing_open : 0,
				spacing_close : 0,
				north__size : 50,
				north__minSize : 50,
				north__maxSize : 50,
				north__animatePaneSizing : true,
				north__fxSpeed_size : 200,
				north__fxSpeed_open : 500,
				north__fxSettings_open : {
					easing : "bounce"
				},
				north__fxName_close : "none",
				north__showOverflowOnHover : true,
				//			stateManagement__enabled : true
				initClosed : false
			});

			$("#menu_bar>li>a>span").click(function() {
				$("#menu_bar>li>a>span.active").removeClass("active");
				$(this).addClass("active");
				var url = $(this).parent().attr("_url");
				$("#center").attr("src", url);
			});

			//选择第一个
			$("#hotest>a>span").trigger("click");
		});
	</script>
</head>
<body>
	<div id="north"
		style="padding: 0px; border: 1px solid #e6e6e6; overflow: visible; background: #f0f4f7;">
		<ul id="menu_bar">
			<li id="hotest"><a _url="../../km/disk/listHotest.action"><span>{*[cn.myapps.km.disk.popular_share]*}</span></a></li>
			<li id="newest"><a _url="../../km/disk/listNewest.action"><span>{*[cn.myapps.km.latest_upload]*}</span></a></li>
			<li id="publicDisk"><a _url="../../km/disk/view.action?_type=1"><span>{*[cn.myapps.km.disk.public_disk]*}</span></a></li>
			<li id="personalDisk"><a
				_url="../../km/disk/view.action?_type=2"><span>{*[cn.myapps.km.disk.my_disk]*}</span></a></li>
			<li id="archiveDisk"><a _url="../../km/disk/view.action?_type=5"><span>{*[cn.myapps.km.disk.archive_disk]*}</span></a></li>
			<li id="baike"><a _url="../../km/baike/entry/doInit.action"><span>{*[km.encyclopedia]*}<font style="font-size:9pt;color:red;">(beta)</font></span></a></li>
		</ul>
	</div>
	<iframe id="center" src="" style="border:0px; margin:0px; padding:0px;" frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='auto' allowtransparency='yes'></iframe>
	</div>
</body>
</html>
</o:MultiLanguage>