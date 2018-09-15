<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="cn.myapps.core.deploy.application.action.ApplicationAction"%>
<%@page import="cn.myapps.km.baike.entry.ejb.Entry"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.content.ejb.ReferenceMaterial" %>
<%@ page import="cn.myapps.km.baike.content.ejb.EntryContent" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.EntryProcess" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.EntryProcessBean" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%@ page import="cn.myapps.km.baike.user.ejb.BUser" %>
<%@ page import="java.util.Date" %>
<%@ page import="cn.myapps.km.baike.category.ejb.Category" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcess" %>
<%@ page import="cn.myapps.km.baike.category.ejb.CategoryProcessBean" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcessBean" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestionProcess" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeQuestion" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswer" %>
<%@ page import="cn.myapps.km.baike.knowledge.ejb.KnowledgeAnswerProcessBean" %>

<html>

<link type="text/css" href="css/style.css" rel="stylesheet" />
<head>
<title>词条内容 </title>
    <style>

.table-list .tr {
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

.side { *height:100%; 
		*float:left; 
		*width:200px; 
		*position:relative; 
		*top:0; *right:0; *bottom:0; *left:0;}
.main { *height:100%; *margin-left:200px; *position:relative; *top:0; *right:0; *bottom:0; *left:0;}
.bottom { *height:50px; *margin-bottom:-50px; *position:relative; *top:0; *right:0; *bottom:0; *left:0;}


.title {
    color: #000000;
    font-family: 微软雅黑,黑体,Verdana;
    font-size: 34px;
    font-weight: 500;
    line-height: 34px;
    margin-bottom: 25px;
    padding-top: 22px;
    z-index: 0;
}

.z-catalog {
    background: url('<s:url value="/km/baike/content/images/catelog.png" />') no-repeat scroll 0 0 #FFFFFF;
    margin-bottom: 10px;
    margin-top: 30px;
    overflow: hidden;
    position: relative;
    width: 420px;
    z-index: 0;
}

.z-catalog .hideholder {
    overflow: hidden;
}
.z-catalog dl {
    background: none repeat scroll 0 0 #FFFFFF;
    padding-left: 70px;
}

.tangram-tree dl, dt, dd {
    margin: 0;
    padding: 0;
}

.z-catalog-i1 {
    width: 420px;
}

.z-catalog .catalog-item {
    line-height: 18px;
}
.z-catalog h5 {
    color: #333333;
    margin-bottom: 16px;
    font-family: 微软雅黑,黑体,sans-serif;
    font-size: 24px;
    font-weight: 200;
    letter-spacing: 4px;
    line-height: 22px;
    margin-top: -2px;
    padding: 20px 0 1px 70px;
    width: 95px;
}

.side-box-extend {
    background: none repeat scroll 0 0 #FCFCFC;
    border: 1px solid #E6E6E6;
}
.side-box {
    background-color: #F9F9F9;
    border: 1px solid #DDDDDD;
    margin-bottom: 10px;
    padding: 0 14px 14px;
}
.side-title-extend {
    margin-top: 12px;
}
.side-title {
    color: #5F5F5F;
    font-size: 14px;
    font-weight: bold;
    line-height: 20px;
    margin-bottom: 5px;
    margin-top: 20px;
    padding-bottom: 4px;
}
.side-list-item {
    color: #555555;
    line-height: 22px;
}
.title_2{
	font-family: 微软雅黑,黑体,Verdana;
	font-size: 19px;
	font-weight: 500;
	margin-left:40px;
}
.title_1{
	font-family: 微软雅黑,黑体,Verdana;
	font-size: 24px;
	font-weight: 500
}
.headline-1-index {
	background:url('<s:url value="/km/baike/content/images/bg_title.png" />');
    color: #E9E9E9;
    display: block;
    float: left;
    font-size: 16px;
    height: 24px;
    line-height: 24px;
	margin-top: 10px;
    margin-right: 10px;
    text-align: center;
    width: 24px;
}

.bk_title_body {
    float: right;
}
.bk3-title-wrap {
    background-color: #FDFDFD;
    border: 1px solid #E6E6E6;
    float: left;
    font-size: 12px;
    height: 25px;
    margin-top: 0;
    width: 64px;
}
.bk-editable-lemma-btns {
    background: url('<s:url value="/km/baike/content/images/space.png" />') repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    margin-top: 2px;
}

.text .bk3-title-wrap a {
    line-height: 25px;
    padding-right: 0;
}


a {
    color: #136EC2;
    text-decoration: underline;
}
a {
    text-decoration: none;
}
.bk_title_body .vote_btn {
    background: url("/static/lemma/view3/img/title/btn_bg_e97a70cb.png") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    border: 1px solid #E6E6E6;
    line-height: 25px;
    min-width: 67px;
    width: auto !important;
}
.bk_title_body .vote_btn, .bk_title_body #bdshare {
    color: #888888;
    float: left;
    font-size: 12px;
    height: 25px;
    line-height: 25px;
    margin-left: 8px;
    min-width: 63px;
    text-align: center;
}
.bk_title_body .vote_icon {
    background: url('<s:url value="/km/baike/content/images/vote.png" />') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
    height: 18px;
}
.bk_title_body .bk_share_icon, .bk_title_body .vote_icon {
}
.bk_title_body .bk_share_icon, .bk_title_body .vote_icon {
    display: -moz-inline-stack;
    height: 18px;
    vertical-align: middle;
    width: 16px;
}
.bk_title_body .vote_btn {
    line-height: 25px;
}
.bk_title_body #bdshare {
    background: url('<s:url value="/km/baike/content/images/space.png" />') repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    border: 1px solid #E6E6E6;
    padding: 0 3px;
}
.bk_title_body #bdshare {
    display: -moz-inline-stack;
    text-align: center !important;
}

#bdshare {
    float: left;
    font-size: 12px;
    padding-bottom: 2px;
    text-align: left !important;
    z-index: 999999;
}
#bdshare .bds_more img {
    cursor: default !important;
    float: left;
    padding: 6px 3px 6px 5px;
}
#bdshare img {
    border: 0 none;
    margin: 0;
    padding: 0;
}

.bk_title_body #bdshare .shareCount {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0) !important;
    color: #888888;
    font-family: Arial !important;
    height: 25px;
    line-height: 25px;
    margin: 0;
    min-width: 10px;
    padding: 0;
    text-align: left;
    width: auto !important;
	margin-left:1px;
}
#bdshare a, #bdshare_s a, #bdshare_pop a {
    text-decoration: none;
}
.bds_tools a.shareCount {
    background-position: 0 -30px !important;
    font-size: 12px;
    height: 16px;
    line-height: 16px;
    margin-top: 5px;
    overflow: hidden;
    width: 37px;
}
.bdshare_b a.shareCount, .bds_tools a.shareCount, .bds_tools_32 a.shareCount, .bds_tools_24 a.shareCount {
    background: url("../images/sc.png?cdnversion=20120720") no-repeat scroll 0 0 rgba(0, 0, 0, 0) !important;
    color: #454545;
    float: left;
    font-family: '宋体' !important;
    margin: 0;
    padding: 0 0 0 5px;
    text-align: center;
}
.bds_tools a.shareCount {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0) !important;
    margin: 0;
    padding: 0;
}

	</style>

</head>

<% 
	String entryId = request.getParameter("entryId");
	EntryProcess process = new EntryProcessBean();
	process.doAddBrowserCount(entryId);
%>


<%
	Entry entry = (Entry)ActionContext.getContext().getValueStack().findValue("content");
	session.setAttribute("entry", entry);
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	String userId=entry.getAuthor().getId();
	boolean isOneUser= userId==null || userId.trim().length()<=0 || userId.equals(user.getId());
	//request.setAttribute("entry", entry);
%>
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<script type="text/javascript"> 

/*解析词条内容*/
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
	
	function doVote(entryId){
		<%
			Boolean flag = true;
			NUser nuser = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
			String nuserId = nuser.getId();
			Date voteDate = (Date)application.getAttribute(nuserId+entryId);
			if (voteDate !=null) {
				long startTime =  new Date(voteDate.getYear(), voteDate.getMonth(), voteDate.getDate()+1,0, 0, 0).getTime();
				long endTime = new Date().getTime();
				if (endTime-startTime < 0) {
					flag = false;
				}
			}
		%>
		if (<%=flag%>) {
			var url = '<s:url value="/km/baike/entry/doVote.action" />';
			$.ajax({
				type: "POST",
				url: url,
				data: {entryId:entryId},
				success: function(){
					<%
						if (voteDate==null) {
							application.setAttribute(nuserId+entryId, new Date());
						} else {
							long startTime =  new Date(voteDate.getYear(), voteDate.getMonth(), voteDate.getDate()+1,0, 0, 0).getTime();
							long endTime = new Date().getTime();
							if (endTime-startTime >= 0) {
								application.setAttribute(nuserId+entryId, new Date());
							}
						}
					%>
					location.reload();
				},
				error: function(){alert("投票失败！");}
			});
		}
		
	}

	function doFavorite(entryId){
		var url = '<s:url value="/km/baike/content/doFavorite.action" />';
		$.ajax({
			async:false,
			type: "POST",
			url: url,
			data: {entryId:entryId},
			dataType:'text',
			success: function(data){
				alert(data);
				location.reload();
				//alert("收藏成功！");
			},
			error: function(){alert("收藏失败！");}
		});
	}
	
	
</script>

<body id="baike">
	<div id="wrap" style="min-width:1080px;">
		<%@ include file="/km/baike/entry/baikeHead.jsp"%>
	
		<div id="page"  >
			<div class="edithistory">
				<div id="navbar-collection" class="navbar" style=""><div class="line"></div></div>
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>

		  	<div style='margin-top:22px'>
			</div>
			<div>
            	<div id="content_left" style="float:left;margin-left:20px; width:810px;height=100%;overflow:hidden;" class="bod">
					<div class="bk_title_body">
						<div class="bk-editable-lemma-btns bk3-title-wrap"style="margin-top:0;">
							<img  style="padding-left:8px;margin-top:3px;" src='<s:url value="/km/baike/content/images/edit.png" />'>
							<a id="lemma-edit" style="display: inline;" class="bk-editable-edit" style="color: #888888;" href='<s:url value="/km/baike/content/edit.jsp"  />' >编辑</a>
						
						</div>
						
						<%
						if(isOneUser){
						%>
							<div class="vote_btn vote_btn_1" title="赞一个">
							<a><img style="margin-left:3px;" src='<s:url value="/km/baike/content/images/vote.png" />'>
							<span class="vote_num"><s:property value="content.points" /></a></span>
						</div>
						<%}else{ %>
						<div class="vote_btn vote_btn_1" title="赞一个">
							<a  href="javaScript:doVote('<s:property value="content.entryContent.entryId" />')" ><img style="margin-left:3px;" src='<s:url value="/km/baike/content/images/vote.png" />'>
							<span class="vote_num"><s:property value="content.points" /></a></span>
						</div>
						
						<%} %>
					
						<%
						if(isOneUser){
						%>
						
						<div id="bdshare"  title="点击收藏" class="bdshare_t bds_tools get-codes-bdshare bk_share log-set-param" >
						<span class="bds_more">
							<a ><img  style="margin-left:13px;" src='<s:url value="/km/baike/content/images/share.gif" />'></a>
							<span class="vote_num">	<a id="shareCount" class="shareCount"  style="color: #136EC2;"><s:property value="totalCount" /></a>
						</span>
						</div>
						
						<%}else{ %>
						
						<div id="bdshare"  title="点击收藏" class="bdshare_t bds_tools get-codes-bdshare bk_share log-set-param" >
						<span class="bds_more">
							<a  href="javascript:doFavorite('<s:property value="content.entryContent.entryId" />')";><img  style="margin-left:13px;" src='<s:url value="/km/baike/content/images/share.gif" />'></a>
							<span class="vote_num">	<a id="shareCount" class="shareCount"  style="color: #136EC2;" href="javascript:doFavorite('<s:property value="content.entryContent.entryId" />')";><s:property value="totalCount" /></a>
						</span>
						</div>
						
						<%} %>
					</div>
					<p  class="title"><s:property value="content.name" /></p>
					<div class="xian" style="border-bottom: 1px dashed  #AEC9EA; margin-top: 1px;width:100%"></div>
					<%-- <div style="font: 14px/1.8 arial,宋体,sans-serif;margin-top: 15px;">
						<s:property value="content.entryContent.summary" />
					</div> --%>
					
					<div id="catalog-0" class="z-catalog nslog-area log-set-param" style="" data-subindex="0" data-nslog-type="1016" log-set-param="catalogshow">
						<!-- 目录树 -->	
					</div>
					<!-- 
					<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;width:50%"></div> -->
					
					<!-- 词条内容 -->
					<div style=" font: 14px/1.8 arial,宋体,sans-serif;">	
						<s:property value="content.entryContent.content" escape="false"/>
						
						<!-- 词条内容做处理 -->
		  				<script type="text/javascript">
		  					
		  					/*渲染词条内容*/
		  					var i=1;
		  					$("h1").each(function(index){
		  						$(this).addClass("title_1");
		  						var textHtml = '<span class="headline-1-index">'+ i + '</span>'
		  										+'<span class="firstTitle"><a style="color:#000000" name="title'+i+'">'
		  										+ $(this).text()
		  										+'</a></span>'
		  										+ "<a href= ''><span><img src='<s:url value="/km/baike/content/images/title_edit.png" />'></span></a>";
		  						$(this).html(textHtml);
		  						i++;
		  					});
		  					$("h2").each(function(){
		  						$(this).addClass("title_2");
		  					});
		  					
		  					/*根据内容生成菜单*/
		  					var titles = new Array();
							$("h1, h2").each(function() {
								var title = new Object();
								title.tagName = this.tagName;
								title.text = $(this).text();
								title.subTitles = new Array();
								
								if (title.tagName === "H1") {
									title.text=$(this).find(".firstTitle").text();
									titles.push(title);
								}
								else if (title.tagName === "H2") {
									var parentTitle = titles[titles.length-1];
									parentTitle.subTitles.push(title);
								}
							});
							
							if (titles.length>0) {
								var textHtml = '<h5>目 录</h5><dl id="catalog-holder-0" class="holder hideholder">';
								for(var i=0;i<titles.length;i++) {
									//父标题
									var parentTitle = titles[i];
									textHtml += '<dd class="catalog-item">'
										     + '<p class="z-catalog-i1">'
										     + '<span class="catalog-item-index1 ">'
										     + (i+1)
										     + ' </span><a class="nslog:1274 "  name="STAT_ONCLICK_UNSUBMIT_CATALOG" catalog="true" href="#title'+(i+1)+'">'
										     + parentTitle.text
										     + '</a></p>';
									
									//alert(parentTitle.tagName + ":" +parentTitle.text);
									//alert(parentTitle.subTitles);
									for(var j=0;j<parentTitle.subTitles.length;j++) {
										var subTitle = parentTitle.subTitles[j];
										//alert(subTitle.tagName + ":" + subTitle.text);
										textHtml += '<p style="margin-left:30px;">'
												 + (i+1)+'.'+(j+1)+' '
												 + subTitle.text
												 + '</p>';
									}
									textHtml += '</dd>';
								}
								textHtml += '</dl>';
								$("#catalog-0").html(textHtml);
							}
		  				</script>
				</div>
					
					<div class="xian" style="border-bottom: 1px dashed  #AEC9EA; margin-top: 1px;width:100%"></div>	
				
					
					

				</div>
				<div id="content-right" style="margin-left:880px;margin-right:10px;width:auto;min-width:180px;margin-top:0px;" >
                    <div style="width:100%" class="bod">
                    	<div  class="side-box side-box-extend" style="min-height:180px;">
							<div class="side-title side-title-extend">词条统计</div>
							<div class="side-list-item">浏览次数：<span id="viewPV"><s:property value="content.browseCount" /></span>次</div>
							<div class="side-list-item">编辑次数：<s:property value="content.content.versionNum" />次<a class="nslog:1021" target="_blank" href='<s:url value="/km/baike/content/findHisContent.action" />?entryId=<s:property value="content.id"/>&page=1&lines=2'>历史版本</a></div>
							<div class="side-list-item">最近更新：<span id="lastModifyTime"><s:property value="content.content.saveTime" /></span></div>
							<div class="side-list-item">创建者：<span class="nslog:1022"><a class="usercard" href='<s:url value="/km/baike/center/index.jsp" />?userId=<s:property value="content.author.id" />' 
								target="_blank" username="sarahruirui" title="查看此用户资料"><s:property value="content.author.name" /></a></span>
							</div>
						
						</div>
            		</div>
                    	<div style="width:100%;min-height:40px;">
							<div id="pro-contributors" class="side-box nslog-area side-p side-box-extend" style="min-height:40px;" >
								<dl>
									<div class="side-title side-title-extend" style="margin-bottom:10px;">词条贡献榜</div>
												
											<div class="contri-type" colspan="3"><b>辛勤贡献者：</div>
																								
									<s:iterator value="contributer" > 
											<div class="table-list" >				
						   						
						   						<table class="topuser f12" width="100%" cellspacing="0" cellpadding="0" border="0">
						   							<tr><td width="22"></td><td><a class="usercard" style="font: 13px/1.8 arial,宋体,sans-serif;" target="_blank"  title="查看此用户资料" 
						   							href='<s:url value="/km/baike/center/index.jsp" />?userId=<s:property value="id" />' ><s:property value="name"/></a></td></tr>
						  						</table>
						  					</div>
									</s:iterator>				
								</dl>
							</div>
                    	</div>
				</div>
			</div>
         </div>
	</div>
<div class="bgpagLn" align="center" style="margin-top: 15px;">
		
		
		<div id="footer" class="nslog-area" data-nslog-type="1001" align="center" style="margin-top:300px">
		2013 BaiKe
		<a target="_blank"  >版权所有@天翎网络</a>
		</div>
</div>

</body>
</html>