<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import = "cn.myapps.core.email.email.ejb.EmailUserProcessBean,cn.myapps.core.email.email.ejb.EmailUser" %>
<%@page import="cn.myapps.core.email.util.EmailConfig"%><html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[Setup]*} {*[core.email.user.setting]*}</title>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/email/script/jquery.corner.js'/>"></script>
<link href="<s:url value='/resource/css/main-front.css'/>" type="text/css" rel="stylesheet"></link>
<style type="text/css">
.divCss {
	width: 600px;
	height: 400px;
	background: #EEF0F2;
	border: 4px solid #EEF0F2;
	margin-top: 100px;
}
.divCss .title {
	width: 600px;
	height: 40px;
	background: #EEF0F2;
	text-align: left;
}
.divCss .title span {
	text-align: left;
	margin: 12px 10px;
	font-weight: bold;
	font-size: 14px;
	position: absolute;
}
.divCss .content {
	width: 592px;
	height: 356px;
	
	background: #ffffff;
}
</style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		
		//jQuery('.divCss').corner("10px");
			jQuery('.divCss').corner("top");
			var height = jQuery(window).height();
			var pHeight = (height - jQuery('.divCss').height()) / 2;
			jQuery('.divCss').css("margin-top", pHeight + 'px');

			var error = jQuery("#error").html();
			if (error != "") {
				alert(error);
			}
			
		});
	jQuery(window).resize(function() {
		var height = jQuery(window).height();
		var pHeight = (height - jQuery('.divCss').height()) / 2;
		jQuery('.divCss').css("margin-top", pHeight + 'px');
	});

	function doExit() {
		parent.frames['detail'].location.href = "<s:url value='/portal/share/welcome.jsp'/>";
	}
	function doCheck() {
		jQuery.ajax({
			type: "POST",
			cache: false,
			url: "<s:url value='/portal/email/user/save.action'/>",
			data: decodeURIComponent(jQuery('#mailForm').serialize()),
			success:function(result) {
				if (result == "success") {
					
				} else if (result == "error") {
					
				}
			},
			error: function(result) {
				alert("{*[page.obj.dofailure]*}");
			}
		});
	}
</script>
</head>
<body style="overflow: auto;">
<form action="<s:url value='/portal/email/user/save.action'/>" id="mailForm" method="post">
<center>
	<div class="divCss">
		<div class="title"><span>{*[Setup]*} {*[core.email.user.setting]*}</span></div>
		<div class="content">
			<input type="hidden" name="content.id" value="<s:property value="content.id"/>" />
			<input type="hidden" name="content.ownerid" value="<s:property value="#session.FRONT_USER.id"/>" />
			<input type="hidden" name="content.name" value="<s:property value="#session.FRONT_USER.name"/>" />
			
			<%WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER); 
			String domainid = webUser.getDomainid();
			String userId = webUser.getId();
			EmailUserProcessBean eupb =new EmailUserProcessBean(); 
			EmailUser  emailUser = eupb.getEmailUserByOwner(userId,domainid);
			if(emailUser==null) emailUser = new EmailUser();%>
			
			<table style="padding-top: 90px;">
				<tr>
					<td>{*[core.email.user.account]*}：</td>
					<td><input type="text" name="content.account" id ="content.account"  value="<%=emailUser.getAccount()%>"/> </td>
					<td>@<%=EmailConfig.getEmailDomain() %></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>{*[core.email.user.pwd]*}：</td>
					<td><input type="password" name="content.password" id="content.password" value="<%=emailUser.getPassword()%>"/> </td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</table>
			<div style="margin-top: 40px;">
				<input type="submit" value="&nbsp;{*[Save]*}&nbsp;" />&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="&nbsp;{*[Exit]*}&nbsp;" onclick="doExit();" />
			</div>
		</div>
	</div>
</center>
</form>
<span id="error" style="display: none;"><s:if test="hasFieldErrors()"><s:iterator value="fieldErrors">*<s:property value="value[0]" /></s:iterator></s:if></span>
</body>
</o:MultiLanguage></html>