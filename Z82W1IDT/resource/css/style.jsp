<%@page import="cn.myapps.util.file.FileOperate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.style.repository.action.StyleRepositoryHelper"%>

<%
String styleid = request.getParameter("styleid");
if (styleid!=null && styleid.trim().length()>0) {
//	StyleRepositoryProcess process = (StyleRepositoryProcess)ProcessFactory.createProcess(StyleRepositoryProcess.class);
//	StyleRepositoryVO vo = (StyleRepositoryVO)process.doView(styleid);
	String text = StyleRepositoryHelper.getStyleContent(styleid);
	if (text!=null) {
		out.print(text);
	}
}
else {
	String filePath = application.getRealPath("resource/css/main-front.css");
	String content = cn.myapps.util.file.FileOperate.getFileContentAsString(filePath);
	out.print(content);
}
%>