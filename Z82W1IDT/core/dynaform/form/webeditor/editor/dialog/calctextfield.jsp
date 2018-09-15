<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="viewHelper">
<s:param name="moduleid" value="#parameters.moduleid"/>
</s:bean>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh" />
<html><o:MultiLanguage>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper"
	id="viewHelper">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<script src="common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language="JavaScript" src="dialog.js"></script>
<script language="JavaScript" src="script.js"></script>
<script language="JavaScript" src="sequence.js"></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;

var oActiveEl = dialog.Selection.GetSelectedElement() ;

// 替换特殊字符
function HTMLEncode(text){
	text = text.replace(/&/g, "@amp;") ;
	text = text.replace(/"/g, "@quot;") ;
	text = text.replace(/</g, "@lt;") ;
	text = text.replace(/>/g, "@gt;") ;
	text = text.replace(/'/g, "@#146;") ;
	text = text.replace(/\ /g,"@nbsp;");
	return text;
}

// 替换特殊字符
function HTMLDencode(text){
	var textold;
	do {
		textold = text;
		text = text.replace("@amp;","&") ;
		text = text.replace('@quot;','"') ;
		text = text.replace("@lt;","<") ;
		text = text.replace("@gt;",">") ;
		text = text.replace("@#146;","'") ;
		text = text.replace("@nbsp;"," ");
        }
        while(textold != text);
	return text;
}

function Ok()
{
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.CalctextField";
	var id=getFieldId();	
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
									classname: className,
									src:"../../webeditor/editor/images/calctextfield.gif",
									id: id,
									valuescript:HTMLEncode(temp.valuescript.value),
									calculateonrefresh:HTMLEncode(temp.calculateonrefresh.value)
									} 
								   ) ;	
	alert("4444");
	return true ;
}
/*
var sAction = URLParams['action'] ;
var sTitle = "{*[Insert]*}";

var oControl;
var oSeletion;
var sRangeType;

oSelection = dialogArguments.eWebEditor.document.selection.createRange();
sRangeType = dialogArguments.eWebEditor.document.selection.type;
if (sAction == "modify"){
	if (sRangeType == "Control"){
		if (oSelection.item(0).tagName == "IMG"){
			oControl = oSelection.item(0);
		}
	}else{
		oControl = getParentObject(oSelection.parentElement(), "IMG");
	}
	if (oControl) {
		sTitle = "{*[Modify]*}";		
	}
}

document.write("<title>{*[CalculateField]*}{*[Property]*}（" + sTitle + "）</title>");
*/

function InitDocument(){
	var editMode;
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	//ev_init('content.type','_onactionviewid','_onactionformid','_onactionflowid');
	
	if ( oActiveEl)
	{
		var tmp = oControl.valuescript.replace("<!--{[","");
		tmp = tmp.replace("]}-->","");
		temp.valuescript.value = HTMLDencode(tmp);
		temp.calculateonrefresh.checked = oControl.calculateonrefresh == "true";
	}
	else
		oActiveEl = null ;
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	SelectField( 'name' ) ;
}

</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp" method="post">
<table border=0 cellpadding=3 cellspacing=0   width="98%">
<tr>
	<td  align=center valign=middle colspan=10>
	<table border=1 cellpadding=3 cellspacing=1  class="content" id="content2" width="98%">
	<tr>
		<td width="20%">{*[Recalculate]*}</td>
		<td><input type="checkbox" name="calculateonrefresh" value="true"></td>
	</tr>
	<tr>
		<td colspan="2">
			<textarea name="valuescript" cols="80" style="width: 95%" rows="20"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('valueScript','{*[Script]*}{*[Editor]*}','{*[Value_Script]*}','name','{*[Save]*}{*[Success]*}');">
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
