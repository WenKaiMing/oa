<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
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
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<%
    String formid = request.getParameter("formid");
 %>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

//初始值
function InitDocument(){
	
	handleTypeChange("text");
	
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	if ( oActiveEl)
	{
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}
		if(oActiveEl.getAttribute('refreshOnChanged')!=null){
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
	   	}else{
	   		temp.refreshOnChanged.checked = false;
	   	}
		if(oActiveEl.getAttribute('calculateOnRefresh')!=null){
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		}else{
			temp.calculateOnRefresh.checked = false;
		}
		if(oActiveEl.getAttribute('mobile')!=null){
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
		}else{
			temp.mobile.checked = false;
		}
		if(oActiveEl.getAttribute('size')!=null){
			temp.size.value = HTMLDencode(oActiveEl.getAttribute('size'));
		}
		if(oActiveEl.getAttribute('discript')!=null){
			temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
		}
		if(oActiveEl.getAttribute('valueScript')!=null){
			temp.valueScript.value = HTMLDencode(oActiveEl.getAttribute('valueScript'));
		}
		if(oActiveEl.getAttribute('callbackScript')!=null){
			temp.callbackScript.value = HTMLDencode(oActiveEl.getAttribute('callbackScript'));
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
		if(oActiveEl.getAttribute('handleType')!=null){
			var handleTypes = document.getElementsByName("handleType");
			for(var i=0;i<handleTypes.length;i++){
				if(handleTypes[i].value == oActiveEl.getAttribute('handleType')){
					handleTypes[i].checked=true;
					break;
				}
			}
			handleTypeChange(oActiveEl.getAttribute('handleType'));
		}
	}
	else{
		oActiveEl = null ;
		
	}
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	SelectField( 'name' ) ;
	resize();
	window.top.toThisHelpPage("application_module_form_info_advance_htmlediter");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
}

function cleanPromptVal(){
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
	jQuery("#callbackScriptButton").click(function(){
		if(jQuery("#callbackScript").val() == jQuery("#callbackScript").attr("title"))
			jQuery("#callbackScript").val("");
		openIscriptEditor('callbackScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.form.webeditor.label.questionscript]*}','name','{*[Save]*}{*[Success]*}');
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
}

function Ok()
{ 
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(!ev_check()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
		  return false;
	}
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.QRCodeField";
	var id=getFieldId();	
	var handleTypes=document.getElementsByName("handleType");  
	var handleType="";
    for(var i=0;i<handleTypes.length;i++){
		  if(handleTypes[i].checked){
			  handleType = handleTypes[i].value;
			  break;
	      }
    }
	
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
									classname: className,
									src:"plugins/qrcodefield/qrcodefield.png",
									id: id,
									type:"qrcodefield",
									name:HTMLEncode(temp.name.value),
									handleType:handleType,
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									mobile: HTMLEncode(temp.mobile.checked+""),
									size:HTMLEncode(temp.size.value),
									discript:GetE('discript').value,
									valueScript:HTMLEncode(temp.valueScript.value),
									callbackScript:HTMLEncode(temp.callbackScript.value),
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									readonlyScript:HTMLEncode(temp.readonlyScript.value),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value)
									} 
								   ) ;	
	return true ;
}

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<=7;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<=7;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
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
function handleTypeChange(value){
	document.getElementById("card2").style.display="none";
	document.getElementById("card2_td").style.display="none";
	document.getElementById("card6").style.display="none";
	document.getElementById("card6_td").style.display="none";
	document.getElementById("_refreshOnChanged").style.display="none";
	if(value=="text"){
		document.getElementById("card2").style.display="";
		document.getElementById("card2_td").style.display="";
	}else if(value=="callback_event"){
		document.getElementById("_refreshOnChanged").style.display="";
		document.getElementById("card6").style.display="";
		document.getElementById("card6_td").style.display="";
	}
}
</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp">
<s:hidden name="formid" id="formid" value="%{#parameters.formid}" ></s:hidden>
<table border=0 cellpadding=0 cellspacing=0 width="520px"><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0 width="520px">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2 id="card2_td"></td>
	<td class="card" onclick="cardClick(2)" id="card2">{*[cn.myapps.core.dynaform.activity.qrcode.content_script]*}</td>
	<td width=2 id="card6_td"></td>
	<td class="card" onclick="cardClick(6)" id="card6">{*[cn.myapps.core.dynaform.activity.qrcode.callback_script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(7)" id="card7">{*[ReadOnly_Script]*}</td>
	<td width=2></td>
</tr>
<tr>
	<td  align=center valign=middle colspan=12>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1" width="520px">
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td><input type=text name="name" onchange="checkStartChar(this.value);"></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.qrcode.process_mode]*}:</td>
		<td>
			<label><input type="radio" name="handleType" value="text" onclick="handleTypeChange(this.value)" checked="checked">{*[cn.myapps.core.dynaform.activity.qrcode.text]*}</label>
			<label><input type="radio" name="handleType" value="link" onclick="handleTypeChange(this.value)">{*[cn.myapps.core.dynaform.activity.qrcode.link]*}</label>
			<label><input type="radio" name="handleType" value="callback_event" onclick="handleTypeChange(this.value)">{*[cn.myapps.core.dynaform.activity.qrcode.callback]*}</label>
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.qrcode.size]*}:</td>
		<td><input type=text name="size" style="width: 40;"> px</td>
	</tr>
	<tr>
		<td align="left" colspan="5" style="padding-left: 140px;">
			<div id="_refreshOnChanged" style="display:none;" ><input type=checkbox name="refreshOnChanged" value="true">{*[cn.myapps.core.dynaform.qrcode.refreshonchanged.label]*}<br/></div>
			<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
			<input type="checkbox" name="mobile" value="true" checked />{*[cn.myapps.core.dynaform.activity.phone]*}<br/>
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" cols="70"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content"
		id="content2">
		<tr>
		<td>
			<textarea id="valueScript" name="valueScript" title="/*返回内容字符串，如果内容为url地址，扫码后会调转到此url指定的页面上*/" style="width:96%" rows="8"></textarea>
			<button type="button" id="valueScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content6" width="520px">
	<tr>
		<td>
			<textarea id="callbackScript" name="callbackScript" title="" cols="70" style="width: 95%"  rows="7"></textarea>
			<button type="button" id="callbackScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4" width="520px">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" cols="70" style="width: 95%"  rows="7"></textarea>
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
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" cols="70" style="width: 95%" rows="7"></textarea>
			<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content"
					id="content7">
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
