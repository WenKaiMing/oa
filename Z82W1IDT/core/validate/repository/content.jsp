<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" /> 
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script>
function returncheck()
{

     var mode = document.getElementById('mode').value;
     if(mode=='application'){document.getElementById('s_module').value='';}
     document.forms[0].action="<s:url action='list.action'/>";
     document.forms[0].submit();
 
   
}
jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_libraries_validateLibs_info");
});
</script>
<title>{*[ValidateLibs]*}{*[Info]*}</title>
</head>
<body id="application_info_libraries_validateLibs_info" class="contentBody">
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
								onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img
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
	<div class="navigation_title">{*[ValidateLibs]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table class="table_border id1">
			<s:hidden name='s_module' value="%{#parameters._moduleid}" />
			<s:hidden name='content.version'></s:hidden>
			<s:hidden name='mode' value="%{#parameters.mode}" />
			<s:textfield name="tab" cssStyle="display:none;" value="2" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnValidateLibs'}" />
			<tr><td class="commFont">{*[Name]*}:</td></tr>
			<tr><td width="90%"><s:textfield cssClass="input-cmd" label="{*[Name]*}" theme="simple" name="content.name" /></td></tr>
			<tr><td class="commFont">{*[Content]*}:  <button type="button" class="button-image" onclick="openIscriptEditor('content.content','{*[Script]*}{*[Editor]*}','{*[Macro_Library]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td></tr>
			<tr>
			<td valign="top">
				<s:textarea cssClass="content-textarea" rows="25" theme="simple" name="content.content"/>
			</td></tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
