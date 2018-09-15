<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.Collection" %>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.baike.category.ejb.Category" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcess" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcessBean" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<% 
	CategoryProcess process = new CategoryProcessBean();
	Collection<Category> categories =process.doQuery();
	request.setAttribute("categories", categories);
%>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>百科首页</title>

<style type="text/css">
@IMPORT url("css/style.css");
*{
	margin: 0;
	padding: 0;
}
.section_div{
		margin-top:10px;
		border:1px solid #ccc;
		height:45%;		
		width: 37%;
		float: left;
	}
	.section{
		width: 100%;
		height: 10%
	}

	.section_font{
		font-size: 16px;
		font-style: inherit;
		font-family:黑体,arial,sans-serif;
	}
	.more{
		float:right;
		color: #0080FF ;
		font-size: 15px;
		margin-right: 10px;
	}
	.t2{
		background-color: #8E8E8E ;
	}
	tr{
		font-size: 15px;
		font-style:  inherit, ;
		color: black;
		
	}
	#table{
		margin: 0;
		padding: 0;
		width: 100%;
		
	}
	.table{
		table-layout:fixed;
		font-style:normal ;
		border:1px solid #ADADAD;
		color: #0080FF ;
		font-family:微软雅黑,arial,sans-serif;
		width: 100%;
		height: 85%;
		word-break: keep-all;
		table-layout:fixed;
		border: 0;
		
	}
	.h3{
		color:#FFFFFF ;
		align:"center";
		font-family:黑体,arial,sans-serif;
		/*background-color: #ECECEC;*/
	}
	.h5{
		font-size:12px;
		border-top:1px dotted #DDDDDD;
		word-break: break-all;
		text-overflow:ellipsis;
		white-space:nowrap; 
		overflow:hidden;
		padding-left:5px;
	}
	.h6{
		
		font-family:黑体,arial,sans-serif;
	}
	#con{
		text-align:left;
		/* width:1170px; */
		width:90%;
		min-width:800px;
		margin-bottom: 35px;
		
		margin-left:5%;
	}
	#createEntry{
		padding-top:13px;
		padding-left:20px;
		font-size:18px;
		float:right;
	}
	.bgpagLn{
		float:left;
		margin-top: 20px;
		padding-top: 20px;
		width: 100%;
	}
	
	.table .t_content:hover{
	background: #CCC;
		
	}
	
	
	a:link{
			text-decoration: none;
			color: #0000C6;
		}
		a:visited{
			text-decoration: none;
			color: #750000;
		}
		a:hover{
			color:#0000C6;
		}

</style>

<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 12px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a {text-decoration: none;color: #000;}
a:hover, a:link, a:visited {
    color: #136EC2;
}

#tabbox{ width:100%; overflow:hidden; margin:0 auto;}
.tab_conbox{border: 1px solid #999;border-top: none;}
.tab_con{ display:none;}

.tabs{height: 32px;border-bottom:1px solid #999;width: 100%;}
.tabs li{height:31px;line-height:31px;float:left;border:1px solid #999;border-left:none;margin-bottom: -1px;background: #e0e0e0;overflow: hidden;position: relative;}
.tabs li a {display: block;padding: 0 20px;border: 1px solid #fff;outline: none;}
.tabs li a:hover {background: #ccc;cursor:pointer}	
.tabs .thistab,.tabs .thistab a:hover{background: #fff;border-bottom: 1px solid #fff;}

.tab_con {padding:12px;font-size: 14px; line-height:175%;}
</style>
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
	
	/*获取更多最新词条*/
	function newMore() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/entry/doFindRecentEntry.action" />?selectedMenu='+selectedMenu;
	}
	/*获取部门积分*/
	function department() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/entry/doFindDepartmentPoint.action" />?selectedMenu='+selectedMenu;
	}
	
	/*获取更多最热词条*/
	function hotMore() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/entry/doFindHotEntry.action" />?selectedMenu='+selectedMenu;
	}
	/*获取更多 积分排行名单*/
	function pointMore() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/entry/doFindPointEntry.action" />?selectedMenu='+selectedMenu;
	}
	/*获取我的贡献名单*/
	function myContributor() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/entry/doFindContribute.action" />?selectedMenu='+selectedMenu;
	}
	/*获取我的贡献名单*/
	function moreQuestion() {
		var selectedMenu = $(".thistab").attr("id");
		location.href='<s:url value="/km/baike/knowledge/queryAllQuestion.action" />?selectedMenu='+selectedMenu;
	}
	function createEntry(){
		location.href='<s:url value="/km/baike/content/addEntry.jsp" />';
	}

	function init() {
		var menuId = '<s:property value="selectedMenu" />';
		if (menuId=="menu_2") {
			
			//菜单切换
			$("#menu_2").addClass("thistab").siblings("li").removeClass("thistab"); 
			
			//内容根据菜单发生变化
			$("#num1").hide();
			$("#num3").hide();
			$("#num4").hide();
			$("#num2").show();
			
		} else {
			$("#menu_1").addClass("thistab").siblings("li").removeClass("thistab"); 
		}
	}
	
	$(document).ready(function() {
		
		init();
		
		//点击已通过版本菜单
		$("#menu_1").click(function(){
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#num1").show();
			$("#num2").hide();
			$("#num3").hide();
			$("#num4").hide();
			//$("#menu_passed").find("iframe").attr('src', '<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed');
			//alert('<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed');
			//alert($("#menu_passed").find("iframe").attr("src"));
		/* 	document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed';
			document.getElementsByName("version")[0].submit(); */
			
		});
		
		//点击未通过版本菜单
		$("#menu_2").click(function(){
			
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#num1").hide();
			$("#num2").show();
			$("#num3").hide();
			$("#num4").hide();
			//$("#menu_notpassed").find("iframe").attr('src', '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed');
		/* 	document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed';
			document.getElementsByName("version")[0].submit(); */
		});
		
		//点击未通过版本菜单
		$("#menu_3").click(function(){
			
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#num1").hide();
			$("#num3").show();
			$("#num2").hide();
			$("#num4").hide();
			//$("#menu_notpassed").find("iframe").attr('src', '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed');
		/* 	document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed';
			document.getElementsByName("version")[0].submit(); */
		});
		
		//点击未通过版本菜单
		$("#menu_4").click(function(){
			
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#num1").hide();
			$("#num4").show();
			$("#num3").hide();
			$("#num2").hide();
			//$("#menu_notpassed").find("iframe").attr('src', '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed');
		/* 	document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed';
			document.getElementsByName("version")[0].submit(); */
		});
	}	
	);
	

		
	
</script>

</head>  
<body>
<div id="con" align="center">
		<div id="userbar" >
					<a class="nslog:87" href='<s:url value="/km/baike/center/index.jsp?userId=" />'>我的百科&nbsp;|&nbsp;</a><a class="nslog:87" href='<s:url value="/km/baike/entry/pointRule.jsp" />'>积分规则</a>
		</div>
		<div id="header">
		<form action='<s:url value="/km/baike/entry/doAccess.action" />' method="post">
				<div id="search" class="clearfix" style="margin-bottom: 15px;">
					<div id="logo">
					<img class="nslog:1008" width="287" height="40" border="0" alt="到百科首页" src='<s:url value="/km/baike/entry/images/logo.png" />'>
					</div>
					<div id="search-content">
						<span class="s_ipt_wr">
								<span><input id="searchString" class="s_ipt"  maxlength="100" name="searchString" tabindex="1"  value='<s:property value="searchString" />'></span>
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
			<div style=" text-align: right;font-family: 微软雅黑,黑体,Verdana;font-size:15px;margin-top:2px;">已有&nbsp;<a style="color:#136EC2;"><s:property value="entryCounts" /></a>&nbsp;词条&nbsp;&nbsp;&nbsp;&nbsp;浏览&nbsp;<a style="color:#136EC2;"><s:property value="readCounts"/></a>&nbsp;人次</div>
			 <div id="top" class="tab clearfix" style="background:#D8D8D8 ; width:100%; height:32px;">
			<form  name="version" method="post">
			<div id="tabbox">
				<ul class="tabs" id="tabs">
					<li style="width:10px;border-top:0px; border-left:0px;border-bottom:0px;"></li>
					<s:iterator value="#request.categories" >
						<li id='<s:property value="id" />'><a href="<s:url value='/km/baike/entry/doInit.action'><s:param name='selectedMenu' value='id' /></s:url>"><s:property value="name" /></a></li>
					</s:iterator>
					
					<!-- 设置选项卡状态 -->
					<script type="text/javascript">
					    var selectedMenu = '<s:property value="selectedMenu" />';
						if (selectedMenu==null || selectedMenu=='null' || selectedMenu=='') {
							$("#tabs li:nth-child(2)").addClass("thistab");
							document.forms[0].action='<s:url value="/km/baike/entry/doInit.action" />?selectedMenu='+ $("#tabs li:nth-child(2)").attr("id");
							document.forms[0].submit();
						} else {
							$("#"+selectedMenu).addClass("thistab");
						} 
					</script>
				</ul>
			</div>
			
			</form>
		</div>
		
		</div>
<div id="table">
 <div>
		<div class="section_div">
		<table class="table">
			<tr>
			<td class="h2" >最新分享</td><td calss="h3"  align="right" style='color: #136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a  href='javascript:newMore();' >更多>></a></td>
		</tr>
			<table class="table">
				<tr class="t2">
					<td class="h3" style="width:70%">标题</td>
				
					<td class="h3" align="center"  style="width:30%;">分享时间</td>
				</tr>
			<s:set name="index" value="-1" />	
			<s:iterator value="topNewest.datas" status="anyStatus">
				<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5" ><a title='<s:property value="name"/>' href='<s:url value="/km/baike/entry/doView.action"/>?entryId=<s:property value="id" />'><s:property value="name"/></a></td>  
	
					<td class="h5" align="center" ><s:date name="created" format="yyyy-MM-dd" /></td>
				</tr>
			</s:iterator>
			
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter1"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter1">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
			</table>
		</div>
		
		
<div>
	<div class="section_div"  style="margin-left:2.6%;" >
		<table class="table">
		<tr>
			<td class="h2">热门分享</td><td  class="h3" align="right"  style='color: #136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a href='javascript:hotMore();' >更多>></a></td>
		</tr>
	<table class="table">
			<tr class="t2">
				<td class="h3" style="width:70%">标题</td>
				<td class="h3"  align="center" style="width:30%;">浏览次数</td>
			</tr>
			<s:set name="index" value="-1" />
			<s:iterator value="topHot.datas" status="anyStatus">
				<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5"><a title='<s:property value="name"/>' href='<s:url value="/km/baike/entry/doView.action"/>?entryId=<s:property value="id" />'><s:property value="name"/></a></td>  
					
					<td class="h5" align="center" ><s:property value="browseCount"/></td>
				</tr>			
			</s:iterator>
			
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter2"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter2">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
		</table>
	</div>
     
		
	 <div class="section_div"  style="margin-left:2.6%;width:20%;">
		<table class="table">
		<tr>
		<td class="h2" width="60%">部门积分排名</td><td align="right" class="h3"  style='color: #136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a href='javascript:department();'>更多>></a></td>
		</tr>
		<table class="table">
			<tr class="t2">
				<td class="h3" style="width:70%">部门</td>
				<td class="h3"  align="center"  style="width:30%;margin-right:1px;">积分</td>
			</tr>
			
			<s:set name="index" value="-1" />
			 <s:iterator value="topDepartmentPoint.datas" id="depScore" status="anyStatus">
			 	<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5"><s:property value="#depScore.get('NAME')" /></td>
					<td class="h5" align="center" ><s:property value="#depScore.get(\"TOTALINTEGRAL\")" /></td>
				</tr>
			</s:iterator>
			
			
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter3"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter3">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
		</table>
	</div>
</div>
	</div>

	
	 <div class="section_div"  >
		<table class="table">
		<tr>
			<td class="h2">知识悬赏(<a href="<s:url value="/km/baike/knowledge/doInit.action" />" style="font-size:13px">我要悬赏</a>)</td><td class="h3" align="right"  style='color:#136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a href='javascript:moreQuestion();'>更多>></a></td>
		</tr>
		<table class="table">
			<tr class="t2">
				<td class="h3" style="width:70%">标题</td>
				<td class="h3"  align="center"  style="width:30%;">提问时间</td>
			</tr>
			
			<s:set name="index" value="-1" />
			<s:iterator value="question.datas" status="anyStatus">
				<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5"><a href='<s:url value="/km/baike/knowledge/doView.action"/>?questionId=<s:property value="id" />'><s:property value="title"/></td>
			
					<td class="h5" align="center" ><s:date name="created" format="yyyy-MM-dd" /></td>
				</tr>
			</s:iterator>
			
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter4"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter4">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
		</table>
	</div>

	
	
 <div class="section_div"  style="margin-left:2.6%">
		<table class="table">
		<tr>
			<td class="h2">我的百科</td><td class="h3" align="right"  style='color:#136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a href='javascript:myContributor();'>更多>></a></td>
		</tr>
		<table class="table">
			<tr class="t2">
				<td class="h3" style="width:70%">标题</td>
				<td class="h3"  align="center"  style="width:30%;">创建时间</td>
			</tr>
			
			<s:set name="index" value="-1" />
			<s:iterator value="conttribute.datas" status="anyStatus">
				<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5"><a title='<s:property value="entry.name"/>' href='<s:url value="/km/baike/entry/doView.action"/>?entryId=<s:property value="id" />'><s:property value="name"/></a></td>
			 
					<td class="h5" align="center" ><s:date name="created" format="yyyy-MM-dd" /></td>
				</tr>
			</s:iterator>
			
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter5"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter5">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
		</table>
	</div>
	
    <div class="section_div" style="margin-left:2.6%;width:20%;">
			<table class="table">
			<tr>
			<td class="h2" width="60%">个人积分排名</td><td class="h3" href='javascript:pointMore();' align="right" style='color:#136EC2;font-family: 微软雅黑,arial,sans-serif;font-size: 14px;'><a href='javascript:pointMore();'>更多>></a></td>
			</tr>
			<table class="table">
				<tr class="t2">
					<td class="h3" style="width:70%;">姓名</td>
					<td class="h3"  align="center"  style="width:30%;">积分</td>
				</tr>
			<s:set name="index" value="-1" />	
			<s:iterator value="topPoint.datas" status="anyStatus">
				<s:set name="index" value="#anyStatus.index" />
				<tr class="t_content">
					<td class="h5"><s:property value="name"/></td>  
					<td class="h5" align="center" ><s:property value="attribute.integral"/></td>
				</tr>			
			</s:iterator>
			<!--  <script>alert('<s:property value="#index" />');</script> -->
			<!-- 若已经输出6条记录 -->
			<s:if test="#index<7"> 
			<!-- for循环 -->
			<s:bean id="counter6"   name="org.apache.struts2.util.Counter">   
          		<s:param  name="last"  value="7-#index"/>    
          	</s:bean>
			<s:iterator value="#counter6">
				<tr class="t_content">
					<td class="h5">&nbsp;</td>  
					<td class="h5">&nbsp;</td>
				</tr>
			</s:iterator>
			</s:if>
			</table>
		</div>
    
    
    
    
</div>
</div>




<div class="bgpagLn" align="center" style="text-align: center; float: left; margin-top: 30px; width: 100%;">
		<a target="_blank" href="">copyright: 2013 BaiKe版权所有@天翎网络</a>
</div>

</div>
