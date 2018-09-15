<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	boolean isSuperAdmin = user.isSuperAdmin();
	boolean isDomainAdmin = user.isDomainAdmin();
%>
<o:MultiLanguage>
<html>
<head>
<title>{*[Monitor]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css" />
<script type="text/javascript">
jQuery(document).ready(function(){
	var obj=window.parent.document;
	obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML;
	jQuery(".forInitCurrentPosition").click(function(){
		debugger
		obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML+">><a target='detail' title='"+jQuery(this).attr("topage")+"' href='"+jQuery(this).attr("clickval")+"' class='currentPosition'>"+jQuery(this).attr("topage")+"</a>";
		if(obj.getElementById("currentPosition4")){
			obj.getElementById("currentPosition4").innerHTML=obj.getElementById("currentPosition").innerHTML;
		}
		window.location = jQuery(this).attr("clickval");
	});
});
</script>
</head>
<body>
	<h2 style="text-align: center; color: #AB0101;">{*[System_Monitor]*}</h2>
<div style="vertical-align: middle; height:90%;" align="center">
	<table class="table-monitor" height="200px" width="500px" cellspacing="0px" cellpadding="0px">
		<tr>
			<td style="font-size:16px;"><b>{*[Druid Monitor]*}</b></td>
			<td>对数据源连接情况、sql执行效率、sql防火墙、web并发、session等多维度的实时监控</td>
			<td><input type="button" class="forInitCurrentPosition" topage="{*[Druid Monitor]*}" value="进入" clickval="<s:url value='/core/monitor/druid/index.html'/>" /></td>
		</tr>
		<tr>
			<td style="font-size:16px;"><b>{*[Jamon]*}</b></td>
			<td>监控宏语言、系统类方法及Sql的执行效率</td>
			<td><input type="button" class="forInitCurrentPosition" topage="{*[Jamon]*}" value="进入" clickval="<s:url value='/core/jamon/menu.jsp'/>" /></td>
		</tr>
		<!-- <tr>
			<td style="font-size:16px;"><b>SOAP</b></td>
			<td>SOAP信息管理</td>
			<td><input type="button" class="forInitCurrentPosition" topage="{*[SOAP]*}" value="进入" clickval="<s:url value='/core/axis2/soapmonitor.html'/>" /></td>
		</tr> -->
		<tr>
			<td style="font-size:16px;"><b>web-services</b></td>
			<td>web-services调用和执行情况</td>
			<td><input type="button" class="forInitCurrentPosition" topage="{*[Web-services]*}" value="进入" clickval="<s:url value='/servlet/AdminServlet'/>" /></td>
		</tr>
		<%
		if (isSuperAdmin || isDomainAdmin) {
		%>
		<tr>
			<td style="font-size:16px;"><b>OnlineUsers</b></td>
			<td>监控服务器当前在线用户会话(Session)情况</td>
			<td><input type="button" class="forInitCurrentPosition" topage="{*[OnlineUsers]*}" value="进入" clickval="<s:url value='/core/user/onlineUsersList.action?_pagelines=10'/>" /></td>
		</tr>
		<%
			}
		%>
	</table>
</div>
</body>
</html>

</o:MultiLanguage>