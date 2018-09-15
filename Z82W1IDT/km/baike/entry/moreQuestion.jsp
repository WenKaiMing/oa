<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%@ page import="cn.myapps.km.baike.user.ejb.BUser" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswer" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswerProcessBean" %>
<%
	BUser user = (BUser)session.getAttribute(BUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isPublicDiskAdmin = user.isPublicDiskAdmin();
	String userId=request.getParameter("userId");
	boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(user.getId());
%>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<title>所有问题</title>
    <style>

#wrap {
    margin: 0 auto;
    width: 90%;
}
#logo, #search-content, #help {
    float: left;
}
#logo {
    margin-top: 0px;
    position: relative;
    width: 152px;
}
#logo img {
    display: block;

}
#page, #header, #content, #footer {
    margin-left: auto;
    margin-right: auto;
}
#view, #wrap {
    margin-top: 1px;
}
#header {
    margin-top: 6px;
}
fieldset, img {
    border: 0 none;
}
div, input {
    font-family: Arial;
}

.edithistory {
    min-width: 1000px;
}
#search {
    margin-bottom: 25px;
    position: relative;
    width: 900px;
    z-index: 2;
}
#search .s_btn {
    background: url("1.png") repeat scroll 0 0 #DDDDDD;
    border: 0 none;
    cursor: pointer;
    font-size: 14px;
    height: 32px;
    padding: 0;
    width: 95px;
}

.clearfix:after {
    clear: both;
    content: " ";
    display: block;
    height: 0;
    visibility: hidden;
}
.clearfix:after {
    clear: both;
    content: " ";
    display: block;
    height: 0;
}
.tab {

    font-family: "????";
    position: relative;
}

.tab li {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-color: #FFFFFF #FFFFFF -moz-use-text-color;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 1px 0;
    color: #136EC2;
    font-size: 14px;
    line-height: 20px;
}
ul, li {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

body, button, input, select, textarea {
    font: 13px/1.5 arial,����,sans-serif;
}

div, input {
    font-family: Arial;
}
#search .s_ipt {
    background: none repeat scroll 0 0 #FFFFFF;
    border: 0 none;
    font: 16px/22px arial;
    height: 22px;
    margin: 5px 0 0 7px;
    outline: 0 none;
    padding: 0;
    width: 398px;
}

#search .s_ipt_wr {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: url("1.png") no-repeat scroll -304px 0 rgba(0, 0, 0, 0);
    border-color: #7B7B7B #B6B6B6 #B6B6B6 #7B7B7B;
    border-image: none;
    border-style: solid;
    border-width: 1px;
    display: inline-block;
    height: 30px;
    margin-right: 5px;
    vertical-align: top;
    width: 408px;
}
#userbar {

    color: #000000;
    font: 12px/18px Arial;
    right:70px;
    text-align: right;
    top: 3px;
}
#footer, #footer a:link, #footer a:visited {
    clear: both;
    color: #000000;
    font: 12px/1 Arial;
    margin-bottom: 15px;
    margin-top: 60px;
    text-align: center;
    white-space: nowrap;
}

#search .s_btn {
    background: url("http://img.baidu.com/img/baike/logo/bg_search.png") repeat scroll 0 0 #DDDDDD;
    border: 0 none;
    cursor: pointer;
    font-size: 14px;
    height: 32px;
    padding: 0;
    width: 95px;
}
.title span {
font-size: 18px;
    color: #333333;
	 line-height: 50px;
    padding: 25px 0 0 8px;
}
.table-head .time {
    width: 34%;
      text-align:center;
}



.table-list .tr {
    border-bottom: 1px solid #ECECEC;
    line-height: 28px;
}
.table-head  {
    border-bottom: 1px solid #665666;
    line-height: 28px;
}

.table-list .tr li {
    float: left;
    line-height: 28px;
}

.table-list .tr .version a {
    vertical-align: middle;
}
.table-list .tr a {
    text-decoration: none;
}
a:hover, a:link, a:visited {
    color: #136EC2;
    text-decoration: none;
}

.table-head li {
    color: #333333;
    float: left;
    font-size: 14px;
    font-weight: bold;
}
.back {
    float: right;
    line-height: 28px;
}

.page {
    font-size: 14px;
    line-height: 128px;
    text-align: center;
}
td {
    border-bottom: 1px dotted #AEC9EA;
    font-size: 14px;
    margin-top: 3px;
}

	</style>

</head>

<script type="text/javascript">
/*搜索词条*/
function searchQuestion(){
	var searchString = $("#searchString").val();
	if($.trim(searchString).length==0){
		alert("请填写搜索内容!");
		return;
	}
	document.forms[0].action = "<s:url value='/km/baike/knowledge/doQuery.action' />";
	
	document.forms[0].submit();
}



</script>
<body id="baike" >

	<div id="wrap">
		<div id="userbar" >
					<a class="nslog:87" href='<s:url value="/km/baike/center/index.jsp" />?userId='>我的百科</a>&nbsp;|&nbsp;
					<a class="nslog:87" href='<s:url value="/km/baike/entry/doInit.action" />'>百科首页</a>
		</div>
		<div id="header">
			<form action='<s:url value="/km/baike/entry/doAccess.action" />' method="post">
				<div id="search" class="clearfix">
					<div id="logo">
						<img class="nslog:1008" width="287" height="40" border="0" alt="到百科首页" src='<s:url value="/km/baike/entry/images/logo.png" />'>
					</div>
					<div id="search-content">
						<span class="s_ipt_wr">
								<span><input id="searchString" class="s_ipt"  maxlength="100" name="searchString" tabindex="1"  value='<s:property value="searchString" />'></span>
						</span>
						<span class="s_btn_wr" style="margin-right:6px">
							<span>
							<input class="s_btn" type="button" tabindex="2" value="搜索问题" onclick=searchQuestion();>
							</span>
						</span>
					</div>
				</div> 
				</form>
		</div>
		
		<div id="page">
			<div class="edithistory">
				<div id="navbar-collection" class="navbar" style="">
					<div class="line"></div>
				</div>
				<form action="/diff/" method="get" name="diff" target="_blank">
					<input type="hidden" name="vid1" value="">
					<input type="hidden" name="vid2" value="">
				</form>
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888">
					
				</div>
					<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;">
					</div>
			<div>
				<div class="title clearfix">
					
				</div>
				<table style="width:100%;">
					<tr class="table-head clearfix">
						<th class="version" width="28%" style="white-space:nowrap;padding-left:10px;font-size: 14px;font-weight: bold; text-align:left;">问题标题</th>
						<th class="contributor" width="23%" style="text-align:center;font-size: 14px;font-weight: bold;">提问者</th>
						<th class="time" width="29%" style="text-align:center;font-size: 14px;font-weight: bold;">提出日期</th>
						<%
						if(isPublicDiskAdmin){
					%>
						<th class="handle" width="15%" style="text-align:center;font-size: 14px;font-weight: bold;">操作</th>
						<%}else{ %>
					
					<%} %>
					</tr>
					
						<s:iterator value="question.datas" status="anyStatus">
							<div class="table-list">				
			   						<tr class="tr clearfix">
			   							<td class="version" width="28%" style="padding-left: 10px;"><a href='<s:url value="/km/baike/knowledge/doView.action"/>?questionId=<s:property value="id" />'><s:property value="title"/></a></td>
			   							<td class="contributor" width="23%" style="text-align:center;"><s:property value="author.name"/></td>
			   							<td class="time" width="29%" style="text-align:center;"><s:date name="created" format="yyyy-MM-dd" /></td>
			   								<%
									if(isPublicDiskAdmin){
								%>
								<td class="handle" width="15%" style="text-align:center;"><a href='<s:url value="/km/baike/knowledge/doRemove.action"/>?questionId=<s:property value="id" />'>删除</a></li>
			  						<%}else{ %>
								
								<%} %>
			  						</td>
			  					</div>
			  			</s:iterator>	
			</table>
		</div>
		
	</div>

<div class="bgpagLn" align="center">
			<div class="bgpagLn" align="center">
				<div class="page">
				
					<a href="<s:url action='doFindRecentEntry'> 
					<s:param name="page" value="1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url>" >首页</a>
			<a href="<s:if test="datas.pageNo>1">
					<s:url action='doFindRecentEntry'>
					<s:param name="page" value="datas.pageNo-1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					
					</s:url></s:if><s:else>#</s:else>" >上一页</a> 
			<a href="<s:if test="datas.pageNo<datas.getPageCount()">
					<s:url action='doFindRecentEntry'>
					<s:param name="page" value="datas.pageNo+1" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url></s:if><s:else>#</s:else>" >下一页</a>
			<a href="<s:url action='doFindRecentEntry'>
					<s:param name="page" value="datas.getPageCount()" />
					<s:param name="lines" value="datas.linesPerPage" />
					<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
					</s:url>" >尾页</a>
页次：<s:property value="question.pageNo" />/<s:property value="question.getPageCount()" />
页 共<s:property value="question.rowCount" />条记录 <s:property value="question.linesPerPage" />条记录/页
					</div>
			</div>
			</div>
		</div>
		<div id="footer" class="nslog-area" style="text-align:center;margin-top:115px;">
		© 2013 BaiKe版权所有@天翎网络
			</div>
		</div>
	</body>
</html>