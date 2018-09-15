<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

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

function getImageType(){
	  var value= '';
	  var imageType = document.getElementsByName('filePattern');
	  if(imageType.length>0){
		  for(var i=0;i<imageType.length;i++){
			  if(imageType[i].checked){
			     value = imageType[i].value;
			  }
		  }
	  }
	  return value;
	}

function initImageType(value){
	  var imageType = document.getElementsByName('filePattern');
	  if(imageType.length>0){
		  for(var i=0;i<imageType.length;i++){
			  if(imageType[i].value == value){
				  imageType[i].checked=true;
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

function checkChangeStr(){
	var value =  document.getElementById("fileCatalog").value;
	if(value.indexOf("uploads")!=-1||value.indexOf("UPLOADS")!=-1){
		alert("{*[CanNotHaveKeyword]*} 'uploads'");
		return false;
	}
	if(document.getElementById("00").checked==true){
		return true;
	}
	return IsDir(value);
}
//根据模式的选择显示目录输入框
function ev_onTyepch() {
	//npTD.style.display = 'none';
	npDiv.style.display = 'none';
    if (document.getElementById("01").checked==true){
 		//npTD.style.display = '';
 		npDiv.style.display = '';
 	} 
 	//resize();
}

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<7;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<7;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.ImageUploadField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
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
		src:"plugins/imageuploadfield/img.gif",
		classname: className,
		id: id,
		type: "imageupload",
		fieldtype: "VALUE_TYPE_TEXT",
		imgh: HTMLEncode(temp.imgh.value)==""?"100":HTMLEncode(temp.imgh.value),
		imgw: HTMLEncode(temp.imgw.value)==""?"100":HTMLEncode(temp.imgw.value),
		limitsize: HTMLEncode(temp.limitsize.value),
		openType:HTMLEncode(temp.openType.value),
		name: HTMLEncode(temp.name.value),
		refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
		calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
		readOnlyShowValOnly:HTMLEncode(temp.readOnlyShowValOnly.checked+""),
		mobile:HTMLEncode(temp.mobile.checked+""),
		discript: GetE('discript').value,
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
		readonlyScript:HTMLDencode(temp.readonlyScript.value),
		filePattern: getImageType(),
		fileCatalog: HTMLEncode(temp.fileCatalog.value),
		refreshMode:refreshMode,
		refreshFields:HTMLEncode(getRefreshFieldsValue()),
		limitNumber:HTMLEncode(temp.limitNumber.value)
	});
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	if (oActiveEl){
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}
		
		if(oActiveEl.getAttribute('discript')!=null){
			temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
		}
		
		if(oActiveEl.getAttribute('hiddenscript')!=null){
			temp.hiddenScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenscript'));
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
		
		if(HTMLDencode(oActiveEl.getAttribute('imgh'))==null || HTMLDencode(oActiveEl.getAttribute('imgh'))=="")
		{
			temp.imgh.value="100";
		}else{
			temp.imgh.value = HTMLDencode(oActiveEl.getAttribute('imgh'));
		}
		
		if(HTMLDencode(oActiveEl.getAttribute('imgw'))==null || HTMLDencode(oActiveEl.getAttribute('imgw'))=="")
		{
			temp.imgw.value="100";
		}else{
			temp.imgw.value = HTMLDencode(oActiveEl.getAttribute('imgw'));
		}

		if(oActiveEl.getAttribute('limitsize')!=null){
			temp.limitsize.value = HTMLDencode(oActiveEl.getAttribute('limitsize'));
		}

		if(oActiveEl.getAttribute('openType')!=null){
			temp.openType.value = HTMLDencode(oActiveEl.getAttribute('openType'));
		}

		if(oActiveEl.getAttribute('filePattern')!=null){
			temp.filePattern.checked = initImageType(oActiveEl.getAttribute('filePattern'));
		}
		
		if(oActiveEl.getAttribute('limitNumber')!=null && oActiveEl.getAttribute('limitNumber') !=''){
			temp.limitNumber.value = HTMLDencode(oActiveEl.getAttribute('limitNumber'));
		}else{
			temp.limitNumber.value = '10';
		}
		
		if(oActiveEl.getAttribute('filePattern')=="01"){
			temp.fileCatalog.value = HTMLDencode(oActiveEl.getAttribute('fileCatalog'));
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
		
		if(oActiveEl.getAttribute('readOnlyShowValOnly')!=null){
			temp.readOnlyShowValOnly.checked = oActiveEl.getAttribute('readOnlyShowValOnly') == "true";
		}
		//------------------------
		if(oActiveEl.getAttribute('mobile')!=null){
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
		}
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
		ev_onTyepch();
	}else{
		var imgw = document.getElementsByName("imgw")[0];
		var imgh = document.getElementsByName("imgh")[0];
		if(imgw.value==null || imgw.value==""){
			imgw.value="100";
		}
		if(imgh.value==null || imgh.value==""){
			imgh.value="100";
		}
	}

	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;

	SelectField( 'name' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_imageupload");
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

// 点击返回
function Ok(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(!ev_check()||!checkChangeStr()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
		return false;
	}
	if(!checkSavefileCatalog())
		return false;
	oEditor.FCKUndo.SaveUndoStep() ;
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
</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp">
<table border=0 cellpadding=0 cellspacing=0 width="100%"><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0 width="100%">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
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
		<td><input type=text name="name" id="name" onchange="checkStartChar(this.value);" ></td>
	</tr>
	<tr>
	    <td class="commFont commlabel">{*[cn.myapps.core.dynaform.form.show_size]*}:</td>
	    <td>{*[Height]*}:
		  <input type="text" name="imgh" id="imgh" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" size="5" >&nbsp<b>px</b>
		    &nbsp
		    &nbsp
	        {*[Width]*}:
		<input type="text" name="imgw"  id="imgw" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" size="5" >&nbsp<b>px</b>
	    </td>
	</tr>
	<tr>
	<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.limit_file_size]*}:</td>
		<td>
  		<input type=text name="limitsize" />KB
		<font color="red">&nbsp;&nbsp;{*[Default]*} 10M</font>
		</td>
	</tr>
	<tr  style="display:none">
		<td class="commFont commLabel">{*[Open]*}{*[Type]*}:</td>
		<td><select id="openType" name="openType">
				<option value="dialog" selected='selected'>{*[PopDIV]*}{*[Open]*}</option>
				<option value="download" >HTML{*[core.email.attachment.download]*}</option>
			</select></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.webeditor.label.maxUploadFileNum]*}:</td>
		<td><input type="text" id="limitNumber" name="limitNumber" value="10"/></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.image_pattern]*}:</td>
		<td>
		<input type=radio id="00" name="filePattern" value='00' checked onclick="ev_onTyepch();"/>{*[cn.myapps.core.dynaform.form.webeditor.label.default]*}
		<input type=radio id="01" name="filePattern" value='01' onclick="ev_onTyepch();"/>{*[cn.myapps.core.dynaform.form.webeditor.label.customize]*}
		</td>
	</tr>
	<tr id ='npDiv' style="display: none">
		<td class="commFont commLabel" >{*[cn.myapps.core.dynaform.form.image_catalog]*}:</td>
		<td ><input type=text id="fileCatalog" size="45" title="/*{*[cn.myapps.core.dynaform.form.webeditor.label.inputFormat]*}*/" name="fileCatalog" onchange="checkChangeStr();"></td>
	</tr>
	<tr>
		<td colspan="5" align="left" style="padding-left: 140px;">
			<input type="checkbox" name="readOnlyShowValOnly" checked="checked" value="true">{*[cn.myapps.core.dynaform.form.webeditor.label.readOnlyShowValOnly]*}<br/>
			<input type=checkbox name="refreshOnChanged" onclick="refreshOnChangedClick(this);" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
			<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
			<input type="checkbox" name="mobile" value="true" checked />{*[cn.myapps.core.dynaform.activity.phone]*}<br/>
		</td>
	</tr>
	<%@include file="../../dialog/common_refresh_cfg.jsp"%>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" style="width:100%"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%"  rows="6"></textarea>
			<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" >
	<tr>
		<td>
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%"  rows="6"></textarea>
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
				<textarea id="readonlyScript" name="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:95%" rows="10"></textarea>
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
                                                                                              
