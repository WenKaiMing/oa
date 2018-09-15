<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.moduleid"/>
</s:bean>
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
<script language=JavaScript src="about.js"></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />
<%
    String formid = request.getParameter("formid");
 %>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<8;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<8;i++){
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

	//检查选项脚本设计模式内容是否完成正确
	if(checkOptionMapping()){
		alert("{*[page.options.mappingfield.notexist]*}!");
		return;
	}
	 
	if(!ev_check()){
		jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
		return false;
		}
	oEditor.FCKUndo.SaveUndoStep() ;
	var className="cn.myapps.core.dynaform.form.ejb.SelectAboutField";
	var id=getFieldId();
	var editMode=document.getElementsByName("editMode");  
	var ed="";   
    for(var i=0;i<editMode.length;i++){
		  if(editMode[i].checked){
			   ed += editMode[i].value;
	      }
	    }	
    
	//选项编辑模式
	var optionsEditMode = document.getElementsByName("optionsEditMode");
	var oed = "";
	for ( var i = 0; i < optionsEditMode.length; i++) {
		if (optionsEditMode[i].checked) {
			oed += optionsEditMode[i].value;
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
									multiple:"",
									id: id,
									name:HTMLEncode(temp.name.value),
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									isDefaultValue:HTMLEncode(temp.isDefaultValue.checked+""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									/* mobile: HTMLEncode(temp.mobile.checked+""), */
									valueScript:HTMLDencode(temp.valueScript.value),
									validateRule:HTMLDencode(temp.validateRule.value),
									hiddenScript:HTMLEncode(temp.hiddenScript.value),
									hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
									hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
									printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
									readonlyScript:HTMLDencode(temp.readonlyScript.value),
									discript:GetE('discript').value,
									optionsScript:HTMLEncode(temp.optionsScript.value),
									fieldtype:"VALUE_TYPE_VARCHAR",
									isSelectAboutField:true,
									filtercondition:HTMLEncode(temp.filtercondition.value),
									processDescription :HTMLEncode(createRelStr()),
								   	validateLibs:HTMLEncode(libs),
									editMode:HTMLEncode(ed),
									optionsEditMode :HTMLEncode(oed),
									dialogView:HTMLEncode(temp.dialogView.options[temp.dialogView.selectedIndex].value),
									module:HTMLEncode(temp.module.options[temp.module.selectedIndex].value),
									optionsValue:HTMLEncode(temp.optionsValue.options[temp.optionsValue.selectedIndex].value),
									refreshMode:refreshMode,
									refreshFields:HTMLEncode(getRefreshFieldsValue()),
									optionsText:HTMLEncode(temp.optionsText.options[temp.optionsText.selectedIndex].value)
									} 
								   ) ;	
	return true ;
}

//初始值
function InitDocument(){
	var editMode;
	var optionsEditMode;
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	
		if ( oActiveEl){
			if(oActiveEl.getAttribute('name')!=null){
				temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
			}

			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";

			if(oActiveEl.getAttribute('isDefaultValue')!=null){
				temp.isDefaultValue.checked = oActiveEl.getAttribute('isDefaultValue') == "true";
			}else{
				temp.isDefaultValue.checked = false;
			}
			
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";

			if(oActiveEl.getAttribute('optionsScript')!=null){
				temp.optionsScript.value = HTMLDencode(oActiveEl.getAttribute('optionsScript'));
			}

			if(oActiveEl.getAttribute('discript')!=null){
				temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
			}

			if(oActiveEl.getAttribute('valueScript')!=null){
				temp.valueScript.value = HTMLDencode(oActiveEl.getAttribute('valueScript'));
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
			
			if(oActiveEl.getAttribute('filtercondition')!=null){
				temp.filtercondition.value =HTMLDencode(oActiveEl.getAttribute('filtercondition'));
			}

			if(oActiveEl.getAttribute('readonlyScript')!=null){
				temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));
			}
			
	/* 		if(oActiveEl.getAttribute('mobile')!=null){
				temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
			} */

			if(oActiveEl.getAttribute('editMode')!=null){
				editMode=HTMLDencode(oActiveEl.getAttribute('editMode'));
			}
			
			if(oActiveEl.getAttribute('processDescription')!=null){
			    var items=HTMLDencode(oActiveEl.getAttribute('processDescription'));
			    parseRelStr(items);
			}

			//选项编辑模式
			if(oActiveEl.getAttribute('optionsEditMode')!=null){
				optionsEditMode = HTMLDencode(oActiveEl.getAttribute('optionsEditMode'));
			}

			if(oActiveEl.getAttribute('module')!=null){
				for(var i=0;i<temp.module.options.length;i++)
					  if(temp.module.options[i].value==HTMLDencode(oActiveEl.getAttribute('module'))){
					    temp.module.selectedIndex = i;
						break;
				}
			}

			if(oActiveEl.getAttribute('dialogView')!=null){
				for(i=0;i<temp.dialogView.options.length;i++)
					if(temp.dialogView.options[i].value==HTMLDencode(oActiveEl.getAttribute('dialogView'))){
					    temp.dialogView.selectedIndex = i;
						break;
					} 
			}

			if(oActiveEl.getAttribute('optionsValue')!=null && oActiveEl.getAttribute('optionsText')!=null){
				var defValueMap = {value: oActiveEl.getAttribute('optionsValue'), text: oActiveEl.getAttribute('optionsText')};
				addViewOptions(oActiveEl.getAttribute('module'), oActiveEl.getAttribute('dialogView'), defValueMap);
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
		initForm();
		modeChange(editMode);
		optionsEditModeChange(optionsEditMode);
		window.top.toThisHelpPage("application_module_form_info_advance_selectabout");
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
</script>

</HEAD>

<BODY onload="InitDocument()">

<form name="temp">
<s:hidden name="formid" id="formid" value="%{#parameters.formid}" ></s:hidden>
<table border=0 cellpadding=3 cellspacing=0 width="540">
<tr>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(2)" id="card2">{*[Value_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(3)" id="card3">{*[Option_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Validate_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(6)" id="card6">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(7)" id="card7">{*[ReadOnly_Script]*}</td>
	<td width=2></td>
</tr>
<tr>
	<td valign="middle" colspan="13" bgcolor="#ffffff" align="center" width="100%">
	
	<table border=1 cellpadding=3 cellspacing=1 class="content" width="100%" id="content1" width="520px">
	
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td><input type=text name="name" onchange="checkStartChar(this.value);"/></td>
	</tr>
	<tr>
		<td align="left" colspan="4" style="padding-left: 140px;">
			<input type=checkbox name="refreshOnChanged" onclick="refreshOnChangedClick(this);" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
			<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
			<!-- <input type="checkbox" name="mobile" value="false"  />{*[cn.myapps.core.dynaform.activity.phone]*}<br/> -->
		</td>
		</tr>
		<%@include file="../../dialog/common_refresh_cfg.jsp"%>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td colspan="3"><textarea name="discript" style="width:100%"  rows="7"></textarea>
		<span style="color:green">*{*[cn.myapps.core.dynaform.form.field.label.Mobile_client_does_not_support]*}</span>
		</td>
	</tr>
	</table>
	
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content2" width="520px">
	<tr>
		<%@include file="../../dialog/commondialog.jsp"%>
	</tr>
	</table>
	
	<table border=1 cellpadding=3 cellspacing=1 class="content"
		id="content3">
		<tr>
			<%@include file="../../dialog/common_optionsScript.jsp"%>
		</tr>
	</table>

	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4" width="520px">
	<tr>
	    <td width="25%">
			<%@include file="../../dialog/common_validateScript.jsp"%>
	    </td>
		<td width="75%">
			<textarea id="validateRule" name="validateRule" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_validate_rule]*}*/" style="width:93%"  rows="10"></textarea>
			<button type="button" id="validateRuleButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	</table>

	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" width="520px">
	<tr>
		<td>
			<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%"  rows="10"></textarea>
			<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content6" width="520px">
	<tr>
		<td>
			<textarea id="hiddenPrintScript" name="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%"  rows="10"></textarea>
			<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
	
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content7" width="520px">
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
