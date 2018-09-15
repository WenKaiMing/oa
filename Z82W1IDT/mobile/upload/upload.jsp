<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tags.jsp"%>

<%@page import="cn.myapps.mobile.upload.MbUploadAction"%>
<o:MultiLanguage>
	<%
	String path = (String) request.getAttribute(MbUploadAction.PATH);
	out.write(path == null ? "" : path);
	%>
</o:MultiLanguage>