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
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

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
	var className="cn.myapps.core.dynaform.form.ejb.AttachmentUploadToDataBaseField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
	
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/attachmentuploadtodatabasefield/attachment.png",
		classname: className,
		id: id,
		type: "attachmentuploadtodatabase",
		fieldtype: "VALUE_TYPE_VARCHAR",
		limitsize: HTMLEncode(temp.limitsize.value),
		limitNumber: HTMLEncode(temp.limitNumber.value),
		name: HTMLEncode(temp.name.value),
		refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
		discript: GetE('discript').value,
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
		readonlyScript:HTMLDencode(temp.readonlyScript.value),
		fileType: getUploadFileType(),
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

		if(oActiveEl.getAttribute('limitsize')!=null){
			temp.limitsize.value = HTMLDencode(oActiveEl.getAttribute('limitsize'));
		}
		
		if(oActiveEl.getAttribute('limitNumber')!=null){
			temp.limitNumber.value = HTMLDencode(oActiveEl.getAttribute('limitNumber'));
		}else{
			temp.limitNumber.value = '10';
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

		if(oActiveEl.getAttribute('readonlyScript')!=null){
			temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));
		}

		ev_fileTypech();
		
	}else{
		temp.limitNumber.value = '10';
	}

	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;

	SelectField('name');
	window.top.toThisHelpPage("application_module_form_info_advance_attachmentuploadtodatabase");
}

// 点击返回
function Ok(){
	if(!ev_check())
		return false;
	oEditor.FCKUndo.SaveUndoStep() ;
	//检查自定义文件类型
	if(!checkSavefileType())
		return;
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
	return IsDigit(value,"{*[page.name.startingit]*}");
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
	return false;
}

//根据文件类型的选择显示自定义类型输入框
function ev_fileTypech(){
	customizeTypeDiv.style.display = 'none';
    if (document.getElementById("fileType01").checked==true){
    	customizeTypeDiv.style.display = '';
 	} 
}

//检查自定义文件类型
function checkSavefileType(){
	if(document.getElementById("fileType00").checked==true){
		return true;
	}
	if(jQuery.trim(temp.customizeType.value)==''){
		alert("{*[customizeType.notexist]*}");
		return false;
	}
	return true;
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
		<td colspan="5" align="center">
			<input type=checkbox name="refreshOnChanged" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}&nbsp;
		</td>
	</tr>
	<tr>
	<td class="commFont commLabel">{*[Limit]*}{*[Single]*}{*[Upload]*}{*[File]*}{*[Size]*}:</td>
		<td>
  		<input type="text" name="limitsize"/>KB<font color="red">&nbsp;&nbsp;{*[Default]*} 10M</font>
		</td>
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
		<td><select id="limitNumber" name="limitNumber">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
			</select></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" style="width:100%"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4">
	<tr>
		<td>
			<textarea name="hiddenScript" style="width:92%"  rows="6"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','name','{*[Save]*}{*[Success]*}');">
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
			<textarea name="hiddenPrintScript" style="width:92%"  rows="6"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}');">
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
				<textarea name="readonlyScript" style="width:95%" rows="10"></textarea>
				<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('readonlyScript','{*[Script]*}{*[Editor]*}','{*[ReadOnly_Script]*}','name','{*[Save]*}{*[Success]*}');">
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
                                                                                              
