<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="cn.myapps.extendedReport.Charts"%>
<%
	Charts chart = new Charts();
	String chartType = request.getParameter("chartType");
	String _name = request.getParameter("_name");
	//out.print(chart.getDatas(chartType, _name));
	out.print(chart.getDatas());
%>