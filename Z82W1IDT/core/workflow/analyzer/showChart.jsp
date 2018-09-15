<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String applicationId = request.getParameter("application");
	String type = request.getParameter("type");
	String domainid = request.getParameter("domain");
	String dateRange = request.getParameter("dateRange");
	String showMode = request.getParameter("showMode");

	String dataFile = "./" + type + ".action?application="
			+ applicationId + "%26domain=" + domainid + "%26dateRange="
			+ dateRange + "%26showMode=" + showMode;
	//	dataFile = "./tooltip-mixed-2.txt";
%>
<div id="my_chart">
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		width="100%"
		codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab"
		id="ie_chart" align="middle">
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="movie"
			value="./resource/open-flash-chart.swf?data-file=<%=dataFile%>" />
		<param name="quality" value="high" />
		<param name="bgcolor" value="#eeeeee" />
		<param name="wmode" value="opaque" />
		<param name="data-file" value="<%=dataFile%>" />

		<embed src="./resource/open-flash-chart.swf?data-file=<%=dataFile%>"
			quality="high" width="100%" height="100%" bgcolor="#eeeeee"
			style="width: 100%; height: 100%;" wmode="opaque" name="chart"
			align="middle" allowScriptAccess="sameDomain"
			type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer" id="chart3"
			wmode="window" />
	</object>
</div>
