<%@ page language="java" contentType="text/html; charset=UTF-8" autoFlush="true"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.CalctextField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
	
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/calctextfield/calctextfield.gif",
		classname: className,
		id: id,
		name:HTMLEncode(temp.name.value),
		valueScript: HTMLEncode(temp.valueScript.value),
		calculateOnRefresh: HTMLEncode(temp.calculateOnRefresh.checked+"")
	});
}

// 点击返回
function Ok(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	oEditor.FCKUndo.SaveUndoStep() ;
	
	
	//检查内容是否完成正确
	oActiveEl = getCreateNamedElement();
	
	//检查名字
	var name = oActiveEl.getAttribute('name');
	return !checkStartChar(name);
	
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	if (oActiveEl){
		var tmp = oActiveEl.getAttribute('valueScript').replace("<!--{[","");
		tmp = tmp.replace("]}-->","");
		temp.valueScript.value = HTMLDencode(tmp);
		temp.name.value = oActiveEl.getAttribute('name');
		temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
	}
	
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;

	SelectField( 'valueScript' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_calctext");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
}

function cleanPromptVal(){
	jQuery("#valueScriptButton").click(function(){
		if(jQuery("#valueScript").val() == jQuery("#valueScript").attr("title"))
			jQuery("#valueScript").val("");
		openIscriptEditor('valueScript','{*[Script]*}{*[Editor]*}','{*[Value_Script]*}','','{*[Save]*}{*[Success]*}');
	});
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

<form name="temp" method="post">
<table border=0 cellpadding=3 cellspacing=0   width="520px" height="250px">
<tr>
	<td  align=center valign=middle colspan=10>
			<table border=1 cellpadding=3 cellspacing=1  class="content" id="content2" width="100%">
					<tr>
						<td align="right" class="commFont commLabel">{*[Name]*}:</td>
						<td><input type=text name="name" onchange="checkStartChar(this.value);"/></td>
					</tr>
					<tr>
						<td  colspan = 2 align="center"><input type="checkbox" name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}</td>
					</tr>
					<tr>
						<td width="15%" align="right">
							{*[CalculateField]*}
						</td>
						<td>
							<textarea id="valueScript" name="valueScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_recalculate_value_script]*}*/" style="width:100%" rows="13"></textarea>
							<button type="button" id="valueScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
	</table>
	</td>
</tr>
</table>
</form>

</BODY>
</o:MultiLanguage>
</HTML>
