<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Success</title>
</head>
<body>
<table  width="100%" >
	<tr><td align="left">
	<s:if test="hasFieldErrors()">
		<span class="errorMessage"> 
			<b>{*[Errors]*}:</b><br>
			<s:iterator value="fieldErrors">
				*<s:property value="value[0]" />;
			</s:iterator> 
		</span>
	</s:if></td>
	</tr>
</table>
	
<ul>
    <li>
        {*[GoTo]*}:
        <a href='<s:url value="/portal/share/welcome.jsp" />'>{*[Home_Page]*}</a>
    </li>
	
    <li>
        {*[GoTo]*}:
        <a href='<s:url action="list" />'>{*[User_List]*}</a>
    </li>
</ul>

</body>
</o:MultiLanguage></html>