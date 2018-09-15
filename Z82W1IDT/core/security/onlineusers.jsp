<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="cn.myapps.core.user.action.*"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.base.dao.DataPackage"%>
<%@include file="/common/tags.jsp"%>
<html><o:MultiLanguage>
<head>
<title>OnlineUsers</title>
</head>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>'
	type="text/css">
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onload="init()">
<s:form action="/login.action" method="POST" theme="simple">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<%
			DataPackage dpg = OnlineUsers.doQuery(new ParamsTable());
			out.println("<tr><td>Total Users:</td><td>" + dpg.datas.size()
					+ "</td></tr>");
			if (dpg != null && dpg.datas != null)
				for (Iterator iter = dpg.datas.iterator(); iter.hasNext();) {
					WebUser user = (WebUser) iter.next();
					String dpts = "";
					out.println("<tr><td>" + user.getId() + "</td><td>"
					+ user.getName() + "</td></tr>");

				}
		%>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
</http>

