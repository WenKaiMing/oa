<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@ include file="/portal/share/common/head.jsp"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head>
<title>{*[menu]*}</title>

<body onload="doEnter();">
<script>
function doEnter() {
	//var rtn ="{*[Create]*}{*[Success]*}";
	OBPM.dialog.doReturn("success");
}
</script>
</body>
</o:MultiLanguage></html>
