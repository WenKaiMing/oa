<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>会议预定</title>
		<link href="css/style1.css" type="text/css" rel="stylesheet" />
		<link href="css/timeline.css" type="text/css" rel="stylesheet" />
		<link href="css/messenger.css" type="text/css" rel="stylesheet" />
		<link href="css/messenger-theme-flat.css" type="text/css" rel="stylesheet" />
		<!-- jquery-ui 1.11 -->
		<script type="text/javascript" src="./js/plugin/jquery.js"></script>
		
		<script type="text/javascript" src="./js/plugin/messenger/messenger.min.js"></script>
		<script type="text/javascript" src="./js/plugin/messenger/messenger-theme-flat.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$(".p_right").css("height",($(window).height()+"px"));
			});
		</script>
		
		<!-- layer -->
		<script src="layer/layer.min.js"></script>
		<script type="text/javascript" src="mylayer.js" ></script>
		<script type="text/javascript" src="laydate/laydate.js" ></script>
		<script type="text/javascript" src="js/mr.core.js" ></script>
		<script type="text/javascript" src="js/mr.utils.js" ></script>
		<script type="text/javascript" src="./js/plugin/jquery.tmpl.js"></script>
		
		<!-- bootstrap -->
		<link href="bootstrap-3.3.4-dist/css/bootstrap.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="bootstrap-3.3.4-dist/js/bootstrap.js"></script>
	</head>

	<body style="background-color: #f7f7f7;">
	<div class="container-fluid" style="height:100%;background-color: #f7f7f7;">
	<div class="page-header" style="height:100%;margin:15px 0 0 0;font-family:'Microsoft YaHei'">
		<div class="row" style="height:100%">
			<div class="col-xs-2" style="height:100%;">
			<ul class="nav nav-tabs nav-stacked" style="height:100%;box-shadow:2px 1px 3px #c0c0c0;background-color: white;">
				<li><h2 style="text-align: center;color:#df4c32;font-size:28px;font-family:'Microsoft YaHei';margin:20px 0;">会议室</h2></li>
				<li class="nav-item mr-reservation" style="margin:10px 0;" data-target="mr-page-reservation">
					<a href="javascript:void(0);" style="overflow:hidden;">
						<span class="img_a"></span>
						&nbsp;&nbsp;&nbsp;<span style="font-size:18px;float:left;">会议室预定</span>
					</a>
				</li>
				<li class="nav-item mr-management" style="margin:10px 0;" data-target="mr-page-management">
					<a href="javascript:void(0);" style="overflow:hidden;">
						<span class="img_a1"></span>
						&nbsp;&nbsp;&nbsp;<span style="float:left;font-size:18px;">会议室管理</span>
					</a>
				</li>
				<li class="nav-item mr-myreservation" style="margin:10px 0;" data-target="mr-page-myreservation">
					<a href="javascript:void(0);" style="overflow:hidden;">
						<span class="img_a2"></span>
						&nbsp;&nbsp;&nbsp;<span style="float:left;font-size:18px;">我的预定</span>
					</a>
				</li>
			</ul>
			</div>
		

		<div class="col-xs-10" style="padding:0 10px 0 0;">
			<!--
	<div class="top">
		<input type="button" name="today" value="今天" />
		<input type="text" class="date" name="date" value="2014-10-24" />
		<span class="radioset">			
			<input type="radio" id="radio1" name="radio" ><label for="radio1">明天</label>
			<input type="radio" id="radio2" name="radio" ><label for="radio2">本周</label>
			<input type="radio" id="radio3" name="radio" checked="checked"><label for="radio3">本月</label>
			<input type="radio" id="radio4" name="radio" ><label for="radio4" style="float:right; margin-right:15px; margin-top: 13px;">全部</label>
		</span>
	</div>	
	-->
			<div class="pm_page_container" id="container" >
				<%@ include  file="mr-reservation.jsp"%>
				<%@ include  file="mr-management.jsp"%>
				<%@ include  file="mr-myreservation.jsp"%>
			</div>
		</div>
		<!-- 遮罩层 -->
		<div class="mask"></div>
		<script type="text/javascript">
			var USER = {
				id:'<s:property value="#session.FRONT_USER.getId()" />',
				name:'<s:property value="#session.FRONT_USER.getName()" />',
				domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
					};

			$(document).ready(function(){
				$.ajaxSetup({
	                error:function(x,e){
					Utils.showMessage("请求服务端发生异常,请稍后尝试！","error");
	                    return false;
	                }
	            });	
	            
				MR.reservation();
	        	MR.area();
	        	document.getElementById("hello").value = Utils.getToday();
	        	$("body").css({ height:document.documentElement.clientHeight-15});
	        	$("#mr-reservation-div").height(
						document.documentElement.clientHeight-45-53-25
			    );
	        	$("#mr-management-div").height(
						document.documentElement.clientHeight-45-53-25
			    );
	        	$("#mr-myreservation-div").height(
						document.documentElement.clientHeight-45-53-25
			    );
				window.onresize = function(){
					$("#mr-reservation-div").height(
							document.documentElement.clientHeight-45-53-25
				    );
					$("#mr-management-div").height(
							document.documentElement.clientHeight-45-53-25
				    );
		        	$("#mr-myreservation-div").height(
							document.documentElement.clientHeight-45-53-25
				    );
					$("body").css({ height:document.documentElement.clientHeight-15});
					Utils.closeReservationPanel();
					Utils.closeManagementPanel();
					Utils.closeMyReservationPanel();
				};
			});
			MR.init();
			readygo();
			//PM.init();
			
		</script>
		</div>
		</div>
	</div>
	</body>

	</html>