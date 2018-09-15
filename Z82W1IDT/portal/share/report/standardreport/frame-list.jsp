<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<o:Url value='/resource/css/style.jsp'/>" />
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
<title>Insert title here</title>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ReportUtil.js"/>'></script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<style type="text/css">
body {
	background-color:#dfe8f6;
}
</style>
</head>
<%
  String width = request.getParameter("width");
  String height = request.getParameter("height");
%>
<body onload="on_load()" style="margin:0px;">
<script>

  function on_load(){
   var arrayObj = new Array() ;
   var tempObj = parent.document.getElementsByName('col');
   
   var j =0;
   for(var i=0 ;i<tempObj.length;i++){
     if(tempObj[i].value != null&& tempObj[i].value!=''){
       arrayObj[j] = tempObj[i].value;
       j++;
     }
   }
   if(arrayObj.length == 0)
     arrayObj[0] = 'AUDITOR';
    var dbmethod = parent.document.getElementsByName("dbmethod")[0];
    var application = parent.document.getElementsByName("application")[0];
    var formId = parent.document.getElementsByName("_formid")[0];
    var startdate = parent.document.getElementsByName("startdate")[0];
    var enddate = parent.document.getElementsByName("enddate")[0];

    ReportUtil.getTabContent(application.value, formId.value, startdate.value,
    enddate.value, arrayObj, dbmethod.value, function(str){
     document.getElementById("listdiv").innerHTML = str;
    });
}
</script>

<div id="listdiv"  style='overflow:auto;' width="<%=height%>" height="<%=height%>" >
</div>
</body>
</html>