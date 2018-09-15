<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.base.action.BaseAction" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="cn.myapps.constans.Web" %>

<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>

<%
	String contextPath = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head>
	<title>{*[cn.myapps.core.dynaform.view.col_info]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<style>
#save_success  {font-size:14px; color:#23571d; background-color: #9bffa3; padding:5px; height:100%}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url id="url" value='/resourse/main.css'/>"/>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ColumnUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewUtil.js"/>'></script>
<script src='<s:url value="column.js"/>'></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>

<!-- 颜色选择取插件 -->
<link rel="stylesheet" type="text/css" href="<s:url value='/script/bgrins-spectrum/spectrum.css'/>">
<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/spectrum.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/i18n/jquery.spectrum-zh-cn.js'/>"></script>

</head>
<script>
var isMap=true;
var args = OBPM.dialog.getArgs();
var parentObj = args['parentObj'];
function ev_init(fn1,fn2) {
	
	var def1 = document.getElementsByName(fn1)[0].value;
	var def2 = document.getElementsByName(fn2)[0].value;
	
	//if (document.getElementsByName(fn1)[0].value==''){def1 = column.formid;}
	if (document.getElementsByName(fn2)[0].value==''){def2 = column.fieldName;}
	
	if(document.getElementsByName(fn1)[0].value=='')
		def2='none';

	var func = new Function("ev_init('"+fn1+"','"+fn2+"')");

	document.getElementsByName(fn1)[0].onchange = func;
	DWREngine.setAsync(false);
	FormHelper.creatFormfield4Column(fn2,def1,def2,function(str) {var func=eval(str);func.call();});
	DWREngine.setAsync(true);
}

function ev_onchange(val) {
	var _buttonType = document.getElementById("buttonType").value;
	var visible4ExpExcel = document.getElementsByName("visible4ExpExcel")[0];
	var visible4Print = document.getElementsByName("visible4Print")[0];
	document.getElementById('vstrid').style.display='';
	document.getElementById('fntrid').style.display='';
	document.getElementById('fftrid').style.display='';
	document.getElementById('stid').style.display='';
	mobileremind.style.display = "none";
	jQuery("#orderfield_tr").css("display","");
	document.getElementById("showicon_tr").style.display = 'none';
	document.getElementById("showiconMapping_tr").style.display = 'none';
	if (val=='COLUMN_TYPE_FIELD'){			
		visible4ExpExcel.disabled='';
		visible4Print.disabled='';	
		document.getElementById('btid').style.display='none';
		document.getElementById('vstrid').style.display='none';
		document.getElementById('rftrid').style.display='';
		document.getElementById('sftrid').style.display='';
		document.getElementById('cdtrid').style.display='';
		document.getElementById('cstrid').style.display='';
		document.getElementById('bnid').style.display='none';
		document.getElementById('tfid').style.display='none';
		document.getElementById('icon_tr').style.display='none';
		document.getElementById("astrid").style.display = 'none';
		if(parentObj.document.getElementById('editModeValue').value == '00'){
			document.getElementById("tftrid").style.display = '';
		}
		if(parentObj.document.getElementById('editModeValue').value == '02' || parentObj.document.getElementById('editModeValue').value == '03'){
			document.getElementById('fntrid').style.display='none';
		}
		document.getElementById("mfid").style.display = 'none';
//		if(document.getElementById("isOrderByFieldtrue").checked)
			document.getElementById('orderBy_tr').style.display='';
//		else
//			document.getElementById('orderBy_tr').style.display='none';
		document.getElementById("showicon_tr").style.display = '';
		change4ShowIcon(document.getElementsByName("showIcon")[0].checked);
	}else if (val=='COLUMN_TYPE_SCRIPT') {
		visible4ExpExcel.disabled='';
		visible4Print.disabled='';		
		document.getElementById('btid').style.display='none';
		document.getElementById('fntrid').style.display='none';
		document.getElementById('fftrid').style.display='none';
		document.getElementById('stid').style.display='none';
		document.getElementById('bnid').style.display='none';
		jQuery("#orderfield_tr").css("display","none");
		document.getElementById('vstrid').style.display='';
		document.getElementById('rftrid').style.display='';
		document.getElementById('sftrid').style.display='';
		document.getElementById('cdtrid').style.display='';
		document.getElementById('cstrid').style.display='';
		document.getElementById('tfid').style.display='none';
		document.getElementById('icon_tr').style.display='none';
		document.getElementById("astrid").style.display = 'none';
		document.getElementById("tftrid").style.display = 'none';
		document.getElementById("mfid").style.display = 'none';
//		if(document.getElementById("isOrderByFieldtrue").checked)
//			document.getElementById('orderBy_tr').style.display='';
//		else
			document.getElementById('orderBy_tr').style.display='none';
		document.getElementById("showicon_tr").style.display = '';
		change4ShowIcon(document.getElementsByName("showIcon")[0].checked);
	}else if (val=='COLUMN_TYPE_OPERATE'){
		mobileremind.style.display = "";
		visible4ExpExcel.disabled='true';
		visible4Print.disabled='true';	
		document.getElementById('btid').style.display='';
		document.getElementById('bnid').style.display='';
		document.getElementById('stid').style.display='none';
		document.getElementById('fntrid').style.display='none';
		document.getElementById('fftrid').style.display='none';
		jQuery("#orderfield_tr").css("display","none");
		document.getElementById('rftrid').style.display='none';
		document.getElementById('sftrid').style.display='none';
		document.getElementById('cdtrid').style.display='none';
		document.getElementById('cstrid').style.display='none';
		document.getElementById('vstrid').style.display='none';
		document.getElementById('icon_tr').style.display='none';
		document.getElementById('mftrid').style.display='none';
		document.getElementById('cftrid').style.display='none';
		bt_onchange(_buttonType);
//		if(document.getElementById("isOrderByFieldtrue").checked)
//			document.getElementById('orderBy_tr').style.display='';
//		else
			document.getElementById('orderBy_tr').style.display='none';
	}else if(val=='COLUMN_TYPE_LOGO'){	
		visible4ExpExcel.disabled='';
		visible4Print.disabled='';		
		document.getElementById('btid').style.display='none';
		document.getElementById('bnid').style.display='none';
		document.getElementById('stid').style.display='none';
		document.getElementById('fntrid').style.display='none';
		document.getElementById('fftrid').style.display='none';
		jQuery("#orderfield_tr").css("display","none");
		document.getElementById('rftrid').style.display='none';
		document.getElementById('sftrid').style.display='none';
		document.getElementById('cdtrid').style.display='none';
		document.getElementById('cstrid').style.display='none';
		document.getElementById('vstrid').style.display='none';
		document.getElementById('tfid').style.display='none';
		document.getElementById('icon_tr').style.display='';
		document.getElementById('mftrid').style.display='none';
		document.getElementById('cftrid').style.display='none';
		document.getElementById("astrid").style.display = 'none';
		document.getElementById("mfid").style.display = 'none';
//		if(document.getElementById("isOrderByFieldtrue").checked)
//			document.getElementById('orderBy_tr').style.display='';
//		else
			document.getElementById('orderBy_tr').style.display='none';
	}else if(val=='COLUMN_TYPE_ROWNUM'){
		visible4ExpExcel.disabled='';
		visible4Print.disabled='';			
		document.getElementById('btid').style.display='none';
		document.getElementById('bnid').style.display='none';
		document.getElementById('stid').style.display='none';
		document.getElementById('fntrid').style.display='none';
		document.getElementById('fftrid').style.display='none';
		jQuery("#orderfield_tr").css("display","none");
		document.getElementById('orderBy_tr').style.display='none';
		document.getElementById('rftrid').style.display='none';
		document.getElementById('sftrid').style.display='none';
		document.getElementById('cdtrid').style.display='none';
		document.getElementById('cstrid').style.display='';
		document.getElementById('vstrid').style.display='none';
		document.getElementById('tfid').style.display='none';
		document.getElementById('icon_tr').style.display='none';
		document.getElementById('mftrid').style.display='none';
		document.getElementById('cftrid').style.display='none';
		document.getElementById("astrid").style.display = 'none';
		document.getElementById("mfid").style.display = 'none';
	}
}

// content.name字段校验(请查看util.js)
var validators = [{fieldName: "content.name", type: "required", msg:"{*[page.name.required]*}" }             
                  ]; 


function doSave(){

	//验证审批状态是否为空
//	var aprovalue = document.getElementById('approveLimit').value;
//	var _buttonType01 = document.getElementById('buttonType').value;
//	var _type1 = document.getElementsByName("type");
//	if(aprovalue==""&&_buttonType01==01&&_type1[2].checked){
//		showMessage("error", "请选择下一个审批状态");
//		return false;
//		
//	}

	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	createJumpMappingStr(); //生成操作列跳转类型的配置
	createIconMappingStr(); //生成操作列图标属性的映射关系
	var vt = parentObj.document.getElementById("viewType").value;
	if(vt==18){
		var mappingtField = document.getElementById("MappingtField").value;
		if(mappingtField==null||mappingtField.length ==0){
			alert("请先该控件设映射字段");
			return ;
		}else{
			for(var i=0;i<columnCache.length;i++){
				if(mappingtField != this.column.mappingField && mappingtField == columnCache[i].mappingField){
					var flag = window.confirm("该映射字段以绑定,是否取消原先的绑定重新绑定到该字段");
					if(flag){
						columnCache[i].mappingField = "";
						break;
					}else{
						return;
					}
				}
			}
		}
	}

	if (doValidate(validators) && buttonNameValidate()) {
		DWRUtil.getValues(column);
		if (!column.id) {
			doCreate(column);
		}
		jQuery("#save_success").css("display","");
		parentObj.columnProcess.refreshList(columnCache);
		//表单字段是否为地图控件标识
		OBPM.dialog.doReturn(isMap);
	}
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
}

var oldValue;//原先的映射字段值
function checkField(value){//检查映射字段是否已被映射
	var e = false;
	var vt = parentObj.document.getElementById("viewType").value;
	if(vt != 18){
		for(var i=0;i<columnCache.length;i++){
			if(value != "" && value != this.column.mappingField && value == columnCache[i].mappingField){
				alert("该字段已被映射,请选择其他字段");
				document.getElementById("MappingField").value = oldValue;//this.column.mappingField
				e = true;
				break;
			}
		}
	}
	if(!e){
		oldValue = value;
	}
}

function doSaveAndNew(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if (doValidate(validators) && buttonNameValidate()){
		DWRUtil.getValues(column);
		var tempView = column.parentView;
		if (!column.id) {
			doCreate(column);
		}
		//置换当前编辑的column为新column
		column = new Column();
		column.parentView = tempView;
		DWRUtil.setValues(column);
		initType();
		initShowType();
		initOrderByField();
		parentObj.columnProcess.refreshList(columnCache);
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	}
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
}

//初始化Column Type默认值
function initType(){
	var types = document.getElementsByName("type");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
	  	types[0].click();
	}
}

function initShowType(){
	var types = document.getElementsByName("showType");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
	  	types[0].click();
	}
}

//初始化排序字段 
function initOrderByField(){
	var types = document.getElementsByName("isOrderByField");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
	  	types[0].click();
	}
}

//如果列的初始状态的displayType值为空时,则显示方式displayType默认选择“所有”
function initDisplayType(){
	var displayTypes = document.getElementsByName("displayType");
	var flag = true;
	for(var i=0;i<displayTypes.length;i++){
		if(displayTypes[i].checked){
			flag = false;
			break;
		}
	}
	if(flag){
		displayTypes[0].click();
	}
}

function init_flowRunters(){
        var val = document.getElementById("flowReturnCss");
        if(val.value=='true'){
           document.getElementById('mftrid').style.display="";
	       document.getElementById('cftrid').style.display="";
        }else{
           document.getElementById('mftrid').style.display="none";
	       document.getElementById('cftrid').style.display="none";
        }
}

function init_fr_SumAndMapping(){//初始化回退标志、汇总和映射字段显示
	//var vt = '<s:property value="#parameters.viewType"/>';
	var vt = parentObj.document.getElementById("viewType").value;
	if(vt == '19'){//甘特图
		document.getElementById("rftrid").style.display="none";
		document.getElementById("sftrid").style.display="none";
		document.getElementById("mfftrid").style.display="";
		ColumnUtil.getGanttFields(function(options){init_Options("MappingtField", options, ["name", "start", "end", "complete"]);});
		document.getElementById("mapView").innerText = "({*[cn.myapps.core.dynaform.view.gantt_view]*})";
	} else if (vt == '18') {//地图
		document.getElementById("rftrid").style.display="";
		document.getElementById("sftrid").style.display="";
		document.getElementById("mfftrid").style.display="";
		ColumnUtil.getMapFields(function(options){init_Options("MappingtField", options, ["mapcolumn"]);});
		document.getElementById("mapView").innerText = "({*[map]*})";
	} else if(vt == '17') {//树形视图
		document.getElementById("rftrid").style.display="";
		document.getElementById("sftrid").style.display="";
		document.getElementById("mfftrid").style.display="";
		ColumnUtil.getTreeFields(function(options){init_Options("MappingtField", options, ["superior_Node", "current_Node", "name_Node"]);});
		document.getElementById("mapView").innerText = "({*[cn.myapps.core.dynaform.view.tree_view]*})";
	}else if(vt == '16'){//日历视图
		document.getElementById("rftrid").style.display="";
		document.getElementById("sftrid").style.display="";
		document.getElementById("mfftrid").style.display="";
		ColumnUtil.getCldFields(function(options){init_Options("MappingtField", options, ["CldViewDateColum"]);});
		document.getElementById("mapView").innerText = "({*[cn.myapps.core.dynaform.view.calendar_view]*})";
	}else {
		document.getElementById("rftrid").style.display="";
		document.getElementById("sftrid").style.display="";
		document.getElementById("mfftrid").style.display="none";
		document.getElementById("mapView").innerText = "";
	}
}

//初始化映射字段的选项
function init_Options(elemId, options, defKeys) {
	DWRUtil.removeAllOptions(elemId);
	var choose = {"" : "{*[cn.myapps.core.dynaform.view.please_choose]*}"};
	DWRUtil.addOptions(elemId, choose);
	for(var i=0;i<defKeys.length;i++){
		//提示(必填的字段)
		if(defKeys[i] != null && defKeys[i] != ''){
			options[defKeys[i]] = "({*[cn.myapps.core.dynaform.view.need]*})"+options[defKeys[i]];
		}
	}
	DWRUtil.addOptions(elemId, options);
	DWRUtil.setValue(elemId, this.column.mappingField);
	oldValue = jQuery("#" + elemId).val();
}

//当试图为日历视图时检查选择的字段是否是日期字段
function checkformFieldIsDate(value){
	var vt = parentObj.document.getElementById("viewType").value;
	if(vt == '16'){
		var form = document.getElementById("formid").value;
		FormHelper.getDateFields(form, function(options){
			var isDate = false;
			if(value != null && value != ''){
				for(var k in options){
					if(k == value ||options[k] == value){
						isDate = true;
						break;
					}
				}
			}
			if(isDate)
				document.getElementById("MappingtField").disabled = "";
			else{
				document.getElementById("MappingtField").value = "";
				document.getElementById("MappingtField").disabled = "disabled";
			}
		});
	}
}
function checkformFieldIsNoOrder(value){
	if(column.type == 'COLUMN_TYPE_FIELD'){
		var form = document.getElementById("formid").value;
		DWREngine.setAsync(false);
		FormHelper.isNoOrderField(form,value, function(f){
			if(f=="true"||value=='$AuditorNames'){
				jQuery("#orderfield_tr").css("display","none");
				jQuery("#orderBy_tr").css("display","none");
				jQuery("#orderfield_tr_advice").html("{*[cn.myapps.core.dynaform.view.dissupport_order]*}"); 
			}else{
				jQuery("#orderfield_tr").css("display","");
				jQuery("#orderfield_tr_advice").html(""); 
			}
		});
		DWREngine.setAsync(true);
	}
}

/**
 * 检查字段是否有真实值，以下控件有：单选、复选、下拉、用户、部门、树形部门；
 * 无真实值时隐藏“值类型”选项
 */
function fieldIsHasTrueValue(value){
	if(column.type == 'COLUMN_TYPE_FIELD'){
		var form = document.getElementById("formid").value;
		DWREngine.setAsync(false);
		FormHelper.isHasTrueValue(form,value, function(f){
			if(f=="true"){
				jQuery("#stid").css("display","");
			}else{
				jQuery("#stid").css("display","none");
			}
		});
		DWREngine.setAsync(true);
	}
}

//当选择的表单字段为非地图控件，映射字段为“标题”，“地址”，“内容”。
function checkformFieldIsMap(value){
	var vt = parentObj.document.getElementById("viewType").value;
	if(vt==18){
		var form = document.getElementById("formid").value;
		FormHelper.isMapField(form,value, function(b){
			if(!b){
				isMap = false;
				ColumnUtil.getOtherFormFields(function(options){init_Options("MappingtField", options, ["titlecolumn","addresscolumn","detailcolumn"]);});
			}else{
				isMap = true;
				ColumnUtil.getMapFields(function(options){init_Options("MappingtField", options, ["mapcolumn"]);});
			}
		});
	}
}

function changeDisplayType(value){
	if(value == '01'){
		var diplayLength = document.getElementById("displayLength").value;
		if(diplayLength < 0){
			document.getElementById("displayLength").value = '';
		}
		document.getElementById("cdl").style.display = '';
	}else{
		document.getElementById("cdl").style.display = 'none';
	}
}

function on_change(item){
	if(item.checked){
	    document.getElementById('mftrid').style.display="";
		document.getElementById('cftrid').style.display="";
	}else{
	    document.getElementById('mftrid').style.display="none";
		document.getElementById('cftrid').style.display="none";
	}
}

function addEventForDivPrompt(){
	jQuery("#width").bind("focus",function(){
		jQuery("#divPrompt").css("display","");
	});
	jQuery("#width").bind("blur",function(){
		jQuery("#divPrompt").css("display","none");
	});
}

//视图列选择系统字段时,将汇总信息给屏蔽掉
function on_sftrid_change_handle(obj) {
	var sftrid = document.getElementById("sftrid");
	if(obj =='$Id' || obj=='$StateLabel' || obj=='$Created' || obj=='$AuditDate' || obj=='$LastModified' || obj=='$Author' || obj=='$AuditorNames' || obj=='$LastFlowOperation' || obj=='$FormName'){
		sftrid.style.display = 'none';
	}else{
		sftrid.style.display = '';
	}
}

//根据视图过滤"设计模式"或者"代码模式"来显示列绑定的表单字段
function define_fieldName(){
	var mode = parentObj.document.getElementById("editModeValue").value;
	switch (mode) {
	case '00':
		break;
	case '01':
		break;
	case '02':
		reset_fieldName();
		break;
	case '03':
		reset_fieldName();
		break;
	default:
		break;
	}
}

function reset_fieldName(){
	document.getElementById('fntrid').style.display='none';
	var obj = document.getElementById("fieldName");
	var html="<input type='text' name='content.fieldName' id='fieldName' value='" + (column.fieldName != null ? column.fieldName:'') + "' />";
	obj.parentNode.innerHTML = html;
}

//初始化Column对象
window.onload = function(){
	this.columnCache = parentObj.columnCache;
	var index = '<s:property value="#parameters.index" />';
	if (columnCache[index]) {
		this.column = columnCache[index];
		DWRUtil.setValues(this.column);
	} else {
		this.column = new Column();
	}

	initColorInput();	//初始化颜色选择控件
	//initType();
	initShowType();
	initDisplayType();
	document.getElementById('mftrid').style.display="none";
	document.getElementById('cftrid').style.display="none";
	document.getElementById('btid').style.display="none";
	ev_init('content.formid', 'content.fieldName');
	init_flowRunters();
	changeDisplayType(column.displayType);
	init_fr_SumAndMapping();//
	initType();
	initOrderByField();
	checkformFieldIsNoOrder(column.fieldName);
	checkformFieldIsDate(column.fieldName);
	checkformFieldIsMap(column.fieldName);
	var flowReturnCss=document.getElementById("flowReturnCss");
	on_change(flowReturnCss);

	var _buttonType = document.getElementById("buttonType").value;
	bt_onchange(_buttonType);

	if(column.icon != null && column.icon != ''){
		document.getElementById("_iconImg").src ='<s:url value="/lib/icon/" />'+column.icon;
	}else{
		document.getElementById("_iconImg").style.display = 'none';
	}
		
	window.top.toThisHelpPage("application_module_view_info_column_info");
	addEventForDivPrompt();
	if(parentObj.document.getElementById('editModeValue').value != '00'){
		document.getElementById('tftrid').style.display = 'none';
	}

	initMapping(); //初始化操作列跳转类型的配置
	initMapping4icon();//初始化图标属性的映射关系
	change4ShowIcon(document.getElementsByName("showIcon")[0].checked);

	//初始列格式的类型
	var _formatType = document.getElementById("formatType").value;
	formatTypeChange(_formatType);
	formatChange();
	formatChange4Curr();

	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	var _type = document.getElementsByName("type");
	for(var i=0;i<_type.length;i++){
		if(_type[i].checked){
			ev_onchange(_type[i].value);
		}
	}
	define_fieldName();
	cleanPromptVal();
	fieldIsHasTrueValue(column.fieldName);	//检查字段是否有真实值，无真实值时隐藏“值类型”选项
};

function setOrderByField(val){
	if(val=='true' || val==true){
		//jQuery("#orderType").removeAttr("disabled");
		//jQuery("#sortStandard").removeAttr("disabled");
		//document.getElementById("orderBy_tr").style.display = '';
	}else{
		//jQuery("#orderType").attr("disabled","disabled");
		//jQuery("#sortStandard").attr("disabled","disabled");
		//document.getElementById("orderBy_tr").style.display = 'none';
	}
}

function bt_onchange(val){
	if(val == '03'){
		document.getElementById("tfid").style.display = '';
	}else{
		document.getElementById("tfid").style.display = 'none';
	}

	if(val == '04'){
		document.getElementById("astrid").style.display = '';
	}else{
		document.getElementById("astrid").style.display = 'none';
	}

	if(val == '05'){
		document.getElementById("mfid").style.display = '';
	}else{
		document.getElementById("mfid").style.display = 'none';
	}
}

function selectField(actionName, field){
	var url = contextPath + '/core/workflow/statelabel/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}

	var oField = document.getElementById(field);
	//var rtn = window.showModalDialog(url, oField, "dialogHeight:400px; dialogWidth:300px; status:no; scroll:no;");
	OBPM.dialog.show({
		opener:window.parent,
		width: 300,
		height: 400,
		url: url,
		args: {oField:oField},
		title: '{*[cn.myapps.core.dynaform.view.select_state]*}',
		close:function(rtn) {
			if(rtn){
				oField.value = rtn;
			} else if (rtn == '') {
				oField.value = rtn;
			}
		}
	});
	
}

function selectMultiLanguage(actionName, field){
	var url = contextPath + '/core/multilanguage/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	
	var oField = document.getElementsByName(field)[0];
	OBPM.dialog.show({
		opener:window.parent,
		width: 610,
		height: 440,
		url: url,
		args: {},
		title: '{*[cn.myapps.core.dynaform.view.select_multilanguage]*}',
		close: function(rtn) {
			if(rtn){
				oField.value = rtn;
			} else if (rtn == '') {
				oField.value = rtn;
			}
		}
	});
	
}

function buttonNameValidate(){
	var _types = document.getElementsByName('type');
	var _buttonName = document.getElementById('buttonName').value;
	var _buttonType = document.getElementById('buttonType').value;
	for(i=0; i<_types.length; i++){
		if(document.getElementsByName('type')[i].checked){
			var typeValue = document.getElementsByName('type')[i].value;
		}
	}
	if(typeValue == 'COLUMN_TYPE_FIELD'){
	    var fieldValue = document.getElementsByName("content.fieldName")[0].value;
		 if(fieldValue == null || fieldValue == ''){
			showMessage("error", '请给该列设映射字段');
			return false;
		}  
	}else if(typeValue == 'COLUMN_TYPE_OPERATE' && _buttonName == ''){
		showMessage("error", '{*[cn.myapps.core.dynaform.view.name_required]*}');
		return false;
	}else if(typeValue == 'COLUMN_TYPE_OPERATE' && _buttonType == ''){
		showMessage("error", '{*[page.macro.type.notchoose]*}');
		return false;
	}else if(typeValue == 'COLUMN_TYPE_OPERATE' && _buttonType == '05'){ //对操作列跳转类型按钮的校验
		var _mappingform = document.getElementById("mappingform").value;
		var agrs = document.getElementsByName("agr");
		var colNames = document.getElementsByName("Colname");
		if(_mappingform == ''){
			showMessage("error", "请选择目标表单");
			return false;
		}
		for(var k=0; k<agrs.length; k++){
			if(agrs[k].value == ''){
				showMessage("error", "请输入参数名称");
				return false;
			}
		}
		for(var j=0; j<colNames.length; j++){
			if(colNames[j].value == ''){
				showMessage("error", "请选择参数值(列)");
				return false;
			}
		}
	}
	if(document.getElementById("cdl").style.display !="none" && document.getElementById("displayLength").value ==""){
		showMessage("error", '{*[cn.myapps.core.dynaform.view.Display_value]*}');
		return false;
	}
	return true;
}

function cleanPromptVal(){
	jQuery("#actionScriptButton").click(function(){
		if(jQuery("#actionScript").val() == jQuery("#actionScript").attr("title"))
			jQuery("#actionScript").val("");
		openIscriptEditor('content.actionScript','{*[Script]*}{*[Editor]*}','{*[ActionScript]*}','content.name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenScriptButton").click(function(){
		if(jQuery("#hiddenScript").val() == jQuery("#hiddenScript").attr("title"))
			jQuery("#hiddenScript").val("");
		openIscriptEditor('content.hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','content.name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#valueScriptButton").click(function(){
		if(jQuery("#valueScript").val() == jQuery("#valueScript").attr("title"))
			jQuery("#valueScript").val("");
		openIscriptEditor('content.valueScript','{*[cn.myapps.core.dynaform.view.script_editor]*}','{*[cn.myapps.core.dynaform.view.value_script]*}','content.name','{*[Save]*}{*[Success]*}');
	});
}

function selectIcon(imgFieldId, targetid){
	  var application = document.getElementById("application").value;
	  var url = contextPath + '/core/resource/iconLib.jsp?application=' + application;
	  OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {},
			title: '{*[Select]*}{*[Icon]*}',
			close: function(rtn) {
				if (rtn != null && rtn != '') {
					document.getElementById(imgFieldId).style.display = '';
					document.getElementById(targetid).value=rtn;
					document.getElementById(imgFieldId).src ='<s:url value="/lib/icon/" />'+rtn;
				}
			}
		});
	}

function cleanIcon(imgFieldId, targetid){
	document.getElementById(imgFieldId).style.display = 'none';
	document.getElementById(targetid).value='';
}

jQuery(function(){
	var viewType=parentObj.document.getElementById("viewType").value;
	if(viewType==1 || viewType==17){
		jQuery("#orderfield_tr").css("display","");
	}
});

var rowIndex = 2;
var getFrom = function(data) {return '{*[From]*}:'};
var getAgr = function(data) {
	return '<input type="text" name="agr" value="' + data.agr + '"/>';
};
var getColName = function(data) {
	var s = '';
	s +='<select id="ColId' + rowIndex + '" name="colname" value="' + data.colname + '">';
	s +='<option value="">{*[Select]*}</option>';
	s +='</select>';
	rowIndex ++;
	return s;
}
var getTo = function(data){return '{*[cn.myapps.core.dynaform.view.to]*}:'};
var getDelete = function(data){
	return '<input type="button" value="{*[Delete]*}" onclick="delMappRow(this.parentNode.parentNode)" />';
}


function addMappRows(datas){
	var cellFuncs = [getFrom, getAgr, getTo, getColName, getDelete];

	var rowdatas = datas;
	if(!datas){
		var data = {agr:'', colname:''};
		rowdatas = [data];
	}

	DWRUtil.addRows("_jumpmapping", rowdatas, cellFuncs);

	var defValues = new Array();
	
	if (datas) { //设置默认值
		for(var i=0;i<datas.length;i++) {
			defValues[i] = datas[i].colname;
		}
	} else {
		var colSels = document.getElementsByName("colname");
		for(var i=0;i<colSels.length;i++) {
			defValues[i] = colSels[i].value;
		}
	}
	
	addColOptions(defValues);
}

function addColOptions(defValues){
	this.columnCache = parentObj.columnCache;
	var index = '<s:property value="#parameters.index" />';

	var map = {'':'{*[Select]*}'};
	for(var k=0; k<columnCache.length; k++){
		if(columnCache[k].type == 'COLUMN_TYPE_FIELD' || columnCache[k].type == 'COLUMN_TYPE_SCRIPT'){
			if((index && k != index) || !index){
				map[columnCache[k].id] = columnCache[k].name;
			}
		}
	}
	
	var colSels = document.getElementsByName("colname");
	for(var i=0; i<colSels.length; i++){
		DWRUtil.removeAllOptions(colSels[i].id);
		DWRUtil.addOptions(colSels[i].id, map);
		if (defValues) { // 设置column name 默认选项
			DWRUtil.setValue(colSels[i].id, defValues[i]);
		}
	}
}

function delMappRow(row){
	document.getElementById("_jumpmapping").deleteRow(row.rowIndex);
	rowIndex --;	
}

function createJumpMappingStr(){
	var agrs = document.getElementsByName("agr");
	var cols = document.getElementsByName("colname");
	var mappStr = '';
	if(cols){
		for(var i=0; i<cols.length; i++){
			if(agrs[i].value != '' && cols[i].value != ''){
				mappStr += HTMLEncode(agrs[i].value + ":" + cols[i].value + ";");
			}
		}
	}

	mappStr = mappStr.substring(0, mappStr.length-1);
	document.getElementById("jumpMapping").value = mappStr;
}

function initMapping(){
	var _jumpMapping = document.getElementById("jumpMapping").value;
	var mapps;
	if(_jumpMapping){
		mapps = _jumpMapping.split(";");
	}
	var array = new Array();
	array[0] = {agr:'', colname:''};

	if(mapps){
		for(var i=0; i<mapps.length; i++){
			var rel = mapps[i].split(":");
			var agrValue = rel[0];
			var colValue = rel[1];
			var map = {agr:agrValue, colname:colValue};
			array[i] = map;
		}
	}

	addMappRows(array);
}

//==========showIcon begin===============
var rowIndex4icon = 2;
var getIconValue = function(data) {
	return '<input type="text" name="iconValue" value="' + data.iconValue + '"/>';
};
var getIconUrl = function(data) {
	var s = '';
	if(data.iconUrl){
		s += '<img id="_iconImg4icon' + rowIndex4icon + '" width="16" height="16" alt="" src="<s:url value="/lib/icon/" />' + data.iconUrl + '">';
	}else {
		s += '<img id="_iconImg4icon' + rowIndex4icon + '" width="16" height="16" alt="" src="" style="display:none">';
	}
	s += '<input type="hidden" id="iconUrl' + rowIndex4icon + '" name="iconUrl" value="' + data.iconUrl + '"/>';
	s += '<input type="button" class="button-cmd" style="margin: 0 5px;" onclick="selectIcon(\'_iconImg4icon' + rowIndex4icon + '\',\'iconUrl' + rowIndex4icon + '\')" value="{*[Select]*}"/>';
	s += '<input type="button" class="button-cmd" onclick="cleanIcon(\'_iconImg4icon' + rowIndex4icon + '\',\'iconUrl' + rowIndex4icon + '\')" value="{*[Clear]*}"/>';
	rowIndex4icon ++;
	return s;
}
var getDelete4Icon = function(data){
	return '<input type="button" value="{*[Delete]*}" onclick="delMappRow4icon(this.parentNode.parentNode)" />';
}


function addMappRows4icon(datas){
	var cellFuncs = [getIconValue, getIconUrl, getDelete4Icon];

	var rowdatas = datas;
	if(!datas){
		var data = {iconValue:'', iconUrl:''};
		rowdatas = [data];
	}

	DWRUtil.addRows("_iconMapping", rowdatas, cellFuncs);
}

function delMappRow4icon(row){
	document.getElementById("_iconMapping").deleteRow(row.rowIndex);
	rowIndex4icon --;	
}

function createIconMappingStr(){
	var agrs = document.getElementsByName("iconValue");
	var cols = document.getElementsByName("iconUrl");
	var mappStr = '';
	if(agrs){
		for(var i=0; i<cols.length; i++){
			if(agrs[i].value != '' && cols[i].value != ''){
				mappStr += HTMLEncode(agrs[i].value + ":" + cols[i].value + ";");
			}
		}
	}

	mappStr = mappStr.substring(0, mappStr.length-1);
	document.getElementById("iconMapping").value = mappStr;
}

function initMapping4icon(){
	var _iconMapping = document.getElementById("iconMapping").value;
	var mapps;
	if(_iconMapping){
		mapps = _iconMapping.split(";");
	}
	var array = new Array();
	array[0] = {iconValue:'', iconUrl:''};

	if(mapps){
		for(var i=0; i<mapps.length; i++){
			var rel = mapps[i].split(":");
			var agrValue = rel[0];
			var colValue = rel[1];
			var map = {iconValue:agrValue, iconUrl:colValue};
			array[i] = map;
		}
	}

	addMappRows4icon(array);
}

function change4ShowIcon(val){
	if(val){
		document.getElementById("showiconMapping_tr").style.display = '';
	}else {
		document.getElementById("showiconMapping_tr").style.display = 'none';
	}
}
//==========showIcon end  ===============

function ev_switchpage(sId) {
	document.getElementById('span_tab1').className="btcaption";
	document.getElementById('span_tab2').className="btcaption";
	
	document.getElementById('1').style.display="none";
	document.getElementById('2').style.display="none";

	if(jQuery("#"+ sId)) {
		document.getElementById('span_tab'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
	}
}

//改变格式类型
function formatTypeChange(value){
	document.getElementById("formattype_simple").style.display = 'none';
	document.getElementById("formattype_sum").style.display = 'none';
	document.getElementById("formattype_curr").style.display = 'none';

	if(value == 'simple'){
		document.getElementById("formattype_simple").style.display = '';
	}else if(value == 'number'){
		document.getElementById("formattype_sum").style.display = '';
	}else if(value == 'currency'){
		document.getElementById("formattype_curr").style.display = '';
	}
}

//数值格式化
function formatChange(){
	var num = document.getElementById("decimalsNum").value;
	var divi = document.getElementById("thouSign").checked;
	ColumnUtil.formatNum(num, divi, function(result){
		document.getElementById("exampleNum").innerHTML = result;
	});
}

//货币格式化
function formatChange4Curr(){
	var num = document.getElementById("decimalsCurr").value;
	var currType = document.getElementById("currType").value;
	ColumnUtil.formatCurr(num, currType, function(result){
		document.getElementById("exampleCurr").innerHTML = result;
	});
}

//输入的值不是数字时，重置为上一个值
var origValue = "";
function resetWhenNonNumeric(input){
	var re = /^([\-]{1}[0-9]*|[0-9]*)\.?[0-9]*$/;
	if (!re.test(input.value)) {
		for(var i =0;i<input.value.length;i++){
			var s = input.value.charAt(i);
			if(isNaN(s)){	
				break;
			}
		}
		input.value = input.value.substring(0,i);
		return false;
	} else {
		origValue = input.value;
	}
}

/**
 * 改变示例样式
 */
function changeExampleStyle(){

	jQuery("#exampleSpan").css({
		"color" : jQuery("#color").val(),
		"background-color" : jQuery("#groundColor").val(),
	});
}

/**
 * 初始化颜色选择控件
 */
function initColorInput(){
	
	//初始化颜色选择器--字体颜色
	jQuery("#fontColor").spectrum({
		showPalette:true,
		hideAfterPaletteSelect:true,
		showInput: true,
		showInitial: true,
		allowEmpty: true,
		showPalette: true,
		showSelectionPalette: true,
		clickoutFiresChange: true,
		preferredFormat: "hex3",
		palette: [
			["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
			["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
			["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
			["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
			["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
			["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
			["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
			["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
		],
		change: function(color) {
			if(color){
				color = color.toHexString();
			}else{
				color = "";
			}
			jQuery("#fontColor").val(color);
		}
	});
	
	//初始化颜色选择器--颜色
	jQuery("#color").spectrum({
		showPalette:true,
		hideAfterPaletteSelect:true,
		showInput: true,
		showInitial: true,
		allowEmpty: true,
		showPalette: true,
		showSelectionPalette: true,
		clickoutFiresChange: true,
		preferredFormat: "hex3",
		palette: [
			["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
			["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
			["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
			["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
			["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
			["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
			["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
			["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
		],
		change: function(color) {
			if(color){
				color = color.toHexString();
			}else{
				color = "";
			}
			jQuery("#color").val(color);
			
			changeExampleStyle();	//改变示例样式
		}
	});
	
	//初始化颜色选择器--底色
	jQuery("#groundColor").spectrum({
		showPalette:true,
		hideAfterPaletteSelect:true,
		showInput: true,
		showInitial: true,
		allowEmpty: true,
		showPalette: true,
		showSelectionPalette: true,
		clickoutFiresChange: true,
		preferredFormat: "hex3",
		palette: [
			["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
			["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
			["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
			["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
			["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
			["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
			["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
			["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
		],
		change: function(color) {
			if(color){
				color = color.toHexString();
			}else{
				color = "";
			}
			jQuery("#groundColor").val(color);
			
			changeExampleStyle();	//改变示例样式
		}
	});
	
	changeExampleStyle();	//改变示例样式
}

jQuery(document).ready(function(){
	jQuery("#displayLength").keyup(function(){
		resetWhenNonNumeric(this);
	});
})
</script>
<body style="margin:0px;padding-left: 15px;">
<s:form name="columnform" action="save" method="post">
<s:bean name="cn.myapps.core.dynaform.view.action.ColumnHelper" id="helper" />
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="formHelper" >
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<%@include file="/common/page.jsp"%>

<s:hidden name="moduleid" value="%{#parameters.moduleid}"/>
<s:hidden id="parentView" name="viewid" value="%{#parameters.viewid}"/>
<s:hidden name="s_view" value="%{#parameters.viewid}"/>
<s:hidden id="orderno" name="content.orderno" />
<table width="100%" style="border-bottom: 1px solid gray;">
	<tr valign="top">
		<td><div id="save_success" style="display:none">{*[cn.myapps.core.dynaform.view.col_info_save_success]*}</div></td>
		<td align="right">
			<table border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td  valign="top">
						<button type="button" class="button-class" onClick="doSaveAndNew()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save&New]*}</button>
					</td>
					<td width="70" valign="top">
						<button type="button" id="btn_confirm" class="button-class" onClick="doSave();" ><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</button>
					</td>
					<td width="65" valign="top">
						<button type="button" class="button-class" onClick="OBPM.dialog.doReturn();">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Cancel]*}
						</button>
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
<table width="100%">
	<tr>
		<td class="nav-s-td">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left: 10px;">
						<div class="listContent">
							<input type="button" id="span_tab1" name="spantab1"
								class="btcaption" onClick="ev_switchpage('1')"
								value="{*[Basic]*}" />
						</div>
						<div class="listContent nav-seperate">
							<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
						</div>
						<div class="listContent">
							<input type="button" id="span_tab2" name="spantab2"
								class="btcaption" onclick="ev_switchpage('2')"
								value="{*[Format]*}" />
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table id="1" width="100%">
		<tr>
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.col_name]*}：</td>
			<td><s:textfield id="name" theme="simple" cssClass="input-cmd"  name="content.name" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.col_width]*}：</td>
			<td height="30px">
				<div style="float: left;">
					<s:textfield id="width" theme="simple" cssClass="input-cmd"  name="content.width"/>
				</div>
				<div id="divPrompt" style="display: none; float: left; margin-top: 5px;">
					<span class="tipsStyle">{*[Unit.is.px.or.%]*}</span>
				</div>
			</td>
			
		</tr>
		<tr>
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.multilanguage_label]*}：</td>
			<td><s:textfield id="multiLanguageLabel" theme="simple" cssClass="input-cmd" readonly="true"  name="multiLanguageLabel" />
				<button type="button" class="button-image" onClick="selectMultiLanguage('selectlist','multiLanguageLabel');">
					<img src="<s:url value='/resource/image/search.gif' />" />
				</button>
			</td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[Type]*}：</td>
			<td><s:radio name="type" theme="simple" list="#helper.getTypeList()" onclick="ev_onchange(this.value)"/></td>
		</tr>
		<tr id="mobileremind" style="display:none">
			<td></td>
			<td class="tipsStyle">*{*[cn.myapps.core.dynaform.view.Mobile_client_does_not_support]*}</td>
		</tr>
		
		<tr id="bnid">
			<td class="commFont commLabel">{*[Name]*}：</td>
			<td><s:textfield id="buttonName" name="buttonName" theme="simple" value=""/></td>
		</tr>
		
		<tr id="btid">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.operate_type]*}：</td>
			<td><s:select id ="buttonType" name="buttonType" theme="simple" list="#helper.getButtontypelist()" emptyOption="true" onchange="bt_onchange(this.value)"/></td>
		</tr>
		<tr id="tfid" style="display:none">
			<td class="commFont commLabel" >{*[core.dynaform.form.type.templateform]*}：</td>
			<td><s:select name="content.templateForm" list="#fh.getTemplateFormList(#parameters.application)" listKey="id" id="templateForm" listValue="name"
			     emptyOption="true" theme="simple" /></td>
		</tr>
		
		<tr id="mfid" style="display:none">
			<td class="commFont commLabel" >{*[cn.myapps.core.dynaform.view.mapping_config]*}：
			<input type="hidden" name="jumpMapping" id="jumpMapping"/>
			</td>
			<td width="85%">
			<table style="border:dashed thin black" width="85%">
				<tbody id="_jumpmapping"> 
				<tr>
					<td>{*[cn.myapps.core.dynaform.view.to_summary_form]*}:</td>
					<td>
						<s:select id="mappingform" name="content.mappingform" list="#formHelper.get_formListByModuleType(#parameters.moduleid)" emptyOption="true" theme="simple"/>
					</td>
				</tr>
				<tr><td colspan="5" align="right">
					<input type="button" value="{*[Add]*}" onclick="addMappRows()"/> 
				</td></tr>
				<tr>
					<th width="30%"></th>
					<th>{*[cn.myapps.core.dynaform.view.param_name]*}</th>
					<th width="10%"></th>
					<th width="25%">{*[cn.myapps.core.dynaform.view.param_value]*}</th>
					<th width="20%"></th>
				</tr>
				</tbody>
			</table>
			</td>
		</tr>
		
		<tr id='stid'>
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.value_type]*}：</td>
			<td><s:radio name="showType" theme="simple" list="#{'01':'{*[cn.myapps.core.dynaform.view.text_value]*}','00':'{*[cn.myapps.core.dynaform.view.real_value]*}'}" /></td>
		</tr>
		
		<tr id='vstrid' style="display:none">
		    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.value_script]*}：</td>
			<td>
				<s:textarea id="valueScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_value_script]*}*/" cssClass="input-cmd" label="{*[cn.myapps.core.dynaform.view.value_script]*}" name="content.valueScript" cols="60" rows="5" theme="simple"/>
				<button type="button" id="valueScriptButton" class="button-image" ><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
			</td>
		</tr>
		
		<tr id='fntrid'>
		    <td class="commFont commLabel">{*[Form]*}：</td>
			<td>
				<s:select label="Form" id="formid" name="content.formid" list="#formHelper.get_relateFormById(#parameters.targetFormId)" listKey="id"
					listValue="name" emptyOption="true" theme="simple"/>
			</td>
		</tr>
		<tr id='fftrid'>
		    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.form_field]*}：</td>
			<td>
				<s:select label="{*[Field]*}" id="fieldName" name="content.fieldName" list="{}" emptyOption="true" theme="simple"
					onchange="checkformFieldIsNoOrder(this.value);checkformFieldIsDate(this.value);checkformFieldIsMap(this.value);on_sftrid_change_handle(this.value);fieldIsHasTrueValue(this.value);" />
					<div id = "orderfield_tr_advice" align="left" style = "color: #ff0000";></div>
			</td>
		</tr>
		<tr id='orderfield_tr' style="display: none;">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.IsOrderByField]*}：</td>
			<td>
				<s:radio id="isOrderByField" name="isOrderByField" theme="simple" list="#{'false':'{*[cn.myapps.core.dynaform.view.no]*}','true':'{*[Yes]*}'}" onclick="setOrderByField(this.value)"/>
				<span class="tipsStyle">同一时间仅支持一列默认排序</span>
			</td>
		</tr>
		<tr id="orderBy_tr" style="display: none;">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.OrderBy]*}：</td>
			<td>
				<s:select id="sortStandard" name="sortStandard"
										list="#{'00':'{*[Database]*}{*[Default]*}','01':'{*[cn.myapps.core.dynaform.view.Chinese]*}'}" theme="simple" />
				<s:select id="orderType" name="orderType"
										list="#{'ASC':'{*[asc]*}','DESC':'{*[desc]*}'}" theme="simple" />
			</td>
		</tr>
		<tr id='rftrid'>
			<td class="commFont commLabel">{*[FlowReturnCss]*}：</td>
			<td>
				<s:checkbox  name="content.flowReturnCss" id="flowReturnCss"  theme="simple" onclick="on_change(this);" />
			</td>
		</tr>
		<tr id='mftrid'>      
		    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.ImageName]*}：</td>
			<td>
			    <s:select label="{*[ImageName]*}" id="imageName" name="content.imageName" list="#{'01':'{*[Light]*}'}" emptyOption="true" theme="simple" />
			</td>
		</tr>
		<tr id='cftrid'>
			<td class="commFont commLabel">{*[Font_Color]*}：</td>
			<td>
				<input name="content.fontColor" id="fontColor"/>
				<!--<s:textfield id="fontColor" theme="simple" cssClass="input-cmd"  name="content.fontColor" onblur="colordialoghidden()" onfocus="colordialog(event);"/>
			--></td>
		</tr>
		<tr id="sftrid">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.sum]*}：</td>
			<td class="commFont">
				{*[cn.myapps.core.dynaform.view.current_page_total]*}
				<s:checkbox  name="content.sum" id="sum"  theme="simple"/>
				<span id="tftrid">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{*[cn.myapps.core.dynaform.view.Grant_Total]*}
					<s:checkbox  name="content.total" id="total"  theme="simple" />
					<span class="tipsStyle">({*[core.dynaform.view.column.total]*})</span>
				</span>
			</td>
		</tr>
		
		<tr id="icon_tr" style="display:none">
				<td class="commFont commLabel">{*[Icon]*}:</td>
				<s:hidden id="icon" name="content.icon"/>
					<td align="left" class="commFont"><img id="_iconImg" alt="" src=''>
					<input type="button" class="button-cmd" onclick="selectIcon('_iconImg', 'icon')" value="{*[Select]*}"/>
					<input type="button" class="button-cmd" onclick="cleanIcon('_iconImg', 'icon')" value="{*[Clear]*}"/>
					</td>
			</tr>
		
		<tr>
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.isVisible]*}：</td>
			<td>
				<s:checkbox name="visible" theme="simple" value="true"/>
				{*[core.dynaform.view.column.visible]*}
				<s:checkbox name="visible4ExpExcel" theme="simple" value="true"/>
				{*[core.dynaform.view.column.visible4ExpExcel]*}
				<s:checkbox name="visible4Print" theme="simple" value="true"/>
				{*[core.dynaform.view.column.visible4Print]*}
				<s:checkbox name="visible4PagePrint" theme="simple" value="true"/>
				{*[core.dynaform.view.column.visible4PagePrint]*}
			</td>
		</tr>
		<tr><td></td><td align="left"  class="tipsStyle">*{*[cn.myapps.core.dynaform.view.col_hidden_display_in_view]*}</td></tr>
		<tr id="showicon_tr">
			<td class="commFont commLabel">{*[core.dynaform.view.column.label.icon]*}：</td>
			<td>
				<s:checkbox name="showIcon" theme="simple" value="false" onclick="change4ShowIcon(this.checked)"></s:checkbox>
			</td>
		</tr>
		<tr id="showiconMapping_tr">
			<td class="commFont commLabel"></td>
			<td>
				<table style="border:dashed thin black" width="85%">
					<tbody id="_iconMapping"> 
						<tr>
							<td colspan="3" align="right"><input type="button" value="{*[Add]*}" onclick="addMappRows4icon()"/> </td>
						</tr>
						<tr>
							<th width="30%">{*[core.dynaform.view.column.icon.value]*}</th>
							<th>{*[Icon]*}</th>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<s:hidden name="iconMapping" id="iconMapping"></s:hidden>
		<tr id="astrid" style="display:none">
		    <td class="commFont commLabel">{*[ActionScript]*}：</td>
			<td>
				<s:textarea id="actionScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_after_action_script]*}*/" cssClass="input-cmd" label="{*[ActionScript]*}" name="content.actionScript" cols="60" rows="6" theme="simple"/>
				<button type="button" id="actionScriptButton" class="button-image" ><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
			</td>
		</tr>
		
		<tr id="hstrid">
		    <td class="commFont commLabel">{*[Hidden_Script]*}：</td>
			<td>
				<s:textarea id="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" cssClass="input-cmd" label="{*[Hidden_Script]*}" name="content.hiddenScript" cols="60" rows="5" theme="simple"/>
				<button type="button" id="hiddenScriptButton" class="button-image" ><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
			</td>
		</tr>
		<tr id="mfftrid">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.view.mapping_field]*}：</td>
			<td id="mapping">
				<s:select id="MappingtField" name="mappingField" cssClass="input-cmd" list="{}" theme="simple" onchange="checkField(this.value)"/>
				<label id="mapView" style="color: red"></label>
			</td>
		</tr>
	</table>
	<table id="2" width="100%" style="display:none;">
		<tr>
			<td class="commFont commLabel" width="17%">{*[Type]*}：</td>
			<td>
				<table style="border:dashed thin black;" width="80%" height="180">
					<tr>
						<td width="20%" style="border:1px solid #cccccc;">
							<s:select name="content.formatType" id="formatType" list="#helper.getFormatType()" theme="simple" onchange="formatTypeChange(this.value)"></s:select>
						</td>
						<td valign="top">
							<div id="formattype_simple">
								<fieldset>
									<legend>{*[core.dynaform.view.column.format.example]*}</legend>
									字段一
								</fieldset>
								<br>
								<br>
								<span class="tipsStyle">&nbsp;&nbsp;{*[core.dynaform.view.column.format.normal.explain]*}</span>
							</div>
							
							<div id="formattype_sum" style="display:none">
								<fieldset>
									<legend>{*[core.dynaform.view.column.format.example]*}</legend>
									<span id="exampleNum">1234</span>
								</fieldset>
								<br>
								&nbsp;&nbsp;{*[core.dynaform.view.column.format.decimals]*}:
								<s:select name="content.decimalsNum" id="decimalsNum" list="#helper.getDecimalsNum()" theme="simple" emptyOption="true" onchange="formatChange()"/><br><br>
								<s:checkbox name="content.thouSign" id="thouSign" theme="simple" onclick="formatChange()"/>&nbsp;&nbsp;{*[core.dynaform.view.column.format.thousandsign]*}<br><br>
								<span class="tipsStyle">&nbsp;&nbsp;{*[core.dynaform.view.column.format.number.explain]*}</span>
							</div>
							
							<div id="formattype_curr" style="display:none">
								<fieldset>
									<legend>{*[core.dynaform.view.column.format.example]*}</legend>
									<span id="exampleCurr">￥1234</span>
								</fieldset>
								<br>
								&nbsp;&nbsp;{*[core.dynaform.view.column.format.decimals]*}:
								<s:select name="content.decimalsCurr" id="decimalsCurr" list="#helper.getDecimalsNum()" theme="simple" emptyOption="true" onchange="formatChange4Curr()"/><br><br>
								&nbsp;&nbsp;{*[core.dynaform.view.column.format.currency.type]*}:
								<s:select name="content.currType" id="currType" list="#helper.getCurrType()" theme="simple" onchange="formatChange4Curr()"/><br><br>
								<br>
								<span class="tipsStyle">&nbsp;&nbsp;{*[core.dynaform.view.column.format.currency.explain]*}</span>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="commFont commLabel" width="17%">{*[Font]*}：</td>
			<td>
				<table style="border:dashed thin black;" width="80%" height="45">
					<tr>
						<td width="50%">{*[Color]*}：
							<input name="color" id="color" value=""></input><br/>
							{*[core.dynaform.view.column.format.color.background]*}：
							<input name="groundColor" id="groundColor" value=""></input><br/>
							{*[Size]*}：
							<s:select name="fontSize" id="fontSize" list="#helper.getFontSize()" value="12" theme="simple"/>
						</td>
						<td valign="top">
							<fieldset>
								<legend>{*[core.dynaform.view.column.format.example]*}</legend>
								<div id="exampleSpan" style="width:100%;text-align:center;background-color:#000000;font-size:2">&nbsp;&nbsp;字段一</div>	
							</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="cdtrid">
			<td class="commFont commLabel">{*[column.display.word_type]*}：</td>
			<td><s:radio name="displayType" list="#{'00':'{*[All]*}','01':'{*[Part]*}'}" 
			onclick="changeDisplayType(this.value);" theme="simple"/></td>
		</tr>
		<tr id="cdl">
			<td class="commFont commLabel">{*[column.display.word_length]*}：</td>
			<td><s:textfield name="displayLength" id="displayLength" theme="simple"/><span class="tipsStyle">{*[cn.myapps.core.dynaform.view.Required_integer]*}</span></td>
		</tr>
		
		<tr id="cstrid">
			<td class="commFont commLabel">{*[column.show.title]*}：</td>
			<td><s:checkbox name="showTitle" theme="simple"/></td>
		</tr>
</table>
</s:form>
</body>
<script>
</script>
</o:MultiLanguage>
</html>