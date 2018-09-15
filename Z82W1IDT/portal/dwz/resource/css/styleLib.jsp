<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.style.repository.action.StyleRepositoryHelper"%>
<%@ page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.util.file.FileOperate"%>
<%
	String styleid = request.getParameter("styleid");
	if (styleid != null && styleid.trim().length() > 0) {
		String text = StyleRepositoryHelper.getStyleContent(styleid);
		if (text != null && !text.trim().isEmpty()) {
			out.print("<style>");
			out.print(text);
			out.print("</style>");
		}
	}
%>