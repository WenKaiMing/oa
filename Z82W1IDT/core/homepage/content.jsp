<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>


<s:bean name="cn.myapps.core.style.repository.action.StyleRepositoryHelper" id="sh">
	<!-- ww:param name="applicationid" value="#parameters.application" /> -->
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html>

<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String userName = webUser.getName();
	String appid =(String)request.getParameter("application");
	String path=request.getContextPath();
	//String homepageId = (String)request.getParameter("content.id");
%>

<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.user.homepage_info]*}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/main.css" type="text/css">
	<style type="text/css">
	.btn {
		font-size: 9pt;
		TEXT-ALIGN: center;
		cursor: pointer;
		color: #000;
		background-image: url('<s:url value = "/resource/imgnew/buttonsmall.gif" />');
		background-repeat: no-repeat;
		display: block;
		background-position: left top;
		padding: 3px 0px 0px 0px;
		float: left;
		width: 70px;
		height: 21px
	}
</style>
	<script src="<s:url value='/script/list.js'/>"></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script type='text/javascript'
	src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script type="text/javascript" src="../dynaform/form/webeditor/fckeditor.js"></script>
	<script language="JavaScript" type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var applicationId =  "<%=appid%>";
function ev_preview(){
	var viewid = document.forms[0].elements['content.id'].value;
	if (viewid == "") {
		alert("{*[Please_Save]*}");
	}
	else {
		var url = '<s:url action="displayView" />' 
	  			+ '?_viewid=' + viewid;
	 	//alert(url);
		window.open(url);
  	}
}
function ev_isPagination(item) {
	//alert(item);
	if (item.checked && item.value == 'true') {
		pl_tr.style.display="";
	} else {
		pl_tr.style.display="none";
		document.getElementById('content.pagelines').value="";	
	}
}
function ev_save() {
	document.forms[0].submit();
}

function selectRole() {
	var roles = document.getElementById("content.roleIds").value;
	var path = "<%=path%>";
	var url = path+'/core/role/linkRole.action?application='+applicationId+'&tempRoles='+roles;
	OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {"tempRoles":roles},
				title: '{*[cn.myapps.core.user.select_role]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("application_info_generalTools_homePage_info");
					if (rtn){
						if (rtn == 'clear') {
							document.getElementById("content.roleIds").value = "";
							document.getElementById("content.roleNames").value = "";
						}else{
							document.getElementById("content.roleIds").value = rtn;
							RoleUtil.findRoleNames(rtn, insertName);
						}
					}
				}
		});
}

function clearRole(){
	document.getElementById("content.roleIds").value = "";
	document.getElementById("content.roleNames").value = "";
}


function validation(){
	var name = document.getElementsByName("content.name")[0];
	if(name.value=='' || name.value==null){
		alert("{*[cn.myapps.core.user.please_input_name]*}");
		return false;
	}else{
		return true;
	}
}
function insertName(data) {
	document.getElementById("content.roleNames").value = data;
}

function modeChange(mode) {
	//var homepageid = '<s:property value="content.id"/>';
	document.getElementById('basicpage').style.display = '';
	document.getElementById('advancepage').style.display = 'none';
	if(mode == '16'){//常规模式
		document.getElementById('mode_1_tab').style.display = 'none';
		//document.getElementById('mode_1_sll').style.display = 'none';
		//document.getElementById('mode_1_slc').style.display = 'none';
		//if(homepageid != null && homepageid != ''){
			document.getElementById('reminder').style.display = '';
		//}
	}else if(mode = '256'){//自定义模式
		document.getElementById('mode_1_tab').style.display = '';
		//document.getElementById('mode_1_sll').style.display = '';
		//document.getElementById('mode_1_slc').style.display = '';
		document.getElementById('reminder').style.display = 'none';
		//ev_switchpage("basicpage");
	}
}

//change the color of font on the button
function changeButtonStyle(sId){
	document.getElementById("basicpageSpan").style.color = "#000000";
	document.getElementById("advancepageSpan").style.color = "#000000";
	sId = sId + "Span";
	if (document.getElementById(sId)) {
		document.getElementById(sId).style.color = "#E00101";
	}
}


//--jack--选择模板
function showSelectTemplate() {
	var templateStyle = jQuery("#templateStyle").attr("value");
	var url = contextPath+ "/core/homepage/reminder/selectTemplate.action?templateStyle=" + templateStyle;
	OBPM.dialog.show({
				opener:window.parent.parent,
				width: 700,
				height: 500,
				url: url,
				//args: {"templateStyle":templateStyle},
				title: '{*[Select.Template]*}',
				close: function(rtn) {
					if(rtn == null || rtn == ""){
						//alert("未选择模板，返回值为空值");
					}else{
						jQuery("#templateStyle").attr("value",rtn);
						setTemplateStyle();
						//把原模板中的元素重新添加到新模板中
						parseTemplateElementValue();
						//对新模板和元素分配数据重新储存
						setTemplateElementValue();
					}
				}
		});
}

//--jack--构建并显示表格
function setTemplateStyle(){
	var templateStyle = jQuery("#templateStyle").attr("value");
	if(templateStyle == null || templateStyle == ""){
		templateStyle = "td1|td2|td3|td4|td5|td6";
		jQuery("#templateStyle").val("td1|td2|td3|td4|td5|td6");
	}
	var templateHtml ='<table id="tempTable" border="1px" style="width: 80%; height: 80%; table-layout: fixed;"><tr>';
	templateHtml = parseTemplateStyle(templateHtml,templateStyle);
	templateHtml += '</tr></table>';
	jQuery("#templateDiv").html(templateHtml);
	//设置表格
	setSizeTempTable();
	//为td加载添加元素控件
	addModuleOfTd();
}

//--jack--设置单元格布局
function parseTemplateStyle(templateHtml,tempSty){
	var templateArray = tempSty.split("|");
	//设置换行标志
	var turnLine = false;
	for(var i=0; i<templateArray.length; i++){
		//添加换行标志--开始
		if(turnLine == false && templateArray[i].substr(2,1)>=4){
			turnLine = true;
			templateHtml += '</tr><tr>';
		}
		//添加换行标志--结束
		//根据id结构设置td格式--开始
		if(templateArray[i].match("-")){
			var templateTdArray = templateArray[i].split("-");
			templateHtml += "<td id='" + templateArray[i] + "' ";
			for(var j=1; j<templateTdArray.length; j++){
				//根据横列和数量标志判断合并横或纵及要合并的单元格数量--开始
				if(templateTdArray[j].substr(0,1) == "x"){
					templateHtml += "colspan='" + templateTdArray[j].substr(1,1) + "' ";
				}else{
					templateHtml += "rowspan='" + templateTdArray[j].substr(1,1) + "' ";
				}
				//根据横列和数量标志判断合并横或纵及要合并的单元格数量--结束
			}
			templateHtml += "><div class='eleParentDiv'>&nbsp;</div></td>";
		}else{
			templateHtml += "<td id='" + templateArray[i] + "'><div class='eleParentDiv'>&nbsp;</div></td>";
		}
		//根据id结构设置td格式--结束
	}
	return templateHtml;
}

//增加图形控件到td中,以触发添加提醒事件
function addModuleOfTd(){
	var ModuleOfTdHtml = "<div class='addModuleDiv'><img style='cursor:pointer' title='{*[Add.Reminder.Element]*}' onclick='showAddElementWindow(this)' src='<s:url value='/portal/default/resource/imgv2/front/grid/add.gif'/>'/></div>";
	jQuery("#templateDiv table td").prepend(ModuleOfTdHtml);
}

//--jack--弹出选择元素的窗口
function showAddElementWindow(obj){
	//var url = contextPath+ "/core/dynaform/summary/list.action?application=" + applicationId+"&n_scope=0|6";
	var homepageId = '<s:property value="content.id" />';
	var url = contextPath+ "/core/widget/new.action?application=" + applicationId+"&content.containerType=homepage&content.containerId="+homepageId+"&n_scope=0|6";
	var generalPage = jQuery("#generalPage").attr("value");
	var tdOfId = obj.parentNode.parentNode.id;
	
	OBPM.dialog.show({
		opener:window.parent.parent,
		width: 420,
		height: 350,
		url: url,
		args: {},
		title: '{*[cn.myapps.core.user.add_widget]*}',
		close: function(rtn) {
			if(rtn == null || rtn == ""){
				//alert("未选择元素，返回值为空值");
			}else{
				var rtns = rtn.split("'");
				addElementToTd(tdOfId,rtns[0],rtns[1]);
				setTemplateElementValue();
			}
		}
	});
}

//--jack--把元素加入对应td中
function addElementToTd(tdOfId,tempEleId,tempEleTitle){
	var tempEleIds = tempEleId.split("|");
	if(tempEleTitle != null && tempEleTitle != ""){
		var tempEleTitles = tempEleTitle.split("|");
	}
	if(tempEleIds.length == 1 && tempEleIds[0] == ""){
			return;
	}
	var elementDivHtml = "";
	if(jQuery("#" + tdOfId + " .eleParentDiv").length != 0){
		for(var i=0; i<tempEleIds.length; i++){
			elementDivHtml += "<div class='elementOfTd' id='" + tempEleIds[i] + "'><div style='float: left; width: 85%;word-wrap: break-word; word-break: break-all;'>" + tempEleTitles[i] + "</div>";
			elementDivHtml += "<div style='float: right;' onclick='doDeleteEle(this)'><img style='cursor:pointer' title='{*[Delete.Reminder.Element]*}' src='<s:url value='/portal/default/resource/imgv2/front/grid/delete.gif'/>'/></div></div>";
		}
		jQuery("#" + tdOfId + " .eleParentDiv").append(elementDivHtml);
	}else{
		for(var i=0; i<tempEleIds.length; i++){
			elementDivHtml += "<div class='elementOfTd' id='" + tempEleIds[i] + "'><div style='float: left; width: 85%;word-wrap: break-word; word-break: break-all;'>" + tempEleTitles[i] + "</div>";
			elementDivHtml += "<div style='float: right;' onclick='doDeleteEle(this)'><img style='cursor:pointer' src='<s:url value='/portal/default/resource/imgv2/front/grid/delete.gif'/>'/></div></div>";
		}
		jQuery("#templateDiv table td .eleParentDiv").first().append(elementDivHtml);
	}

}

//--jack--设置json数据
function setTemplateElementValue_bak(){
	var elementValue = "{";
	var tdObjs = jQuery("#templateDiv table td");
			
	for(var i=0; i<tdObjs.length; i++){
		if(i!=0){
			elementValue += ",";
		}
		elementValue += "'" + tdObjs[i].id + "':";
		var tdDivObjs = jQuery("#" + tdObjs[i].id + " .elementOfTd");
		var tdDivObjsId = "'";
		var tdDivObjsTitle = "'";
		
		if(tdDivObjs.length != 0){
			tdDivObjsId += tdDivObjs[0].id;
			tdDivObjsTitle += tdDivObjs[0].innerText;
			
			for(var j=1; j<tdDivObjs.length; j++){
				tdDivObjsId += "|" + tdDivObjs[j].id;
				tdDivObjsTitle += "|" + tdDivObjs[j].innerText;
			}
		}
		tdDivObjsId += "'";
		tdDivObjsTitle += "'";
		elementValue += tdDivObjsId + ";" + tdDivObjsTitle;
	}
	elementValue += "}";
	jQuery("#templateElement").val(elementValue);
	//doSubmit();
}

//--jack--解释json数据
function getTemplateElementValue_bak(){
	var templateElement = jQuery("#templateElement").attr("value");
	if(templateElement == null || templateElement == ""){
		templateElement = "{'td1':'','td2':'','td3':'','td4':'','td5':'','td6':''}";
	}
	templateElement = templateElement.slice(1,-1);
	var templateElementSubs = templateElement.split(",");
	if(templateElementSubs.length == 0){
		return;
	}
	for(var i=0; i<templateElementSubs.length; i++){
		var templateElementSubsSubs = templateElementSubs[i].split(":");
		if(templateElementSubsSubs.length == 0){
			return;
		}
		var templateTdId = templateElementSubsSubs[0].slice(1,-1);
		var templateTdElements = templateElementSubsSubs[1].split(";");
		if(templateTdElements[0] != null){
			var templateTdElementId = templateTdElements[0].slice(1,-1);
		}else{
			return;
		}
		if(templateTdElements[1] != null){
			var templateTdElementTitle = templateTdElements[1].slice(1,-1);
		}
		addElementToTd(templateTdId,templateTdElementId,templateTdElementTitle);
	}
	
}

	
//设置表格中td及div大小
function setSizeTempTable(){	
	//jQuery("#tempTable").height(jQuery("body").height()* 0.5);
	//jQuery("#tempTable").width(jQuery("body").width() * 0.6);
	var tdOneHeight = jQuery("body").height() * 0.2;
	var tdOneWidth = tdOneHeight;
	
	var tdSizeObj = jQuery("#tempTable td");
	for(var i=0; i<tdSizeObj.length; i++){
		if(tdSizeObj[i].colSpan != ""){
			tdSizeObj[i].width = tdSizeObj[i].colSpan * tdOneWidth;
		}else{
			tdSizeObj[i].width = tdOneWidth;		
		}
		
		if(tdSizeObj[i].rowSpan != ""){
			tdSizeObj[i].height = tdSizeObj[i].rowSpan * tdOneHeight;
		}else{
			tdSizeObj[i].height = tdOneHeight;
		}
		jQuery("#" + tdSizeObj[i].id + " .eleParentDiv").height(tdSizeObj[i].height-18);
		
	}
}

jQuery(window).resize(function(){
	setSizeTempTable();
});


//--jack--删除td中的元素
//并重新把json值存入templateStyle中
function doDeleteEle(Obj){
	//Obj.parentNode.outerHTML = "";
	Obj.parentNode.parentNode.removeChild(Obj.parentNode);
	setTemplateElementValue();
}

//待办提醒功能函数

function ev_saveAndNew(){
	if(validation()){
		document.forms[0].action=
			'<s:url action="saveAndNewHomepage"><s:param name="tab" value="%{\'1\'}"/><s:param name="selected" value="%{\'btnHomepage\'}"/></s:url>';
		document.forms[0].submit();
	}
}

function doSave(){
	if(validation()){
		document.forms[0].action = "<s:url value='/core/user/saveElement.action'/>";
		document.forms[0].submit();
	}
}

function doExit(){
	var sm_name = document.getElementById("sm_name").value;
	var _currpage = '<s:property value="%{#parameters._currpage}"/>';
	var _pagelines = '<s:property value="%{#parameters._pagelines}"/>';
	var url = "<s:url value='/core/user/queryHomepage.action'/>?mode=application&s_applicationid=" + 
	applicationId + "&application=" + applicationId + "&tab=1&selected=btnHomepage&sm_name=" + sm_name + 
	"&_currpage=" + _currpage + "&_pagelines=" + _pagelines;
	document.location.href = url;
}

//切换角色
function doChangeRoles(Obj){
	if(Obj.value == 1){
		jQuery("#contentDisplay").css("display","none");
	}else{
		jQuery("#contentDisplay").css("display","block");
	}
}


//切换基本和高级模式
function ev_switchpage(Obj) {
	jQuery("#reminder").css("display","none");
	jQuery("#advancepage").css("display","none");
	if(Obj.value == 16){
		jQuery("#reminder").css("display","");
	}else{
		jQuery("#advancepage").css("display","");
	}
}

jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_generalTools_homePage_info");
	jQuery("#contentMainDiv").height(jQuery("body").parent().parent().height() - 81);
	setTemplateStyle();
	parseTemplateElementValue();
	/*
	var contentType = jQuery("#contentType");
	if(contentType.value == "" || contentType.value == null){
		jQuery("#contentType").attr("value","16");
	}*/
	// 调整Fckeditor高度
	var bodyHeight = jQuery(window).height();
	oFCKeditor.Height = bodyHeight - "300";
});
//调整Fckeditor所在td的高度
function adjustViewLayout(){		
	var documentH=parent.document.body.offsetHeight;
	jQuery("#FCKeditorid").height(documentH-200);
}
jQuery(window).load(function(){
	adjustViewLayout();
}).resize(function(){
	adjustViewLayout();
});


/**
 *定义小工具对象 
 *@author Happy
 */
function Widget(id,title,position,color,index){
	this.id = id;//widget的id
	this.title = title;//标题
	this.position = position;//在模板中的位置
	this.color = color;//边框颜色
	this.index = index;//排序号
}
/**
 * 生成小工具布局描述（JSON格式）
 *@author Happy
 */
function setTemplateElementValue(){
	var widgets = [];//小工具集合，存储首页的所有widget
	var tdObjs = jQuery("#templateDiv table td");
			
	for(var i=0; i<tdObjs.length; i++){
		var index = 0;
		var position = tdObjs[i].id;
		var tdDivObjs = jQuery("#" + tdObjs[i].id + " .elementOfTd");
		
		for(var j=0; j<tdDivObjs.length; j++){
			var widget = new Widget(tdDivObjs[j].id,tdDivObjs[j].innerText,position,"",index++);
			widgets.push(widget);
		}
	}
	jQuery("#templateElement").val(JSON.stringify(widgets));
}
/**
 * 解析小工具布局JSON数据，在页面上展示
 *@author Happy
 */
function parseTemplateElementValue(){
	var templateElement = jQuery("#templateElement").attr("value");
	if(templateElement != null && templateElement.length>0 && templateElement.indexOf("[")==0){
		var widgets = JSON.parse(templateElement);
		for(var i=0;i<widgets.length;i++){
			var widget = widgets[i];
			addElementToTd(widget.position,widget.id,widget.title);
		}
	}
}

</script>
</head>
<body class="contentBody" width="80%">
<input type="hidden" id="mark4Fckeditor" value="pedding" />
<s:form name="viewform" action="" method="post" theme="simple">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
				 <td valign="top" align="right">
					<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
					<button type="button" class="button-image" onclick="ev_saveAndNew()"><img
						src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
					<button type="button" onclick="doSave()" class="button-image""><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					<button type="button" class="button-image"
						onClick="doExit()"><img
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
	<div class="navigation_title">{*[HomePage]*}</div>
	<div id="contentMainDiv" style="overflow-y: auto; overflow-x: hidden; width:100%;">
	<%@include file="/common/page.jsp"%>
		<table cellpadding="0" cellspacing="0" width="100%" class="homepage_table">
			<tr>
				<td class="commFont" align="left">{*[Name]*}:</td>
				<td class="commFont" align="left">{*[Creator]*}:</td>
			</tr>
			<tr>
				<td width="50%">
					<s:textfield cssClass="input-cmd" name="content.name" cssStyle="width:50%;"/>
				</td>
				<td width="50%">
					<s:textfield cssClass="input-cmd" readonly="true" name="content.creator" cssStyle="width:50%;"/>
				</td>
			</tr>
			<tr>
				<td class="commFont" align="left">{*[cn.myapps.core.user.show_type]*}:</td>
				<td class="commFont" align="left">{*[cn.myapps.core.user.label.publish_or_not]*}:</td>
			</tr>
			<tr>
				<td align="left" width="50%">
				<s:radio name="content.displayTo"  onclick="doChangeRoles(this)" list="#{'1':'{*[cn.myapps.core.user.display_all_role]*}', '0':'{*[cn.myapps.core.user.display_specify_role]*}'}" theme="simple"/>
				<s:if test="content.displayTo == 1">
				<div id="contentDisplay" style="display:none;">
				</s:if>
				<s:else>
				<div id="contentDisplay" style="display:block;">
				</s:else>
					<s:textfield cssClass="input-cmd" id="content.roleNames" readonly="true" name="content.roleNames" cssStyle="width:50%;"/>
					<s:textfield cssClass="input-cmd" id="content.roleIds" name="content.roleIds" cssStyle="display:none;"/>
					<button type="button" class="button-image" style="color: #1E50C4" onclick="selectRole()">{*[Choose]*}</button>
					<button type="button" class="button-image" style="color: #1E50C4" onclick="clearRole()">{*[Clear]*}</button>
				</div>
				</td>
				<td align="left" width="50%">
					<s:radio name="content.published" theme="simple" list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.user.no]*}'}" 
					value="%{content.published + ''}" />
				</td>
			</tr>
			<s:if test="content.type == 1">
			<tr>
				<td class="commFont" align="left">{*[cn.myapps.core.user.define_type]*}:</td>
				<td></td>
			</tr>
			<tr>
				<td align="left" width="50%">
					<s:radio name="content.defineMode" list="#{'16':'{*[Regular]*}', '256':'{*[cn.myapps.core.user.customize]*}'}"
						onclick="ev_switchpage(this)" value="%{content.defineMode + ''}" theme="simple"/>
				</td>
				<td></td>
			</tr>
			</s:if>
		</table>
	<s:if test="content.defineMode == 256">
		<table id="advancepage" class="table_noborder" style="padding-left: 20px;padding-right: 20px;">
	</s:if>
	<s:else>
		<table id="advancepage" class="table_noborder" style="padding-left: 20px;padding-right: 20px;display:none;">
	</s:else>
			<tr valign="top">
				<td class="tipsStyle">*桌面客户端及手机客户端不能显示使用脚本生成的首页代办</td>
			</tr>
			<tr valign="top">
				<td id="FCKeditorid">
					<input type="hidden" id="moduleid" name="moduleid" value="<s:property value='#parameters.s_module'/>">
					<s:textarea cssStyle="display:none" name="content.templateContext" theme="simple" />
					
					<script type="text/javascript">
						var sBasePath = '<s:url value="/core/dynaform/form/webeditor/"></s:url>';
						var oFCKeditor = new FCKeditor("content.templateContext");
						oFCKeditor.BasePath	= sBasePath;
						oFCKeditor.ReplaceTextarea();
					</script>
				</td>
			</tr>
		</table>
		<s:hidden name="sm_name" value="%{#parameters.sm_name}" id="sm_name"/>
		<s:hidden name='content.version' />
		<s:hidden name="content.titlescript" />
		<s:hidden name="tab" value="1" />
		<s:hidden name="selected" value="%{'btnHomepage'}" />
		<s:hidden name="content.templateStyle" id="templateStyle" />
		<s:hidden name="content.templateElement" id="templateElement" />
		<s:hidden name="content.userId" id="userId" />
		<s:hidden name="content.type" id="userDefinedType" />
		
	<s:if test="content.defineMode == 16">	
		<table id="reminder" cellpadding="0" cellspacing="0" width="100%">
	</s:if>
	<s:else>
		<table id="reminder" cellpadding="0" cellspacing="0" width="100%" style="display:none;">
	</s:else>
			<tr>
				<td>
					<div id="tempDivParent" style="border: 1px solid #d8dadc; width:550px; height: 350px; margin: 10px; text-align: center;">
						<div style="background-color: #d8dadc;">
							<table width="100%">
								<tr>
									<td>{*[Select.Template.For.Homepage.Reminder]*}：</td>
									<td align="right">
										<button type="button" title="{*[Select.Other.Template]*}" class="button-image" onClick="showSelectTemplate()">
											<img src="<s:url value="/resource/imgnew/act/act_20.gif"/>">{*[Select.Other.Template]*}
										</button>
									</td>
								</tr>
							</table>
						</div>
						<div id="templateDiv" class="templateDiv" style="padding: 10px;">
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
