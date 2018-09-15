<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<html lang="en">

<head>
<%
String domainId = (String)request.getParameter("domain");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业管理员</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/swiper.css">
<link rel="stylesheet" href="./css/admin.css">

</head>
<body>
	<div class="adminContent">
		<h1>企业管理员</h1>
		
		<div class="batch_import" data-target="initDisk">
			<img src="./images/import.png" alt="批量导入"/>
			<div class="dec">批量导入</div>
		</div>
		<div class="document_classify" data-target="manageCategory">
			<img src="./images/document.png" alt="分类设置"/>
			<div class="dec">分类设置</div>
		</div>
		<div class="batch_authorization" data-target="kmRole">
			<img src="./images/authorization.png" alt="批量授权"/>
			<div class="dec">批量授权</div>
		</div>
		<div class="index_rebuilt" data-target="index">
			<img src="./images/index.png" alt="全文索引重建"/>
			<div class="dec">全文索引重建</div>
		</div>
	</div>

<script src="./js/jquery-2.1.4.js"></script>
<script>
var domainId = '<%=domainId%>';
var isStartInitDisk;
	$(function(){
		StartInitDisk();
		if(!isStartInitDisk){
			var adminContentWidth = $(".adminContent>div").width()*3+80;
			$(".adminContent").width(adminContentWidth);
			$(".batch_import").hide();
		}
		$(".adminContent>div").click(function(){
			var target = $(this).attr("data-target");
			switch(target){
			case "initDisk" :
				openInitDisk();
				break;
			case "manageCategory" :
				manageCategory();
				break;
			case "kmRole" :
				kmRole();
				break;
			case "index" :
				openIndex();
				break;
			};
		});
	});
	function openInitDisk(){
		var url = '<s:url value="/km/admin/initDisk.jsp"/>';
		OBPM.dialog.show({
			opener : window.top,
			width : 720,
			height : 350,
			url : url,
			args : {},
			title : "KM初始使用向导",
			close : function() {
			}
		});
	}
	function openIndex(){
		var url = '<s:url value="/km/admin/indexing.jsp"/>';
		OBPM.dialog.show({
			opener : window.top,
			width : 720,
			height : 350,
			url : url,
			args : {},
			title : "全文索引重建",
			close : function() {
				$(".startToBuilt").attr("disabled",false);
			}
		});
	}
	function manageCategory(){
		OBPM.dialog.show({
			opener : window.top,
			width : 720,
			height : 400,
			url : contextPath + "/km/category/list.jsp",
			args : {},
			title : "文档分类设置",
			maximized: false, // 是否支持最大化
			close : function() {
			}
		});
	}
	function kmRole(){
		OBPM.dialog.show({
			opener : window.top,
			width : 820,
			height : 500,
			url : contextPath + "/portal/sysconfig/configure.action?domainId="+domainId,
			args : {},
			title : "KM角色授权",
			maximized: false, // 是否支持最大化
			close : function() {
			}
		});
	}
	function StartInitDisk(){
		$.ajax({
			  type: 'POST',
			  url: "../../km/disk/isStartInitDisk.action",
			  dataType:"json",
			  async:false,
			  success: function(result){
				  isStartInitDisk = result.data;
				  return isStartInitDisk;
			  },
			});
	}
</script>

</body>
</html>