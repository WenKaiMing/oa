<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<html>
<head>


	<meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="./resource/css/ratchet.min.css" rel="stylesheet">
    <link href="./resource/css/global.css" rel="stylesheet">
    <script src="./resource/js/jquery.min.js"></script>
    <script src="./resource/js/ratchet.min.js"></script>
    <script src="./resource/js/common.js"></script>
    <script>
	$(function() {
	    $("div.bar-web-con").css("height",$(window).height()-56);
	});
	$(window).resize(function() {$("div.bar-web-con").css("height",$(window).height()-56);});
	</script>



<!-- <link type="text/css" rel="stylesheet" href="./resource/jquery/layout-default-latest.css">
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
	<script src="./resource/jquery/jquery1.11.1.min.js"></script> -->
	<script type="text/javascript" src="./resource/jquery/jquery.layout-latest.js"></script>

	<script type="text/javascript">
		var $layout;
		$(function() {
			$layout = $('body').layout({
				center__paneSelector : "#center",
				south__paneSelector : "#south",
				togglerClass : "togglerClass",
				resizerClass : "resizerClass",
				spacing_open : 0,
				spacing_close : 0,
				south__size : 56,
				south__minSize : 56,
				south__maxSize : 56,
				south__animatePaneSizing : true,
				south__fxSpeed_size : 200,
				south__fxSpeed_open : 500,
				south__fxSettings_open : {
					easing : "bounce"
				},
				south__fxName_close : "none",
				south__showOverflowOnHover : true,
				//			stateManagement__enabled : true
				initClosed : false
			});

			$("#menu_bar>a").click(function() {
				//$("#menu_bar>li>a>span.active").removeClass("active");
				//$(this).addClass("active");
				var url = $(this).attr("_url");
				$("#center").attr("src", url);
			});

			//选择第一个
			$("#personalDisk").trigger("click");
		});
	</script>
</head>
<body>

<div class="bar-web-con">
	<span id="km-iframe" class="control-content active">
		<iframe id="center" src="" style="border:0px; margin:0px; padding:0px;" frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='auto' allowtransparency='yes'></iframe>
	</span>
</div>

<div id="south">
	<div id="menu_bar" class="segmented-control bar-web">
		<a id="personalDisk" class="control-item active" _url="../../km/themes/phone/disk/view.action?_type=2">
			<div class="icon iconfont">&#xe101;</div>{*[cn.myapps.km.disk.my_disk]*}
		</a>
		<a id="hotest" class="control-item" _url="../../km/themes/phone/listHotest.action">
			<div class="icon iconfont">&#xe102;</div>{*[cn.myapps.km.disk.popular_share]*}
		</a>
		<a id="publicDisk" class="control-item" _url="../../km/themes/phone/view.action?_type=1">
			<div class="icon iconfont">&#xe103;</div>{*[cn.myapps.km.disk.public_disk]*}
		</a>
		<a class="control-item">
			<div class="icon iconfont">&#xe615;</div>更多
		</a>
		<!-- <a id="newest" class="control-item" _url="../../km/disk/listNewest.action" data-ignore="push">
			<div class="icon iconfont">&#xe615;</div>{*[cn.myapps.km.latest_upload]*}
		</a>
		<a id="archiveDisk" class="control-item" _url="../../km/disk/view.action?_type=5" data-ignore="push">
			<div class="icon iconfont">&#xe615;</div>{*[cn.myapps.km.disk.archive_disk]*}
		</a>
		<a id="baike" class="control-item" _url="../../km/baike/entry/doInit.action" data-ignore="push">
			<div class="icon iconfont">&#xe615;</div>{*[km.encyclopedia]*}<font style="color:red;">(beta)</font>
		</a> -->
	</div>
</div>

<div id="bar-web-div" style="display:none"></div>

</body>
</html>
</o:MultiLanguage>