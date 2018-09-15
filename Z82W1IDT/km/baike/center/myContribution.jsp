<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%

	String userId=request.getParameter("userId");
	
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	//out.print(user.getId());
	boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(user.getId());
	session.setAttribute("isOneUser", isOneUser);
	//out.print(isOneUser);
%>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<html>
<!-- <link type="text/css" href="css/styleitem.css" rel="stylesheet" />
<link type="text/css" href="css/style.css" rel="stylesheet" /> --> 
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<meta content="IE=7" http-equiv="X-UA-Compatible"/>
<title>我的词条</title>


<style>
	th {
		border-bottom: 1px solid #000000; 
	} 
	td
	{
		border-bottom: 1px dotted #AEC9EA;  
		margin-top: 3px; 
		word-break: break-all; 
		text-overflow:ellipsis; 
		white-space:nowrap; 
		overflow:hidden; 
		font-size:12px;
	}
	
	tr 
	{
		height:35px;
	}
	
	a{
	   color:#000000;
	   text-decoration:none;
	}

/* 	a:hover{
    	/* cursor:cursor; */
    	position:relative;
	} */
	
	a:visited{
		color:#FF0000;
	}
	
</style>


<script type="text/javascript">

	function init() {
		var menuId = '<s:property value="selectedMenu" />';
		if (menuId=="menu_notpassed") {
			
			//菜单切换
			$("#menu_notpassed").addClass("thistab").siblings("li").removeClass("thistab"); 
			
			//内容根据菜单发生变化
			$("#content_passed").hide();
			$("#content_notpassed").show();
		} else {
			$("#menu_passed").addClass("thistab").siblings("li").removeClass("thistab"); 
		}
	}
	
	$(document).ready(function() {
		
		init();
		
		//点击已通过版本菜单
		$("#menu_passed").click(function(){
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#content_passed").show();
			$("#content_notpassed").hide();
			//$("#menu_passed").find("iframe").attr('src', '<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed');
			//alert('<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed');
			//alert($("#menu_passed").find("iframe").attr("src"));
			document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_passed&userId=<%=userId%>';
			document.getElementsByName("version")[0].submit();
			
		});
		
		//点击未通过版本菜单
		$("#menu_notpassed").click(function(){
			
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#content_passed").hide();
			$("#content_notpassed").show();
		
			//$("#menu_notpassed").find("iframe").attr('src', '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed');
			document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_notpassed&userId=<%=userId%>';
			document.getElementsByName("version")[0].submit();
		});
		
	}	
	);

</script>



<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 12px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a {text-decoration: none;color: #000;}
a:hover, a:link, a:visited {
   
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


</head>
<body>
	<div>
		 <div id="top" class="tab clearfix" style="background:#D8D8D8 ; width:100%; height:32px;">
			<form  name="version" method="post">
			<div id="tabbox">
				<ul class="tabs" id="tabs">
					<li style="width:10px;border-top:0px; border-left:0px;border-bottom:0px;"></li>
					<li id="menu_passed"><a>已通过版本</a></li>
					<li id="menu_notpassed"><a>未通过版本</a></li>
				</ul>
			</div>
			
			</form>
		</div>
		
		<!-- 已通过版本 -->
		<div id="content_passed">
			<div class="title">
				
			</div>
			<div class="content">
				<div class="table-list" style="text-align:center; width:100%; ">
				<table cellSpacing="0"  cellPadding="0" style="text-align:center;table-layout:fixed;width:100%">
					<tr class="tr clearfix">
						<th class="time" align="left" style="padding-left:10px; font-size: 14px;font-weight: bold;">词条名称</th>
						<th class="version" style="font-size: 14px;font-weight: bold;">创建人</th>
						<th class="contributor" style="font-size: 14px;font-weight: bold;">贡献时间</th>
						<th class="reason" style="font-size: 14px;font-weight: bold;">编辑次数</th>
					</tr>
						<!-- 循环遍历Entry数据集 -->
					<s:iterator value="entrys.datas">
						<tr class="tr clearfix">
							<td class="time"  align="left" style="padding-left:10px;"><a href="#" title='<s:property value="name"/>' onclick='javascript:parent.location.href="<s:url value="/km/baike/entry/doView.action" />?entryId=<s:property value="id"/>";'><s:property value="name"/></a></td>
							<td class="version"><s:property value="author.name"/></td>
							<td class="contributor"><s:date name="created" format="yyyy-MM-dd" /></td>
							<td class="reason"><s:property value="latestContent.versionNum"/></td>
						</tr>
					</s:iterator>
				</table>
				
				<!-- 分页 -->
				<div id="fenye" align="right" style="margin-top:5px;font-size:12px;">
					<a style=" color: #136EC2;" href="<s:url action='doGetMyContribution'> 
							<s:param name="page" value="1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author">fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url>" >首页</a>
					<a style=" color: #136EC2;" href="<s:if test="entrys.pageNo>1">
							<s:url action='doGetMyContribution'>
							<s:param name="page" value="entrys.pageNo-1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url></s:if><s:else>#</s:else>" >上一页</a> 
					<a style=" color: #136EC2;" href="<s:if test="entrys.pageNo<entrys.getPageCount()">
							<s:url action='doGetMyContribution'>
							<s:param name="page" value="entrys.pageNo+1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>" >下一页</a>
					<a  style=" color: #136EC2;" href="<s:url action='doGetMyContribution'>
							<s:param name="page" value="entrys.getPageCount()" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url>" >尾页</a>
						页次：<s:property value="entrys.pageNo" />/<s:property value="entrys.getPageCount()" />
						页 共<s:property value="entrys.rowCount" />条记录 <s:property value="entrys.linesPerPage" />条记录/页
						</div>
					</div>
				</div>	
			 </div>
		</div>


	<!-- 未通过版本 -->
	<div id="content_notpassed" style="display: none;">
		<div style="text-align:center width:100%;">
				<table cellSpacing="0"  cellPadding="0" style="text-align:center; table-layout:fixed;width:100%">
					<tr>
						<th align="left" style="padding-left:10px; font-size: 14px;font-weight: bold;">词条名称</th>
						<th class="version" style="font-size: 14px;font-weight: bold;">提交时间</th>
						<th class="contributor" style="font-size: 14px;font-weight: bold;">创建人</th>
						<s:if test="(#session['isOneUser'])">
							<th class="reason" style="font-size: 14px;font-weight: bold;">操作</th>
						</s:if>
					</tr>
					
					<!-- 循环遍历Entry数据集 -->
						<s:iterator value="entrys.datas">
							<tr>
								<td class="time" align="left" style="padding-left:10px;"><a href="#" title='<s:property value="name"/>' onclick='javascript:parent.location.href="<s:url value="/km/baike/entry/doPreview.action" />?entryId=<s:property value="id"/>&contentId=<s:property value="latestContent.id" />";'><s:property value="name"/></a></td>
								<td class="version"><s:date name="created" format="yyyy-MM-dd" /></td>
								<td class="contributor"><s:property value="author.name"/></td>
								<s:if test="(#session['isOneUser'])">
									<td class="reason">
									<a onclick='javascript:parent.location.href="<s:url value="/km/baike/content/findContent.action" />?contentId=<s:property value="entryContent.id"/>";' ><image src='<s:url value="image/ContinueEdit.gif" />'/>继续编辑</a>
										<%-- <a href='<s:url value="/km/baike/entry/doView.action" />?entryId=<s:property value="id"/>'><image src="image/ContinueEdit.gif" border='0'/>继续编辑</a> --%>
										<a href='<s:url value="/km/baike/center/doRemoveReject.action" />?entryId=<s:property value="id"/>'><image src='<s:url value="/km/baike/center/image/delete.gif"/>' border='0'/>删除</a>
									</td>
								</s:if>
							</tr>
						</s:iterator>
				</table>
				
			</div>
				<div align="right" style="margin-top:5px;font-size:12px;">
					<a href='<s:url action="doNotThroughVersion"> 
							<s:param name="page" value="1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author">fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url>' >首页</a>
					<a href='<s:if test="entrys.pageNo>1">
							<s:url action='doNotThroughVersion'>
							<s:param name="page" value="entrys.pageNo-1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>' >上一页</a> 
					<a href='<s:if test="entrys.pageNo<entrys.getPageCount()">
							<s:url action='doNotThroughVersion'>
							<s:param name="page" value="entrys.pageNo+1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>' >下一页</a>
					<a href='<s:url action='doNotThroughVersion'>
							<s:param name="page" value="entrys.getPageCount()" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url>' >尾页</a>
					页次：<s:property value="entrys.pageNo" />/<s:property value="entrys.getPageCount()" />
					页 共<s:property value="entrys.rowCount" />条记录 <s:property value="entrys.linesPerPage" />条记录/页
					</div>
				
			</div>
		</div>
	</body>
</html>