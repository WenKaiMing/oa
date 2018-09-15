<%@page import="jofc2.model.Text"%>
<%@page import="jofc2.model.elements.PieChart"%>
<%@page
	import="cn.myapps.core.workflow.analyzer.Colors"%>
<%@page import="jofc2.model.*"%>
<%@page import="jofc2.model.axis.*"%>
<%@page import="jofc2.model.elements.*"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.workflow.analyzer.FlowAnalyzerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	Collection<FlowAnalyzerVO> datas = (Collection<FlowAnalyzerVO>) request
			.getAttribute("DATA");

	StackedBarChart chart = new StackedBarChart(); // 设置组合柱状图
	long max = 0; // //Y 轴最大值
	Map<String, StackedBarChart.Stack> columns = new HashMap<String, StackedBarChart.Stack>();

	XAxis x = new XAxis(); // X 轴
	x.set3D(0);
	x.setColour("#909090");
	x.setGridColour("#ADB5C7");

	if (datas != null && datas.size() > 0) {

		HashMap<String, Long> maxMap = new HashMap<String, Long>();
		Colors color = new Colors();
		int index = 0;
		for (FlowAnalyzerVO fa : datas) {
			String flowName = fa.getGroupColumnValue("FLOWNAME");

			String nodeName = fa.getGroupColumnValue("STARTNODENAME");
			long amount = (long) fa.getResultFieldValue("AMOUNT")
					/ (1000 * 60 * 60);
			if (amount <= 0) continue;
			
			
			StackedBarChart.Stack stack = null;
			if (columns.containsKey(flowName)) {
				stack = columns.get(flowName);
			} else {
				stack = new StackedBarChart.Stack();//新建柱组
				columns.put(flowName, stack);
				chart.addStack(stack); // 条标题，显示在 x 轴上
				x.addLabels(flowName); // x 轴的文字
			}
			
			//计算最大值
			if (maxMap.containsKey(flowName)) {
				maxMap.put(flowName, maxMap.get(flowName) + amount);
			} else {
				maxMap.put(flowName, amount);				
			}

			String colorStr = color.getColor(index++);
			StackedBarChart.StackValue stackValue = new StackedBarChart.StackValue(amount, colorStr);//每组柱状图每个柱的设置

			StackedBarChart.Key chartKey = new StackedBarChart.Key(colorStr,nodeName, 10);
					
			chart.addKeys(chartKey);
			
			stack.addStackValues(stackValue);
		}

		for(Long value: maxMap.values()) {
			max = value > max? value:max;
		}
	} 

	/**
	StackedBarChart.Key key1 = new StackedBarChart.Key("0x336699",
			"包烧费", 10);
	StackedBarChart.Key key2 = new StackedBarChart.Key("#3334AD",
			"热表收费", 10);
	StackedBarChart.Key key3 = new StackedBarChart.Key("#D54C78",
			"生活热水收费", 10);

	chart.addKeys(key1);
	chart.addKeys(key2);
	chart.addKeys(key3);
	 */

	Chart flashChart = new Chart(
			"流程&结点耗时",
			"{font-size:16px; color: #FFFFFF; margin: 5px; background-color: #505050; padding:5px; padding-left: 20px; padding-right: 20px;}");

	// chart.setTooltip("#key#:<br>#val#");
	 
	flashChart.addElements(chart); // 把柱图加入到图表       

	YAxis y = new YAxis(); //y 轴   

	y.set3D(0);
	y.setColour("#909090");
	y.setGridColour("#ADB5C7");

	y.setMax(Math.floor(max / 10.0) * 10.0 + 10.0); //y 轴最大值   
	y.setSteps(max / 10 * 1.0); // 步进   
	flashChart.setYAxis(y);
	flashChart.setXAxis(x);
	Text text = new Text("myApps");

	text.setStyle(Text
			.createStyle(15, "#736AFF", Text.TEXT_ALIGN_RIGHT));

	flashChart.setBackgroundColour("#eeeeee");

	flashChart.setYLegend(text);//设置Y轴左侧的文字
	out.println(flashChart.toString());
%>