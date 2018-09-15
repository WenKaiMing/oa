<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[attachment]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
<p> SUCCESS!</p>
<script language="JavaScript">
	var webPath = '<s:url value="%{webPath}"/>';
	var	index = webPath.indexOf("_");
	//alert(webPath.substring(0, index));
	parent.sFromUrl = webPath.substring(0, index);
	parent.ReturnValue();
  	window.close();
</script>
		
</body>
</o:MultiLanguage></html>
