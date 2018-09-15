<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="cn.myapps.core.dynaform.dts.datasource.ejb.DataSourceProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="cn.myapps.extendedReport.Charts"%>
<%
	Map<String,Object> result = new HashMap<String,Object>();
	String active = request.getParameter("active");			//操作类型--插入/更新/删除，insert/update/delete
	String subActive = request.getParameter("subActive");	//子表操作类型--插入/更新/删除，insert/update/delete
	try{
		Charts chart = new Charts();
		JSONArray json = null;
		String state = null;
		if ("".equals(active) || "search".equals(active) || "showList".equals(active)) {
			json = chart.orderQuery();

			if(json != null){
			    result.put("status", 1);
			    result.put("datas",json);
			}else{
			    result.put("status", 0);
			}
		} else if ("insert".equals(active)){
			state = chart.orderInsert();
			if(state != null){
			    result.put("status", 1);
			}else{
			    result.put("status", 0);
			}
		}else if ("delete".equals(active)){
			state = chart.orderDelete();
			if(state != null){
			    result.put("status", 1);
			}else{
			    result.put("status", 0);
			}
		}else if ("update".equals(active)) {
			if (subActive == null){
				state = chart.orderUpdate();
			}else if ("update".equals(subActive)){	//子表更新
				state = chart.orderUpdate();
			}else if ("delete".equals(subActive)){	//子表删除
				state = chart.orderDelete();
			}else if ("insert".equals(subActive)){	//子表插入
				state = chart.orderInsert();
			}
			if(state != null){
			    result.put("status", 1);
			}else{
			    result.put("status", 0);
			}
		}
	    //result.put("message", "");
	}catch(Exception e){
		result.put("status", 0);
		//result.put("message", e.getLocalizedMessage());
	}
	out.println(JSONObject.fromObject(result));

%>
