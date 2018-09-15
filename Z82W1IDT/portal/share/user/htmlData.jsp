<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage>
<%
String htmlText = (String)request.getAttribute("HTML");
if (htmlText!=null) {
	out.print(htmlText);
}
%>
</o:MultiLanguage>