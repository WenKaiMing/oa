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
	
#west {
border:1px solid #fafafa;
	margin:18px 0px 0px 5px!important;
	left: 10px!important;
	padding:0px;
}

#center {
left:130px!important;
}

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
	margin: 0px;
	text-decoration: none;
	list-style-type: none;
	height:50px;
}

#menu_bar li a {
	cursor: pointer;
}

#menu_bar li a span {
	width: 100px;
	height: 50px;
	display: block;
	font-size: 16px;
	font-style: normal;
	line-height: 50px;
	color:#666;
	font-family: Microsoft YaHei, tahoma, arial;
	text-align: center;
	word-break: break-all;
	text-overflow:ellipsis;
	white-space:nowrap;
	overflow:hidden;
}

#menu_bar li a span.active {
	background: #fff;
	border-right: 0px;
	color:#2679ff;
	font-family: Microsoft YaHei, tahoma, arial;
}
#menu_bar li a span font{
	font: 12px 'Microsoft YaHei, tahoma, arial';
}
#menu_bar li a span.active font{
	color:#2679ff;
}

.act_title {
	height: 63px;
	line-height: 63px;
	text-align: center;
	font-size: 20px;
	color: #e58050;
	font-family: Microsoft YaHei, tahoma, arial;
	font-weight: bold;
}

#menu_bar li a span div {
	background-image: url('resource/launchpad/menuPic.png');
	background-repeat: no-repeat;
	display: inline-block;
	width: 22px;
	height: 18px;
	_display: block;
	_float: left;
	_margin-top: 12px;
	_margin-left: 5px;
}

#menu_bar li a span.active div{
	background-position-y: -18px;
}

.launch_pic {
	background-position-y: 2px;
}

.pending_pic {
	background-position-x: -24px;
	background-position-y: 2px;
}

.processed_pic {
	background-position-x: -46px;
	background-position-y: 2px;
}

.finished_pic {
	background-position-x: -68px;
	background-position-y: 2px;
}

.dashboard_pic {
	background-position-x: -90px;
	background-position-y: 2px;
}
</style>
	<script src="./resource/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript"
		src="./resource/jquery/jquery.layout-latest.js"></script>

	<link type="text/css" rel="stylesheet"
		href="./resource/jquery/jquery.loadmask.css">
	<script type="text/javascript"
		src="./resource/jquery/jquery.loadmask.js"></script>
	
	<script type="text/javascript">
		var $layout;
		$(function() {
			$layout = $('body').layout({
				center__paneSelector : "#center",
				west__paneSelector : "#west",
				togglerClass : "togglerClass",
				resizerClass : "resizerClass",
				spacing_open : 0,
				spacing_close : 0,
				west__size : 100,
				west__minSize : 100,
				west__maxSize : 100,
				west__animatePaneSizing : true,
				west__fxSpeed_size : 200,
				west__fxSpeed_open : 500,
				west__fxSettings_open : {
					easing : "bounce"
				},
				west__fxName_close : "none",
				west__showOverflowOnHover : true,
				//			stateManagement__enabled : true
				initClosed : false
			});

			$("#menu_bar>li>a>span")
					.click(
							function() {
								//mask
								$("#menu_bar>li>a>span.active").removeClass(
										"active");
								$(this).addClass("active");
								var url = $(this).parent().attr("_url");
								var id = "iframe_"
										+ $(this).parent().parent().attr("id");
								//$("#center").attr("src", url);
								$("iframe").hide();
								if ($("#" + id).size() <= 0) {
									$(
											"<iframe id='"
													+ id
													+ "' style='border:0px solid red' width='100%' height='100%' frameborder='no' border='0'></iframe>")
											.appendTo($("#center")).attr(
													"src", url).show();
								} else {
									$("#" + id).show();
								}
							});

			//选择第一个
			$("#launch>a>span").trigger("click");

//			setTimeout(function() {
//				$layout.open("west");
//			}, 300);
		});
	</script>
</head>
<body>
	<div id="west"
		style="padding: 0px; border: 1px solid #e6e6e6; overflow: visible; background: white;">
		<div class="act_title">Actions</div>
		<ul id="menu_bar">
			<li id="launch">
				<a _url="startFlow.jsp"><span><div class="launch_pic"></div>{*[flow.start]*}<font>{*[New]*}</font></span></a>
			</li>
			<li id="pending">
				<a _url="pending.jsp"><span><div class="pending_pic"></div>{*[flow.Pending]*}<font>{*[flow.my]*}</font></span></a></li>
			<li id="processed">
				<a _url="processing.jsp"><span><div class="processed_pic"></div>{*[flow.processing]*}<font>{*[flow.unfinished]*}</font></span></a>
			</li>
			<li id="finished">
				<a _url="finished.jsp"><span><div class="finished_pic"></div>{*[History]*}<font>{*[flow.finish]*}</font></span></a>
			</li>
			<li id="dashboard">
				<a _url="dashboard.jsp"><span><div class="dashboard_pic"></div>{*[flow.instrument]*}<font>{*[flow.analyze]*}</font></span></a>
			</li>
		</ul>
	</div>
	<div id="center" src=""
		style="padding: 0px; margin: 0px; border: 0px; overflow: hidden;"></div>
	</div>
</body>
</html>
</o:MultiLanguage>