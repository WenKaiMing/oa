<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String chartstr = (String)(request.getAttribute("chartstr"));
request.setAttribute("chartsrt",chartstr);
%>
<%=chartstr%>
