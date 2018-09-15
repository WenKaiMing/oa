<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<title>体验</title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link href="./resource/css/animate.css" rel="stylesheet">
<link href="./resource/css/index.css" rel="stylesheet">
<script src="./resource/js/jquery-1.11.3.min.js"></script>
</head>
<body>
	<div class="share">
		<div class="box">
			<div class="share-title">选择体验用户</div>
			<div class="share-content">	
			<form id="sharebox" name="form1"  action="./setUser.jsp" method="post" role="form" >
				<div class="form-group active" value="11e5-975b-abcfab55-8df7-f9d0d3fc48f4">
					<div class="img"><img src="resource/images/dai_self.png"/></div>
					<div class="name">行政专员	</div>
					<div style="clear:both"></div>
				</div>
				<div class="form-group" value="11e4-7b56-045d6210-a888-6d6b162bf5de">
					<div class="img"><img src="resource/images/dai_self.png"/></div>
					<div class="name">行政经理</div>
					<div style="clear:both"></div>
				</div>
				<div class="form-group" value="11e3-8a58-82144b41-9194-1d682b48d529">
					<div class="img"><img src="resource/images/dai_self.png"/></div>
					<div class="name">总经理</div>
					<div style="clear:both"></div>
				</div>
				<button id="submitId" type="submit" class="btn btn-tiyan">开始体验</button>
			</form>
		</div>
		</div>
	</div>
</body>
<script>
	$(function () {
		$("#sharebox .form-group").click(function(){
			$(this).addClass("active").siblings().removeClass("active");
		});
		$("#submitId").click(function(){
			var url = "./setUser.jsp?userid=" + $("#sharebox .form-group.active").attr("value");
			document.forms[0].action = url;
			document.forms[0].submit();
		});
	})
</script>
</html>