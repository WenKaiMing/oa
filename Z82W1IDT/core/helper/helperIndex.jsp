<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
	String helpnodeid = request.getParameter("id");
%>
<html><o:MultiLanguage>
<head>
<title>{*[Helper]*}{*[Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
	var helpnodeid='<%=helpnodeid%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>
<script>
	jQuery(document).ready(function(){
		jQuery("#title").html("<span class='selectHelp'>"+helpnodeid+"</span>");
		initGetHelpTree(helpnodeid);
	});
</script>
</head>
<body style="margin: 0px;padding: 0px;">
<input type="button" value="{*[Back]*}" onclick="parent.showHelpContentToBack()"><br>
<div id="main">
	<div id="title"></div>
	<div id="helpTree"></div>
</div>
</body>
</o:MultiLanguage></html>
