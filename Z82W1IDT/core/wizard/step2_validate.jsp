<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String name = (String)request.getAttribute("formName");
	out.println(name);
%>