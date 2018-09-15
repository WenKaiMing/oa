<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<title> </title>
    <style>


.title span {
font-size: 18px;
    color: #333333;
	 line-height: 50px;
    padding: 25px 0 0 8px;
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


	</style>

</head>

<script type="text/javascript">


/*搜索词条*/
function searchEntry(){
	var queryString = document.getElementsByName("word")[0].value;
	if(queryString ==""){
		alert("请填写搜索内容!");
		return;
	}
	document.forms[0].action = "<s:url value='/km/baike/entry/findEntry.action'><s:param name='queryString' value='word' /></s:url>";
	document.forms[0].submit();
}

/*进入词条*/
function enterEntry(){
	var queryString = document.getElementsByName("word")[0].value;
	if(queryString == ""){
		alert("请填写搜索内容!");
		return;
	}
	/*<s:url value='/km/disk/file/query.action'><s:param name='_type' value='_type' /></s:url>*/
	document.forms[0].action = "<s:url value='/km/baike/entry/findEntryByName.action'><s:param name='queryString' value='word' /></s:url>";
	document.forms[0].submit();
}

function createEntry(){
	location.href='<s:url value="/km/baike/content/addEntry.jsp" />';
}

</script>
<body id="baike" >

		<div id="userbar" >
					<a class="nslog:87" href='<s:url value="/km/baike/center/index.jsp" />?userId='>我的百科</a>&nbsp;|&nbsp;
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
		
</body>
</html>