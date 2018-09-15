<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="cn.myapps.util.http.UrlUtil"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[{*[View]*}]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url id="url" value='/resourse/main.css'/>" />
<script src="<s:url value='/portal/share/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>

<body>
	<% 
		ParamsTable params = ParamsTable.convertHTTP(request);
		WebUser user =(WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		View view = (View)request.getAttribute("content");
		Document doc = (Document)request.getAttribute("currentDocument");
		//String contextPath = request.getContextPath();
		
		Map oldPasams = new HashMap(request.getParameterMap());
		oldPasams.put("innerType",view.getInnerType());
		
		if (view.getLink() != null) {
			// 参数处理，新参数替换旧参数
			String url = view.getLink().toLinkUrl(doc, params, user);
			String newUrl = UrlUtil.deparameterize(url, oldPasams, true);
			url = UrlUtil.parameterize(newUrl, oldPasams);
			
			response.sendRedirect(url);
			//request.getRequestDispatcher(url).forward(request, response);
		}
	%>
</body>
</o:MultiLanguage></html>
