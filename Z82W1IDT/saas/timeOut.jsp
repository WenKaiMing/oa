<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/tags.jsp"%>
<html><o:MultiLanguage>
<head>
<%
	String contextPath = request.getContextPath();
	String pageTo = request.getParameter("page");
	String toUrl = contextPath + "/admin/login_error.jsp";
	if (pageTo != null && pageTo.indexOf("kmindex.jsp") > 0){
		toUrl = contextPath + "/saas/login_error.jsp";
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Time Out</title>
</head>
<script >
var url = window.top.location.href;

var toUrl = '<%=toUrl%>';

if(url.indexOf("kmindex.jsp") > 0){
	toUrl = '<%=contextPath%>/saas/login_error.jsp';
}

window.top.location = toUrl;
  
//alert(temp);
</script>
<body align="center">
<table valign="center">
<tr><td style="color: red;">
你的登录已经过期，请重新登录！</td></tr>
</table>
</body>
</o:MultiLanguage></html>