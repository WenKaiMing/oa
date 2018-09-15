<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<% 	
	String url = EmailUserHelper.checkLogin(request, response);
	if (url != null) {request.getRequestDispatcher(url).forward(request, response); return;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="cn.myapps.core.email.email.action.EmailUserHelper"%><html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/email/script/loading.js'/>"></script>
<link href="<s:url value='/portal/share/email/css/globle_v1.css'/>" type="text/css" rel="stylesheet">
<link href="<s:url value='/portal/share/email/css/skin_blue.css'/>" rel="stylesheet" type="text/css" id="lnkSkin">
<title>{*[E-mail]*}</title>
<style type="text/css">
a {
	hide-focus: expression(this.hideFocus=true); /* for ie 5+ */
	outline: none; /* for firefox 1.5 + */
	/*去除点击虚线框*/  
}

#leftMenu {
	/* border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #80AB73;*/
	clear: both;
}

#leftMenu ul {
	margin-right: 10px;
	margin-left: 10px;
	/*background-image: url(images/mun_bg.gif);*/
	background-repeat: no-repeat;
	margin-top: 0px;
}

#leftMenuPic {
	position: absolute;
	clear: both;
}

#leftMenu li {
	font-size: 12px;
	line-height: 30px;
	padding-left: 30px;
	cursor: pointer;
}
#ulDefFolder {
	overflow: auto;
}

#ulDefFolder li {
	font-size: 12px;
	line-height: 30px;
	padding-left: 30px;
	cursor: pointer;
}
.button1 {
	background: transparent;
	margin-left : 10px;
	border-width: 0px;
	width: 80px;
	height: 34px;
	cursor: pointer;
	hide-focus: expression(this.hideFocus=true);
}
</style>
<script type="text/javascript">

	//var loading = '<s:url value='/portal/share/email/images/loading2.gif'/>';

	window.onload = function() {
		hideLoading();
		setFolderClickEvent();

		jQuery("#inboxid").click(function () {
			showLoading();
			var folderid = '<s:property value="#folderHelper.getInboxEmailFolderId()" />';
			jQuery("#emailFrame").attr("src", "<s:url value='/portal/email/list.action'/>?folderid=" + folderid + "&type=0");
		});
		jQuery("#wrieid").click(function () {
			showLoading();
			jQuery("#emailFrame").attr("src", "<s:url value='/portal/share/email/input.jsp'/>");
		});
		jQuery("#person").click(function () {
			showLoading();
			jQuery("#emailFrame").attr("src", "<s:url value='/portal/email/folder/list.action'/>?userid=<s:property value='#session.FRONT_USER.emailUser.id' />");
		});

		jQuery("#ico").click(function () {
			var div = document.getElementById("dvDefinedFolder");
			var ico = document.getElementById("ico");
			var dis= div.style.display;
			if (dis == "none") {
				div.style.display = "";
				ico.className = "icoOpCls icoOpen";
			} else {
				div.style.display = "none";
				ico.className = "icoOpCls icoClose";
			}
		});
		
	};
	
	jQuery(document).ready(function(){resetSize();});

	// 窗口大小改变时
	jQuery(window).resize(function(){resetSize();});

	function resetSize() {
		var clientH = jQuery(window).height();
		var clientW = jQuery(window).width();
		//alert(clientH);
		var leftWidth = jQuery(".leftBg").width();
		var mainContentWidth = clientW - leftWidth - 2;
		var footerHeight = clientH;
		
		jQuery("#mainContent").css("width", mainContentWidth + "px");
		jQuery("#mainContent").css("height", footerHeight + "px");

		jQuery("#emailFrame").css("width", jQuery("#mainContent").width());
		jQuery("#emailFrame").css("height", jQuery("#mainContent").height());
		
		//jQuery("#mainContent").css("margin-left", leftWidth + 'px');

		jQuery(".leftBg").css("height", footerHeight + "px");

		var h1 = jQuery(".tbSbTop").height();
		var h2 = jQuery(".Sb_ConWpIn").height();
		var h3 = jQuery(".Sb_Line").height();
		var h4 = jQuery(".PanelTT").height();
		var currHeight = footerHeight - h1 - h2 - h3 - h4 - 8;
		jQuery("#dvDefinedFolder").css("height", currHeight + "px");
	}
	function setFolderClickEvent() {
		jQuery("ul li").each(function(){
			jQuery(this).click(function(){
				clearMenuStyle();
		   		this.style.background = 'url(<s:url value='/portal/share/email/images/f3-2.png'/>)';

		    	var folderid = this.id;
		    	if (folderid != null) {
		    		showLoading();
		    		jQuery("#emailFrame").attr("src", "<s:url value='/portal/email/list.action'/>?folderid=" + folderid + "&type=0");
		   		}
			});
		});
	}

	function clearMenuStyle() {
		jQuery("ul li").each(function(){
			this.style.background = '';
		});
	}

</script>
</head>
<body style="overflow: hidden; background: #fff;"><s:bean name="cn.myapps.core.email.folder.action.EmailFolderHelper" id="folderHelper" />
	<div class="leftBg" style="width: 193px; float: left;">
		<table class='tbSB' height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
			<tbody>
				<tr bgcolor="#cccccc" style="border: 1px solid #ccccccbb;">
					<td class="tbSbTop"><!-- 收写信大按钮 -->
						<input type="button" title="{*[core.email.inbox]*}" value="{*[core.email.inbox]*}" class="button1" id="inboxid"/>
						<input type="button" title="{*[core.email.wirte]*}" value="{*[core.email.wirte]*}" class="button1" id="wrieid" />
					</td>
				</tr>
				<tr class="F1Img">
					<td class="tbSbMid"><!-- 主体列表 开始 -->
						<div class="Sb_ConWp">
							<div class="Sb_ConWpIn"><!-- 文件夹 开始 -->
								<div class="PanelWp Panel_Fld"><!-- 内容部分（折叠时隐藏） -->
									<ul id="leftMenu"><s:iterator value="#folderHelper.getSystemFolders(#session.FRONT_USER)" status="index">
										<li id="<s:property value="id"/>" title="<s:property value="displayName"/>"><s:property value="displayName"/></li>
									</s:iterator></ul>
								</div>
							</div>
							<!-- 文件夹 结束 --><!-- 分隔线 -->
							<div class=Sb_Line></div>
							<!-- 自定义文件夹 开始 -->
							<div class="PanelWp Panel_PslFld" style="overflow: auto"><!-- 标题部分 --> <!-- 折叠时把icoOpen换成icoCls -->
								<p class=PanelTT>
									<a class="icoOpCls icoOpen" title="{*[Collapse]*}" href="javascript:void(0);" id="ico"></a> &nbsp;
									<a class="TTxt" title="{*[core.email.in.manager]*}" href="javascript:void(0);" id="person">{*[core.email.folder.other]*}</a>&nbsp;<span class="Extra" style="display: none;">[<a title="{*[core.email.folder.new]*}" href="javascript:void(0);">{*[New]*}</a>]</span>
								</p>
								<!-- 内容部分（折叠时隐藏） -->
								<div id="dvDefinedFolder" style="overflow: auto;">
									<ul id="ulDefFolder"><s:iterator value="#folderHelper.getPersonalEmailFolders(#session.FRONT_USER)" status="index">
										<li id="<s:property value="id"/>" title="<s:property value="displayName"/>"><s:property value="displayName"/></li>
									</s:iterator></ul>
								</div>
							</div>
						</div><!-- 自定义文件夹 结束 -->
					</td><!-- 主体列表 结束 -->
				</tr>
			</tbody>
		</table>
	</div>
	
	<div style="float: right; overflow: hidden; /*border: 2px solid #7abfda;*/" id="mainContent">
		<iframe src="home.jsp" name="emailFrame" id="emailFrame" frameborder="0" scrolling="auto"></iframe>
	</div>
</body>
</o:MultiLanguage></html>