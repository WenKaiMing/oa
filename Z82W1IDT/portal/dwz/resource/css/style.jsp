<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ww" uri="webwork"%>
<%@ page
	import="cn.myapps.core.style.repository.action.StyleRepositoryHelper"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.util.file.FileOperate"%>
<%
	String styleid = request.getParameter("styleid");

	if (styleid != null && styleid.trim().length() > 0) {
		//	StyleRepositoryProcess process = (StyleRepositoryProcess)ProcessFactory.createProcess(StyleRepositoryProcess.class);
		//	StyleRepositoryVO vo = (StyleRepositoryVO)process.doView(styleid);
		String text = StyleRepositoryHelper.getStyleContent(styleid);
		if (text != null) {
			out.print("<style>");
			out.print(text);
			out.print("</style>");
		}
	}
//读出theme中的cookie
	String skin = "";
	Cookie myCookie[] = request.getCookies();
	for (int n = 0; n < myCookie.length; n++) {
		Cookie newCookie = myCookie[n];
		if (newCookie.getName().equals("dwz_theme")) //判断元素的值是否为dwz_theme中的值
		{
			skin = newCookie.getValue();
		}
	}
	
	if(skin==null || skin.length()<=0) {
		skin = "default";
	}

	String linkStr = "<link rel='stylesheet' href='" + request.getContextPath() +"/portal/dwz/themes/" + skin + "/main-front.css' />";
	out.print(linkStr);
%>