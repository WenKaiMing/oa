<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="GB2312"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>download</title>
</head>
<body>
	<% 
		String contextPath = request.getContextPath();
		String filePath = (String) request.getAttribute("filePath");
		new OBPMDispatcher().sendRedirect(contextPath + filePath,request, response);
	%>
</body>
</o:MultiLanguage></html>