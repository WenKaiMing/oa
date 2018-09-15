<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:bean
	name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
	id="sh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<o:MultiLanguage>

	<head>
<title>{*[cn.myapps.core.dynaform.view.info]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#col_list table td,#act_list table td {
	padding-left: 3px;
	border: 2px solid #FFFFFF;
}

@-moz-document url-prefix(){
#authority td{
	text-align: center;
	white-space: nowrap;
}
}
</style>
	</head>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<script src="<s:url value='/script/list.js'/>"></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ColumnUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ActivityUtil.js"/>'></script>
	<script language="JavaScript" type="text/javascript"><!--

	jQuery(function(){
		//-aimar-阻止<button>的默认行为，因为在ff下点击<from>表单中的<button>会默认提交表单
		jQuery("button").click(function(e){e.preventDefault();});
	});
	
var contextPath = '<%=request.getContextPath()%>';
var mode = '1';
var wx = '480px';
var wy = '250px';
var openTypeOptions = "";
var openTypeGridOptions = "";
var openTypeDivOptions = "";
function ev_createMenu(){//生成菜单
	var viewid = document.forms[0].elements['content.id'].value;
	var applicationid = '<%=request.getParameter("application")%>';
	var url = contextPath + "/core/dynaform/view/menu.jsp?viewid=" + viewid + "&application=" + applicationid;
	//var rtn = showframe("{*[menu]*}", url);
	OBPM.dialog.show({
				opener:window.parent.parent,
				width: 600,
				height: 400,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.dynaform.view.create_menu]*}',
				close: function(rtn) {
					if(rtn != null && rtn != '')
						alert(rtn);
				}
		});
}

function ev_preview(){
	
	var viewid = document.forms[0].elements['content.id'].value;
	if (viewid == "") {
		alert("{*[cn.myapps.core.dynaform.view.please_save]*}");
	}
	else {
		var url = '<s:url value="/core/dynaform/view/preview.jsp" />' + '?_viewid=' + viewid + '&application=<%=request.getParameter("application")%>';
		window.open(url);
  	}
}

function fadein(obj) {
	obj.style.backgroundColor = "#E9E9E9";
}

function fadeout(obj) {
	obj.style.backgroundColor = "#FFF";	
}

function ev_isPagination(item) {
	var _pagelines = '<s:property value="content.pagelines"/>';
	var obj = document.getElementsByName('content.pagelines')[0];
	if(_pagelines == '5'){
		_pagelines = '05';
	}
	if (item.value == 'true') {
		document.getElementById("pl_tr").style.display="";
		if(_pagelines != '' && _pagelines != null){
			obj.value = _pagelines;
		}else{
			obj.options[1].selected = 'selected';
		}
	} else {
		document.getElementById("pl_tr").style.display="none";
		obj.options[obj.selectedIndex].value = '';
	}
}

function selectAllCols(b, isRefresh) {
	var c = document.all('columnSelects');
	if (c == null)
		return;

	if (c.length != null) {
		for (var i = 0; i < c.length; ++i)
			c[i].checked = b && !(c[i].disabled);
	} else {
		c.checked = b;
	}
}

function selectAllAct(b, isRefresh) {
	var c = document.all('activitySelects');
	if (c == null)
		return;

	if (c.length != null) {
		for (var i = 0; i < c.length; ++i)
			c[i].checked = b && !(c[i].disabled);
	} else {
		c.checked = b;
	}
}

function evChangLinkType(linkType){
	document.getElementById("link.td.title").style.display = "none";
	document.getElementById("link.td.content").style.display = "none";
	
	if(linkType == 'LINK' || linkType == 'link'){
		document.getElementById("link.td.title").style.display = "";
		document.getElementById("link.td.content").style.display = "";
	}
	
	if(linkType != 'VIEW' && linkType != 'view'){//Node open type = Link & Form
		var temp = document.getElementsByName("_readOnly");
		for(var i=0; i<temp.length; i++){
			temp[i].disabled = "disabled";
		}
	}else{//Node open type = View
		var temp = document.getElementsByName("_readOnly");
		for(var i=0; i<temp.length; i++){
			temp[i].disabled = "";
		}
	}
}

/*
function initAuthFields() {
	var auth_user = "<s:property value="content.auth_user" />";
	var auth_fields = "<s:property value="content.auth_fields" />";
	var auth_role = "<s:property value="content.auth_role" />";
	
	if (auth_user != null && auth_user.trim().length > 0) {
		document.getElementsByName('content.auth_user')[0].checked = true;
	}
	if (auth_fields != null && auth_fields.trim().length > 0) {
		document.getElementsByName('content.auth_fields')[0].checked = true;
	}
	if (auth_role != null && auth_role.trim().length > 0) {
		document.getElementsByName('content.auth_role')[0].checked = true;
	}
	
}
*/

//prototype定义trim函数
String.prototype.trim = function(){
         //用正则表达式将前后空格
         //用空字符串替代。
         return this.replace(/(^\s*)|(\s*$)/g,"");
}

//去所有空格   
String.prototype.trimAll = function(){   
    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
}; 

//名称失去焦点事件
function checkName(s){
	var temp = document.getElementsByName('content.name')[0].value.trimAll();
	document.getElementsByName('content.name')[0].value = temp;
}
//菜单描述失去焦点事件
function checkResourceDesc(s){
	var temp = document.getElementsByName('_resourcedesc')[0].value.trimAll();
	document.getElementsByName('_resourcedesc')[0].value = temp;
}


function showProperty(obj) {
	var frame = '<iframe frameborder="0" src="<s:url value='/core/domain/basicInfo.action'/>?id=<%=request.getParameter("id")%>"></iframe>';
	jQuery("#act_property").html(frame);
	
}

function RelStr(str){
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();
	}
}

function createJSONStr() {
	var fields=  document.getElementsByName("fields");
	var str = '[';
	if(fields.length>0){
		 for (var i=0;i<fields.length;i++) {
			if (fields.options(i).value != '') {
				str += '{';
				str += '"text"' +':\''+fields.options(i).text+'\',';
				str += '"value"' +':\''+fields.options(i).value+'\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
	}
	str += ']';
	
	return str;
}

function resetOpenTypeOptions(type){
	var openType = document.getElementById("openType");
	openTypeOptions = openType.options;
	if(openTypeGridOptions == "" || openTypeGridOptions == null){
		for(var i=0;i<openTypeOptions.length;i++){
			var option = openTypeOptions[i];
			if(option.value == 288 ){
				openTypeGridOptions = option;
				break;
			}
		}
	}
	jQuery("#openType option[value='288']").remove();
	if(type ==1){
		jQuery("#openType").append(openTypeGridOptions);
		if(openType.value == 288){
			openType.value =288;
		}
	}else{
		if(openType.value == 288){
			openType.value = 1;
		}
	}
	//地图视图不支持弹出层显示
	if(openTypeDivOptions == "" || openTypeDivOptions == null){
		for(var i=0;i<openTypeOptions.length;i++){
			var option = openTypeOptions[i];
			if(option.value == 277 ){
				openTypeDivOptions = option;
				break;
			}
		}
	}
	jQuery("#openType option[value='277']").remove();
	if(type != 18){
		jQuery("#openType").append(openTypeDivOptions);
		if(openType.value == 277){
			openType.value = 277;
		}
	}else{
		if(openType.value == 277){
			openType.value = 1;
		}
	}
}

function viewTypeChange(type){
	//document.getElementById('relationDateColum').disabled=false;
	OBPM(".treeview").hide(); // 隐藏class为treeview的元素
	//OBPM(".cldview").hide();
	
	var _displayType = document.getElementsByName("content.displayType")[0];
	var _templateForm_label_td = document.getElementById("_templateForm_label_td");
	var _templateForm_td = document.getElementById("_templateForm_td");
	var _displayType_label_td = document.getElementById("_displayType_label_td");
	var _displayType_td = document.getElementById("_displayType_td");
	var _content_display = document.getElementById("_content_display");
	
	var span_tab5_img = document.getElementById("span_tab5_img");
	var span_tab5_input = document.getElementById("span_tab5_input");
	
	var openType = document.getElementById("openType");
	
	//_templateForm_label_td.style.display = '';
	//_templateForm_td.style.display = '';
	_displayType_label_td.style.display = '';
	_displayType_td.style.display = '';
	
	span_tab5_img.style.display = 'none';
	span_tab5_input.style.display = 'none';
	
	resetOpenTypeOptions(type);
	
	if (type == 18 || type == 19) {
		// 屏蔽 甘特视图 和 地图视图 的水印功能
		jQuery("td#showWaterMark").hide();
		jQuery("td#waterMarkScript").hide();
	} else {
		jQuery("td#showWaterMark").show();
		jQuery("td#waterMarkScript").show();
	}

	if(type==1 || type==16 || type==0x0000014){//列表视图 or 日历视图 or 折叠视图
		if(openType.value == '288'){
			_displayType_td.style.display = 'none';
			_displayType_label_td.style.display = 'none';
		}else{
			_displayType_label_td.style.display = '';
			_displayType_td.style.display = '';
		}
		on_displayType_change_handle(_displayType);
	}else if(type==0x0000012){//地图视图
		_content_display.options[0].selected="selected";	/**地图视图不支持按模板表单的格式呈现，所以把数据呈现类型设为"按数据来源表单的格式呈现"*/
		on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);	
		_displayType_td.style.display = 'none';
		_displayType_label_td.style.display = 'none';
		ganttViewTypeBaseInfoReset(false);
		var isPaginationObj=document.getElementsByName("_isPagination");
		for(var i=0;i<isPaginationObj.length;i++){
			isPaginationObj[i].disabled="disabled";
		}
		document.getElementsByName("content.pagelines")[0].disabled="disabled";
		
		span_tab5_img.style.display = '';
		span_tab5_input.style.display = '';
	}else if (type==0x0000013){//选择甘特视图时
		_content_display.options[0].selected="selected";	/**甘特视图不支持按模板表单的格式呈现，所以把数据呈现类型设为"按数据来源表单的格式呈现"*/
		on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);	
		_displayType_td.style.display = 'none';
		_displayType_label_td.style.display = 'none';
		ganttViewTypeBaseInfoReset(true);
	}else if(type==0x0000011){  ////选择树形视图时
		_content_display.options[0].selected="selected";	/**树形视图不支持按模板表单的格式呈现，所以把数据呈现类型设为"按数据来源表单的格式呈现"*/
		on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);	
		_displayType_td.style.display = 'none';
		_displayType_label_td.style.display = 'none';
		ganttViewTypeBaseInfoReset(false);
		var isPaginationObj=document.getElementsByName("_isPagination");
		for(var i=0;i<isPaginationObj.length;i++){
			isPaginationObj[i].disabled="disabled";
		}
		document.getElementById("link.td.title").style.display = "none";
		document.getElementById("link.td.content").style.display = "none";
		document.getElementsByName("content.pagelines")[0].disabled="disabled";
		OBPM(".treeview").show();
	}else{
		ganttViewTypeBaseInfoReset(false);
	}
	resetOptions();
	initRadio(type)
}

function initRadio(type){
	var _isShowTotalRowObj = document.getElementsByName("_isShowTotalRow");
	var _isRefreshObj = document.getElementsByName("_isRefresh");
	var _isPaginationObj = document.getElementsByName("_isPagination");
	var _pagelinesObj = document.getElementsByName("content.pagelines");
	var _readOnlyObj = document.getElementsByName("_readOnly");
	
	jQuery("#tips").text("");

	if(type==1){//普通视图 
		jQuery("input[name='_isShowTotalRow']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isRefresh']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isPagination']").each(function(){
			this.disabled = false;
		});
		jQuery("select[name='content.pagelines']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_readOnly']").each(function(){
			this.disabled = false;
		});
	}else if (type==16){ //日历视图
		jQuery("input[name='_isShowTotalRow']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_isRefresh']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isPagination']").each(function(){
			this.disabled = true;
		});
		jQuery("select[name='content.pagelines']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_readOnly']").each(function(){
			this.disabled = false;
		});
	}else if(type==0x0000012){  //地图视图
		jQuery("input[name='_isShowTotalRow']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isRefresh']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isPagination']").each(function(){
			this.disabled = true;
		});
		jQuery("select[name='content.pagelines']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_readOnly']").each(function(){
			this.disabled = false;
		});
	}else if (type==0x0000013){  //甘特视图时
		jQuery("input[name='_isShowTotalRow']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_isRefresh']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_isPagination']").each(function(){
			this.disabled = false;
		});
		jQuery("select[name='content.pagelines']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_readOnly']").each(function(){
			this.disabled = true;
		});
	}else if(type==0x0000011){  //树形视图时
		jQuery("input[name='_isShowTotalRow']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isRefresh']").each(function(){
			this.disabled = false;
		});
		jQuery("input[name='_isPagination']").each(function(){
			this.disabled = true;
		});
		jQuery("select[name='content.pagelines']").each(function(){
			this.disabled = true;
		});
		jQuery("input[name='_readOnly']").each(function(){
			this.disabled = true;
		});
	}else if(type==0x0000014){  //折叠视图时
		jQuery("input[name='_isShowTotalRow']").prop( "disabled", false);
		jQuery("input[name='_isRefresh']").prop( "disabled", false);
		jQuery("input[name='_isPagination']").prop( "disabled", true);
		jQuery("select[name='content.pagelines']").prop( "disabled", true);
		jQuery("input[name='_readOnly']").prop( "disabled", true);
		jQuery("#tips").text("折叠视图，第一列为默认的折叠列，此列正确的内容输出格式为：AA\BB，其中“\”为分隔符，系统将以AA作为折叠的键值。");
	}
}

function ganttViewTypeBaseInfoReset(isopen){
	var showTotalRowObj=document.getElementsByName("_isShowTotalRow");
	var isRefreshObj=document.getElementsByName("_isRefresh");
	var isPaginationObj=document.getElementsByName("_isPagination");
	var readOnlyObj=document.getElementsByName("_readOnly");
	if(isopen){
		for(var i=0;i<showTotalRowObj.length;i++){
			showTotalRowObj[i].disabled="disabled";
		}
		for(var i=0;i<isRefreshObj.length;i++){
			isRefreshObj[i].disabled="disabled";
		}
		for(var i=0;i<isPaginationObj.length;i++){
			isPaginationObj[i].disabled="disabled";
		}
		document.getElementsByName("content.pagelines")[0].disabled="disabled";
		for(var i=0;i<readOnlyObj.length;i++){
			readOnlyObj[i].disabled="disabled";
		}
		//document.getElementsByName("_searchformid")[0].disabled="disabled";
		
		//document.getElementsByName("content.orderField")[0].disabled="disabled";
		//document.getElementsByName("content.orderType")[0].disabled="disabled";
	}else{
		for(var i=0;i<showTotalRowObj.length;i++){
			showTotalRowObj[i].disabled=false;
		}
		for(var i=0;i<isRefreshObj.length;i++){
			isRefreshObj[i].disabled=false;
		}
		for(var i=0;i<isPaginationObj.length;i++){
			isPaginationObj[i].disabled=false;
		}
		document.getElementsByName("content.pagelines")[0].disabled=false;
		for(var i=0;i<readOnlyObj.length;i++){
			readOnlyObj[i].disabled=false;
		}
		document.getElementsByName("_searchformid")[0].disabled=false;
		//document.getElementsByName("content.orderField")[0].disabled=false;
		//document.getElementsByName("content.orderType")[0].disabled=false;
	}
}

function ev_showTreeDialog() {
	var url = contextPath + '/core/formula/tree.jsp';
	var moduleid = '<s:property value="#parameters.s_module" />';
	var filterScript = document.getElementsByName('content.filterScript')[0].value;
	
	if (moduleid != null && moduleid != '') {
		url = url + '?s_module=' + moduleid;
	} 
	if (filterScript != null && filterScript.trim != '') {
		filterScript = ev_filtrate(filterScript);
		url = addParam(url, 'content', filterScript);
	}
		
	var rtn = showframe('tree', url);
	
	if (rtn != undefined && rtn != '' && rtn != null) {
		//alert("rtn->" + rtn);
		document.getElementsByName('content.filterScript')[0].value = "\""+ rtn + "\""; 
	}
}

	function ev_filtrate(content) { //过滤掉#和"号;
	
		var oldcontent;
		do {
			oldcontent = content;
		  	content = content.replace("#","%23");
		  	content = content.replace("\"","");
		   	//content = content.replace(" ","&nbsp;")
		}

		while(oldcontent != content);
		return content;
	}
	
	function adjust_clientdivheight() {
//		var clientHeight = document.body.scrollHeight - 30;
//		jQuery("#col_list").height(clientHeight+"px");
//		jQuery("#act_list").height(clientHeight+"px");
	}
	
	function adjust_clientdivwidth() {
		
		//var clientWidth = document.body.scrollWidth-150;
		//document.getElementById("columnDiv").style.width = clientWidth+"px";
		//document.getElementById("activityDiv").style.width = clientWidth+"px";

	}
	
	function modeChange(mode) { //Design和Code模式互换
		document.getElementById('editModeValue').value = mode;
		for(var i=0;i<5;i++) {
			var content = document.getElementById('content' + i);
			content.style.display = 'none';
		}
		switch (mode) {
		case '00':
			content0.style.display = '';
			content4.style.display = '';
			break;
		case '01':
			content1.style.display = '';
			content4.style.display = '';
			break;
		case '02':
			content2.style.display = '';
			break;
		case '03':
			content3.style.display = '';
			break;
		default:
			content0.style.display = '';
			break;
		}
	}

	function sessionFieldChange(type, index) {
		var sed = jQuery("#"+ 'seField' + index);
		var sessionprompts = document.getElementById('sessionprompt'+index);
		if (type == 'currsession') {
			sed.css("display","");
			sessionprompts.style.display="";
		}else {
			sed.css("display","none");
			sessionprompts.style.display="none";
		}
	}

	function typeChange(type,index) { //Search Form,System Var,Text,Number,Date的改变
		var ifd = jQuery("#"+ 'ipField' + index);
		var sfd = jQuery("#"+ 'sfField' + index);
		var dfd = jQuery("#"+ 'daField' + index);
		var syd = jQuery("#"+ 'syField' + index);
		var sed = jQuery("#"+ 'seField' + index);
		var sessionprompts = document.getElementById('sessionprompt'+index);		
		
		ifd.css("display","none");
		sfd.css("display","none");
		dfd.css("display","none");
		syd.css("display","none");
		
		switch (type) {
		case '00':
			ifd.css("display","");
			break;
		case '01':
			ifd.css("display","");
			break;
		case '02':
			dfd.css("display","");
			break;
		case '03':
			sfd.css("display","");
			break;
		case '04':
			syd.css("display","");
			break;
		default:
			break;
		}
		if(type != 04){
			sed.css("display","none");
			sessionprompts.style.display="none";
		}else if(syd.val() == "currsession"){
			sed.css("display","");
			sessionprompts.style.display="";
		}
	}
	
	
	var rowIndex = 0;
	var getField = function(data) {
	  	var s =''; 
		s +='<select id="field'+ rowIndex +'" name="field">';
		s +='<option value="'+data.field+'" selected></option>';
		s +='</select>';
		return s; 
	};
	
	var getOperator = function(data) { 
		var operators = ['LIKE','=','<>','>','>=','<','<=','IN','NOT IN'];
		var s =''; 
		s +='<select id="operator'+ rowIndex +'" name="operator" style="width:100%">';
		for (var i=0; i < operators.length; i++) {
			if (data.operator.toUpperCase() == operators[i]) {
				s+='<option value="'+operators[i]+'" selected>'+operators[i]+'</option>';
			} else {
				s+='<option value="'+operators[i]+'">'+operators[i]+'</option>';
			}
		}
		s +='</select>';
		return s; 
	}; 
	
	var getMatch = function(data) {
		var typeCodes = ['00','01','02','03','04'];
		var typeNames = ['{*[Text]*}','{*[Number]*}','{*[Date]*}','{*[SearchForm]*}','{*[System_Var]*}'];
		
		var s =''; 
		s +='<table style="border-collapse:collapse;"><tbody><tr><td style="padding: 0;"><select name="type" onchange="typeChange(this.value,'+ rowIndex +')" style="width:100px;">';
		for (var i=0; i < typeCodes.length; i++) {
			if (data.type.toUpperCase() == typeCodes[i]) {
				s+='<option value="'+typeCodes[i]+'" selected>'+typeNames[i]+'</option>';
			} else {
				s+='<option value="'+typeCodes[i]+'">'+typeNames[i]+'</option>';
			}
		}
		s +='</select></td>';
		
		s +='<td style="padding: 0;"><input type="text" id="ipField'+ rowIndex +'" name="ipField" value="'+HTMLDencode(data.match)+'" size="27"/></td>';
		
		s +='<td style="padding: 0;"><select id="sfField'+ rowIndex +'" name="sfField" >';
		s +='<option value='+HTMLDencode(data.match)+'></option>';
		s +='</select></td>';

		s +='<td style="padding: 0;"><input type="text" id="daField'+ rowIndex +'" name="daField" value="'+HTMLDencode(data.match)+'" class="Wdate" onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd\',minDate:\'\',maxDate:\'2050-12-30\',skin:\'whyGreen\'})" /></td>';

		s +='<td style="padding: 0;"><select id="syField'+ rowIndex +'" name="syField" onchange="sessionFieldChange(this.value, ' + rowIndex + ')">';
		s +='<option value='+HTMLDencode(data.match)+'></option>';
		s +='</select></td>';

		if (data.sessionfield) {
			s += '<td style="padding: 0;"><input style="display:none" type="text" id="seField'+ rowIndex +'" name="seField" value="'+HTMLDencode(data.sessionfield)+'"/>';
			s += '<span id="sessionprompt'+ rowIndex +'" style="color:green"> *{*[cn.myapps.core.dynaform.view.corresponding_session_key]*}</span></td>';
		}
		else {
			s += '<td style="padding: 0;"><input style="display:none" type="text" id="seField'+ rowIndex +'" name="seField" value=""/>';
			s += '<span  style="display:none;color:green" id="sessionprompt'+ rowIndex +'" > *{*[cn.myapps.core.dynaform.view.corresponding_session_key]*}</span></td>';
		}

		s += '</tr></tbody></table>';
		return s;
	};
	var getDelete = function(data) {
	  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)" style="width:100%"/>';
	  	rowIndex ++;
	  	return s;
	};
	jQuery(window).resize(function(){
		resize();
	});		
	function resize(){
		var bodyH = document.body.clientHeight;		
		var contentH=jQuery("#content0_table").height();
		var setH=bodyH-130;	
		if(contentH>setH){			
			jQuery("#content0_cols").height(setH-160);
			jQuery("#content0_cols").css("overflow","auto");				
		}
		jQuery("#viewContent").height(bodyH - 37);
	}
	
	// 根据数据增加行
	function addRows(datas) {
		var cellFuncs = [getField, getOperator, getMatch, getDelete];
	
		var rowdatas = datas;
		if (!datas) {
			var data = {field:'', operator:'', type:'',match:''};
			rowdatas = [data];
		}
		
		DWRUtil.addRows("tb", rowdatas, cellFuncs);
		
		//var fl = document.all('content.relatedForm'); //normal form下拉联动
		var fl = document.getElementById("relatedForm");
		fl.onchange();
	
		var sf = document.getElementsByName('_searchformid')[0]; //search form下拉联动
		sf.onchange();
		
		var types = document.getElementsByName("type");
		for (var i=0; i < types.length; i++) {
			types[i].onchange();
		} 

		ViewHelper.getSystemVariable(function (options) {
			addOptions("syField", options);
		});

		var seFields = document.getElementsByName('seField');
		for (var i = 0; i < seFields.length; i++) {
			if (seFields[i].style.display == 'none') {
				document.getElementById("sessionprompt"+i).style.display = 'none';
			}
		}
		resize();
	}

	// 删除一行
	function delRow(elem, row) {
		if (elem) {
			elem.deleteRow(row.rowIndex);
			//rowIndex --;
		}
	}

	// 增加element options
	function addOptions(elemName, options) {
		var elems = document.getElementsByName(elemName);
		for (var i=0; i<elems.length; i++) {
			var defVal = elems[i].value;
			DWRUtil.removeAllOptions(elems[i].id);
			DWRUtil.addOptions(elems[i].id, options);
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}

	//获取选中的分页radio对象
	function findCheckedObj(){
		var elements = document.getElementsByName("_isPagination");
		for(var i = 0;i<elements.length;i++){
			if(elements[i].checked){
				elements = elements[i];
			}
		}
		return elements;
	}
	
	function ev_init() {
		modeChange('<s:property value="content.editMode" />');
		
		var obj = findCheckedObj();
		ev_isPagination(obj);//初始化是否分页
		
		initFormFields(); // 需在addRows前
		//onAuthField_change_handle(document.getElementsByName("content.auth_fields")[0]);
		on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);		
		//initAuthFields();
		columnProcess.initList();
		actProcess.initList();
		
		
		var sf = document.getElementsByName('_searchformid')[0];//search form下拉联动
		
		sf.onchange = function(){
			FormHelper.getFields4SearchForm(sf.value, function(options) {
				addOptions("sfField", options);
				addOptions("_commonFilterFields", options);
			});
		};

		var str = document.getElementsByName('content.filterCondition')[0].value;
		var datas = parseRelStr(str);
		addRows(datas);
		ev_switchpage(mode);
		
		var commonFilterStr  = document.getElementsByName('content.commonFilterCondition')[0].value;
		var _commonFilterStr = parseRelStr(commonFilterStr);
		addRows4commonFilter(_commonFilterStr);
		
		var authConditionStr = document.getElementById("authorityCondition").value;
		var _datas = parseRelStr(authConditionStr);
		addRows4authority(_datas);
		
		
		// 初始化各种视图基本属性与列的映射
		initRelatedMapping();
		
		//初始化创建菜单 
		var createmenu = document.getElementById('relatedForm');
		if(createmenu.value == ''||createmenu.value == null){
			document.getElementById('createMenuTD').style.display = 'none';
		}
		viewTypeChange('<s:property value="content.viewType"/>');
		// 初始化连接类型  当视图类型为树形视图时才初始化
		if('<s:property value="content.viewType"/>' == 17){
			evChangLinkType('<s:property value="content.innerType"/>');
		}
	}
	
	var relatedMap = {}; // 视图列关系映射
	function initRelatedMapping(){
		var oRelatedMap = document.getElementById("relatedMap");
		
		if (oRelatedMap && oRelatedMap.value) {
			relatedMap = jQuery.parseJSON(oRelatedMap.value);
			// 初始化甘特视图配置
			if (relatedMap['ganttview']){
				var ganttRelatedMap = relatedMap['ganttview'];
				for (key in ganttRelatedMap) {
					// 如：ganttid、ganttname
					jQuery('#gantt' + key).val(ganttRelatedMap[key]);
				}
			}
			
			// 初始化地图视图配置
			if (relatedMap['mapview']){
				
				var isPaginationObj=document.getElementsByName("_isPagination");
				for(var i=0;i<isPaginationObj.length;i++){
					isPaginationObj[i].disabled="disabled";
				}
				document.getElementsByName("content.pagelines")[0].disabled="disabled";
				
				var mapRelatedMap = relatedMap['mapview'];
				for (key in mapRelatedMap) {
					// 如：mapcloumn
					jQuery('#' + key).val(mapRelatedMap[key]);
				}
			}
		}
	}
	
	// 根据mapping str获取data array
	function parseRelStr(str) {
		var obj = eval(str);
		if (obj instanceof Array) {
			return obj;
		} else {
			return new Array();	
		}
	}
	
	// 根据页面内容生成关系语句
	function createRelStr() {
		var fields = document.getElementsByName("field");
		var operators = document.getElementsByName("operator");
		var types = document.getElementsByName("type");
		var ipfields = document.getElementsByName("ipField");
		var sffields = document.getElementsByName("sfField");
		var dafields = document.getElementsByName("daField");
		var syfields = document.getElementsByName("syField");
		var sefields = document.getElementsByName("seField");
		
		var str = '[';
		for (var i=0;i<fields.length;i++) {
			if (fields[i].value != '' && 
				(ipfields[i].value != '' || sffields[i].value != '' 
					|| dafields[i].value != '' || syfields[i].value != ''
					|| sefields[i].value != '')) {
				str += '{';
				str += fields[i].name +':\''+fields[i].value+'\',';
				str += operators[i].name +':\''+operators[i].value+'\',';
				str += types[i].name +':\''+types[i].value+'\',';
				if (types[i].value == '03') {
					str += 'match:\''+ sffields[i].value + '\'';
				} else if(types[i].value == '02') {
					str += 'match:\''+ dafields[i].value + '\'';
				} else if (types[i].value == '04') {
					str += 'match:\''+ syfields[i].value + '\'';
					if (sefields[i].value != '') {
						str += ', sessionfield:\''+sefields[i].value+'\'';
					}
				} else {
					str += 'match:\''+HTMLEncode(ipfields[i].value)+'\'';
				} 

				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += ']';
		return  str;
	}
	
	function createcommonFilterCondition(){
		var cfElems = document.getElementsByName("_commonFilterFields");
		var str = '[';
		for (var i=0;i<cfElems.length;i++) {
			if (cfElems[i].value != '') {
				str += '{';
				str += 'field:\''+cfElems[i].value+'\',';
				str += 'isCommonFilter:\'true\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += ']';
		return  str;
	}

	//保存
	function ev_save() {
		var msg="";
		var type = document.getElementById('viewType').value;
		var openType = document.getElementById('openType').value;
		var searchFormid = jQuery("#save__searchformid").val();
		
		if(openType == 0x0000120 ){//网格视图下不支持查询表单
			if(jQuery.trim(searchFormid) != ""){
				msg = "网格视图下不支持查询表单";
			}
		}
		
		if(type==0x0000012 || type==0x0000013){
			document.getElementById("relatedMap").value= jQuery.json2Str(relatedMap);
			if(type==0x0000012 && openType==0x0000120){
				msg="{*[cn.myapps.core.dynaform.view.map_dissupport_open_in_grid]*}";
			}else if(type==0x0000012 && openType==0x0000115){
				msg="{*[cn.myapps.core.dynaform.view.map_dissupport_open_in_working_div]*}";
			}
		} 	
		if(document.getElementsByName("content.displayType")[0].value=='templateForm' && document.getElementsByName("content.templateForm")[0].value.length<=0){
			msg="{*[cn.myapps.core.dynaform.view.module_form_can_not_empty]*}";
		}
		
		DWREngine.setAsync(false);
		ColumnUtil.parseObject(columnCache, function(xml){
			DWRUtil.setValue('columnXML', xml);
		});
		ActivityUtil.parseObject(activityCache, function(xml){
			DWRUtil.setValue('activityXML', xml);
		});
		
		var type = document.getElementsByName("content.editMode");
		if(type[0].checked){
			var field = document.getElementsByName("field");
			if(field.length>0){
			for ( var i = 0; i < field.length; i++) {
					if(field[i].value==null || field[i].value==''){
						msg="{*[cn.myapps.core.dynaform.view.page.tip.filter_field_request_qequired]*}";
					}
				}
			}
		}
    	var name = document.getElementsByName("content.name");
		if(name[0].value==''){
			msg = "{*[page.name.notexist]*}";
		}
		
		var cfElems = document.getElementsByName("_commonFilterFields");
		
		if(cfElems!= null){
			outerloop:for(var index = 0 ; index < cfElems.length; index ++){
				if(cfElems[index].value == null || cfElems[index].value == "" ){
					msg = "{*[cn.myapps.core.dynaform.view.common_filter_condition_not_empty]*}";
					break outerloop;
				}
				innerloop:for(var pos = 0 ; pos < index ; pos ++){
					if(cfElems[index].value == cfElems[pos].value){
						msg = "{*[cn.myapps.core.dynaform.view.common_filter_condition_not_same]*}";
						break outerloop;
					}
				}
			}
		}

		createAuthCondition();//设置权限过滤条件
    	
		if(msg=='' || msg==null){
			document.getElementsByName('content.filterCondition')[0].value = createRelStr();
			document.getElementsByName('content.commonFilterCondition')[0].value = createcommonFilterCondition();
			var vt=document.getElementById('viewType').value;//地图视图
			var isMap=jQuery("#isMap").val();//表单字段是否为地图控件
			if(vt==18 && isMap!=null && isMap.length>0)
				document.forms[0].action='<s:url action="save"></s:url>'+'?isMap='+isMap;
			else
				document.forms[0].action='<s:url action="save"></s:url>'+'?isMap='+true;
			document.forms[0].submit();
		}else{
			alert(msg);
		}

	}

	/**
	  * 重置日历视图、排序、树形视图、设计等字段
	  **/
	function resetOptions(defVal){
		var viewType = document.getElementById('viewType').value;
		var of = document.getElementsByName('content.relatedForm')[0];
		
		FormHelper.getValueStoreFields(of.value, function(options) {
			
			// 基本字段
			addOptions("field", options);
			/*
			addOptions("orderField", options);
			if (defVal) {
				DWRUtil.setValue("orderField", defVal.orderField);
			}
			*/
		});
	}
	
	//orderby form下拉联动
	function initFormFields() {
		var of = document.getElementsByName('content.relatedForm')[0];
		of.onchange = resetOptions;
		
		// 选项初始值
		//var orderFieldValue = '<s:property value="content.orderField" />';
		//var relationDateColumValue = '<s:property value="content.relationDateColum" />';
		//var treeRelationFieldValue = '<s:property value="content.treeRelationField" />';
		//var nodeNameFieldValue = '<s:property value="content.nodeNameField" />';
		//var nodeValueFieldValue = '<s:property value="content.nodeValueField" />';
		
		var defVal = {
			//orderField: orderFieldValue
			//relationDateColum:relationDateColumValue, 
			//treeRelationField:treeRelationFieldValue, 
			//nodeNameField:nodeNameFieldValue,
			//nodeValueField:nodeValueFieldValue
		};
		
		// 初始化选项
		of.onchange(defVal);
	}

	
// sort by element order number
function sortByOrder(obj, anObj){
	return obj.orderno - anObj.orderno;
}
	
// swap element order number
function swap(obj, anObj) {
	var tempOrderno = obj.orderno;
	obj.orderno = anObj.orderno;
	anObj.orderno = tempOrderno;
}

function ev_switchpage(sId) {
	document.getElementById('span_tab1').className="btcaption";
	document.getElementById('span_tab2').className="btcaption";
	document.getElementById('span_tab3').className="btcaption";
	document.getElementById('span_tab4').className="btcaption";
	document.getElementById('span_tab5').className="btcaption";
	
	document.getElementById('1').style.display="none";
	document.getElementById('2').style.display="none";
	document.getElementById('3').style.display="none";
	document.getElementById('4').style.display="none";
	document.getElementById('5').style.display="none";

	if (jQuery("#"+ sId)) {
		document.getElementById('span_tab'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
		if(sId==3){
			resizeColumnTable();
		}
		window.top.toThisHelpPage(jQuery("#"+sId).attr("helpid"));
	}
	mode = sId;
	resize();
}

//选择链接
function selectLink(){
	var url =  contextPath + '/core/links/selectlink.action?application=<s:property value="#parameters.application"/>';
  	//var rtn = showframe('{*[Please choose a Link]*}', url);
  
  	OBPM.dialog.show({
				opener:window.parent.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.dynaform.view.select_link]*}',
				close: function(link) {
					window.top.toThisHelpPage("application_module_view_info");
					if (link.id == '') {
						document.getElementById("linkId").value='';
	  					document.getElementById("linkName").value='';
					}
					else{
					   document.getElementById("linkId").value = link.id;
					   document.getElementById("linkName").value =link.name;
					   //parseType(link.type);
					}
				}
		});
}
function clearLink(){
	document.getElementById("linkId").value='';
	document.getElementById("linkName").value='';
}

jQuery(document).ready(function(){
	ev_init();
	window.top.toThisHelpPage("application_module_view_info");
	initOptions();
	jQuery("#save_btn").removeAttr("disabled");
});

function selectOrderByFiled(name){
	alert(name);
}

/* 签入
*/
function ev_checkin(){
	DWREngine.setAsync(false);
	ColumnUtil.parseObject(columnCache, function(xml){
		DWRUtil.setValue('columnXML', xml);
	});
	ActivityUtil.parseObject(activityCache, function(xml){
		DWRUtil.setValue('activityXML', xml);
	});
	document.getElementsByName('content.filterCondition')[0].value = createRelStr();
	document.forms[0].action='<s:url action="checkin"></s:url>';
	document.forms[0].submit();
}
/*
* 签出
*/
function ev_checkout(){
	DWREngine.setAsync(false);
	ColumnUtil.parseObject(columnCache, function(xml){
		DWRUtil.setValue('columnXML', xml);
	});
	ActivityUtil.parseObject(activityCache, function(xml){
		DWRUtil.setValue('activityXML', xml);
	});
	document.getElementsByName('content.filterCondition')[0].value = createRelStr();
	document.forms[0].action='<s:url action="checkout"></s:url>';
	document.forms[0].submit();
}
/*
* 权限字段下拉框onchange事件
*/
function onAuthField_change_handle(obj){
	var def = " ";
	var index = obj.id;
	index = index.substring(9);
	ViewHelper.createAuthFieldOptions("_authFieldScope"+index,obj.value,def,function(map){
		DWRUtil.removeAllOptions("_authFieldScope"+index);
		DWRUtil.addOptions("_authFieldScope"+index, map);
	});
}

function on_displayType_change_handle(obj) {
	var _templateForm_label_td = document.getElementById("_templateForm_label_td");
	var _templateForm_td = document.getElementById("_templateForm_td");
	if(obj.value =='relatedForm'){
		_templateForm_label_td.style.display = 'none';
		_templateForm_td.style.display = 'none';
	}else if(obj.value =='templateForm'){
		_templateForm_label_td.style.display = '';
		_templateForm_td.style.display = '';
	}
}

function on_openType_change_handle(obj) {
	var _displayType_td = document.getElementById("_displayType_td");
	var _displayType_label_td = document.getElementById("_displayType_label_td");
	var _content_display = document.getElementById("_content_display");
	var viewType = document.getElementById("viewType");

	if(viewType.value == '1' || viewType.value == '16'){
		if(obj.value =='288'){
			_content_display.options[0].selected="selected";	
			on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);	
			_displayType_label_td.style.display = 'none'; 
			_displayType_td.style.display = 'none';	
		}else{
			_displayType_td.style.display = '';
			_displayType_label_td.style.display = '';
		}
	}else if(viewType.value=='17' || viewType.value=='18' || viewType.value=='19'){
		_content_display.options[0].selected="selected";	
		on_displayType_change_handle(document.getElementsByName("content.displayType")[0]);	
		_displayType_label_td.style.display = 'none'; 
		_displayType_td.style.display = 'none';	
	}
}


/*
* 权限字段 添加行操作
*/
var rowIndex4authority = 0;
var getAuthField = function(data) {
	return '{*[cn.myapps.core.dynaform.view.by]*}<select name="_authFields" id="authField' + rowIndex4authority + 
				'" value="' + data._authFields + '"' + 
				' onchange="onAuthField_change_handle(this)">' +
				'<option value="" selected></option></select>{*[cn.myapps.core.dynaform.view.dofilter]*}';
};
var getAuthFieldScope = function(data) {
	return '{*[cn.myapps.core.dynaform.view.only]*}<select id="_authFieldScope' + rowIndex4authority + '" name="_authFieldScope" value="' + data._authFieldScope + '">' +
			'<option value="' + data._authFieldScope + '"></option></select>{*[cn.myapps.core.dynaform.view.visible]*}';
}
var getDelete4Auth = function(data){
	rowIndex4authority ++;
	return '<input type="button" value="{*[Delete]*}" onclick="delMappRow(this.parentNode.parentNode)" />';
}


function addRows4authority(datas){
	var cellFuncs = [getAuthField, getAuthFieldScope, getDelete4Auth];

	var rowdatas = datas;
	if(!datas){
		var data = {_authFields:'', _authFieldScope:''};
		rowdatas = [data];
	}

	DWRUtil.addRows("authority", rowdatas, cellFuncs);

	var defValues = new Array();
	var _defValues = new Array();
	if(datas){
		for(var i=0;i<datas.length;i++){
			defValues[i] = datas[i]._authFields;
			_defValues[i] = datas[i]._authFieldScope;
		}
	}else {
		var _authFieldss = document.getElementsByName("_authFields");
		var _authFieldScopes = document.getElementsByName("_authFieldScope");
		for(var i=0; i<_authFieldss.length; i++){
			defValues[i] = _authFieldss[i].value;
			_defValues[i] = _authFieldScopes[i].value;
		}
	}

	var formid = document.getElementById("relatedForm").value;
	addFieldOption(formid, defValues, _defValues);
}

function addFieldOption(formid, defValues, _defValues){
	DWREngine.setAsync(false);
	ViewHelper.createFieldOptions(formid, function(map){
		var _authFieldss = document.getElementsByName("_authFields");
		var _authFieldScopes = document.getElementsByName("_authFieldScope");
		for(var i=0; i<_authFieldss.length; i++){
			DWRUtil.removeAllOptions(_authFieldss[i].id);
			DWRUtil.addOptions(_authFieldss[i].id, map);
			if(defValues || _defValues){
				DWRUtil.setValue(_authFieldss[i].id,defValues[i]);
				_authFieldss[i].onchange();
				DWRUtil.setValue(_authFieldScopes[i].id,_defValues[i]);
			}
		}
	});
	DWREngine.setAsync(true);
}

function delMappRow(row){
	document.getElementById("authority").deleteRow(row.rowIndex);
}

function createAuthCondition(){
	var authfieldValue = document.getElementsByName("_authFields");
	var authFieldScopeValue = document.getElementsByName("_authFieldScope");

	var conditionStr = '';
	if(authfieldValue.length>0 && authFieldScopeValue.length>0){
		conditionStr += '[';
		for(var i=0; i<authfieldValue.length; i++){
			conditionStr += '{_authFields:\'' + authfieldValue[i].value + '\',_authFieldScope:\'' + authFieldScopeValue[i].value + '\'},';
		}
		conditionStr = conditionStr.substring(0, conditionStr.length-1);
		conditionStr += ']';
	}
	document.getElementById("authorityCondition").value = conditionStr;
}


/*
* 常用查询字段 添加行操作
*/
var rowIndex4commonFilter = 0;
var getcommonFilterField = function(data) {
	return '<select name="_commonFilterFields" id="commonFilterField' + rowIndex4commonFilter + 
				'" value="' + data._commonFilterFields + '">' + 
				'<option value="" selected></option></select>';
};
var getDelete4commonFilter = function(data){
	rowIndex4commonFilter ++;
	return '<input type="button" value="{*[Delete]*}" onclick="delCommonFilterRow(this.parentNode.parentNode)" />';
}

function delCommonFilterRow(row){
	document.getElementById("commonFilter").deleteRow(row.rowIndex);
}

function addRows4commonFilter(datas){
	//数量控制 
	var cfElems = document.getElementsByName('_commonFilterFields'); 
	if(cfElems != null && cfElems.length >= 2 ){
		alert("{*[cn.myapps.core.dynaform.view.common_filter_condition_nums]*}");
		return ;
	} 
	
	var cellFuncs = [getcommonFilterField, getDelete4commonFilter];

	var rowdatas = datas;
	if(!datas){
		var data = {field:'', isCommonField:''};
		rowdatas = [data];
	}

	DWRUtil.addRows("commonFilter", rowdatas, cellFuncs);
	
	 var sf = document.getElementsByName('_searchformid')[0]; //search form下拉联动
	 sf.onchange(); 

	var defValues = new Array();
	var _commonFilterFields = document.getElementsByName("_commonFilterFields");
	if(datas){
		for(var i=0;i<datas.length;i++){
			defValues[i] = datas[i].field;
		}
	}else {
		for(var i=0; i<_commonFilterFields.length; i++){
			defValues[i] = _commonFilterFields[i].value;
		}
	}
	
	//设置回显值
	for(var i=0; i<_commonFilterFields.length; i++){
		_commonFilterFields[i].value = defValues[i];
		var opts = _commonFilterFields[i].options;
		if(opts.length == 1 ){
			opts[0].value = defValues[i];
			opts[0].selected = true;
		}else{
			for(var pos = 0 ; pos < opts.length ; pos ++){
				if(opts[pos] == defValues[i]){
					opts[pos].selected = true;
					break ;
				}
			}
		}
	}
}

</script>

	<body id="application_module_view_info" class="contentBody" style="height:100%;">
		<table width="100%" height="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="27px;" valign="top" align="left">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td class="nav-s-td">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="padding-left: 10px;">
											<div id="sec_tab1">
												<div class="listContent">
													<input type="button" id="span_tab1" name="spantab1"
														class="btcaption" onClick="ev_switchpage('1')"
														value="{*[Basic]*}" />
												</div>
												<div class="listContent nav-seperate">
													<img
														src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
												</div>
												<div class="listContent">
													<input type="button" id="span_tab2" name="spantab2"
														class="btcaption" onclick="ev_switchpage('2')"
														value="{*[cn.myapps.core.dynaform.view.dofilter]*}" />
												</div>
												<div class="listContent nav-seperate">
													<img
														src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
												</div>
												<div class="listContent">
													<input type="button" id="span_tab3" name="spantab3"
														class="btcaption" onClick="ev_switchpage('3')"
														value="{*[Column]*}" />
												</div>
												<div class="listContent nav-seperate">
													<img
														src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
												</div>
												<div class="listContent">
													<input type="button" id="span_tab4" name="spantab4"
														class="btcaption" onClick="ev_switchpage('4')"
														value="{*[Activity]*}" />
												</div>
												<div id="span_tab5_img" class="listContent nav-seperate" style='display: none;'>
													<img
														src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
												</div>
												<div id="span_tab5_input" class="listContent" style='display: none;'>
													<input type="button" id="span_tab5" name="spantab5"
														class="btcaption" onClick="ev_switchpage('5')"
														value="默认加载城市" />
												</div>
												<div style='display: none;'></div>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td class="nav-s-td" align="right">
								<table border=0 cellpadding="0" cellspacing="0">
									<tr>
										<s:if test="checkoutConfig == 'true'">
											<s:if
												test="content.id !=null && content.id !='' && !content.checkout">
												<!-- 签出按钮 -->
												<td align="left">
													<button type="button" class="button-image"
														style="width: 50px" onClick="ev_checkout()">
														<img
															src="<s:url value="/resource/imgnew/act/checkout.png" />"
															align="top">{*[core.dynaform.form.checkout]*}
													</button>
												</td>
											</s:if>
											<s:elseif
												test="content.id !=null && content.id !='' && content.checkout && #session['USER'].id == content.checkoutHandler">
												<!-- 签入按钮 -->
												<td align="left">
													<button type="button" class="button-image"
														style="width: 50px" onClick="ev_checkin()">
														<img
															src="<s:url value="/resource/imgnew/act/checkin.png" />"
															align="top">{*[core.dynaform.form.checkin]*}
													</button>
												</td>
											</s:elseif>
										</s:if>
										<td valign="top" id="createMenuTD">
											<button type="button" class="button-image"
												onClick="ev_createMenu()">
												<img src='<s:url value="/resource/imgnew/act/act_2.gif" />' />{*[cn.myapps.core.dynaform.view.create_menu]*}
											</button>
										</td>
										<td valign="top">
											<button type="button" class="button-image"
												onClick="ev_preview()">
												<img
													src='<s:url value="/resource/imgnew/act/preview.gif" />'>{*[Preview]*}
											</button>
										</td>
										<s:if test="checkoutConfig == 'true'">
											<s:if
												test="(content.checkout && #session['USER'].id == content.checkoutHandler)">
												<!-- 签出 -->
												<td align="left">
													<button type="button" id="save_btn" disabled="disabled" style="width: 50px"
														class="button-image" onClick="ev_save()">
														<img
															src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
															align="top">{*[Save]*}
													</button>
												</td>
											</s:if>
											<s:elseif
												test="content.checkout && #session['USER'].id != content.checkoutHandler">
												<!-- 签入-->
												<td align="left">
													<button type="button" id="save_btn" disabled="disabled" style="width: 50px"
														class="button-image" disabled="disabled"
														onClick="ev_save()">
														<img
															src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
															align="top">{*[Save]*}
													</button>
												</td>
											</s:elseif>
											<s:if
												test="!content.checkout && (content.checkoutHandler ==null || content.checkoutHandler == '')">
												<!-- 没有签出-->
												<td align="left">
													<button type="button" id="save_btn" disabled="disabled" style="width: 50px"
														class="button-image"
														onClick="alert('{*[message.update.before.checkout]*}')">
														<img
															src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
															align="top">{*[Save]*}
													</button>
												</td>
											</s:if>
										</s:if>
										<s:else>
											<td align="left">
												<button type="button" id="save_btn" disabled="disabled" style="width: 50px"
													class="button-image" onClick="ev_save()">
													<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
														align="top">{*[Save]*}
												</button>
											</td>
										</s:else>
										<td valign="top">
											<button type="button" class="button-image"
												onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();">
												<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
											</button>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top" align="left"
					style="padding: 2px; padding-top: 8px;"><s:property
						value="#session.parentcontent" /> <%@include
						file="/common/msg.jsp"%> 
						<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
					<div id="viewContent" style="height:100%;overflow-y:auto;">
						<s:form
						name="viewform" action="save" theme="simple" method="post">
						<s:textarea id="columnXML" name="content.columnXML"
							cssStyle="display:none" />
						<s:textarea id="activityXML" name="content.activityXML"
							cssStyle="display:none" />
						<%@include file="/common/page.jsp"%>
						<s:hidden name="sm_name" value="%{#parameters.sm_name}" />
						<s:hidden name='content.checkout' />
						<s:hidden name="content.checkoutHandler" />
						<s:bean
							name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
							id="sh">
							<s:param name="moduleid" value="#parameters.s_module" />
						</s:bean>
						<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper"
							id="vh">
							<s:param name="moduleid" value="#parameters.s_module" />
						</s:bean>
						<input type="hidden" name="s_module"
							value="<s:property value='#parameters.s_module'/>" />
						<input type="hidden" name="_moduleid"
							value="<s:property value='#parameters.s_module'/>" />
						<input type="hidden" name="editModeValue" id="editModeValue" />
						<s:hidden name="_resourceid" />
						<s:textarea name="content.relatedMap" id="relatedMap"
							cssStyle="display:none" />
						<table width="100%">
							<tr id="1" helpid="application_module_view_info">
								<td>
									<table border=0 cellpadding="0" cellspacing="0" width="100%"
										class="id1">
										<tr>
											<td class="commFont">{*[Name]*}:</td>
											<td class="commFont">{*[Description]*}:</td>
										</tr>
										<tr>
											<td><s:textfield cssClass="input-cmd" theme="simple"
													name="content.name" onblur="checkName(this.value)" /></td>
											<td><s:textfield cssClass="input-cmd" theme="simple"
													name="_resourcedesc" onblur="checkResourceDesc(this.value)" /></td>
										</tr>
										<tr class="seperate">
											<td class="commFont">{*[cn.myapps.core.dynaform.view.type]*}:</td>
											<td class="commFont">{*[StyleLib]*}:</td>
										</tr>
										<tr>
											<td><s:select id='viewType' name="content.viewType"
													cssClass="input-cmd" list="_VIEWTYPE" theme="simple"
													onchange="viewTypeChange(this.value)" /></td>
											<td><s:select cssClass="input-cmd" theme="simple"
													name="_styleid"
													list="#sh.get_listStyleByApp(#parameters.application)"
													listKey="id" listValue="name" emptyOption="true" /></td>
										</tr>
										<tr class="seperate">
											<td class="commFont">{*[cn.myapps.core.dynaform.view.open_type]*}:</td>
											<td>{*[cn.myapps.core.dynaform.view.page.label.permission_type]*}</td>
										</tr>
										<tr>
											<td><s:select id="openType" cssClass="input-cmd"
													name="content.openType" theme="simple" list="_OPENTYPE" onchange="on_openType_change_handle(this);"/>
											</td>
											<td><div ><s:radio
							name="content.permissionType" theme="simple"
							list="#{'public':'{*[cn.myapps.core.dynaform.view.attr.permission_type.public]*}','private':'{*[cn.myapps.core.dynaform.view.attr.permission_type.private]*}'}"  /></div></td>
										</tr>
										<tr class="seperate">
											<td class="commFont" id="_displayType_label_td">{*[core.dynaform.view.basic.displayType]*}:</td>
											<td class="commFont" id="_templateForm_label_td"
												style="display: none">{*[core.dynaform.form.type.templateform]*}</td>
										</tr>
										<tr>
											<td id="_displayType_td"><s:select id="_content_display" cssClass="input-cmd"
													theme="simple" name="content.displayType"
													list="#{'relatedForm':'{*[core.dynaform.view.basic.displayType.relatedForm]*}','templateForm':'{*[core.dynaform.view.basic.displayType.templateForm]*}'}"
													onchange="on_displayType_change_handle(this);" /></td>
											<td id="_templateForm_td" style="display: none"><s:select
													name="content.templateForm"
													list="#fh.getTemplateFormList(#parameters.application)"
													listKey="id" id="templateForm" listValue="name"
													emptyOption="true" theme="simple" cssClass="input-cmd" />
											</td>
										</tr>
										<tr class="seperate">
											<td class="commFont">{*[cn.myapps.core.dynaform.view.show_total_rows]*}:</td>
											<td class="commFont">{*[Refresh]*}:</td>
										</tr>
										<tr>
											<td><s:radio name="_isShowTotalRow" theme="simple"
													list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"></s:radio></td>
											<td><s:radio name="_isRefresh" theme="simple"
													list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"></s:radio></td>
										</tr>
										<tr class="seperate">
											<td class="commFont">{*[Pagination]*}:</td>
											<td class="commFont">{*[cn.myapps.core.dynaform.view.Readonly]*}:</td>
										</tr>
										<tr>
											<td><s:radio name="_isPagination"
													onclick="ev_isPagination(this)" theme="simple"
													list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"></s:radio>
												<span id="pl_tr"><s:select label="{*[PageLines]*}"
														name="content.pagelines"
														list="#{'05':'5','10':'10','15':'15','30':'30'}"
														theme="simple" />{*[page.view.pageline]*}</span></td>
											<td><s:radio name="_readOnly" theme="simple"
													list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"></s:radio>
											</td>
										</tr>
										<tr>
											<td id="showWaterMark" class="commFont">{*[是否显示水印]*}:<span style="color:green;">*只支持H5和DWZ皮肤</span>
											</td>
											<td class="commFont"></td>
										</tr>
										<tr>
											<td id="showWaterMark"><s:radio name="content.showWaterMark" theme="simple"
													list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"></s:radio>
											</td>
											<td colspan="2" id="tips" class="tipsStyle">
											</td>
										</tr>
										<tr>
											<td id="waterMarkScript" class="commFont">{*[水印脚本]*}:
											<button type="button" class="button-image" onclick="openIscriptEditor('content.waterMarkScript','{*[Script]*}{*[Editor]*}','{*[水印脚本]*}','content.name','{*[Save]*}{*[Success]*}');">
											<img alt="{*[水印脚本]*}" src="<s:url value='/resource/image/editor.png' />"/>
											</button>
											</td>
											<td class="commFont"></td>
										</tr>
										<tr id='scriptContent'>
											<td id="waterMarkScript"><s:textarea theme="simple" cssClass="input-cmd"
												name="content.waterMarkScript" rows="4"></s:textarea>
											</td>	
											<td>
											</td>
										</tr>
										<tr>
											<td colspan="2" id="tips" class="tipsStyle">
											</td>
										</tr>

										<!---------------------- 树形视图定制项 ------------------------------->
										<tr class="seperate treeview">
											<td class="commFont">{*[cn.myapps.core.dynaform.view.InnerType]*}:</td>
											<td class="commFont" id="link.td.title">{*[cn.myapps.core.dynaform.view.node_link]*}:</td>
										</tr>
										<tr class="treeview">
											<td><s:select id="innerType" cssClass="input-cmd"
													onchange="evChangLinkType(this.value)"
													name="content.innerType"
													list="#{'FORM':'{*[Form]*}','VIEW':'{*[View]*}', 'LINK':'{*[Link]*}'}"
													theme="simple" /></td>
											<td id="link.td.content"><s:hidden id="linkId"
													name="content.nodeLinkId" /> <s:textfield id="linkName"
													name="linkName" cssStyle="width:200px;" readonly="true" />
												<button type="button" class="button-image"
													style="color: #1E50C4" onclick="selectLink()">{*[Choose]*}</button>
												<button type="button" class="button-image"
													style="color: #1E50C4" onclick="clearLink()">{*[Clear]*}</button>
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<tr id="2" helpid="application_module_view_info_content"
								style="display: none">
								<td><s:radio name="content.editMode"
										list="#{'00':'{*[Design]*}','01':'{*[Code]*}(DQL)','02':'{*[Code]*}(SQL)','03':'{*[cn.myapps.core.dynaform.view.code_procedure]*}'}"
										onclick="modeChange(this.value)" theme="simple" />
									<table width="100%">
										<tr id="content4">
											<td>
												<fieldset>
													<legend>{*[core.dynaform.form.action.FormHelper.relatedFrom]*}:</legend>
													<s:select name="content.relatedForm"
														list="#fh.getNormalFormList(#parameters.application)"
														listKey="id" id="relatedForm" listValue="name"
														theme="simple" cssClass="input-cmd" />
												</fieldset>
											</td>
										</tr>
										<tr>
											<td>
												<fieldset>
													<legend>{*[cn.myapps.core.dynaform.view.search_template]*}:</legend>
													<table style="width: 100%;">
														<tr>
															<td><s:select cssStyle="width:250px;"
																	label="{*[cn.myapps.core.dynaform.view.search_template]*}" name="_searchformid"
																	cssClass="input-cmd"
																	list="#vh.get_searchForm(#parameters.application)"
																	listKey="id" listValue="name" theme="simple"
																	emptyOption="true" /></td>
														</tr>
													</table>
												</fieldset>
											</td>
										</tr>
										<tr>
											<td>
												<fieldset>
													<legend>{*[cn.myapps.core.dynaform.view.common_filter_fields]*}:</legend>
													<table width="40%">
														<tbody id="commonFilter">
															<tr><td colspan="3" class="commFont"><span class="tipsStyle">{*[cn.myapps.core.dynaform.view.common_filter_fields.tip]*}</span></td></tr>
															<tr>
																<td style="width: 25px;text-align: left;"><input
																	type="button" value="{*[Add]*}" onclick="addRows4commonFilter()" /></td>
															</tr>
															<tr>
																<td style="text-align: left;">{*[cn.myapps.core.dynaform.view.common_filter_fields]*}</td>
															</tr>
																</tbody>
													</table>
													<s:textarea name="content.commonFilterCondition" id="commonFilterCondition" cssStyle="display:none" />
												</fieldset>
											</td>
										</tr> 
										<tr id="content0">
											<td colspan="2">
												<table width="100%" id="content0_table" border="0"
													cellpadding="0" cellspacing="0">
													<!--<tr>
														<td class="commFont">
															<fieldset>
																<legend>{*[Authority]*}</legend>
																<table width="40%">
																	<tr>
																		<td><s:checkbox theme="simple"
																				name="content.auth_user" fieldValue="auth_user" />{*[Author]*}&nbsp;</td>
																		<td></td>
																	</tr>
																	<tr>
																		<td>{*[core.dynaform.view.authfield]*}</td>
																		<td>{*[Scope]*}</td>
																	</tr>
																	<tr>
																		<td><s:select emptyOption="true"
																				name="content.auth_fields"
																				list="#{'author':'{*[Author]*}','authorDefaultDept':'{*[作者默认部门]*}','auditor':'{*[Auditor]*}'}"
																				onchange="onAuthField_change_handle(this)"></s:select></td>
																		<td><s:select name="content.authFieldScope"
																				list="#{}"></s:select></td>
																	</tr>
																</table>
															</fieldset>
														</td>
													</tr>
													--><tr>
														<td class="commFont">
															<fieldset>
																<legend>{*[cn.myapps.core.dynaform.view.filter_system]*}</legend>
																<table width="40%">
																<tbody id="authority">
																	<tr><td colspan="3" class="commFont"><span class="tipsStyle">{*[core.dynaform.view.filter.authority_condition.tip]*}</span></td></tr>
																	<tr>
																		<td style="width: 25px;text-align: left;"><input
																			type="button" value="{*[Add]*}" onclick="addRows4authority()" /></td>
																	</tr>
																	<tr>
																		<td style="text-align: left;">{*[cn.myapps.core.dynaform.view.filter_fields]*}</td>
																		<td>{*[cn.myapps.core.dynaform.view.scope]*}</td>
																	</tr>
																</tbody>
																</table>
																<s:textarea name="content.authorityCondition" id="authorityCondition"
																	cssStyle="display:none" />
															</fieldset>
														</td>
													</tr>
													<tr>
														<td valign="top">
															<fieldset>
																<legend>{*[cn.myapps.core.dynaform.view.form_dofilter_confition]*}</legend>
																<div id="content0_cols">
																	<table>
																		<tbody id="tb">
																			<tr><td colspan="3" class="commFont"><span class="tipsStyle">{*[core.dynaform.view.filter.field.description]*}</span></td></tr>
																			<tr>
																				<td width="25px;" align="right"><input
																					type="button" value="{*[Add]*}" onclick="addRows()" /></td>
																			</tr>
																			<tr align="center">
																				<td class="commFont">{*[Field]*}</td>
																				<td class="commFont" style="width: 70px;">{*[Operator]*}</td>
																				<td class="commFont">{*[cn.myapps.core.dynaform.view.match_with]*}</td>
																				<td>&nbsp;</td>
																			</tr>
																		</tbody>
																	</table>
																</div>
																<s:textarea name="content.filterCondition"
																	cssStyle="display:none" />
															</fieldset>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<!-- dql脚本 -->
										<tr id="content1">
											<td colspan="4"><s:textarea cssClass="input-cmd"
													label="{*[cn.myapps.core.dynaform.view.filter_script]*}" name="content.filterScript"
													cssStyle="width:100%;height:350px;" cols="115" rows="5"
													theme="simple" />
												<button type="button" class="button-image"
													onclick="openIscriptEditor('content.filterScript','{*[cn.myapps.core.dynaform.view.script_editor]*}','{*[Code]*}(DQL)','content.name','{*[Save]*}{*[Success]*}');">
													<img alt="{*[page.Open_with_IscriptEditor]*}"
														src="<s:url value='/resource/image/editor.png' />" />
												</button></td>
										</tr>
										<!-- sql脚本 -->
										<tr id="content2">
											<td colspan="4"><s:textarea cssClass="input-cmd"
													label="{*[cn.myapps.core.dynaform.view.filter_script]*}" name="content.sqlFilterScript"
													cssStyle="width:100%;height:350px;" cols="115" rows="5"
													theme="simple" />
												<button type="button" class="button-image"
													onclick="openIscriptEditor('content.sqlFilterScript','{*[cn.myapps.core.dynaform.view.script_editor]*}','{*[Code]*}(SQL)','content.name','{*[Save]*}{*[Success]*}');">
													<img alt="{*[page.Open_with_IscriptEditor]*}"
														src="<s:url value='/resource/image/editor.png' />" />
												</button></td>
										</tr>
										<!-- 存储过程脚本 -->
										<tr id="content3">
											<td colspan="4"><s:textarea cssClass="input-cmd"
													label="{*[cn.myapps.core.dynaform.view.filter_script]*}"
													name="content.procedureFilterScript"
													cssStyle="width:100%;height:350px;" cols="115" rows="5"
													theme="simple" />
												<button type="button" class="button-image"
													onclick="openIscriptEditor('content.procedureFilterScript','{*[cn.myapps.core.dynaform.view.script_editor]*}','{*[Code]*}({*[Procedure]*})','content.name','{*[Save]*}{*[Success]*}');">
													<img alt="{*[page.Open_with_IscriptEditor]*}"
														src="<s:url value='/resource/image/editor.png' />" />
												</button></td>
										</tr>
									</table></td>
							</tr>
							<s:if test="content.id!=null && content.id!=''">
								<script type="text/javascript">
				function resizeColumnTable(){
					var viewAreaH =jQuery("body").height()-127;
					var thisTabH=jQuery("#tab3_table").height();
					if(thisTabH>viewAreaH){
						jQuery("#col_list").height(viewAreaH);
					}
				}
				function ColumnProcess() {
					this.bodyid = "columnbody";
					this.selectsFieldName = "columnSelects";
				}
				ColumnProcess.prototype.initList = function() {
					var columnXML = DWRUtil.getValue("columnXML");
					if (columnXML) {
						var process = this;
						// 回调函数中的this为XmlHttpRequest
						ColumnUtil.parseXML(columnXML, function(columns){
							columnCache = columns;
							process.refreshList(columns);
						});
					}
				}
				
				ColumnProcess.prototype.refreshList = function(columns) {
					DWREngine.setAsync(false);
					jQuery("#save_btn").attr("disabled",true);
					columns.sort(sortByOrder);
					var columns_bak = columns;
					ColumnUtil.toListHtml(columns_bak, function(html){
						var oDiv = jQuery("#col_list");
						oDiv.html(html);
						resizeColumnTable();
					});
					jQuery("#save_btn").removeAttr("disabled");
				}
				ColumnProcess.prototype.doCreate = function() {
			    	//var url= '<s:url value="/core/dynaform/column/content.jsp"><s:param name="application" value="#parameters.application"/><s:param name="viewid" value="content.id"/><s:param name="moduleid" value="#parameters.s_module"/></s:url>';
			
					var moduleid='<%=request.getParameter("s_module")%>';
					var applicationid='<%=request.getParameter("application")%>';
					var viewid='<s:property value='content.id'/>';
					var targetFormId = document.getElementById("relatedForm").value;
					var url= '<s:url value="/core/dynaform/column/content.jsp" />?application='+applicationid+'&viewid='+viewid+'&moduleid='+moduleid+'&targetFormId='+targetFormId;
					var process = this;
					OBPM.dialog.show({
							opener:window.parent.parent,
							width: 600,
							height: 550,
							url: url,
							args: {"parentObj":window,"application":applicationid,"viewid":viewid,"moduleid":moduleid},
							title: '{*[cn.myapps.core.dynaform.view.new_col]*}',
							maximized: false, // 是否支持最大化
							close: function(result) {
								jQuery("#isMap").val(result);//返回表单字段是否为地图控件标识
								window.top.toThisHelpPage("application_module_view_info_column");
								process.refreshList(columnCache);
							}
					});
				}
				ColumnProcess.prototype.doMutilCreate = function(){
			       	//var url= '<s:url value="/core/dynaform/column/guidecontent.jsp"><s:param name="application" value="#parameters.application"/><s:param name="viewid" value="content.id"/><s:param name="moduleid" value="#parameters.s_module"/></s:url>';
				   	var moduleid='<%=request.getParameter("s_module")%>';
					var applicationid='<%=request.getParameter("application")%>';
					var viewid='<s:property value='content.id'/>';
					var targetFormId = document.getElementById("relatedForm").value;
					var url= '<s:url value="/core/dynaform/column/guidecontent.jsp" />?application='+applicationid+'&viewid='+viewid+'&moduleid='+moduleid+'&targetFormId='+targetFormId;
					var process = this;
					OBPM.dialog.show({
							opener:window.parent.parent,
							width: 600,
							height: 500,
							url: url,
							args: {"parentObj":window,"application":applicationid,"viewid":viewid,"moduleid":moduleid},
							title: '{*[cn.myapps.core.dynaform.view.edit_col_info]*}',
							maximized: false, // 是否支持最大化
							close: function(result) {
								window.top.toThisHelpPage("application_module_view_info_column");
								process.refreshList(columnCache);
							}
						});
				}
				ColumnProcess.prototype.doEdit = function(index){
				    //var url= '<s:url value="/core/dynaform/column/content.jsp"><s:param name="application" value="#parameters.application"/><s:param name="viewid" value="content.id"/><s:param name="moduleid" value="#parameters.moduleid"/></s:url>';
				   	var moduleid='<%=request.getParameter("s_module")%>';
					var applicationid='<%=request.getParameter("application")%>';
					var viewid='<s:property value='content.id'/>';
					var targetFormId = document.getElementById("relatedForm").value;
					var url= '<s:url value="/core/dynaform/column/content.jsp" />?application='+applicationid+'&viewid='+viewid+'&moduleid='+moduleid+'&index=' + index+'&targetFormId='+targetFormId;
					var process = this;
					OBPM.dialog.show({
							opener:window.parent.parent,
							width: 600,
							height: 550,
							url: url,
							args: {"parentObj":window,"application":applicationid,"viewid":viewid,"moduleid":moduleid},
							title: '{*[cn.myapps.core.dynaform.view.edit_col_info]*}',
							maximized: false, // 是否支持最大化
							close: function(result) {
								jQuery("#isMap").val(result);//返回表单字段是否为地图控件标识
								window.top.toThisHelpPage("application_module_view_info_column");		
								process.refreshList(columnCache);
							}
						});
				}
				ColumnProcess.prototype.doDelete = function(){
					var tempArray = [];
					var columnSelects = document.getElementsByName(this.selectsFieldName);
					var process = this;
					for (var n=0; n<columnSelects.length; n++) {
						if (columnSelects[n].checked) {
							var index = columnSelects[n].value;
							columnCache[index] = null;
						}
					}
					columnCache = jQuery.grep(columnCache,function(val,key){
						return val==null || val== undefined;
					},true);
					process.refreshList(columnCache);
				}				
				ColumnProcess.prototype.doOrderChange = function(index, type) {
					var process = this;
					if (type == "p") {
						if (index != 0) {
							var column = columnCache[index];
							var previousColumn = columnCache[index-1];
							swap(column, previousColumn);
							process.refreshList(columnCache);
						}
					} else if (type == "n"){
						if (index != columnCache.length - 1) {
							var column = columnCache[index];
							var nextColumn = columnCache[index+1];
							swap(column, nextColumn);
							process.refreshList(columnCache);
						}
					}
				}
				var columnCache = [];
				var columnProcess = new ColumnProcess();
			</script>
			<input type="hidden" id="isMap"/>
								<tr id="3" helpid="application_module_view_info_column"
									style="display: none">
									<td>
										<table id="tab3_table" width="100%" class="table_noboder">
											<tr style="vertical-align: top;">
												<td>
													<button type="button" class="button-class"
														onClick="columnProcess.doCreate()">
														<img border=0
															SRC="<s:url  value='/resource/imgnew/act/act_2.gif'></s:url>"
															alt="{*[cn.myapps.core.dynaform.view.create_col]*}">{*[Create]*}
													</button>
													<button type="button" class="button-class"
														onClick="columnProcess.doMutilCreate()">
														<img border=0
															SRC="<s:url  value='/resource/imgnew/act/act_2.gif'></s:url>"
															alt="{*[cn.myapps.core.dynaform.view.create_col_guide]*}">{*[cn.myapps.core.dynaform.view.batch_create]*}
													</button>
													<button type="button" class="button-class"
														onClick="columnProcess.doDelete()">
														<img border=0
															SRC="<s:url value='/resource/imgnew/act/act_3.gif'></s:url>"
															alt="{*[cn.myapps.core.dynaform.view.remove_col]*}">{*[Remove]*}
													</button>
												</td>
											</tr>
											<tr>
												<td style="width: 100%; vertical-align: top;">
													<div id="col_list" style="overflow:auto;height:100%;"></div>
												</td>
											</tr>
											<!-- 
						<tr>
							<td>{*[OrderBy]*}{*[Field]*}:
								<s:select id="orderField" cssStyle="width:222px;"
									name="content.orderField" list="{}" theme="simple" /> <s:select
									name="content.orderType"
									list="#{'ASC':'{*[ASC]*}','DESC':'{*[DESC]*}'}" theme="simple" />
							</td>
						</tr>
						-->
										</table>
									</td>
								</tr>
								<!--  Activity Script -->
								<tr id="4" helpid="application_module_view_info_activity"
									style="display: none">
									<td><script type="text/javascript">
						function ActivityProcess() {
						}
						ActivityProcess.prototype.initList = function(){
							var activityXML = DWRUtil.getValue("activityXML");
							if (activityXML) {
								var process = this;
								ActivityUtil.parseXML(activityXML, function(activitys){
									activityCache = activitys;
									process.refreshList(activityCache);
								});
							}
						}
						ActivityProcess.prototype.refreshList = function(activitys) {
							DWREngine.setAsync(false);
							jQuery("#save_btn").attr("disabled",true);
							activitys.sort(sortByOrder);
							ActivityUtil.toListHtml(activitys, function(data){
								var act_list = jQuery("#act_list");
								act_list.html(data);
							});
							jQuery("#save_btn").removeAttr("disabled");
						}
						ActivityProcess.prototype.doCreate = function(){
						  	var s_moduleid='<%=request.getParameter("s_module")%>';
							var applicationid='<%=request.getParameter("application")%>';
							var _viewid='<s:property value='content.id'/>';
							var url= '<s:url value="/core/dynaform/activity/content.jsp" />?application='+applicationid+'&_viewid='+_viewid+'&s_module='+s_moduleid;
							OBPM.dialog.show({
									opener:window.parent.parent,
									width: 600,
									height: 500,
									url: url,
									args: {"parentObj":window,"application":applicationid,"_viewid":_viewid,"s_module":s_moduleid},
									title: '{*[cn.myapps.core.dynaform.view.new_activity_button]*}',
									maximized: false, // 是否支持最大化
									close: function(result) {
										window.top.toThisHelpPage("application_module_view_info_activity");
									}
								});
							
						  	this.refreshList(activityCache);
						  	
						}
						ActivityProcess.prototype.doEdit = function(index) {
							var s_moduleid='<%=request.getParameter("s_module")%>';
							var applicationid='<%=request.getParameter("application")%>';
							var _viewid = '<s:property value='content.id'/>';
							var url = '<s:url value="/core/dynaform/activity/content.jsp" />?application='
													+ applicationid
													+ '&_viewid='
													+ _viewid
													+ '&s_module='
													+ s_moduleid
													+ '&index=' + index;
											OBPM.dialog
													.show({
														opener : window.parent.parent,
														width : 600,
														height : 500,
														url : url,
														args : {
															"parentObj" : window,
															"application" : applicationid,
															"_viewid" : _viewid,
															"s_module" : s_moduleid
														},
														maximized: false, // 是否支持最大化
														title : '{*[cn.myapps.core.dynaform.view.edit_activity_button]*}',
														close : function(result) {
															window.top
																	.toThisHelpPage("application_module_view_info_activity");
														}
													});

											this.refreshList(activityCache);
										}
										ActivityProcess.prototype.doDelete = function() {
											var activitySelects = document
													.getElementsByName("activitySelects");
											for ( var n = 0; n < activitySelects.length; n++) {
												if (activitySelects[n].checked) {
													var index = activitySelects[n].value;
													activityCache[index] = null;
												}
											}
											activityCache = jQuery.grep(activityCache,function(val,key){
												return val==null || val== undefined;
											},true);
											this.refreshList(activityCache);
										}

										ActivityProcess.prototype.doOrderChange = function(
												index, type) {
											switch (type) {
											case 'p':
												if (index != 0) {
													var activity = activityCache[index];
													var previousActivity = activityCache[index - 1];
													swap(activity,
															previousActivity);
													this
															.refreshList(activityCache);
												}
												break;
											case 'n':
												if (index != activityCache.length - 1) {
													var activity = activityCache[index];
													var nextActivity = activityCache[index + 1];
													swap(activity, nextActivity);
													this
															.refreshList(activityCache);
												}
												break;
											}
										}
										var activityCache = [];
										var actProcess = new ActivityProcess();
									</script>
										<table width="100%" class="table_noboder">
											<tr>
												<td>
													<button type="button" class="button-class"
														onClick="actProcess.doCreate()" title="{*[Create]*}">
														<img border=0
															SRC="<s:url value='/resource/imgnew/act/act_2.gif'></s:url>"
															alt="{*[cn.myapps.core.dynaform.view.create_activity]*}">{*[Create]*}
													</button>
													<button type="button" class="button-class"
														onClick="actProcess.doDelete()" title="{*[Delete]*}">
														<img border=0
															SRC="<s:url value='/resource/imgnew/act/act_3.gif'></s:url>"
															alt="{*[cn.myapps.core.dynaform.view.remove_activity]*}">{*[Delete]*}
													</button>
												</td>
											</tr>
											<tr>
												<td
													style="width: 100%; vertical-align: top; text-align: left;">
													<div id="act_list">&nbsp;</div>
												</td>
											</tr>
										</table></td>
								</tr>
								<!--  默认加载地图城市 -->
								<tr id="5" helpid="application_module_view_info_activity"
									style="display: none">
									<td><script type="text/javascript">
									
									function countryEvent(){
										jQuery.ajax({
											url : "country.xml",
											success : function(xml) {
												jQuery(xml).find("country").each(
																function() {
																	var t = jQuery(this).attr("label");
																	jQuery("#country").append("<option value='"+t+"'>" + t + "</option>");
																	
																});
												var country = '<s:property value="content.country"/>';
												jQuery("#country").val(country);
												provinceEvent();
											}
										});
									}
									
									function provinceEvent(){
										jQuery("#province>option").remove();
										var pname = jQuery("#country").val();
										jQuery.ajax({url : "country.xml",
												success : function(xml) {
												jQuery(xml).find("country[label='"+ pname+ "']>province").each(
														function() {
																var t = jQuery(this).attr("label");
																jQuery("#province").append("<option value='"+t+"'>"+ t+ "</option>");
																	});
															var province = '<s:property value="content.province"/>';
															jQuery("#province").val(province);
															cityEvent();
															}
												});
									}
									
									function cityEvent(){
										jQuery("#city>option").remove();
										var pname = jQuery("#province").val();
										jQuery.ajax({url : "country.xml",
												success : function(xml) {
												jQuery(xml).find("province[label='"+ pname+ "']>city").each(
														function() {
																var t = jQuery(this).attr("label");
																jQuery("#city").append("<option value='"+t+"'>"+ t+ "</option>");
																	});
															var city = '<s:property value="content.city"/>';
															jQuery("#city").val(city);
															townEvent();
															}
												});
									}
									
									function townEvent(){
										jQuery("#town>option").remove();
										var pname = jQuery("#city").val();
										jQuery.ajax({url : "country.xml",
												success : function(xml) {
												jQuery(xml).find("city[label='"+ pname+ "']>town").each(
														function() {
																var t = jQuery(this).attr("label");
																jQuery("#town").append("<option value='"+t+"'>"+ t+ "</option>");
																	});
															var town = '<s:property value="content.town"/>';
															jQuery("#town").val(town);
															}
												});
									}

									function initOptions() {
											
											countryEvent();	
											jQuery("#level").val("4");
											
											var isroute = '<s:property value="content.isroute"/>';
											jQuery("#isroute").val(isroute);
											
											jQuery("#country").change(function() {
												provinceEvent();
												jQuery("#level").val("4");
												});
											
											jQuery("#province").change(function() {
												cityEvent();
												jQuery("#level").val("8");
												});
											
											jQuery("#city").change(function() {
												townEvent();
												jQuery("#level").val("12");
												});
										}
									</script>
										<input type="hidden" name="content.level" id="level"/>
										
										<table width="100%" class="table_noboder">
											<tr>
												<td align="right" width="10%">国家：</td>
												<td align="left"><select id="country" name="content.country"></select></td>
											</tr>
											<tr>
												<td align="right" width="10%">省市自治区：</td>
												<td align="left"><select id="province" name="content.province"></select></td>
											</tr>
											<tr>
												<td align="right" width="10%">市县区：</td>
												<td align="left"><select id="city" name="content.city"></select></td>
											</tr>
											<tr>
												<td align="right" width="10%">市县镇：</td>
												<td align="left"><select id="town" name="content.town"></select></td>
											</tr>
											<tr>
												<td align="right" width="10%">是否生成路线：</td>
												<td align="left"><select id="isroute" name="content.isroute"><option value="true">是</option><option value="false">否</option></select></td>
											</tr>
										</table>
									<td>
								</tr>
							</s:if>
						</table>
					</s:form>
					</div>
					<script src='<s:url value="/script/datePicker/WdatePicker.js"/>'></script>
				</td>
			</tr>
		</table>
	</body>
</o:MultiLanguage>
</html>
