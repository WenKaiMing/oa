<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="java.util.*"%>
<!doctype html>
<html>
<head>
<title>微OA365</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
		<%
		WebUser user = (WebUser) request.getSession().getAttribute(
				Web.SESSION_ATTRIBUTE_FRONT_USER);
		ApplicationHelper ah = new ApplicationHelper();
		Collection<ApplicationVO> appList = ah.getAppList();
		String contextPath = request.getContextPath();
		for (ApplicationVO applicationVO : appList) {

			if (!applicationVO.isActivated())
				continue;
			
			String appId1 = applicationVO.getId();

			out.print("<div class='appName'><img src='./resource/launchpad/menu.png' class='ul-li-icon'><a href='main.jsp?application="+appId1+"'>"
					+ applicationVO.getName() 
					+ "</a></div>");
		}
	%>
</o:MultiLanguage>
</body>
</html>