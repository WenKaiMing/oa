<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%@ page import="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper" %>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.user.action.WebUser" %>
<%@page import="cn.myapps.constans.Web"%>

<%
WebUser user = (WebUser) session
.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String applicationid = (String) (request.getParameter("application")==null?user.getDomainid():request.getParameter("application"));
	String domainid = (String) (request.getParameter("domain")==null?user.getDomainid():request.getParameter("domain"));
	BillDefiHelper bh = new BillDefiHelper();
	String flowid = bh.get_FirstflowId(applicationid,domainid);
	String dateRange = request.getParameter("dateRange");
	String showMode = request.getParameter("showMode");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<style type="text/css">

* {font-size:12px;}
#sumframeT iframe {
	width:100%;
	height:300px;
}
</style>
<script type="text/javascript">
function e_onload(){
	var sumframeT = document.getElementById("sumframeT");
	sumframeT.style.width = document.body.clientWidth + "px";
}

jQuery(window).load(function(){
  e_onload();
}).resize(function(){
  e_onload();
});
</script>
</head>
<body style="margin:0px;">
	<table id="sumframeT" border=0 style="height: 90%;width:90%;">
		<tr>
			<td>
				<iframe id="frame1" name="frame1" scrolling="auto"
					src="./timeConsumingTopX.action?application=<%=applicationid%>&domain=<%=domainid%>&dateRange=<%=dateRange%>&showMode=<%=showMode%>"
					frameborder="0" /></iframe>
			</td>
			<td>
				<iframe id="frame2" name="frame2" scrolling="auto"
					src="./showChart.jsp?type=flowAccounting&application=<%=applicationid%>&domain=<%=domainid%>&dateRange=<%=dateRange%>&showMode=<%=showMode%>"
					frameborder="0" /></iframe>
			</td>
		</tr>
		<tr>
			<td rowspan="2">
				<iframe id="frame4" name="Frame4" scrolling="auto"
					src="./showChart.jsp?type=flowTimeConsumingAccounting&application=<%=applicationid%>&domain=<%=domainid%>&dateRange=<%=dateRange%>&showMode=<%=showMode%>"
					frameborder="0" /></iframe>
			</td>
			<td>
				<iframe id="frame3" name="Frame3" scrolling="auto"
					src="./showChart.jsp?type=flowAndNodeTimeConsuming&application=<%=applicationid%>&domain=<%=domainid%>&dateRange=<%=dateRange%>&showMode=<%=showMode%>"
					frameborder="0" /></iframe>
			</td>
		</tr>
	</table>
</body>
</html>