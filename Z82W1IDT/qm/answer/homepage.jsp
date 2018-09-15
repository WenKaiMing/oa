<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/theme.css"/>

<style>
#title {
	width: 320px;
	margin: 10px;
	min-height: 70px;
	margin-bottom: 10px;
	cursor: pointer;
	border: 1px dashed #cccccc;
	border-radius: 5px;
}

#title:hover {
	width: 320px;
	margin: 10px;
	min-height: 70px;
	margin-bottom: 10px;
	background-color: #FAFAFA;
	border-radius: 5px;
	color: #151515;
	border: 1px dashed #8ad748;
}
</style>
<title>首页</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if($(".grid > div").length <= 0){
			$(".createNew").css("display","block");
		}
		
		$(".grid > div").click(function() {
			var q_id = $(this).attr("q_id");
			window.location.href = "new.action?id="+q_id;
		});
		$(".newPaper").click(function(){
			window.location.href = "../questionnaire/new.action";
		});
		
		$(".explains").each(function (){
			
			if($(this).text().length>70){
				$(this).text($(this).text().substring(0,70)+"...");
			}
			
		});
		
	});
</script>
</head>
<body style="overflow: auto;">
	<s:form id="formList" name="formList" action="save.action"
		method="post" theme="simple">
		<div style="min-height: 100%;background:#fff;padding-top: 1px;">
		
		<%
		WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		%>
		<s:if test="datas.datas.size()<=0">
		<%		
				if(user != null && user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
		%>
		<div class="createNew">
					<span style="margin-left: 40%;position: absolute;top: 300px;">你还没有问卷，马上开始创建第一份问卷</span><br/>
		<%
		        out.println("<span style=\"margin-left: 70px;\"><a class=\"newPaper btn btn-primary_green\"  href=\"javascript:void(0)\" style='margin-left: 43%;position: absolute;top: 330;'>创建问卷</a></span></div>");
				}else{
		%>
					<span style="margin-left: 50%;position: absolute;top: 300px;">当前没有问卷</span><br/>
		<%
		        out.println("<span></span></div>");
				}
		%>
		
		</s:if>

		
		<div class="grid">
			<s:iterator value="datas.datas" status="index" id="questionnaire">
			<div id='title' q_id='<s:property value="id" />'>
				<div class="title"><s:property value="title" /></div>
				<div class="explains"><s:property value="explains" /></div>
				<div class="publisher">发布者:<s:property value="creatorName" /></div>
				<div class="publishDate">发布时间:<s:date name="publishDate" format="yyyy-MM-dd" /></div>
			</div>
			</s:iterator>
		</div>
	</s:form>
</body>
</html>