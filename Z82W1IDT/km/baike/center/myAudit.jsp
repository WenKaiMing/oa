<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.myapps.km.baike.category.ejb.Category" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcess" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcessBean" %>

<%
	String userId=request.getParameter("userId");
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(user.getId());
	session.setAttribute("isOneUser", isOneUser);
%>
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
<html>
<link type="text/css" rel="stylesheet" href="css/default.css" />
<link type="text/css" href="css/styleitem.css" rel="stylesheet" />
<link type="text/css" href="css/style.css" rel="stylesheet" />

<link rel="stylesheet" href="<%=basePath %>/km/baike/script/jquery-ui/themes/base/jquery.ui.all.css">
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.core.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.widget.js"  type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.mouse.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.draggable.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.position.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.resizable.js" type="text/javascript"></script>
<script src="<%=basePath %>/km/baike/script/jquery-ui/ui/jquery.ui.button.js" type="text/javascript"></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero"></script>
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="<%=basePath %>/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js"></script>
<!-- 弹出层插件--end -->

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<meta content="IE=7" http-equiv="X-UA-Compatible"/>
<title>我的词条</title>


<style>
	th {
		border-bottom: 1px solid #000000; 
	} 
	.content td,#content_manager td
	{
		border-bottom: 1px dotted #AEC9EA;  
		margin-top: 3px; 
		word-break: break-all; 
		text-overflow:ellipsis; 
		white-space:nowrap; 
		overflow:hidden; 
		font-size:12px;
	}
	
	.content tr,#content_manager tr
	{
		height:35px;
	}

	
a {
    color: #000000;
    cursor: pointer;
    text-decoration: none;
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
		if (menuId=="menu_manager") {
			//菜单切换
			$("#menu_manager").addClass("thistab").siblings("li").removeClass("thistab"); 
			
			//内容根据菜单发生变化
			$("#content_audit").hide();
			$("#content_manager").show();
		} else {
			$("#menu_audit").addClass("thistab").siblings("li").removeClass("thistab"); 
		}
	}
	
	$(document).ready(function() {
		init();
		//点击已通过版本菜单
		$("#menu_audit").click(function(){
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#content_audit").show();
			$("#content_manager").hide();
			//$("#menu_audit").find("iframe").attr('src', '<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_audit');
			//alert('<s:url value="/km/baike/center/doGetMyContribution.action"/>?selectedMenu=menu_audit');
			//alert($("#menu_audit").find("iframe").attr("src"));
			document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doPendingList.action"/>?selectedMenu=menu_audit&userId=<%=userId%>';
			document.getElementsByName("version")[0].submit();
			
		});
		
		//点击未通过版本菜单
		$("#menu_manager").click(function(){
			$(this).addClass("thistab").siblings("li").removeClass("thistab"); 
			
			$("#content_audit").hide();
			$("#content_manager").show();
		
			//$("#menu_manager").find("iframe").attr('src', '<s:url value="/km/baike/center/doNotThroughVersion.action"/>?selectedMenu=menu_manager');
			document.getElementsByName("version")[0].action = '<s:url value="/km/baike/center/doGetMyManager.action"/>?selectedMenu=menu_manager&userId=<%=userId%>';
			document.getElementsByName("version")[0].submit();
		});
		
	}	
	);

	function deleteEntry(entryId) {
		var url = '<s:url value="/km/baike/center/doRemove.action" />';
		if(window.confirm("确定要删除您选择的词条吗？")){
			$.ajax({
				type: "POST",
				url: url,
				data: {entryId:entryId},
				success: function(){location.reload();},
				error: function(){alert("数据删除失败!请稍后再试,如果问题仍然存在,请与管理员联系!");}
			});
		};
	}
	function refresh()
	{

	window.opener.location.href=window.opener.location.href;
	   window.close();
	} 
	
	//必填校验
	function validateEmpty() {
		var $reason = $("#modify_reason");
		if ($.trim($reason.val()).length<=0) {
			$("#entryNametext").html('词条名称不能为空！');
			return false;
		} 
		
		return true;
	}
	
	
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
<body onload="refresh();">
	<div>
		 <div id="top" class="tab clearfix" style="background:#D8D8D8 ; width:100%; height:32px;">
			<form  name="version" method="post">
				<div id="tabbox">
					<ul class="tabs" id="tabs">
						<li style="width:10px;border-top:0px; border-left:0px;border-bottom:0px;"></li>
						<li id="menu_audit"><a>词条审核</a></li>
						<li id="menu_manager"><a>词条管理</a></li>
					</ul>
				</div>
			</form>
		</div>
		
		<!-- 已通过版本 -->
		<div id="content_audit">
			<div id="reasonDialog" >
			</div>
	<script>
	function mydialog(){
		artDialog({
			title:"驳回原因",
			height: 220,
			width: 550,
			background: '#000',			// 遮罩颜色
			opacity: 0.5,				// 遮罩透明度
			lock: true,
			content : $("#reasonDialog").html(),
			ok : function() {
	        	$.ajax({
	        		async:false,
	        		url:'<s:url value="/km/baike/center/doReject.action" />',
	        		data:'contentId='+$("#modify_contentId").val()+'&reason='+$("#modify_reason").val(),
	        		type:"post",
	        		dataType:'html',
	        		success:function(data){
	        			artDialog.close();
	        			window.location=window.location;
	        		},
	        		error:function(data) {
				        artDialog.close();
	        			alert('驳回失败!');
	        		}
	        	});
			},
			cancel : function() {
				artDialog.close();
			},
			okVal: '确定',
			cancelVal : '取消'
		});
	}
		
		function setDialogContent(divId,contentId){
			$("#"+divId).html("<div style='margin-left:60px;margin-top:14px;'> "+"<input type='hidden' value='"+contentId+"' id='modify_contentId'>"+
			"<font size='2px'  >驳回理由：<font color='red'>*<span id='entryNametext'><s:if test='hasFieldErrors()'><s:iterator value='fieldErrors'><s:property value='value[0]' />;<br/></s:iterator></s:if></span></font></font><br><textarea id='modify_reason' rows='5'  style='resize:none;border: 1px solid #CFCFCF;width:390px;align:center;'></textarea>"); 

		}
		
		
		</script>
			<div class="content">
				<div class="table-list" style="text-align:center; width:100%; ">
				<table cellSpacing="0"  cellPadding="0" style="text-align:center;table-layout:fixed;width:100%">
						<tr class="tr clearfix">
								<th  width="25%" class="time" align="left" style="padding-left:10px;">词条名称</th>
								<th  width="25%" class="reason">创建人</th>
								<th  width="25%" class="version">提交时间</th>
								<th  width="25%" class="contributor" >操作</th>
						</tr>
							<!-- 循环遍历Entry数据集 -->
						<s:iterator value="datas.datas">
							<tr class="tr clearfix">
								<td class="time"  align="left" style="padding-left:10px;"><a href="#" title='<s:property value="name"/>' onclick='javascript:parent.location.href="<s:url value="/km/baike/entry/doPreview1.action" />?entryId=<s:property value="entryId"/>&contentId=<s:property value="id" />";'><s:property value="entry.name"/></a></td>
								<td class="reason"><s:property value="author.name"/></td>
								<td class="version"><s:date name="submmitTime" format="yyyy-MM-dd HH:mm" /></td>
								<td class="reason">
										<a href='<s:url value="/km/baike/center/doApprove.action" />?contentId=<s:property value="id"/>'><image src='<s:url value="image/ContinueEdit.gif" />'/>通过</a>
										<%-- <a href='<s:url value="/km/baike/center/doReject.action" />?contentId=<s:property value="id"/>'><image src='<s:url value="image/delete.gif" />'/>驳回</a> --%>
										<a onclick="setDialogContent('reasonDialog','<s:property value="id" />');mydialog();">
										<image src='<s:url value="image/delete.gif" />'/>驳回</a>
								</td>
							</tr>
						</s:iterator>
				</table>
				
				<!-- 分页 -->
				<div id="fenye" align="right" style="margin-top:5px;font-size:12px;">
					<a style=" color: #136EC2;" href="<s:url action='doPendingList'> 
							<s:param name="page" value="1" />
							<s:param name="lines" value="datas.linesPerPage" />
							<s:param name="entry.author">fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url>" >首页</a>
					<a style=" color: #136EC2;" href="<s:if test="datas.pageNo>1">
							<s:url action='doPendingList'>
							<s:param name="page" value="datas.pageNo-1" />
							<s:param name="lines" value="datas.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url></s:if><s:else>#</s:else>" >上一页</a> 
					<a style=" color: #136EC2;" href="<s:if test="datas.pageNo<datas.getPageCount()">
							<s:url action='doPendingList'>
							<s:param name="page" value="datas.pageNo+1" />
							<s:param name="lines" value="datas.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>" >下一页</a>
					<a  style=" color: #136EC2;" href="<s:url action='doPendingList'>
							<s:param name="page" value="datas.getPageCount()" />
							<s:param name="lines" value="datas.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							</s:url>" >尾页</a>
						页次：<s:property value="datas.pageNo" />/<s:property value="datas.getPageCount()" />
						页 共<s:property value="datas.rowCount" />条记录 <s:property value="datas.linesPerPage" />条记录/页
						</div>
					</div>
				</div>	
			 </div>


	<!-- 未通过版本 -->
	<div id="content_manager" style="display: none;">
	<div id="mydialog" >
	
	
	</div>
	
		<script>
		function mydialog1(){
			artDialog({
				title:"词条名称/类型修改",
				height: 220,
				width: 350,
				background: '#000',			// 遮罩颜色
				opacity: 0.5,				// 遮罩透明度
				lock: true,
				content : $("#mydialog").html(),
				ok : function() {
				        	$.ajax({
				        		async:false,
				        		url:'<s:url value="/km/baike/entry/doModifyEntryNameAndCategory.action" />',
				        		data:'entryId='+$("#modify_entryId").val() + '&entryName='+$("#modify_entryName").val()+ '&categoryId='+$("#modify_categoryId").val(),
				        		type:"post",
				        		dataType:'html',
				        		success:function(data){
				        			artDialog.close();
				        			window.location=window.location;
				        		},
				        		error:function(data) {
				        			artDialog.close();
				        			alert('修改失败!');
				        		}
				        	});
				},
				cancel : function() {
					artDialog.close();
				},
				okVal: '确定',
				cancelVal : '取消'
			});
		}
		
		function setDialogContent1(divId,entryId,name,categoryId){
			$.ajax({
        		async:false,
        		url:'<s:url value="/km/baike/category/doFindByEntryId.action" />',
        		data: {entryId:entryId},
        		type:"post",
        		dataType:'json',
        		success:function(data){
        			//alert(data['categoryName']);
        			$("#"+divId).html("<div style='margin-left:40px;margin-top:14px;'> "+"<input type='hidden' value='"+entryId+"' id='modify_entryId'>"+
        					"<font size='2px'  >旧名称：</font><input type='text' value='"+name+"' style='width:250px;height:23px;' readonly><br><font size='2px'  >旧词条类型：</font><input type='text' value='"+data["categoryName"]+"' style='width:250px;height:23px;' readonly><br><br><font size='2px'>新名称：</font>"+
        					"<input type='text' id='modify_entryName' value='"+name+"' style='width:250px;height:23px;color:#000000;'><br><font size='2px'>新词条类型：</font>"+
        					"<select id='modify_categoryId'  style='width:257px;height:27px;'><s:iterator value="#request.categories" ><option  value='<s:property value="id"/>'><s:property value="name"/></option></s:iterator></select></div>"); 
        	
        		},
        		error:function(data) {
        			alert('修改失败!');
        		
        		}
        	});
		}
		
		
		</script>
		
		<div style="text-align:center width:100%;">
				<table cellSpacing="0"  cellPadding="0" style="text-align:center; table-layout:fixed;width:100%">
				<tr style="font-size:14px;">
				
				<!-- <th width="80xp;">全选<a onclick="notSelectAll();" style="cursor: pointer;">反选</a></th> -->
					<th  width="25%" align="left" style="padding-left: 10px;">词条名称</th>
					<th  width="25%">创建人</th>
					<th  width="25%">创建时间</th>
					<th  width="25%">操作</th>
				</tr>
				
				<!-- 循环遍历Entry数据集 -->
				<s:iterator  value="entrys.datas">
			<div margin-top: 3px;">
				<tr align="center" height="10px">
				
					<td align="left"><a title='<s:property value="name"/>' onclick='javascript:parent.location.href="<s:url value="/km/baike/entry/doView.action" />?entryId=<s:property value="id"/>";' style="padding-left: 10px;"><s:property value="name"/></a></td>	
					<td><s:property value="author.name"/></td>
					<td><s:date name="created" format="yyyy-MM-dd" /></td>
					<td>
						<a href="javaScript:deleteEntry('<s:property value="id" />')" title="删除"><image src='<s:url value="image/delete.gif" />'/>
						删除</a>
						
						<a onclick="setDialogContent1('mydialog','<s:property value="id" />','<s:property value="name" />','<s:property value="categoryId" />');mydialog1();"><image src='<s:url value="image/submit.gif" />'/>修改</a>
					</td>
				</tr>
			</div>
			</s:iterator>
					
				</table>
				
			</div>
				<div align="right" style="margin-top:5px;font-size:12px;">
					<a href='<s:url action="doGetMyManager"> 
							<s:param name="page" value="1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author">fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url>' >首页</a>
					<a href='<s:if test="entrys.pageNo>1">
							<s:url action='doGetMyManager'>
							<s:param name="page" value="entrys.pageNo-1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>' >上一页</a> 
					<a href='<s:if test="entrys.pageNo<entrys.getPageCount()">
							<s:url action='doGetMyManager'>
							<s:param name="page" value="entrys.pageNo+1" />
							<s:param name="lines" value="entrys.linesPerPage" />
							<s:param name="entry.author" >fasdf</s:param>
							<s:param name="userId" ><s:property value="userId" /></s:param>
							<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
							</s:url></s:if><s:else>#</s:else>' >下一页</a>
					<a href='<s:url action='doGetMyManager'>
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