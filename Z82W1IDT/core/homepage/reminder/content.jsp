<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>

<title>提醒信息</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/jquery.js'/>"></script>
<script src="<s:url value='/core/homepage/reminder/jquery.colorPicker.js'/>"></script>
<s:url action="save" id="doSaveURL">
	<s:param name="_currpage" value="datas.pageNo" />
	<s:param name="_pagelines" value="datas.linesPerPage" />
	<s:param name="_rowcount" value="datas.rowCount" />
</s:url>
<script language="JavaScript">
var $j = jQuery.noConflict(); 
var applicationId = '<%= request.getParameter("application")%>';
function addOptions(relatedFieldId, options, defValues){
	var el = document.getElementById(relatedFieldId);
	if(relatedFieldId){
		DWRUtil.removeAllOptions(relatedFieldId);
		DWRUtil.addOptions(relatedFieldId, options);
		if (defValues) {
			DWRUtil.setValue(relatedFieldId, defValues);
		}
		if (el.onchange && typeof(el.onchange) == "function") {
			el.onchange();
		}
	}
}

function addFormOptions(oModuleField, relatedFieldId, defValues) {
	FormHelper.get_formListByModule(oModuleField.value, function(options) {
		addOptions(relatedFieldId, options, defValues);
	});
}

function addFieldOptions(oFormField, relatedFieldId, defValues) {

	FormHelper.getFields(oFormField.value, function(options){
		var oFieldSelect = document.getElementById(relatedFieldId);
		var oSelectedList = document.getElementById("selectedList");
		DWRUtil.removeAllOptions(oSelectedList.id);
		addOptions(relatedFieldId, options, defValues);
		moveSelectedOptions(oFieldSelect, oSelectedList, false, '');
	});
}

function setSelectedValuesToField(oField, oSel, separator){
	if (!oField || oSel.options.length == 0) return;
	separator = separator ? separator : ";";
	oField.value = '';
	for (var i=0; i<oSel.options.length; i++) {
		var option = oSel.options[i];
		oField.value += option.value + separator;
		
	}
	oField.value = oField.value.substring(0, oField.value.length-1);
}

function getSelectedValuesByFiled(oField, separator) {
	if (!oField) return;
	separator = separator ? separator : ";";
	var valueList = oField.value.split(separator);
	return valueList;
}

function ev_OK(){
	if(validation()){
	    var oSel = document.getElementById("selectedList");
	   	var oField = document.getElementById("content.summaryFieldNames");
	   	setSelectedValuesToField(oField, oSel);
	   	var url='<s:property value="#doSaveURL" escape="false"/>';
	    document.forms[0].action = url;
		document.forms[0].submit();
	}
}

function ev_saveAndNew_OK(){
	if(validation()){
	    var oSel = document.getElementById("selectedList");
	   	var oField = document.getElementById("content.summaryFieldNames");
	   	setSelectedValuesToField(oField, oSel);
	    document.forms[0].action='<s:url action="saveAndNew"></s:url>';
		document.forms[0].submit();
	}
}

function validation(){
	var title = document.getElementsByName("content.title")[0];
	if(title.value==null || title.value==""){
		alert("{*[Please]*}{*[Input]*}{*[Title]*}");
		return false;
	}else return true;
}

window.onload = function (){
	var moduleSelect = document.getElementById("moduleSelect");
	var formSelect = document.getElementById("formSelect");
	var formDefValue = '<s:property value="content.formId" />';
	var fieldDefValues = getSelectedValuesByFiled(document.getElementById("content.summaryFieldNames"));
	// before initialize
	moduleSelect.onchange = function(){
		addFormOptions(moduleSelect, formSelect.id, formDefValue);
		moduleSelect.onchange = function(){
			addFormOptions(moduleSelect, formSelect.id);
		}
	}
	formSelect.onchange = function() {
		addFieldOptions(formSelect, "fieldSelect", fieldDefValues);
		formSelect.onchange = function(){
			//alert(document.getElementById("content.summaryFieldNames").value);
			//清空旧的选定字段值
			document.getElementById("content.summaryFieldNames").value="";
			addFieldOptions(formSelect, "fieldSelect");
		}
	}
	// initialize
	moduleSelect.onchange();
	modeChange('<s:property value="content.type" />');
	 var subject = document.getElementById("_style");
	 resplaceImg(subject.value);

	 inittab();
}

jQuery(document).ready(function (){
	if (parent && parent.parentWindow) {
		parent.parentWindow.document.forms[0].submit();
	}
	window.top.toThisHelpPage("application_info_generalTools_reminder_info");
});
function modeChange(value){
	if(value=='00'){
		document.getElementById("content0").style.display='';
		document.getElementById("content1").style.display='none';
	}
	if(value=='01'){
		document.getElementById("content1").style.display='';
		document.getElementById("content0").style.display='none';
	}
}
function checkTitle(value){
	if(value==null && value.trim().length>0){
		alert('Please Enter Title');
	}
}

function setColor(){
    var value=  document.getElementById('color').value;
    var values=  document.getElementById('content.bgcolor');
    if(value){
        values.value = value;    
    }
}
function init(){
   var images = document.getElementById("image1");
   resplaceImg(images.value);
}
function resplaceImg(value){
   var images = document.getElementById("image1");
   if(value==1){
   		images.src = '<s:url value="/resource/imgnew/pending_img5.gif"/>';
   }
   if(value==2){
   		images.src = '<s:url value="/resource/imgnew/pending_img1.gif"/>';
   }
   if(value==3){
   		images.src = '<s:url value="/resource/imgnew/pending_img2.gif"/>';
   }
   if(value==4){
   		images.src = '<s:url value="/resource/imgnew/pending_img3.gif"/>';
   }
   if(value==5){
   		images.src = '<s:url value="/resource/imgnew/pending_img4.gif"/>';
   }
}
</script>

</head>
<body id="application_info_generalTools_reminder_info" class="contentBody">
<s:form name="thisform" action="" method="post" theme="simple">
	<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper"
		id="formHelper">
		<s:param name="applicationid" value="%{#parameters.application}" />
		<s:param name="moduleid" value="_module" />
	</s:bean>
	<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
		id="mh">
		<s:param name="applicationid" value="%{#parameters.application}" />
	</s:bean>
	<s:bean name="cn.myapps.core.homepage.action.ReminderHelper" id="reminderHelper"></s:bean>

	<s:hidden name="application" value="%{#parameters.application}" />
	<s:hidden name="content.id" />
	<s:hidden name="content.sortId" />
	<s:hidden name="content.summaryFieldNames" />
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnReminder'}" />	
	<s:hidden name="homePageId" />
	
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
				        <td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onclick="ev_saveAndNew_OK();"><img
								src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="save"></s:url>';ev_OK();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>	
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<table class="table_noborder id1">
			<tr>
				<td class="commFont"></td>
				<td class="commFont"><s:radio name="content.type"
						label="{*[Type]*}" list="#{'00':'{*[Design]*}','01':'{*[cn.myapps.core.dynaform.form.iscript]*}'}"
						onclick="modeChange(this.value)" theme="simple" value="content.type"/></td>
			</tr>
			<tr>
				<td class="commFont">{*[Title]*}：</td>
				<td class="commFont" rowspan="7" height="380px" valign="top">
					<table id="content0" class="table_noborder" height="100%">
						<tr>
							<td class="commFont">{*[Module]*}：</td>
						</tr>
						<tr>
							<td><s:select id="moduleSelect" name="content.moduleid"
							list="#mh.getModuleSel(#parameters.application)"
							cssClass="input-cmd" /></td>
						</tr>
						<tr>
							<td class="commFont">{*[Form]*}：</td>
						</tr>
						<tr>
							<td><s:select id="formSelect" name="content.formId" list="#{}"
							cssClass="input-cmd" onchange="addFieldOptions(this, 'fieldSelect')" /></td>
						</tr>
						<tr>
							<td class="commFont">{*[Fields]*}：</td>
						</tr>
						<tr>
							<td align="left">
								<s:optiontransferselect id="fieldSelect"  
										tooltip="Select fields to summary" name="fieldName" theme="simple"
										leftTitle="{*[All_Fields]*}" multiple="true" emptyOption="true"
										rightTitle="{*[Show]*}{*[Fields]*}" list="{}" 
										addToRightLabel="向右移动"
										addToLeftLabel="向左移动"
										addAllToRightLabel="全部右移"
										addAllToLeftLabel="全部左移"
										selectAllLabel="全部选择"
										doubleId="selectedList" 
										doubleList="{}" doubleName="selectedFieldName"
										doubleCssStyle="height:10px;"
										 />
								<script language="javascript">
									jQuery(function(){
										jQuery("#selectedFieldName").height("210");
									});
								</script>
								
							</td>
						</tr>
					</table>
					<div id="content1" style="display: none"><s:textarea cssClass="height:300px;width:300px;"
						label="{*[Filter_Script]*}" name="content.filterScript" cols="65"
						rows="20" theme="simple" /></div>
				</td>
			</tr>
			<tr>
				<td><s:textfield cssClass="input-cmd" name="content.title"/></td>
			</tr>
			<tr>
				<td class="commFont">{*[OrderBy]*}：</td>
			</tr>
			<tr>
				<td><s:select name="content.orderby"
					list="#{'CREATED':'{*[CREATED]*}','LASTMODIFIED':'{*[LAST_MODIFIED]*}'}"
					cssClass="input-cmd" emptyOption="true" /></td>
			</tr>
			
		    <tr>
		        <td class="commFont">{*[Style]*}：</td>
		        
		    </tr>
		    <tr>
		        <td><s:select id="_style" name="_styles"
					list="#reminderHelper.getStyleList()"
					cssClass="input-cmd" onchange="resplaceImg(this.value);"/></td>
			</tr>
			
			
			<tr height="130px;">
		        <td class="commFont" valign="top">
		        	<img alt="pending-head" id="image1"	src="" />
		        </td>
		    </tr>
		</table>
	</div>
</s:form>
</body>
</html>

</o:MultiLanguage>
