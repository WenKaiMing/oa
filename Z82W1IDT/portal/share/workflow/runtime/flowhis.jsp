<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.*"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.dynaform.document.action.DocumentHelper"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@page import="cn.myapps.core.workflow.storage.runtime.ejb.FlowStateRTProcess"%>
<%@page import="cn.myapps.core.workflow.storage.runtime.ejb.FlowStateRTProcessBean"%>
<%@page import="cn.myapps.core.workflow.storage.runtime.ejb.FlowStateRT"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
<head>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
</head>
<body>
<table width="100%" height="100%">
<tr><td height="90%">
<%=DocumentHelper.toHistoryHtml(request)%>
</td></tr>
<tr><td align="center"><br>
	<input type="button" value="{*[Refresh]*}" onClick="javascript:window.location.reload();" />
	<input type="button" value="{*[Close]*}" onClick="OBPM.dialog.doExit()" />
</td></tr>
</table>
</body></html>
</o:MultiLanguage>
