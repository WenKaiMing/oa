<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="cn.myapps.core.email.email.ejb.Email"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
</head>
<script type="text/javascript">
window.onload = function(){
	var height = document.body.clientHeight;
	window.parent.document.getElementById("frame_content").height = height + 20;
};
</script>
<body>
	<%
		String email = (String) request.getAttribute("emailContent");
		if (email != null) {
			out.println(email);
		}
	%>
</body>
</html>