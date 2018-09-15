<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
	String helpnodeid = request.getParameter("id");
%>
<html><o:MultiLanguage>
<head>
<title>domain/HelpContent.jsp</title>
<link rel="stylesheet" href="<s:url value='/core/helper/helper.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
	var helpnodeid='<%=helpnodeid%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>

</head>
<body style="margin: 0px;padding: 0px;">
	function/HelpContent.jsp
</body>
</o:MultiLanguage></html>
