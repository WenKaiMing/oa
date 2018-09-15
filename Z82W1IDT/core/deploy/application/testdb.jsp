<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<html><o:MultiLanguage>
<head>
<title>{*[App]*}</title>
<SCRIPT language="javascript">
</SCRIPT>
</head>
<body style="margin: 0px">
<%
	String msg = "{*[connect]*}{*[Success]*}!";
	try {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String driver = request.getParameter("driver");
		String url = request.getParameter("url");

		Class.forName(driver).newInstance();
		Connection conn = DriverManager.getConnection(url, username,
		password);
		conn.close();
	} catch (Exception e) {
		msg = "{*[connect]*}{*[Error]*}!<br>" + e.getMessage();
	}
	out.println(msg);
%>
</body>
</o:MultiLanguage></html>
