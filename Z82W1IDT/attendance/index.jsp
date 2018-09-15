<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>考勤管理</title>
	<link rel="stylesheet" type="text/css" href="js/lib/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="js/lib/easyui/themes/icon.css">
	<style type="text/css">
	*{
		font-size:12px;
	}
	body {
	    font-family:verdana,helvetica,arial,sans-serif;
	    padding:220px;
	    font-size:12px;
	}
	#tabs{
		margin-top: 5px;
	}
	</style>
	<script type="text/javascript">
		var contextPath = '<%=request.getContextPath()%>';
	</script>
</head>
<body>
	<div id="tabs" class="easyui-tabs">
		<div title="考勤规则" style="padding:1px">
		   <table id="rule_list" >
	        	<thead>
		            <tr>
		            	<th data-options="field:'id',checkbox:true"></th>
		                <th field="name" width="180">规则名称</th>
		                <th field="organizationsText" width="25%">适用范围</th>
		                <th field="locationsText" width="40%" >考勤地点</th>
		                <th field="range" width="80" >考勤范围(米)</th>
		            </tr>
	        	</thead>
	    	</table>
	    	<div id="rule_content_dialog" >
		      <form id="rule_form" method="post">
		          <table cellpadding="5">
		              <tr>
		                  <td>规则名称:</td>
		                  <td><input class="easyui-textbox" type="text" id="rule_name" name="content.name" data-options="required:true" style="width:250px;" ></input></td>
		              </tr>
		              <tr>
		                  <td>适用范围:</td>
		                  <td>
		                  	<input id="rule_organizations" name="content.organizations" style="width:250px;" />
		                  </td>
		              </tr>
		               <tr>
		                  <td>考勤地点:</td>
		                  <td>
		                  	<input id="rule_locations" name="_locations" style="width:250px;" />
		                  </td>
		              </tr>
		              <tr>
		                  <td>考勤范围:</td>
		                  <td><input class="easyui-textbox" type="text" name="content.range" data-options="required:true" style="width:50px" ></input>&nbsp;米</td>
		              </tr>
		              <tr>
		                  <td>多时段考勤:</td>
		                  <td>
							<input type="radio" name="content.multiPeriod" value="true"    ><span>是</span>
							<input type="radio" name="content.multiPeriod" value="false"   ><span>否</span>	  </td>                
		              </tr>
		          </table>
		          <input type="hidden" name="content.id" />
		          <input type="hidden" id="rule_organizationsText" name="content.organizationsText" />
		          <input type="hidden" id="rule_locationsText" name="content.locationsText" />
		          <input type="hidden" name="content.organizationType" value="1" />
		      </form>
	    	</div>
		</div>
		<div title="考勤地点" style="padding:1px">
			<table id="locations_list" >
	        	<thead>
		            <tr>
		            	<th data-options="field:'id',checkbox:true"></th>
		                <th field="name" width="90%">考勤地点</th>
		            </tr>
	        	</thead>
	    	</table>
	    	
	    	<div id="locations_content_dialog">
		      <form id="location_form" method="post">
		          <table cellpadding="5">
		              <tr>
		                  <td>详细地址:</td>
		                  <td><input class="easyui-textbox" type="text" id="location_addr" name="content.name" data-options="required:true" placeholder="广州市越秀区先烈中路80号" style="width: 300px;"></input>&nbsp; <a href="#" id="location_search_btn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">搜索</a></td>
		              </tr>
		              <tr>
		                  <td></td>
		                  <td>
		                  	<div id="location_map" style="width: 500px; height: 300px"></div>
		                  	<input type="hidden" name="content.longitude" id="location_longitude" />
		                  	<input type="hidden" name="content.latitude" id="location_latitude" />
		                  	<input type="hidden" name="content.id" />
		                  </td>
		              </tr>
		          </table>
		      </form>
	    	</div>
	    	
		</div>
		<div title="考勤记录" style="padding:1px">
			<table id="attendance_list"  >
	        	<thead>
		            <tr>
		            	<!-- <th data-options="field:'id',checkbox:true"></th> -->
		                <th field="userName" width="10%">员工</th>
		                <th field="deptName" width="20%">部门</th>
		                <th field="attendanceDate" width="20%" >考勤日期</th>
		                <th field="workingHours" width="10%">工作时长</th>
		                <th field="status" data-options="
		                	formatter: function(value,row,index){
								if (value){
									var rtn = '';
									switch(value){
										case 1:
											rtn='正常';
											break;
										case -1:
											rtn='迟到';
											break;
										case -2:
											rtn='早退';
											break;
										case -3:
											rtn='迟到且早退';
											break;
										case -4:
											rtn='地点异常';
											break;
									}
									return rtn;
								} else {
									return '未知';
								}
							}
		                " width="40%">考勤状态</th>
		                
		            </tr>
	        	</thead>
	    	</table>
	    	<div id="attendance_list_tb" style="padding:2px 5px;">
		        从: <input id="attendance_list_tb_startDate" class="easyui-datebox" style="width:110px">
		        到: <input id="attendance_list_tb_endDate" class="easyui-datebox" style="width:110px">
		        员工: 
		        <input id="attendance_list_tb_name" class="easyui-validatebox textbox" style="width:110px">
		        <a href="#" class="easyui-linkbutton" id="attendance_list_tb_btn_search" iconCls="icon-search">查询</a>
		        <a href="#" class="easyui-linkbutton" id="attendance_list_tb_btn_reset">重置</a>
		        <a href="#" class="easyui-linkbutton" id="attendance_list_tb_btn_export">导出明细表</a>
		    </div>
		</div>
	</div>
</body>
	<script type="text/javascript" src="js/lib/jquery.min.js"></script>
	<script type="text/javascript" src="js/lib/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/lib/easyui/datagrid-detailview.js"></script>
	<script type="text/javascript" src="js/lib/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4b13e87bef9c0298377377db89487985"></script>
	<script type="text/javascript" src="js/attendance.core.js"></script>
	<script type="text/javascript">
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
		});	
		AM.init();
	</script>
</html>