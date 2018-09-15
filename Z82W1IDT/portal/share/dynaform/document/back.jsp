<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="cn.myapps.util.OBPMDispatcher"%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>back</title>
</head>
<body>
	<% 
		String backURL = request.getParameter("_backURL");
		new OBPMDispatcher().sendRedirect(backURL,request, response);
	%>
</body>
</o:MultiLanguage></html>