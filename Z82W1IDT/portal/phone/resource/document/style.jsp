<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		if (text != null && !text.trim().isEmpty()) {
			out.print("<style>");
			out.print(text);
			out.print("</style>");
		} else {
			String urlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/resource/document/main-front.css",request,response);
			String linkStr = "<link rel='stylesheet' href='"
					+ urlStr + "' />";
			System.out.print(linkStr);
			out.print(linkStr);
		}
	}
%>