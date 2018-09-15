<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities"%> 
<%@ page import="org.jfree.chart.ChartUtilities"%> 
<%@ page import="org.jfree.chart.ChartRenderingInfo"%> 
<%@ page import="org.jfree.chart.entity.StandardEntityCollection"%> 
<%@ page import="cn.myapps.core.report.oreport.action.OReportUtil"%>
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
}
ParamsTable params = new ParamsTable();
params.setParameter("domainid",domainid);
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
String fileName = ServletUtilities.saveChartAsJPEG(chart,800,350,info,session);
String path = contextPath+"/servlet/DisplayChart?filename=" + fileName;
ChartUtilities.writeImageMap(w, "map0", info, false); 
w.flush();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html oncontextmenu="return false">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>oReport</title>
<script type="text/javascript">
	/* window.onload = function(){
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
		if(!isIE){
			for(var i=0;i<10;i++){
				var iframeId="iframe"+i;
				var parentIframeId="iframe_iframe"+i;
				var div=parent.document.getElementById(iframeId);
				var parentIframe=parent.document.all(parentIframeId);
				if(div!=null && parentIframe!=null){
					var divLeft=(parent.parent.document.all("frame").offsetWidth-830)/2;
					var divTop=(parent.parent.document.all("frame").offsetHeight-330)/2;
					parentIframe.style.width=830+"px";
					parentIframe.style.height=388+"px";
					div.style.width=830+"px";
					div.style.height=388+"px";
					div.style.left=divLeft+"px";
					div.style.top=divTop+"px";
				}
			}
		}
	} */
</script> 

</head>
<body>
<div><%=chartLabel %></div>
<img src="<%=path %>" border="0" usemap="#map0">
</body>
</html>