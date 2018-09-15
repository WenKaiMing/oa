<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.EntryProcessBean" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.EntryProcess" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%@ page import="cn.myapps.km.baike.user.ejb.BUser" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswer" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswerProcessBean" %>
<%
NUser kmUser = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
boolean isPublicDiskAdmin = kmUser.isPublicDiskAdmin();
String userId=request.getParameter("userId");
boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(kmUser.getId());
%>

<%
	//获取参数：选中菜单
	String selectedMenu = request.getParameter("selectedMenu");
%>

<html>
<link type="text/css" href="css/styleitem.css" rel="stylesheet" />
<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<title>个人中心 </title>
<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>
<script type="text/javascript">

	function init() {
		var menuId = '<s:property value="selectedMenu" />';
		
		if (menuId == null || menuId=='' || menu=='null') {
			menuId = '<%=selectedMenu%>';
		}
		
		var newId = menuId.substring(5, menuId.length);
		$("#"+newId).show().siblings().hide();
		var $curMenu = $("#"+menuId);
		//replaceWith()替换  find() 查找子节点
		$curMenu.find("a").replaceWith("<p>"+$curMenu.find("a").html()+"</p>");
		//.parent().find先找父节点,再找子节点
		var selected = $curMenu.parent().find(".selected");
		//调用方法,传入点击li的id
		selected.find("p").replaceWith("<a href='javascript:void(0);'>"+selected.find("p").html()+"</a>");
		$curMenu.addClass("selected").siblings().removeClass("selected");
		
		//初始化当前用户属性
		var $val_iframe = $("#"+newId).find("iframe");
		
		if (menuId == null || menuId=='' || menuId=='null') {
			$("#mycenter").find("iframe").attr('src','<s:url value="/km/baike/center/doGetMyInfo.action" />?userId=<%=userId %>');
		}
		
		if (newId.indexOf("mycenter") >= 0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyInfo.action" />?userId=<%=userId %>');
			//词条贡献
		} else if (newId.indexOf("myentryatrribute")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyContribution.action" />?userId=<%=userId %>');
			//未通过版本
		}else if (newId.indexOf("mynotthroughversion")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doNotThroughVersion.action" />?userId=<%=userId %>');
			//我的收藏
		} else if (newId.indexOf("myfavorite")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyFavorites.action" />?userId=<%=userId %>');
			//浏览记录
		}else if (newId.indexOf("myshared")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/history/queryByUserId.action" />?userId=<%=userId %>');
			//我的词条(根据词条里面的作者查询)
		}else if (newId.indexOf("myentry")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyEntry.action" />?userId=<%=userId %>');
			//草稿箱
		}else if (newId.indexOf("mydrafts")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyDraft.action" />');
			//词条审核
		}else if (newId.indexOf("myaudit")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doPendingList.action" />');
			//词条管理
		}else if (newId.indexOf("mymanager")>=0) {
			$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyManager.action" />');
		}
		
		//如果是km管理员
		if (<%=isPublicDiskAdmin%>==true) {
			$("#menu_myaudit").show();
		} else {
			$("#menu_myaudit").hide();
		}
		if (<%=isPublicDiskAdmin%>==true) {
			$("#menu_mymanager").show();
		} else {
			$("#menu_mymanager").hide();
		}
		if(!<%=isOneUser%>){
			$("#menu_mydrafts").hide();
			$("#menu_myentry").hide();
			$("#menu_myfavorite").hide();
			$("#menu_mymanager").hide();
			$("#menu_myaudit").hide();
		}
		
		
	} 
	
</script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	});
	
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
	function createEntry(){
		location.href='<s:url value="/km/baike/content/addEntry.jsp" />';
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
</script>



<script language="javascript">
	$(document).ready(function(){
		init();
		//设置菜单的点击事件
		$(".menu li").each(function(){
			$(this).click(function(){
				if ($(this).attr("class").indexOf("selected")<0) {
					
					var id = $(this).attr("id");
					var newId = id.substring(5, id.length);
					//siblings()寻找兄弟节点
					$("#"+newId).show().siblings().hide();
					//replaceWith()替换  find() 查找子节点
					$(this).find("a").replaceWith("<p>"+$(this).find("a").html()+"</p>");
					//.parent().find先找父节点,再找子节点
					var selected = $(this).parent().find(".selected");
					
					//调用方法,传入点击li的id
					selected.find("p").replaceWith("<a href='javascript:void(0);'>"+selected.find("p").html()+"</a>");
					$(this).addClass("selected").siblings().removeClass("selected");
					
					//菜单对应的iframe
					var $val_iframe = $("#"+newId).find("iframe");
					
						//个人中心
					if (newId.indexOf("mycenter") >= 0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyInfo.action" />?userId=<%=userId %>');
						//词条贡献
					} else if (newId.indexOf("myentryatrribute")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyContribution.action" />?userId=<%=userId %>');
						//未通过版本
					}else if (newId.indexOf("mynotthroughversion")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doNotThroughVersion.action" />?userId=<%=userId %>');
						//我的收藏
					} else if (newId.indexOf("myfavorite")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyFavorites.action" />?userId=<%=userId %>');
						//我的词条
					}else if (newId.indexOf("myentry")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyEntry.action" />?userId=<%=userId %>');
						//草稿箱
					}else if (newId.indexOf("mydrafts")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyDraft.action" />');
						//词条审核
					}else if (newId.indexOf("myaudit")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doPendingList.action" />');
						//词条管理
					}else if (newId.indexOf("mymanager")>=0) {
						$val_iframe.attr('src','<s:url value="/km/baike/center/doGetMyManager.action" />');
					}
				}
			});
		});
	});
</script>
<style>

#wrap {
    margin: 0 auto;
    width: 90%;
}

#logo, #search-content, #help {
    float: left;
}
#view, #wrap {
    padding-top: 1px;
}

.edithistory {
    min-width: 1000px;
}
	#header {
    margin-top: 26px;
    }

	#logo img {
    display: block;
}
img {
}
fieldset, img {
    border: 0 none;
}

.title h2 {
    float: left;
    font-size: 24px;
    line-height: 60px;
}
h1, h2, h3, h4, h5, h6 {
    font-size: 100%;
}

.title span {
    color: #333333;
    float: left;
    padding: 25px 0 0 8px;
}



.tab {
    border-bottom: 1px solid #AEC9EA;
    position: relative;
}

.tab li {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-color: #E7ECF0 #E7ECF0 -moz-use-text-color;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 1px 0;
    color: #136EC2;
    float: left;
    font-size: 14px;
    line-height: 30px;
    margin: 0 0 0 -1px;
    padding: 0 14px 0 15px;
}

.tab li.on {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-image: none;
    border-style: solid solid none;
    border-width: 0 0 0 0;
    color: #000000;
    font-weight: bold;
    margin: 0 0 0 0;
    padding-bottom: 2px;
    position: relative;
}

.table-head .time {
    width: 25%;
}


.table-head .version {
    width: 25%;
}

.table-head .contributor {
    width: 25%;
}
.reason {
    width: 25%;
    word-break: break-all;
}


.table-list .tr {
    border-bottom: 1px solid #ECECEC;
    line-height: 28px;
}
.table-head  {
    border-bottom: 1px solid #665666;
	margin-right:30px;
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
}

<!---->
.table-list .tr .time {
    
    width: 25%;
}
.table-list .tr .version {
    font-size: 14px;
    width: 25%;
}
.table-list .tr .contributor {
    font-size: 14px;
    overflow: hidden;
    width: 25%;
}
.table-list .tr .reason {
    font-size: 14px;
    width: 25%;
    word-break: break-all;
}

.table-head li {
    color: #333333;
    float: left;
    font-size: 14px;
    font-weight: bold;
}
ul, li {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

body, button, input, select, textarea {
    font: 12px/1.5 arial,锟斤拷锟斤拷,sans-serif;
}
.back {
    float: right;
    line-height: 28px;
}

#search {
    margin-bottom: 15px;
    position: relative;
    width: 900px;
    z-index: 2;
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

.page {
    font-size: 14px;
    line-height: 18px;
    text-align: center;
}


h1, h2, h3, h4, h5, h6 {
    font-size: 100%;
}

* {
    margin: 0;
    padding: 0;
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
    font-size: 14px;
    line-height: 128px;
    text-align: center;
}

.side { *height:100%; 
		*float:left; 
		*width:200px; 
		*position:relative; 
		*top:0; *right:0; *bottom:0; *left:0;}
.main { *height:100%; *margin-left:200px; *position:relative; *top:0; *right:0; *bottom:0; *left:0;}
.bottom { *height:50px; *margin-bottom:-50px; *position:relative; *top:0; *right:0; *bottom:0; *left:0;}




.col-left .menu li {
    height: 26px;
    padding: 10px 0 0 17px;
}

.col-left li.selected {
    height: 38px;
    padding: 0;
    position: relative;
}

ul, li {
    list-style-type: none;
    margin: 0;
    padding: 0;
}
.col-left {
	margin-right:5px;
    font-size: 14px;
}
body, button, input, select, textarea {
    font: 12px/1.5 arial,锟斤拷锟斤拷,sans-serif;
}

.col-left li.effort-sel span {
    background-position: -25px -122px;
}
.col-left li.selected span {
    cursor: default;
}
 
.col-left li.selected p {
    font-weight: bold;
}

.col-left li.myscore span {
    background-position: -5px -184px;
}

.col-left li.myscore a:hover span {
    background-position: -50px -184px;
}


.col-left .menu li a {
    color: #FFFFFF;
    display: inline-block;
}
a {
    color: #00488D;
}
a {
    text-decoration: none;
}

.col-left li.mybaike a  span {
    background-position: -50px -96px;
}

.col-left li.effort-sel span {
    background-position: -25px -122px;
}

	.hidden {display:none}
	.selected {display:block}
	
	

.col-left .menu {
    background: url('<s:url value="/km/baike/center/image/gray.png" />') repeat-x scroll 0 -227px #022C5D;
    margin-bottom: 8px;
    padding: 10px 0;
    width: 170px;
}

#search .s_btn {
    background: url('<s:url value="/km/baike/center/image/btn_search.png" />') repeat scroll 0 0 #DDDDDD;
    border: 0 none;
    cursor: pointer;
    font-size: 14px;
    height: 32px;
    padding: 0;
    width: 95px;
}

#search .s_ipt_wr {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: url('<s:url value="/km/baike/center/image/btn_search.png" />') no-repeat scroll -304px 0 rgba(0, 0, 0, 0);
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

.col-left li.selected p {
    background: url('<s:url value="/km/baike/center/image/controls.png" />');
    font-weight: bold;
    height: 30px;
    left: -5px;
    overflow: hidden;
    padding: 8px 0 0 15px;
    position: absolute;
    width: 160px;
}

.col-left .menu li span {
    background: url('<s:url value="/km/baike/center/image/controls.png" />') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
    cursor: pointer;
    padding: 1px 10px;
}

</style>

</head>
<body id="baike">

	<div id="wrap">
		<div id="userbar" style="min-width:770px;">
			<ul>
				<li>
				
					<%
						if(isOneUser){
					%>
					<a class="nslog:87" href='<s:url value="/km/baike/entry/doInit.action" />'>百科首页|</a><a class="nslog:87" href='<s:url value="/km/baike/entry/pointRule.jsp" />'>积分规则</a>
					
					<%}else{ %>
					
					<%} %>
			
				</li>
			</ul>
		</div>
		<div id="header">
			<form action='<s:url value="/km/baike/entry/doAccess.action" />' method="post">
				<div id="search" class="clearfix">
					<div id="logo">
						<img class="nslog:1008" width="287" height="40" border="0" alt="到百科首页" src='<s:url value="/km/baike/entry/images/logo.png" />'>
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
		
		<div id="page"  >
			<div class="edithistory">
				<div id="navbar-collection" class="navbar" style=""><div class="line"></div></div>
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>
			
		  	<div style='margin-top:22px'>
            		<div style="float:left; width:170px;" class="bod">
						<div class="col-left">
							<!-- 隐藏域  存放当前点击菜单ID -->
							
							
							<ul class="menu" style="margin:0px;padding:0px">
								<li class="mybaike selected" id="menu_mycenter">
									<p><span></span>我的积分</p>
								</li>
								
								<li class="mybaike" id="menu_myentryatrribute">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>审批状态</a>
								</li>
									
								<li class="mybaike" id="menu_mydrafts">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>草稿箱</a>
								</li>
								
								
								<li class="mybaike" id="menu_myfavorite">
									<a onclick="javascript:void(0);" hidefocus="true" cursor="hand"><span></span>我的收藏</a>
								</li>
								
								
								<li class="mybaike" id="menu_myaudit">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>词条审核</a>
								</li>
								
								<!-- <li class="mybaike" id="menu_mymanager">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>词条管理</a>
								</li> -->
								
								<!-- <li class="mybaike" id="menu_myshared">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>浏览记录</a>
								</li> -->
								
								<!-- <li class="mybaike" id="menu_myentry">
									<a onclick="javascript:void(0);" hidefocus="true"><span></span>我的词条</a>
								</li> -->
							</ul>
						</div>
					</div>
                    
					<div style="margin-left:190px; min-width:581px;" >
					<!-- 个人中心 -->
				   	<div id="mycenter" style="float:right; width:100%;height:400px; " class="selectd">
						<iframe src='<s:url value="/km/baike/center/myCenter.jsp" />' width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
                    </div>
						
					<!-- 词条贡献 -->
					<div id="myentryatrribute" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myContribution.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
                    </div>
                    
                    <!-- 我的收藏-->
					<div id="myfavorite" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myFavarite.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
                    </div>
                    
					
					<!-- 浏览记录 -->
				<%-- 	<div id="myshared" style="float:right; width:100%;height:400px; " class="hidden">
							<iframe src='<s:url value="/km/baike/center/myShare.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
					</div>
				 --%>
				
					<!-- 我的词条 -->
				   	<div id="myentry" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myEntry.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
                    </div>
				
					<!-- 草稿箱 -->
					<div id="mydrafts" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myDrafts.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
					</div>
						
						
					<!-- 词条审核  -->
					<div id="myaudit" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myAudit.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
					</div>
					
					<!-- 词条管理  -->
					<div id="mymanager" style="float:right; width:100%;height:400px; " class="hidden">
						<iframe src='<s:url value="/km/baike/center/myManager.jsp" />'  width="100%" height="400px" frameborder="0" scrolling="no">
						</iframe>
					</div>
				</div> 
				
           </div>
		</div>

	<div class="bgpagLn" align="center">
		<div id="footer" class="nslog-area" data-nslog-type="1001"  style="margin-top: 400px;">
			2013 BaiKe
			<a target="_blank" >版权所有@天翎网络</a>
		</div>
	</div>
</div>
	</body>
</html>