<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>
<%@ include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
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
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<%
    String formid = request.getParameter("formid");
 %>
<SCRIPT language="JavaScript">

var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;

var oActiveEl = dialog.Selection.GetSelectedElement() ;


//初始值
function InitDocument(){
	//document.getElementsByName("formlist")[0].value=document.getElementById("formid").value;
	var editMode;
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	if ( oActiveEl && (oActiveEl.tagName == 'INPUT'))
	{
		//基本
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value	= oActiveEl.getAttribute('name');
		}
		//temp.textType.value	= oActiveEl.textType ;
		for(var i=0;i<temp.textType.options.length;i++)
			if(temp.textType.options[i].value==oActiveEl.getAttribute('textType')){
		    	temp.textType.selectedIndex = i;
				break;
		}
		//temp.fieldType.value	= oActiveEl.fieldType;
		for(i=0;i<temp.fieldkeyevent.options.length;i++)
			if(temp.fieldkeyevent.options[i].value==oActiveEl.getAttribute('fieldkeyevent')){
		    	temp.fieldkeyevent.selectedIndex = i;
				break;
		}
		//temp.fieldkeyevent.value	= oActiveEl.fieldkeyevent;
		for(i=0;i<temp.fieldType.options.length;i++){
			if(temp.fieldType.options[i].value==oActiveEl.getAttribute('fieldType')){
		    	temp.fieldType.selectedIndex = i;
				if (temp.fieldType.options[i].value == 'VALUE_TYPE_NUMBER') {
					ev_onTyepch();
					temp.numberPattern.value = HTMLDencode(oActiveEl.getAttribute('numberPattern'));
				}
				break;
			}
		}
		
		if(oActiveEl.getAttribute('readOnlyShowValOnly')!=null){
			temp.readOnlyShowValOnly.checked = oActiveEl.getAttribute('readOnlyShowValOnly') == "true";
		}

		if(oActiveEl.getAttribute('refreshOnChanged')!=null){
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		}else{
			temp.refreshOnChanged.checked = false;
		}
		
		if(oActiveEl.getAttribute('isDefaultValue')!=null){
			temp.isDefaultValue.checked = oActiveEl.getAttribute('isDefaultValue') == "true";
		}else{
			temp.isDefaultValue.checked = false;
		}

		if(oActiveEl.getAttribute('calculateOnRefresh')!=null){
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		}else{
			oActiveEl.calculateOnRefresh = false;
		}

		if(oActiveEl.getAttribute('mobile')!=null){
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
		}else{
			oActiveEl.mobile = false;
		}

		if(oActiveEl.getAttribute('discript')!=null){
			temp.discript.value = oActiveEl.getAttribute('discript');
		}

		if(oActiveEl.getAttribute('validateRule')!=null){
			temp.validateRule.value = HTMLDencode(oActiveEl.getAttribute('validateRule'));
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

		if(oActiveEl.getAttribute('valueScript')!=null){
			temp.valueScript.value=HTMLDencode(oActiveEl.getAttribute('valueScript'));
		}

		if(oActiveEl.getAttribute('editMode')!=null){
			editMode=HTMLDencode(oActiveEl.getAttribute('editMode'));
		}

		if(oActiveEl.getAttribute('processDescription')!=null){
			var items=HTMLDencode(oActiveEl.getAttribute('processDescription'));
		    parseRelStr(items);
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
	else
		oActiveEl = null ;
	
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	SelectField( 'name' ) ;
	
	//ev_onTyepch();
	initForm();
	modeChange(editMode);
	resize();
	window.top.toThisHelpPage("application_module_form_info_advance_input");
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
	jQuery("#hiddenScriptEditor").click(function(){
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

// 选项卡点击事件(ok)
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

function Ok()
{
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	var isok=true;
	//检查值脚本设计模式内容是否完成正确
	for(var i=0;i<document.all("editMode").length;i++){
		if(document.all("editMode")[i].checked){
			if(document.all("editMode")[0].checked){
		    	isok=createItems();
		     	if(!isok){
			    	alert("{*[Value_Script]*}{*[page.content.notexist]*}");
		         	return;
		     	}
		    }
		  
	      }
	 }
	  
	if(ev_check()){
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.InputField";
	var id=getFieldId();
	var editMode=document.getElementsByName("editMode");  
	var ed="";   
    for(var i=0;i<editMode.length;i++){
		  if(editMode[i].checked){
			   ed += editMode[i].value;
	      }
	    }
	var validateLibs=document.getElementsByName("validateLibs");
	var libs='';
	for(i=0; i< validateLibs.length; i++){
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
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'INPUT', {
									classname: className,
									id: id,
									text:GetE('textType').value,
									name: temp.name.value,
									textType:temp.textType.options[temp.textType.selectedIndex].value,
									fieldType:temp.fieldType.options[temp.fieldType.selectedIndex].value,
									fieldkeyevent:temp.fieldkeyevent.options[temp.fieldkeyevent.selectedIndex].value,
									readOnlyShowValOnly:HTMLEncode(temp.readOnlyShowValOnly.checked+""),
									discript:GetE('discript').value,
									validateRule:HTMLEncode(temp.validateRule.value),
									valueScript:HTMLEncode(temp.valueScript.value),
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
									readonlyScript:HTMLEncode(temp.readonlyScript.value),
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									isDefaultValue:HTMLEncode(temp.isDefaultValue.checked+""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									mobile: HTMLEncode(temp.mobile.checked+""),
									numberPattern:GetE('numberPattern').value,
									filtercondition:GetE('filtercondition').value,
									validateLibs:HTMLEncode(libs),
									editMode:HTMLEncode(ed),
									refreshMode:refreshMode,
									refreshFields:HTMLEncode(getRefreshFieldsValue()),
									processDescription:HTMLEncode( createRelStr())
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

function ev_onTextTypeChanged(value){
	//文本类型如果为隐藏时,则隐藏脚本选项卡无效，不可操作
	if(value == 'hidden'){
		jQuery('#hiddenValue').val("");
		jQuery('#hiddenScript').attr("disabled","disabled");
		jQuery('#hiddenScriptEditor').attr("disabled","disabled");
		jQuery('#hiddenValue').attr("disabled","disabled");
	} else {
		jQuery('#hiddenScript').attr("disabled","");
		jQuery('#hiddenScriptEditor').attr("disabled","");
		jQuery('#hiddenValue').attr("disabled","");
	}
}

function ev_onTyepch() {
	npTD.style.display = 'none';
	noneTD.style.display = 'none';
	colspanTD.style.display = 'none';
    if (document.all('fieldType').value == 'VALUE_TYPE_NUMBER'){
 		npTD.style.display = '';
 		noneTD.style.display = '';
 	} else {
 		colspanTD.style.display = '';
 	}
 	resize();
}
</script>

</HEAD>

<BODY onload="InitDocument()">
<form name="temp">
<s:hidden name="formid" id="formid" value="%{#parameters.formid}" ></s:hidden>
		<table border="0" cellpadding="3" cellspacing="0" width="520px">
			<tr align=center>
				<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(2)" id="card2">{*[Value_Script]*}</td>
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
				<td valign="middle" colspan="12" bgcolor="#ffffff" align="center"
					width="100%">
				<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1" width="520px">
					<tr>
						<td class="commFont commLabel">{*[Name]*}:</td>
						<td colspan="4"><input type="text" id="name" name="name"  onchange="checkStartChar(this.value);" size="20"></td>
					</tr>
					<tr>
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.label.type]*}:</td>
						<td colspan="2"><select onchange="ev_onTyepch()"
							name="fieldType">
							<option value="VALUE_TYPE_VARCHAR">{*[Text]*}</option>
							<option value="VALUE_TYPE_NUMBER">{*[Number]*}</option>
						</select></td>
						<td class="commFont commLabel">{*[TextType]*}:</td>
						<td><select id="textType" name="textType" >
							<option value="text">{*[Common]*}</option>
							<option value="tel">{*[Mobile]*}</option>
							<option value="password">{*[Password]*}</option>
							<option value="readonly">{*[Readonly]*}</option>
							<option value="hidden">{*[Hidden]*}</option>
						</select></td>
					</tr>
					
					<tr>
						<td class="commLabel commFont">{*[cn.myapps.core.dynaform.form.webeditor.label.focusKey]*}:</td>
						<td colspan="2"><select name="fieldkeyevent">
							<option value="Tabkey">Tab</option>
							<option value="Enterkey">Tab or Enter</option>
						</select></td>
						<td id="colspanTD" class="commLabel commFont" colspan="2"></div></td>
						<td id="npTD" style="display: none"><div>{*[Format]*}:</td>
						<td id="noneTD" style="display: none">{*[cn.myapps.core.dynaform.form.eg]*}:##.##<br>
						<input type="text" id="numberPattern" name="numberPattern" size="13"></td>
					</tr>
					<tr>
						<td align="left" colspan="5" style="padding-left: 140px">
							<input type="checkbox" name="readOnlyShowValOnly" checked="checked" value="true">{*[cn.myapps.core.dynaform.form.webeditor.label.readOnlyShowValOnly]*}<br/>
							<input type=checkbox name="refreshOnChanged" value="true" onclick="refreshOnChangedClick(this);">{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
							<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
							<input type="checkbox" name="mobile" value="true" checked />{*[cn.myapps.core.dynaform.activity.phone]*}<br/>
						</td>
					</tr>
					<%@include file="common_refresh_cfg.jsp"%>
					<tr>
						<td class="commLabel commFont">{*[Description]*}:</td>
						<td colspan="4"><textarea id="discript" name="discript" style="width:100%;" rows="4"></textarea></td>
					</tr>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content"
					id="content2" width="520px">
					<%@include file="commondialog.jsp"%>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content"
					id="content3" width="520px">
					<tr>
						<td width="25%">
							<%@include file="common_validateScript.jsp"%>
						</td>
						<td width="75%">
							<textarea id="validateRule" name="validateRule" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_validate_rule]*}*/" cols="75"  style="width:93%" rows="10"></textarea>
							<button type="button" id="validateRuleButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
							</td>
					</tr>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="100%" id="content4" width="520px">
					<tr>
						<td><textarea id="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" name="hiddenScript" style="width:96%" rows="10"></textarea>
						<button type="button" id="hiddenScriptEditor" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
							<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
						</button>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
					</tr>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="520px"
					id="content5">
					<tr>
						<td><textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
						<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
							<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
						</button>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
					</tr>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="520px"
					id="content6">
					<tr>
						<td><textarea id="readonlyScript"  name="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
						<button type="button" id="readonlyScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
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
