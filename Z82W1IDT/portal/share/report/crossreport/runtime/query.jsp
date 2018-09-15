<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.report.crossreport.definition.ejb.CrossReportProcess" %>
<%@ page import="cn.myapps.core.report.crossreport.definition.ejb.CrossReportVO" %>
<%@ page import="cn.myapps.core.dynaform.view.ejb.ViewProcess" %>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View" %>
<%@ page import="cn.myapps.util.ProcessFactory" %>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>report content</title>
<%
String chartstr = (String) (request.getAttribute("str"));
request.setAttribute("str", chartstr);
%>
<script>
   function doQuery(){
	   OBPM.dialog.doReturn(dy_getValuesMap(false));
   }

   function ev_resetAll() {
		var elements = document.forms[0].elements;

		for (var i = 0; i < elements.length; i++) {
			if(jQuery(elements[i]).attr('fieldType')=='UserField'){
				elements[i].value = "";
			}
			// alert(elements[i].id + ": "+elements[i].type + " resetable-->" +
			// elements[i].resetable);
			if (elements[i].type == 'text' || elements[i].resetable) {
				elements[i].value = "";
			} else if (elements[i].type == 'select-one') {
				// 还原至第一个选项
				if (elements[i].options.length >= 1) {
					elements[i].options[0].selected = true;
				}
			}
		}
	}
   jQuery(document).ready(function () {
		//表单控件jquery重构
		jqRefactor();
   });
</script>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/dialog.css'/>" type="text/css"  media="all" />
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script src='<s:url value="/portal/share/script/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<link rel="stylesheet"
	href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
</head>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<body class="body-front1">
	<s:form action="runreport" method="post" theme="simple" name="formItem" validate="true">
	<s:hidden name="reportId" id="reportId" value="%{#parameters.reportId}" />
	<s:hidden name="application" id="application" value="%{#parameters.application}" />
			<%=chartstr%>
	</s:form>
	</body>
</o:MultiLanguage>
</html>