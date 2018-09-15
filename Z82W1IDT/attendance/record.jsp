
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
	<title>考勤记录</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
	<script src="js/lib/jquery.min.js"></script>
	<script src="js/lib/jquery.mobile-1.4.5.min.js"></script>
	
</head>
<body>
<div id="record" data-role="page" data-theme="a">
		<div data-role="header">
			<h1>考勤记录</h1>
			<a href="#search" class="ui-btn-right" 
				data-role="button" data-icon="search" data-iconpos="left">查询</a>
		</div>
		<div data-role="content" style="padding: 0.5em;font-size: 10px;">
			<table data-role="table" id="record-list" data-mode="none" 
			class="ui-body-d ui-shadow table-stripe ui-responsive" data-column-btn-theme="b" 
			data-column-btn-text="列选择" data-column-popup-theme="b">
	        	<thead>
		            <tr class="ui-bar-d">
		            	<!-- <th data-options="field:'id',checkbox:true"></th> -->
		                <th data-priority="1">员工</th>
		                <th data-priority="1">日期</th>
		                <th data-priority="1">状态</th>
		                <th data-priority="1">工作时长</th>
		                <th data-priority="1">考勤明细</th>
		            </tr>
	        	</thead>
	        	<tbody id="record-table-body">
  				</tbody>
	    	</table>
    	</div>
</div>



<div id="search" data-role="page" data-theme="a">
<form id="formName">
		<div data-role="header">
			<h1>查询记录</h1>
		</div>
		<div data-role="content">
			<div date-role="fieldcontainer">
				<label for="userName">员工:</label>
				<select name="userSelect" id="userSelect" multiple="multiple" data-native-menu="false" data-icon="grid" data-iconpos="left">
    			<option>选择用户</option>
				<optgroup label="当前用户">
					<option value="<s:property value="#session.FRONT_USER.getId()" />" ><s:property value="#session.FRONT_USER.getName()" /></option>
				<optgroup/>
				<optgroup label="下级用户" id="underList">
				<optgroup/>
			</select>
			</div>
			<div date-role="fieldcontainer">
				<label for="signdate">开始日期:</label>
				<input type="date" name="signdate" id="signdate">
			</div>
			<div date-role="fieldcontainer">
				<label for="signdate">结束日期:</label>
				<input type="date" name="signenddate" id="signenddate">
			</div>
			<div date-role="fieldcontainer">
				<label for="status">状态:</label>
				<!--<input type="text" name="status" id="status">-->
				<select name="status" id="status">
				  <option value =""></option>
				  <option value ="迟到">迟到</option>
				  <option value="早退">早退</option>
				  <option value="迟到且早退">迟到且早退</option>
				</select>
			</div>
			<div date-role="fieldcontainer">
				<a id="change-page" href="#record" data-direction="reverse" class="ui-btn ui-shadow ui-corner-all ui-btn-a ui-btn-icon-left ui-icon-search">查询</a>
				<a id="reloadpage"  type="reset"  class="ui-btn ui-shadow ui-corner-all ui-btn-icon-left ui-icon-forward ">重置</a>
			</div>
    	</div>
</form>
</div>

<div id="chart" data-role="page" data-theme="a">
		<div data-role="header">
			<h1>考勤记录图形报表</h1>
			<a href="#record" class="ui-btn-right" 
				data-role="button" data-icon="back" data-iconpos="left" id="chartPage">确定</a>
		</div>
		<div data-role="content" style="padding:1px;">
			<div id="signin" style="height:500px;border:0px solid #ccc;padding:1px;"></div>
    	</div>
</div>

<div data-role="page" id="attendanceDetail">
  <div data-role="header">
    <h1>考勤明细</h1>
</div>
 <div data-role="content" style="padding: 0.5em;font-size: 10px;">
			<table data-role="table" id="attendanceDetail-list" data-mode="none" 
			class="ui-body-d ui-shadow table-stripe ui-responsive" data-column-btn-theme="b" 
			data-column-btn-text="列选择" data-column-popup-theme="b">
	        	<thead>
		            <tr class="ui-bar-d">
		            	<!-- <th data-options="field:'id',checkbox:true"></th> -->
		                <th data-priority="1">日期</th>
		                <th data-priority="1">时间段</th>
		                <th data-priority="1">签到</th>
		                <th data-priority="1">签退</th>
		                <th data-priority="1">工作时长</th>
		                <th data-priority="1">状态</th>
		            </tr>
	        	</thead>
	        	<tbody id="attendanceDetail-table-body">
  				</tbody>
	    	</table>
    	</div>
</div>
</body>
<script type="text/javascript">
//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.format = function(fmt) 
{ //author: meizz 
var o = { 
 "M+" : this.getMonth()+1,                 //月份 
 "d+" : this.getDate(),                    //日 
 "h+" : this.getHours(),                   //小时 
 "m+" : this.getMinutes(),                 //分 
 "s+" : this.getSeconds(),                 //秒 
 "q+" : Math.floor((this.getMonth()+3)/3), //季度 
 "S"  : this.getMilliseconds()             //毫秒 
}; 
if(/(y+)/.test(fmt)) 
 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
for(var k in o) 
 if(new RegExp("("+ k +")").test(fmt)) 
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
return fmt; 
}



</script>
	<script type="text/javascript" src="js/lib/jquery.min.js"></script>
	<script type="text/javascript" src="js/lib/jquery.tmpl.js"></script>
	<script type="text/javascript" src="js/record.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>
	
	<script id="tmplRecordTableListItem" type="text/x-jquery-tmpl">
		<tr class="row" data-id="${id}">
			<td>${userName}</td>
			<td>${$item.signdate()}</td>
			<td>{%if status==1%}<font color="#00FF00">正常</font>{%elseif status==-1%}<font color="#FF0000">迟到</font>{%elseif status==-2%}<font color="#FF0000">早退</font>
				{%elseif status==-3%}<font color="#FF0000">迟到且早退</font>{%elseif status==-4%}<font color="#FF0000">地点异常</font>{%/if%}</td>
			 <td>${workingHours}</td>			
<td><a href="#attendanceDetail" onclick="showAttendanceDetail('${id}')" data-rel="dialog">详情</a></td>
		</tr>
	</script>
	
	<script id="tmplAttendanceDetail" type="text/x-jquery-tmpl">
		<tr class="row" data-id="${id}">
	        <td>${$item.signdate()}</td>
	        <td>${timeRegion}</td>
			<td>${$item.signinTime()}</td>
			<td>${$item.signoutTime()}</td>
            <td>${workingHours}</td>
			<td>{%if status==1%}<font color="#00FF00">正常</font>{%elseif status==-1%}<font color="#FF0000">迟到</font>{%elseif status==-2%}<font color="#FF0000">早退</font>
				{%elseif status==-3%}<font color="#FF0000">迟到且早退</font>{%elseif status==-4%}<font color="#FF0000">地点异常</font>{%/if%}</td>
		</tr>
	</script>
	
	<script type="text/javascript">
	var action = '<s:property value="#parameters.action" />';
	var _host ='<s:property value="#session.FRONT_USER.getDomain().getServerHost()" />';
	
	function showAttendanceDetail(id) {
		 $.ajax({
			  url: 'attendance/attendance/doQueryAttendanceDetail.action?attendanceId='+id,
			  success: function(datas){
				  $("#attendanceDetail-table-body").html($("#tmplAttendanceDetail").tmpl(datas.rows,{
					   
					  signinTime : function(){
							var startTime = this.data.signinTime;
							var startTimeArr = startTime.split("T");
							return startTimeArr[1];
							
						},
						signoutTime : function(){
							var endTime = this.data.signoutTime;
							if(!endTime) return "";
							var endTimeArr = endTime.split("T");
							return endTimeArr[1];
						}, 
						signdate : function(){
		    						var attendancedate = this.data.attendanceDate;
		    						var signdate = new Date(attendancedate).format("yyyy-MM-dd");
		    						return signdate;
		    			}
				  }));
				  
			  }
		});
    }
	function onBridgeReady(){
		 WeixinJSBridge.call('hideOptionMenu');
		}

		if (typeof WeixinJSBridge == "undefined"){
		    if( document.addEventListener ){
		        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
		    }else if (document.attachEvent){
		        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
		        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		    }
		}else{
		    onBridgeReady();
		}
		
		var USER = {
				id:'<s:property value="#session.FRONT_USER.getId()" />',
				name:'<s:property value="#session.FRONT_USER.getName()" />',
				domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
				};

		$(document).ready(function(){

			$.ajaxSetup({
                error:function(x,e){
				//Utils.showMessage("请求服务端发生异常,请稍后尝试！","error");
                    return false;
                }
            });
			RECORD.init();
		});
		
	</script>
</html>