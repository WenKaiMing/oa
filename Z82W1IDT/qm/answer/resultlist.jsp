<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>答卷列表</title>
<link href="../css/theme.css" rel="stylesheet" type="text/css">
<link href="../css/table.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	
	function showResult(id){
		window.location.href = "view.action?id="+id;
	}
	
	function selectAll(b, isRefresh) {
		var c = document.all('_selects');
		if (c == null)
			return;

		if (c.length != null) {
			for (var i = 0; i < c.length; ++i)
				c[i].checked = b && !(c[i].disabled);
		} else {
			c.checked = b;
		}
	}
	
	$(document).ready(function(){
		var $tr = $(".gridtable").find("tr:gt(0)");
		var $question_id = $("input[name='question_id']");
		var questionid = $question_id.val();
		$tr.each(function(){
			var $td = $(this).children("td:eq(2)");
			if(questionid == null || questionid.length <=0){
				var $a = $td.children().eq(1);
				$a.text("点击查看");
				return;
			}
			var $hidden = $td.children().eq(0);
			var answers = $.parseJSON($hidden.text());
			for(var i=0;i<answers.length;i++){
				var answer = answers[i];
				if(answer.id == questionid){
					var value = answer.value;
					var $a = $td.children().eq(1);
					$a.text(value);
				}
			}
		});
	});
	
</script>
</head>
<body>
<s:form id="formList" name="formList" action="list.action" method="post" theme="simple">
	<s:hidden name="question_id" />
	<div style="width: 88%; min-width: 700px;padding:2px">
		<table class='gridtable' width="100%">
			<thead>
				<tr>
					<td>答卷人</td>
					<td>答卷时间</td>
					<td>答案</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="datas.datas" status="index" id="answer">
					<tr class="Query_Form_table">
					<td class="Query_Form_table_text">
						<a href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="userName" />
						</a>
					</td>
					<td class="Query_Form_table_text">
						<a href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:date name="date" format="yyyy-MM-dd" />
						</a>
					</td>
					<td class="Query_Form_table_text"><span style="display:none"><s:property value="answer" /></span><a href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();"></a></td>
					
					</tr>
				</s:iterator>
			</tbody>
		</table>

	</div>
	</s:form>
</body>
</html>