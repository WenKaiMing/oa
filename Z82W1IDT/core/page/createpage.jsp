<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head>
<title>{*[Create_Page]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url id="url" value='/resourse/main.css'/>" />
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<body class="contentBody" style="overflow: hidden;">
<s:form name="thisform" action="save" method="post">
	<table class="table_noborder">
		<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Create_Page]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button"	class="button-image" onClick="forms[0].action='<s:url action="savepageinfo"></s:url>';forms[0].submit();">{*[Confirm]*}</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">{*[Cancel]*}</button>
				</div>
			</td>
		</tr>
			<tr>
				<td colspan="2"
					style="border-top: 1px solid dotted; border-color: black;">
				&nbsp;</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div style="margin: 10px;">
		<s:bean
			name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
			id="sh">
		    <s:param name="applicationid" value="#parameters.application" />
			<s:param name="moduleid" value="#parameters.s_module" />
		</s:bean>
		<%@include file="/common/page.jsp"%>
		<s:hidden name='content.version'></s:hidden>
		<s:hidden name="content.applicationid" value="%{#parameters.application}" />
		<s:hidden name="content.titlescript" />
		<s:textfield name="tab" cssStyle="display:none;" value="3" />
		<s:textfield name="selected" cssStyle="display:none;" value="%{'btnPage'}" />
		<input type="hidden" name="s_module"
			value="<s:property value='#parameters.s_module'/>">
		<input type="hidden" name="moduleid"
			value="<s:property value='#parameters.s_module'/>">
		<s:textarea cssStyle="display:none;" name="content.templatecontext" theme="simple" />
		<table class="table_noborder id1">
				<tr>
					<td align="left" width="50%">{*[Name]*}:</td>
				</tr>
				<tr>
					<td align="left"><s:textfield cssClass="input-cmd" size="25" name="content.name"
						theme="simple" /></td>
				</tr>
				<tr>
					<td align="left" width="50%">{*[DEFAULT]*}:</td>
				</tr>
				<tr>				
					<td align="left"><s:radio name="_default"
						list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple" /></td>
				</tr>
				
				<tr>
					<td align="left" width="50%">{*[StyleLib]*}:</td>
				</tr>
				
				<tr>
					<td><s:select cssClass="input-cmd" label="{*[StyleLib]*}"
						name="_styleid" list="#sh.get_listStyleByApp(#parameters.application)"
						listKey="id" listValue="name" emptyOption="true" theme="simple" /></td>
				</tr>
				
				<tr>
					
					<td align="left" width="50%">{*[Description]*}:</td>
				</tr>
				<tr>			
					
					<td><s:textarea cols="70" rows="5" cssClass="input-cmd"
						name="content.discription" theme="simple" />
						<s:hidden name="content.type" value="4096"/>
					</td>
				</tr>
			</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
