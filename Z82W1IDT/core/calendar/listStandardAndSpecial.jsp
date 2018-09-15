<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script>
function change(display) {
	document.getElementById("btnStandard").className = "btcaption";
	document.getElementById("btnSpecial").className = "btcaption";

	display.className = "btcaption-selected";
	
	switch (display.name){ 
		case "btnSpecial": frames["frame"].location.href="<s:url value='/core/calendar/special/list.action'></s:url>?domain=<s:property value="#parameters.domain" />&_calendarid=<s:property value="_calendarid" />";break;
		case "btnStandard": frames["frame"].location.href="<s:url value='/core/calendar/standard/list.action'></s:url>?domain=<s:property value="#parameters.domain" />&_calendarid=<s:property value="_calendarid" />";break;
	} 
}
</script>

</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0> 
<table width=100% height="98%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td align="left" class="table-header" height="5%" style="background-image: url(<s:url value='/resource/imgnew/nav_back.gif'/>); background-position: bottom; background-repeat:repeat-x;">
	<table cellspacing="0" cellpadding="0">
	<tr>
		<td width=80><input type="button" id="btnStandard" name="btnStandard" class="btcaption-selected" onClick="change(this)" value="{*[Working-weeks]*}"/></td>
		<td width=80><input type="button" id="btnSpecial" name="btnSpecial" class="btcaption" onClick="change(this)" value="{*[Special]*}{*[Day]*}"/></td>
	</tr>
	</table>	
	</td></tr>
	<tr><td valign="top" height="100%">
		<iframe scrolling="auto" style="overflow:visible;height:250px;width:100%;" id="frame" name="frame"  src="<s:url value='/core/calendar/standard/list.action'></s:url>?domain=<s:property value="#parameters.domain" />&_calendarid=<s:property value="_calendarid" />" frameborder="0"/></iframe>
	</td></tr>
</table>


</body>
</o:MultiLanguage></html>