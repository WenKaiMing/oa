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
var checkedJson = args['checkedJson'];

function doClose(){
	OBPM.dialog.doReturn();
}

function doSaveToMydisk(){
	var obj = eval("(" + checkedJson + ")");

	var _dirSelects = obj._dirSelects;
	var _fileselects = obj._fileselects;

	document.forms[0].action = contextPath + '/km/disk/file/saveToMydisk.action?_dirSelects=' + _dirSelects + "&_fileSelects=" + _fileselects;
	document.forms[0].submit();
}


jQuery(document).ready(function(){
	/* jQuery("#shareTab").tabs({				
		mouseEvent: "click"
	}); */
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
	<div class="public_share" >
		<div class="share_head">
			<img alt="" src="<s:url value="/km/disk/images/warning.gif"/>"/>
			<a>{*[cn.myapps.km.disk.save_to_my_disk_tip]*}</a>
		</div>
		<div class="share_subject">
			<div class="share_sub">
				<div class="share_left"></div>
				<div class="share_center" onclick="doSaveToMydisk()">
					{*[cn.myapps.km.disk.save_to_private_disk]*}
				</div>
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
</s:form>
</body>
</o:MultiLanguage></html>