<%@page import="java.text.NumberFormat"%>
<%@page import="cn.myapps.core.user.action.UserUtil"%>
<%@page import="cn.myapps.core.user.ejb.UserProcessBean"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.workflow.analyzer.FlowAnalyzerVO"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Time Consuming Top X</title>
<link href="../cool/resource/jquery/jquery-ui.min.css" rel="stylesheet">
<style type="text/css">
body {
 overflow-x: hidden; 
 height:100%;
 width:100%;
 font-size: 62.5%;
 font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana",
 "sans-serif";
 margin:0;
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
#dateRange{
width:300px;
display:inline;
}
</style>
<script type="text/javascript" src="../cool/resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../cool/resource/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
<!--
	$(document).ready(function(){
		$("input:radio").click(function(){
			var dateRange = $("input[name='searchDate']").filter(':checked').val();
			var url='<s:url action="showWorkflowAnalyzer" namespace="/portal/widget"><s:param name="type" value="#request.type"/></s:url>';
			url+="&dateRange="+dateRange+"&applicationId="+'<s:property value="#request.applicationId"/>';
			document.forms[0].action = url;
			document.forms[0].submit();
			
		});
		var dr = '<s:property value="#request.dateRange"/>';
		$("input[name=searchDate][value="+dr+"]").attr("checked",true);
		$("#analyzerActorTimeConsumingTopX-dateRange").buttonset();
	});
	
//-->
</script>
</head>
<body>
<s:form action="" theme="simple">
<div id="analyzerActorTimeConsumingTopX-dateRange">
				<input type="radio" id="today" name="searchDate" checked="checked" value="today"/><label for="today">今天</label>
				<input type="radio" id="thisweek" name="searchDate" value="thisweek"/><label for="thisweek">本周</label> 
				<input type="radio" id="thismonth" name="searchDate" value="thismonth"/><label for="thismonth">本月</label> 
				<input type="radio" id="thisyear" name="searchDate" value="thisyear"/><label for="thisyear">本年</label>
	</div>
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
				+ format.format(fa.getResultFieldValue("AMOUNT")
						/ (1000 * 60 * 60)) + "</td> ");

		out.println("</tr>");
	}
	out.println("</table>");
%>
</s:form>
</body>
</html>