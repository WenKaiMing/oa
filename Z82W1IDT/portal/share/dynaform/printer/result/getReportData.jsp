
<%@page import="java.util.Enumeration"%><%@ page language="java" %>
<%
response.setContentType("text/xml;charset=utf-8"); 
out.println(request.getAttribute("reportData"));
%>