<%@ page contentType="text/html; charset=UTF-8"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.util.*"%>
<%@ taglib uri="myapps" prefix="o"%>

<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard</title>
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<style type="text/css">
body {
 overflow: hidden; 
 height:100%;
 width:98%;
 font-size: 62.5%;
 font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana",
 "sans-serif";
 background-color: rgb(250, 250, 250);
 padding-top: 18px;
 padding-bottom: 10px;
 margin: 0px;
}

#searchDiv{
  box-shadow: 1px 1px 1px 0px #BBB;
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

.ui-state-active{
background: rgb(13, 187, 13);
color: white;
}

.ui-button-text-only .ui-button-text {
  padding: .6em 2em;
  font-weight: bold;
}

</style>

<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>

<script>

$(function() {
		var frameHeight = parent.document.body.clientHeight - $("#searchDiv").height() - 30;
		var frameWidth = parent.document.body.clientWidth - 145;
		
		$("#dateRange").buttonset();
		$("input:radio,input:checkbox").click(function(){
			var dateRange = $("input[name='searchDate']").filter(':checked').val();
			var showMode = $("input[name='showMode']").filter(":checked").size()>0?"all":"mine";
			var $app = $("input[name='searchApp']");
			var searchAppId;
			if ($app.filter(':checked').size()>0) {
				searchAppId = $app.filter(':checked').val();
			}
			else {
				searchAppId = $app.filter(':first').val();
			}
			var url='../share/workflow/analyzer/borderFrame.jsp?application='+ searchAppId+'&dateRange='+dateRange+'&showMode='+showMode;
			$("#showFrame").attr("src",url);
			
		});
		
		$("#showFrame").height(frameHeight).width(frameWidth);
		//选择第一个软件
		$("input[name='searchApp']:first").trigger('click'); 
	});
</script>
</head>
<body>
	<div id="searchDiv" style="height: 50px;line-height: 48px;margin-right: 20px;padding-left: 15px;background: white;border: 1px solid #EEEEEE;">
		<div id="dateRange">
			<input type="radio" id="today" name="searchDate" checked="checked" value="today"/><label for="today">{*[Today]*}</label>
			<input type="radio" id="thisweek" name="searchDate" value="thisweek"/><label for="thisweek">{*[instrument.week]*}</label> 
			<input type="radio" id="thismonth" name="searchDate" value="thismonth"/><label for="thismonth">{*[instrument.month]*}</label> 
			<input type="radio" id="thisyear" name="searchDate" value="thisyear"/><label for="thisyear">{*[instrument.year]*}</label>
		</div>
		<div id="appRange">

	<%
		WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
		Collection<ApplicationVO> appList = process.queryAppsByDomain(user.getDomainid(),1,Integer.MAX_VALUE);

		String applicationId = request.getParameter("application");
		for (ApplicationVO applicationVO : appList) {
			applicationId = applicationVO.getId();
			String desc = applicationVO.getName().trim();
			out.println("<input type='radio' style='margin-left: 20px;' id='app_" + applicationId + "' name='searchApp' value='" + applicationId + "' /><label for='app_"+applicationId+"'>"
					+ desc + "</label>");
		}
	%>
		</div>
		<div id="manager">
		
            <%
				if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
					out.println("<input type='checkbox' style='margin-left: 20px;' name='showMode' value='all'/><label for='showMode'>{*[show.all]*}</label>");
				}
			%>
		</div>
	</div>	

	<iframe id='showFrame' frameborder="no" width="100%" height="100%" style="margin-top: 15px;margin-right: 50px;"/>

</body>
</html>
</o:MultiLanguage>