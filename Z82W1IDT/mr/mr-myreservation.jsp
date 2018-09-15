
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" %>
<div class="pm-page mr-page-myreservation" style="height: 100%;">
		
	<div class="pm-tool-bar" style="height:53px;padding:10px;background-color:white;margin-bottom:15px;box-shadow:0px 2px 1px #c0c0c0;">

			<div class="mr-button-block">
				<input placeholder="YYYY-MM-DD" id="start" class="laydate-icon" style="padding: 0 5px;width:150px;height:27px;border-radius: 4px;"/>
				- <input placeholder="YYYY-MM-DD" id="end" class="laydate-icon" style="padding: 0 5px;width:150px;height:27px;border-radius: 4px;"/>
			</div>

			<div class="mr-list-block"><span class="mr-list-block-icon">会议室&nbsp;<img src="images/down.png"></span>
				<ul id="mr-myreservation-room-list">
				</ul>
			</div>
			<div class="mr-list-block"><span class="mr-list-block-icon">区域&nbsp;<img src="images/down.png"></span>
				<ul id="mr-myreservation-area-list">
				</ul>
			</div>
			<div class="clr"></div>
	</div>
		
	<div id="mr-myreservation-container" style="height:100%;">
		<div id="mr-myreservation-div" style="box-shadow:0px 1px 1px #c0c0c0;height:auto;width:100%;padding:15px;background-color:white;overflow:auto;float:left;">
			<table border="1" id="mr-myreservation-table" class="tableid table-hover" style="width:100%;min-width:1000px;border-color:#a7a7a7;table-layout:fixed;border: 1px solid #a7a7a7;">
				<tbody >
				<tr class="row1 row_first" style="background-color: #f7f7f7;color:#606060;">
					<td width="10%">会议名称</td>
					<td width="25%">内容</td>
					<td width="20%">时间</td>
					<td width="10%">区域</td>
					<td width="10%">会议室</td>
					<td width="10%">预定人电话</td>
				</tbody>
				<tbody class="myreservation" id="mr-myreservation-table-body" style="color: #a7a7a7;cursor: pointer;"></tbody>
			</table>
		
			<nav>
			  <div style="font-size:14px;float:right;margin:29px 30px 20px 0px;color:#a7a7a7;font-family: 'Microsoft YaHei';font-size:">共<span id="countPages" href="javascript:void(0);" class="disabled">1</span>页&nbsp;&nbsp;</div>
			  <ul class="pagination" style="float:right;margin:24px 4px 20px 20px;">
			    <li>
			      <a onclick="Utils.lastPage();" href="javascript:void(0);" aria-label="Previous" style="height: 27px;padding: 4px 10px;">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <li><a id="currPages" class="disabled" style="height: 27px;padding: 4px 10px;">1</a></li>
			    <li>
			      <a aria-label="Next" onclick="Utils.nextPage();" href="javascript:void(0);" style="height: 27px;padding: 4px 10px;">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		
		</div>
		
		<div id="mr-myreservation-box" class="reservation-box" style="overflow:auto;">
			<div id="myreservation-box-close"></div>
			<div class="myreservation-box-css">
					<h3><div class="box_title">会议</div></h3>
					<hr></hr>
		    		<table class="table_css">
		    		<tr><td>会议名称：</td><td><span style="color:#E51700;">*</span><input type="text" class="td_box" id="myreservation_name" value="" class="td_box"/></td></tr>
		    		<tr><td>会议内容：</td><td><span style="color:#ffffff;">*</span><input type="text" class="td_box" id="myreservation_content" value="" class="td_box"/></td></tr>
		    		<tr><td>预定人电话：</td><td><span style="color:#ffffff;">*</span><input type="tel" class="td_box" id="myreservation_creatorTel" value="" class="td_box"/></td></tr>
		    		<tr><td>开始时间：</td><td><span style="color:#E51700;">*</span><input id="myreservation_starttime" class="td_box laydate-icon" placeholder="YYYY-MM-DD hh:mm" class="td_box laydate-icon" style="width:170px;height:27px;padding:2px;"/></td></tr>
		    		<tr><td>结束时间：</td><td><span style="color:#E51700;">*</span><input id="myreservation_endtime" class="td_box laydate-icon" placeholder="YYYY-MM-DD hh:mm" class="td_box laydate-icon" style="width:170px;height:27px;padding:2px;"/></td></tr>
		    		<tr><td>区域：</td><td><span style="color:#E51700;">*</span><select id="mr-myreservation-pop-area" class="td_box" name="selse" class="td_box"></select></td></tr>
		    		<tr><td>会议室：</td><td><span style="color:#E51700;">*</span><select id="mr-myreservation-pop-room" class="td_box" name="selse" class="td_box"></select></td></tr>
		    		</table>
		    		<input type="hidden" id="myreservation_id" value=""/>
					<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;保存" onclick="updateMyreservation();" class="btn btn-success btn-sm" style="margin-left:130px;background:url(images/icon_03.png) 5px 6px no-repeat;background-color:#7BC57B;"/>
		    		<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;删除" onclick="deleteMyreservation();" class="btn btn-default btn-sm" style="margin-left:20px;background:url(images/icon_02.png) 5px 6px no-repeat;"/>		    		
		    </div>
		   
		</div>
		
	</div>
</div>

<script>
var start ={
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
	};
laydate(start);
var end = {
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
	};
laydate(end);

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
<script id="tmplMyreservationTableListItem" type="text/x-jquery-tmpl">
		<tr class="row1" id="${id}"> 
			<td title="点击表格修改会议预定记录" nowrap style="overflow:hidden;">${name}</td>
			<td title="点击表格修改会议预定记录" nowrap style="overflow:hidden;">${content}</td>
			<td class="timepos" title="点击表格修改会议预定记录">${startTime}-${endTime}</td>
			<td title="点击表格修改会议预定记录">${area}</td>
			<td title="点击表格修改会议预定记录">${room}</td>
			<td title="点击表格修改会议预定记录">${creatorTel}</td>
		</tr>
</script>    

