<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<o:MultiLanguage>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>{*[cn.myapps.core.domain.fieldextends.extends.content.addField]*}</title>
		<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
		<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
		<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
		<script src="<s:url value="/script/list.js"/>"></script>
		<script src="<s:url value='/script/help.js'/>"></script>
		<script type="text/javascript">
		jQuery(function(){
			
			var forTable = "<s:property value='fieldExtends.forTable'/>";
			var name = "<s:property value='fieldExtends.name'/>";
			
			onChangeTable(forTable);
			
			var forTableOpts = jQuery("#forTable").find("option");
			jQuery.each(forTableOpts,function(index,forTableOpt){
				if(jQuery(forTableOpt).val() == forTable) {
					jQuery(forTableOpt).attr("selected",true);
				}
			});
	
			if (forTable == "tableDept") {
				var nameOpts = jQuery("#nameByDep").find("option");
				jQuery.each(nameOpts,function(index,nameOpt){
					if(jQuery(nameOpt).val() == name) {
						jQuery(nameOpt).attr("selected",true);
					}
				});
//				if(name != "field9" && name != "field10") {
//					jQuery("#optClob").remove();
//				}
			} else {
				var nameOpts = jQuery("#nameByUser").find("option");
				jQuery.each(nameOpts,function(index,nameOpt){
					if(jQuery(nameOpt).val() == name) {
						jQuery(nameOpt).attr("selected",true);
					}
				});
//				if(name != "field9" && name != "field10") {
//					jQuery("#optClob").remove();
//				}
			}
			if(jQuery("#fid").val() != null && jQuery("#fid").val() != ""){
				jQuery("#nameByDep").empty();
				jQuery("#nameByUser").empty();
				jQuery("#nameByDep").append("<option value='" + name + "'>" + name + "</option>");
				jQuery("#nameByUser").append("<option value='" + name + "'>" + name + "</option>");
				jQuery("#nameByDep").attr("disabled",true);
				jQuery("#nameByUser").attr("disabled",true);
				jQuery("#forTable").attr("disabled",true);
			}

			var typeOpts = jQuery("#type").find("option");
			jQuery.each(typeOpts,function(index,typeOpt){
				if(jQuery(typeOpt).val() == "<s:property value='fieldExtends.type'/>") {
					jQuery(typeOpt).attr("selected",true);
				}
			});

			var isNullOpts = jQuery("#isNull").find("option");
			jQuery.each(isNullOpts,function(index,isNullOpt){
				if(jQuery(isNullOpt).val() == "<s:property value='fieldExtends.isNull'/>") {
					jQuery(isNullOpt).attr("selected",true);
				}
			});

			var enabelOpts = jQuery("#enabel").find("option");
			jQuery.each(enabelOpts,function(index,enabelOpt){
				if(jQuery(enabelOpt).val() == "<s:property value='fieldExtends.enabel'/>") {
					jQuery(enabelOpt).attr("selected",true);
				}
			});

		});
			/**
			* 保存
			*/
			function save(){
				var contentform = document.getElementById("contentform");
				//保存前必须把disabled去掉，类里才能获取到值
				jQuery("#forTable").removeAttr("disabled");
				contentform.submit();
			}

			/**
			* 保存并继续新建
			*/
			function saveAndNew(){
				var contentform = document.getElementById("contentform");
				var action = '<s:url value='/core/fieldextends/saveAndNew.action'/>';
				contentform.action = action;
				//保存前必须把disabled去掉，类里才能获取到值
				jQuery("#forTable").removeAttr("disabled");
				contentform.submit();
			}
			
			/**
			* 设置字段类型
			*/
			function setType(value){
				var name = value;
				
				if(name == "field9" || name == "field10"){
					if(jQuery("#type").find("option").length == 2) {
						jQuery("#type").append("<option id='optClob' value='clob' selected='selected'>{*[cn.myapps.core.domain.fieldextends.extends.type.clob]*}</option>");
					}else{
						jQuery("#optClob").attr("selected","selected");
					}
					jQuery("#type").attr("disabled",true);
				}else{
					jQuery("#optClob").remove();
					jQuery("#type").attr("disabled",false);
				}
			}
			
			function onChangeTable(value) {
				if (value == "tableUser" || value == "") {
					jQuery("#nameByUser").css("display", "");
					jQuery("#nameByDep").css("display", "none");
					var nameByUser = jQuery("#nameByUser").val();
					setType(nameByUser);
				} else {
					jQuery("#nameByUser").css("display", "none");
					jQuery("#nameByDep").css("display", "");
					var nameByDep = jQuery("#nameByDep").val();
					setType(nameByDep);
				}
			}

			jQuery(document).ready(function(){
				window.top.toThisHelpPage("domain_fieldextends_info");
			});

			function doExit(){
				var page = "<s:url value='/core/fieldextends/list.action'/>?";
					page += "domain=<s:property value='#parameters.domain' />";
					page += "&_currpage=<s:property value='#parameters._currpage'/>";
					page += "&_pagelines=<s:property value='#parameters._pagelines'/>";
					page += "&_rowcount=<s:property value='#parameters._rowcount'/>";
				//===========firefox兼容性修改--start=================
				var parentIframe = window.parent.document.getElementById("frame");
				var tdParent = jQuery(parentIframe).parent();
				var strIframe = '<iframe width="100%" style="overflow: auto;" scrolling="auto" height="100%" frameborder="0"'; 
					strIframe += ' name="frame" id="frame" src="' + page  + '"></iframe>';
				jQuery(tdParent).html(strIframe);
				//===========firefox兼容性修改--end=================

			}
			
		</script>
</head>
<body id="domain_fieldextends_info" class="contentBody">
<s:bean name="cn.myapps.core.fieldextends.action.FieldExtendsHelper" id="fh" />
<form id="contentform" action="save.action" method="post" >
	<div id="contentActDiv">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.fieldextends.extends.content.addField]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="Save_Field" title="{*[cn.myapps.core.domain.fieldextends.extends.content.title.save_field]*}" class="justForHelp button-image" onClick="save()">
						<img src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save]*}
					</button>
					<button type="button" id="Save_New_Field" title="{*[cn.myapps.core.domain.fieldextends.extends.content.title.save_new_field]*}" class="justForHelp button-image" onClick="saveAndNew()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save&New]*}
					</button>
					<button type="button" id="Back" title="{*[Back]*}" class="justForHelp button-image" onClick="doExit()">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
	</table>
	</div>
	<!-- 信息提示 -->
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<input type="hidden" name="fieldExtends.domainid" value="<s:property value='#parameters.domain' />" />
		<input type="hidden" name="domain" value="<s:property value='#parameters.domain' />" />
		<input type="hidden" id="fid" name="fieldExtends.fid" value="<s:property value='fieldExtends.fid'/>">
	
		<table class="table_noborder id1">
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.fieldextends.extends.label]*}:</td>
				<td class="commFont">{*[cn.myapps.core.domain.fieldextends.extends.content.sortNumber]*}:</td>
			</tr>
			<tr>
				<td class="commFont"><input class="input-cmd" id="label" name="fieldExtends.label" value="<s:property value='fieldExtends.label'/>"></td>
				<td class="commFont">
					<input class="input-cmd" id="sortNumber" name="fieldExtends.sortNumber" value="<s:property value='fieldExtends.sortNumber'/>"></td>
			</tr>
	
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.fieldextends.extends.name]*}:</td>
				<td class="commFont" >{*[Type]*}:</td>
			</tr>
			<tr>
				<td class="commFont">
					<select class="input-cmd" id="nameByUser" name="nameByUser" onchange="setType(this.value);" style="display: none;">
							<s:iterator value="#fh.getUnUseFieldsByUser(#parameters.domain)">
								<option value="<s:property/>"><s:property/></option>
							</s:iterator>
					</select>
					<select class="input-cmd" id="nameByDep" name="nameByDep" onchange="setType(this.value);" style="display: none;">
							<s:iterator value="#fh.getUnUseFieldsByDep(#parameters.domain)">
								<option value="<s:property/>"><s:property/></option>
							</s:iterator>
					</select>
				</td>
				<td class="commFont">
					<select class="input-cmd" id="type" name="fieldExtends.type">
							<option value="string">{*[String]*}</option>
							<option value="date">{*[Date]*}</option>
							<option id="optClob" value="clob">{*[cn.myapps.core.domain.fieldextends.extends.type.clob]*}</option>
						</select>
				</td>
			</tr>
			
			<tr>
				<td class="commFont" >{*[cn.myapps.core.domain.fieldextends.extends.enabel]*}:</td>
				<td class="commFont" >{*[cn.myapps.core.domain.fieldextends.extends.forTable]*}:</td>
			</tr>
			<tr>
				<td class="commFont">
					<select class="input-cmd" id="enabel" name="fieldExtends.enabel">
							<option value="true">{*[Yes]*}</option>
							<option value="false">{*[cn.myapps.core.domain.fieldextends.extends.content.no]*}</option>
						</select>
				</td>
				<td class="commFont">
					<select class="input-cmd" id="forTable" name="fieldExtends.forTable" onchange="onChangeTable(this.value)">
							<option value="tableUser">{*[cn.myapps.core.domain.fieldextends.extends.user]*}</option>
							<option value="tableDept">{*[cn.myapps.core.domain.fieldextends.extends.dept]*}</option>
						</select>
				</td>
			</tr>
		</table>
	</div>
</form>
		<script type="text/javascript">
		jQuery(function(){
			var nameByUser = jQuery("#nameByUser").val();
			setType(nameByUser);
		});
		</script>
</body>
</html>
</o:MultiLanguage>