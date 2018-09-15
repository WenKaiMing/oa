<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities"%> 
<%@ page import="org.jfree.chart.ChartUtilities"%> 
<%@ page import="org.jfree.chart.ChartRenderingInfo"%> 
<%@ page import="org.jfree.chart.entity.StandardEntityCollection"%> 
<%@ page import="cn.myapps.core.report.oreport.action.OReportUtil"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.awt.Shape,java.net.URLDecoder"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.jfree.chart.entity.ChartEntity"%>
<%@page import="cn.myapps.base.action.ParamsTable" %>
<%@page import="net.sf.json.JSONObject" %>
<%@ page import="java.io.*,org.jfree.chart.JFreeChart"%> 
<%
String contextPath = request.getContextPath();
String json = (String)request.getParameter("json");
String filter = (String)request.getParameter("filter");
String domainid = (String)request.getParameter("domainid");
String chartType = (String)request.getParameter("chartType");
WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String openType = (String)request.getParameter("openType");
String jsonData = (String)request.getParameter("jsonData");
String chartLabel = "";
if(chartType.equals("PieChart")){
	chartLabel = "馅饼图";
}else if(chartType.equals("BarChart")){
	chartLabel = "条形图";
}else if(chartType.equals("AreaChart")){
	chartLabel = "面积图";
}else if(chartType.equals("ColumnChart")){
	chartLabel = "柱状图";
}else if(chartType.equals("LineChart")){
	chartLabel = "折线图";
}else if(chartType.equals("PlotChart")){
	chartLabel = "散点图";
}else{
	chartLabel = "馅饼图";
}
ParamsTable params = new ParamsTable();
params.setParameter("domainid",domainid);
params.setParameter("userid",webUser.getId());
params.setParameter("jsonData", jsonData);
if(filter !=null && !filter.equals("")){
	JSONObject jsonObject = JSONObject.fromObject(filter);
	for(int i=0;i<jsonObject.names().size();i++){
		String key = jsonObject.names().getString(i);
		if(jsonObject.get(key)!=null && !jsonObject.get(key).equals("") && !jsonObject.get(key).equals("null")){
			params.setParameter(key,jsonObject.get(key));
		}
	}

}

JFreeChart chart = OReportUtil.getCreateChar(json,chartType,params);

Shape shape = new Rectangle(20, 10);
ChartEntity entity = new ChartEntity(shape);
StandardEntityCollection sec = new StandardEntityCollection(); 
sec.add(entity);
ChartRenderingInfo info = new ChartRenderingInfo(sec); 
PrintWriter w = new PrintWriter(out);//输出MAP信息 
String fileName = ServletUtilities.saveChartAsJPEG(chart,800,400,info,session);
String path = contextPath+"/servlet/DisplayChart?filename=" + fileName;
ChartUtilities.writeImageMap(w, "map0", info, false); 
w.flush();
%>
<html oncontextmenu="return false">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>oReport</title>
<script type="text/javascript">
<%--  window.onload = function(){
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
		var type = '<%=openType%>';
		if(!isIE){
			 for(var i=0;i<10;i++){
				 var iframeId="iframe"+i;
				var parentIframeId="iframe_iframe"+i;
				var chartIframeId="chartIframe"+i;
				var iframe_chartIframeId="iframe_chartIframe"+i;
					
				var div=parent.document.getElementById(iframeId);
				var parentIframe=parent.document.all(parentIframeId);
				var chartIframe=parent.document.getElementById(chartIframeId);
				var iframe_chartIframe=parent.document.all(iframe_chartIframeId);
				var detailIframeH = 0;
				var detailIframeW = 0;
				var detailIframe = parent.parent.document.getElementById("detail");
				if(detailIframe!=null){
					detailIframeH = detailIframe.offsetHeight;
					detailIframeW = detailIframe.offsetWidth;
				}else{
					detailIframeH = parent.document.body.offsetHeight;
					detailIframeW = parent.document.body.offsetWidth;
				}
				if(type == "ExplorerCanvas2"){
					if(chartIframe!=null&&iframe_chartIframe!=null){
						var left = (detailIframeW - 212 - 812)/2 + 212;
						var height = detailIframeH - 90;
						chartIframe.style.width = "830px";
						chartIframe.style.height = height+"px";
						chartIframe.style.top = "100px";
						chartIframe.style.left = left+"px";
						chartIframe.style.display = "block";
						iframe_chartIframe.style.width ="100%";
						iframe_chartIframe.style.height = "450px";
					}
				}else if(type == "ChartViewCanvasCreate"){
					if(div!=null && parentIframe!=null){
						var divLeft=(detailIframeW-812)/2;
						var divTop=(detailIframeH-4060)/2;
						parentIframe.style.width="100%";
						parentIframe.style.height="360px";
						
						div.style.display = "block";
						div.style.width = "830px";
						div.style.heiht = "420px";
						div.style.left=divLeft+"px";
						div.style.top=divTop+"px";
					}
				}else if(type == "ExplorerCanvas"){
					if(chartIframe!=null&&iframe_chartIframe!=null){
						var left = (detailIframeW - 812)/2;
						var height = detailIframeH - 90;
						chartIframe.style.width = "830px";
						chartIframe.style.height = height+"px";
						chartIframe.style.top = "80px";
						chartIframe.style.left = left+"px";
						chartIframe.style.display = "block";
						iframe_chartIframe.style.width ="100%";
						iframe_chartIframe.style.height = "450px";
					}
				}
			} 
		}
	};  --%>
</script> 

</head>
<body style="text-align:center;">
<div><%=chartLabel %></div>
<img style="margin:auto;" src="<%=path %>" border="0" usemap="#map0">
</body>
</html>