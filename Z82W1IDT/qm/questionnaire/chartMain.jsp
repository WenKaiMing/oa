<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结果主界面</title>
</head>

<link href="../css/theme.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.questionnaire.js"></script>
<script type="text/javascript" src="../js/qm.chart.js"></script>
<script type="text/javascript" src="../js/highcharts.js"></script>
<script type="text/javascript">

	var id = '<%=request.getParameter("id")%>';
	$(document).ready(function(){
		$("#back").click(function(){
			window.location.href="list.action";
		});
	});
</script>

<body style="overflow: auto;height: 87%;">
	<div style="background:#595959; height:65px;">
	<a id="back" class="btn btn-primary_Blue" href="javascript:void(0)">返回</a>  
	</div>
	<iframe scrolling="auto" style="overflow: auto; height: 100%; width: 100%;" id="frame" name="frame"
				src="showresult.action?id=<%=request.getParameter("id") %>"
				width="100%" height="100%" frameborder="0" /></iframe>
</html>