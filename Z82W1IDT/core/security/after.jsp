<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
<%
	String url = request.getParameter("url");
	String error = "";
%>
<head>
<script>
window.onload = function(){
   document.getElementsByName("forms")[0].submit();
}
</script>
</head>
<s:form action="<%=url%>" method="post" name="forms" >
<s:if test="hasFieldErrors()">
	<s:iterator value="fieldErrors">
		<s:set name="value" id="value" scope="page" />
		<%
			Object value = pageContext.getAttribute("value");
			if (value != null) {
				String errors = value.toString();
				error += (errors.split("="))[1];
			}
		%>
	</s:iterator>
</s:if>
<s:hidden name="error"  value="<%=error%>"></s:hidden>
</s:form>
</o:MultiLanguage>
</html>