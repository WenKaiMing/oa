<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>答卷列表</title>
<link href="../css/theme.css" rel="stylesheet" type="text/css">
<link href="../css/table.css" rel="stylesheet" type="text/css">
<link href="../css/contentstyle.css" rel="stylesheet" type="text/css">

<style>
a {
	text-decoration: none;
}
.pagenav { /*color: #7EB8C6;*/
	color: #666666;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	background-color: #FFFFFF;
	background-image: none;
}

.pagenav a{
	color: #2A5685;
}
.pagenav a:hover {
	color: #c61a1a;
	text-decoration: underline;
}
</style>
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	
	$(function(){
		$("#button").click(function(){
			var page=$("#cptext").val();
   		    if(!isNaN(page)){
   			 window.location.href = "list.action?_currpage="+page;
   			}else{
   		     window.location.href = "list.action?_currpage=1";
   			}
   	    }
   	    );
	});
	
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
	
	//设置cookie值
	function setCookie(name,value){
	    var exp  = new Date();  
	    exp.setTime(exp.getTime() + 30*24*60*60*1000);
	    jQuery("input[name='_pagelines']").val(value);
	}
</script>
</head>
<body style="overflow: auto;">
<s:form id="formList" name="formList" action="list.action" method="post" theme="simple" style="margin-left: 15px;">
	<div style="background: #f5f5f5; height:65px;margin-right: 15px;border-left: 1px solid #dcdcdc;border-right: 1px solid #dcdcdc;">
		<div style="height: 65px; line-height: 65px; float: right; margin-right: 11%; color: white;">
			<s:textfield style=" height: 30px; line-height: 10px; border: none; text-indent: 8px; " name="s_title"></s:textfield>
			<a href="javascript:document.forms[0].submit()"  class="btn btn-primary_green q_new" style="margin-top: -0px; border: none; height: 30px; line-height: 30px; margin-left: -10px;}" >查询</a>
		</div>
		<input type='hidden' name="_currpage" value='<s:property value="datas.pageNo"/>' />
		<input type='hidden' name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
		<input type='hidden' name="_rowcount" value='<s:property value="datas.rowCount"/>' />
	</div>
	<div style="margin-right:15px;min-height: 100%;background-color: #fff;border-left: 1px solid #dcdcdc;border-right: 1px solid #dcdcdc;">
		<table class='gridtable' width="100%">
			<thead>
				<tr>
					<td>标题</td>
					<td>提交时间</td>
					<td>得分</td>
					<td>查看</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="datas.datas" status="index" id="answer">
					<tr  class="Query_Form_table">
					<td>
						<a  class="Query_Form_table_text" href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="title" />
						</a>
					</td>
					<td>
						<a class="Query_Form_table_text" href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:date name="date" format="yyyy-MM-dd" />
						</a>
					</td>
					<td>
						<a class="Query_Form_table_text" href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="account" />
						</a>
					</td>
					<td class="Query_Form_table_text"><a class="Button_Edit_Blue" href="javascript: document.forms[0].action='<s:url action="view">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">查看</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<!-- 分页 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
					css="linktag" /></td>
			</tr>
		</table>
		<input type='button' value='确定' id='button' style="float: right;">
			<input type='text' name='cp' id='cptext' value='' style="width: 40px;float: right;"/>
			<span style="float: right;font-size: 10px">页数 :&nbsp;</span>
	</div>
	</s:form>
</body></o:MultiLanguage>
</html>