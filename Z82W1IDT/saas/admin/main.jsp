<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	boolean isSuperAdmin = user.isSuperAdmin();
	boolean isDomainAdmin = user.isDomainAdmin();
	boolean isDeveloper = user.isDeveloper();
	String username = user.getName();
	String contextPath = request.getContextPath();
%>
<o:MultiLanguage>
<html>
<head>
<title>{*[page.title]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
</head>
<script type="text/javascript">
	var contextPath='<%=contextPath%>';
	wy = '600px';
	wx = '650px';

function initCurrentPosition(){
	var obj=window.parent.document;
	obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition2").innerHTML;
	jQuery(".forInitCurrentPosition").click(function(){
		obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition2").innerHTML+">><a target='detail' href='"+jQuery(this).attr("href")+"' title='"+jQuery(this).attr("topage")+"' class='currentPosition'>"+jQuery(this).attr("topage")+"</a>";
		obj.getElementById("currentPosition3").innerHTML=obj.getElementById("currentPosition").innerHTML;
	});
}

	function openHomePage(){
	   jQuery("#detail").attr("src","<s:url value='/saas/admin/detail.jsp'/>"); 
	}
	jQuery(document).ready(function(){
		openHomePage();
		initBodyLayOut();
		setHeightOfIframe();
		initCurrentPosition();
		jQuery(window).resize(function(){
		setHeightOfIframe();
		});
	});

	function logout() {
		if (confirm("{*[core.page.logout.confirm]*}?")) {
			window.location.href = contextPath + '/saas/admin/logout.jsp';
		}
	}
</script>
<body >
<div class="ui-layout-center" id="back_main">
	<div name="header" id="header">
		<table class="table_noborder" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="455" height="41" background='<s:url value="/resource/imgnew/index_01.gif"/>' style="font-weight: bold;align:center;FILTER: glow(color=white,strength=3)dropshadow(color=white,offx=2,offy=1,positive=1)">
					<img style="margin-left:11px;" src='<s:url value="/resource/imgnew/logobanner.gif" />' alt="Teemlink Web Technology" />
				</td>
				<td style="padding-top: 1px;">&nbsp;</td>
				<td width="250" align="right" background='<s:url value="/resource/imgnew/index_03.gif"/>' />&nbsp;</td>
				<td align="right" width="236"  background='<s:url value="/resource/imgnew/index_04.gif"/>'>
					<div class="margin_r" style="margin-right: 3px;">
						<span style="cursor: pointer;">&nbsp;<a title="{*[Home]*}" style="font-weight: normal; color:black;" onclick="openHomePage()">{*[Home]*}</a></span> 
						<span>&nbsp;<a title="{*[Logout]*}" style="font-weight: normal; color:black;" href="javascript:logout();">{*[Logout]*}</a></span>
						<span style="cursor: pointer;">&nbsp;<a id="helpLink" title="{*[Help]*}" onclick="closeHelp()" style="font-weight: normal; color:black;">{*[Help]*}</a></span>
					</div>
				</td>
			</tr>
		</table>
		<table border="0" width="100%" style='height: 22px; background-color: #9EA4A9; font-family: Arial, Helvetica; font-size: 12px; background-image: none; color: #FFFFFF;'>
			<tr>
				<td colspan="2" style="padding-left: 11px;">
					<div style="padding-top: 2px;vertical-align: middle;float: left;">{*[Hello]*}, <span id="username"><%=username%></span> <a target="detail"
						title="Edit Profile" class="nav_table_edit" target="main"
						href="<s:url value='/saas/admin/superuser/editPersonal.action'><s:param name='editPersonalId' value='#session["USER"].id'/></s:url>" style="color: #FFFFFF">
						[{*[Edit]*}]</a>
					</div>
					<div style="margin-left: 20px;float: left;text-align: left;">
					<div class="currentPosition" id="currentPosition">{*[Location]*}：>>
					<a onclick="openHomePage()" class="currentPosition">{*[Home]*}</a></div>
					
					<div class="currentPosition" id="currentPosition2" style="display: none">{*[Location]*}：>>
					<a onclick="openHomePage()" class="currentPosition">{*[Home]*}</a></div>
					
					<div class="currentPosition" id="currentPosition3" style="display: none"></div>
					<div id="currentPosition3" class="currentPosition" style="display: none"></div>
					</div>
				</td>
				<td class="margin_r">
				</td>
			</tr>
		</table>
	</div>
	<iframe name="detail" id="detail" width="100%" style="height: 600px;overflow: hidden;" src="<s:url value='/saas/admin/detail.jsp' />" align="top" scrolling="no" frameborder="0"></iframe>
</div>

<%@include file="/common/right_help.jsp"%>
</body>
<script type="text/javascript">
	/*调整iframe合适的高度*/
	function setHeightOfIframe(){
		//jQuery("#detail").css("height",jQuery(".ui-layout-east").height()-jQuery("#header").height()-2);
		jQuery("#detail").css("height",jQuery("body").height()-jQuery("#header").height());
	}
</script>
</html>
</o:MultiLanguage>
