<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
String username = user.getName();
%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" /> 
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script>
function returncheck(){
    var mode = document.getElementById('mode').value;
    if(mode==''){
    	document.getElementById('s_module').value='';
    }
    document.forms[0].action="<s:url action='list.action'/>";
    document.forms[0].submit();
}

jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_libraries_macroLibs_info");
});

function checkForm(){
	var name=document.getElementsByName("content.name")[0];
	var content=document.getElementsByName("content.content")[0];
	if(name.value==null || name.value==""){
		alert("{*[cn.myapps.core.validate.repository.please_input_name]*}");
		return false;
	}
	else if(content.value==null || content.value==""){
		alert("{*[cn.myapps.core.validate.repository.please_input_content]*}");
		return false;
	}
	else return true;
}

function ev_save(){
	if(checkForm()){
		document.forms[0].action='<s:url action="save"></s:url>';
		document.forms[0].submit();
	}
}

</script>
<title>{*[Macro_Library]*}{*[Info]*}</title>
</head>
<body class="contentBody">
<s:form action="save" method="post" theme="simple">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_content" value="%{#parameters.sm_content}"/>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td"  style="height:27px;">
				<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
				<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image"
								onClick="ev_save()"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="list"><s:param name="s_applicationid" value="#parameters.application" /></s:url>';forms[0].submit();"><img
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
	<div class="navigation_title">{*[MacroLibs]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1" height="85%">
			<s:textfield name="tab" cssStyle="display:none;" value="2" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnMacroLibs'}" />
			<s:hidden name='content.version'></s:hidden>
		   	<tr><td class="commFont">{*[Name]*}:</td></tr>
			<tr><td><s:textfield cssClass="input-cmd" theme="simple" name="content.name" /></td></tr>
			<s:hidden id="application" name='content.applicationid' value="%{#parameters.application}" />
			<!-- 
			<tr>
				<td class="commFont">{*[Application]*}:</td>
		   	</tr>
		   	<tr>
		   		<td>
					<s:select label="{*[Application]*}" name="content.applicationid"  list="_applications" theme='simple' emptyOption="true" />
					
				</td>
		   	</tr>
		   	 -->
			<tr><td class="commFont">{*[Content]*}:  <button type="button" class="button-image" onclick="openIscriptEditor('content.content','{*[Script]*}{*[Editor]*}','{*[Macro_Library]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td></tr>
			<tr style="height:90%;"><td valign="top"><s:textarea cssClass="content-textarea" rows="15" theme="simple" name="content.content"/></td></tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
