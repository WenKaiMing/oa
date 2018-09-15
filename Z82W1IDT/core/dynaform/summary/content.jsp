<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%String contextPath = request.getContextPath();%>

<html><o:MultiLanguage>
	<head>
	<title>{*[Summary]*}{*[Info]*}</title>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/CrossReportHelper.js"/>'></script>
	<script src="<s:url value='/script/util.js'/>"></script>

	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script type="text/javascript" language="javascript">
var contextPath = '<%=contextPath%>';
var formId = '';
window.onload=function(){
	window.top.toThisHelpPage("application_module_form_reminder_info");
	if(document.getElementsByName("content.formId")[0].value.length>0){
		formId = document.getElementsByName("content.formId")[0].value;
	}else{
		formId = '<s:property value="#parameters['content.formId']"/>';
	}
	
	ev_init();
	re_size();
	
	var fieldDefValues = getSelectedValuesByFiled(document.getElementById("content.fieldNames"));
	addFieldOptions("fieldSelect", fieldDefValues);
	
	modeChange('<s:property value="content.type" />');
	document.getElementById("fieldSelect").style.width=120;
	document.getElementById("selectedList").style.width=120;

	ev_onScopeChange('<s:property value="content.scope" />');

	if(jQuery("#formItem_content_summaryCfg_type00").attr("checked")==false && jQuery("#formItem_content_summaryCfg_type01").attr("checked")==false){
		jQuery("#formItem_content_summaryCfg_type00").attr("checked",true);
	}
};
function getSelectedValuesByFiled(oField, separator) {
	if (!oField) return;
	 oField.value.replace("")
	separator = separator ? separator : ";";
	var valueList = oField.value.split(separator);
	return valueList;
}
function ev_init(){
	if (formId.length>0){
	FormHelper.getAllFields(formId,false, function(options) {
			//addOptions("fieldSelect", options);
			//initfields();
			//ev_switchpage(mode);
			//reSize();
			//initRows(); 
		});
	}
}

function addOptions2(relatedFieldId, options, defValues){
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

function addFieldOptions(relatedFieldId, defValues) {

	FormHelper.getFields(formId, function(options){
		
		var oFieldSelect = document.getElementById(relatedFieldId);
		var oSelectedList = document.getElementById("selectedList");
		DWRUtil.removeAllOptions(oSelectedList.id);
		addOptions2(relatedFieldId, options, defValues);
		moveSelectedOptions(oFieldSelect, oSelectedList, false, '');
	});
}

function modeChange(value){
	if(value=='00'){
		document.getElementById("docSummaryCfg_type_00").style.display='';
		document.getElementById("docSummaryCfg_type_01").style.display='none';
	}
	if(value=='01'){
		document.getElementById("docSummaryCfg_type_01").style.display='';
		document.getElementById("docSummaryCfg_type_00").style.display='none';
	}
}

function doSave(type){
	var oSel = document.getElementById("selectedList");
	var oField = document.getElementById("content.fieldNames");
	var oType = document.getElementsByName("content.type")[0];
	var oScope = document.getElementsByName("content.scope")[0];
	
	if(oScope.value != 6 && oType.checked && oSel.options.length == 0){
		alert("{*[show.fields.is.empty]*}!");
		return;
	}
	setSelectedValuesToField(oField, oSel);
	 
	 
	if('save'==type){
		document.forms[0].submit();
	}
}

function setSelectedValuesToField(oField, oSel, separator){
	if (!oField || oSel.options.length == 0){
		oField.value ="";
		 return;
	}
	separator = separator ? separator : ";";
	oField.value = '';
	for (var i=0; i<oSel.options.length; i++) {
		var option = oSel.options[i];
		oField.value += option.value + separator;
		
	}
	oField.value = oField.value.substring(0, oField.value.length-1);
}

function ev_onScopeChange(value){
	
	var type_lable_tr = document.getElementById("type_lable_tr");
	var type_des_tr = document.getElementById("type_des_tr");
	var docSummaryCfg_type_00 = document.getElementById("docSummaryCfg_type_00");
	var docSummaryCfg_type_01 = document.getElementById("docSummaryCfg_type_01");
	
	if(value==6){
		type_lable_tr.style.display='none';
		type_des_tr.style.display='none';
		docSummaryCfg_type_00.style.display='none';
		docSummaryCfg_type_01.style.display='none';
	}else {
		type_lable_tr.style.display='';
		type_des_tr.style.display='';
		modeChange('<s:property value="content.type" />');
	}
}

function re_size(){
	var bodyW = jQuery("#application_info_generalTools_links_info").width();
	jQuery("#navTable").width(bodyW);
	jQuery("#contentMainDiv").width(bodyW);
}

jQuery(window).resize(function(){
	re_size();
});
</script>

	</head>
	<body id="application_info_generalTools_links_info" class="contentBody">
	<table id="navTable" cellpadding="0" cellspacing="0">
		<tr>
			<td class="nav-s-td" align="right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr >
					<td valign="top" width="80%"></td>
					<td valign="top">
					<button type="button" class="button-image" onClick="doSave('save');"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					</td>
					<td valign="top">
					<button type="button" class="button-image" 
						onClick="OBPM.dialog.doReturn();"><img
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
	<s:form action="save" method="post"
		theme="simple" name="summaryCfg" validate="true">
	<s:bean name="cn.myapps.core.dynaform.summary.action.SummaryCfgHelper" id="summaryCfgHelper"></s:bean>
	<s:hidden name='content.id' />
	<s:hidden name='content.formId' />
	<s:hidden name='content.applicationid' />
		<td>
			<table  width="80%" border="0" cellpadding="0" cellspacing="0" width="100%" class="id1">
			  <tr>
			    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
			    	<tr>
			        <td><span class="commFont">{*[Title]*}:</span></td>
		          </tr>
			      <tr>
			        <td><s:textfield cssClass="input-cmd" name='content.title' /></td>
		          </tr>
		          <tr>
			        <td><span class="commFont">{*[cn.myapps.core.dynaform.summary.label.scope]*}:</span></td>
		          </tr>
			      <tr>
			        <td><s:select name="content.scope"
										list="#{0:'{*[core.dynaform.form.summary.scope.pending]*}',1:'{*[core.dynaform.form.summary.scope.flowNotice]*}',6:'{*[core.dynaform.form.summary.scope.flowCc]*}'}"
										cssClass="input-cmd" onchange="ev_onScopeChange(this.value)" /></td>
		          </tr>
		        </table></td>
			    <td ><table width="100%" border="0" cellspacing="0" cellpadding="4">
			      <tr id="type_lable_tr">
			        <td style="width: 100%;"><span class="commFont">{*[cn.myapps.core.dynaform.summary.custom_content]*}:</span></td>
		          </tr>
			      <tr id="type_des_tr">
			        <td style="width: 100%;"><s:radio  name="content.type"
					                            label="{*[Type]*}" list="#{'00':'{*[Design]*}','01':'{*[Script]*}'}"
					                            onclick="modeChange(this.value)" /></td>
		          </tr>
			      <tr>
			        <td style="width: 100%;"><div id="docSummaryCfg_type_00">
															<s:optiontransferselect id="fieldSelect"  
																tooltip="Select fields to summary" name="fieldNames" theme="simple"
																leftTitle="{*[cn.myapps.core.dynaform.summary.label.allFields]*}" multiple="true" emptyOption="true"
																rightTitle="{*[Show]*}{*[Fields]*}" list="{}" 
																addToRightLabel="  >  "
																addToLeftLabel="  <  "
																doubleId="selectedList" 
																doubleList="{}" doubleName="selectedFieldNames"
															 />
															 
															 <s:hidden id="content.fieldNames" name="content.fieldNames"/>
															</div>
															
															<div id="docSummaryCfg_type_01" style="display: none;">
															<table>
															<tr><td><button type="button" class="button-image" onclick="openIscriptEditor('content.summaryScript','{*[Script]*}{*[Editor]*}','{*[SummaryScript]*}','content.title','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
															</td></tr>
															<tr><td><s:textarea cssClass="height:150px;width:200px;"
																	label="{*[Script]*}" name="content.summaryScript" cols="45"
																	rows="20" theme="simple" />
															</td></tr>
															</table>
																
																
															</div></td>
		          </tr>
		        </table></td>
		      </tr>
</table>
	
		</td>
		
		
	</s:form></div>
</body>
</o:MultiLanguage></html>
