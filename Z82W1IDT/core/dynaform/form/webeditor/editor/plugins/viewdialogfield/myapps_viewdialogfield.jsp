<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%
	String contextPath = request.getContextPath();
%>
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="viewHelper">
<s:param name="moduleid" value="#parameters.moduleid"/>
</s:bean>

<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh" />
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript>
var dialog	= window.parent;
var args = OBPM.dialog.getArgs();
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement();
var joinChecked = false;

var fldValidateObj;  //表单校验对象
var viewValidateObj;  //视图列校验对象
var $optionsDiv ;     //文本编辑器内容

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<7;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<7;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
	resize();
}

//radio单击事件 
function ev_isPagination(item) {
	var oTR = document.getElementById("height_width");
	var divHeight = document.getElementById("divHeight");
	var divWidth = document.getElementById("divWidth");
	oTR.style.display="none";
	if (item.value != undefined) {
		if (item.value == 'true') {
			oTR.style.display="none";
			divHeight.value = "800" ;
			divWidth.value = "600" ;
		} else if(item.value == 'false') {
			oTR.style.display="";
			divHeight.value = "" ;
			divWidth.value = "" ;
		}else{
			divHeight.value = "" ;
			divWidth.value = "" ;
		}
	}
}

//初始值(或把HTML代码回选到属性页面) 
function InitDocument(){
	var editMode;
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	//ev_init('content.type','_onactionviewid','_onactionformid','_onactionflowid');
	//加载视图数据和表单数据
	DWREngine.setAsync(false);
	ev_form_view();

	if ( oActiveEl)
	{
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}
		
		if(oActiveEl.getAttribute('caption')!=null){
	   		temp.caption.value = HTMLDencode(oActiveEl.getAttribute('caption'));
		}
		
		temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		
		temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		
		//新增属性
		if(oActiveEl.getAttribute('maximization')!=null){
			initmaximization(oActiveEl.getAttribute('maximization'));
		}
		
		if(oActiveEl.getAttribute('divHeight')!=null){
			temp.divHeight.value = HTMLDencode(oActiveEl.getAttribute('divHeight'));
		}

		if(oActiveEl.getAttribute('divWidth')!=null){
			temp.divWidth.value = HTMLDencode(oActiveEl.getAttribute('divWidth'));
		}
		
		if(oActiveEl.getAttribute('mutilSelect') == "true"){
			temp.mutilSelect.checked = oActiveEl.getAttribute('mutilSelect') == "true";
			temp.selectOne.disabled = true;
		}

		if(oActiveEl.getAttribute('selectOne') == "true"){
			temp.selectOne.checked = oActiveEl.getAttribute('selectOne') == "true";
			temp.mutilSelect.disabled = true;
		}
		
		temp.allowViewDoc.checked = oActiveEl.getAttribute('allowViewDoc') == "true";
		
		
		if(oActiveEl.getAttribute('hiddenScript')!=null){
			temp.hiddenScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenScript'));
		}

		if(oActiveEl.getAttribute('hiddenValue')!=null){
			temp.hiddenValue.value = HTMLDencode(oActiveEl.getAttribute('hiddenValue'));
		}

		if(oActiveEl.getAttribute('hiddenPrintScript')!=null){
			temp.hiddenPrintScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenPrintScript'));
		}

		if(oActiveEl.getAttribute('printHiddenValue')!=null){
			temp.printHiddenValue.value = HTMLDencode(oActiveEl.getAttribute('printHiddenValue'));
		}
		
		if(oActiveEl.getAttribute('readonlyScript')!=null){
			temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));
		}
		
		if(oActiveEl.getAttribute('okScript')!=null){
			temp.okScript.value = HTMLDencode(oActiveEl.getAttribute('okScript'));
		}
		if(oActiveEl.getAttribute('callbackScript')!=null){
			temp.callbackScript.value = HTMLDencode(oActiveEl.getAttribute('callbackScript'));
		}
		if(oActiveEl.getAttribute('openType')!=null){
			temp.openType.value = HTMLDencode(oActiveEl.getAttribute('openType'));
		}

		if(oActiveEl.getAttribute('mobile')!=null){
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
		}else{
			temp.mobile.checked = false;
		}
		
		if(oActiveEl.getAttribute('module')!=null){
			for(var i=0;i<temp.module.options.length;i++)
				  if(temp.module.options[i].value==HTMLDencode(oActiveEl.getAttribute('module'))){
				    temp.module.selectedIndex = i;
					break;
			}
		}

		if(oActiveEl.getAttribute('dialogView')!=null){
			for(i=0;i<temp.dialogView.options.length;i++)
				if(temp.dialogView.options[i].value==HTMLDencode(oActiveEl.getAttribute('dialogView'))){
				    temp.dialogView.selectedIndex = i;
					break;
				} 
		}

		if(oActiveEl.getAttribute('validateLibs')!=null){
			var libstr=HTMLDencode(oActiveEl.getAttribute('validateLibs'));
			var lib=libstr.split(';');
			var validateLibs=document.getElementsByName('validateLibs');
			for(i=0; i< lib.length; i++){
			     for(var j=0; j< validateLibs.length; j++){
		   			if(validateLibs[j].value==lib[i]){
		   				validateLibs[j].checked=true;
		   			}
		   		}
		   	}
		}

		if(oActiveEl.getAttribute('mapping')!=null){
			var mappStr = HTMLDencode(oActiveEl.getAttribute('mapping'));
			var datas = parseMappStr(mappStr);
			addViewOptions(oActiveEl.getAttribute('module'), oActiveEl.getAttribute('dialogView'), datas);
		}
		//------------------------
	    if(oActiveEl.getAttribute('filtercondition')!=null){
			temp.filtercondition.value = oActiveEl.getAttribute('filtercondition');		
	    }
	    if(oActiveEl.getAttribute('refreshFields')!=null){
	    	initLocalRefreshMappRow(oActiveEl.getAttribute('refreshFields'));
		}
	    var refreshMode="0";
	    if(oActiveEl.getAttribute('refreshMode')!=null){
	    	refreshMode = oActiveEl.getAttribute('refreshMode');
		}
	    var refreshModes = document.getElementsByName("refreshMode");
		for(var i=0;i<refreshModes.length;i++){
			if(refreshModes[i].value == refreshMode){
				refreshModes[i].checked=true;
				break;
			}
		}
		refreshModeChange(refreshMode);
	    refreshOnChangedClick(document.getElementsByName("refreshOnChanged")[0]);
	    //------------------------
	}
	else {
		addMappRows();
		oActiveEl = null ;
	}

	dialog.SetOkButton( true ) ;
	changeChecked();
	//dialog.SetAutoSize( true ) ;
	SelectField( 'name' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_viewdialog");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
	 _getFormFields();
}

function ev_form_view(){
	  getformValidateObj();
}
function  getformValidateObj(){
	 //初始化表单数据
	  var formHtml = "";
	  formHtml = oDOM.body.innerHTML;
	
	  var reg = new RegExp("&lt;","g");
	  formHtml = formHtml.replace(reg,"<");
	  reg = new RegExp("&gt;","g");
	  formHtml = formHtml.replace(reg,">");
	
	  $optionsDiv = jQuery("#optionsDiv");
	  if($optionsDiv.length==0){
		$optionsDiv = jQuery("<div id='optionsDiv' style='display: none'>" + formHtml + "</div>");
    }else{
		$optionsDiv.html(formHtml);
	  }
	  //初始化表单校验数据
	  fldValidateObj = new Object();
	  $optionsDiv.find("*").each(function(){
	    	var optionsName = jQuery(this).attr("name");
	    	if(optionsName){
	    		var cn = jQuery(this).attr("classname");
	    		if(cn && cn=="cn.myapps.core.dynaform.form.ejb.FlowHistoryField"){
	    		}else{
	    			fldValidateObj[optionsName] = cn;
	    		}
	    	}
	    });
}
function getviewValidateObj(viewId){
	ViewUtil.getFilterColsTypeByView(viewId, function(map) {
		viewValidateObj = map ;
	});
}

function itemValidateFun(obj){
	var name = obj.name;
	var Elem = document.getElementsByName(name);
	var index = -1 ;
	for(var pos = 0  ; pos < Elem.length; pos ++ ){
		 var _id = Elem[pos].id ;
		 if(_id == obj.id){
			 index = pos ;
			 break; 
		 }
	}
	//数据校验
	if(index > -1){
		
		var colSelVal = document.getElementsByName("colname")[index].value;
		var fldSelVal = document.getElementsByName("fldname")[index].value;
		
		if(colSelVal == null || colSelVal=="" || colSelVal ==undefined ){
			return 
		}
		if(fldSelVal == null || fldSelVal=="" || fldSelVal ==undefined ){
			return 
		}
		
		//字段检验规则
		//var msg = colFldValidate(colSelVal,fldSelVal);
		
		if(msg != null){
			alert(msg);
		}
	}
}
function colFldValidate(colSelVal,fldSelVal){
	var colType = viewValidateObj[colSelVal] ;
	var fldType = fldValidateObj[fldSelVal];  
	
	if(colType == "cn.myapps.core.dynaform.form.ejb.InputField" 
			|| fldType == "cn.myapps.core.dynaform.form.ejb.InputField" ){
		return null ;
	}
	
	if(colType != fldType){
		return "字段与列的类型不一致,映射不一定成功";
	}
}
function cleanPromptVal(){
	jQuery("#validateRuleButton").click(function(){
		if(jQuery("#validateRule").val() == jQuery("#validateRule").attr("title"))
			jQuery("#validateRule").val("");
		openIscriptEditor('validateRule','{*[Script]*}{*[Editor]*}','{*[Validate_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenScriptButton").click(function(){
		if(jQuery("#hiddenScript").val() == jQuery("#hiddenScript").attr("title"))
			jQuery("#hiddenScript").val("");
		openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenPrintScriptButton").click(function(){
		if(jQuery("#hiddenPrintScript").val() == jQuery("#hiddenPrintScript").attr("title"))
			jQuery("#hiddenPrintScript").val("");
		openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#readonlyScriptButton").click(function(){
		if(jQuery("#readonlyScript").val() == jQuery("#readonlyScript").attr("title"))
			jQuery("#readonlyScript").val("");
		openIscriptEditor('readonlyScript','{*[Script]*}{*[Editor]*}','{*[ReadOnly_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#valueScriptButton").click(function(){
		if(jQuery("#valueScript").val() == jQuery("#valueScript").attr("title"))
			jQuery("#valueScript").val("");
		openIscriptEditor('valueScript','{*[Script]*}{*[Editor]*}','{*[Value_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#optionsScriptButton").click(function(){
		if(jQuery("#optionsScript").val() == jQuery("#optionsScript").attr("title"))
			jQuery("#optionsScript").val("");
		openIscriptEditor('optionsScript','{*[Script]*}{*[Editor]*}','{*[Option_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#okScriptButton").click(function(){
		if(jQuery("#okScript").val() == jQuery("#okScript").attr("title"))
			jQuery("#okScript").val("");
		openIscriptEditor('okScript','{*[Script]*}{*[Editor]*}','{*[Ok_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#callbackScriptButton").click(function(){
		if(jQuery("#callbackScript").val() == jQuery("#callbackScript").attr("title"))
			jQuery("#callbackScript").val("");
		openIscriptEditor('callbackScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.callbackscript]*}','name','{*[Save]*}{*[Success]*}');
	});
}


function getmaximization(){
	  var value= '';
	  var maximization = document.getElementsByName('maximization');
	  if(maximization.length>0){
		  for(var i=0;i<maximization.length;i++){
			  if(maximization[i].checked){
			     value = maximization[i].value;
			  }
		  }
	  }
	  return value;
	}

function initmaximization(value){
	  var maximization = document.getElementsByName('maximization');
	  if(maximization.length>0){
		  for(var i=0;i<maximization.length;i++){
			  if(maximization[i].value == value){
				  maximization[i].checked=true;
				  if(value == 'default'||value == 'true'){
						document.getElementById("height_width").style.display="none";
					}else{
						document.getElementById("height_width").style.display="";
				}
			  }
		  }
	  }
	}

function Ok()
{
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(ev_check()){
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.ViewDialogField";
	var id=getFieldId();	
	var validateLibs=document.getElementsByName('validateLibs');
	var libs='';
	for(var i=0; i< validateLibs.length; i++){
 		if(validateLibs[i].checked){
 			libs+=validateLibs[i].value+";";
 		}
 	}
 	libs=libs.substring(0,libs.length-1);
 	//--------------------
	var refreshModeEls=document.getElementsByName("refreshMode");  
	var refreshMode="0";   
	for(var i=0;i<refreshModeEls.length;i++){
	  if(refreshModeEls[i].checked){
		  refreshMode = refreshModeEls[i].value;
		  break;
      }
    }
	//--------------------
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
									classname: className,
									src:"images/viewdialog.gif",
									id: id,
									type:"viewdialogfield",
									name:HTMLEncode(temp.name.value),
									caption:HTMLEncode(temp.caption.value),
									//新增属性 
									maximization:getmaximization(),
									divHeight:HTMLEncode(temp.divHeight.value),
									divWidth:HTMLEncode(temp.divWidth.value),
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									mobile: HTMLEncode(temp.mobile.checked+""),
									mutilSelect: HTMLEncode(temp.mutilSelect.checked+""),
									selectOne: HTMLEncode(temp.selectOne.checked+""),
									allowViewDoc: HTMLEncode(temp.allowViewDoc.checked+""),
									openType:HTMLEncode(temp.openType.value),
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
									readonlyScript:HTMLEncode(temp.readonlyScript.value),
									okScript:HTMLEncode(temp.okScript.value),
									callbackScript:HTMLEncode(temp.callbackScript.value),
									validateLibs:HTMLEncode(libs),
									dialogView:HTMLEncode(temp.dialogView.options[temp.dialogView.selectedIndex].value),
									module:HTMLEncode(temp.module.options[temp.module.selectedIndex].value),
									refreshMode:refreshMode,
									refreshFields:HTMLEncode(getRefreshFieldsValue()),
									mapping:HTMLEncode(createMappStr())
									} 
								   ) ;	
	return true ;
	}
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	return false;
}
//检查内容是否完成正确
function ev_check(){
   if(temp.name.value==''){
 	 alert("{*[page.name.notexist]*}");
	  return false;
   }else if(temp.module.selectedIndex==0){
	 	 alert("{*[please.choose.module]*}");
		  return false;
   }else if(temp.dialogView.selectedIndex==0){
	 	 alert("{*[page.resource.view.notchoose]*}");
		  return false;
  }else if(createMappStr()==''){
	   alert("{*[core.dts.exp.columnmapping.field]*}");
       return false;
  }else if(getmaximization() == 'false'){
	   if(temp.divHeight.value==''||!checkDigit(temp.divHeight.value,"height")){
		alert("{*[page.divHeight.notexist]*},"+"{*[ands]*}"+"{*[can.only.for]*}"+"{*[Number]*}"+"{*[between.zero.and.Onethousand]*}");
		return false;
       }
	  if(temp.divWidth.value==''||!checkDigit(temp.divWidth.value,"width")){
		alert("{*[page.divWidth.notexist]*},"+"{*[ands]*}"+"{*[can.only.for]*}"+"{*[Number]*}"+"{*[between.zero.and.Twothousand]*}");
		return false;
	   }
  }
   var refreshMode="0";
   var refreshModeEls=document.getElementsByName("refreshMode");  
   for(var i=0;i<refreshModeEls.length;i++){
   	if(refreshModeEls[i].checked){
   		refreshMode = refreshModeEls[i].value;
 	  	break;
      }
   }
   var refreshOnChangedEls=document.getElementsByName("refreshOnChanged");
   if(refreshMode=="1" && getRefreshFieldsValue().length==0 && refreshOnChangedEls[0].checked){
 		alert('{*[cn.myapps.core.dynaform.form.field.valid.msg.refreshfield_not_empty]*}');
 		return false;
 	}
   return !checkStartChar(temp.name.value);
}

function checkDigit(value,h_w){
	var patrn=/^\d*$/; //JS中关于数字的正则
	if(!patrn.test(value))//判断输入是否是数字
	{   
		return false;  
	}else if(h_w=="height"&&(value<=0||value>1000)){
		return false;
	} 
	 else if(h_w=="width"&&(value<=0||value>2000)){
		return false;
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


var instance = '<%= request.getParameter("application")%>';
// 添加dialog view元素的options
function addViewOptions(modId, defValues, datas) {
	ApplicationUtil.getViewByMod1(modId,instance, function(map) {
		var elem = document.getElementById('dv');
		DWRUtil.removeAllOptions(elem.id);
		DWRUtil.addOptions(elem.id, map);
		addAllColAndFldOptions('');
		if (defValues) {
			DWRUtil.setValue(elem.id, defValues);
			addMappRows(datas);
		}
	});
}

function addAllColAndFldOptions(viewId){
	addAllColOptions(viewId);
	addAllfldOptions(viewId);
	getviewValidateObj(viewId);
}

// 添加所有colname元素的options
function addAllColOptions(viewId, defValues) {
	ViewUtil.getColsByView(viewId, function(map) {
		var colSels = document.getElementsByName("colname");
		for(var i=0;i<colSels.length;i++) {
			DWRUtil.removeAllOptions(colSels[i].id);
			DWRUtil.addOptions(colSels[i].id, map);
			if (defValues) { // 设置column name 默认选项
				DWRUtil.setValue(colSels[i].id, defValues[i]);
			}
		}
	});

	ViewUtil.getViewType(viewId, function (viewType){
		if(viewType != ""){
			if(viewType == "17"){ //当是树形视图时隐藏拼接模式
				document.getElementById("selectOne").checked = false;
				document.getElementById("selectOneSpan").style.display = "none";
				changeChecked();
			}else{
				joinChecked = document.getElementById("selectOne").checked;
				document.getElementById("selectOneSpan").style.display = "";
				document.getElementById("selectOne").checked = joinChecked;
				changeChecked();
			}
		}
	});
}

//添加所有fldname元素的options
function addAllfldOptions(viewId, defValues) {
	
	  var map = new Object();
	  //添加选择选项
	  map[""]="选择";
	  $optionsDiv.find("*").each(function(){
	    	var optionsName = jQuery(this).attr("name");
	    	if(optionsName){
	    		var cn = jQuery(this).attr("classname");
	    		if(cn && cn=="cn.myapps.core.dynaform.form.ejb.FlowHistoryField"){
	    		}else{
	    			map[optionsName] = optionsName;
	    		}
	    	}
	    });
	  //2.添加选项并设置回显
	  var fldSels = document.getElementsByName("fldname");
	  for(var i=0;i<fldSels.length;i++) {
		  	DWRUtil.removeAllOptions(fldSels[i].id);
			DWRUtil.addOptions(fldSels[i].id, map);
			if(defValues !=null){
				if (defValues[i] != null && defValues[i] !="") {    // 设置column name 默认选项
					DWRUtil.setValue(fldSels[i].id, defValues[i]);
				}
			}
		}
}

var rowIndex = 2;
var getFrom = function(data) { return '{*[From]*}:' };
var getColName = function(data) { 
	var s =''; 
	s +='<select id="colId'+ rowIndex +'" name="colname" value="' + data.colname + '" onchange=itemValidateFun(this) >';
	s +='<option value="">{*[Select]*}</option>';	
	s +='</select>';
	return s; 
}; 
var getTo = function(data) { return '{*[cn.myapps.core.dynaform.form.webeditor.label.to]*}:' };
var getFldName = function(data) {
	var s =''; 
	s +='<select id="fldname'+ rowIndex +'" name="fldname" value="' + data.fldname + '" onchange=itemValidateFun(this) >';
	s +='<option value="">{*[Select]*}</option>';	
	s +='</select>';
	return s ;
  	//return '<input type="text" name="fldname" value="'+ data.fldname + '"/>';
};
var getDelete = function(data) {
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delMappRow(this.parentNode.parentNode)"/>'
  	rowIndex ++;
  	return s;
};
//DWRUtil.setEscapeHtml(false);

// 根据数据增加行
function addMappRows(datas) {
	var cellFuncs = [getFrom, getColName, getTo, getFldName, getDelete];

	var rowdatas = datas;
	
	if (!datas) {
		var data = {colname:'', fldname:''};
		rowdatas = [data];
	}
	
	DWRUtil.addRows("mapping", rowdatas, cellFuncs);
	if (document.getElementsByName("dialogView")[0].value != '') {
		var defValues = new Array();
		var fldValues = new Array();
		
		if (datas) { //设置默认值
			for(var i=0;i<datas.length;i++) {
				defValues[i] = datas[i].colname;
				fldValues[i] = datas[i].fldname;
			}
		} else {
			var colSels = document.getElementsByName("colname");
			var fldSels = document.getElementsByName("fldname");
			for(var i=0;i<colSels.length;i++) {
				defValues[i] = colSels[i].value;
				fldValues[i] = fldSels[i].value;
			}
		}
		addAllColOptions(document.getElementsByName("dialogView")[0].value, defValues);
		addAllfldOptions(document.getElementsByName("dialogView")[0].value, fldValues);
	}
	resize();
	changeChecked();
}
// 删除一行
function delMappRow(row) {
	mapping.deleteRow(row.rowIndex);
	rowIndex --;
	resize();
}
// 根据mapping str获取datas array
function parseMappStr(str) {
	var mapps = str.split(";");
	var array = new Array();
	array[0] = {colname:'', fldname:''};
	for (var i=0;i<mapps.length;i++) {
		var rel = mapps[i].split(":");
		var colValue = rel[0];
		var fldValue = rel[1];	
		var map = {colname : colValue, fldname : fldValue};
		array[i] = map;
	}
	return array;
}

// 根据页面内容生成mapping string
function createMappStr() {
	var cols = document.getElementsByName("colname");
	var flds = document.getElementsByName("fldname");
	var mappStr = '';
	if(document.getElementById("selectOne").checked){
		for (var i=0;i<cols.length;i++) {
			mappStr += HTMLEncode(cols[i].value + ":" + flds[i].value) +";";
		}
	}else{
		for (var i=0;i<cols.length;i++) {
			if (cols[i].value != '' && flds[i].value != '') {
				mappStr += HTMLEncode(cols[i].value + ":" + flds[i].value) +";";
			}
		}
	}
	mappStr = mappStr.substring(0, mappStr.length - 1);
	return  mappStr;
}
function IsDigit(s,msg){
	var text = s.substring(0,1);
	var patrn=/^[0-9]{1}$/; 
	var patrn1=/^[.,?~!@#$%^&*()+|`=\-/;<>:]{1}$/; 
	if(s=="action"){
	   	alert("action为关键字，不能作为字段名！");
	   	return;
   	}else if (patrn.exec(text)){
   	   	
		alert(msg);
		return true;
	}
	if(patrn1.exec(text)){
		alert(msg);
		return true;
	}
	if(checkNameSameAsMappingFieldName(s)){
		alert("名称不能与映射字段名称相同！");
		return true;
	}
	return false;
} 

function checkNameSameAsMappingFieldName(name){
	var obj = document.getElementsByName('fldname');
	if(obj){
		for(var i=0;i< obj.length;i++){
			if(name == obj[i].value)
				return true;
		}
	}
	return false;
}

//选择多语言标签
function selectMultiLanguage(actionName, field){
	var url = contextPath + '/core/multilanguage/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	
	var oField = document.getElementsByName(field)[0];
	OBPM.dialog.show({
		opener:window,
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

function changeChecked(){
	var _selectOne = document.getElementById("selectOne");
	var _mutilSelect = document.getElementById("mutilSelect");
	if(_selectOne.checked){
		jQuery("select[name='colname']").each(function(){
			this.disabled = true;
		});
		_mutilSelect.checked = false;
		_mutilSelect.disabled = true;
		_selectOne.disable = false;
	}else if(_mutilSelect.checked){
		jQuery("select[name='colname']").each(function(){
			this.disabled = false;
		});
		_selectOne.checked = false;
		_selectOne.disabled = true;
		_mutilSelect.disable = false;
	}else{
		jQuery("select[name='colname']").each(function(){
			this.disabled = false;
		});
		_mutilSelect.disabled = false;
		_selectOne.disabled = false;
	}
		
}
</script>
 
</HEAD>

<BODY onload="InitDocument()">

<form name="temp">
<table border=0 cellpadding=3 cellspacing=0 width="520px">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(2)" id="card2">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(3)" id="card3">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[ReadOnly_Script]*}</td>
    <td width=2></td>
     <td class="card" onclick="cardClick(5)" id="card5">{*[Ok_Script]*}</td>
    <td width=2></td>
     <td class="card" onclick="cardClick(6)" id="card6">{*[cn.myapps.core.dynaform.form.webeditor.label.callbackscript]*}</td>
    <td width=2></td>
</tr>

<tr>
	<td bgcolor=#ffffff align=center valign=middle colspan=13  width="100%">
<!-- *************************** content1 ********************************* -->
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1" width="520px">
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td><input type=text name="name" size="40" onchange="checkStartChar(this.value);"></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Caption]*}:</td>
		<td>
			<input id="caption" type=text name="caption" size="40">
			<button type="button" class="button-image" onClick="selectMultiLanguage('selectlist','caption');">
				<img src="<s:url value='/resource/image/search.gif' />" />
			</button>
		</td>
	</tr>	
	<tr>
		<td class="commFont commLabel">{*[Module]*}:</td>
		<td>
			<s:select name="module" list="#mh.getModuleSel(#parameters.application)" 
			theme="simple" cssStyle="width:275" onchange="addViewOptions(this.value)"/>
		</td>
	</tr>
	
	<tr>
		<td class="commFont commLabel">{*[View]*}:</td>
		<td> 
			<s:select id="dv" name="dialogView" list="#{'':'{*[Select]*}'}" theme="simple" cssStyle="width:275" 
			onchange="addAllColAndFldOptions(this.value)"/>
		</td>
		</tr>
		<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.webeditor.label.openType]*}:</td>
		<td>
		    <input id="openType" name="openType" value="3" type="hidden"/>
		    {*[Open.in.working.div]*} 
			<!-- <select id="openType" name="openType">
				<option value="3">{*[Open.in.working.div]*}</option>
		    	<option value="1">{*[Open.in.pop.window]*}</option>
		    </select>-->
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Show]*}{*[Size]*}:</td>
		<td>
		    <div style=float:left>
			<s:radio id="maximization" name="maximization" theme="simple" value="'default'" onclick="ev_isPagination(this)"
			list="#{'default':'{*[Default]*}','true':'{*[Maximize]*}','false':'{*[cn.myapps.core.dynaform.form.webeditor.label.customize]*}'}"></s:radio>
			</div>
			<div id="height_width" style="display:none" >
			{*[Height]*}:<input type=text id="divHeight" name="divHeight" value="" size="4">&nbsp;px&nbsp;
			{*[Width]*}:<input type=text id="divWidth" name="divWidth" value="" size="4">&nbsp;px
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="left" style="padding-left: 140px;">
			<input type=checkbox name="refreshOnChanged" onclick="refreshOnChangedClick(this);" />{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
			<input type=checkbox name="calculateOnRefresh" />{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
			<span id="selectOneSpan">
			<input type=checkbox name="selectOne" id="selectOne" onclick="changeChecked()"/>{*[cn.myapps.core.dynaform.form.webeditor.label.joinMode]*}<br/>
			</span>
			<input type=checkbox name="mutilSelect" id="mutilSelect" onclick="changeChecked()"/>{*[Multi_Select]*}<br/>
			<input type=checkbox name="allowViewDoc" />{*[cn.myapps.core.dynaform.form.webeditor.label.allowViewDoc]*}<br/>
			<input type="checkbox" name="mobile" value="true" checked />{*[cn.myapps.core.dynaform.activity.phone]*}
		</td>
	</tr>
	<%@include file="../../dialog/common_refresh_cfg.jsp"%>
	<tr>
		<td class="commFont commLabel">
			{*[Mapping]*}:
		</td>
		<td>
		<table border="0" width="100%">
			<tbody id="mapping"> 
			<tr><td colspan="5" align="right">
				<input type="button" value="{*[Add]*}" onclick="addMappRows()"/> 
			</td></tr>
			<tr>
				<th width="15%"></th>
				<th>{*[cn.myapps.core.dynaform.form.webeditor.label.columnName]*}</th>
				<th width="10%"></th>
				<th>{*[cn.myapps.core.dynaform.form.webeditor.label.fieldName]*}</th>
				<th width="25%"></th>
			</tr>
			</tbody>
		</table>
		</td>
	</tr>
	</table>
<!-- *************************** content2 ********************************* -->		
<!-- *************************** content3 ********************************* -->	
<!-- *************************** content4 ********************************* -->	
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content2" width="520px">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%"  rows="10"></textarea>
			<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content3" >
	<tr>
		<td>
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:92%"  rows="6"></textarea>
			<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
<!-- *************************** content6 ********************************* -->		
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4" width="520px">
	<tr>
		<td>
			<textarea id="readonlyScript" name="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
			<button type="button" id="readonlyScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		
		</td>
	</tr>
	</table>
<!--****************************  content7   ************************************ -->
     <table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" width="520px" >
	<tr>
		<td>
			<textarea id="okScript" name="okScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10" ></textarea>
			<button type="button" id="okScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		
		
		</td>
	</tr>
	</table>
	<!--****************************  content6   ************************************ -->
     <table border=1 cellpadding=3 cellspacing=1 class="content" id="content6" width="520px" >
	<tr>
		<td>
			<textarea id="callbackScript" name="callbackScript" title="" style="width:96%" rows="10" ></textarea>
			<button type="button" id="callbackScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		
		
		</td>
	</tr>
	</table>
	</td>
</tr>
</table>
</form>

<script language=javascript>
cardClick(1);

</script>

</BODY>
</o:MultiLanguage>
</HTML>
