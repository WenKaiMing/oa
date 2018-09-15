<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@page import="cn.myapps.util.Security"%>
<%@ include file="/portal/share/common/head.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<%@page import="cn.myapps.util.OBPMDispatcher"%><html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[DOCUMENT]*}</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<body>
<% 
	String backURL = (String)request.getParameter("_backURL");
	if (backURL != null && backURL.trim().length() > 0) {
		Object result = request.getAttribute("message");
		if(result != null && result instanceof JsMessage){
			if (backURL.indexOf("?") > 0) {
				backURL += "&message.type=" + ((JsMessage)result).getType();
				
			} else {
				backURL += "?message.type=" + ((JsMessage)result).getType();
			}
			backURL += "&message.content=" + Security.bytesToHexString(((JsMessage)result).getContent().getBytes());
		}
		new OBPMDispatcher().sendRedirect(backURL,request, response);
	} else {
		backURL = "/portal/dispatch/closeTab.jsp";
		new OBPMDispatcher().forward(backURL,request, response);
	}
	//request.getRequestDispatcher(backURL).forward(request, response);
%>
</body>
</o:MultiLanguage></html>
