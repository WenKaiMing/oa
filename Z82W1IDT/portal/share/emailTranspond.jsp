<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.security.OBPMParameter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
Loading......
<%
String url = (String)request.getAttribute("emailTranspondUrl");
out.println("<script>window.location='"+url+"'</script>");
%>
</body>
</html>