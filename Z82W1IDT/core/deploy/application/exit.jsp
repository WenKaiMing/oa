<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head>
<title>{*[menu]*}</title>

<body onload="doEnter();">
<script>
function doEnter() {
	var rtn ="{*[cn.myapps.core.deploy.application.create_succeed]*}";
	OBPM.dialog.doReturn(rtn);
}
</script>
</body>
</o:MultiLanguage></html>
