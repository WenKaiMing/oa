<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.widget.action.PageWidgetHelper"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.myapps.core.user.ejb.UserDefined"%>
<%@page import="cn.myapps.core.widget.ejb.PageWidget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);

	ParamsTable params = ParamsTable.convertHTTP(request);

	String id = request.getParameter("id");
	PageWidgetHelper widgetHelper = new PageWidgetHelper();
	PageWidget widget = widgetHelper.getWidget(id);
	String url = widget.toUrl(params, user);
	ServletContext sc = getServletContext();
	RequestDispatcher rd = null;
	rd = sc.getRequestDispatcher(url);
	rd.forward(request, response);
%>