
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
<%@ page import="java.util.*" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcessBean" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcess" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestion" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswer" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswerProcessBean" %>
<%@ page import="cn.myapps.km.baike.user.ejb.BUser" %>
<% 
	CategoryProcess process = new CategoryProcessBean();
	Collection<Category> categories =process.doQuery();
	request.setAttribute("categories", categories);
	BUser user = (BUser)session.getAttribute(BUser.SESSION_ATTRIBUTE_FRONT_USER);
	
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
		editor = K.create('textarea[name="knowledgeAnswer.content"]', {
		cssPath : '<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.css" />',
		uploadJson : '<s:url value="/km/baike/component/kindeditor/jsp/upload_json.jsp" />',
		fileManagerJson : '<s:url value="/km/baike/component/kindeditor/jsp/file_manager_json.jsp" />',
		allowFileManager : true,
		afterCreate : function() {
			this.sync();
		}
	});
});


function doAcceptAnswer(answerId) {
	var url = '<s:url value="/km/baike/knowledge/doAcceptAnswer.action" />';
		$.ajax({
			type: "POST",
			url: url,
			data: {answerId:entryId},
			success: function(){location.reload();},
			error: function(){alert("采纳失败!");}
		});
	
}
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
    line-height: 30px;
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
	background-image: url('<s:url value="/km/baike/entry/images/subAnswer.jpg" />');
}
#save {
	background-image: url('<s:url value="/km/baike/content/images/save.jpg" />');
}
.wgt-ask .guide-tip {
    background: none repeat scroll 0 0 #FEFBED;
    border: 1px solid #EFEED7;
    box-shadow: 0 3px 3px rgba(0, 0, 0, 0.05);
    padding: 10px 25px;
}
.f-12, a.f-12 {
    font-size: 12px;
}
.f-gray, a.f-gray {
    color: #666666;
}
 .mb-10 {
    margin-bottom: 10px;
}
.mt-10 {
    margin-top: 10px;
}
.btn-24-white, a.btn-24-white, .btn-24-white1, a.btn-24-white1, .btn-24-white2, a.btn-24-white2 {
    background-color: #FFFFFF;
    background-image: -moz-linear-gradient(center top , #D8E9EC, #FDFDFD);
    background-repeat: repeat-x;
    border: 1px solid #DBDBDB;
    border-radius: 2px;
    box-shadow: 0 1px 1px #F2F2F2;
    cursor: pointer;
    display: inline-block;
    font-size: 12px;
    height: 22px;
    line-height: 22px;
    padding: 0 5px;
    text-align: center;
}

	</style>
</head>

<script type="text/javascript">

function htmlspecialchars(str) {
		var re1 = new RegExp("&","g"); 
		var re2 = new RegExp("<","g");  
		var re3 = new RegExp(">","g");
		var re4 = new RegExp("\"","g"); 
		str = str.replace(re1, "&amp;");
		str = str.replace(re2, "&lt;");
		str = str.replace(re3, "&gt;");
		str = str.replace(re4, "&quot;");
		return str;
}

	function doSave() {
		editor.sync();
		document.getElementsByName("content_handle")[0].action = '<s:url value="/km/baike/content/doUpdate.action" />';
		document.getElementsByName("content_handle")[0].submit();
	}
	
	function doSubmit() {
		editor.sync();
		document.getElementsByName("content_handle")[0].action = '<s:url value="/km/baike/content/doSubmmit.action" />';
		document.getElementsByName("content_handle")[0].submit();
	}
	
	//必填校验
	function validateEmpty() {
		if ($.trim(editor.text()).length<=0) {
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
  
    <!-- 判断当前用户是否为此问题作者 -->		
    <s:set name="curUserIsQeustionAuthor" value="false" />
	<s:if test="#session['BAIKE_FRONT_USER'].id ==content.author.id">
		<s:set name="curUserIsQeustionAuthor" />
	</s:if>
	
	    <!-- 判断答案是否已经被采纳 -->		
    <s:set name="answerIsAccept" value="false" />
	<s:if test="acceptAnswer==null ">
		<s:set name="answerIsAccept" />
	</s:if> 

<s:set name="answerIsNull" value="false" />
	<s:if test="acceptAnswer!=null ">
		<s:set name="answerIsNull" />
	</s:if> 
	    
		
		<div class="b1" style="background-color: #FBFBFB;">
		
		<div class="ml" style="text-align:left;">


		<div class="converttips">
			
		<span class="dt-ask" style=" -moz-box-orient: vertical; background: none repeat scroll 0 0 #63BD65;border-radius: 2px;
	    color: #FFFFFF;display: inline-block;font-size: 12px;height: 18px;line-height: 18px;margin-right: 7px;
	    margin-top: -3px; overflow: hidden;text-align: center; vertical-align: middle;
	    width: 15px;">问</span><s:property value="content.title"  />（悬赏<s:property value="content.point"  />分）</br>
		
		<a align="right" style="color: #136EC2;  font-family: 微软雅黑,黑体,Verdana;">
			<label style="margin-right:726px;color: #333333;  font-family: 微软雅黑,黑体,Verdana;background-image: url('<s:url value="/km/baike/entry/images/question.png" />');background-position: -239px -742px;padding-left: 25px;">
			<s:property value="content.author.name" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><s:date name="content.created" format="yyyy-MM-dd HH:mm:ss" /></br>
		 </a>
		<div> <s:property value="content.content" escape="false" /></div>
		  
		<s:if test="#answerIsNull"> 
			 <div style="border: 1px solid #EFEED7;background: none repeat scroll 0 0 #FEFBED;box-shadow: 0 3px 3px rgba(0, 0, 0, 0.05); padding: 10px;width:920px;"> 
				 <h2 >最佳答案</h2> 
					<a align="right" style="color: #999999; "><label style="margin-right:760px;color: #999999;  font-size:13px;">
						<s:property value="acceptAnswer.author.name" /></label><s:date name="acceptAnswer.submitTime" format="yyyy-MM-dd HH:mm:ss" />
					</a> 
					<a style="margin-top:20px">
				<div id="answer" style="width:840px;">
					<s:property value="acceptAnswer.content"  escape="false" />	
				</div> 
			</div>
		   </s:if> 
			
		<label class="label-name" for="create" style="margin-top:20px;color: #2D64B3;">提问者正在等待您的回答：</label> 
		<font color="red">*<span id="demoareatext">
				<s:if test="hasFieldErrors()">
					<s:iterator value="fieldErrors">
						<s:property value="value[0]" />;<br/>
					</s:iterator>
				</s:if>
			</span>
		</font>
				
		<form name="content_handle" action='<s:url value="/km/baike/knowledge/doSubmit.action"/>' method="post">
				 <div>
						<input type="hidden"  name="knowledgeAnswer.questionId" value='<s:property value="content.id" />' /> 	
						<textarea  id="demoarea" rows="5" name="knowledgeAnswer.content" style="resize:none;border: 1px solid #CFCFCF;width:940px;align:center;"></textarea>
				</div> 
						<input id="submmit" class="bg btn" type="submit" value="" onclick="return validateEmpty();"  >
		 </form>
		 
		 <div class="tab clearfix" style="margin-top:10px;width:100%; height:10px; background:#CCCCFF"></div> 
		
		 <div style="margin-top:10px;font-size: 16px;font-weight: bold;text-align:left; ">其他回答</div></tr>
		
		 <div class="xian" style="border-bottom:1px dashed  #AEC9EA; margin-top: 1px;width:100%"></div> 
			
		<s:iterator value="answers" > 
			<table>
				<tr><td align="right" style="color: #999999;  font-size:14px;"><label style="margin-right:730px;color: #999999;  font-size:13px;background-image: url('<s:url value="/km/baike/entry/images/question.png" />');background-position: -239px -742px;padding-left: 25px;"><s:property value="author.name" /></label><s:date name="submitTime" format="yyyy-MM-dd HH:mm:ss" /> 
				<tr ><td style="margin-top:20px"><div id="answer" style="width:840px;font-size: 15px;margin-top:10px;margin-bottom:10px;"><s:property value="content"  escape="false" />	</div> 
				<tr><td align="right"><div id="acceptAnswer" ><s:if test="#answerIsAccept"><s:if test="#curUserIsQeustionAuthor"><a href='<s:url value="/km/baike/knowledge/doAcceptAnswer.action" />?answerId=<s:property value="id" />'  id="adopt-ask-1595612650" class="btn-24-white grid mr-10" >采纳为满意回答</a></s:if></s:if></div> 
			</table>
			 <div class="xian" style="border-bottom:1px dashed  #AEC9EA; margin-top: 1px;width:100%"></div> 
		</s:iterator>
	
		</div>
	</div>
</div>
	</div>

	<div class="bgpagLn" align="center" >
			<div id="footer" class="nslog-area"  align="center" data-nslog-type="1001" style="margin: 0 auto;margin-top:20px;margin-top: 115px;">
			2013 BaiKe
			<a target="_blank"  >版权所有@天翎网络</a>
			</div>
	</div>
<s:property value="knowledgeQuestion.point" />
</body>
</html>


