<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
String contextPath = request.getContextPath();
String url = request.getParameter("_link");
String surl = new OBPMDispatcher().getDispatchURL(contextPath+"/portal/dispatch/main.jsp?application="+request.getParameter("application"),request,response);
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
 		<td align="center" height="30%"><img onclick="javascript:doRefresh()" src="<s:url value="/portal/share/images/warning.png" />"></img></td>
	</tr>
    	<tr><td align="center" height="20%"style="font-size: 15px; color: red;">站点[<%=url %>]非本系统站点，系统无法保证其安全性，是否需要继续？
    	<p><a href="javascript:doRedirect()">{*[继续访问]*}  </a> | <a href="javascript:doHome()">{*[返回主页]*}</a></p> </td></tr>
   <tr><td height="50%">&nbsp;</td></tr>
</table>
<script type="text/javascript">
	function doRedirect() {
		parent.window.location = "<%=url%>";
	}
	function doHome() {
		parent.window.location = "<%=surl%>";
	}
</script>
</body>
</o:MultiLanguage>
</html>