<%@ page language="java" 
    pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link type="text/css" href="<s:url value='/portal/share/common/msgbox/msgBox.css'/>" rel="stylesheet"/>
<script type="text/javascript" src='<s:url value="/portal/share/common/msgbox/msgBox.js"/>'></script>
<script type="text/javascript">
var content = "<s:property value='runtimeException.nativeMessage'/>"; //简要提示
var completeMessage = "<s:property value='runtimeException.completeMessage'/>";
var contentFull = completeMessage; //详细提示

jQuery(document).ready(function() {
    jQuery("#msgBox").SmohanPopLayer({Shade : true,Content : content});
});
</script>
</head>
<body id="msgBox">
</body>
</html>