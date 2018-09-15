<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script type="text/javascript" src='<s:url value="/km/disk/script/share.js"/>'></script>
<script type="text/javascript">
var args = OBPM.dialog.getArgs();
var fileId = args['fileId'];

function doClose(){
	OBPM.dialog.doReturn();
}

function doRecommend(){
	jQuery(".confirm_center").removeAttr("onClick");
	document.forms[0].action = contextPath + '/km/disk/file/recommend.action?_fileId=' + fileId;
	document.forms[0].submit();
}

jQuery(document).ready(function(){
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
		<ul class="">
			<li class="tc_li">
				<div class="public_share" >
					<div class="share_head">
						<img alt="" src="<s:url value="/km/disk/images/warning.gif"/>"/>
						<a>{*[cn.myapps.km.disk.recommend_tip]*}</a>
					</div>
					<div class="share_subject">
						<div class="user_select">
							<input type="hidden" id="userHidden"  name="userids" />
							<input type="text" id="userInput" name="用户选择" title="" value="" readonly/> 
							<span onclick="selectUser4Km('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')" title="{*[cn.myapps.km.disk.select_user]*}">{*[cn.myapps.km.disk.select_user]*}</span>
							<span id="clearUser" title="{*[Clear]*}">{*[Clear]*}</span>
						</div>
						<div class="btn_confirm">
							<div class="confirm_left"></div>
							<div class="confirm_center" onclick="doRecommend()">{*[cn.myapps.km.disk.confirm]*}</div>
							<div class="confirm_right"></div>
							<div class="clear"></div>
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
		</ul>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>