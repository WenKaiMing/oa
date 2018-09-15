<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[core.email.folder.add]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/portal/share/email/css/email.css'/>" type="text/css">
<%@include file="jquery-tabs.jsp" %>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery("#saveButton").click(function(){
		jQuery.ajax({
			type: "POST",
			cache: false,
			url: "<s:url value='/portal/email/folder/save.action' />",
			data: decodeURIComponent(jQuery("form").serialize()),
			success:function(result) {
				var strs = result.split("::");
				alert(strs[1]);
				if (strs[0] == "INFO") {
					OBPM.dialog.doReturn();
				} else if (strs[0] == "ERROR") {
				}
			},
			error: function(error) {
				alert(error);
			}
		});
	});
	jQuery("#cancelButton").click(function(){
		OBPM.dialog.doReturn();
	});
});
</script>
</head>
<body style="background: #ffffff;">
<div class="content">
	<div class="bar">
		<input type="button" name="" value="&nbsp;{*[Save]*}&nbsp;" id="saveButton" />
		<input type="button" name="" value="&nbsp;{*[Cancel]*}&nbsp;" id="cancelButton" />
	</div>
	<div class="main">
		<form action="" method="post">
			<input type="hidden" name="content.id" id="folderid" value="<s:property value="content.id" />"></input>
			<input type="hidden" name="content.ownerId" value="<s:property value="content.ownerId" />"></input>
			<input type="hidden" name="content.createDate" value="<s:property value="content.createDate" />"></input>
			<input type="hidden" name="userid" value="userid=<s:property value='#session.FRONT_USER.emailUser.id' />" />
			<table bgcolor="#ffffff" width="100%">
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td width="16%">{*[core.email.folder.name]*}：</td>
					<td align="left"><input type="text" name="content.name" value="<s:property value="content.name" />" /></td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</o:MultiLanguage></html>