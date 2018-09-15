<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>FCKeditor - Sample</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex, nofollow" />
<link href="../sample.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="fckeditor.js"></script>
</head>
<body>
	<% 
		String content=request.getParameter("content");
		if (content != null) {
			content = content.replaceAll("\r\n", "");
			content = content.replaceAll("\r", "");
			content = content.replaceAll("\n", "");
			content = content.replaceAll("\"", "'");
		}else{
			content = "";
		}
	%>	
	<span><%=content%></span>
</body>
</html>
