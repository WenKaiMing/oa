<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="pm-page mr-page-reservation" style="height: 100%;">

	<div class="pm-tool-bar" id="pm-tool-bar" style="height: 53px;padding:10px;background-color:white;margin-bottom:15px;box-shadow:0px 2px 1px #c0c0c0;">
			<div class="mr-button-block">
				<input type="button" value="会议预定" onclick="popinitreservation();" class="btn btn-primary" style="margin-right:15px;"/>
				<input placeholder="YYYY-MM-DD" id="hello" class="laydate-icon" style="padding: 0 5px;width:150px;height:27px;border-radius: 4px;"/>
			</div>
<script>
laydate({
    elem: '#hello', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus', //响应事件。如果没有传入event，则按照默认的click
    	istime: true,//是否开启时间选择
        istoday: true, //是否显示今天
        format: 'YYYY-MM-DD', //日期格式
        choose: function(datas){
    		MR.reservation("3",datas);
		}
});
</script>			
		
			<div class="mr-list-block"><span class="mr-list-block-icon">会议室&nbsp;<img src="images/down.png"></span>
				<ul id="mr-reservation-room-list">
				</ul> 
			</div>
			<div class="mr-list-block"><span class="mr-list-block-icon">区域&nbsp;<img src="images/down.png"></span>
				<ul id="mr-reservation-area-list">
				</ul>
			</div>
			
			<div style="float:right;">
				<div style="background-color:#ff9f02;float:left;border:1px solid black;width:18px;height:18px;margin:10px 5px 0 0;"></div><div style="float:left;margin:10px 15px 0 0">已预定</div>
			</div>
			<div style="float:right;">
				<div style="float:left;border:1px solid black;width:18px;height:18px;margin:10px 5px 0 0;"></div><div style="float:left;margin:10px 15px 0 0">未预定</div>
			</div>
			
			
			<div class="clr"></div>
	</div>
		
	<div id="mr-reservation-container" style="height:100%;">
		
		<div id="mr-reservation-div" style="box-shadow:0px 1px 1px #c0c0c0;height:auto;width:100%;padding:15px;background-color:white;overflow:auto;float:left;">
		<table border="1" class="table-hover" id="mr-reservation-table" style="width:100%;min-width:1000px;border-color:#a7a7a7;border: 1px solid #a7a7a7;">
		<tbody class="reservation">
			<tr class="row1 row_first" style="background-color: #f7f7f7;color:#606060;">
				<td  width="7%"></td>
				<td colspan="2" width="7%">9:00-10:00</td>
				<td colspan="2" width="7%">10:00-11:00</td>
				<td colspan="2" width="7%">11:00-12:00</td>
				<td colspan="2" width="7%">12:00-13:00</td>
				<td colspan="2" width="7%">13:00-14:00</td>
				<td colspan="2" width="7%">14:00-15:00</td>
				<td colspan="2" width="7%">15:00-16:00</td>
				<td colspan="2" width="7%">16:00-17:00</td>
				<td colspan="2" width="7%">17:00-18:00</td>
			</tr>
		</tbody>
		<tbody class="reservation" id="mr-reservation-table-body" style="color: #a7a7a7;"></tbody>

		</table>
		</div>
		
		<div id="mr-reservation-box" class="reservation-box" style="overflow:auto;">
			<div id="reservation-box-close"></div>
			<div class="myreservation-box-css">
				<h3><div class="box_title" id="meeting_title" >会议</div></h3>
		    	<hr></hr>
		    	<table class="table_css">
		    		<tr><td>会议名称：</td><td><span style="color:#E51700;">*</span><input type="text" id="reservation_name" value="" class="td_box"></input></td></tr>
		    		<tr><td>会议内容：</td><td><span style="color:#ffffff;">*</span><textarea id="reservation_content" value="" class="td_box1"></textarea></td></tr>
		    		<tr><td>预定人电话：</td><td><span style="color:#ffffff;">*</span><input type="tel" id="reservation_number" value="" class="td_box"/></td></tr>
		    		<tr><td>开始时间：</td><td><span style="color:#E51700;">*</span><input class="td_box laydate-icon" type="text" value="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})" id="reservation_starttime" style="width:170px;height:27px;padding:2px;"/></td></tr>
		    		<tr><td>结束时间：</td><td><span style="color:#E51700;">*</span><input class="td_box laydate-icon" type="text" value="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})" id="reservation_endtime" style="width:170px;height:27px;padding:2px;"/></td></tr>
		    		<tr><td>区域：</td><td><span style="color:#E51700;">*</span><select class="td_box" id="mr-reservation-pop-area" name="selse"></select></td></tr>
		    		<tr><td>会议室：</td><td><span style="color:#E51700;">*</span><select class="td_box" id="mr-reservation-pop-room" name="selse"></select></td></tr>
		    	</table>
		    	<input type="hidden" value="" id="reservation_id"/>
		    		<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;保 存" onclick="savereservation();" class="btn btn-success btn-sm" style="margin-left:130px;background:url(images/icon_03.png) 5px 6px no-repeat;background-color:#7BC57B;"/>
		    		<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;删  除" onclick="deleteReservation();" class="btn btn-default btn-sm" style="margin-left:20px;background:url(images/icon_02.png) 5px 6px no-repeat;"/>
			</div>
		</div>
		
	</div>
</div>

<script id="tmplReservationTableListItem" type="text/x-jquery-tmpl">
		<tr class="row1" id="${id}" data-areaid="{$areaId}" >
			<td style="font-size:16px;">${name}</td>
			<td style="cursor:pointer;" width="3.5%" class="rowhand" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
			<td style="cursor:pointer;" width="3.5%" title="点击表格进行会议预定"></td><td style="cursor:pointer;" title="点击表格进行会议预定"></td>
		</tr>
</script>    
<script id="tmplAreaListItem" type="text/x-jquery-tmpl">
	<li class="mr-list-block-option" data-id="${id}" style="display:none">${name}</li>
</script> 
					
<script id="tmplRoomListItem" type="text/x-jquery-tmpl">
	<li class="mr-list-block-option" data-id="${id}" style="display:none" >${name}</li>
</script> 


<script id="tmplAreaSelectItem" type="text/x-jquery-tmpl">
	<option value="${id}" class="mr-pop-area-option">${name}</option>
</script> 
<script id="tmplRoomSelectItem" type="text/x-jquery-tmpl">
	<option value="${id}" class="mr-pop-room-option">${name}</option>
</script> 


