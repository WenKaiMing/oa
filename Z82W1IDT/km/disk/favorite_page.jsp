<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script type="text/javascript">
var args = OBPM.dialog.getArgs();
var fileId = args['fileId'];

function doClose(){
	OBPM.dialog.doReturn();
}

function doFavorite(){
	jQuery("#share_div").removeAttr("onClick");
	document.forms[0].action = contextPath + '/km/disk/file/favorite.action?_fileId=' + fileId;
	document.forms[0].submit();
}
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
						<a>{*[cn.myapps.km.disk.favorite_tip]*}</a>
					</div>
					<div class="share_subject">
						<div class="share_sub">
							<div class="share_left"></div>
							<s:if test="!_favorited">
							<div id="share_div" class="share_center" onclick="doFavorite()">
								{*[cn.myapps.km.disk.favorite]*}
							</div>
							</s:if>
							<s:else>
							<div id="share_div" class="btnCenter" style="cursor:default;text-align:center;">
								<a style="color:#ccc;">{*[cn.myapps.km.disk.favorite]*}</a>
							</div>
							</s:else>
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
		</ul>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>