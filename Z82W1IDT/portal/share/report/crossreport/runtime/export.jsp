<%@page import="org.apache.fop.render.awt.viewer.PageChangeEvent"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%
	//处理url传中文参数
	String filename = (String)request.getAttribute("filename");
	String path = DefaultProperty.getProperty("REPORT_PATH");
	String filepath = application.getRealPath(path);
	response.setContentType("application/x-msdownload; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(filename.trim(), "UTF-8"));
	response.setCharacterEncoding("UTF-8");
	OutputStream os = response.getOutputStream();
	BufferedInputStream reader = new BufferedInputStream(
			new FileInputStream(filepath + "/" + filename));
	byte[] buffer = new byte[4096];
	int i = -1;
	while ((i = reader.read(buffer)) != -1) {
		os.write(buffer, 0, i);
	}
	os.flush();
	os.close();
	reader.close();
	out.clear();
	out=pageContext.pushBody();
%>
