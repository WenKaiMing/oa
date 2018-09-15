<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
	<!DOCTYPE html>
	<html>
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会议室管理</title>
		
		<script type="text/javascript" src="../js/plugin/jquery.js"></script>
		<script src="../layer/layer.min.js"></script>
		<script type="text/javascript" src="../js/wap/jquery.mobile-git.js" ></script>
		<link rel="stylesheet" href="../js/plugin/jqm/jquery.mobile-1.4.5.min.css"/>
		<link rel="stylesheet" href="../js/plugin/mmenu/css/jquery.mmenu.all.css"/>
		<link href="../js/plugin/jquery-ui/jquery-ui.min.css" type="text/css" rel="stylesheet" />
		
		<!-- layer -->
		<script type="text/javascript" src="../laydate/laydate.js" ></script>
		<script type="text/javascript" src="../js/wap/mr.mobile.core.js" ></script>
		<script type="text/javascript" src="../js/wap/mr.data.js" ></script>
		<link href="../js/plugin/jquery-ui/jquery-ui.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../js/plugin/jquery.tmpl.js"></script>
		
		<style type="text/css">
		.center{
			width:100%;
			background: black;
		}
		.table_css{
			width:100%;
		}
		.table_css td{
			background: #FFFFFF;
			width:30%;
		}
		.input_block{
			background: #FFFFFF;
			margin:0 5% 35px 5%;
			text-align: center;
			display: none;
		}
		.management_div{
			margin: 3%;
		}
		.management_table{
			border: 1;
		}
		.popclass{
			padding: 5%;
		}
		</style>
	</head>

	<body>
	
		<div><a href="index.jsp" data-role="button" data-icon="arrow-l">返回</a></div>
		<div>
			<input type="button" value="新增区域" onclick="newarea_show();"/>
				<div class="input_block" id="newarea_block">
					区域名：<input type="text" id="newarea_text" value=""/>
						<input type="button" value="保存" onclick="new_area();"/>
				</div>
			<input type="button" value="新增会议室" onclick="newroom_show();"/>
				<div class="input_block" id="newroom_block">
					<table data-mode="reflow">
			    		<tr><td>区域：</td><td><select id="management_area1" title="区域"></select></td></tr>
			    		<tr><td>会议室：</td><td><input type="text" id="management_room1" value=""/></td></tr>
			    		<tr><td>容纳人数：</td><td><input type="number" id="management_number1" value=""/></td></tr>
			    		<tr><td>设备：</td><td><textarea id="management_equipment1" ></textarea></td></tr>
			    		<tr><td>备注：</td><td><textarea id="management_note1" ></textarea></td></tr>
			    	</table>
			    	<input type="button" value="新增" onclick="new_room();"/>
			    	<input type="button" value="取消" onclick="newroom_close();"/>
				</div>
		</div>
		
		<div class="top" >
			<select id="mr-management-area-list" title="区域">
                <option value="one">区域</option>
			</select>
			<select id="mr-management-room-list" title="会议室">
                <option value="one">会议室</option>
			</select>
			
		</div>
		<div class="center">
		</div>
		
		<div id="mr-management-div" class="management_div">
			<table id="mr-management-table" class="table_css" data-mode="reflow">
				<tr class="row1" >
					<td >区域</td>
					<td >会议室</td>
					<td >容纳人数</td>
					<td >设备</td>
					<td >备注</td>
					<td ></td>
				</tr>
				<tbody class="management tableid" id="mr-management-table-body" style="cursor: pointer;"></tbody>
			</table>
		</div>

		<div class="popclass" id="room_block" data-role="popup">
			<table class="table_css">
		    	<tr><td>区域：</td><td><input type="text" id="management_area" value="" readonly="readonly"/></td></tr>
		    	<tr><td>会议室：</td><td><input type="text" id="management_room" value="" readonly="readonly"/></td></tr>
		    	<tr><td>容纳人数：</td><td><input type="text" id="management_number" value=""/></td></tr>
		    	<tr><td>设备：</td><td><textarea id="management_equipment" ></textarea></td></tr>
		    	<tr><td>备注：</td><td><textarea id="management_note" ></textarea></td></tr>
		    </table>
		    <input type="button" value="保存" onclick="save_room();"/>
		    <input type="button" value="删除" onclick="delete_room();"/>
		    <input type="button" value="关闭" onclick="man_close();" class="button-css"/>
		</div>

		
<script id="tmplAreaListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script> 
					
<script id="tmplRoomListItem" type="text/x-jquery-tmpl">
	<option value="${name}" data-id="${id}" class="mr-list-block-option">${name}</option>
</script>
<script id="tmplManagementTableListItem" type="text/x-jquery-tmpl">
		<tr class="row1" id="${id}">
			<td>${area}</td>
			<td>${name}</td>
			<td>${number}</td>
			<td>${equipment}</td>
			<td>${note}</td>
			<td><input type="button" data-role="button" data-icon="check" name="${id}" value="修改" onclick="room_show('${id}');"/></td>
		</tr>
</script>
<script type="text/javascript">
		MR.init();
		MR.management();
		MR.area_mag_list();
		MR.room_mag_list($("#mr-management-area-list").find("option:selected").attr("data-id"));
		MR.area_mag_select();
		</script>
	</body>
	</html>
