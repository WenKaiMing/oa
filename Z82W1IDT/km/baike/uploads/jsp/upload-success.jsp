<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/km/disk/head.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	font: 13px Arial, Helvetica, Sans-serif;
}
</style>
	<script type="text/javascript">
	jQuery(document).ready(function(){
		var acResult = '<%=request.getParameter("_acResult")%>';
		if(acResult == 'success'){
			var fileInfo = '<s:property value="jsonFileInfo" escape="false"/>';
			//alert("upload-success.jsp"+fileInfo);
			OBPM.dialog.doReturn(fileInfo);
		}
	});
	</script>
</head>
<body>
</body>
</html>