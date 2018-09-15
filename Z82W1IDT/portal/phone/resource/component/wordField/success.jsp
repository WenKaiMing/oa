<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%
String filePath = "";
WordFieldForm form = (WordFieldForm)request.getAttribute("WordFieldForm");
if (form!=null) {
  filePath = form.getFilePath();
}
%>
<html>
<head>
<title>{*[attachment]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
<script language="JavaScript">
<!--
  window.returnValue = '<%=filePath%>';
  window.close();
// -->
</script>
</body>
</html>
