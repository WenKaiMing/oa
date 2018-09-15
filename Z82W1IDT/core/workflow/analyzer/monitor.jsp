<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.homepage.action.HomePageHelper"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.myapps.core.user.ejb.UserDefined"%>
<%@page import="cn.myapps.core.widget.ejb.PageWidget"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
	String closeUrlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/closeTab.jsp",request,response);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Monitoring</title>
	<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>

	<link href="./resource/homepage/css/main.css" rel="stylesheet"
		type="text/css" />
</head>
<body>

<form action="post">
日期：<input type="text" name="dateFrom" /> 到 <input name="dateTo" />
人员：<input type="text" name="actor" />
部门：<input type="text" name="department" />
流程：<input type="text" name="flow"/>
<input type="submit" value="查询"/>
</form>
<div id="result">

</div>
</body>
</html>