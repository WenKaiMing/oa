<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/theme.css" rel="stylesheet" type="text/css">

<title>预览界面</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.answer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		QM.answer.init($("#question").val(),"");
	});
	
</script>
</head>
<body style="text-align: center;">
	<s:form id="formList" name="formList" action="save.action" method="post" theme="simple" >
		<input type='hidden' name='content.id' value='<s:property value='content.id' />'/>
		<input type='hidden' name='content.questionnaire_id' value='<s:property value='content.questionnaire_id' />'/>
		<textarea id="question" name='content.content' style='display: none'><s:property
				value='content.content' /></textarea>
		<div style="border:solid 1px #ddd;width:650px;padding:20px">	
			<div style="padding-bottom:50px"><h1><s:property value='content.title' /></h1></div>
			<div>
				<div id="maiDiv" style="text-align:left;" ></div>
			</div>
		</div>
	</s:form>
</body>
</html>