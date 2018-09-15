<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="css/theme.css"/>
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<title>调查问卷模块</title>
<script type="text/javascript">
var USER = {
		id:'<s:property value="#session.FRONT_USER.getId()" />',
		name:'<s:property value="#session.FRONT_USER.getName()" />',
		domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />',
		admin: '<s:property value="#session.FRONT_USER.getId()" />'=='true'
			};

	var $clickView;
	$(document).ready(function() {
		var $pos = $('#lanPos');
		$pos.css('top', $('#qm_left').offset().top);
		$('#qm_left ul li').hover(function() {
			$pos.css('top', $(this).offset().top);
		}, function() {
			$pos.css('top', $('#qm_left .hover').offset().top);
		});
		$('#qm_left ul li').eq(0).addClass('hover');
		$('#qm_left ul li').click(function() {
			for (var i = 0; i < $('#qm_left ul li').size(); i++) {
				var type = $(this).attr("data-target");
				if (this == $('#qm_left ul li').get(i)) {
					$('#qm_left ul li').eq(i).addClass('hover');
				} else {
					$('#qm_left ul li').eq(i).removeClass('hover');
				}
				switch (type) {
				case "homepage": {
					var $iframe = $("#frame");
					$iframe.attr("src", "answer/index.jsp");
					$iframe.load();
					break;
				}
				case "mine": {
					var $iframe = $("#frame");
					$iframe.attr("src", "questionnaire/list.action");
					$iframe.load();
					break;
				}
				}
			}
		});
		$("#qm_right").width($(window).width()-140);
	});
</script>
</head>
<body>
<div id="qm_left">
		<ul>
			<li data-target="homepage" id="left_iconbg" ><a>待填写</a></li>
			<li data-target='mine' id='left_iconbg2' ><a>问卷中心</a></li>
			<div id='lanPos'></div>
		</ul>
	</div>
<div id="qm_right">
		<iframe id="frame" src="answer/index.jsp" width="100%"
			height="100%" style="border: none;"> </iframe>
	</div>
</body>
</html>