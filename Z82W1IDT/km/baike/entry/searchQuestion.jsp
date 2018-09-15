<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>查找你想要的词条</title>
<!--  
	<link rel="stylesheet" type="text/css" href="css/style.css" />
-->
<style type="text/css">
	@IMPORT url("css/style.css");
	*{
		margin: 0;
		padding: 0;
	}
		.entry{
			font-size: 12px;
			margin-bottom: 15px;
			width: 50%;
			margin-left: 46px;
		}
		.title{
			font-size:20px;
			padding-bottom: 0px;
			margin-bottom: 0px;
		}	
		.link{
			color:#006000;
			font-size:12px;
			/*padding-top: -20px;
			padding-bottom: -30px;
			margin-top:-20px;*/
		}
		.key_word{
		color:#EA0000 ;
		}	
		.content{
			margin-top:0px;
			padding-top: 0px;
			padding-bottom: 0px;
			
		}
		p{
			padding-top: 0px;
			padding-bottom: 0px;
		}.
		#content{
			
			margin-left: 200px;
			
		}
		
		#foot{
			margin-left:46px;
			margin-bottom:20px;
			font-size:14px;
		}
		.page{
			
			display: block;
			font-size:15px;
			color: blue;
			float: left;
			margin-left: 20px;
		}
		.time{
		margin-right: 20px;
		}
		
	#search1 {
	
    margin-bottom: 55px;
    position: relative;
    width: 900px;
    z-index: 2;
}
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
	
	#ft {
	    background: none repeat scroll 0 0 #E6E6E6;
	    font-family: Arial,宋体,sans-serif;
	    font-size: 12px;
	    height: 20px;
	    line-height: 20px;
	    text-align: center;
	}

#search1 .s_btn {
    background: url("http://img.baidu.com/img/baike/logo/bg_search.png") repeat scroll 0 0 

#DDDDDD;
    border: 0 none;
    cursor: pointer;
    font-size: 14px;
    height: 32px;
    padding: 0;
    width: 95px;
}


#search1 .s_ipt {
    background: none repeat scroll 0 0 #FFFFFF;
    border: 0 none;
    font: 16px/22px arial;
    height: 22px;
    margin: 5px 0 0 7px;
    outline: 0 none;
    padding: 0;
    width: 398px;
}


#search1 .s_ipt_wr {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: url("http://img.baidu.com/img/baike/logo/bg_search.png") no-repeat scroll -304px 

0 rgba(0, 0, 0, 0);
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


#search-content1 {
    float: left;
}


.direct_bg {
	margin-left: 46px;
    background: none repeat scroll 0 0 #EBEBEB;
    margin: 23px 0 38px 5px;
    width: 502px;
}


.direct_holder {
    background: none repeat scroll 0 0 #EBF6FE;
    border: 1px solid #C0C0C0;
    
    left: -5px;
    padding: 10px;
    position: relative;
    top: -5px;
    width: 480px;
}

</style>
</head>
<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>
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
<body>
	<div id="userbar">
		<ul style="margin-bottom: -5px;padding-bottom: -5px">
			<li>
				<a class="nslog:87" href='<s:url value="/km/baike/center/index.jsp" />?userId='>我的百科</a>&nbsp;&nbsp;|<a class="nslog:87" href='<s:url value="/km/baike/entry/doInit.action" />'>百科首页</a>
			</li>
		</ul>
	</div>
	<div id="header" style="padding-left: 46px;">
		<div id="search" class="clearfix">
			<div id="logo">
			<a href="/"><img class="nslog:1008" width="287" height="40" border="0" alt="到百科首页" src='<s:url value="/km/baike/entry/images/logo.png" />'></a>
			</div>
			<div id="search-content">
				<span class="s_ipt_wr">
						<span><input id="searchString" class="s_ipt" maxlength="100" name="searchString" tabindex="1" value='<s:property value="searchString" />'></span>
				</span>
				<span class="s_btn_wr" style="margin-right:6px">
						<span>
							<input class="s_btn" type="button" onclick="searchQuestion();" onmousedown="this.className=" onmouseout="this.className=" tabindex="2" value="搜索问题">
						</span>
					</span>
			</div>
		</div>
	</div>

	<!-- 搜索出来的内容 -->
	<div id="content">
		<!-- 如果查询出记录非空 -->
		<s:if test="listQuestion.size()>0" >
		<s:iterator value="listQuestion" >
			<div class="entry">
				<div class=title>
					<a href='<s:url value="/km/baike/knowledge/doView.action" />?questionId=<s:property value="id" />'><s:property value="title" /></a>
				</div>
				<div class="content">
					<p><s:property value="question.content" /></p>
				</div>		
				<div class="link">
					<span><span class="time"><s:date name="created" format="yyyy-MM-dd HH:mm" /></span><span><a class="link" href="#"><s:property value="author.name" /></a></span></span>
				</div>
			</div>
		</s:iterator>
		</s:if> 
		<s:else>
			<div class="direct_bg">
				<div class="direct_holder">
					<p>抱歉，知识悬赏尚未收录该问题“
						<font id="searchWord" color="#C60A00">
							<s:property value="searchString" />
						</font>
						”</br>
						欢迎您来创建，与各位同事讨论该问题。
					</p>
				</div>
			</div>
		</s:else>
	</div>
	
	<!-- 如果查询结果为空，隐藏分页 -->
	<s:if test="listQuestion.size()>0">
	<div id="foot" >
	
		
	
		<a href="<s:if test="page>1">
				<s:url value='/km/baike/content/doQuery.action'>
				<s:param name="page" value="page-1" />
				<s:param name="lines" value="10" />
				<s:param name="searchString" value="searchString"/>
				</s:url></s:if><s:else>#</s:else>" >上一页</a>
				<font color="red"></font><s:property value="page" /></font>
		<a href="<s:if test="listcontent.size()<10">
				<s:url value='/km/baike/content/doQuery.action'>
				<s:param name="page" value="page+1" />
				<s:param name="lines" value="10" />
				<s:param name="searchString" value="searchString"/>
				</s:url></s:if><s:else>#</s:else>" >下一页</a>
			
		
		
	
	</div>	
	</s:if>

<div id="ft" align="center" style="text-align: center; float: left; margin-top: 0px; width: 100%;">
		<a target="_blank" href="">copyright: 2013 BaiKe版权所有@天翎网络</a>
</div>



</body>
</html>