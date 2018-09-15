<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<html>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<title>a_历史版本_经验百科 </title>
    <style>


.title span {
font-size: 18px;
    color: #333333;
	 line-height: 50px;
    padding: 25px 0 0 8px;
}
.table-head .time {
    width: 19.5%;
}


.table-head .version {
    width: 16%;
}

.table-head .contributor {
    width: 20%;
}
.table-head .reason {
    width: 35.5%;
}
.table-list .tr {
    border-bottom: 1px solid #ECECEC;
    line-height: 28px;
}
.table-head  {
    border-bottom: 1px solid #665666;
    line-height: 28px;
}
.table-list .tr .time {
    color: #666666;
    width: 19.5%;
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
}
.table-list .tr .version {
    font-size: 14px;
    width: 16%;
}
.table-list .tr .contributor {
    font-size: 14px;
    overflow: hidden;
    width: 20%;
}
.table-list .tr .reason {
    color: #333333;
    font-size: 14px;
    width: 35.5%;
    word-break: break-all;
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


	</style>

</head>

<body id="baike" >

	<div id="wrap">
		<%@ include file="/km/baike/entry/baikeHead.jsp"%>
		
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
					<ul class="table-head clearfix">
						<li class="version-compare"> </li>
						<li class="time">贡献者</li>
						<li class="version">版本号</li>
						<li class="contributor">更新时间</li>
						<li class="reason">修改原因</li>
					</ul>
			
					<s:iterator value="datas.datas" id="status"> 
						<div class="table-list">				
		   						<ul class="tr clearfix">
		   							<li class="contributor"><s:property value="author.name"/></li>
		   							<li class="version"><s:property value="versionNum"/></li>
		   							<li class="time"><s:property value="saveTime"/></li>
		   							<li class="reason"><s:property value="reason"/></li>
		  						</ul>
		  					</div>
		  			</s:iterator>	
			</div>
	</div>

<div class="bgpagLn" align="center">
			<div class="bgpagLn" align="center">
				<div class="page">
				
							   <a href="<s:url action='findHisContent'> 
										<s:param name="page" value="1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="entryId"  ><s:property value="entryId" /></s:param>
										</s:url>" >首页</a> 
								<a href="<s:if test="datas.pageNo>1">
										<s:url action='findHisContent'> 
										<s:param name="page" value="datas.pageNo-1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="entryId" ><s:property value="entryId" /></s:param>
										</s:url></s:if><s:else>#</s:else>" >上一页</a> 
								<a href="<s:if test="datas.pageNo<datas.getPageCount()">
										<s:url action='findHisContent'> 
										<s:param name="page" value="datas.pageNo+1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="entryId" ><s:property value="entryId" /></s:param>
										</s:url></s:if><s:else>#</s:else>" >下一页</a> 
								<a href="<s:url action='findHisContent'> 
										<s:param name="page" value="datas.getPageCount()" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="entryId" ><s:property value="entryId" /></s:param>
										</s:url>" >尾页</a> 
				页次：<s:property value="datas.pageNo" />/<s:property value="datas.getPageCount()" />页 共<s:property value="datas.rowCount" />条记录 <s:property value="datas.linesPerPage" />条记录/页</div>
				</div>
			</div>
		</div>
			<div id="footer" class="nslog-area" style="text-align:center;margin-top:115px;">
							
			© 2013 BaiKe版权所有@天翎网络
			</div>
		</div>
	</body>
</html>