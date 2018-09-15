<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@	include file="/portal/share/common/lib.jsp"%>
<%
	String contextPath = request.getContextPath();
	// 组装queryString，WebSphere不支持getQueryString
	String queryString = "";
	Map parameterMap = request.getParameterMap();
	String[] temp = (String [])parameterMap.get("selectOne");
	String[] mutil = (String []) parameterMap.get("mutil");
	for(Iterator it = parameterMap.entrySet().iterator(); it.hasNext();) {
		Map.Entry entry = (Map.Entry)it.next();
		String[] values = (String[])entry.getValue();
		queryString += entry.getKey() + "="+values[0]+"&";
	}
	
	if (!parameterMap.isEmpty()) {
		queryString = queryString.substring(0, queryString.length() - 1);
	}

%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<script>
function ev_onload2(){
  temp.submit();
}
//window.attachEvent("onload", ev_onload2);
</script>
</head>
<body onload='ev_onload2()' align="center" style="overflow: hidden">
<%if(mutil[0].equals("true")){ %>
	<form method='post' name='temp' action='<%= contextPath %>/portal/dynaform/view/mainDialogView4Phone.action?<%=queryString%>'>
<%} else{%>
	<form method='post' name='temp' action='<%= contextPath %>/portal/dynaform/view/dialogView4Phone.action?<%=queryString%>'>
<%} %>
<div id="strHeddin" style="display:none; height:100%">
<script>
	var args = top.OBPM.dialog.getArgs();
	document.write(args?args['html']:"");
</script>
</div>
</form>
</body>
</o:MultiLanguage></html>