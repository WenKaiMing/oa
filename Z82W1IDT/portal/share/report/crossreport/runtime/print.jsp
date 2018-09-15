<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.report.crossreport.print_report]*}</title>
<%
	String chartstr = (String) (request.getAttribute("str"));
	request.setAttribute("str", chartstr);
%>
<style>
.content-table {
	border: 1px solid black;
}

.title1 {
	font-weight: bold;
	font-family: 宋体; 
	font-size: 9pt
}

.note {
	font-weight: bold;
	font-family: 宋体; 
	font-size: 9pt
}

.content-table td {
	border: 1px solid gray;
}

a {
	text-decoration: none;
	font-size: 12px;
}

.tr-total {
	background-color:#EEF0F2;
	color: red;
}

a:active {
	text-decoration: underline;
}

a:HOVER {
	text-shadow: black;
	text-decoration: underline;
}

.cursor:pointe

* {
	margin: 0px;
	padding: 0px;
}

#container {
	border: 1px solid #e4e4e4;
	visibility: hidden;
}

#activityTable {
	border-bottom: 1px solid #e4e4e4;
	margin: 0;
	padding: 0;
	height: 23px;
	width: 100%;
}

#container,#activityTable,#searchFormTable,#pageTable {
	overflow: hidden;
}

#dataTable {
	overflow-x: auto;
	overflow-y: auto;
	background-color: white;
}

#searchFormTable {
	background-color: white;
	padding: 10px;
	width: 100%;
}

.body-front1 {
	margin-top: 0px;
	margin-left: 0px;
	padding: 0px; 
	margin: 0px;
}

.display_view-table1 {
	border: 0px solid #e4e4e4;
	width: 100%;
	font-family: Arial, Vendera;
	font-size: 12px;
	z-index: 100;
}

.dtable-header1 {
	height: 24px;
	text-align: center;
	vertical-align: middle;
	text-align: center;
	z-index: 100;
	white-space: nowrap;
	background-color: #EEF0F2;
}

.table-tr1 td {
	background-color: #FFFFFF;
}

.table-tr-onchange1 {
	background-color: #fbefda;
}

@media print {
	#actprint {
		display : none;
	}
}
</style>
<script>
function ev_onload()
{
	container.style.visibility = "visible";
}

function doPrint() {
	  //document.getElementById("actprint").style.visibility = "hidden";
	  //WB.ExecWB(7,1);
	  //document.getElementById("actprint").style.visibility = "visible";
	  window.print();
	}
</script>
<link rel="stylesheet"
	href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
</head>
	<body class="body-front1" onload="ev_onload()">
<OBJECT classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 id=WB width=0></object>

	<table style="width: 100%; vertical-align: top;">
		<tr id="actprint" valign="top" style="height:50px;">
			<td align="right"><span class='button-document'><a
				href="#" id='button_act' title='{*[Print]*}' onclick="doPrint()"
				onmouseover='this.className="button-onchange"'
				onmouseout='this.className="button-document"'><span> <img
				style='border: 0px solid blue; vertical-align: middle;'
				src='../../../../resource/imgv2/front/act/act_25.gif' />&nbsp;{*[Print]*}</span></a>
			</span></td>
		</tr>
		<tr valign="top">
			<td>
			<div id="container" style="width: 100%;">
				<%@include file="/common/list.jsp"%>
				<%=chartstr%>
			</div>
			</td>
		</tr>
	</table>
	</body>
</o:MultiLanguage>
</html>