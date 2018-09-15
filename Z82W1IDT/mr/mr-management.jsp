<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="pm-page mr-page-management" style="height: 100%;">
	
		
	<div class="pm-tool-bar" style="height: 53px;padding:10px;background-color:white;margin-bottom:15px;box-shadow:0px 2px 1px #c0c0c0;">
				
			<div class="mr-button-block">
				<input type="button" value="新建会议室" onclick="popinitmanagement();" class="btn btn-primary" style="margin-right:15px;"/>
				<input type="button" value="删除会议室" onclick="deleteroom();" class="btn btn-default"/>
			</div>
			
			<div class="mr-list-block"><span class="mr-list-block-icon">会议室&nbsp;<img src="images/down.png"></span>
				<ul id="mr-management-room-list">
				</ul>
			</div>
			<div class="mr-list-block"><span class="mr-list-block-icon">区域&nbsp;<img src="images/down.png"></span>
				<ul id="mr-management-area-list">
				</ul>
			</div>
			
			<div class="clr"></div>
	</div>
	<style>
		.float_left{   float: left; }
	</style>
	<div id="mr-management-container">

		<div id="mr-management-box" class="management-box" style="overflow:auto;">
			<div id="management-box-close"></div>
			<h3><div class="box_title">会议室</div></h3>
		    <hr></hr>
		    
			<div role="tabpanel">
				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist" id="myTab" style="padding-left:15px;">
				    <li role="presentation" class="active"><a href="#home" id="home-tab" aria-controls="home" role="tab" data-toggle="tab" style="width:130px;text-align:center;">会议室</a></li>
				    <li role="presentation"><a href="#profile" id="profile-tab" aria-controls="profile" role="tab" data-toggle="tab" style="width:130px;text-align:center;">区域</a></li>
				  </ul> 
				
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="home" aria-labelledby="home-tab" style="margin-bottom:15px;">

						<table class="table_css">
							<tr><td width="80px">区域：</td><td><span style="color:#E51700;">*</span><select id="mr-management-pop-area" name="selse" class="td_box"></select></td></tr>
					    	<tr><td width="80px">会议室：</td><td><span style="color:#E51700;">*</span><input type="text" class="td_box" id="mr-management-pop-room" value="" readonly="readonly"/></td></tr>
				    		<tr><td>容纳人数：</td><td><span style="color:#E51700;">*</span><input type="number" class="td_box" id="management_number" value="" /></td></tr>
				    		<tr><td>设备：</td><td><span style="color:#E51700;">*</span><textarea  id="management_equipment" class="td_box1" rows="2"></textarea></td></tr>
				    		<tr><td>备注：</td><td><span style="color:#ffffff;">*</span><textarea id="management_note" class="td_box1" rows="2"></textarea></td></tr>
			    		</table>
				    		<input type="hidden" value="" id="management_id"/>
				    		<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;保 存" onclick="saveroom();" class="btn btn-success btn-sm" style="margin-left:110px;background:url(images/icon_03.png) 5px 6px no-repeat;background-color:#7BC57B;"/>
							<input type="button" value="&nbsp;&nbsp;&nbsp;&nbsp;删 除" onclick="deleteroom1();" class="btn btn-default btn-sm" style="margin-left:20px;background:url(images/icon_02.png) 5px 6px no-repeat;"/>				    

				    </div>
				    
				    <div role="tabpanel" class="tab-pane" id="profile" aria-labelledby="profile-tab">
				    	
				    	<div id="mr-management-pop-area1-box">
			    			<table class="table_css"><tr><td width="80px">区域：</td><td><span style="color:#E51700;">*</span><select id="mr-management-pop-area1" name="selse" class="td_box"></select></td></tr></table>
			    		</div>
						<div id="mr-management-pop-area2-box" style="display:none;">
							<table class="table_css"><tr><td width="80px">区域：</td><td><span style="color:#E51700;">*</span><input type="text" id="mr-management-pop-area2" class="td_box" value=""/></td></tr></table>
						</div>
					    <div id="area_select">
					    	<div id="management_edit1" style="display:block;">
					    		<input type="button" onclick="MR.area_edit();" value="&nbsp;&nbsp;&nbsp;&nbsp;编辑" class="btn btn-success btn-sm" style="margin-left:100px;background:url(images/icon_03.png) 5px 6px no-repeat;background-color:#7BC57B;"/>
					    		<input type="button" onclick="deletearea();" value="&nbsp;&nbsp;&nbsp;&nbsp;删除" class="btn btn-default btn-sm" style="margin-left:20px;background:url(images/icon_02.png) 5px 6px no-repeat;"/>
					    	</div>
					    </div>
					    	
					    <div id="area_select_edit" style="display:none;">
					    		<input type="button" onclick="updatearea();" value="&nbsp;&nbsp;&nbsp;&nbsp;修改" class="btn btn-primary btn-sm" style="margin-left:45px;background:url(images/icon_01.png) 5px 6px no-repeat;background-color:#31AFE8"/>
					    		<input type="button" onclick="newarea();" value="&nbsp;&nbsp;&nbsp;&nbsp;新建" class="btn btn-primary btn-sm" style="margin-left:15px;background:url(images/icon_03.png) 5px 6px no-repeat;background-color:#7BC57B;"/>
					    		<input type="button" onclick="MR.area_edit_cancel();" value="&nbsp;&nbsp;&nbsp;&nbsp;取消" class="btn btn-default btn-sm" style="margin-left:15px;background:url(images/icon_02.png) 5px 6px no-repeat;"/>
					    </div>
				    
				    </div>
				  </div>
			</div>
			
			<div class="myreservation-box-css">
		    		
		    </div>
		</div>
		
		<div id="mr-management-div" style="box-shadow:0px 1px 1px #c0c0c0;height:auto;width:100%;padding:15px;background-color:white;overflow:auto;float:left;">
			<table border="1" id="mr-management-table" class="management tableid table-hover" style="width:100%;min-width:1000px;border-color:#a7a7a7;table-layout:fixed;border: 1px solid #a7a7a7;">
				<tr class="row1 row_first" style="background-color: #f7f7f7;color:#606060;" >
					<td width="4%"><input type="checkbox" name="management_checkbox" id="all_checkbox"/></td>
					<td width="10%">区域</td>
					<td width="10%">会议室</td>
					<td width="10%">容纳人数</td>
					<td width="23%">设备</td>
					<td width="23%">备注</td>
				</tr>
				<tbody class="management tableid" id="mr-management-table-body" style="color: #a7a7a7;cursor: pointer;">
				</tbody>
			</table>
		</div>
	</div>
</div>

<script id="tmplManagementTableListItem" type="text/x-jquery-tmpl">
		<tr class="row1" id="${id}">
			<td><input type="checkbox" name="management_checkbox" value="${id}"/></td>
			<td title="点击表格进行会议室修改">${area}</td>
			<td title="点击表格进行会议室修改">${name}</td>
			<td title="点击表格进行会议室修改">${number}</td>
			<td title="点击表格进行会议室修改" nowrap style="overflow:hidden;">${equipment}</td>
			<td title="点击表格进行会议室修改" nowrap style="overflow:hidden;">${note}</td>
		</tr>
</script>    


