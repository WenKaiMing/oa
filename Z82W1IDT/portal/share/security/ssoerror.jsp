<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.security.action.LoginHelper"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String debug = (String) session.getAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	session.removeAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	LoginHelper.logout(request, response);
	String errorMsg = (String)request.getAttribute("errorMsg");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出错啦!</title>
<style type="text/css">
.errorMessage {
	color: red;
	font-family: Arial;
	font-size: 14px;
}
</style>
</head>
<body>
	<span class="errorMessage">
		*<%=errorMsg %>
	</span>
</body>
</html>
</o:MultiLanguage>