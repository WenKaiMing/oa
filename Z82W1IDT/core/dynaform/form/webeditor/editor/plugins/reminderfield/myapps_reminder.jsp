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
<script src='<s:url value="/dwr/interface/ReminderUtil.js"/>'></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<6;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<6;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.ReminderField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
	
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/reminderfield/reminder.png",
		classname: className,
		id: id,
		type: "reminder",
		fieldtype: "VALUE_TYPE_VARCHAR",
		name: HTMLEncode(temp.name.value),
		reminderid:HTMLEncode(temp.reminderid.value),
		discript: GetE('discript').value,
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue.value)
	});
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	if (oActiveEl){
		temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		temp.reminderid.value = HTMLDencode(oActiveEl.getAttribute('reminderid'));
		temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
		
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
	}

	dialog.SetOkButton(true);
	dialog.SetAutoSize(true);
	SelectField('name');
	window.top.toThisHelpPage("application_module_form_info_advance_reminder");
}

function Ok(){
	if(!ev_check())
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
   }else if(document.getElementById("reminderid").value==''){
	  alert("{*[please.select]*}{*[Pending]*}{*[Summary]*}");
	  return false;
   }
   return !checkStartChar(temp.name.value);
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

</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp">
<table border=0 cellpadding=0 cellspacing=0 width="100%"><tr valign=top><td>
<s:bean name="cn.myapps.core.homepage.action.ReminderUtil" id="ru" />
<s:bean name="cn.myapps.core.dynaform.summary.action.SummaryCfgHelper" id="summaryCfgHelper" />

<table border=0 cellpadding=3 cellspacing=0 width="100%">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Print_Script]*}</td>
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
	    <td class="commFont commLabel">{*[Summary]*}:</td>
	    <td ><s:select theme="simple"  name="reminderid"  list="#summaryCfgHelper.getAllSummaryByApplication(#parameters.application)" /></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" style="width:100%"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4">
	<tr>
		<td>
			<textarea name="hiddenScript" style="width:96%"  rows="6"></textarea>
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
			<textarea name="hiddenPrintScript" style="width:96%"  rows="6"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}');">
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
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
                                                                                              
