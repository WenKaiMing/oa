<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ page buffer="50kb"%>
<%@include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>

<meta name="robots" content="noindex, nofollow" />
<link href="../sample.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./webeditor/fckeditor.js"></script>

<s:bean
	name="cn.myapps.core.deploy.application.action.ApplicationHelper"
	id="ApplicationHelper" />
<s:bean
	name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
	id="sh">
	<s:param name="applicationid" value="#parameters.application" />
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<s:bean id="fh"
	name="cn.myapps.core.dynaform.form.action.FormHelper" />
<html>
<o:MultiLanguage>
<head>
<title>{*[Form]*}{*[Info]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />'	type="text/css">
<style type="text/css">
	.listContent {float: left;}
	#act_list table td{padding-left: 3px; border: 2px solid #FFFFFF;}
</style>
	<!-- import prototype-window js lib -->
	<script type="text/javascript" src='<s:url value="/dwr/engine.js"/>'></script>
	<script type="text/javascript" src='<s:url value="/dwr/util.js"/>'></script>
	<script type="text/javascript" src='<s:url value="/dwr/interface/ActivityUtil.js"/>'></script>
	<script type="text/javascript" src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script type="text/javascript" src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
	
	<script type="text/javascript" src='dynamicTable.js'></script>
	
	<script>
var sContentPath = '<s:url value="/"/>';
var contextPath = '<%=request.getContextPath()%>';
var deleteBtn = '{*[Delete]*}';
var emptyOption = '{*[Select]*}';
var pk = '{*[PrimaryKey]*}';
var application = '<%=request.getParameter("application")%>';

var mode = 'tab1';

var wx = '480px';
var wy = '250px';
function ev_createMenu(){//生成菜单
	var formid = document.forms[0].elements['content.id'].value;
	if (formid == "") {
		alert("{*[cn.myapps.core.dynaform.form.please_save]*}");
  	}else{
		var formid = document.forms[0].elements['content.id'].value;
		var url = contextPath + "/core/dynaform/form/menu.jsp?formid=" + formid +"&application=" + application;
		//var rtn = showframe("{*[menu]*}", url);
		OBPM.dialog.show({
				opener:window.parent.parent,
				width: 600,
				height: 400,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.dynaform.form.create_menu]*}',
				close: function(rtn) {
					if(rtn != null && rtn != '')
						alert(rtn);
				}
		});
  	}
}

function ev_init(){
	var type = "<s:property value='content.type'/>";
	if(type==65536){
		document.getElementById('div_Seprate').style.display="";
		document.getElementById('div_tab5').style.display="";
	}
	changeMenu(type);
	actProcess.initList();
	var id = "<s:property value='content.id'/>";
	if (id){
	FormHelper.getAllFields(id,false, function(options) {
			//addOptions("fieldName", options);
			initfields();
			ev_switchpage(mode);
			//reSize();
			initRows(); 
			
		});
	}
}

function setActListH(){
	var bodyH = parent.document.body.clientHeight;
	var act_list = document.getElementById("act_list");
	act_list.style.height = (bodyH-85) + "px";
}

/*
function addOptions2(relatedFieldId, options, defValues){
	var el = document.getElementById(relatedFieldId);
	if(relatedFieldId){
		DWRUtil.removeAllOptions(relatedFieldId);
		DWRUtil.addOptions(relatedFieldId, options);
		if (defValues) {
			DWRUtil.setValue(relatedFieldId, defValues);
		}
		if (el.onchange && typeof(el.onchange) == "function") {
			el.onchange();
		}
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

function addFieldOptions(relatedFieldId, defValues) {

	FormHelper.getFields(document.getElementById("content.id").value, function(options){
		var oFieldSelect = document.getElementById(relatedFieldId);
		var oSelectedList = document.getElementById("selectedList");
		DWRUtil.removeAllOptions(oSelectedList.id);
		addOptions2(relatedFieldId, options, defValues);
		moveSelectedOptions(oFieldSelect, oSelectedList, false, '');
	});
}
*/

function moveup(){   
	var s =   document.all.fields;   
  	var v =   new   Array();   
    for(var i=0;i<s.length-1;i++){   
        if(!   s.options[i].selected   &&   s.options[i+1].selected){   
            v.value   =   s.options[i].value;   
            v.text   =   s.options[i].text;   
            v.selected   =   s.options[i].selected;   
            s.options[i].value   =   s.options[i+1].value;   
            s.options[i].text   =   s.options[i+1].text;   
            s.options[i].selected   =   s.options[i+1].selected;   
            s.options[i+1].value   =   v.value;   
            s.options[i+1].text   =   v.text;   
            s.options[i+1].selected   =   v.selected;   
        }   
    }   
} 

function movedown(){   
    var s = document.all.fields;
    var v = new Array();   
    for(var i = s.length-1; i > 0; i--){   
        if(!s.options[i].selected && s.options[i-1].selected){   
            v.value = s.options[i].value;   
            v.text = s.options[i].text;   
            v.selected = s.options[i].selected;   
            s.options[i].value = s.options[i-1].value;   
            s.options[i].text = s.options[i-1].text;   
            s.options[i].selected = s.options[i-1].selected;   
            s.options[i-1].value = v.value;   
            s.options[i-1].text = v.text;   
            s.options[i-1].selected = v.selected;   
        }   
    }   
}  
    
function addItem(source,target){ 
	for(var i=0;i<source.length;i++){	 
		if(source.options[i].selected==true){
			var Opt=document.createElement("option");
			Opt.value=source.options[i].value;
			Opt.text=source.options[i].text;
			var k=0;
			for(var j=0;j<target.length;j++){
			    if(source.options[i].value==target.options[j].value){
				   k=1;
				}
			}
			if(k==0){
			    target.options.add(Opt);
			    //source.options[i]="";
			}
		}	
	}
} 

function delItem(source,target){ 
	for(var x = target.length-1;x >= 0;x--){ 
		var opt = target.options[x]; 
		if (opt.selected){
			var fieldname=document.all.fieldName;
			var flag = true;
			for(var i=fieldname.length-1;i>=0;i--){
				if (fieldname.options[i].value==opt.value){
					flag=false;
					break;
				}
			}
			if (flag){
			var Opt=document.createElement("option");
			Opt.value=opt.value;
			Opt.text=opt.text;
		 	fieldname.options.add(Opt);
			}
		 	target.options[x] = null;
		} 
	}
} 

function RelStr(str){
	var test = "";
		if (str!=null && str.length>2){
			str = str.substring(1,str.length-1);
			var cols = str.split(",");
			if (cols.length>0){
				var str1 = '[';
				for (var i=0;i<cols.length;i++) {
					var col = cols[i].split(":");
					str1 += '{';
					str1 += 'fieldOrder:\''+col[0]+'\',';
					str1 += 'fieldname:'+col[1];
					str1 += '},';
				}
				if (str.lastIndexOf(',') != -1) {
					str1 = str1.substring(0, str1.length - 1);
				}
				test = str1 + ']';
			}
		}
		var obj = eval(test);
		if (obj instanceof Array) {
			return obj;
		} else {
			return new Array();	
		}
}

function createJSONStr() {
	var fields=  document.all.fields;
	if (fields){
	var str = '{';
		for (var i=0;i<fields.length;i++) {
			if (fields.options[i].value != '') {
				str += (i+1) +':\''+fields.options[i].value;
				str += '\',';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += '}';
	return str;
	}
	return "";
}

function initfields(){
	var str = document.getElementsByName('content.relationText')[0].value;
	if(str.length>0){
		var obj=RelStr(str);
		if(obj!=null){
			if(obj.length>0){
				var field=document.all.fields;
				var fieldname=document.all.fieldName;	
				for(var i=0;i<obj.length;i++){
					for(var j=0;j<fieldname.length;j++){
					if (obj[i]){
					if (fieldname.options[j].value==obj[i].fieldname)
					{
						var Opt=document.createElement("option");
						Opt.value=obj[i].fieldname;
						Opt.text=fieldname.options[j].text;
						field.options.add(Opt);
						//fieldname.options[j]="";
						break;
					}
					}
		     	}
	       	}
   		}
	}
}
}

function checkDimension() {
	var sWidth = document.body.clientWidth;
	var sHeight = document.body.clientHeight;
}

function fadein(obj) {
	obj.style.backgroundColor = "#E9E9E9";
}

function fadeout(obj) {
	obj.style.backgroundColor = "#FFF";	
}

window.onload=function(){
	ev_init();
	setActListH();
	window.top.toThisHelpPage("application_module_form_info");
	//jQuery("#save_btn").removeAttr("disabled");
	/*
	var fieldDefValues = getSelectedValuesByFiled(document.getElementById("content.summaryCfg.fieldNames"));

	addFieldOptions("fieldSelect", fieldDefValues);
	
	modeChange('<s:property value="content.summaryCfg.type" />');
	document.getElementById("selectedList").style.width=120;

	resplaceImg('<s:property value="content.summaryCfg.style" />');

	if(jQuery("#formItem_content_summaryCfg_type00").attr("checked")==false && jQuery("#formItem_content_summaryCfg_type01").attr("checked")==false){
		jQuery("#formItem_content_summaryCfg_type00").attr("checked",true);
	}
	*/
	
}

/*
function getSelectedValuesByFiled(oField, separator) {
	if (!oField) return;
	 oField.value.replace("")
	separator = separator ? separator : ";";
	var valueList = oField.value.split(separator);
	return valueList;
}
*/
function ev_switchpage(sId) {
	document.getElementById('span_tab1').className="btcaption";
	document.getElementById('span_tab2').className="btcaption";
	if (document.getElementById('span_tab3'))
		document.getElementById('span_tab3').className="btcaption";
	if (document.getElementById('span_tab4'))
		document.getElementById('span_tab4').className="btcaption";
	if (document.getElementById('span_tab5'))
		document.getElementById('span_tab5').className="btcaption";	
	if (document.getElementById('span_tab6'))
		document.getElementById('span_tab6').className="btcaption";	

	document.getElementById('tab1').style.display="none";
	document.getElementById('tab2').style.display="none";
	document.getElementById('tab3').style.display="none";
	document.getElementById('tab4').style.display="none";
	document.getElementById('tab5').style.display="none";
	document.getElementById('tab6').style.display="none";
	
	if (document.getElementById(sId)) {
		document.getElementById('span_'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
		window.top.toThisHelpPage(jQuery("#"+sId).attr("helpid"));
	}
		
	if (sId == 'tab3' || sId == 'tab4' || sId == 'tab5' || sId == 'tab6') {
		jQuery("#form_editor").css("display","none");
		if (sId == 'tab5') {
			addFldOptions(); // dynamicTable.js
		}
	}
	else {
		jQuery("#form_editor").css("display","");
	}
	mode = sId;
}

function ev_preview(){
	var formid = document.forms[0].elements['content.id'].value;
	if (formid == "") {
		alert("{*[cn.myapps.core.dynaform.view.please_save]*}");
  	}
 	else {
 	 	
    	var url = '<s:url value="/core/dynaform/document/preview.jsp" />' + '?_formid=' + formid + '&application=<%=request.getParameter("application")%>';
    	window.open(url);
 	}
}

function ev_onekeycreview(){
	var formid = document.forms[0].elements['content.id'].value;
	if(formid== ""){
		alert("{*[cn.myapps.core.dynaform.form.please_save]*}");
	}else{
		if(document.forms[0].elements['content.type'].value==256){
			alert("{*[page.core.dynaform.oneKeyCreateView]*}");
			return ;}
		var url = '<s:url action="onekeycreview" namespace="/core/dynaform/form" />' + '?_formid=' + formid+ '&application=<%=request.getParameter("application")%>&s_module=<%=request.getParameter("s_module")%>';
		window.location=url;
	}
}

function ev_cleardata(){
	var formid = document.forms[0].elements['content.id'].value;
	if(formid== ""){
		alert("{*[cn.myapps.core.dynaform.form.please_save]*}");
	}else{
	var url = '<s:url action="beforecleardata" namespace="/core/dynaform/form" />' + '?id=' + formid+ '&applicationid=<%=request.getParameter("application")%>&s_module=<%=request.getParameter("s_module")%>';
    var viewurl="<s:url action='edit'><s:param name='_currpage' value='datas.pageNo' /><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='application' value='#parameters.application'/><s:param name='s_module' value='#parameters.s_module'/></s:url>";
	OBPM.dialog.show({
				opener:window.top,
				width: 300,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.dynaform.form.clear_data]*}',
				close: function(rtn) {
				}
			});
	}
}

function ExecuteCommand( commandName )
{
	// Get the editor instance that we want to interact with.
	var oEditor = FCKeditorAPI.GetInstance('_templatecontext') ;

	// Execute the command.
	oEditor.Commands.GetCommand( commandName ).Execute() ;
}


// 重设重复的字段ID
function resetDuplicateField() {

	var oEditor = FCKeditorAPI.GetInstance("_templatecontext");
	
	if (oEditor.EditorDocument == null) {
		return;
	}
	
	var els = oEditor.EditorDocument.body.childNodes;
	
	
	var ids = [];
	if (els && els.length > 0){
		DWREngine.setAsync(false);
		for (var i=0; i<els.length; i++) {
			var tagName = els[i].tagName ? els[i].tagName.toUpperCase() : "";
			if ((tagName == 'INPUT' || tagName == 'TEXTAREA' || tagName == 'SELECT' || tagName == 'IMG') 
				&& ids.indexOf(els[i].id) != -1) { 
				// reset ID
				Sequence.getSequence(function(id) {
					els[i].id = id;
				});
			}
			ids.push(els[i].id);
		}
		DWREngine.setAsync(true);
	}
}

// 重设所有表单字段ID
function resetAllFieldId(){
	if (confirm("{*[confirm.reset.all.field.id]*}")) {
		var oEditor = FCKeditorAPI.GetInstance("_templatecontext");
	
		if (oEditor.EditorDocument == null) {
			return;
		}	
		var els = oEditor.EditorDocument.body;
		DWREngine.setAsync(false);
		recursion(els);
			alert("{*[reset.field.id.success]*}!");
	}
}

function recursion(obj){
	var childObjs = obj.childNodes;
	for(var i=0; i<childObjs.length; i++){
		if(childObjs[i].tagName&&childObjs[i].tagName>0){
			childObjs[i].tagName = childObjs[i].tagName.toUpperCase();
		}
		if (childObjs[i].tagName == 'INPUT' || childObjs[i].tagName == 'TEXTAREA' || childObjs[i].tagName== 'SELECT' || childObjs[i].tagName == 'IMG') {
			// reset ID
			Sequence.getSequence(function(id) {
				childObjs[i].id = id;
			});
		}else{
			recursion(childObjs[i]);
			}	
	}
}

function ev_save() {
	
	var tempname = document.getElementsByName('content.name')[0].value;
	if(tempname == ''){
		showMessage("error", "{*[page.name.notexist]*}");
		return false;
	}
	//为映射表单时,保存前所做的校验
	var bool = mappingFieldValidation();
	if(typeof bool != 'undefined' && !bool){
		return false;
	}
	if(checkIsNumber()){
		preparation();

		//Alvin
		//把FCK的值放到content中，再将FCK的值去掉。因为FCK的值是对象，使用关键字时会造成冲突。
		document.getElementsByName('content.templatecontext')[0].value= FCKeditorAPI.GetInstance("_templatecontext").GetXHTML(true);
		document.getElementsByName('_templatecontext')[0].value ="";
		
		//去除标签，防止关键字字符保存冲突
	    jQuery("#optionsDiv").remove();
		document.forms[0].action='<s:url action="save"></s:url>';
		document.forms[0].submit();
	}
}
function preparation(){
	DWREngine.setAsync(false);
	// 1. parse activity array to xml and set value to textarea
	ActivityUtil.parseObject(activityCache, function(xml){
		DWRUtil.setValue('activityXML', xml);
	});
	
	// 2. update all field's id
	resetDuplicateField();
	
	// 3.parse SMFieldNames to string and set value to content.relationText
	document.getElementById("relationTextId").value = createJSONStr();
	setMappingStr(); // dynamicTable.js

	//4.parse document summary config 
	/*
	 var oSel = document.getElementById("selectedList");
	 var oField = document.getElementById("content.summaryCfg.fieldNames");
	 setSelectedValuesToField(oField, oSel);
	 */
	
	// 5. check some changes of form.
}

// sort by element order number
function sortByOrder(obj, anObj){
	return obj.orderno - anObj.orderno;
}
	
// swap element order number
function swap(obj, anObj){
	var tempOrderno = obj.orderno;
	obj.orderno = anObj.orderno;
	anObj.orderno = tempOrderno;
}


function changeMenu(s){
	var id = '<s:property value="content.id"/>';
	document.getElementById('permission_type_lable').style.display="inline";
	document.getElementById('permission_type_option').style.display="inline";
	document.getElementById('scriptLabel').style.display="";
	document.getElementById('scriptContent').style.display="";
	document.getElementById('isDisplayLog').style.display="";
	document.getElementById('displayLabel').style.display="";
	document.getElementById('layoutType_Div_label').style.display="";
	document.getElementById('layoutType_Div').style.display="";
	if(s==1){
		if(id && id.length>0){
			document.getElementById('div_Seprate1').style.display="none";
			document.getElementById('div_tab6').style.display="inline";
		}
	}else {
		document.getElementById('div_Seprate').style.display="none";
		if(id && id.length>0){
			document.getElementById('div_tab6').style.display="none";
		}
	}
	
	if(s==65536){
		document.getElementById('div_Seprate1').style.display="inline";
		document.getElementById('div_tab5').style.display="inline";
		document.getElementById('div_tab6').style.display="inline";
	}else{
		document.getElementById('div_Seprate').style.display="none";
		document.getElementById('div_tab5').style.display="none";
	}
	document.getElementById("tip_isshowlog").style.display="none";
	if(s==1048576){
		document.getElementById("tip_isshowlog").style.display="block";
	}
	if(s==256 || s==2){
		document.getElementById('permission_type_lable').style.display="none";
		document.getElementById('permission_type_option').style.display="none";
		document.getElementById('div_tab_act').style.display="none";
		document.getElementById('div_seprate_act').style.display="none";
		document.getElementById('layoutType_Div_label').style.display="none";
		document.getElementById('layoutType_Div').style.display="none";
	}else{
		document.getElementById('div_tab_act').style.display="";
		document.getElementById('div_seprate_act').style.display="";
	}
	if(s==2){
		document.getElementById('scriptLabel').style.display="none";
		document.getElementById('scriptContent').style.display="none";
		document.getElementById('isDisplayLog').style.display="none";
		document.getElementById('displayLabel').style.display="none";
	}
	if(s==256 || s==1048576 || s==2){
		jQuery("#createMenu_btn").attr("disabled",true);
		jQuery("#clean_data_btn").attr("disabled",true);
		jQuery("#layoutType_Div").attr("disabled",true);
	}else{
		jQuery("#createMenu_btn").attr("disabled",false);
		jQuery("#clean_data_btn").attr("disabled",false);
	}
	if(s==1048576 || s==2){
		jQuery("#OneKey_Creview_btn").attr("disabled",true);
	}else{
		jQuery("#OneKey_Creview_btn").attr("disabled",false);
	}
	if (s == 1 || s == 65536 || s == 1048576) {
		jQuery("td#showWaterMark").show();
		jQuery("td#waterMarkScript").show();
	} else {
		jQuery("td#showWaterMark").hide();
		jQuery("td#waterMarkScript").hide();
	}
}

function synchronouslyData(){
	    var formid = document.forms[0].elements['content.id'].value;
	    var tableName = document.getElementById("tableName").value;
	    var domainName = document.getElementById("domainName").value;
        if (formid == "" ) {
		    alert("{*[cn.myapps.core.dynaform.form.please_save]*}");
		    return ;
	    }else if(tableName == null || tableName ==""){
		    alert("{*[please.select]*}{*[Database]*}{*[Table]*}");
		    return ;
	    }else{
	    	if(PKchanged()){
			    var url = contextPath + '/core/dynaform/form/selectDomain.jsp?application='+application;
//			    var value= window.showModalDialog(contextPath + '/frame.jsp?title={*[synchronouslyData]*}',
//					    url, 'font-size:9pt;dialogWidth:' + 300 + 'px;dialogHeight:'
//					    + 150 + 'px;status:no;scroll=no;');
				OBPM.dialog.show({
					width : 300, // 默认宽度
					height : 150, // 默认高度
					url : url,
					args : {},
					title : '{*[synchronouslyData]*}',
					close : function(result) {
						var value = result;
					    document.getElementById("domainName").value=value;
					    if(value == "" || value == null || value == 'undefined'||document.getElementById("domainName").value==""){
						    alert("{*[please.select]*}{*[Domain]*}");
						    return ;
					    }else if(value =='canel'){
						    return ;
					    }else{
					    	document.getElementById("loadingDivBack").style.display = 'block';
						    document.getElementById("loadingDiv").style.display = 'block';
				 		    document.forms[0].action='<s:url action="synchronouslyData"></s:url>';
				 		    document.forms[0].submit();
					    }
					}
				});
	    	}
 	    }
}

//为映射表单时,保存前所做的校验
function mappingFieldValidation(){
	var type = "<s:property value='content.type'/>";
	if(document.forms[0].elements['content.type'].value==65536){
	    var mfields = document.getElementsByName("mFieldName");
		if (window.frames[0] && window.frames[0].frames[0]) {
			var fields = window.frames[0].frames[0].document.body.all;
			if (fields && fields.length > 0) {
				for (var i = 0; i < fields.length; i++) {
					var field = fields[i];
					if (field.name) {
						var temp = false;
					    for(var j = 0; j<mfields.length; j++){
					        if(mfields[j].value == field.name){
						        temp = true;
						        break;
						    }
					    }
					    if(!temp){
						    alert("{*[cn.myapps.core.dynaform.form.complete_all_mapped_fields]*}");
						    return false;
						}
					}
				}
			}
		}
	}
}

function dupFieldValidation(obj){
	var mark = obj.id.substr(5)-1;
    var fields = document.getElementsByName("mFieldName");
    for(i = 0; i<fields.length; i++){
        temp= fields[i].value;
        if(temp!="" && mark!=i && temp==obj.value){
            alert("该字段已被占用!");
            obj.value = ""; 
            break;
        }
    }
}

function dupColumnNameValidation(obj){
	var mark = obj.id.substr(6)-1;
    var fields = document.getElementsByName("mColumnName");
    for(i = 0; i<fields.length; i++){
        temp= fields[i].value;
        if(temp!="" && mark!=i && temp==obj.value){
            alert("该列已被占用!");
            obj.value=obj.value;
            break;
        }
    }
}

function PKchanged(){
	var Oldmid = document.getElementById("mappingID").value;
    var field = document.getElementsByName("mFieldName");
    var column = document.getElementsByName("mColumnName");
    var mark = -1;
	for(i=0;i<field.length;i++){
		if(field[i].value=="MAPPINGID"){
			mark = i;
		}
    }
    if(-1!=mark){
        var Newmid = column[mark].value;
        if(Newmid!=""){
            if(Oldmid!=Newmid){
             	alert("主键对应列已修改, 请保存表单后再进行同步数据操作。");
             	 return false;
            }
        }else{
            alert("请选择映射主键!");
            return false;
        }
    }else{
        alert("请选择映射主键!");
        return false;
    }
    return true;
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
/*
function setSelectedValuesToField(oField, oSel, separator){
	if (!oField || oSel.options.length == 0){
		oField.value ="";
		 return;
	}
	separator = separator ? separator : ";";
	oField.value = '';
	for (var i=0; i<oSel.options.length; i++) {
		var option = oSel.options[i];
		oField.value += option.value + separator;
		
	}
	oField.value = oField.value.substring(0, oField.value.length-1);
}

*/
/*
 * 签入
 */
function ev_checkin(){
	preparation();
	document.forms[0].action='<s:url action="checkin"></s:url>';
	document.forms[0].submit();
}
/*
 * 签出
 */
function ev_checkout(){
	preparation();
	document.forms[0].action='<s:url action="checkout"></s:url>';
	document.forms[0].submit();
}

function refreshSummary(){
	var url = '<s:url value='/core/dynaform/summary/summaryList.action'/>?sm_formId=<s:property value="content.id" />&_applicationid=<s:property value="%{#parameters.application}"/>';
	var frame = document.getElementById("summaryList");
	frame.src=url;
	window.setTimeout("",0);
	window.status="完成";
	ev_switchpage('tab6');
}

//检查排序号是否为数字类型
function checkIsNumber(){
	var obj = document.getElementsByName('content.orderno');
	var regex = /^[0-9]*$/;
	if(regex.test(obj[0].value)){
		return true;
	}else{
		alert("{*[page.user.orderbyno.legal]*}!");
		return false;
	}
}

function showScriptTips(){
	document.getElementById("iseditableScriptTips").style.display='';
}

function hideScriptTips(){
	document.getElementById("iseditableScriptTips").style.display="none";
}
</script>
</head>
</o:MultiLanguage>
<body id="application_module_form_info" class="contentBody">
<input type="hidden" id="mark4Fckeditor" value="form" />
<!-- -aimar-加上id为"application"的<hidden>元素以修复在ff下不显示fckeditor的bug -->
<input type="hidden" id="application" value='<%=request.getParameter("application")%>'/>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="27px;" valign="top" align="left">
		<o:MultiLanguage>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="nav-s-td">
							<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td style="padding-left: 10px;min-width: 200px;">
									<div id="sec_tab1">
									<div class="listContent"><input type="button"
										id="span_tab1" name="spantab1" class="btcaption"
										onClick="ev_switchpage('tab1')" value="{*[Basic]*}" /></div>
									<div class="listContent nav-seperate"><img
										src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
									</div>
									<div class="listContent"><input type="button"
										id="span_tab2" name="spantab2" class="btcaption"
										onclick="ev_switchpage('tab2')" value="{*[Format]*}" /></div>
									<s:if test="content.id!=null && content.id!=''">
										<div class="listContent nav-seperate"><img
											src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
										</div>
										<div class="listContent" id="div_tab_act"><input type="button"
											id="span_tab3" name="spantab3" class="btcaption"
											onClick="ev_switchpage('tab3')" value="{*[Activity]*}" /></div>
										<div class="listContent nav-seperate" id="div_seprate_act"><img
											src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
										</div>
										<div class="listContent nav-seperate" id="div_Seprate" style='display:none;'><img
											src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
										</div>
										<s:if test="content.type==1">
										<div class="listContent" id="div_tab6" style="display:inline;"><input type="button"
												id="span_tab6" name="spantab6" class="btcaption"
												onClick="ev_switchpage('tab6')" value="{*[core.workflow.storage.runtime.intervention.summary]*}" />
											</div>
											</s:if>
											<s:else>
												<div class="listContent" id="div_tab6" style="display:none;"><input type="button"
												id="span_tab6" name="spantab6" class="btcaption"
												onClick="ev_switchpage('tab6')" value="{*[core.workflow.storage.runtime.intervention.summary]*}" />
											</div>
											</s:else>
									</s:if></div>
									<!-- 分隔线 -->			
										<div class="listContent nav-seperate" id="div_Seprate" style='display:none;'><img
											src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
										</div>
										<div class="listContent nav-seperate" id="div_Seprate1" style='display:none;'><img
											src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
										</div>
										<div class="listContent" id="div_tab5" style='display:none;'><input type="button"
											id="span_tab5" name="spantab5" class="btcaption"
											onClick="ev_switchpage('tab5')" value="{*[Mapping]*}" /></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td class="nav-s-td" align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<s:if test="checkoutConfig == 'true'">
							<s:if test="content.id !=null && content.id !='' && !content.checkout">
							<!-- 签出按钮 -->
							<td align="left">
								<button type="button" class="button-image" style="width:50px" onClick="ev_checkout()"><img
									src="<s:url value="/resource/imgnew/act/checkout.png" />"
									align="top">{*[core.dynaform.form.checkout]*}</button>
								</td>
							</s:if>
							<s:elseif test="content.id !=null && content.id !='' && content.checkout && #session['USER'].id == content.checkoutHandler">
							<!-- 签入按钮 -->
							<td align="left">
								<button type="button" class="button-image" style="width:50px" onClick="ev_checkin()"><img
									src="<s:url value="/resource/imgnew/act/checkin.png" />"
									align="top">{*[core.dynaform.form.checkin]*}</button>
								</td>
							</s:elseif>
							</s:if>
						
							<td align="left">
							<button type="button" class="button-image" title="{*[Preview]*}" style="width:60px" onClick="ev_preview()"><img
								src="<s:url value="/resource/imgnew/act/preview.gif" />"
								align="top">{*[Preview]*}</button>
							</td>
							<td align="left">
								<button type="button" id="createMenu_btn" class="button-image" title="{*[cn.myapps.core.dynaform.form.create_menu]*}" style="width:85px" onClick="ev_createMenu()">
									<img src='<s:url value="/resource/imgnew/act/act_2.gif" />'/>{*[cn.myapps.core.dynaform.form.create_menu]*}
								</button>
							</td>
							<td align="left">
							<button type="button" class="button-image" title="{*[cn.myapps.core.dynaform.form.reset_field_id]*}" style="width:100px" onClick="resetAllFieldId()">
								<img src="<s:url value="/resource/imgnew/act/reset.gif" />"
								align="top">{*[cn.myapps.core.dynaform.form.reset_field_id]*}</button>
							</td>
							<td align="left">
							<button type="button" id="clean_data_btn" class="button-image" title="{*[cn.myapps.core.dynaform.form.clear_data]*}" style="width:80px" onClick="ev_cleardata()"><img
								src="<s:url value="/resource/imgnew/act/act_3.gif" />"
								align="top">{*[cn.myapps.core.dynaform.form.clear_data]*}</button>
							</td>
						    <td align="left">
							<button type="button" id="OneKey_Creview_btn" class="button-image" title="{*[OneKey_Creview]*}" style="width:100px" onClick="ev_onekeycreview()"><img
								src="<s:url value="/resource/imgnew/act/act_7.gif" />"
								align="top">{*[OneKey_Creview]*}</button>
							</td>
							<s:if test="checkoutConfig == 'true'">
							<s:if test="(content.checkout && #session['USER'].id == content.checkoutHandler) || (!content.checkout && content.checkoutHandler == null)">
							<!-- 签出 -->
							<td align="left">
								<button type="button" id="save_btn" title="{*[Save]*}" style="width:50px" class="button-image" onClick="ev_save()">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
							</s:if>
							<s:elseif test="content.checkout && #session['USER'].id != content.checkoutHandler">
							<!-- 签入-->
							<td align="left">
								<button type="button" id="save_btn" title="{*[Save]*}" style="width:50px" class="button-image" disabled="disabled" onClick="ev_save()">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
							</s:elseif>
							<s:if test="!content.checkout && ( content.checkoutHandler == '')">
							<!-- 没有签出-->
							<td align="left">
								<button type="button" id="save_btn" title="{*[Save]*}" style="width:50px" class="button-image"  onClick="alert('{*[message.update.before.checkout]*}')">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
							</s:if>
							</s:if>
							<s:else>
								<td align="left">
								<button type="button" id="save_btn"  title="{*[Save]*}" style="width:50px" class="button-image" onClick="ev_save()">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
							</s:else>
							<td align="left">
							<button type="button" class="button-image" title="{*[Exit]*}" style="width:50px"
								onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();">
							<img align="top"
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
							</td>
						</tr>
					</table>
		
					</td>
				</tr>
			</table>
		</o:MultiLanguage>
	</td></tr>
	<tr><td valign="top" align="left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<o:MultiLanguage>
					<%@include file="/common/msg.jsp"%>
					<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
					<%@include file="/portal/share/common/msgbox/msg.jsp"%>
					</s:if>
				</o:MultiLanguage>
			</td>
		</tr>
	</table>
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td class= "chromePositionCls">
			<s:form id="formItem" cssStyle="height:100%;" action="save" method="post" theme="simple">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				
					<o:MultiLanguage>
					<%@include file="/common/page.jsp"%>
					<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
					<s:hidden name='content.version' />
					<s:hidden name="content.titlescript" />
					<s:hidden name='content.checkout' />
					<s:hidden name="content.checkoutHandler" />
		
					<input type="hidden" name="s_module"
						value="<s:property value='#parameters.s_module'/>"/>
					<input type="hidden" name="moduleid" id="moduleid"
						value="<s:property value='#parameters.s_module'/>"/>
					<s:textarea id="activityXML" name="content.activityXML"
						cssStyle="display:none" />
		
					<tr id="tab1" helpid="application_module_form_info" valign='top'>
						<td style="padding-left: 10px;padding-top: 10px;">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" class="id1">
							<tr class="seperate">
								<td class="commFont">{*[Name]*}:</td>
								<td id="displayLabel" class="commFont" style="word-wrap: break-word; word-break: break-all; ">{*[cn.myapps.core.dynaform.form.label.showlog]*}: <div id="tip_isshowlog" style="display: none;width:270px;" class="tipsStyle">{*[cn.myapps.core.dynaform.form.tip.showlog]*}</div></td>
							</tr>
							<tr>
								<td align="left">
								<s:if test="content.name==null">
									<s:textfield id="name" cssClass="input-cmd" name="content.name" theme="simple" />
								</s:if>
								<s:else>
									<s:textfield id="name" cssClass="input-cmd" cssStyle="color:gray" name="content.name" theme="simple" readonly="true"/>
								</s:else>
								</td>
								<td id="isDisplayLog"><!--<s:checkbox name="_isDisplayLog" theme="simple" />-->
								<s:radio name="_isDisplayLog" theme="simple"
									list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}"></s:radio>
								</td>
							</tr>
							<tr>
								<td class="commFont">{*[Type]*}:</td>
								<td class="commFont"><span id="permission_type_lable">{*[cn.myapps.core.dynaform.form.page.label.permission_type]*}</span></td>
							</tr>
							<tr>
								<td align="left"><s:select name="content.type" onchange="changeMenu(this.value)"
									cssClass="input-cmd" list="_FORMTYPE" theme="simple" /></td>
								<td><div id="permission_type_option"><s:radio
							name="content.permissionType" theme="simple"
							list="#{'public':'{*[cn.myapps.core.dynaform.form.attr.permission_type.public]*}','private':'{*[cn.myapps.core.dynaform.form.attr.permission_type.private]*}'}"  /></div></td>
							</tr>
							<tr class="seperate">
								<td class="commFont">{*[StyleLib]*}:</td>
								<td class="commFont" id='layoutType_Div_label'>{*[cn.myapps.core.dynaform.form.label.layoutType]*}:</td>
							</tr>
							<tr>
								<td><s:select cssClass="select-size input-cmd"
									label="{*[StyleLib]*}" name="_styleid"
									list="#sh.get_listStyleByApp(#parameters.application)"
									listKey="id" listValue="name" emptyOption="true" theme="simple" /></td>
								<td style="vertical-align: top;">
								<div id="layoutType_Div">
										<s:radio name="content.layoutType" theme="simple"
							                list="#{'horizontal':'{*[cn.myapps.core.dynaform.form.label.layoutType.horizontal]*}','vertical':'{*[cn.myapps.core.dynaform.form.label.layoutType.vertical]*}'}"/></div></td>
									</div>
								</td>
							</tr>
							<tr class="seperate">
								<td class="commFont">{*[Form]*}{*[OrderNumber]*}:</td>
								<td class="commFont" id="showWaterMark">{*[是否显示水印]*}:<span style="color:green;">*只支持H5和DWZ皮肤</span></td>
							</tr>
							<tr>
								<td><s:textfield cssClass="input-cmd"
									name="content.orderno" theme="simple" /></td>
								<td id="showWaterMark"><s:radio name="content.showWaterMark" theme="simple"
									list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}"></s:radio>
								</td>
							</tr>
							<!-- <tr>
							   	<td class="commFont commLabel">{*[Leave]*}{*[Tips]*}:</td> 
							    <td><s:checkbox name="_Tips" theme="simple"/></td>
							</tr> -->
							<tr class="seperate" id="scriptLabel">
								<td class="commFont">{*[cn.myapps.core.dynaform.form.label.isOpenAbleScript]*}:   <button type="button" class="button-image" onclick="openIscriptEditor('content.isopenablescript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.label.isOpenAbleScript]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[cn.myapps.core.dynaform.form.label.isOpenAbleScript]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td>
								<td class="commFont" id="waterMarkScript">{*[水印脚本]*}:
								<button type="button" class="button-image" onclick="openIscriptEditor('content.waterMarkScript','{*[Script]*}{*[Editor]*}','{*[水印脚本]*}','content.name','{*[Save]*}{*[Success]*}');">
								<img alt="{*[水印脚本]*}" src="<s:url value='/resource/image/editor.png' />"/>
								</button>
								</td>
							</tr>
							<tr id='scriptContent'>
								<td><s:textarea onmousedown="showScriptTips()" onmouseout="hideScriptTips()" theme="simple" cssClass="input-cmd"
									name="content.isopenablescript" rows="4"></s:textarea>
									</td>
								<td id="waterMarkScript"><s:textarea theme="simple" cssClass="input-cmd"
									name="content.waterMarkScript" rows="4"></s:textarea>
								</td>	
							</tr>
							<tr class="seperate" id="scriptLabel">
								<td class="commFont">{*[cn.myapps.core.dynaform.form.label.IsEditAbleScript]*}:   <button type="button" class="button-image" onclick="openIscriptEditor('content.iseditablescript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.label.IsEditAbleScript]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[cn.myapps.core.dynaform.form.label.IsEditAbleScript]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td>
								<td class="commFont"></td>
							</tr>
							<tr id='scriptContent'>
								<td><s:textarea theme="simple" cssClass="input-cmd"
									name="content.iseditablescript" rows="4"></s:textarea>
									</td>	
								<td></td>
							</tr>
							
							<tr id="iseditableScriptTips" style="display: none" >
								<td><span class="tipsStyle">{*[cn.myapps.core.dynaform.form.tip.isEditAbleScriptTips]*}</span>
									</td>
							</tr>
							<tr class="seperate">
								<td class="commFont">{*[Description]*}:</td>
								<td></td>
							</tr>
							<tr id='discriptionContent'>
								<td align="left" colspan="2">
									<s:textarea rows="10" cssClass="input-cmd" cssStyle="width:700px" name="content.discription" theme="simple" /></td>
								<td></td>	
							</tr>
					<!-- 原来放文档摘要配置的地方 -->
					
						</table>
						
						</td>
					</tr>
					</o:MultiLanguage>
					
					<tr id='tab2' helpid="application_module_form_info_advance" style='display: none' valign="top" height="100%">
						<td>
						<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" align="center">
							<tr valign="top">
								<td height="100%">
								<div id="form_editor"  style="height:100%;overflow: hidden">
								<div id="eWebEditor" name="eWebEditor" style="height:100%;">
								
								<s:hidden name="content.templatecontext"
									theme="simple" />
								<textarea name="_templatecontext"><s:property value="content.templatecontext" /></textarea>
								<script type="text/javascript">
									var sBasePath = '<s:url value="/core/dynaform/form/webeditor/"/>';
									var oFCKeditor = new FCKeditor("_templatecontext");
									//oFCKeditor.ToolbarSet = "myeditor";
									oFCKeditor.BasePath	= sBasePath;
									oFCKeditor.Height	= "100%";
									oFCKeditor.ReplaceTextarea();
								</script>
								</div>
								</div>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<o:MultiLanguage>
					<tr id="tab3" helpid="application_module_form_info_activity" style="display: none; vertical-align: top;">
						<td width="100%">
						
						<script type="text/javascript">
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
							var formid='<s:property value='content.id'/>';
							var url= '<s:url value="/core/dynaform/activity/content.jsp" />?application='+applicationid+'&_formid='+formid+'&s_module='+s_moduleid;
							OBPM.dialog.show({
									opener:window.parent.parent,
									width: 600,
									height: 500,
									url: url,
									args: {"parentObj":window,"application":applicationid,"_formid":formid,"s_module":s_moduleid},
									title: '{*[New]*}{*[Activity]*}{*[ButtonField]*}',
									maximized: false, // 是否支持最大化
									close: function(result) {
										window.top.toThisHelpPage("application_module_form_info_activity");
									}
								});
							
						  	this.refreshList(activityCache);
						}
						ActivityProcess.prototype.doEdit = function(index) {
							var s_moduleid='<%=request.getParameter("s_module")%>';
							var applicationid='<%=request.getParameter("application")%>';
							var formid='<s:property value='content.id'/>';
							var url= '<s:url value="/core/dynaform/activity/content.jsp" />?application='+applicationid+'&_formid='+formid+'&s_module='+s_moduleid+'&index=' + index;
							OBPM.dialog.show({
									opener:window.parent.parent,
									width: 600,
									height: 500,
									url: url,
									args: {"parentObj":window,"application":applicationid,"_formid":formid,"s_module":s_moduleid},
									title: '{*[Edit]*}{*[Activity]*}{*[ButtonField]*}',
									maximized: false, // 是否支持最大化
									close: function(result) {
										window.top.toThisHelpPage("application_module_form_info_activity");
									}
								});
							this.refreshList(activityCache);
						}
						ActivityProcess.prototype.doDelete = function() {
							if(isSelectedOne("activitySelects","{*[please.choose.one]*}")){
								var activitySelects = document.getElementsByName("activitySelects");
								for (var n=0; n<activitySelects.length; n++) {
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
						}
						
						ActivityProcess.prototype.doOrderChange = function(index, type) {
							switch(type){
								case 'p' :
								if (index != 0) {
									var activity = activityCache[index];
									var previousActivity = activityCache[index-1];
									swap(activity, previousActivity);
									this.refreshList(activityCache);
								}
								break;
								case 'n' :
								if (index != activityCache.length - 1) {
									var activity = activityCache[index];
									var nextActivity = activityCache[index+1];
									swap(activity, nextActivity);
									this.refreshList(activityCache);
								}
								break;
							}
						}
						var activityCache = [];
						var actProcess = new ActivityProcess();
						</script>
						<table width="100%" class="table_noboder">
							<tr><td>
								<button type="button" class="button-class" onClick="actProcess.doCreate()"
											title="{*[Create]*}"><img border="0"
											SRC="<s:url value='/resource/imgnew/act/act_2.gif'></s:url>"
											alt="{*[Create]*} {*[Activity]*}">{*[Create]*}</button>
								<button type="button" class="button-class" onClick="actProcess.doDelete()"
											title="{*[Delete]*}"><img border="0"
											SRC="<s:url value='/resource/imgnew/act/act_3.gif'></s:url>"
											alt="{*[Remove]*} {*[Activity]*}">{*[Delete]*}</button>
							</td></tr>
							<tr>
							<td style="width: 100%; vertical-align: top;text-align: left;">
								<div id="act_list" style="border: 0px solid;overflow-y:auto;">&nbsp;</div>
							</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id='tab4' style='display: none' valign="top">
						<td colspan="4" height="20">
						<table width="100%">
							<tr>
								<td>
								<fieldset style="HEIGHT: 60px"><legend>{*[Basic]*}</legend>
								<table class="id1" width="80%">
									<tr>
										<td class="commFont">{*[Relation]*}{*[Name]*}:</td>
										<td class="commFont">{*[OnSaveStartFlow]*}:</td>
									</tr>
									<tr>
										<td><s:textfield cssClass="input-cmd"
											name="content.relationName" theme="simple" /></td>
										<td><s:radio name="_isOnSaveStartFlow" theme="simple"
											list="#{'false':'{*[No]*}','true':'{*[Yes]*}'}"></s:radio></td>
									</tr>
								</table>
								</fieldset>
								</td>
							</tr>
							<tr>
								<td>
								<fieldset style="HEIGHT: 300px"><legend>{*[Configurations]*}</legend>
								<table style="width: 80%;" border="1">
									<tbody id="tb">
										<tr>
											<td colspan="2" align="center">
											<table>
												<tr>
													<td class="commFont">{*[FormField]*}</td>
													<td></td>
													<td class="commFont">{*[SelectField]*}</td>
												</tr>
												<tr>
													<td height="60" class="tdLabel"><select id="fieldName"
														name="fieldName" size="15" multiple="multiple"
														style="width: 10em"
														ondblclick="addItem(document.all.fieldName,document.all.fields)">
													</select></td>
													<td bgcolor="#FFFFFF">
													<p align="center">
													<button type="button" class="button-image" onClick="moveup()"><img
														src="<s:url value="/resource/image/up2.gif"/>"
														alt="{*[Move_Up]*}"></button>
													</p>
													<p align="center">
													<button type="button" class="button-image"
														onClick="addItem(document.all.fieldName,document.all.fields)"><img
														src="<s:url value="/resource/image/right2.gif"/>"
														alt="{*[Add]*}{*[Item]*}"></button>
													</p>
													<p align="center">
													<button type="button" class="button-image"
														onClick="delItem(document.all.fieldName,document.all.fields)"><img
														src="<s:url value="/resource/image/left2.gif"/>"
														alt="{*[Delete]*}{*[Item]*}"></button>
													</p>
													<p align="center">
		
													<button type="button" class="button-image" onClick="movedown()"><img
														src="<s:url value="/resource/image/down2.gif"/>"
														alt="{*[Move_Down]*}"></button>
													</p>
													</td>
													<td height="60" class="tdLabel">
													<div align="center"><select id="selectid" name="fields"
														size="15" multiple style="width: 10em"
														ondblClick="delItem(document.all.fieldName,document.all.fields)">
													</select></div>
													</td>
												</tr>
											</table>
											</td>
										</tr>
									</tbody>
								</table>
								</fieldset>
								<s:textarea id="relationTextId" cssStyle="display:none"
									cssClass="input-cmd" name="content.relationText" cols="103"
									rows="2"></s:textarea></td>
							</tr>
		
						</table>
						</td>
					</tr>
					<!-- 映射 -->
					<tr id='tab5' helpid="application_module_form_info_mapping" style='display: none' valign="top">
						<s:hidden id="mappingStr" name="content.mappingStr" />
		
						<td colspan="4" height="20">
						<table width="100%">
							<tr>
								<td>
								<fieldset style="HEIGHT: 60px"><legend>{*[Basic]*}</legend>
								<table class="id1" width="80%">
									<tr>
										<td class="commFont">{*[Database]*}{*[Table]*}{*[Name]*}:</td>
										<td class="commFont">{*[synchronouslyData]*}:</td>
									</tr>
									<tr>
										<td><s:select cssClass="input-cmd" id="tableName"
											name="content.tableName"
											list="#fh.getDataBaseTableMap(#parameters.application)"
											theme="simple" onchange="addColOptions(true)" cssStyle="width:90%"/>
									</td>
									<td>
									    <input type="hidden" id="domainName" name="domainName"/>
									    <input type="hidden" id="mappingID" name="mappingID"/>
										<button type="button" onclick="synchronouslyData()"><img border=0 alt="{*[synchronouslyData]*}" src="<s:url value='/resource/image/synchronouslyData.png'/>"/>{*[synchronouslyData]*}</button>
									</td>
									</tr>
								</table>
								</fieldset>
								</td>
							</tr>
		
							<tr>
								<td>
								<fieldset style="HEIGHT: 300px"><legend>{*[Configurations]*}</legend>
								<table style="width: 100%;" border="0">
									<tr><td align="right" colspan="3" style="height:50px">
										<input type="button" value="{*[Add]*}" onclick="addRows()" />
									</td></tr>
									<tr><td style="height:200px">
									<div style="overflow:auto;height:250px">
									<table style="width: 80%;">
										<tbody id="mappingtb">
											<tr>
												<td>{*[cn.myapps.core.dynaform.form.field_name]*}</td>
												<td>{*[cn.myapps.core.dynaform.form.ColumnName]*}</td>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
									</div>
									</td></tr>
								</table>
								</fieldset>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr style='display: none' valign="top" height="100%">
					<div id="tab6" helpid="application_module_form_info_advance" style="z-index: -1;display: none;" >
						<iframe scrolling="no" id="summaryList" name="summaryList" border="0" 
							src="<s:url value='/core/dynaform/summary/summaryList.action'/>?sm_formId=<s:property value="content.id" />&_applicationid=<s:property value="%{#parameters.application}"/>"
							width="100%" height="500" frameborder="0" /></iframe>
					</div>
					</tr>
					</o:MultiLanguage>
				
			</table>
			</s:form>
			</td></tr>
		</table>
		</td>
	</tr>
</table>
</div>
<DIV ID="loadingDiv"
		STYLE="position: absolute; z-index: 100; width: 60%; height: 60%; left: 40%; top: 40%; display: none;">
	<table>
		<tr>
			<td><img src="<s:url value="/resource/imgnew/loading.gif"/>"></td>
			<td><b><font size='3'>数据导入中...</font> </b></td>
		</tr>
	</table>
	</DIV>
	<div id="loadingDivBack"
		style="position: absolute; z-index: 50; width: 104%; height: 100%; top: 0px; left: 0px; display: none; background-color:#DED8D8; filter: alpha(opacity = 20); opacity: 0.20;">
	</div>
</body>
</html>