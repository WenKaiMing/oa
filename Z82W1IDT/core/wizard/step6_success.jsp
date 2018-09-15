<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.util.cache.ICacheProvider"%>
<%@ page import="cn.myapps.util.cache.MyCacheManager"%>
<%@include file="/common/taglibs.jsp"%>

<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", -1);


	ICacheProvider provider = MyCacheManager.getProviderInstance();
	String[] cacheNames = provider.getCacheNames();

	for (int i = 0; i < cacheNames.length; ++i) {
		provider.clearCache(cacheNames[i]);
	}
	
%>
<html>
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="0">

</script>

<title></title>
</head>

<body>
loading....
</body>
<script>

var url  = '<s:url value='/core/deploy/module/edit.action' />';
url += "?applcation=" + '<s:property value="#parameters.application" />';
url += "&refresh=leftFrame";
url += "&id=" + '<s:property value="#request.mid" />';


	window.location.href =  url;
</script>
</html>
