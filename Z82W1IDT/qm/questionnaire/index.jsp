<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/list.css" rel="stylesheet" type="text/css">
<title>首页</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/common.js"></script>	
<script type="text/javascript" src="../js/qm.index.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		/* if($(".grid > div").length <= 0){
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
			
		}); */
		QM.init();
	});
</script>
</head>
<body style="overflow: auto;">
	<s:form id="formList" name="formList" action="save.action"
		method="post" theme="simple">
		
		<input type='hidden' name="type" value="<s:property value='#parameters.type' />" />
		<input type='hidden' name="status" value="<s:property value='#parameters.status' />" />
		<input type='hidden' name="_currpage" value="<s:property value='#parameters._currpage' />" />
		<input type='hidden' name="_pagelines" value="<s:property value='#parameters._pagelines' />" />
		<input type='hidden' name="_rowcount" value='' />
		
		<div style="min-height: 100%;margin-right: 15px;margin-left: 15px;border-left: 1px solid #dcdcdc;border-right: 1px solid #dcdcdc;background:#fff;">
		
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
			<div id='title-top'>
				<div class="do_new">新建</div>
			</div>
			
		</div>
	</s:form>
</body>
</html>