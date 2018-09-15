<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%
	String previewId = request.getParameter("previewId");
	String previewTitle = request.getParameter("previewTitle");
	String previewText = request.getParameter("previewText");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/theme.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="./css/print.css" media="print">
<title>问卷填写界面</title>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/qm.core.js"></script>
<script type="text/javascript" src="./js/qm.answer.js"></script>
<!-- <script type="text/javascript" src="./js/qm.questionnaire.js"></script> -->

<script type="text/javascript">
	$(document).ready(function() {
		var reg = new RegExp("\n","g");
		var previewText = '<%=previewText %>'.replace(reg,"\\n");
		
		//初始化问卷
		QM.answer.init(previewText, "");
		
	});
	

</script>
</head>
<body style="text-align: center;overflow-y: auto;">
		<div style="text-align:left; background:#f5f5f5; height: 65px;" class="noprint">
			<a class="btn btn-primary_green"  id="print" href='javascript:print();' style="float:right;margin-right: 27px;">打印</a>
		</div>
		<div style=" width: 100%; height: 95%;" id="printpage">
			<div style="padding-bottom: 10px; border-bottom: 3px #8ad748 solid;text-align:center;"><h1><%=previewTitle %></h1></div>
			<div>
				<div id="maiDiv" style="text-align:left;" ></div>
			</div>
		</div>
</body>
</html>