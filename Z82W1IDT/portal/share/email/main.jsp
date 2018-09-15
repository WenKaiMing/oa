<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="cn.myapps.core.email.folder.ejb.EmailFolder"%><%@page import="cn.myapps.core.email.util.Constants"%>
<%@page import="cn.myapps.core.email.folder.action.EmailFolderHelper"%><html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/portal/share/email/css/email.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/portal/share/email/css/icon.css'/>" type="text/css">
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/email/script/email.js'/>"></script>
<style type="text/css">
body {
	margin-left: 1%; 
	width: 98.2%;
	margin: 0px;
	padding: 0px;
	overflow-x:hidden;
}

table {border: 0;}

td {
	line-height: 26px;
	overflow: hidden;
}
th {
	line-height: 26px;
}

thead tr {
	background: #BDC5CC;
}

tbody tr {
	background: #EEF0F2;
}

tr.odd {
	background: #ffffff;
}

tr.highlight {
	background: #FFF3BF;
}

tr.selected {
	background: #FFF3BF;
}

.line_style {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}

.line_style_left {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}
.line_style_fight {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
}

.Th_Read_Icon {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
}

.Th_From {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}

.Th_Subject {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}
.Th_Date {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}
.Th_icoATCM {
	border-bottom: 1px solid #cccccc;
	border-top: 1px solid #cccccc;
}
.Td_sy {
	/*border-bottom: 1px solid #cccccc;*/
}
.Td_Read_Icon {
	/*border-bottom: 1px solid #cccccc;*/
}
.Td_Unread_Icon {
	/*border-bottom: 1px solid #cccccc;*/
}
.Td_From {
	/*border-bottom: 1px solid #cccccc;*/
}

.Td_Subject {
	/*border-bottom: 1px solid #cccccc;*/
	overflow: hidden;
}
.Td_Date {
	/*border-bottom: 1px solid #cccccc;*/

}
.Td_icoATCM {
	/*border-bottom: 1px solid #cccccc;*/
}
</style>
</head>
<body class="All_C_Page Inbox" style="margin-left: 1%; width: 98.2%; margin-top: 4px;"><jsp:include page="list.jsp" /></body>
</o:MultiLanguage></html>