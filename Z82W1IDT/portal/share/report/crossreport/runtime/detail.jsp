<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>report detail</title>
<style>
.content-table {
	border:1px solid black;

}

.content-table td {
	border:1px solid gray;
}

.display_view-table2 {
	border: 0px solid #FFFFFF;
	width: 100%;
	font-family: Arial, Vendera;
	font-size: 12px;
	z-index: 100;
	background:white;
}
.cursor:pointe
</style>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main-front.css'/>"
	type="text/css">
	
</head>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src="<s:url value='/portal/share/script/list.js'/>"></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script>
function viewDoc(docid, formid) {
		wx = '800px';
	    wy = '600px';
		
		var url = '<s:url value="/portal/dynaform/document/view.action" />' ;
		url += '?_docid=' + docid;
		
		if (formid != null && formid != "") {
			url += '&_formid=' +  formid;
		}
		
		// 查看view.js
		openWindowByType(url,'{*[Select]*}', VIEW_TYPE_NORMAL); 
	}
	
function ev_submit() {
	document.forms[0].submit();
	}

function doPrint() {
	window.print();
}

function doPageSet(){ 
	WB.ExecWB(8,1) 
} 

function doPreview(){ 
	WB.ExecWB(7,1) 
} 
</script>
<body class="body-front">
<s:form action="runreport" method="post" theme="simple" name="formList"  validate="true">
<span class='button-document'><a href="#" id='button_act' title='{*[Back]*}' onclick="ev_submit()"
 onmouseover='this.className="button-onchange"' onmouseout='this.className="button-document"' ><span>
 <img style='border:0px solid blue;vertical-align:middle;' src='../../../../resource/imgv2/front/act/act_10.gif' />&nbsp;{*[Back]*}</span></a>
 </span>
 
	<s:hidden name="reportId"  id ="reportId" value="%{#parameters.reportId}"/>
<%@include file="/common/list.jsp"%>
<%
String chartstr = (String)(request.getAttribute("detailStr"));
request.setAttribute("detailStr",chartstr);
%>
<%=chartstr%>
	<s:url id="backURL" action="runreport" >
		<s:param name="reportId" value="#parameters.reportId" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="_currpage" value="datas.pageNo"/>
	</s:url>
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage>
</html>