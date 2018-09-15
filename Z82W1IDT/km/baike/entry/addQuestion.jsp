
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.content.ejb.ReferenceMaterial" %>
<%@ page import="cn.myapps.km.baike.content.ejb.EntryContent" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.baike.category.ejb.Category" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcess" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcessBean" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcessBean" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcess" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestion" %>
<%@ page import="java.util.*" %>

<% 
	CategoryProcess process = new CategoryProcessBean();
	Collection<Category> categories =process.doQuery();
	request.setAttribute("categories", categories);
	/* 
	KnowledgeQuestion kq = new KnowledgeQuestion();
	boolean isAccept = kq.state =="ACCEPT"; */
%>
<html>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" href='<s:url value="/km/baike/component/kindeditor/themes/default/default.css" />' />
<link rel="stylesheet" href='<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.css" />' />
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/jquery.js" />' ></script>
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/kindeditor.js" />' ></script>
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/lang/zh_CN.js" />'></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<script>
	var editor = "";
	KindEditor.ready(function(K) {
			editor = K.create('textarea[name="knowledgeQuestion.content"]', {
			cssPath : '<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.css" />',
			uploadJson : '<s:url value="/km/baike/component/kindeditor/jsp/upload_json.jsp" />',
			fileManagerJson : '<s:url value="/km/baike/component/kindeditor/jsp/file_manager_json.jsp" />',
			allowFileManager : true,
			afterCreate : function() {
				this.sync();
			}
		});
	});
</script>

<head>
<title>知识悬赏 </title>
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
    margin-left: 62px;
}
#demoarea {
    border: 1px solid #D2DAE7;
    line-height: 22px;
    margin: 0 0 27px;
    width: 440px;
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
#submmit {
	background-image: url('<s:url value="/km/baike/entry/images/subQuestion.jpg" />');
}
#save {
	background-image: url('<s:url value="/km/baike/content/images/save.jpg" />');
}
	</style>
</head>

<script type="text/javascript">

	function doSave() {
		editor.sync();
		document.getElementsByName("content_handle")[0].action = '<s:url value="/km/baike/knowledge/doSave.action" />';
		document.getElementsByName("content_handle")[0].submit();
	}
	
	//必填校验
	function validateEmpty() {
		var $demoarea = $("#demoarea");
		if ($.trim($demoarea.val()).length<=0) {
			$("#demoareatext").html('问题标题不能为空！');
			return false;
		} 
		
		return true;
	}

</script>

<body id="baike" style="margin:0;padding:0;text-align:center">

	<div id="wrap">
			<%@ include file="/km/baike/entry/baikeHead.jsp"%>
		
		<div id="page"  >
			<div class="edithistory">
				<div id="navbar-collection" class="navbar" style=""><div class="line"></div></div>
				<form action="/diff/" method="get" name="diff" target="_blank">
					<input type="hidden" name="vid1" value="">
					<input type="hidden" name="vid2" value="">
				</form>
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>

		  	<div style='margin-top:22px'></div>
		</div>
		
				
	<div class="b1" style="background-color: #FBFBFB;">
		<form name="content_handle" action='<s:url value="/km/baike/knowledge/doSave.action"/>' method="post">
			<div class="ml" style="text-align:left;">
				<table >
					<div class="converttips">
						<tr><td><span class="dt-ask" style=" -moz-box-orient: vertical; background: none repeat scroll 0 0 #63BD65;border-radius: 2px;
	    color: #FFFFFF;display: inline-block;font-size: 12px;height: 18px;line-height: 18px;margin-right: 7px;
	    margin-top: -3px; overflow: hidden;text-align: center; vertical-align: middle;
	    width: 15px;">问</span><label class="label-name" for="create" style="margin-top:20px;">悬赏问题的标题：</label>
							<font color="red">*<span id="demoareatext">
								<s:if test="hasFieldErrors()">
									<s:iterator value="fieldErrors">
										<s:property value="value[0]" />;<br/>
									</s:iterator>
								</s:if>
								</span>
							</font>
						</td></tr>
						
						<tr><td><div >
							<textarea id="demoarea" class="questionName" placeholder="一句话描述您的疑问" name="knowledgeQuestion.title" style="resize:none;border: 1px solid #CFCFCF;width:770px;align:center;"></textarea>
						</div></td><td><img class="nslog:1008" width="737" height="60" border="0" style="float:right;;margin-left:5px" src='<s:url value="/km/baike/entry/images/1.gif" />'></td></tr>
						
						<tr><td>
							<label class="label-name" for="create" style="margin-top:20px;">问题简介：</label>
						</td><td><img class="nslog:1008" width="637" height="60" border="0"  style="float:right;margin-right:50px;" src='<s:url value="/km/baike/entry/images/welcome.gif" />'></td></tr>
						
						<tr><td><div >
							<textarea id="demoarea" placeholder="您可以在这里继续补充问题细节" rows="5" name="knowledgeQuestion.content" style="resize:none;border: 1px solid #CFCFCF;width:770px;align:center;"></textarea>
						</div></td></tr>
		
						<tr align=right><td>
							<div>
								<select name="knowledgeQuestion.point">
									<option selected="selected"  value="1">悬赏1分</option>
									<option  value="2">悬赏2分</option>
									<option  value="3">悬赏3分</option>
									<option  value="4">悬赏4分</option>
									<option  value="5">悬赏5分</option>
								</select>
								
								<select name="knowledgeQuestion.categoryId">
									<s:iterator value="#request.categories" >
						 			<option value='<s:property value="id"/>'><s:property value="name"/></option>
						 		</s:iterator>
								</select>
							
							</div>
						</td></tr>
							
						<tr><td>
							<input id="submmit" class="bg btn" type="submit" value="" onclick="return validateEmpty();" >
						</td></tr>
								
				</table>
			</div>
		</div>
	</form>
</div>
	

<div class="bgpagLn" align="center" >
		
		
		<div id="footer" class="nslog-area"  align="center" data-nslog-type="1001" style="margin: 0 auto;margin-top:20px;margin-top: 115px;">
		2013 BaiKe
		<a target="_blank"  >版权所有@天翎网络</a>
		</div>
</div>
</body>
</html>
<%-- 

<img class="nslog:1008" width="737" height="60" border="0" style="margin-top:-55px;float:right;" src='<s:url value="/km/baike/entry/images/knowledge.gif" />'>
&nbsp;&nbsp;&nbsp;<img class="nslog:1008" width="637" height="60" border="0"  style="margin-top:-55px;float:right;" src='<s:url value="/km/baike/entry/images/welcome.gif" />'>

<div style=" text-align: right;font-family: 微软雅黑,黑体,Verdana;font-size:15px;margin-top:2px;margin-bottom:10px">
共计&nbsp;<a style="color:#136EC2;"><s:property value="allQuestion" /></a>&nbsp;问题
&nbsp;&nbsp;&nbsp;&nbsp;已解决&nbsp;<a style="color:#136EC2;"><s:property value="allAcceptAnswer"/></a>&nbsp;问题</div> --%>