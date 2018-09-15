<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!-- todo -->
<!-- todo -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<link href="../css/theme.css" rel="stylesheet" type="text/css"></link>
<link type="text/css" rel="stylesheet" href="../css/print.css" media="print">
<title>结果战士</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.result.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						QM.result.init($("#question").val(),$("#answer").val());
						//todo
						var val=QM.open;
						var total=QM.question;
						var correct=QM.correct;

						//生成分数栏
						if(val==true){
							$div=$("<div style='margin-bottom: 10px;'></div>");
							$table=$("<table style='width:100%'></table>");
							
							$tr1=$("<tr><td width='50%'>总分值</td><td width='50%'>个人得分</td></tr>");
							$score=$("<tr><td><s:property value='content.totalScore'/></td><td><s:property value='content.account'/></td></tr>");
							
							$tr2=$("<tr><td width='50%'>考题数</td><td width='50%'>答对数目</td></tr>");
							$question=$("<tr><td>"+total+"</td><td>"+correct+"</td></tr>");
							
							$("#analysis").append($div);
							$div.append($table);
							$table.append($tr1);
							$table.append($score);
							$table.append($tr2);
							$table.append($question);
						}
						
						var $button = $("#jump");
						$button.click(function(){
							var jumpType = $("input[name='s_jumpType']").val();
							if(jumpType != null && jumpType == "HOMEPAGE"){
								window.location.href = contextPath+"/qm/answer/index.jsp";
							}else{
								document.forms[0].action = '../questionnaire/list.action';
								document.forms[0].submit();
							}
							
						});
					});
	function f1(){
		//var hwnd=window.open(""); 
		//hwnd.document.write(content.innerHTML);
		var obj=document.getElementById("contentResult");
		var content=obj.innerHTML;
		//var hwnd=window.open(""); 
		//hwnd.document.write(content);
		//window.location.href="download.action?content="+content;
		//$("#i1").val(encodeURI(content));
		$("#i1").val(content);
		document.forms[0].submit();
	}

</script>
</head>
<body style="overflow: auto;width: 100%;height: 90%;">
<div style="background: #f5f5f5; height:65px;" class="noprint">
	<a id='jump'  class='btn btn-primary'>返回</a>
	<!-- todo --><!-- href="download.action" -->
	<a id='download' class='btn btn-primary_green' onclick="f1();" target="_blank" style="display:none;">下载</a>
	<a class='btn btn-primary_green btn-print' href='javascript:print();'>打印</a>
	</div>
	<s:textarea id="question" name="content.content" style="display:none"></s:textarea>
	<s:textarea id="answer" name="content.answer" style="display:none"></s:textarea>
	<s:hidden name="s_jumpType"></s:hidden>
	<s:hidden name="content.id"></s:hidden>
	<s:hidden name="content.userId"></s:hidden>
	<input type="hidden" id="_back_url_type" name="type" value="<s:property value='#parameters.type' />" />
	<input type="hidden" id="_back_url_status" name="status" value="<s:property value='#parameters.status' />" />
	<div id="contentResult" style="width: 100%;height: 98%;overflow: auto;">	
			<div style="padding-bottom:10px;text-align: center; border-bottom: 3px #8ad748 solid;"><h1><s:property value="content.title" /></h1></div>
			<div id="analysis" style='padding: 15px 0px 0px 15px; margin-bottom: 10px;border-bottom: 1px solid #f4f4f4;'>1.基本情况分析
				<%-- <div style='margin-bottom: 10px;'>
					<table style="width:100%">
						<tr>
							<td width="50%">总分值</td>
							<td width="50%">个人得分</td>
						</tr>
						<tr>
							<td><s:property value="content.totalScore"/></td>
							<td><s:property value="content.account"/></td>
						</tr>
					</table>
				</div> --%>
			</div>
			<div style='padding: 15px 0px 0px 15px; margin-bottom: 10px;border-bottom: 1px solid #f4f4f4;'>
				<div id="maiDiv" style="text-align:left"></div>
			</div>
		</div>
	<form action="download.action" method="post">
		<input type="hidden" id="_back_url_type" name="type" value="<s:property value='#parameters.type' />" />
	<input type="hidden" id="_back_url_status" name="status" value="<s:property value='#parameters.status' />" />
	    <input id="i1" type="hidden" name="content" value=""/>
	</form>
		<!-- todo -->
<script language="javascript">  
/* function printFile() 
{ 
var strResult=window.confirm("确认用Word打印吗?"); 
if(strResult)  
{ */
/* try 
{  */
/* content.focus(); 
document.execCommand("SelectAll"); 
document.execCommand("Copy"); 
content.focus(); 
var WordApp=new ActiveXObject("Word.Application"); */
/* dim wordapp as variant;
Set wordapp=createObject("Word.Application"); */
/* WordApp.Application.Visible=true; 
var Doc=WordApp.Documents.Add(); 
Doc.Activate(); 
Doc.Content.Paste(); 
Doc.PrintPreview(); 
WordApp.DisplayAlerts=false; 
Doc.Close(); 
WordApp.DisplayAlerts=true; 
WordApp.Quit(); */ 
/* } 
catch(e){}  */
/* } 
else 
{ 
var hwnd=window.open(""); 
hwnd.document.write(content.innerHTML); 
} 
return false; 
} */

/* function printFile2(){
	var oWD = new ActiveXObject("Word.Application");
	var oDC = oWD.Documents.Add("", 0, 1);
	var oRange = oDC.Range(0, 1);
	var sel = document.body.createTextRange();
	sel.moveToElementText(document.getElementById(Area));
	sel.select();
	sel.execCommand("Copy");
	oRange.Paste();
	oWD.Application.Visible = true;
} */
</script> 
<!-- todo end-->
</body>
</html>