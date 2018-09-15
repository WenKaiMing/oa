<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.net.*,java.util.*" %>
<%
	Map<String,String> map = new HashMap<String,String>();
	map.put("我的公司", "http://dev01.teemlink.com:8080/obpm");
	
	request.setCharacterEncoding("UTF-8");
	String domainName = request.getParameter("domainName");
	
	String hostPath = map.get(domainName);

	if(hostPath != null){
		out.write(hostPath);
	}else{
		out.write("");
	}
%>