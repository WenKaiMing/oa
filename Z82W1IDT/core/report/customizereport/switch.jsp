<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String chartType = request.getParameter("chartType");
String openType = request.getParameter("openType");
String type1 = request.getParameter("type1");
String domainid = request.getParameter("domainid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function init(){
	var openType = '<%=openType%>';
	var type1 = '<%=type1%>';
	if (navigator.appName.indexOf("Microsoft") != -1) {
		var oReport = parent.document.getElementById("oReport");
		document.getElementById('json').value =oReport.getJSON(openType);
		document.getElementById('jsonData').value = oReport.getJsonData();
		if(type1=="ExplorerCanvasFilter"){
			document.getElementById('filter').value = oReport.getFilter();
		}
   	} else {
	    document.getElementById('json').value = parent.document.oReport.getJSON(openType);
	    document.getElementById('jsonData').value = parent.document.oReport.getJsonData();
	    if(type1=="ExplorerCanvasFilter"){
	    	document.getElementById('filter').value = parent.document.oReport.getFilter();
	    }
   	}
	document.forms[0].submit();
	
}

</script>
</head>
<body onload="init()">
<form id="form1" action="jFreeChart.jsp" method="post">
<input type="hidden" id="json" name="json"/>
<input type="hidden" name="chartType" value="<%=chartType %>"/>
<input type="hidden" name="filter" id="filter"/>
<input type="hidden" name="domainid" value="<%=domainid %>"/>
<input type="hidden" name="jsonData" id="jsonData"/>
</form>
</body>
</html>