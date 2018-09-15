<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String applicationId = (String)request.getAttribute("applicationId");
	String type = (String)request.getAttribute("type");
	String dateRange = (String)request.getAttribute("dateRange");

	String dataFile = request.getContextPath()+"/portal/share/workflow/analyzer/" + type + ".action?application="
			+ applicationId + "%26dateRange="
			+ dateRange;
	//	dataFile = "./tooltip-mixed-2.txt";
%>
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<style>
<!--
body {
 overflow-x: hidden; 
 height:100%;
 width:100%;
 font-size: 62.5%;
 font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana",
 "sans-serif";
 margin:0;
}

#dateRange{
width:300px;
display:inline;
}
-->
</style>
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>
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
	$("#analyzerChar-dateRange").buttonset();
	
});
//-->
</script>
<s:form action="" theme="simple">
<div id="analyzerChar-dateRange">
				<input type="radio" id="today" name="searchDate" checked="checked" value="today"/><label for="today">今天</label>
				<input type="radio" id="thisweek" name="searchDate" value="thisweek"/><label for="thisweek">本周</label> 
				<input type="radio" id="thismonth" name="searchDate" value="thismonth"/><label for="thismonth">本月</label> 
				<input type="radio" id="thisyear" name="searchDate" value="thisyear"/><label for="thisyear">本年</label>
	</div>
<div id="my_chart">
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		width="100%"
		codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab"
		id="ie_chart" align="middle">
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="movie"
			value="../cool/widget/open-flash-chart.swf?data-file=<%=dataFile%>" />
		<param name="quality" value="high" />
		<param name="bgcolor" value="#eeeeee" />
		<param name="wmode" value="opaque" />
		<param name="data-file" value="<%=dataFile%>" />

		<embed src="../cool/widget/open-flash-chart.swf?data-file=<%=dataFile%>"
			quality="high" width="100%" height="100%" bgcolor="#eeeeee"
			style="width: 100%; height: 100%;" wmode="opaque" name="chart"
			align="middle" allowScriptAccess="sameDomain"
			type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer" id="chart3"
			wmode="window" />
	</object>
</div>
</s:form>