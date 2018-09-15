<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.baike.category.ejb.Category" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcess" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcessBean" %>

<%@ page import="java.util.*" %>
<html>

<link type="text/css" href="css/style.css" rel="stylesheet" />
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>

<head>
<title>创建词条 </title>
  <style>

.table-list .tr {
    border-bottom: 1px solid #ECECEC;
    line-height: 28px;
}
.table-head  {
    border-bottom: 1px solid #665666;
    line-height: 28px;
}
.table-head li {
    color: #333333;
    float: left;
    font-size: 14px;
    font-weight: bold;
}

.page {
    font-family: "????";
    font-size: 14px;
    line-height: 128px;
    text-align: center;
}


.label-name {
    display: inline-block;
    font-weight: bold;
   
}
#create {
    border: 1px solid #CFCFCF;
    padding: 5px 1px;
}
.converttips {
    font-size: 12px;
    line-height: 25px;
}

#demoarea {
    border: 1px solid #D2DAE7;
    line-height: 22px;
    padding: 9px 20px 1px;
    width: 483px;
}
#nextStep{
    line-height: 22px;
    padding: 9px 20px 1px;
    width: 483px;
}
.b1 form p {
    color: #999999;
}
.content {
    margin: 5px 0;
}
.top-line {
    border-top: 1px dashed #EFEFEF;
    line-height: 20px;
    padding: 14px 0;
}

.btn {
    border: 0 none;
    height: 30px;
    width: 90px;
}

.yes {
    height: 8px;
    width: 11px;
}
.yes, .no {
    display: inline-block;
    margin-right: 8px;
    overflow: hidden;
}

.no {
    height: 9px;
    width: 9px;
}

a {
    color: #2D64B3;
    text-decoration: none;
}

#createButton {
	background-image: url('<s:url value="/km/baike/content/images/next.jpg" />');
}



</style>

<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>
<script type="text/javascript"> 


	//必填校验
	function validateEmpty() {
		var $entryname = $("#entryName");
		if ($.trim($entryname.val()).length<=0) {
			$("#entryNametext").html('词条名称不能为空！');
			return false;
		} 
		if ($.trim($("#entryKeyWord").val()).length<=0) {
			$("#entryKeyWordtext").html('词条标签不能为空！');
			return false;
		}
		return true;
	}

//执行查询
function findByName(){
		//根据词条名称查找
		entryProcess.doFindByName(entryName,checkUnique);
}

//带回数据
function checkUnique(content){
	if(content!=null){
		document.getElementById("entryNametext").innerHTML="注意：已经存在此词条！";
	}
}

</script> 

</head>

<% 
	CategoryProcess process = new CategoryProcessBean();
	Collection<Category> categories =process.doQuery();
	request.setAttribute("categories", categories);
%>

<body id="baike" style="margin:0;padding:0;text-align:center">

	<div id="wrap">
			<%@ include file="/km/baike/entry/baikeHead.jsp"%>
		
		<div id="page">
			<div class="edithistory">
					<!--灰色横条-->
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<!--灰色横条下面的线-->
				
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>

		  	<div style='margin-bottom:22px'>
			</div>
					
		<div class="b1" style="background-color: #FBFBFB;width:100%;">
		<form   name="form_key" action='<s:url value="/km/baike/entry/doSaveAndAddPoint.action"/>' method="post">
		<div class="ml" style="text-align:left;">
	
		<p class="top-line">
		经验百科的积分规则是：<br>
（1）创建词条：用户创建一个全新的词条，并能通过管理员的审核，该用户积分可加5分;<br>
（2）编辑词条：用户编辑现有词条，并能通过管理员的审核，该用户积分可加1分;<br>
（3）好评词条：词条被其他用户好评时，创建该词条的作者及编辑者都可增加积分1分;<br>
（4）悬赏积分：悬赏的积分不来自于悬赏人的总积分，最高悬赏分为5分;<br>
（5）知识悬赏：用户可完成提问者提出的问题，得到提问者采纳后，根据提问者的悬赏积分获得相应积分;

		</p>
		</div>
			
			
	</div>
		</div>
		</form>
		
		</div>
		
		</div>
	</div>
		<div class="bgpagLn" align="center" >
		
		
		<div id="footer" class="nslog-area"  align="center" data-nslog-type="1001" style="margin: 0 auto;margin-top:20px;margin-top: 155px;">
		2013 BaiKe
		<a target="_blank"  >版权所有@天翎网络</a>
		</div>
</div>
</body>
</html>