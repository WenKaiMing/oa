<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="cn.myapps.util.OBPMDispatcher"%><html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Error</title>
<link rel="stylesheet"
		href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
<style type="text/css">
table {
	table-layout: fixed;
}
td {
	word-break: break-all;
	word-wrap:break-word;
}
</style>
</head>
<body>
<table width="80%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	 <tr><td height="10%">&nbsp;</td></tr>
	<tr>
 		<td align="center" height="20%"><img onclick="javascript:doRefresh()" src="<s:url value="/portal/share/images/error.png" />" width="100px" height="100px"></img></td>
	</tr>
	<% if (exception != null) {  
		exception.printStackTrace();
	%>
		<tr><td align="center" height="20%" style="font-size: 15px;"><%=exception.getMessage() %>
		<p><a href="#" onClick="history.back(-1)" style="font-size: 12px;">{*[Back]*}</a></p></td></tr>
    <%} else {%>
    	<tr><td align="center" height="20%"style="font-size: 13px;"><%=request.getAttribute("error") == null ? request.getParameter("error") : request.getAttribute("error") %>
    	<p><a href="javascript:doRefresh()">{*[Refresh]*}</a></p></td></tr>
   <%}%>
   <tr><td height="50%">&nbsp;</td></tr>
</table>
<%
String url = new OBPMDispatcher().getDispatchURL("/portal/dispatch/main.jsp",request,response);
%>
<script type="text/javascript">
	function doRefresh() {
		parent.window.location = contextPath + "<%=url%>";
	}
</script>
</body>
</o:MultiLanguage>
</html>