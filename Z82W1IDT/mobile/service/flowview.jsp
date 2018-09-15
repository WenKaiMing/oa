<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%
	Document doc = (Document)request.getAttribute("content");
	String docid = doc.getId();
	String contextPath = request.getContextPath();
	out.println("<img src='../../../uploads/billflow/" + docid + ".jpg' />");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=request.getParameter("title")%></title>

</head>
<body>

<img name="flowImg"
	src=<%= "../../../uploads/billflow/" + docid +  ".jpg"%>?time=<%=System.currentTimeMillis()%> />
</body>
</html>