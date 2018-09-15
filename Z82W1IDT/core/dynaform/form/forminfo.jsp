<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>


<%@page import="cn.myapps.core.dynaform.form.constants.ConfirmConstant"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<o:MultiLanguage>
<html>
<head>
<title>{*[{*[Create Form]*}]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url id="url" value='/resourse/main.css'/>" />
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script>

</script>
<body>
<s:form name="thisform" action="save" method="post">
	<s:bean
		name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
		id="sh">
		<s:param name="applicationid" value="#parameters.application" />
		<s:param name="moduleid" value="#parameters.s_module" />
	</s:bean>
	<%@include file="/common/page.jsp"%>
	<s:hidden name='content.version'></s:hidden>
	<s:hidden name="content.titlescript" />
	<input type="hidden" name="applicationid"
		value="<s:property value='#parameters.application'/>">
	<input type="hidden" name="s_application"
		value="<s:property value='#parameters.application'/>">
	<input type="hidden" name="s_module"
		value="<s:property value='#parameters.s_module'/>">
	<input type="hidden" name="moduleid"
		value="<s:property value='#parameters.s_module'/>">
	<div style="display:none"><s:textarea
		label="Form在{*[Module content]*}" name="content.templatecontext"
		theme="simple" /></div>
	<table width="100%">
		<tr>
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="90" class="text-label">{*[Create Form]*}</td>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0"
				class="line-position">
				<tr>
					<td></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<s:if test="hasFieldErrors()">
		<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
		<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
	</s:if>
	<s:iterator value="confirms" status="row">
			<s:if
				test="msgKeyCode == @cn.myapps.core.dynaform.form.constants.ConfirmConstant@FORM_EXIST">
				<%@include file="confirm/formexist.jsp"%>
			</s:if>
	</s:iterator>		
	<table width="70%" border=0 align='center'>
		<tr>
			<td class="commFont">{*[Name]*}:</td>
			<td align="left"><s:textfield size="25" name="content.name"
				theme="simple" /></td>
		</tr>
		<tr>
			<td class="commFont">{*[Type]*}:</td>
			<td align="left"><s:select name="content.type" list="_FORMTYPE"
				theme="simple" /></td>
		</tr>
		<tr>
			<td class="commFont">{*[StyleLib]*}:</td>
			<td><s:select cssClass="select-size" label="{*[StyleLib]*}"
				name="_styleid" list="#sh.get_listStyleByApp(#parameters.application)"
				listKey="id" listValue="name" emptyOption="true" theme="simple" /></td>
		</tr>
		<tr>
			<td class="commFont" colspan="2">{*[Description]*}:</td>
		</tr>
		<tr>
			<td colspan="2"><s:textarea cols="70" rows="5" cssClass="input-cmd"
				name="content.discription" theme="simple" /></td>
		</tr>
		<tr>
			<td class="commFont" colspan="2" align="center">
			<button type="button" onClick="forms[0].action='<s:url action="saveforminfo"></s:url>';forms[0].submit();">{*[Confirm]*}</button>
			&nbsp;
			<button type="button" onClick="if(parent){parent.close()}else{window.close();}">{*[Cancel]*}</button>
			</td>
		</tr>
	</table>
</s:form>

</body>
</html>
</o:MultiLanguage>
