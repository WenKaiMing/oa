<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String htmlText = (String)request.getAttribute("DATA");
if (htmlText!=null) {
	out.print(htmlText);
}
%>