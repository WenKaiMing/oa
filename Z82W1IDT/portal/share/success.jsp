<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.km.base.contans.Web"%>
<%@ page import="org.apache.struts2.ServletActionContext"%>
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
<%
	String applicationid = request.getParameter("application");
	String url = new OBPMDispatcher().getDispatchURL("/portal/dispatch/main.jsp?application="+applicationid,request,response);
	String debug = (String)ServletActionContext.getRequest().getSession().getAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	if("true".equals(debug)){
		url = "/portal/share/debug.jsp?returnUrl=&application=" + applicationid;
	}
	

%>
<script type="text/javascript">
	jQuery(function(){
		parent.window.top.location = contextPath + "<%=url%>";
	});
</script>
</body>
</o:MultiLanguage>
</html>