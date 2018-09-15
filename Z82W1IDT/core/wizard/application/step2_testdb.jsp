<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[App]*}</title>
<SCRIPT language="javascript">
</SCRIPT>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<%
	String msg = "SUCCESS!";
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
		msg = "ERROR!" + e.getMessage();
	}
	out.println(msg);
%>
</body>
</o:MultiLanguage></html>
