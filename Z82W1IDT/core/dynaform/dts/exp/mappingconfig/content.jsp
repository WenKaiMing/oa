<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<title>{*[MappingConfig ]*}</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script src="<s:url value='/script/list.js'/>"></script>
<script language="JavaScript" type="text/javascript">
function ev_preview(){
}

function ev_switchpage(sId) {
	document.getElementById('basicpage').style.display="none";
	document.getElementById('cloumnFrame').style.display="none";
		
	document.getElementById(sId).style.display="";

}


</script>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>

<!-- 
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh"/>
 -->
<s:bean name="cn.myapps.core.dynaform.dts.datasource.action.DatasourceHelper" id="dh"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="12"><img src='<s:url value="/resource/img/hen01.gif"/>' width="12" height="28" /></td>
		<td width="12" height="28" background='<s:url value="/resource/img/hen02.gif"/>'><img
			src='<s:url value="/resource/img/dian.gif"/>' width="12" height="12" /></td>
		<td align="left" background='<s:url value="/resource/img/hen02.gif"/>'>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50%" align="left">
				<table width="140" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="64" align="center"></td>
						<td width="64" align="center"></td>
					</tr>
				</table>
				</td>
				<td width="50%" align="right">
				<table width="240" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="7" align="left"></td>
						<td width="26" align="left"></td>
						<td width="49" align="left" ></td>
						<td width="6" align="left"><img src='<s:url value="/resource/img/hen03b.gif"/>' width="6"
							height="28" /></td>
						<td width="23" align="left"><button type="button" id="save_btn"  class="button-class"   height="22px" onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();">
					<img src="<s:url value="/resource/img/hen04save.gif"/>"  height="22" width="26">
				   </button></td>
						<td width="47" align="left" style="font-size:14px;">{*[Save]*}</td>
						<td width="6" align="left"><img src='<s:url value="/resource/img/hen03b.gif"/>' alt=""
							width="6" height="28" /></td>
						<td width="25" align="left"><button type="button"  class="button-class"  height="22px"
					onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/img/exit.gif"/>"  height="22" width="25"></button></td>
						<td width="47" align="left" style="font-size:14px;">{*[Exit]*}</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td width="8"><img src='<s:url value="/resource/img/hen05.gif"/>' width="8" height="28" /></td>
	</tr>
</table>
<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
</s:if>
<table width='100%'>
	<tr valign='top' height='20'>
		<td>
		<table>
			<tr>
				<td><input class="button-cmd" type="button"
					onclick="ev_switchpage('basicpage')" value="{*[Basic]*}" /> <s:if
					test="content.id!=null && content.id!=''">
					<input class="button-cmd" type="button"
						onclick="ev_switchpage('cloumnFrame')" value="{*[Column]*}" />
				</s:if> </td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id='basicpage'>
		<td><s:form name="viewform" action="save" method="post">
			<table>
			<tr><td class="commFont"></td><td></td></tr>
			<%@include file="/common/page.jsp"%>
			<input type="hidden" name="_appid"
				value='<s:property value="#parameters['_appid']"/>' />
			<input type="hidden" name="s_application" value='<s:property value="#parameters['_appid']"/>' />	
			<input type="hidden" name="_moduleid"
				value='<s:property value="#parameters['_moduleid']"/>' />
				<input type="hidden" name="s_module" value='<s:property value="#parameters['_moduleid']"/>' />	
				<input type="hidden" name="mode"
				value='<s:property value="#parameters['mode']"/>' />
			<tr><td class="commFont">{*[Name]*}:</td><td><s:textfield cssClass="input-cmd"  theme="simple"
				name="content.name" /></td></tr>
			<tr><td class="commFont">{*[Table Name]*}:</td><td><s:textfield cssClass="input-cmd" theme="simple"
			 name="content.tablename" /></td></tr>
			
			<tr><td class="commFont">{*[Description]*}:</td><td><s:textfield cssClass="input-cmd" theme="simple"
				 name="content.description" /></td></tr>
		
		  <tr><td class="commFont">{*[DataSource]*}:</td>
		  <td><s:select   name="_ds"  theme="simple" list="#dh.getAllDatasource(#parameters.application)"  emptyOption="true" /> </td></tr>
		 
			<tr><td class="commFont">{*[Value_Script]*}:</td><td><s:textarea cssClass="input-cmd"  theme="simple"
				name="content.valuescript" cols="40" rows="5" /></td></tr>
			
		  </s:form></table></td>
		  
	</tr>
	<tr id='columnMapping' style='display:none'>
		<td>
		<div id="div_cloumn"><iframe name="cloumnFrame" style="display:none" scrolling="no"
			src='<s:url value="/core/dynaform/dts/exp/columnmapping/list.action" />?mappingid=<s:property value="content.id"/>&s_application=<s:property value="#parameters['_appid']"/>&s_module=<s:property value="#parameters['_moduleid']"/>&s_mappingConfig=<s:property value="content.id"/>&mode=<s:property value="#parameters['mode']"/>'
			width="100%" height="330" frameborder="0" /></iframe></div>

		</td>
	</tr>
	
	</table>
</body>
</o:MultiLanguage></html>
