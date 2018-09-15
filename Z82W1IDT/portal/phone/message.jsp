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
	color: #595959;
	text-align: center;
	border-bottom: 1px solid #e6e6e6;
}

#menu_bar li a span.active {
	background: #efe4b0 url('./resource/main/images/bg-actived.png')
		no-repeat right center;
	border-right: 0px;
}
</style>
	<script src="./resource/jquery/jquery1.11.1.min.js"></script>
	<script type="text/javascript"
		src="./resource/jquery/jquery.layout-latest.js"></script>

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
				initClosed : true
			});

			$("#menu_bar>li>a>span")
					.click(
							function() {
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
			$("#im>a>span").trigger("click");

			setTimeout(function() {
				$layout.open("west");

			}, 300);
		});
	</script>
</head>
<body>
	<div id="west"
		style="padding: 0px; border: 1px solid #e6e6e6; overflow: visible; background: #f5f5f5;">
		<ul id="menu_bar">
			<li id="im"><a
				_url="../personalmessage/query.action?id=11e1-7f98-53d7e5e8-a04d-05b43c063ac2&messageType=0"><span style="word-break: break-all;text-overflow:ellipsis; white-space:nowrap; overflow:hidden; ">{*[message.instation_GoNews]*}</span></a></li>
			<li id="sms"><a
				_url="../shortmessage/submission/list.action?application=11de-f053-df18d577-aeb6-19a7865cfdb6"><span style="word-break: break-all;text-overflow:ellipsis; white-space:nowrap; overflow:hidden; ">{*[message.phone_SMS]*}</span></a></li>
		</ul>
	</div>
	<div id="center" src=""
		style="padding: 0px; margin: 0px; border: 0px; overflow: hidden;"></div>
	</div>
</body>
</html>
</o:MultiLanguage>