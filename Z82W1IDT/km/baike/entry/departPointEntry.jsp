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


.table-head .version {
    width: 25%;
    margin-left:15px;
}

.table-head .contributor {
    width: 65%;
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
.table-list .tr .version {
    font-size: 14px;
    width: 25%;
    margin-left:15px;
}
.table-list .tr .contributor {
    font-size: 14px;
    overflow: hidden;
    width: 65%;
    text-align:center;
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
		<div id="userbar" >
					<a class="nslog:87" href='<s:url value="/km/baike/center/index.jsp" />'>我的百科</a>&nbsp;|&nbsp;
					<a class="nslog:87" href='<s:url value="/km/baike/entry/doInit.action" />'>百科首页</a>
		</div>
		<div id="header">
			<form action='<s:url value="/km/baike/entry/doAccess.action" />' method="post">
				<div id="search" class="clearfix">
					<div id="logo">
					<a href="/"><img class="nslog:1008" width="287" height="40" border="0" alt="到百科首页" src='<s:url value="/km/baike/entry/images/logo.png" />'></a>
					</div>
					<div id="search-content">
						<span class="s_ipt_wr">
								<span><input id="word" class="s_ipt"  maxlength="100" name="searchString" tabindex="1"  value='<s:property value="searchString" />'></span>
						</span>
						<span class="s_btn_wr" style="margin-right:6px">
							<span>
								<input class="s_btn" type="button" tabindex="2" value="搜索词条" onclick=searchEntry();>
							</span>
						</span>
						<span class="s_btn_wr">
							<span>
							<input class="s_btn" type="button"tabindex="3" value="创建词条" onclick=createEntry();>
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
					<ul class="table-head clearfix">
						<li class="version">部门</li>
						<li class="contributor">积分</li>
						
					</ul>
					 <s:iterator value="topDepartmentPoint.datas" id="depScore" status="anyStatus">
						<div class="table-list">				
		   						<ul class="tr clearfix">
		   							<li class="version" style=" white-space: nowrap;text-overflow: ellipsis;overflow: hidden;" ><s:property value="#depScore.get('NAME')" /></li>
		   							<li class="contributor"><s:property value="#depScore.get(\"TOTALINTEGRAL\")" /></li>
		   				
		  						</ul>
		  					</div>
		  			</s:iterator>	
		</div>
	</div>

<div class="bgpagLn" align="center">
			<div class="bgpagLn" align="center">
				<div class="page">
				
							   <a href="<s:url action='doFindDepartmentPoint'> 
										<s:param name="page" value="1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="selectedMenu"  ><s:property value="selectedMenu" /></s:param>
										</s:url>" >首页</a> 
								<a href="<s:if test="datas.pageNo>1">
										<s:url action='doFindDepartmentPoint'> 
										<s:param name="page" value="datas.pageNo-1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
										</s:url></s:if><s:else>#</s:else>" >上一页</a> 
								<a href="<s:if test="datas.pageNo<datas.getPageCount()">
										<s:url action='doFindDepartmentPoint'> 
										<s:param name="page" value="datas.pageNo+1" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
										</s:url></s:if><s:else>#</s:else>" >下一页</a> 
								<a href="<s:url action='doFindDepartmentPoint'> 
										<s:param name="page" value="datas.getPageCount()" />
										<s:param name="lines" value="datas.linesPerPage" />
										<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
												</s:url>" >尾页</a> 
					页次：<s:property value="topDepartmentPoint.pageNo" />/<s:property value="topDepartmentPoint.getPageCount()" />页 共<s:property value="topDepartmentPoint.rowCount" />条记录 <s:property value="topDepartmentPoint.linesPerPage" />条记录/页</div>
					</div>
			</div>
		</div>
		<div id="footer" class="nslog-area" style="text-align:center;margin-top:115px;">
		© 2013 BaiKe版权所有@天翎网络
			</div>
		</div>
	</body>
</html>