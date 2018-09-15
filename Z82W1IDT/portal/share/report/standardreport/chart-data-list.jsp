<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.openflashchart.Graph"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.openflashchart.Bar"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.standardreport.ejb.StandarReportProcessBean" %>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="reportcommon.jsp"%>
<%
	Graph g = new Graph();
	Bar b = new Bar("50", "#9933CC");
	b.key("时效报表", 15);
	int max = 10;
	List labels = new ArrayList();
	b.setVar("bar_3d");
	
	Iterator iter = collection.iterator();
	
	while(iter.hasNext()) {
		Map map = (Map) iter.next();
		String tempLables = "";
		for(int j=0;j<cols.length;j++)
		{
			String temp =(String) map.get(cols[j]);
			tempLables = tempLables +" "+ temp; 
		}
	
		b.add(String.valueOf(map.get("USEDTIME")), "javascript:alert('hello,world!')");
		labels.add(tempLables);
	}

	// Spoon sales, March 2007
	g.title("柱状时效", "{font-size: 26px;}");
	g.getData_sets().add(b);
	
	g.bar_3D("75", "#D54C78", "2006", 8);
	g.bar_3D("75", "#3334AD", "2007", 8);
	g.set_x_labels(labels);
	g.set_x_label_style("10", "#9933CC", 2, 0, "");
	g.set_x_axis_3d(5);
	
	g.x_axis_colour("#909090", "#ADB5C7");
	g.x_axis_colour("#909090", "#ADB5C7");

	g.bar("0");
	g.bar("0");
	
	g.set_x_axis_steps(2);
	g.set_x_tick_size(5);
	g.set_bg_colour("#eaf7fc");


	g.set_y_max(30);
	g.y_label_steps(10);
%>
<%=g.render()%>
</body>
</html>