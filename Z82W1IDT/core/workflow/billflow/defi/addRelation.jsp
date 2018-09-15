<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<%
String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<title>{*[Path attribute]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="addRelation.js"/>'></script>

<script>
   var contextPath = "<s:url value='/'/>";
  function modeChange(mode) { //Design和Code模式互换
       
		for(var i=0;i<2;i++) {
			var content = document.getElementById('editMode' + i);
			content.style.display = 'none';
		}
		 var formdisplay=document.getElementById("Formdislay");
		switch (mode) {
		case '00':
			 editMode0.style.display = '';
		     document.getElementsByName("editMode")[0].checked = true;
		     formdisplay.style.display="";
			break;
		case '01':
			  editMode1.style.display = '';
			  document.getElementsByName("editMode")[1].checked = true;
			  formdisplay.style.display="none";
			break;
		default:
			 editMode1.style.display = 'none';
			 document.getElementsByName("editMode")[0].checked = true;
			 formdisplay.style.display="";
			 editMode0.style.display="";
			 break;
		}
	}
	
	// 增加element options
	function addOptions(elemName, options) {
		var elems = document.getElementsByName(elemName);
		for (var i=0; i<elems.length; i++) {
			var defVal = elems[i].value;
			DWRUtil.removeAllOptions(elems[i].id);
			DWRUtil.addOptions(elems[i].id, options);
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}
	
	//orderby form下拉联动
	function initForm() {
		var of = document.getElementById('formlist');
		of.onchange = function(defVal){
			FormHelper.getAllFields(of.value,'', function(options) {
				addOptions("field", options);
				  if (defVal) {
					DWRUtil.setValue("field", defVal);
				}
			});
		
		};
		of.onchange('<s:property value="field" />');
	    var fields= document.getElementById('field');
		
		    fields.onchange = function(defVal){
			FormHelper.getFieldType(of.value, fields.value,function(options) {
				addOptions("fieldType", options);
			
				if (defVal) {
					DWRUtil.setValue("fieldType", defVal);
					
				}
			});
		};
		fields.onchange('<s:property value="fieldType" />');
		
	}
	
function checkSatement(statement) {
	var issucess = true;
	if (statement.length > 0) {
		var list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "(", "!"];
		for (var i = 0; i < list.length; i++) {
			if (list[i] == statement.substring(statement.length - 2,
					statement.length - 1)) {
				alert("{*[The.condition.expression.is.not.correct]*}!");
				tmp.filtercondition.value = "";
				issucess = false;
			}
		}
	}
	return issucess;
}
</script>
<SCRIPT LANGUAGE="JavaScript">
function ev_ok()
{ 
    var issumbit=true;
	var attr=new Object()
	attr.name=document.tmp.name.value;
	for(var i=0;i<document.getElementsByName("editMode").length;i++){
	   if(document.getElementsByName("editMode")[i].checked){
	    if(document.getElementsByName("editMode")[0].checked){
	     issumbit=createItems();
	     if(!issumbit){
	         return;
	     }
	      tmp.condition.value="";
	    }else{
	      tmp.processDescription.value="";
	      tmp.filtercondition.value="";
	    }
	   attr.editMode=document.getElementsByName("editMode")[i].value;
      }
	}
  	attr.action = document.tmp.action.value;
	attr.validateScript = document.tmp.validateScript.value;
	attr.processDescription = createRelStr();
	attr.filtercondition=document.tmp.filtercondition.value;
    attr.condition=document.tmp.condition.value;
	OBPM.dialog.doReturn(attr);
 	
}
function Operateselect(){
   var operator=document.all.operator;
   var operatmark=[">","<",">=","<=","<>","="];
    for(var i=0;i<operatmark.length;i++){
       var Opt=document.createElement("option");
           Opt.value=operatmark[i];
		   Opt.text=operatmark[i];
		   operator.options.add(Opt);
    }
    
}
function on_load()
{
    var oldAttr=OBPM.dialog.getArgs()['oldAttr'];
    Operateselect();
    tmp.name.value = HTMLDencode(oldAttr.name);
    tmp.condition.value = HTMLDencode(oldAttr.condition);
 	tmp.action.value = HTMLDencode(oldAttr.action);
	tmp.validateScript.value = HTMLDencode(oldAttr.validateScript);
	tmp.filtercondition.value =HTMLDencode(oldAttr.filtercondition);
	var editMode=HTMLDencode(oldAttr.editMode);
	
	var items=HTMLDencode(oldAttr.processDescription);
	     parseRelStr(items);

	initForm();
	modeChange(editMode);
	window.top.toThisHelpPage("application_module_workflows_relatenode");
}

function ev_close() {
  OBPM.dialog.doReturn();
 }
  // 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<4;i++){
		obj=document.getElementById("card"+i);
		obj.className="";
	}
	obj=document.getElementById("card"+cardID);
	obj.className="on";
	
	for (var i=1;i<4;i++){
		obj=document.getElementById("content"+i);
		obj.style.display="none";
	}
	obj=document.getElementById("content"+cardID);
	obj.style.display="";
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="on_load()">
<form name="tmp" method="post">
<table width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[RelationNodeInfo]*}</td>
		<td align="right">
		<table border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td  valign="top">
				<button type="button" class="button-image"
					onClick="ev_ok();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td valign="top">
				<button type="button" class="button-image"
					onClick="ev_close();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">&nbsp;
		
		</td>
	</tr>
</table>
<input type="hidden" name="fieldpermlist" value="" />
<input type="hidden" name="activityPermList" value="" />
<table class="table_noborder">
<tr>
	<td>
		{*[Name]*}：<input class="input-cmd"	type="text" name="name">
	</td>
</tr>
<!-- 
<table border=0 cellpadding=0 cellspacing=0 width="100%">
	<tr>
		<td colspan=6 class="commFont"></td>
	</tr>
	<tr>
	<td colspan="6">
	<table>
		<tr>
			<td class="card commFont" onClick="cardClick(1)" id="card1">{*[Path_Condition_Script]*}</td>
			
			<td class="card commFont" onClick="cardClick(2)" id="card2">{*[Path_Action_Script]*}</td>
			
			<td class="card commFont" onClick="cardClick(3)" id="card3">{*[Path_Validate_Script]*}</td>
		</tr>
	</table>
	</td>
	</tr>
</table>
 -->
<tr>
	<td>
	<ul class="crossUL">
		<li id="card1" onClick="cardClick(1)" class="on">{*[Path_Condition_Script]*}</li>
		<li id="card2" onClick="cardClick(2)">{*[Path_Action_Script]*}</li>
		<li id="card3" onClick="cardClick(3)">{*[Path_Validate_Script]*}</li>
	</ul>
	<div id="content1" style="clear: left;" class="contentDiv on">
		<table class="table_noborder">
			<tr>
				<td>
					<s:radio name="editMode"
						list="#{'00':'{*[Design]*}','01':'{*[cn.myapps.core.dynaform.form.iscript]*}'}"
						onclick="modeChange(this.value)" theme="simple" />
				</td>
			</tr>
			<tr id="editMode0">
				<td>
					<table class="table_noborder" border="1">
						<tr align="left">
							<td id="Formdislay" class="commFont">{*[Form]*}：<s:select name="formlist"
									list="#fh.get_formList(#parameters.application)" theme="simple" />
							</td>
						</tr>
						<tr>
							<td align="left" valign="top">
							<table class="table_noborder">
								<tr>
									<td colspan="6" class="commFont"></td>
								</tr>
								<tr>
									<td align="right">{*[Field]*}：</td>
									<td class="commFont" align="center"><select id="field" name="field" size="16"
										style="width:150" ondblclick="addData();" /></td>
									<td>{*[Compare]*}:</td>
									<td class="commFont"><select id="operator" name="operator"
										size="16" ondblclick="operateChange(this.value)"
										style="width:50;height: 200px;">
									</select></td>
									<td></td>
									<td>
									<table cellpadding=0 cellspacing=0>
										<tr>
											<td>
											<table border=0 cellpadding=0 cellspacing=0>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('ADD');"><img
														src="<s:url value="/resource/image/add2.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('MINUS');"><img
														src="<s:url value="/resource/image/del2.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image"
														onClick="changeRela('MULTIPLIED');"><img
														src="<s:url value="/resource/image/cheng.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image"
														onClick="changeRela('DIVIDED');"><img
														src="<s:url value="/resource/image/chu.gif"/>"></button>
													</td>
												</tr>
												<tr>
	
													<td>
													<button type="button" class="button-image" onClick="changeRela('AND');"><img
														src="<s:url value="/resource/image/and.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('OR');"><img
														src="<s:url value="/resource/image/or.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('NO');"><img
														src="<s:url value="/resource/image/f.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('LEFT');"><img
														src="<s:url value="/resource/image/left.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('RIGHT');"><img
														src="<s:url value="/resource/image/right.gif"/>"></button>
													</td>
												</tr>
												<tr>
													<td>
													<button type="button" class="button-image" onClick="changeRela('CLEAR');"><img
														src="<s:url value="/resource/image/clear.gif"/>"></button>
													</td>
												</tr>
											</table>
											</td>
											<td>{*[Activity]*}:</td>
											<td valign="top"><textarea name="processDescription"
												id="processDescription" cols="12" rows="16"></textarea></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
							<td style="display:none"><s:select id="fieldType"
								name="fieldType" list="{}" theme="simple" /></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr id="editMode1">
					<td><textarea name="condition" cols="85" rows="16"></textarea></td>
				</tr>
			</table>
	</div>
	<div id="content2" style="clear: left;" class="contentDiv on">
		<table class="table_noborder">
			<tr>
				<td width="100%">
					<textarea cssClass="input-cmd" name="action" cols="85" rows="18"></textarea>
				</td>
			</tr>
		</table>
	</div>
	<div id="content3" style="clear: left;" class="contentDiv on">
		<table class="table_noborder">
			<tr>
				<td width="100%">
					<textarea cssClass="input-cmd" name="validateScript" cols="85" rows="18"></textarea>
				</td>
			</tr>
		</table>
	</div>
	</td>
</tr>
</table>
<div style="display:none"><textarea name="filtercondition" cols="70"
	rows="3"></textarea></div>
<div style="display:none"><select id="selectid" name="fieldtoscript"
	style="width:100"></div>
</form>
<script language=javascript>
cardClick(1);
</script>
</body>
</o:MultiLanguage></html>
