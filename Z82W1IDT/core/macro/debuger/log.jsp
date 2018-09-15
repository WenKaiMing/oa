<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="cn.myapps.util.file.FileOperate"%>
<%@page import="cn.myapps.util.StringUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Log</title>
</head>
<body>
<div style="width: 100%;height: 100%">
<%
try {
	String sessionId = request.getSession().getId();
	String clear = request.getParameter("clear");
	String fileWebPath = "/logs/iscript/" + sessionId + ".log";
	String fileRealPath = request.getRealPath(fileWebPath);
	File file = new File(fileRealPath);
	
	if ("true".equals(clear)){
		file.delete();
	} else {
		if (file.exists()) {
			String content = FileOperate.getFileContentAsString(fileRealPath);
			content = content.replaceAll("\n", "</br>");
			out.print(content);
		}
	}
} catch(Exception e) {
	e.printStackTrace();
}
%>
</div>
</body>
</html>