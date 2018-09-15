<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>

<s:bean name="cn.myapps.core.role.action.RoleHelper" id="rh">
	<s:param name="applicationid" value="#parameters.application" />
</s:bean>

<s:bean name="cn.myapps.core.role.ejb.RoleVO" id="vh"/>
<html><o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="0">
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<6;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<6;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
	resize();
}

//初始值
function InitDocument(){
	var editMode;
	oEditor.FCKLanguageManager.TranslatePage(document) ;
		if (oActiveEl){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";

			if(oActiveEl.getAttribute('isDefaultValue')!=null){
				if(temp.isDefaultValue){
					temp.isDefaultValue.checked = oActiveEl.getAttribute('isDefaultValue') == "true";
				}
			}else{
				if(temp.isDefaultValue){
					temp.isDefaultValue.checked = false;
				}
			}
			
			if(oActiveEl.getAttribute('readOnlyShowValOnly')!=null){
				temp.readOnlyShowValOnly.checked = oActiveEl.getAttribute('readOnlyShowValOnly') == "true";
			}

			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
			if(oActiveEl.getAttribute('discript')!=null){
				temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
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
			temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
			if(oActiveEl.getAttribute('editMode')!=null){
				editMode=HTMLDencode(oActiveEl.getAttribute('editMode'));
			}
			if(oActiveEl.getAttribute('textType')!=null){
				temp.textType.value = HTMLDencode(oActiveEl.getAttribute('textType'));
			}
			if(oActiveEl.getAttribute('limit')!=null){
				temp.limit.value = HTMLDencode(oActiveEl.getAttribute('limit'));
			}
			var libstr= "";
			if(oActiveEl.getAttribute('validateLibs')!=null){
				libstr=HTMLDencode(oActiveEl.getAttribute('validateLibs'));
			}
			var lib=libstr.split(';');
			var validateLibs=document.getElementsByName('validateLibs');
		    for(var i=0; i< lib.length; i++){
		       for(var j=0; j< validateLibs.length; j++){
	 			if(validateLibs[j].value==lib[i]){
	 				validateLibs[j].checked=true;
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
		//initForm();
		//modeChange(editMode);
		window.top.toThisHelpPage("application_module_form_info_advance_treedept");
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


function Ok()
{
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(ev_check()){
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.TreeDepartmentField";
	var id=getFieldId();
	var editMode=document.getElementsByName("editMode");
	var ed="";   
    for(var i=0;i<editMode.length;i++){
		  if(editMode[i].checked){
			   ed += editMode[i].value;
	      }
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
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'SELECT', {
									classname: className,
									id: id,
									type:"text",
									name:HTMLEncode(temp.name.value),
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									readOnlyShowValOnly:HTMLEncode(temp.readOnlyShowValOnly.checked+""),
									isDefaultValue:HTMLEncode(temp.isDefaultValue ? (temp.isDefaultValue.checked)+"" : ""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									mobile: HTMLEncode(temp.mobile.checked+""),
									validateRule:HTMLEncode(temp.validateRule.value),
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
									readonlyScript:HTMLEncode(temp.readonlyScript.value),
									discript:GetE('discript').value,
									
									fieldtype:"VALUE_TYPE_TEXT",
									textType:HTMLEncode(temp.textType.value),
									limit:HTMLEncode(temp.limit.value),
									istreedepartmentfield:true,
								   	validateLibs:HTMLEncode(libs),
								   	refreshMode:refreshMode,
									refreshFields:HTMLEncode(getRefreshFieldsValue()),
									editMode:HTMLEncode(ed)
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
   }else if(!changeLimit()){
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

//验证是否为数字类型
function changeLimit(){
	var s = document.getElementById("limit").value;
	if(s == null || s == ''){//limit不填时
		return true;
	}
	var reg = /^[0-9]*[1-9][0-9]*$/;
	if(reg.test(s)){
		return true;
	}
	alert("{*[Limit]*}{*[Select]*}不是正整数");
	return false;
}

</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()"">

<form name="temp">
		<table border="0" cellpadding="3" cellspacing="0" width="520px" >
			<tr>
				<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(2)" id="card2">{*[Validate_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(3)" id="card3">{*[Hidden_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Print_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(5)" id="card5">{*[ReadOnly_Script]*}</td>
				<td width=2></td>
			</tr>
			<tr>
				<td valign="middle" colspan="13" bgcolor="#ffffff" align="center"
					width="100%">

				<table border=1 cellpadding=3 cellspacing=0 class="content"
					width="100%" id="content1" width="520px">
					<tr>
						<td class="commFont commLabel">{*[Name]*}:</td>
						<td><input type=text name="name" onchange="checkStartChar(this.value);"/></td>
						<td class="commFont commLabel">{*[TextType]*}:</td>
						<td><select name="textType">
							<option value="text" selected>{*[Common]*}</option>
							<option value="readonly">{*[Readonly]*}</option>
							<option value="hidden">{*[Hidden]*}</option>
						</select></td>
					</tr>
					<tr>
						<td class="commFont commLabel">
						{*[cn.myapps.core.dynaform.form.webeditor.label.mostoption]*}:
						</td>
						<td colspan="3">
						<input type=text id="limit" name="limit" onchange="changeLimit()" width="4"/>{*[Item]*}
						</td>
						
					</tr>
					<tr>
						<td align="left" colspan="4" style="padding-left: 140px;">
							<input type="checkbox" name="readOnlyShowValOnly" checked="checked" value="true">{*[cn.myapps.core.dynaform.form.webeditor.label.readOnlyShowValOnly]*}<br/>
							<input type=checkbox name="refreshOnChanged" onclick="refreshOnChangedClick(this);" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
							<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
							<input type="checkbox" name="mobile" value="true" checked />{*[cn.myapps.core.dynaform.activity.phone]*}<br/>
						</td>
					</tr>
					<%@include file="../../dialog/common_refresh_cfg.jsp"%>
					<tr>
						<td class="commLabel commFont">{*[Description]*}:</td>
						<td colspan="4"><textarea name="discript" style="width:100%;" rows="4"></textarea></td>
					</tr>
				</table>
					<table border=1 cellpadding=3 cellspacing=1 class="content"
						id="content2">
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

					<table border=1 cellpadding=3 cellspacing=0 class="content"
						id="content3" width="520px">
						<tr>
							<td>
								<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
								<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
									<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
								</button>
							</td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
						</tr>
					</table>

					<table border=1 cellpadding=3 cellspacing=0 class="content"
						id="content4" width="520px">
						<tr>
							<td>
								<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
								<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
									<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
								</button>
							</td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
						</tr>
					</table>

					<table border=1 cellpadding=3 cellspacing=0 class="content"
						id="content5" width="520px">
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
		</form>

		<script language=javascript>
	cardClick(1);
</script>
</BODY>
</o:MultiLanguage>
</HTML>
