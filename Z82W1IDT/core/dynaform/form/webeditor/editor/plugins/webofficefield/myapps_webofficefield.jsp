<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement() ;
// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<10;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<10;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}
  function InitWordOpertion(){
	  if (oActiveEl){
		  //目前没有需要初始化的内容
	  }
  }

//初始值
function InitDocument(){
	InitWordOpertion();
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	//ev_init('content.type','_onactionviewid','_onactionformid','_onactionflowid');
	
	if ( oActiveEl)
	{
		temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
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
		if(oActiveEl.getAttribute('signatureScript')!=null){//签章脚本
			temp.signatureScript.value = HTMLDencode(oActiveEl.getAttribute('signatureScript'));
		}
		if(oActiveEl.getAttribute('templateScript')!=null){//word模板和套红脚本
			temp.templateScript.value = HTMLDencode(oActiveEl.getAttribute('templateScript'));
		}
		if(oActiveEl.getAttribute('revisionScript')!=null){//保留痕迹脚本
			temp.revisionScript.value = HTMLDencode(oActiveEl.getAttribute('revisionScript'));
		}
		temp.openType.value = HTMLDencode(oActiveEl.getAttribute('openType'));
		if(oActiveEl.getAttribute('readonlyScript')!=null){
			temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));
		}

		if(oActiveEl.getAttribute('calculateOnRefresh')!=null){
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		}else{
			oActiveEl.calculateOnRefresh = false;
		}
	}
	else
		oActiveEl = null ;
	dialog.SetOkButton(true);
	dialog.SetAutoSize(true);
	SelectField('name');
	window.top.toThisHelpPage("application_module_form_info_advance_word");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
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
	jQuery("#signatureScriptButton").click(function(){
		if(jQuery("#signatureScript").val() == jQuery("#signatureScript").attr("title"))
			jQuery("#signatureScript").val("");
		openIscriptEditor('signatureScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.electronicSeal]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#templateScriptButton").click(function(){
		if(jQuery("#templateScript").val() == jQuery("#templateScript").attr("title"))
			jQuery("#templateScript").val("");
		openIscriptEditor('templateScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.templatesAndTaoHong]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#revisionScriptButton").click(function(){
		if(jQuery("#revisionScript").val() == jQuery("#revisionScript").attr("title"))
			jQuery("#revisionScript").val("");
		openIscriptEditor('revisionScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.retainTracesOf]*}','name','{*[Save]*}{*[Success]*}');
	});
}

function Ok()
{    
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(!ev_check()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	    return false;
	}
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.WebOfficeField";
	var id=getFieldId();	
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
									classname: className,
									src:"images/word.gif",
									id: id,
									type:"webofficefield",
									name:HTMLEncode(temp.name.value),
									discript:GetE('discript').value,
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
									signatureScript:HTMLEncode(temp.signatureScript.value),
									templateScript:HTMLEncode(temp.templateScript.value),
									revisionScript:HTMLEncode(temp.revisionScript.value),
									readonlyScript:HTMLEncode(temp.readonlyScript.value),
									openType:HTMLEncode(temp.openType.value),
									fieldtype:"VALUE_TYPE_TEXT"
									} 
								   ) ;	
	return true ;
}

//检查内容是否完成正确
function ev_check(){
   if(temp.name.value==''){
 	 alert("{*[page.name.notexist]*}");
	  return false;
   }
   return !checkStartChar(temp.name.value);
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
<table border=0 cellpadding=0 cellspacing=0 width="520px"><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0 width="520px">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(6)" id="card6">{*[ReadOnly_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(7)" id="card7">{*[cn.myapps.core.dynaform.form.webeditor.label.electronicSeal]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(8)" id="card8">{*[cn.myapps.core.dynaform.form.webeditor.label.templatesAndTaoHong]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(9)" id="card9">{*[cn.myapps.core.dynaform.form.webeditor.label.retainTracesOf]*}</td>
	<td width=2></td>
</tr>
<tr>
	<td  align=center valign=middle colspan=14>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1" width="520px"> 
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td>
			<input type=text name="name" onchange="checkStartChar(this.value);"> 
		</td>
	</tr>
	<tr class="commFont commLabel">
	    <td >{*[cn.myapps.core.dynaform.form.label.display_type]*}:</td>
	    <td align="left">
		    <select name="openType">
				<option value="3">{*[金格浏览器打开]*}</option>
				<option value="1">{*[嵌入表单]*}</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="left" colspan="5" style="padding-left: 140px">
			<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td>
			<textarea name="discript" cols="60"  rows="5"></textarea><br/>
			<span style="color:green">*{*[cn.myapps.core.dynaform.form.wordfield.label.Mobile_client_does_not_support]*}</span>
		</td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4" width="520px">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" cols="60" style="width:95%"  rows="8"></textarea>
			<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" width="520px">
	<tr>
		<td>
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" cols="60" style="width:95%" rows="8"></textarea>
			<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content6" width="520px">
		<tr>
			<td>
				<textarea id="readonlyScript" name="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:95%" rows="10"></textarea>
				<button type="button" id="readonlyScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content7" width="520px">
		<tr>
			<td>
				<textarea id="signatureScript" name="signatureScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:95%" rows="10"></textarea>
				<button type="button" id="signatureScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content8" width="520px">
		<tr>
			<td>
				<textarea id="templateScript" name="templateScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:95%" rows="10"></textarea>
				<button type="button" id="templateScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content9" width="520px">
		<tr>
			<td>
				<textarea id="revisionScript" name="revisionScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:95%" rows="10"></textarea>
				<button type="button" id="revisionScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
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
