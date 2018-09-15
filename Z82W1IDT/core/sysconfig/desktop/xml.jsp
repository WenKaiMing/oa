<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/common/tags.jsp"%>
<o:MultiLanguage>
<%
	
	String toXml = (String) request.getAttribute("toXml");
	out.write(toXml == null ? "" : toXml);
%>
</o:MultiLanguage>