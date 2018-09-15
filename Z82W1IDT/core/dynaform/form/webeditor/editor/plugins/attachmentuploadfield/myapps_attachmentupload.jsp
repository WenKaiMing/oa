<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.validate.repository.action.ValidateRepositoryHelper" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<STYLE type=text/css>
body, a, table, div, span, td, th, input, select{font:9pt;font-family: Arial,  "{*[SongTi]*}", Verdana,Helvetica, sans-serif;}
body {padding:5px}
.card {cursor:hand;background-color:#3A6EA5;text-align:center;}
table{
	border-color: #FFFFFF;
	border-collapse: collapse;
	background-image: none;
		border-top: 0px solid #FFFFFF;
}
table.content td {border-color:#000000;vertical-align:middle;cursor:hand;}
table.content {border-color:#000000;width:100%;}
</STYLE>

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

function getFileType(){
	  var value= '';
	  var fileType = document.getElementsByName('filePattern');
	  if(fileType.length>0){
		  for(var i=0;i<fileType.length;i++){
			  if(fileType[i].checked){
			     value = fileType[i].value;
			  }
		  }
	  }
	  return value;
	}
function initFileType(value){
	var fileType = document.getElementsByName('filePattern');
	if(fileType.length>0){
		for(var i=0;i<fileType.length;i++){
			if(fileType[i].value == value){
				fileType[i].checked=true;
			}
		}
	}
}

//获取上传文件类型value
function getUploadFileType(){
	  var value= '';
	  var fileType = document.getElementsByName('fileType');
	  if(fileType.length>0){
		  for(var i=0;i<fileType.length;i++){
			  if(fileType[i].checked){
			     value = fileType[i].value;
			  }
		  }
	  }
	  return value;
}
//初始化上传文件类型 
function initUploadFileType(value){
	var fileType = document.getElementsByName('fileType');
	if(fileType.length>0){
		for(var i=0;i<fileType.length;i++){
			if(fileType[i].value == value){
				fileType[i].checked=true;
			}
		}
	}
}

//检查保存目录路径格式

function checkSavefileCatalog(){
	if(document.getElementById("00").checked==true){
		return true;
		}
	if(temp.fileCatalog.value==''){
		alert("{*[catalog.notexist]*}");
		return false;
	}
	return checkStartStr(temp.fileCatalog.value);
}

//检查自定义文件类型 
function checkSavefileType(){
	if(document.getElementById("fileType00").checked==true){
		return true;
	}
	if(jQuery.trim(temp.customizeType.value)==''){
		alert("{*[cn.myapps.core.dynaform.form.webeditor.label.customizeType.notexist]*}");
		return false;
	}
	return true;
}

function checkStartStr(value){
	return IsDir(value);
}

function IsDir(value){
	
		if(value.substr(0,1) != "/"){
			alert("{*[catalog.startingit]*}");
			return false;
		}
	 return true;
		
}


//根据模式的选择显示目录输入框
function ev_onTyepch() {
	npDiv.style.display = 'none';
    if (document.getElementById("01").checked==true){
 		npDiv.style.display = '';
 	} 
 	//resize();
}

//根据文件类型的选择显示自定义类型输入框 
function ev_fileTypech(){
	customizeTypeDiv.style.display = 'none';
    if (document.getElementById("fileType01").checked==true){
    	customizeTypeDiv.style.display = '';
 	} 
}

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<=6;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<=6;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}


function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.AttachmentUploadField";
	var id ='';
	try{
		if(oActiveEl !=null && oActiveEl.getAttribute('id') =="undefined"){
			DWREngine.setAsync(false);
			Sequence.getSequence(function(_id) {
	  			id = _id;
	  		});
			
		}else if(oActiveEl !=null && oActiveEl.getAttribute('id') !="undefined"){
			id =  oActiveEl.getAttribute('id');
			}
	}catch(e){
		DWREngine.setAsync(false);
		Sequence.getSequence(function(_id) {
  			id = _id;
  		});
	}
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
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/attachmentuploadfield/attachment.gif",
		classname: className,
		id: id,
		type: "attachmentupload",
		fieldtype :"VALUE_TYPE_TEXT",
		openWaterMark:HTMLEncode(temp.openWaterMark.checked+""),
		waterMarkSupportMode:getWaterMarkSupportMode(),
		waterMarkScript:HTMLEncode(temp.waterMarkScript.value),
		name: HTMLEncode(temp.name.value),
		validateRule:HTMLEncode(temp.validateRule.value),
		validateLibs:HTMLEncode(libs),
		limitsize: HTMLEncode(temp.limitsize.value),
		limitNumber:HTMLEncode(temp.limitNumber.value),
		refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
		calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
		readOnlyShowValOnly:HTMLEncode(temp.readOnlyShowValOnly.checked+""),
		mobile:HTMLEncode(temp.mobile.checked+""),
		previewEdit:HTMLEncode(temp.previewEdit.checked+""),
		supportSorting:HTMLEncode(temp.supportSorting.checked+""),
		discript: GetE('discript').value,
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
		readonlyScript:HTMLDencode(temp.readonlyScript.value),
		filePattern: getFileType(),
		fileCatalog: HTMLEncode(temp.fileCatalog.value),
		fileType: getUploadFileType(),
		refreshMode:refreshMode,
		refreshFields:HTMLEncode(getRefreshFieldsValue()),
		customizeType: HTMLEncode(temp.customizeType.value)
	});
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	if (oActiveEl){
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}

		if(oActiveEl.getAttribute('validateRule')!=null){
			temp.validateRule.value = HTMLDencode(oActiveEl.getAttribute('validateRule'));
		}

		if(oActiveEl.getAttribute('validateLibs')!=null){
			var libstr=HTMLDencode(oActiveEl.getAttribute('validateLibs'));
			var lib=libstr.split(';');
			var validateLibs=document.getElementsByName('validateLibs');
		    for(var i=0; i< lib.length; i++){
		       for(var j=0; j< validateLibs.length; j++){
	 			if(validateLibs[j].value==lib[i]){
	 				validateLibs[j].checked=true;
	 					}
	 				}
	 			}
		}

		if(oActiveEl.getAttribute('limitsize')!=null){
			temp.limitsize.value = HTMLDencode(oActiveEl.getAttribute('limitsize'));
		}
		if(oActiveEl.getAttribute('limitNumber')!=null && oActiveEl.getAttribute('limitNumber') !=''){
			temp.limitNumber.value = HTMLDencode(oActiveEl.getAttribute('limitNumber'));
		}else{
			temp.limitNumber.value = '10';
		}

		if(oActiveEl.getAttribute('discript')!=null){
			temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
		}

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

		if(oActiveEl.getAttribute('filePattern')!=null){
			temp.filePattern.checked = initFileType(oActiveEl.getAttribute('filePattern'));
		}

		
		if(oActiveEl.getAttribute('filePattern')=="01"){
			temp.fileCatalog.value = HTMLDencode(oActiveEl.getAttribute('fileCatalog'));
		}

		if(oActiveEl.getAttribute('fileType')!=null){
			temp.fileType.checked = initUploadFileType(oActiveEl.getAttribute('fileType'));
		}

		if(oActiveEl.getAttribute('fileType')=="01"){
			temp.customizeType.value = HTMLDencode(oActiveEl.getAttribute('customizeType'));
		}
		   
		if(oActiveEl.getAttribute('refreshOnChanged')!=null){
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		}else{
			temp.refreshOnChanged.checked = false;
		}
		
		if(oActiveEl.getAttribute('calculateOnRefresh')!=null){
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		}else{
			oActiveEl.calculateOnRefresh = false;
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
		if(oActiveEl.getAttribute('readOnlyShowValOnly')!=null){
			temp.readOnlyShowValOnly.checked = oActiveEl.getAttribute('readOnlyShowValOnly') == "true";
		}
	    
	    //--- 水印功能
		if(oActiveEl.getAttribute('openWaterMark')!=null){
			temp.openWaterMark.checked = oActiveEl.getAttribute('openWaterMark') == "true";
		}
		if(oActiveEl.getAttribute('waterMarkScript')!=null){
			temp.waterMarkScript.value = HTMLDencode(oActiveEl.getAttribute('waterMarkScript'));
		}
		ev_waterMark(oActiveEl.getAttribute('waterMarkSupportMode'));
		
	    //-----------------------
		if(oActiveEl.getAttribute('mobile')!=null){
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
		}
		if(oActiveEl.getAttribute('previewEdit')!=null){
			temp.previewEdit.checked = oActiveEl.getAttribute('previewEdit') == "true";
		}
		if(oActiveEl.getAttribute('supportSorting')!=null){
			temp.supportSorting.checked = oActiveEl.getAttribute('supportSorting') == "true";
		}
		ev_onTyepch();
		isOpenWaterMark();
		ev_fileTypech();
	}
	else
		oActiveEl="";
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	SelectField('name') ;
	
	window.top.toThisHelpPage("application_module_form_info_advance_attachmentupload");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
	_getFormFields();
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
	jQuery("#waterMarkScriptButton").click(function(){
		if(jQuery("#waterMarkScript").val() == jQuery("#waterMarkScript").attr("title"))
			jQuery("#waterMarkScript").val("");
		openIscriptEditor('waterMarkScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.water_mark_scrpit]*}','name','{*[Save]*}{*[Success]*}');
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
}


// 点击确认
function Ok(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	oEditor.FCKUndo.SaveUndoStep() ;
	//检查内容是否完成正确
	if(!ev_check()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
		return;
	}
	if(!checkSavefileCatalog())
		return;

	//检查自定义文件类型 
	if(!checkSavefileType())
		return;
	
	//检查内容是否完成正确
	oActiveEl = getCreateNamedElement();
	
	return true;
}
//检查内容是否完成正确
function ev_check(){
   if(temp.name.value==''){
 	 alert("{*[page.name.notexist]*}");
	  return false;
   }if(checkNumber(temp.limitsize.value)){
		 alert("{*[Limit]*}{*[Size]*}不是正整数");
		 return false;
	}
   if(temp.limitNumber.value !="" && temp.limitNumber.value <= 0){
	 	 alert("文件数量要大于0");
	 	return false;
	   }else if(checkNumber(temp.limitNumber.value)){
		   var patten = /^-?\d+$/;
		   if(!patten.test(temp.limitNumber.value)){
			   alert("请输入正整数");
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

//检查是否为数字
function checkNumber(s){
	var reg = /^[0-9]*[1-9][0-9]*$/;
	if((s != null && s.Trim().length > 0) && !reg.test(s)){
		return true;
	}
	return false;
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
/**
 * 是否打开水印功能
 */
function isOpenWaterMark(){
	waterMarkTypeDiv.style.display = 'none';
	waterMarkScriptDiv.style.display = 'none';
    if (document.getElementById("openWaterMark").checked==true){
    	waterMarkTypeDiv.style.display = '';
    	waterMarkScriptDiv.style.display = '';
 	} 
}

/**
 * 获取水印属性
 */
 function getWaterMarkSupportMode(){
	var chk_value =[]; 
	jQuery('input[name=waterMarkSupportMode]:checked').each(function(){ 
		chk_value.push(jQuery(this).val()); 
	});
	return chk_value.toString(); 
}

function ev_waterMark(obj){
	if(obj != null){
		var list = obj.split(",");
		var waterMarkSupportMode =  jQuery("input[name=waterMarkSupportMode]");
		for(var index = 0 ; index < list.length ; index ++){
			for(var index2 = 0 ; index2 < waterMarkSupportMode.length; index2++){
				if(list[index] == waterMarkSupportMode[index2].value){
					waterMarkSupportMode[index2].checked = true ;
					break;
				}
			}
		}
	}
}
</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp">
<table border=0 cellpadding=0 cellspacing=0 width="100%"><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0 width="100%">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(3)" id="card3">{*[Validate_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(6)" id="card6">{*[ReadOnly_Script]*}</td>
	<td width=2></td>
</tr>
<tr>
	<td  align=center valign=middle colspan=10>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1">
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td><input type=text name="name" onchange="checkStartChar(this.value);"></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Limit]*}{*[Single]*}{*[Upload]*}{*[File]*}{*[Size]*}:</td>
		<td><input type=text name="limitsize" />KB<font color="red">&nbsp;&nbsp;{*[Default]*} 10M</font></td>
	</tr>
	
	<tr>
		<td class="commFont commLabel">{*[Upload]*}{*[File]*}{*[Type]*}：</td>
		<td>
		<input type=radio id="fileType00" name="fileType" value='00' checked onclick="ev_fileTypech();"/>{*[All]*}
		<input type=radio id="fileType01" name="fileType" value='01' onclick="ev_fileTypech();"/>{*[cn.myapps.core.dynaform.form.webeditor.label.customize]*}
		<div id="customizeTypeDiv" style="display:none">
		<font color="red">{*[Format]*}：doc;xls;ppt</font><br />
		<textarea id="customizeType" name="customizeType" style="width:100%"  rows="3"></textarea>
		</div>
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.webeditor.label.maxUploadFileNum]*}:</td>
		<td><input type="text" id="limitNumber" name="limitNumber" value="10"/></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.file_pattern]*}：</td>
		<td>
		<input type=radio id="00" name="filePattern" value='00' checked onclick="ev_onTyepch();"/>{*[cn.myapps.core.dynaform.form.webeditor.label.default]*}
		<input type=radio id="01" name="filePattern" value='01' onclick="ev_onTyepch();"/>{*[cn.myapps.core.dynaform.form.webeditor.label.customize]*}
		</td>
	</tr>
	<tr id ='npDiv' style="display: none">
		<td class="commFont commLabel" >{*[cn.myapps.core.dynaform.form.system_catalog]*}：</td>
		<td ><input type=text id="fileCatalog" size="45" name="fileCatalog" onchange="checkChangeStr();"></td>
	</tr>
	<tr>
		<td colspan="5" align="left" style="padding-left: 140px;">
			<input type="checkbox" name="readOnlyShowValOnly" id="readOnlyShowValOnly" checked="checked" value="true">
			<label for="readOnlyShowValOnly">{*[cn.myapps.core.dynaform.form.webeditor.label.readOnlyShowValOnly]*}</label><br/>
			<input type=checkbox name="refreshOnChanged" id="refreshOnChanged" onclick="refreshOnChangedClick(this);" value="true">
			<label for="refreshOnChanged">{*[cn.myapps.core.dynaform.activity.reflash]*}</label><br/>
			<input type=checkbox name="calculateOnRefresh" id="calculateOnRefresh" value="true">
			<label for="calculateOnRefresh">{*[cn.myapps.core.dynaform.activity.recalculate]*}</label><br/>
			<input type="checkbox" name="mobile" id="mobile" value="true" checked />
			<label for="mobile">{*[cn.myapps.core.dynaform.activity.phone]*}</label><br/>
			<input type="checkbox" name="previewEdit" id="previewEdit" value="true" checked />
			<label for="previewEdit">{*[cn.myapps.core.dynaform.activity.preview_edit]*}</label><br/>
			<input type="checkbox" name="openWaterMark" id="openWaterMark" onclick="isOpenWaterMark(this);">
			<label for="openWaterMark">{*[cn.myapps.core.dynaform.form.open_water_mark]*}</label><br/>
			<input type="checkbox" name="supportSorting" id="supportSorting" />
			<label for="supportSorting">{*[cn.myapps.core.dynaform.activity.supportSorting]*}<span ><font color="#FF0000">仅支持H5皮肤</font> </span></label><br/>
		</td>
	</tr>
	<tr id='waterMarkTypeDiv' style="display: none">
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.water_mark_type]*}：</td>
		<td>
		    <input type="checkbox" name="waterMarkSupportMode" value="preview" id="preview">
			<label for="preview">{*[cn.myapps.core.dynaform.form.water_mark_preview]*}</label>
			<input type=checkbox   name="waterMarkSupportMode" value="download" id="download">
			<label for="download">{*[cn.myapps.core.dynaform.form.water_mark_download]*}</label>
			<input type=checkbox   name="waterMarkSupportMode" value="print" id="print">
			<label for="print">{*[cn.myapps.core.dynaform.form.water_mark_print]*}</label>
		</td>
	</tr>
	<tr id='waterMarkScriptDiv' style="display: none">
		<td class="commFont commLabel" >{*[cn.myapps.core.dynaform.form.water_mark_scrpit]*}：</td>
		<td>
			<textarea id="waterMarkScript" name="waterMarkScript" title="水印脚本 ：setWaterMarkImgAndText (waterMarkImgPath,waterMarkText)" style="width:96%" rows="3"></textarea>
			<button type="button" id="waterMarkScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<%@include file="../../dialog/common_refresh_cfg.jsp"%>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" style="width:100%"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content"
		id="content3">
		<tr>
			<td width="25%">
				<%@include file="../../dialog/common_validateScript.jsp"%>
			</td>
			<td width="75%">
				<textarea id="validateRule" name="validateRule" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_validate_rule]*}*/" style="width:93%" rows="10"></textarea>
				<button type="button" id="validateRuleButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4" width="100%">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:92%"  rows="7"></textarea>
			<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" width="100%">
	<tr>
		<td>
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:92%"  rows="7"></textarea>
			<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content6">
		<tr>
			<td>
				<textarea id="readonlyScript" name="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
				<button type="button" id="readonlyScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	</td>
</tr>
</table>


</td><td width=10></td><td>

</td></tr></table>
</form>

<script language=javascript>
cardClick(1);
</script>

</BODY>
</o:MultiLanguage>
</HTML>
                                                                                              
