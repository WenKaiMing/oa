<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.km.disk.ejb.NFileHelper" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%@ include file="/km/disk/head.jsp"%>
<%
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	String sharefileid = request.getParameter("sharefileid");
	String shareType = request.getParameter("shareType");
	if(sharefileid == null || sharefileid == ""){
		sharefileid = (String)request.getAttribute("sharefileid");
	}
	NFileHelper helper = new NFileHelper();
	boolean isShared = helper.isSharedInPublic(sharefileid, user);
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script type="text/javascript" src='<s:url value="/km/disk/script/share.js"/>'></script>
<script type="text/javascript">
var shareType = '<%=shareType%>';

function doClose(){
	OBPM.dialog.doReturn();
}

function doShare(){
	
	var _fileselects = '<%=sharefileid %>';

	$.ajax({
		url: contextPath + "/km/disk/file/share.action?_fileSelects=" + _fileselects + "&shareType=public",
		async: false,
		cache:false,
		success: function(){
			$(".share_head").find("a").text("您的文件分享成功");
			var $center = $(".share_subject").find("share_center");
			$center.removeAttr("onclick").css({"color":"#ccc","cursor":"default"});
		}
	})

	/* document.forms[0].action = contextPath + "/km/disk/file/share.action?_fileSelects=" + _fileselects + "&shareType=public";
	document.forms[0].submit(); */
}

var shareLock = true;
function doShareToPersonal(){
	if(shareLock){
		var userids = document.getElementById("userHidden").value;
		if(userids == ""){
			showMessage("error", "{*[cn.myapps.km.disk.select_user_tip]*}");
			return;
		}
		
		shareLock = false;
		var _fileselects = '<%=sharefileid %>';
		
		document.forms[0].action = contextPath + "/km/disk/file/share.action?_fileSelects=" + _fileselects + "&shareType=personal";
		document.forms[0].submit();
	}
}

(function($){
	$.fn.tabs = function(options){
		//默认值
		var defaults = {
			mouseEvent: "click"
		}
		var options = $.extend({}, $.fn.tabs.defaults, options);
		
		var tit = $(this).find(".shareTab_title .tt_li");
		var cont = $(this).find(".shareTab_content .tc_li");
		if(options.mouseEvent == "click"){
			tit.each(function(i){
				$(this).bind({
					"click":function(){
						THIS = $(this);
						hovertime = setTimeout(function(){
							THIS.addClass("active");
							THIS.siblings().removeClass("active");
							cont.eq(i).css("display","block");
							cont.eq(i).siblings().css("display","none");
						},200)
					}
				});				  
			})	
		}
	}
})(jQuery);
jQuery(document).ready(function(){
	if(shareType){
		if(shareType == 'personal'){
			jQuery(this).find(".public_tt_li").removeClass("active");
			jQuery(this).find(".personal_tt_li").addClass("active");

			jQuery(this).find(".public_tc_li").css("display","none");
			jQuery(this).find(".personal_tc_li").css("display","block");
		}
	}
	
	jQuery("#shareTab").tabs({				
		mouseEvent: "click"
	});
	jQuery("#clearUser").click(function(){
		jQuery("#userInput").attr("title","");
		jQuery("#userInput").val("");
		jQuery("#userHidden").val("");
	});

});
</script>
</head>
<body class="share_body">
<s:form action="" method="post" theme="simple">
<%@include file="/common/msg.jsp"%>
	
	<div class="shareTab" id="shareTab">
		<ul class="shareTab_title clearfix">
			<li class="tt_li public_tt_li active"><span><a href="javascript:void(0);">{*[cn.myapps.km.disk.public_share]*}</a></span></li>
			<li class="tt_li personal_tt_li"><span><a href="javascript:void(0);">{*[cn.myapps.km.disk.private_share]*}</a></span></li>
		</ul>
		<ul class="shareTab_content">
			<li class="tc_li public_tc_li">
				<div class="public_share" >
					<div class="share_head">
						<img alt="" src="<s:url value="/km/disk/images/warning.gif"/>"/>
						<%if(isShared){ %>
								<a>{*[cn.myapps.km.disk.share_error]*}</a>
							<%}else{ %>
								<a>{*[cn.myapps.km.disk.share_tip]*}</a>
							<%} %>
					</div>
					<div class="share_subject">
						<div class="share_sub">
							<div class="share_left"></div>
							<%if(isShared){ %>
								<div class="share_center" style="color:#ccc;cursor:default;">
									{*[cn.myapps.km.disk.open_sharing]*}
								</div>
							<%}else{ %>
								<div class="share_center" onclick="doShare()">
									{*[cn.myapps.km.disk.open_sharing]*}
								</div>
							<%} %>
							<div class="share_right">
							</div>
						</div>
					</div>
					<div class="close_sub">
						<div class="close_left"></div>
						<div class="close_center" onclick="doClose()">{*[cn.myapps.km.disk.close]*}</div>
						<div class="close_right"></div>
					</div>
					<div class="clear"></div>
				</div>
			</li>
			<li class="tc_li personal_tc_li" style="display: none;">
				<div class="private_share" >
					<div class="user_select">
						<input type="hidden" id="userHidden"  name="userids" />
						<input type="text" id="userInput" name="用户选择" title="" value="" readonly/> 
						<span onclick="selectUser4Km('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')" title="{*[cn.myapps.km.disk.select_user]*}">{*[cn.myapps.km.disk.select_user]*}</span>
						<span id="clearUser" title="{*[Clear]*}">{*[Clear]*}</span>
					</div>
					<div class="btn_confirm">
						<div class="confirm_left"></div>
						<div class="confirm_center" onclick="doShareToPersonal()">{*[cn.myapps.km.disk.confirm]*}</div>
						<div class="confirm_right"></div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</li>
		</ul>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>