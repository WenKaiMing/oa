<%@page import="java.text.NumberFormat"%>
<%@page import="cn.myapps.core.user.action.UserUtil"%>
<%@page import="cn.myapps.core.user.ejb.UserProcessBean"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.workflow.analyzer.FlowAnalyzerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Time Consuming Top X</title>
<style type="text/css">
body {
 overflow-x: hidden; 
 height:100%;
 width:100%;
 font-size: 62.5%;
 font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana",
 "sans-serif";
}
th {
text-align:left;
}
.title{
font: 14pt/15pt bold "Arial" normal ;
text-align:center;
}
.amount {
text-align:right;
}
</style>
</head>
<body>
<div class='title'>流程结点耗时-TOP10</div>
<%
	String applicationId = request.getParameter("application");
	Collection<FlowAnalyzerVO> datas = (Collection<FlowAnalyzerVO>) request
			.getAttribute("DATA");
	UserUtil userUtil = new UserUtil();

	NumberFormat format = NumberFormat.getInstance();
	format.setMaximumFractionDigits(2);
//	format.setMinimumFractionDigits(2);

	out.println("<table>");

	out.println("<tr><th>FLOWNAME</th><th>STARTNODENAME</th><th>ENDNODENAME</th><th>AUDITOR</th><th>AMOUNT(H)</th></tr>");
	for (FlowAnalyzerVO fa : datas) {
		out.println("<tr>");
		out.println("<td>" + fa.getGroupColumnValue("FLOWNAME")
				+ "</td> ");
		out.println("<td>" + fa.getGroupColumnValue("STARTNODENAME")
				+ "</td> ");
		out.println("<td>" + fa.getGroupColumnValue("ENDNODENAME")
				+ "</td> ");
		String userId = fa.getGroupColumnValue("AUDITOR");

		out.println("<td>" + userUtil.findUserName(userId) + "</td> ");
		out.println("<td class='amount'>"
				+ format.format(fa.getResultFieldValue("AMOUNT")) + "</td> ");//分钟为单位

		out.println("</tr>");
	}
	out.println("</table>");
%>
</body>
</html>