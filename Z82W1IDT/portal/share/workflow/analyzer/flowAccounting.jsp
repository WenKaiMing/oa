<%@page import="jofc2.model.Text"%>
<%@page import="jofc2.model.elements.PieChart"%>
<%@page import="cn.myapps.core.workflow.analyzer.Colors"%>
<%@page import="jofc2.model.Chart"%>
<%@page import="jofc2.model.elements.Element"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.workflow.analyzer.FlowAnalyzerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
Collection<FlowAnalyzerVO> datas = (Collection<FlowAnalyzerVO>)request.getAttribute("DATA");

Chart chart = new Chart(
		"流程实例占比",
		"{font-size:16px; color: #FFFFFF; margin: 5px; background-color: #505050; padding:5px; padding-left: 20px; padding-right: 20px;}");

ArrayList<String> colors = new ArrayList<String>();
Colors color = new Colors();
int index = 0;
PieChart pie = new PieChart();

if (datas != null && datas.size()>0) {
	for (FlowAnalyzerVO fa : datas) {
		String flowName = fa.getGroupColumnValue("FLOWNAME");
		long amount = (long)fa.getResultFieldValue("AMOUNT");
		pie.addSlice(amount, flowName);
		colors.add(color.getColor(index++));
	}
}
else {
	pie.addSlice(Integer.valueOf(100), "");
	colors.add("#ff0000");
}
pie.setColours(colors);// 饼图每块的颜色
pie.setBorder(Integer.valueOf(1));
chart.addElements(new Element[]{pie});
chart.setBackgroundColour("#eeeeee");
out.println(chart.toString());
%>