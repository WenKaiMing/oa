<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/theme.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="../css/print.css" media="print">
<title>问卷填写界面</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.answer.js"></script>

<link href="../js/toastr/toastr.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../js/toastr/toastr.min.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
	
<script type="text/javascript">
	$(document).ready(function() {
		$("#back").click(function() {
			var jumpType = $("input[name='s_jumpType']").val();
			if(jumpType != null && jumpType == "HOMEPAGE"){
				document.forms[0].action = contextPath+'/qm/answer/index.jsp';
				document.forms[0].submit();
			}else{
				document.forms[0].action = contextPath+'/qm/questionnaire/list.action';
				document.forms[0].submit();
			}
		});
		
		QM.answer.init($("#question").val(),$("#answer").val());
		
	});
	
	function doSubmit(){
		if(confirm("是否提交案卷(提交后不可以再作答)?")){
			var flag = QM.answer.checkRequired();
			if(flag){
				var json = QM.answer.encodeJson();
				var $content = $("#answer");
				$content.val(json);
				document.forms[0].submit();
			}else{
				//alert("请填写带 * 必填题");
				Common.Util.showMessage("请填写带 * 必填题", "warning");
			}
		}
	}

</script>
</head>
<body style="text-align: center;" class="printOver">
	<s:form id="formList" name="formList" action="save.action" method="post" theme="simple" >
		<input type='hidden' name='content.id' value='<s:property value='content.id' />'/>
		<input type="hidden" name="s_jumpType" value="<s:property value='#parameters.s_jumpType' />" id="formList_s_jumpType">
		<input type='hidden' id="questionnaire_id" name='content.questionnaire_id' value='<s:property value='content.questionnaire_id' />'/>
		<textarea id="question" name='content.content' style='display: none'><s:property
				value='content.content' /></textarea>
		<textarea id="answer" name='content.answer' style='display: none'><s:property
				value='content.answer' /></textarea>
		<input type="hidden" id="_back_url_type" name="type" value="<s:property value='#parameters.type' />" />
		<input type="hidden" id="_back_url_status" name="status" value="<s:property value='#parameters.status' />" />
		<input type="hidden" id="_back_url_currpage" name="_currpage" value="<s:property value='#parameters._currpage' />" />
		<input type="hidden" id="_back_url_pagelines" name="_pagelines" value="<s:property value='#parameters._pagelines' />" />
	
		<div style="text-align:left; background:#f5f5f5; height: 65px;" class="noprint">
			<a class="btn btn-primary"  id="back" href='javascript:void(0)'>返回</a>
			<a class="btn btn-primary_green" href='javascript:doSubmit();'>提交</a> 	
			<div class="right-btn">
					<a class='btn btn-primary_Blue btn-preview'  href='javascript:print();'>打印</a>
				</div>
		</div>
		<div id="qmTianxie">
			<div style="padding-bottom: 10px; border-bottom: 3px #8ad748 solid;"><h1><s:property value='content.title' /></h1></div>
			<div>
				<div id="maiDiv" style="text-align:left;" ></div>
			</div>
		</div>
	</s:form>

</body>
</html>