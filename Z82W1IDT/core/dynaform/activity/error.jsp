<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="width:100%; height:100%;">
	<tr>
		<td>
			<textarea style="width:90%; height:90%;">
				<%
 				out.println(exception.getLocalizedMessage());
 				%>
			</textarea>
		</td>
	</tr>
</table>
 
</body>
</html>