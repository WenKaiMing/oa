<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<STYLE type=text/css>
#tb td{text-align:center;}
</STYLE>

<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

function cardClick(cardID){
	var obj;
	for (var i=1;i<3;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<3;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.TabField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	
	//alert(createRelStr());
	
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/tabfield/tabfield.gif",
		type:"tabfield",
		classname: className,
		id: id,
		relStr: createRelStr(),
		showMode: temp.showMode.value,
		openAll: temp.openAll.value,
		selectedScript: HTMLEncode(temp.selectedScript.value)
	});
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	try{
		if (oActiveEl){
		   	var relStr = oActiveEl.getAttribute('relStr');
			var datas = parseRelStr(relStr);
			//兼容旧数据没有hiddenPrintScript、readOnlyScript
			for(var i=0; i<datas.length; i++){
				if(datas[i].hiddenPrintScript==undefined){
					datas[i].hiddenPrintScript="";
				}
				if(datas[i].readOnlyScript == undefined){
					datas[i].readOnlyScript="";
				}
			}
			addRows(datas,relStr);
			temp.showMode.value = HTMLDencode(oActiveEl.getAttribute('showMode'));
			temp.openAll.value= HTMLDencode(oActiveEl.getAttribute('openAll'));
		} else {
			addRows();
		}
	}catch(ex){}
	
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	//resize();
    if(document.getElementById("showMode").value==1){
        if(HTMLDencode(oActiveEl.getAttribute('openAll'))=="true"){
        	document.getElementById("open_All").checked=true;
        }else{
        	document.getElementById("open_All").checked=false;
        }
    	document.getElementById("showSpan").style.display="inline";
    }else{
    	document.getElementById("open_All").checked=false;
    	document.getElementById("open_All").value="false";
    }

    if(oActiveEl!=null){
        temp.selectedScript.value = HTMLDencode(oActiveEl.getAttribute('selectedScript'));
    }
    SelectField( 'name' ) ;
    window.top.toThisHelpPage("application_module_form_info_advance_tab");
    jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
}

// 通过表单或试图 ID 获取所在模块，针对旧数据兼容
function getModuleId(data){
	if(data.moduleId == null){
		if(data.type =="form"){
			//同步 异步线程
			DWREngine.setAsync(false);
			var id = "";
			FormHelper.getModuleById(data.formId,function(data){
				id = data;
			});
			DWREngine.setAsync(true);
			return id;
		}else{
			DWREngine.setAsync(false);
			var id = "";
			ViewHelper.getModuleById(data.formId,function(data){
				id = data;
			});
			DWREngine.setAsync(true);
			return id;
		}
	}
}

function cleanPromptVal(){
	jQuery("#selectedScriptButton").click(function(){
		if(jQuery("#selectedScriptId").val() == jQuery("#selectedScriptId").attr("title"))
			jQuery("#selectedScriptId").val("");
		openIscriptEditor('selectedScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.tabSelectedScript]*}','name','{*[Save]*}{*[Success]*}');
	});
}

//模块改变事件
function checkModule(id,rowIndex){
	var $module = jQuery("#"+id).find(".module");
	$module.html(
			ModuleHelper.getModuleSel(instance, function(options) {
			addOptions("moduleId"+rowIndex, options);
			checkType(null,jQuery("#"+"type"+rowIndex).val(),rowIndex);
		})
	);
}

function checkType(id,value,rowIndex){
	if(!value) value="form";//针对旧数据的兼容
	
	var $formOrView = jQuery("#"+id).parent("td").next().find(".formOrView");
	if(value=="form"){
		$formOrView.html(
				FormHelper.getFragmentformListByModules(jQuery("#"+"moduleId"+rowIndex).val(), function(options) {
				addOptions("formId"+rowIndex, options);
			})
		);
	}else{
		$formOrView.html(
				ViewHelper.get_viewListByModules4TabField(jQuery("#"+"moduleId"+rowIndex).val(), function(options) {
				addOptions("formId"+rowIndex, options);
			})
		);
	}
}

//检测选项卡内嵌表单是否有重复
function checkForm(formid){
	var selectObj=document.getElementById(formid);
	var selectObjs=document.getElementsByName("formId");
	for(var i=0;i < selectObjs.length;i++){
		if(selectObj.id == selectObjs[i].id || selectObjs[i].value == "none"){continue;}
		if(selectObjs[i].value == selectObj.value){
			alert("该表单已存在于选项卡内，请选择其他表单！");
			selectObj.value = "none";
			break;
		}
	}
}

// 点击返回
function Ok(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	oEditor.FCKUndo.SaveUndoStep() ;
	//检查内容是否完成正确
	if(!ev_check()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
		return false;
	}
	
	oActiveEl = getCreateNamedElement();
	return true;
}

//检查是否有未选的表单
function checkForms(){
	var selectObjs=document.getElementsByName("formId");
	for(var i=0;i < selectObjs.length;i++){
	 if(selectObjs[i].value == "none") return true; 
	}
	return false;
}

//检查内容是否完成正确
function ev_check(){
	if(checkForms()){
	   alert("{*[page.workflow.form.select]*}");
	   return false;
   }else{
	   var names = document.getElementsByName("name");
	   //名称为空校验
	   for(var i=0;i<names.length;i++){
		   var value = names[i].value;
		   if(value == ''){
			   alert("{*[page.name.notexist]*}");
			   return false;
		   }
	   }
	   //同名校验
	   var allowSameName = document.getElementById("allowSameName").checked;
	   if(!allowSameName){
		   for(var i=0;i<names.length;i++){
			   for(var j=0;j<names.length;j++){
				   if(names[i].value == names[j].value && i != j){
					   alert("{*[page.exist.same.name]*}");
					   return false;
				   }
			   }
		   }
	   }
   }
   return true;
}

function checkStartChar(value){
	return IsDigit(value,"{*[page.name.check]*}");
}
function IsDigit(s,msg){
    var patrn = /^(?![0-9])[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
                 
	if(s=="action"){
		if (!patrn.exec(s)) alert(msg);
	   	alert("action为关键字，不能作为字段名！");
	   	return true;
   	}else if (!patrn.exec(s)){
		alert(msg);
		return true;
	}
	return false;
}  
var instance = '<s:property value="#parameters.application" />';
var currentFormId = '<s:property value="#parameters.formid" />'

var rowIndex = 1;
var getTag = function(data) { return '<div style=\"white-space: nowrap;\">{*[Tab]*}:</div>' };
var getName = function(data) {
  	return '<input type="text" name="name" id="name" attr_index="'+rowIndex+'" value="' + HTMLDencode(data.name) + '" onchange="checkStartChar(this.value);" size="15" style="width:80px"/>';
};
var getType = function(data) { 
	var s =''; 
	s +='<select id="type'+ rowIndex +'" attr_index="'+rowIndex+'" name="type" style="width:55px;" onchange="checkType(this.id,this.value,'+rowIndex+')">';
	s +='<option value="form" selected>{*[cn.myapps.core.dynaform.form.type.fragment]*}</option>';
	s +='<option value="view" >{*[View]*}</option>';
	s +='</select>';
	return s; 
}; 
var getModule = function(data) { 
	var s =''; 
	s +='<select id="moduleId'+ rowIndex +'" class="module" name="moduleId'+ rowIndex +'" style="width: 100px;" onchange="checkModule(this.id,'+rowIndex+')">';
	if(data.moduleId == null){
		s +='<option value="'+getModuleId(data)+'" selected></option>';
	}else{
		s +='<option value="'+data.moduleId+'" selected></option>';
	}
	s +='</select>';
	return s; 
}; 
var getForm = function(data) { 
	var s =''; 
	s +='<select id="formId'+ rowIndex +'" class="formOrView" name="formId'+ rowIndex +'" style="width: 190px;" onchange=checkForm(this.id)>';
	s +='<option value="'+data.formId+'" selected></option>';
	s +='</select>';
	return s; 
}; 
var getRefresh = function(data) {
	var s = '<input id="refresh'+rowIndex+'" type="checkbox" name="refreshOnChanged" value="true" style="display:none;"';
	if (data.refreshOnChanged) {
		s+= ' checked';
	}
	s += '>';
	return s; 
};
var getRecalculate = function(data) {
	var s = '<input id="recalculate'+rowIndex+'" type="checkbox" name="calculateOnRefresh" value="true"';
	if (data.calculateOnRefresh) {
		s+= ' checked';
	}
	s += '>';
	return s; 
};
var getRelate = function(data) {
	var s = '<input id="relate'+rowIndex+'" type="checkbox" name="relate" value="true"';
	if (data.relate) {
		s+= ' checked';
	}
	s += '>';
	return s; 
};
var getHiddenScript = function(data) {
	var s = '<input type="button" value="{*[Open]*}" onclick="showDialog(\'hiddenScript'+rowIndex+'\',\'{*[Hidden_Script]*}\')"/>';
	s += '<textarea id="hiddenScript'+rowIndex+'" name="hiddenScript" style="display:none"/>'+HTMLDencode(data.hiddenScript)+'</textarea>';
	return s;
};
var getReadOnlyScript = function(data) {
	var s = '<input type="button" value="{*[Open]*}" onclick="showDialog(\'readOnlyScript'+rowIndex+'\',\'{*[ReadOnly_Script]*}\')"/>';
	s += '<textarea id="readOnlyScript'+rowIndex+'" name="readOnlyScript" style="display:none"/>'+HTMLDencode(data.readOnlyScript)+'</textarea>';
	return s;
};
var getHiddenPrintScript = function(data) {
	var s = '<input type="button" value="{*[Open]*}" onclick="showDialog(\'hscript'+rowIndex+'\',\'{*[Hidden_Script]*}\')"/>';
	s += '<textarea id="hscript'+rowIndex+'" name="hiddenPrintScript" style="display:none"/>'+HTMLDencode(data.hiddenPrintScript)+'</textarea>';
	return s;
};
var getDelete = function(data) {
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
  	//rowIndex ++;
  	return s;
};

//DWRUtil.setEscapeHtml(false);

// 根据数据增加行
function addRows(datas,relStr) {
	var cellFuncs ="";
	
	cellFuncs = [getName, getType, getModule, getForm, getRefresh, getRecalculate,getRelate, getHiddenScript,getReadOnlyScript,getHiddenPrintScript,getDelete];
	
	var rowdatas = datas;
	if (!datas) {
		var data="";
		data = {name:'', type:'', moduleId:'', formId:'', refreshOnChanged:'', calculateOnRefresh:'true',relate:'', hiddenScript:'',readOnlyScript:'',hiddenPrintScript:''};
		rowdatas = [data];
		DWRUtil.addRows("tb", rowdatas, cellFuncs);
		checkModule(null,rowIndex);
		rowIndex ++;
	}
	else{
		for(var k=0;k<datas.length;k++){
			DWRUtil.addRows("tb", [rowdatas[k]], cellFuncs);
			var $typeIndex = jQuery("#"+"type"+rowIndex);
			$typeIndex.find("option[value='"+datas[k].type+"']").attr("selected", true);
			checkModule(null,rowIndex);
		    rowIndex ++;
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
	resize();
}

// 增加element options
function addOptions(elemName, options) {
	delete options[currentFormId];// 移除当前表单选项
	var elems = document.getElementsByName(elemName);
	for (var i=0; i<elems.length; i++) {
		var defVal = elems[i].value;
		DWRUtil.removeAllOptions(elems[i].id);
		DWRUtil.addOptions(elems[i].id, options);
		DWRUtil.setValue(elems[i].id, defVal);
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
	var names = document.getElementsByName("name");
	var types = document.getElementsByName("type");
	
	//var formIds = document.getElementsByName("formId");

	var hiddenScripts = document.getElementsByName("hiddenScript");
	var readOnlyScripts = document.getElementsByName("readOnlyScript");
	var refreshs = document.getElementsByName("refreshOnChanged");
	var recalculates = document.getElementsByName("calculateOnRefresh");
	var pintscripts  = document.getElementsByName("hiddenPrintScript");
	var relates = document.getElementsByName("relate");
	var str = '[';
	for (var i=0;i<names.length;i++) {
		var index = names[i].getAttribute("attr_index");
		var formIds = document.getElementsByName("formId"+index);
		var moduleIds = document.getElementsByName("moduleId"+index);
		if (names[i].value != '' && formIds[0].value != '') {
			str += '{';
			str += names[i].name +':\''+ HTMLEncode(names[i].value) + '\',';
			str += 'moduleId' +':\''+ moduleIds[0].value + '\',';
			str += types[i].name +':\''+ HTMLEncode(types[i].value) + '\',';
			str += 'formId' +':\''+ formIds[0].value + '\',';
			str += hiddenScripts[i].name +':\''+ HTMLEncode(hiddenScripts[i].value) + '\',';
			str += readOnlyScripts[i].name +':\''+ HTMLEncode(readOnlyScripts[i].value) + '\',';
			str += pintscripts[i].name +':\''+ HTMLEncode(pintscripts[i].value) + '\',';
			str += refreshs[i].name +':'+ (refreshs[i].checked ? true : false) + ',';
			str += recalculates[i].name +':'+ (recalculates[i].checked ? true : false) + ',';
			str += 'relate' +':'+ (relates[i].checked?true:false) + '';
			str += '},';
		}
	}
	str = str.substring(0, str.length - 1);
	str += ']';
	return  str;
	
}

function showDialog(elId,title) {
	var el =document.getElementById(elId);
	var width = "510";
	var height = "290";
	var url = contextPath + "/core/dynaform/form/webeditor/editor/plugins/tabfield/hiddenscript.jsp";
	var rtn = "";
	
	if (el) {
		showDialogByDiv(title,url, width, height, el);
	}
	
}


//DIV弹出层
function showDialogByDiv(title,url,width,height,el) {
	OBPM.dialog.show({
				width : width, // 默认宽度
				height : height, // 默认高度
				url : url,
				args : {'value':el.value,'title':title},
				title : title,
				close : function(result) {
					if(result)
						el.value = result;
				}
			});
}


function show_OpenAll(s){
	var showSpan=document.getElementById("showSpan");
	
	if(s==0){
		document.getElementById("open_All").checked=false;
		document.getElementById("open_All").value="false";
		showSpan.style.display="none";
	}else if(s==1){
		document.getElementById("open_All").checked=true;
		document.getElementById("open_All").value="true";
		showSpan.style.display="inline";
	}else{
		document.getElementById("open_All").checked=false;
		document.getElementById("open_All").value="false";
		showSpan.style.display="none";
	}

}

function changeValue(){
	var open_All=document.getElementById("open_All");
	
	if(open_All.checked==true){
		open_All.checked=true;
		open_All.value="true";
	}else{
		open_All.checked=false;
		open_All.value="false";
	}
}

</script>
 
</HEAD>

<BODY onload="InitDocument()">

<form name="temp">

<table border=0 cellpadding=3 cellspacing=0>
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(2)" id="card2">{*[cn.myapps.core.dynaform.form.webeditor.label.tabSelectedScript]*}</td>
	<td width=2></td>
</tr>

<tr>
<td valign="middle" colspan="13" bgcolor="#ffffff" align="center" width="100%">
	<!-- *************************** content1 ********************************* -->
	<table border=1 cellpadding=3 cellspacing=1 class="content" width="100%" id="content1">
		<tr>
		<td align="left">
			{*[cn.myapps.core.dynaform.form.webeditor.label.showMode]*}:
			<select name="showMode" id="showMode" onchange="show_OpenAll(this.value)">
				<option value="0" selected>{*[Normal]*}</option>
				<option value="1">{*[cn.myapps.core.dynaform.form.webeditor.label.collapse]*}</option>
			</select>
			<span id="showSpan" style="display:none">
			{*[cn.myapps.core.dynaform.form.webeditor.label.isOpenAll]*}
			<input type="checkbox" name="openAll" onclick="changeValue()" id="open_All" value="true"/>
			</span>
		</td>
		<td>
			{*[cn.myapps.core.dynaform.form.webeditor.label.isAllowSameName]*}:
			<input type="checkbox" id="allowSameName" checked="checked"/>
		</td>
		<td align="right">
			<input type="button" value="{*[Add]*}" onclick="addRows()"/> 
		</td></tr>
		<tr>
		<td colspan="4">
			<table border=0 class="content">
				<tbody id="tb">
				<tr>
					<td>{*[Name]*}</td>
					<td>{*[Type]*}</td>
					<td>{*[Module]*}</td>
					<td>{*[cn.myapps.core.dynaform.form.type.fragment]*}/{*[View]*}</td>
					<td><div style="display:none;">{*[Refresh]*}</div></td>
					<td>{*[Recalculate]*}</td>
					<td>{*[cn.myapps.core.dynaform.form.webeditor.label.isRelate]*}</td>
					<td >{*[Hidden_Script]*}</td>
					<td >{*[ReadOnly_Script]*}</td>
					<td>{*[Hidden_Print_Script]*}</td>
					<td>&nbsp;</td>
				</tr>
				</tbody>
			</table>
		</td>
		</tr>
	</table>
	<!-- *************************** content2 ********************************* -->		
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content2" style="width:100%">
	<tr>
		<td>
			<textarea id="selectedScriptId" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_tab_selected_script]*}*/" name="selectedScript" style="width:500" rows="10"></textarea>
			<button type="button"  id="selectedScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	</table>
	
	</td>
</tr>
</form>
<script language=javascript>
cardClick(1);
</script>
</BODY>
</o:MultiLanguage>
</HTML>
