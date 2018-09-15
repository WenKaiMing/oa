<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
	<!DOCTYPE html>
	<html>
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>我的预定</title>
		
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
			background: black;
		}
		.reservation-box-wap{
			background: #FFFFFF;
			text-align: center;
			padding: 5%;
		}
		.mr-button-block{
			width: 100%
		}
		.table_css{
			width:100%;
			border: 1px solid black;
		}
		.table_css td{
			background: #FFFFFF;
		}
		</style>
	</head>

	<body>
		<div><a href="index.jsp" data-role="button" data-icon="arrow-l">返回</a></div>
		<div class="top" >
			<select id="mr-myreservation-area-list" title="区域">
                <option value="one">区域</option>
			</select>
			<select id="mr-myreservation-room-list" title="会议室">
                <option value="one">会议室</option>
			</select>
			<div class="mr-button-block">
				<input placeholder="开始时间" id="start" class="laydate-icon"/>
				<input placeholder="结束时间" id="end" class="laydate-icon"/>
			</div>
		</div>
		<div class="center">
		</div>
		
		<div id="mr-myreservation-div">
			<table  id="mr-myreservation-table" class="table_css" data-mode="reflow">
				<tbody>
				<tr class="row1">
					<td >会议名称</td>
					<td >会议内容</td>
					<td >会议时间</td>
					<td >会议区域</td>
					<td >会议室</td>
					<td >预定人电话</td>
					<td ></td>
				</tbody>
				<tbody class="myreservation" id="mr-myreservation-table-body" style="cursor: pointer;"></tbody>
			</table>
			 <div class="pagescss">&nbsp;<a onclick="Utils.lastPage();" href="javascript:void(0);">上一页</a> &nbsp;&nbsp;&nbsp;-<a id="currPages">1</a>-&nbsp;&nbsp;&nbsp;  总共<a id="countPages">1</a>页&nbsp;&nbsp;&nbsp;  <a onclick="Utils.nextPage();" href="javascript:void(0);">下一页</a></div>
		</div>
		
		<div id="mr-myreservation-box" class="reservation-box-wap" data-role="popup">
			<div id="myreservation-box-close"></div>
			<div class="myreservation-box-css">
					<div class="box_title"><h3>会议</h3></div>
		    		<table>
		    		<tr><td>会议名称：</td><td><input type="text" id="myreservation_name" value=""/></td></tr>
		    		<tr><td>会议内容：</td><td><textarea id="myreservation_content" ></textarea></td></tr>
		    		<tr><td>预定人电话：</td><td><input type="tel" id="myreservation_creatorTel" value=""/></td></tr>
		    		<tr><td>会议时间：</td><td><input id="myreservation_starttime" placeholder="YYYY-MM-DD hh:mm"/>
		    		<br/><input id="myreservation_endtime"  placeholder="YYYY-MM-DD hh:mm"/></td></tr>
		    		<tr><td>会议区域：</td><td><select id="mr-myreservation-pop-area" name="selse"></select></td></tr>
		    		<tr><td>会议室：</td><td><select id="mr-myreservation-pop-room" name="selse"></select></td></tr>
		    		</table>
		    		<input type="hidden" id="myreservation_id" value=""/>
					<input type="button" value="保存" onclick="updateMyreservation();" class="button-css"/>
		    		<input type="button" value="删除" onclick="deleteMyreservation();" class="button-css"/>		    		
		    		<input type="button" value="关闭" onclick="myr_close();" class="button-css"/>
		    </div>
		   
		</div>

		
<script>
laydate({
    elem: '#start', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD', //日期格式
        choose: function(datas){
			end.min = datas; //开始日选好后，重置结束日的最小日期
   	 		end.start = datas; //将结束日的初始值设定为开始日
   	 		MR.cache.date = datas;
    		MR.myreservation();
		}
});
laydate({
    elem: '#end', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD', //日期格式
        choose: function(datas){
			start.max = datas; //结束日选好后，重置开始日的最大日期
			MR.cache.date2 = datas;
    		MR.myreservation();
		}
});

laydate({
    elem: '#myreservation_starttime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD hh:mm', //日期格式
        choose: function(datas){
		}
});
laydate({
    elem: '#myreservation_endtime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD hh:mm', //日期格式
        choose: function(datas){
		}
});
</script>
<script id="tmplAreaListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script> 
					
<script id="tmplRoomListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script>
<script id="tmplAreaSelectItem" type="text/x-jquery-tmpl">
	<option value="${id}" class="mr-pop-area-option">${name}</option>
</script> 
<script id="tmplRoomSelectItem" type="text/x-jquery-tmpl">
	<option value="${id}" class="mr-pop-room-option">${name}</option>
</script> 

<script id="tmplMyreservationTableListItem" type="text/x-jquery-tmpl">
		<tr class="row1" id="${id}">
			<td >${name}</td>
			<td >${content}</td>
			<td >${startTime} to<br> ${endTime}</td>
			<td >${area}</td>
			<td >${room}</td>
			<td >${creatorTel}</td>
			<td ><input type="button" data-role="button" name="${id}" value="修改" onclick="myreservation_show('${id}');"/></td>
		</tr>
</script>
<script type="text/javascript">
		MR.init();
		MR.myreservation();
		MR.area_myr_list();
		MR.room_myr_list($("#mr-myreservation-area-list").find("option:selected").attr("data-id"));
		</script>
	</body>
	</html>
