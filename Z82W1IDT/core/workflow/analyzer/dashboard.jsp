<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.util.*"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard</title>

<style type="text/css">
body {
 overflow-x: hidden; 
 height:100%;
 width:98%;
 font-size: 62.5%;
 font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana",
 "sans-serif";
}

#dateRange{
width:300px;
display:inline;
}
#appRange{
width:500px;
display:inline;
}

#manager{
display:inline;
}
</style>

<link type="text/css" href="<s:url value='/script/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>

<script>
$(function() {
		var frameHeight = parent.document.body.clientHeight < 650 ? 650 : parent.document.body.clientHeight;
		var frameWidth = parent.document.body.clientWidth - 100;

		$("#dateRange").buttonset();
		$("input:radio,input:checkbox").click(function(){
			var dateRange = $("input[name='searchDate']").filter(':checked').val();
			var showMode = $("input[name='showMode']").filter(":checked").size()>0?"all":"mine";
			var domainId = $("input[name='domain']").val();
			var $app = $("input[name='searchApp']");
			var searchAppId;
			if ($app.filter(':checked').size()>0) {
				searchAppId = $app.filter(':checked').val();
			}
			else {
				searchAppId = $app.filter(':first').val();
			}
			var url='./borderFrame.jsp?application='+ searchAppId+'&dateRange='+dateRange+'&showMode='+showMode+'&domain='+domainId;
			$("#showFrame").attr("src",url);
		});
		$("#showFrame").height(frameHeight).width(frameWidth);
		//选择第一个软件
		$("input[name='searchApp']:first").trigger('click'); 
	});
</script>
</head>
<body>
<input type="hidden" name="domain" value="<%=request.getParameter("domain")%>" />
	<div id="searchDiv">
		<div id="dateRange">
			<input type="radio" id="today" name="searchDate" checked="checked" value="today"/><label for="today">今天</label>
			<input type="radio" id="thisweek" name="searchDate" value="thisweek"/><label for="thisweek">本周</label> 
			<input type="radio" id="thismonth" name="searchDate" value="thismonth"/><label for="thismonth">本月</label> 
			<input type="radio" id="thisyear" name="searchDate" value="thisyear"/><label for="thisyear">本年</label>
		</div>
		<div id="appRange">

	<%
		WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		ApplicationHelper ah = new ApplicationHelper();
		String domainId = request.getParameter("domain");
		Collection<ApplicationVO> appList = ah.getListByDomainId(domainId);

		String applicationId = request.getParameter("application");
		for (ApplicationVO applicationVO : appList) {
			applicationId = applicationVO.getId();
			String desc = applicationVO.getName().trim();
			out.println("<input type='radio' id='app_" + applicationId + "' name='searchApp' value='" + applicationId + "' /><label for='app_"+applicationId+"'>"
					+ desc + "</label>");
		}
	%>
		</div>
		<div id="manager">
			<input type='checkbox' name='showMode' value='all' checked disabled/><label for='showMode'>显示所有用户</label>
		</div>
	</div>	

	<hr />
	<iframe id='showFrame' frameborder="no" scrolling="no" width="100%" height="100%" />

</body>
</html>
