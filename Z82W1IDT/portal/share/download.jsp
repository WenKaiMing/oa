<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Download</title>
<script>
	window.onload = function (){
		document.forms[0].submit();
	}
</script>
</head>
<body>
<s:form action="/portal/filedownload/download.action" method="post" theme="simple" name="thisForm">
	<s:hidden name="filename" value="%{#parameters.filename}" />
	<input type="hidden" name="webPath" value="<%=DefaultProperty.getProperty("REPORT_PATH") %>">
</s:form>
</body>
</html>
