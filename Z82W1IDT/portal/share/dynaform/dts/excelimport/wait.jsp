<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String contextPath = request.getContextPath();
	//String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath;
	String action = contextPath + "/portal/share/dynaform/dts/excelimport/ImprotExcel.action";
%>
<html>
<head>
<title>Insert title here</title>

</head>
<body>
<script type="text/javascript">
	setTimeout("window.location='<%=action %>'", 3000);
</script>
	<table width="100%" height="50%">
	<tr>
		<td align="center"><img src="<s:url value="/resource/imgnew/loading.gif"/>" /></td>
	</tr>
	<tr>
	<td align="center"><h1>数据导入中,请稍候.....</h1></td>
		</tr>
	</table>
</body>
</html>