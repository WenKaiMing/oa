<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<html>
<link type="text/css" href="css/styleitem.css" rel="stylesheet" />
<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<meta content="IE=7" http-equiv="X-UA-Compatible"/>
<title>草稿箱</title>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 14px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a{text-decoration: none;color: #000;cursor:pointer;}
a:hover, a:link, a:visited {
    color: #136EC2;
}

#tabbox{ width:100%; overflow:hidden; margin:0 auto;}
.tab_conbox{border: 1px solid #999;border-top: none;}
.tab_con{ display:none;}

.tabs{height: 32px;border-bottom:1px solid #999;width: 100%;}
.tabs li{height:31px;line-height:31px;float:left;border:1px solid #999;border-left:none;margin-bottom: -1px;background: #e0e0e0;overflow: hidden;position: relative;}
.tabs li a {display: block;padding: 0 20px;border: 1px solid #fff;outline: none;}
.tabs li a:hover {background: #ccc;}	
.tabs .thistab,.tabs .thistab a:hover{background: #fff;border-bottom: 1px solid #fff;}

.tab_con {padding:12px;font-size: 14px; line-height:175%;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	jQuery.jqtab = function(tabtit,tab_conbox,shijian) {
		$(tabtit).find("li:last").addClass("thistab").show();
	};
	/*调用方法如下：*/
	$.jqtab("#tabs","#tab_conbox","click");
	
	$.jqtab("#tabs2","#tab_conbox2","mouseenter");
	
});
</script>


<style>
	th{border-bottom:1px #000000 solid;}
	
	td{
		font-size:12px;
		border-bottom: 1px dotted #AEC9EA; 
		margin-top: 3px;
		word-break: break-all;
		text-overflow:ellipsis;
		white-space:nowrap; 
		overflow:hidden;
	}
	tr 
	{
		height:35px;
	}
</style>
<script type="text/javascript">
function selectAll() {
	var choose = document.getElementById("getall").checked;
	var all = document.getElementsByName("alls");
	if(choose==true){
		for(var x=0;x<document.getElementsByName("alls").length;x++){
			 all[x].checked=true;
		 }
	  }
	else{
		for(var x=0;x<document.getElementsByName("alls").length;x++){
			 all[x].checked=false;
		 }
	}
}
function notSelectAll() {
	//var choose = document.getElementById("notGetAll").checked;
	var all = document.getElementsByName("alls");
	for(var x=0;x<document.getElementsByName("alls").length;x++){
		if(all[x].checked==true){	
			all[x].checked=false;
		}else{
			all[x].checked=true;
		}
	}
}

//批量删除草稿
function deleteMany(){
	if(confirm("确定要删除吗？")){
		form1.submit();
	}
}

</script>
</head>
<body>

<div id="mydrafts" style="float:right; width:100%;height:800px; " class="selectd">
	<div id="tabbox" style="background:#D8D8D8 ;width:100%;">
			<ul class="tabs" id="tabs">
				<li style="width:10px;border-top:0px; border-left:0px;border-bottom:0px;"></li>
				<li><a style="font-size:14px;">草稿箱</a></li>
			</ul>
		</div>
	<form name="form1" action="<s:url value="/km/baike/center/deleteMany.action" />" method="post">
		<table width="100%" cellSpacing="0"  cellPadding="0">
			<tr>
				<th style="padding-left:10px;padding-right:2px;" width="5xp;"><input type="checkbox"  id="getall"  onclick="selectAll();"/></th>
				<!-- <th width="80xp;">全选<a onclick="notSelectAll();" style="cursor: pointer;">反选</a></th> -->
				<th  width="25%"align="left" style="font-size:14px;">词条名称</th>
				<th  width="25%" style="font-size:14px;">保存时间</th>
				<th  width="50%" style="font-size:14px;">操作</th>
			</tr>
			<s:iterator value="datas.datas">
			<div margin-top: 3px;">
				<tr align="center" height="10px">
					<td style="padding-left:10px;padding-right:2px;"><input type="checkbox" name="alls" value="<s:property value="entry.id"/>"/></td>
					<td align="left"><a title='<s:property value="entry.name"/>' onclick='javascript:parent.location.href="<s:url value="/km/baike/entry/doPreview.action" />?entryId=<s:property value="id"/>&contentId=<s:property value="entryContent.id" />";'><s:property value="name"/></a></td>
					<td><s:date name="created" format="yyyy-MM-dd" /></td>
					<td><a onclick='javascript:parent.location.href="<s:url value="/km/baike/content/findContent.action" />?contentId=<s:property value="entryContent.id"/>";'><image src='<s:url value="image/ContinueEdit.gif" />'/>继续编辑</a>
						<a href='<s:url value="/km/baike/center/doRemoveDraft.action" />?contentId=<s:property value="entryContent.id"/>'><image src='<s:url value="image/delete.gif" />'/>删除</a>
						<a href='<s:url value="/km/baike/center/doSubmit.action" />?contentId=<s:property value="entryContent.id"/>'><image src='<s:url value="image/submit.gif"  />'/>提交</a>
						<a onclick='javascript:parent.location.href="<s:url value="/km/baike/reason/queryAllReason.action" />?contentId=<s:property value="entryContent.id"/>";'><image src='<s:url value="image/search.png" />'/>查看</a>
					</td>
				</tr>
			</div>
			</s:iterator>
			
		</table>
		<div align="right" ; style="margin-top:5px; font-size:12px;">
		
			<a onclick="deleteMany();">批量删除</a>
			
			<a href="<s:url action='doGetMyDraft'> 
					<s:param name="page" value="1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="entry.author">fasdf</s:param>
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url>" >首页</a>
			<a href="<s:if test="datas.pageNo>1">
					<s:url action='doGetMyDraft'>
					<s:param name="page" value="datas.pageNo-1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="entry.author" >fasdf</s:param>
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					
					</s:url></s:if><s:else>#</s:else>" >上一页</a> 
			<a href="<s:if test="datas.pageNo<datas.getPageCount()">
					<s:url action='doGetMyDraft'>
					<s:param name="page" value="datas.pageNo+1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="entry.author" >fasdf</s:param>
					
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url></s:if><s:else>#</s:else>" >下一页</a>
			<a href="<s:url action='doGetMyDraft'>
					<s:param name="page" value="datas.getPageCount()" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="entry.author" >fasdf</s:param>
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url>" >尾页</a>
页次：<s:property value="datas.pageNo" />/<s:property value="datas.getPageCount()" />
页 共<s:property value="datas.rowCount" />条记录 <s:property value="datas.linesPerPage" />条记录/页
					</div>
		</form> 
		
	</div>
</body>
</html>