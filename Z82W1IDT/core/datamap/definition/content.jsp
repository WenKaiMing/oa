<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<s:bean name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper" id="billDefiHelper">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<html>
<o:MultiLanguage>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style>
body {
        margin-left: 0px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
}
html,body,#DynamicPrinter{
margin:0px;
padding:0px;
width:100%;
height:100%;
overflow:hidden;
}
</style>
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
<script type="text/javascript">

//生成mapping Json
function buildMappingJsonStr(){
	var pkey = document.getElementsByName("stateLabel");
	var pvalue = document.getElementsByName("color");
	var str = '[';
	for (var i=0;i<pkey.length;i++) {
		if (pkey[i].value != '' && pvalue[i].value != '' ){
				str += '{';
				str += pkey[i].name +':\''+pkey[i].value+'\',';
				str += pvalue[i].name +':\''+pvalue[i].value+'\'';
				str += '},';
		}
	}
	str += ']';
	return  str;	

}
//根据mapping str获取data array
function parseRelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();	
	}
}

var rowIndex = 0;
var getParamKey = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="stateLabel'+ rowIndex +'" name="stateLabel" style="width:100" value="'+HTMLDencode(data.stateLabel)+'" />';
	return s; 
	}
};

var getParamValue = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="color'+ rowIndex +'" name="color" style="width:100" value="'+HTMLDencode(data.color)+'" />';
	return s;
	}
};

var getDelete = function(data) {
	if(data){
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
  	rowIndex ++;
  	return s;
	}
};

//根据数据增加行
function addRows(datas) {
	var cellFuncs = [getParamKey, getParamValue, getDelete];

	var rowdatas = datas;
	if (!datas || datas.length == 0) {
		var data = {paramKey:'', paramValue:''};
		rowdatas = [data];
	}
	
	DWRUtil.addRows("tb", rowdatas, cellFuncs);
	
}

// 删除一行
function delRow(elem, row) {
	if (elem) {
		elem.deleteRow(row.rowIndex);
		//rowIndex --;
	}
}

function ev_save(){
	var stateLableColorMapping = document.getElementsByName("content.stateLableColorMapping")[0];
	var stateLableColorMappingStr = buildMappingJsonStr();
	stateLableColorMapping.value = stateLableColorMappingStr;
	document.forms[0].submit();
}

jQuery(document).ready(function(){
	var str = document.getElementsByName('content.stateLableColorMapping')[0].value;
	var datas = parseRelStr(str);
	addRows(datas);
	var showFlowProgressbar = '<s:property value="content.showFlowProgressbar" />';
	if(!showFlowProgressbar || showFlowProgressbar=='false'){
		document.getElementsByName('content.showFlowProgressbar')[0].checked = false;
	}
});
</script>
</head>
<body id="application_module_print_info" class="contentBody">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
		<td class="nav-s-td">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left: 10px;">
					<div id="sec_tab1">
					<div class="listContent"><input type="button" id="span_tab1"
						name="spantab1" class="btcaption" onClick="ev_switchpage('1')"
						value="{*[Basic]*}" /></div>
					<div class="listContent nav-seperate"><img
						src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
					</div>
					<div class="listContent"><input type="button" id="span_tab2"
						name="spantab2" class="btcaption" onclick="ev_switchpage('2')"
						value="{*[Content]*}" /></div>
					</div>
					</td>
				</tr>
			</table>
			</td>
			<td class="nav-s-td" align="right">
			<table width="150" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td align="left">
					<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="ev_save();">
					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
					align="top">{*[Save]*}</button>
					</td>
					<td>
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
	<div style="width: 100%;" id="clientdiv" class="contentMainDiv">
		<s:form name="dataMapCfg"	action="save" theme="simple" method="post">
		<%@include file="/common/page.jsp"%>
		<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
		<input type="hidden" name="s_module"
			value="<s:property value='#parameters.s_module'/>" />
		<input type="hidden" name="_moduleid"
			value="<s:property value='#parameters.s_module'/>" />
		<s:hidden name="content.stateLableColorMapping" />
		<table width="100%">
			<tr id="1">
				<td>
				<table cellpadding="1" cellspacing="3" width="100%" class="id1">
					<tr>
						<td class="commFont">{*[Name]*}:</td>
						<td class="commFont">&nbsp;</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.name" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="commFont">关联表单:</td>
						<td class="commFont">&nbsp;</td>
					</tr>
					<tr>
						<td><s:select name="content.relatedForm"
							list="#fh.get_normalFormList(#parameters.application)"
							listKey="id" id="relatedForm" listValue="name" theme="simple"
							cssClass="input-cmd" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="commFont">线索字段:</td>
						<td class="commFont">摘要字段:</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.clueField" /></td>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.summaryField" /></td>
					</tr>
					<tr>
						<td class="commFont">线索字段2:</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.clueField2" /></td>
					<tr>
						<td class="commFont">流程进度LED灯设置</td>
						<td class="commFont">&nbsp;</td>
					</tr>
					<tr>
						<td>
							<s:checkbox name="content.showFlowProgressbar" value="true" label="显示" /> 显示
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="commFont">&nbsp;</td>
						<td class="commFont">&nbsp; </td>
					</tr>
					<tr >
			<td align="left"><span class="commFont commLabel">{*[颜色设置]*}：</span><br>
			<table class="table_hasborder" border=1 cellpadding="0" cellspacing="0" bordercolor="gray" >
				<tbody id="tb">
					<tr>
						<tr>
							<td align="left" class="commFont">{*[StateLabel]*}</td>
							<td align="left" class="commFont">{*[Color]*}</td>
							<td align="left"><input type="button" value="{*[Add]*}" onclick="addRows()" />
						</td>
					</tr>
				</tbody>
			</table>
			<s:hidden id="queryString" name="content.queryString" />
			</td>
		</tr>
				</table>
				</td>
			</tr>
			</table>
			</s:form>
			</div>
</body>
</o:MultiLanguage>
</html>