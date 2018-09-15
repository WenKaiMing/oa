<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/tags.jsp"%>
<html><o:MultiLanguage>
<head>
<%
  String contextPath = request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script >
//has parent window 
var typeflage = typeof(dialogArguments);
 var url = parent.location;
 var timeout ;
 var flag=10;
 var flag2 =1;
 var type1 =1;
   if(url!=null&&url!="")
{
  if(typeof(dialogArguments)!='undefined'){
   type1 =2;
  }
  else{
   var object1 = window.parent;
   window.top.location='<%=contextPath%>/admin/login_error.jsp';
   
 }
 }else{
 window.location='<%=contextPath%>/admin/login_error.jsp';
 }
  
//alert(temp);
</script>
<body align="center">
<table valign="center">
<tr><td style="color: red;">
你的登录已经过期，请重新登录！</td></tr>
</table>
</body>
</o:MultiLanguage></html>