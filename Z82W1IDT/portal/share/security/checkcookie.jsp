<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="cn.myapps.core.security.CheckCookieHelper"%>
<%@page import="cn.myapps.util.StringUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>正在检查登录</title>
</head>
<body>
<%
try {
	CheckCookieHelper.initJump(request, response);
} catch (Exception e) {
	out.println("<h4 style=\"color: red;\">Server Exception!</h4>");
}
%>
</body>
</html>