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
<%@ page import="cn.myapps.km.baike.user.ejb.BUser" %>

<%@ page import="java.util.*" %>
<html>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<%
	BUser user = (BUser)session.getAttribute(BUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isPublicDiskAdmin = user.isPublicDiskAdmin();
	String userId=request.getParameter("userId");
	boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(user.getId());
%>

<link type="text/css" href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=basePath %>/km/baike/script/jquery-ui/themes/base/jquery.ui.all.css">
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.core.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.widget.js"  type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.mouse.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.draggable.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.position.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.resizable.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.button.js" type="text/javascript"></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero"></script>
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js"></script>
<!-- 弹出层插件--end -->
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

<script type="text/javascript"> 
	//必填校验
	function validateEmpty() {
		var $entryname = $("#entryName");
		if ($.trim($entryname.val()).length<=0) {
			$("#entryNametext").html('词条名称不能为空！');
			return false;
		} 
		
		return true;
	}
	
	//必填校验
	function validateEmptyCategory() {
		var $name = $("#category_name");
		if ($.trim($name.val()).length<=0) {
			$("#categoryNametext").html('词条类型不能为空！');
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
<div id="categoryDialog" >
</div>
	<script>
	function mydialog(){
		artDialog({
			title : "添加分类",
			height : 220,
			width : 550,
			background: '#000',			// 遮罩颜色
			opacity: 0.5,				// 遮罩透明度
			lock : true,
			content : $("#categoryDialog").html(),
			ok : function() {
	        	$.ajax({
	        		async:false,
	        		url:'<s:url value="/km/baike/category/doSave.action" />',
	        		data:'category.name='+$("#category_name").val(),
	        		type:"post",
	        		dataType:'html',
	        		success:function(data){
	        			artDialog.close();
	        			window.location=window.location;
	        		},
	        		error:function(data) {
	        			artDialog.close();
	        			window.location=window.location;
	        		}
	        	});
	        },
	        cancel : function() {
	        	artDialog.close();
			},
			okVal : '确定',
			cancelVal : '取消'
		});
	}
		
		function setDialogContent(divId){
			$("#"+divId).html("<div style='margin-left:60px;margin-top:14px;'> "+
			"类型名称：<input type='text' style='width:250px;height:23px;' id='category_name'>"); 

		}
		
		
		</script>
		
	<div id="wrap">
			<%@ include file="/km/baike/entry/baikeHead.jsp"%>
		<div id="page">
			<div class="edithistory">
					<!--灰色横条-->
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<!--灰色横条下面的线-->
				
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>

		  	<div style='margin-bottom:22px'></div>
					
		<div class="b1" style="background-color: #FBFBFB;width:100%;">
		<form   name="form_key" action='<s:url value="/km/baike/entry/doSaveAndAddPoint.action"/>' method="post">
		<div class="ml" style="text-align:left;">
		<table align="center">
			<tr>
				<td>
					<div style="white-space:nowrap; ">
						<label class="label-name" for="create">词条名称：</label>
				</td>
				<td>
					<input id="entryName" type="text" maxlength="256" size="59" style="width:400px; border: 1px solid #CFCFCF;  padding: 5px 1px;" name="entry.name"  />
						<font color="red">*
							<span id="entryNametext">
								<s:if test="hasFieldErrors()">
									<s:iterator value="fieldErrors">
										<s:property value="value[0]" />;<br/>
									</s:iterator>
								</s:if>
							</span>
						</font>
					</div>
				</td>
			</tr> 
			<tr>
				<td>
					<div style="margin: 20px 0 ;white-space:nowrap;"><label class="label-name" for="create" >词条类型：</label>
				</td>
				<td>
					<select id="entryCategory" name="entry.categoryId" style="width:200px; border: 1px solid #CFCFCF; padding: 5px 1px;">
				    	<s:iterator value="#request.categories" >
				 			<option value='<s:property value="id"/>'><s:property value="name"/></option>
				 		</s:iterator>
			 		</select>
		 			<%
						if(isPublicDiskAdmin){
					%>
					<a onclick="setDialogContent('categoryDialog');mydialog();" style="cursor:pointer;margin-left:15px;">添加词条分类</a>
					<%}else{ %>
					
					<%} %>
		 		</td>
		 		
		 	</tr>
		</table>
		
		<div class="converttips">
		<div id="demoarea"  style=" margin: 0 auto;margin-top:20px;">
		<p class="content">
		经验百科
		<a target="_blank" >规范的词条名</a>
		 应该是一条经验总结、一个方法汇总，应包含专有名词但不能只体现专有名词。
		</p>
		<p class="content">
		<span class="bg yes"></span>
		<img  src='<s:url value="/km/baike/content/images/right.png" />'>&nbsp;广东移动4G基站设计经验、蓄电池组后备时间快速计算方法、江苏地区PTN设计经验、4G基站带宽需求
		</p>
		<p class="content">
		<span class="bg no"></span>
		<img  src='<s:url value="/km/baike/content/images/wrong.png" />'>&nbsp;4G、蓄电池组、PTN、带宽
		</p>
		<p class="top-line">
		经验百科的宗旨是隐性知识转为显性知识，即工作经验，每个版块的涵盖范围是：<br>
（1）技术类：涵盖通信、信息化、建筑的咨询、设计、实施等方法目的是沉淀经验、提升技术水平；如“……计算方法”、“……咨询业务开展方法”“……设计心得”、“……设计步骤”、“……查勘方法”；<br>
（2）管理类：涵盖公司所有职能部门的流程指引、工作方法沉淀、管理经验推广，目的是增加大家流程的熟知度提高管理效率；经验主要涉及管理部门，生产部门也可以总结经验；如“知识文档管理板块使用技巧”；“学分的获取途径”、“学分的查询技巧”、“软课题申报流程与提高准确度方法”等。<br>
（3）市场类：涵盖市场开拓、客户关系维护、技术营销、市场投标，主要是商务类，技术内容不要在此体现；“某省份运营商办公大楼功能分布情况”、“某运营商客户拜访技巧”、“……类标书制作技巧”；<br>
（4）生活类：涵盖办事处管理日常经验、员工差旅经验、工作辅助、办公辅助类、计算机软件等；如“12306退票省钱方法”、“PPT播放投影与备注使用技巧”、“电脑资料分类方法”、“打印机设置方法”、“设计软件”。
		</p>
		</div>
				<div  id="nextStep" style=" margin: 0 auto;margin-top:20px;"><input id="createButton" class="bg btn" type="submit" onclick="return validateEmpty();" value="" >
		</div>
		</div>
			</form>
		</div>
	</div>
</div>
		<div class="bgpagLn" align="center" >
			<div id="footer" class="nslog-area"  align="center" data-nslog-type="1001" style="margin: 0 auto;margin-top:20px;margin-top: 115px;">
			2013 BaiKe
			<a target="_blank"  >版权所有@天翎网络</a>
			</div>
		</div>
	</body>
</html>