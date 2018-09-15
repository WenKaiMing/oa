<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
	<!DOCTYPE html>
	<html>

	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会议室预定</title>
		
		<script type="text/javascript" src="../js/plugin/jquery.js"></script>
		<script src="../layer/layer.min.js"></script>
		<script type="text/javascript" src="../js/wap/jquery.mobile-git.js" ></script>
		<link rel="stylesheet" href="../js/plugin/jqm/jquery.mobile-1.4.5.min.css"/>
		<link rel="stylesheet" href="../js/plugin/mmenu/css/jquery.mmenu.all.css"/>
		<link href="../js/plugin/jquery-ui/jquery-ui.min.css" type="text/css" rel="stylesheet" />
		
		<style>
		a{
			text-decoration:none;
		}
		.center{
			margin: 10% 0 0 0;
		}
		</style>
	</head>

	<body>
		
		<div class="center">
			<a href="mr-reservation-wap.jsp" data-ajax="false"><input type="button" value="会议室预定"></input></a>
			<a href="mr-management-wap.jsp" data-ajax="false"><input type="button" value="会议室管理"></input></a>
			<a href="mr-myreservation-wap.jsp" data-ajax="false"><input type="button" value="我的预定"></input></a>
		</div>
		
	</body>

	</html>