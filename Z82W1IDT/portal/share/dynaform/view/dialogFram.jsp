<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.action.ViewHelper"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%
String contextPath = request.getContextPath();
			WebUser user = (WebUser) session
					.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String viewid=request.getParameter("_viewid");
	String styleid=ViewHelper.get_Styleid(viewid);
	String queryString = "";
	Map parameterMap = request.getParameterMap();
	for(Iterator it = parameterMap.entrySet().iterator(); it.hasNext();) {
		Map.Entry entry = (Entry)it.next();
		String[] values = (String[])entry.getValue();
		queryString += entry.getKey() + "="+values[0]+"&";
	}
	
	if (!parameterMap.isEmpty()) {
		queryString = queryString.substring(0, queryString.length() - 1);
	}
	
	String url = contextPath + "/portal/share/dynaform/view/dialogTemp.jsp?" + queryString;
%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map.Entry"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">	
<script>
	var rtn = {};

	function ev_onload() {
		//var myFrame =  parent.document.getElementById("myFrame");
		tips.style.display = "none";
		document.getElementById("iframe_content").src = '<%=url%>';
	}
	if (window.attachEvent) {    
		window.attachEvent("onload", ev_onload);    
	}    
	else {    
		window.addEventListener('load', ev_onload, false);   
	} 
	jQuery(document).ready(function(){
		//表单控件jquery重构
		jqRefactor();
		});
</script>
</head>
<body align="center">
<div id="tips">
  <table width=100% height=100% align=center cellpadding=0 cellspacing=0 border=0 >
    <tr>
      <td align=center valign=middle><img src="<%=contextPath%>/resource/imgnew/loading.gif">
      	<font size='3'><strong>{*[Loading]*}...</strong></font></td>
    </tr>
  </table>
</div> 
<iframe align="middle"  id = "iframe_content" name="iframe_content" width="100%" height="100%" scrolling="yes" src=""></iframe>

</body>
</o:MultiLanguage></html>