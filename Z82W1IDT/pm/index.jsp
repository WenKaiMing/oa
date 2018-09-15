<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
	<!DOCTYPE html>
	<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>任务管理系统</title>
		<link href="css/style.css" type="text/css" rel="stylesheet" />
		<link href="css/timeline.css" type="text/css" rel="stylesheet" />
		<link href="css/messenger.css" type="text/css" rel="stylesheet" />
		<link href="css/messenger-theme-flat.css" type="text/css" rel="stylesheet" />
		<link href="css/font-awesome.min.css" type="text/css" rel="stylesheet" />
		<!-- jquery-ui 1.11 -->
		<script type="text/javascript" src="./js/plugin/jquery.js"></script>
		<script type="text/javascript" src="./js/plugin/jquery.tmpl.js"></script>
		<!-- 通知插件--start -->
		<link href="./js/plugin/toastr/toastr.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="./js/plugin/toastr/toastr.min.js"></script>
		<!-- 通知插件--end -->
		<script type="text/javascript" src="./js/plugin/bootstrap/bootstrap.min.js" ></script>
		<!-- 弹出层插件--start -->
		<script type="text/javascript" src="./js/plugin/artDialog/jquery.artDialog.js?skin=aero" ></script>
		<script type="text/javascript" src="./js/plugin/artDialog/artDialog.source.js" ></script>
		<script type="text/javascript" src="./js/plugin/artDialog/plugins/iframeTools.source.js" ></script>
		<!-- 弹出层插件--end -->
		<script type="text/javascript" src="./js/plugin/jquery-ui/jquery-ui.min.js" ></script>
		<script type="text/javascript" src="./js/plugin/jquery-ui/jquery-ui.datepicker-zh-CN.js" ></script>
		<link href="./js/plugin/jquery-ui/jquery-ui.min.css" type="text/css" rel="stylesheet" />
		<link href="./js/plugin/jquery-ui/jquery-ui.theme.min.css" type="text/css" rel="stylesheet" />
		<link href="./js/plugin/jquery-ui/jquery-ui.structure.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="./js/plugin/fullcalendar/lib/moment.min.js"></script>
		<script type="text/javascript" src="./js/plugin/fullcalendar/fullcalendar.min.js"></script>
		<script type="text/javascript" src="./js/plugin/fullcalendar/lang/zh-cn.js"></script>
		<link href="./js/plugin/fullcalendar/fullcalendar.min.css" type="text/css" rel="stylesheet" />
		
		<script type="text/javascript" src="./js/plugin/viewer/viewer.min.js"></script>
		<link href="./js/plugin/viewer/viewer.min.css" type="text/css" rel="stylesheet" />
		
		<script type="text/javascript" src="../portal/H5/resource/script/jquery.slimscroll.min.js" ></script>
		<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
		<!-- 分页 -->
		<link href="../portal/H5/resource/script/jquery.pagination/jquery.pagination.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../portal/H5/resource/script/jquery.pagination/jquery.pagination.js" ></script>
		<script type="text/javascript" src="../portal/H5/resource/script/common.js" ></script>
		<script type="text/javascript" src="../portal/H5/resource/js/holmes.js"></script>
		<script type="text/javascript" src="../portal/H5/resource/js/holmes.js"></script>
		<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
		
		<script type="text/javascript">
		var contextPath = '<%=request.getContextPath()%>';
			$(function(){
				$(".p_right").css("height",($(window).height()+"px"));
			});
		</script>
		
		<!--  上传附件   -->
		<link rel="stylesheet" type="text/css" href="./js/uploadify/uploadify.css">
    	<script type="text/javascript" src="./js/uploadify/jquery.uploadify.js"></script>  
    	
	    <!-- webuploader 引入CSS-->
		<link rel="stylesheet" type="text/css" href="<s:url value='/pm/js/plugin/webuploader/webuploader.css'/>" />
		<!-- webuploader 引入JS-->
		<script type="text/javascript" src="<s:url value='/pm/js/plugin/webuploader/webuploader.js'/>" ></script>
    
	</head>

	<body>

		<div class="p_left">
			<ul class="nav">
				<li class="nav-item pm-task" data-target="pm-page-task">
					<a class="selected" href="javascript:void(0);">
						<img src="images/sidenav_li_a1h.png"><span>任务</span>
					</a>
				</li>
				<li class="nav-item pm-follow" data-target="pm-page-follow">
					<a href="javascript:void(0);">
						<img src="images/sidenav_li_a.png"><span>关注</span>
					</a>
				</li>
				<li class="nav-item pm-project" data-target="pm-page-project">
					<a href="javascript:void(0);">
						<img src="images/sidenav_li_a2.png"><span>项目</span>
					</a>
				</li>
				<li class="nav-item pm-activity" data-target="pm-page-activity">
					<a href="javascript:void(0);">
						<img src="images/sidenav_li_a4.png"><span>动态</span>
					</a>
				</li>
			</ul>
		</div>

		<div class="p_right">
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
			<div class="pm_page_container" id="container">
				<%@ include  file="part-project.jsp"%>
				<%@ include  file="part-task.jsp"%>
				<%@ include  file="part-task-list.jsp"%>
				<div id="pm-task-info" style="position: absolute; top: 0px; right: 0px; z-index: 15; width: 0px;"></div>
				<div id="pm-task-pic-view" style="display:none"><img src="" ><i class="pm-task-pic-view-close fa fa-times"></i></div>
			</div>
		</div>
		<!-- 遮罩层 -->
		<div class="mask"></div>
		<script type="text/javascript" src="./js/pm.upload.js"></script>
		<script type="text/javascript" src="./js/pm.core.js"></script>
		<script type="text/javascript" src="./js/pm.utils.js"></script>
		<script type="text/javascript" src="./js/pm.service.js"></script>
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
			});
			PM.init();
		</script>
		
	</body>

	</html>