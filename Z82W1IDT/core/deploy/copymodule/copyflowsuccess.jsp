<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[Module]*}</title>
	<script src="<s:url value='copymodule.js'/>"></script>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {
	color: #000000
}
-->
</style>
	</head>
	<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
	<s:form action="" method="post">
       <s:hidden name="s_module" value="%{#parameters.s_module}" />
       <s:hidden name="moduleid" value="%{content.moduleId}" />
       <s:hidden name="applicationid" value="%{#parameters.applicationid}" />
       <s:hidden name="application" value="%{#parameters.application}" />
	   
	   <table width="100%" height="359" border="1" class="list-table"
			valign="bottom" cellpadding="0" cellspacing="0" bordercolor="#999999">
			<tr bgcolor="#CCCCCC">
				<td width="100%" height="26" class="STYLE2" class="commFont">{*[page.copyflow.success.title]*}</td>
			</tr>
			<tr>
			<tr valign="top" align="center">
				<td height="334"><%@include file="/common/msg.jsp"%>
				<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
					<%@include file="/portal/share/common/msgbox/msg.jsp"%>
				</s:if>
				<table>
					<tr>
						<td class="commFont"></td>
						<td class="commFont"></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td></td>
						<td class="commFont">{*[page.copyflow.success]*}</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<button type="button" onClick="doCancel();">{*[Finish]*}</button>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>
