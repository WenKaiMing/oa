<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<title>{*[StateLabel]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">

<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script type="text/javascript">
//去所有空格
String.prototype.trimAll = function(){   
    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
};  

function checkSpace(s){
	s.value=s.value.trimAll();
}

function checkForm(){
	/*var name=document.getElementsByName("content.name")[0];
	var value=document.getElementsByName("content.value")[0];
	var description=document.getElementsByName("content.description")[0];
	var orderNo=document.getElementsByName("content.orderNo")[0];
	if(null==value.value || ""==value.value){
		alert("请输入{*[Value]*}!");
	}else if(name.value.length>255){
		alert("{*[Name]*}{*[Length]*}不能超过255个{*[Character]*}");
		return false;
	}else if(value.value.length>255){
		alert("{*[Value]*}{*[Length]*}不能超过255个{*[Character]*}");
		return false;
	}else if(description.value.length>255){
		alert("{*[Description]*}{*[Length]*}不能超过255个{*[Character]*}");
		return false;
	}else if(orderNo.value.length>255){
		alert("{*[OrderNumber]*}{*[Length]*}不能超过255个{*[Character]*}");
		return false;
	}else return true;*/
	var name=document.getElementsByName("content.name")[0];
	var value=document.getElementsByName("content.value")[0];
	if(name.value==null || name.value==""){
		alert("{*[cn.myapps.core.workflow.statelabel.please_input_name]*}");
		return false;
	}else if(value.value==null || value.value==""){
		alert("{*[cn.myapps.core.workflow.statelabel.please_input_value]*}");
		return false;
	}else return true;
}

function doSave(){
	if(checkForm()){
		var formItem = document.getElementById("formItem");
		formItem.action='<s:url action="save"><s:param name="tab" value="1"/><s:param name="selected" value="%{\'btnStateLabel\'}"/></s:url>';
		formItem.submit();
	}
}

function doSaveAndNew(){
	if(checkForm()){
		var formItem = document.getElementById("formItem");
		formItem.action='<s:url action="saveAndNew"></s:url>';
		formItem.submit();
	}

}

jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_generalTools_stateLabel_info");
});
</script>

</head>
<body id="application_info_generalTools_stateLabel_info" class="contentBody">
<s:form id="formItem" action="save" method="post"  validate="true" theme="simple">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_value" value="%{#parameters.sm_value}"/>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td"  style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onclick="doSaveAndNew()"><img
								src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
							<button type="button" class="button-image"
								onClick="doSave()"><img
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
	<div class="navigation_title">{*[StateLabel]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table width="100%" class="id1">
			<s:textfield name="tab" cssStyle="display:none;" value="1" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnStateLabel'}" />
			<tr>
				<td class="commFont">{*[Name]*}:</td>
				<td class="commFont">{*[cn.myapps.core.workflow.label.value]*}:</td>
			</tr>
			<tr>			
				<td><s:textfield theme="simple" cssClass="input-cmd" label="{*[Name]*}"
				name="content.name" onblur="checkSpace(this)" maxlength="255"/></td>
				<td><s:textfield theme="simple" cssClass="input-cmd" label="{*[Value]*}"
				name="content.value" onblur="checkSpace(this)" maxlength="255"/></td>
			</tr>
			<tr class="seperate">
				<td class="commFont">{*[Description]*}:</td>
				<td class="commFont">{*[OrderNumber]*}:</td>
			</tr>
		  	<tr>	  		
		  		<td><s:textarea rows="4" theme="simple" cssClass="input-cmd" label="{*[Description]*}"
				name="content.description" onblur="checkSpace(this)" /></td>
		  		<td valign="top"><s:textfield  theme="simple" cssClass="input-cmd" label="{*[OrderNumber]*}"
				name="content.orderNo" onblur="checkSpace(this)" /></td>
			</tr>		
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
