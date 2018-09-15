<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% out.println("<!--TARGET SERVLETPATH:"+request.getServletPath()+"-->");%>
<%
	String contextPath = request.getContextPath();
%>
<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->

<script type="text/javascript" >
var contextPath = "<%=contextPath%>";
var serverAddr = '<s:property value="#session.KM_FRONT_USER.serverAddr" />';
</script>