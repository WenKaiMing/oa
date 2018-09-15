<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%
WebUser user = (WebUser) request.getSession().getAttribute(
		Web.SESSION_ATTRIBUTE_FRONT_USER);
%>
<style type="text/css">
.setting .inputText {
	font-size:1.4em;
}
</style>
	<label for="">用户名</label>
	<input name="content.name" class="inputText" value="<%=user.getName() %>" disabled="disabled"/>
	<label for="">账户名</label>
	<input readonly="true" class="inputText"  name="content.loginno" value="<%=user.getLoginno() %>" disabled="disabled"/>
	<label for="">电子邮箱</label>
	<input name="content.email" class="inputText" value="<%=user.getEmail() %>" disabled="disabled"/>
	<label for="">手机</label>
	<input name="content.telephone" class="inputText" value="<%=user.getTelephone() %>" disabled="disabled"/>
	<%
	String fromWeixin = (String)request.getSession().getAttribute("visit_from_weixin");
	if(fromWeixin == null){
	%>
	<input type="button" onclick="window.location.href='./logout.jsp';" value="注销" class="logoutBtn" />
	<%
	}
	%>