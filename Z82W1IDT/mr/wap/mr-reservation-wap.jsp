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
		
		<!-- layer -->
		<script src="../layer/layer.min.js"></script>
		<script type="text/javascript" src="../laydate/laydate.js" ></script>
		<script type="text/javascript" src="../js/wap/mr.mobile.core.js" ></script>
		<script type="text/javascript" src="../js/wap/mr.data.js" ></script>
		<script type="text/javascript" src="../js/wap/mr.utils.js" ></script>
		<link href="../js/plugin/jquery-ui/jquery-ui.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../js/plugin/jquery.tmpl.js"></script>
		
		
		<style type="text/css">
		.center{
			width:100%;
		}
		.reservation-table{
			width:100%;
			border: 1px solid black;
		}
		.reservation-table td{
			background: #FFFFFF;
		}
		.reservation-box{
			padding: 5%;
		}
		</style>

	</head>

	<body>
		<div><a href="index.jsp" data-role="button" data-icon="arrow-l">返回</a></div>	
		<div class="top" >
			<select id="mr-reservation-area-list" title="区域">
                <option value="one">区域</option>
			</select>
			<select id="mr-reservation-room-list" title="会议室">
                <option value="one">会议室</option>
			</select>
			
			<div class="mr-button-block">
				<input type="text" placeholder="YYYY-MM-DD" id="hello" class="laydate-icon"/>
			</div>

		</div>
		
		<div class="center" >
			<table data-mode="reflow" class="reservation-table" id="reservation-tableid">
				<tr>
					<td data-status="0">9:00-9:30</td>
					<td data-status="0">9:30-10:00</td>
					<td data-status="0">10:00-10:30</td>
				</tr>
				<tr>
					<td data-status="0">10:30-11:00</td>
					<td data-status="0">11:00-11:30</td>
					<td data-status="0">11:30-12:00</td>
				</tr>
				<tr>
					<td data-status="0">12:00-12:30</td>
					<td data-status="0">12:30-13:00</td>
					<td data-status="0">13:00-13:30</td>
				</tr>
				<tr>
					<td data-status="0">13:30-14:00</td>
					<td data-status="0">14:00-14:30</td>
					<td data-status="0">14:30-15:00</td>
				</tr>
				<tr>
					<td data-status="0">15:00-15:30</td>
					<td data-status="0">15:30-16:00</td>
					<td data-status="0">16:00-16:30</td>
				</tr>
				<tr>
					<td data-status="0">16:30-17:00</td>
					<td data-status="0">17:00-17:30</td>
					<td data-status="0">17:30-18:00</td>
				</tr>
			</table>
		</div>
		
		<div data-role="popup" id="mr-reservation-box" class="reservation-box">
			<div id="reservation-box-close"></div>
			<div class="reservation-box-css">
				<h3 align="center" id="meeting_title">预定会议</h3>
		    		<table class="table_css">
		    		<tr><td>会议名称：</td><td><input type="text" id="reservation_name" value=""/></td></tr>
		    		<tr><td>会议内容：</td><td><textarea id="reservation_content"></textarea></td></tr>
		    		<tr><td>预定人电话：</td><td><input type="tel" id="reservation_number" value=""/></td></tr>
		    		<tr><td>会议时间：</td><td>
		    		<input id="reservation_starttime" placeholder="YYYY-MM-DD hh:mm"/><input id="reservation_endtime"  placeholder="YYYY-MM-DD hh:mm"/></td></tr>
		    		</table>
		    		
		    		<input type="hidden" id="reservation_id" value=""/>
					<input type="button" value="保存" onclick="savereservation();" class="button-css"/>
					<input type="button" value="关闭" onclick="res_close();" class="button-css"/>
		    </div>
		</div>
		
<script>
laydate({
    elem: '#hello', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD', //日期格式
        choose: function(datas){
			MR.reservation(3,datas);
		}
});
laydate({
    elem: '#reservation_starttime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD hh:mm', //日期格式
        choose: function(datas){
		}
});
laydate({
    elem: '#reservation_endtime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD hh:mm', //日期格式
        choose: function(datas){
		}
});
</script>

		<script type="text/javascript">
		
		$(document).ready(function(){
			document.getElementById("hello").value = Utils.getToday();
			MR.init();
			MR.area();
			MR.room($("#mr-reservation-area-list").find("option:selected").attr("data-id"));
			MR.reservation(2,$("#mr-reservation-room-list").find("option:selected").attr("data-id"));
		});
		</script>


<script id="tmplAreaListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script> 
					
<script id="tmplRoomListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script> 
	</body>

	</html>
