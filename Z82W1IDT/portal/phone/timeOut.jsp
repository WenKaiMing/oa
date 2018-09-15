<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
  	String contextPath = request.getContextPath();
	String actionUrl = (String)request.getAttribute("_ActionUrl");
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>TimeOut</title>
</head>
<script >
var url = "<%=contextPath%>" + "/portal/phone/login.jsp";
window.location.href = url;
if(window.confirm('登陆超时,请重新登陆')){
	if(WeixinJSBridge){
		WeixinJSBridge.invoke('closeWindow',{},function(res){
		});
	}
 }
</script>
<body align="center">
</body>
</o:MultiLanguage></html>