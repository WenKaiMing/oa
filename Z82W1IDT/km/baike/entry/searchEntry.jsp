<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
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
<script type="text/javascript">
	/*搜索词条*/
	function searchEntry(){
		var searchString = $("#searchString").val();
		if($.trim(searchString).length==0){
			alert("请填写搜索内容!");
			return;
		}
		document.forms[0].action = "<s:url value='/km/baike/content/doQuery.action' />";
		
		document.forms[0].submit();
	}
	
	/*进入词条*/
	function enterEntry(){
		var searchString = $("#searchString").val();
		if($.trim(searchString).length==0){
			alert("请填写搜索内容!");
			return;
		}
		/*<s:url value='/km/disk/file/query.action'><s:param name='_type' value='_type' /></s:url>*/
		document.forms[0].action = "<s:url value='/km/baike/entry/doAccess.action' />";
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
				<form action='<s:url value="/km/baike/entry/doAccess.action" />' method="post">
						<span class="s_ipt_wr">
								<span><input id="searchString" class="s_ipt" maxlength="100" name="searchString" tabindex="1" value='<s:property value="searchString" />'></span>
						</span>
						<span class="s_btn_wr" style="margin-right:6px">
								<span>
									<input class="s_btn" type="button" onclick="enterEntry();" onmousedown="this.className=" onmouseout="this.className=" tabindex="2" value="进入词条">
								</span>
							</span>
							<span class="s_btn_wr">
								<span>
						 			<input class="s_btn" type="button" onclick="searchEntry();" onmousedown="this.className="onmouseout="this.className=" tabindex="3" value="搜索词条">
							</span>
						</span>
				</form>
			</div>
		</div>
	</div>

	<!-- 搜索出来的内容 -->
	<div id="content">
		<!-- 如果查询出记录非空 -->
		<s:if test="listContent.size()>0" >
		<s:iterator value="listContent" >
			<div class="entry">
				<div class=title>
					<a href='<s:url value="/km/baike/entry/doView.action" />?entryId=<s:property value="entryId" />'><s:property value="entry.name" /></a>
				</div>
				<div class="content">
					<p><s:property value="summary" /></p>
				</div>		
				<div class="link">
					<span><span class="time"><s:date name="handleTime" format="yyyy-MM-dd HH:mm" /></span><span><a class="link" href="#"><s:property value="author.name" /></a></span></span>
				</div>
			</div>
		</s:iterator>
		</s:if> 
		<s:else>
			<div class="direct_bg">
				<div class="direct_holder">
					<p>抱歉，经验百科尚未收录词条“
						<font id="searchWord" color="#C60A00">
							<s:property value="searchString" />
						</font>
						”</br>
						欢迎您来创建，与各位同事分享关于该词条的信息。
					</p>
				</div>
			</div>
		</s:else>
	</div>
	
	<!-- 如果查询结果为空，隐藏分页 -->
	<s:if test="listContent.size()>0">
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