<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String contextPath=request.getContextPath();
%>
<html>
<o:MultiLanguage>
<head>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{*[cn.myapps.core.main.domain_info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script>
	jQuery(document).ready(function(){
		window.top.toThisHelpPage("domain_info");
	});
</script>
</head>
<body id="domain_info" class="contentBody">
<s:form id="domainForm" action="save" method="post" theme="simple">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_users.loginno" value="%{#parameters['sm_users.loginno']}"/>
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.main.domain_info]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<s:if test="synchronize == 'true'">
						<button type="button" id="synchronize" class="button-image" onclick="forms[0].action='<s:url action="synchLDAP"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[core.domain.synchLDAP]*}</button>
						</s:if>
						<button type="button" id="btnSave" class="button-image" onclick="forms[0].action='<s:url action="saveBasic" />';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" />{*[Save]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/basic.jsp" %>
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<table class="table_noborder id1" border="0">
			<tr>
				<td class="commFont">{*[Domain]*}{*[Name]*}：</td>
				<td class="commFont">{*[Description]*}：</td>
			</tr>
			<tr>
				<td><s:textfield cssClass="input-cmd" name="content.name" /></td>
				<td rowspan="3"><s:textarea cssClass="input-cmd" cols="43" rows="2"
					label="{*[Description]*}" name="content.description" /></td>
			</tr>
	
			<tr>
				<td class="commFont">{*[Status]*}：</td>
			</tr>
			<tr>
				<td>
					<s:radio label="{*[Status]*}" name="_strstatus" theme="simple"	list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" /></td>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
