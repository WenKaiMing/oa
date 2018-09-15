<%@page import="cn.myapps.util.property.DefaultProperty"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.email.util.EmailConfig"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%>
<%@page import="cn.myapps.extendedReport.NDataSource"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@page import="java.util.*"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<link rel="shortcut icon" type="images/x-icon" href="<s:url value='../share/images/logo/logo32x32.ico'/>" media="screen" />
<title><s:if test="#session.FRONT_USER.getDomain().getSystemName().length()>0"><s:property value="#session.FRONT_USER.getDomain().getSystemName()"/></s:if><s:else>{*[front.teemlink]*} OA</s:else></title>
<link type="text/css" rel="stylesheet"
	href="./resource/jquery/layout-default-latest.css">
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>
<!-- 弹出层插件--start -->
<script src="../share/component/artDialog/jquery.artDialog.source.js?skin=aero"></script>
<script src="../share/component/artDialog/plugins/iframeTools.source.js"></script>
<script src="../share/component/artDialog/obpm-jquery-bridge.js"></script>
<!-- 弹出层插件--end -->
<script type="text/javascript" src="./resource/jquery/jquery.layout-latest.js"></script>
<script type="text/javascript" src="./resource/main/obpm.peelback.js"></script>
<style>
body {
	font-size: 62.5%;
	font-family: "Trebuchet MS", "Arial", "Helvetica", "Verdana","sans-serif";
	background: #fafafa;
	border-right: 1px solid #000;
	border-bottom: 1px solid #000;
}
.content ｛
	border:1px blue solid;
｝
.togglerClass {
	border: 1px solid red;
}
.resizerClass {
	width: 0px;
}
.paneClass { /*	border: 1px solid blue;*/}
#button_bar {
	margin: 0;
	padding: 0px;
	border: 1px solid #e6e6e6;
	background: #fafafa;	
	filter: alpha(opacity = 80);
	-moz-opacity: 0.8;
	opacity: 0.8;
	
-moz-border-radius-bottomright: 3px; 
-webkit-border-bottom-right-radius: 3px;
border-bottom-right-radius:  3px;
}

#button_bar li {
	text-decoration: none;
	list-style-type: none;
	padding: 0px;
	margin: 0px;
	border: 0px;
	height: 60px;
}

#button_bar li a.active:hover {
	background-color: transparent ;
}

#button_bar li a span.icon {
	margin-top:10px;
	height: 30px;
	width: 60px;
	display: block;	
}

#button_bar li a span.icon:hover {
	-webkit-transform:rotate(720deg);
	-moz-transform:rotate(720deg);
	-moz-transition: -moz-transform 0.3s ease;
	-webkit-transition: -webkit-transform 0.3s ease;
	rotation:720deg;
}

.icon-home {
	background: url('./resource/main/images/home.png') no-repeat bottom center;
}

.icon-flowcenter {
	background: url('./resource/main/images/flowcenter.png') no-repeat bottom center;
}

.icon-appmenu {
	background: url('./resource/main/images/appmenu.png') no-repeat bottom center;
}

.icon-knowledge {
	background: url('./resource/main/images/knowledge.png') no-repeat bottom center;
}

.icon-message {
	background: url('./resource/main/images/message.png') no-repeat bottom center;
}

.icon-email {
	background: url('./resource/main/images/email.png') no-repeat bottom center;
}

.icon-profile {
	background: url('./resource/main/images/profile.png') no-repeat bottom center;
}

.icon-logout {
	background: url('./resource/main/images/logout.png') no-repeat bottom center;
}

#button_bar li a {
	position: relative;
	margin-right: -1px;
	display: block;
	padding: 0px;
	overflow: hidden;
	color: #808080;
	text-decoration: none;
	text-overflow: ellipsis;
	white-space: nowrap;
	cursor: pointer;
	clear: both;
}

#button_bar li a.active {
	cursor: default;
	background-color: #f5f6f7;
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
}

#button_bar li a.active span { /**透明度*/
	filter: alpha(opacity = 100);
	-moz-opacity: 1;
	opacity: 1;
}

#button_bar li a.hover span { /**透明度*/
	filter: alpha(opacity = 100);
	-moz-opacity: 1;
	opacity: 1;
}

#button_bar li a span {
	display: block;
	width: 60px;
	height: 20px;
	font-size: 12px;
	font-style: normal;
	line-height: 20px;
	color: #595959;
	text-align: center;
	/**透明度*/
	filter: alpha(opacity = 25);
	-moz-opacity: 0.25;
	opacity: 0.25;
}

.ui-tabs,.ui-tabs-nav {
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
}

.ui-tabs .ui-tabs-panel {
	padding: 0px;
}

.ui-state-active,.ui-widget-content .ui-state-active,.ui-widget-header .ui-state-active
	{
	color: #227db2;
	font-weight: bold;
	border: 0px solid #e7eef5;
	padding-left: 1px;
	
	filter: alpha(opacity = 80);
	-moz-opacity: 0.8;
	opacity: 0.8;

}

#logo {
	width: 61px;
	height: 46px;
	background-color: #16628f;
	overflow: hidden;
	border: 0px;
	padding: 0px;
	margin: 0px;
}

#logo span{
display:block;
border:1px solid #fff;
margin:2px 5px 5px 10px;
	width:40px;
	height:40px;
	<s:if test="#session.FRONT_USER.getDomain().getLogoUrl().length()>0">
	background: #ffffff url('<s:url value="/lib/icon/" /><s:property value="#session.FRONT_USER.getDomain().getLogoUrl()"/>') no-repeat center center;
	</s:if>
	<s:else>
	background: #ffffff url('../share/images/logo/logo-cool.png') no-repeat center center;
	</s:else>
	
	border-radius: 20px;/*设置图像圆角效果,在这里我直接设置了超过width/2的像素，即为圆形了*/  
    -webkit-border-radius: 20px;/*圆角效果：兼容webkit浏览器*/  
    -moz-border-radius:20px;   
    box-shadow: inset 0 -1px 0 #FFF;/*设置图像阴影效果*/  
    -webkit-box-shadow: inset 0 -1px 0 #CCC; 
	
	position:relative; 
	z-index:2; 
	behavior: url('./resource/main/iecss3.htc') 
}

#tabs {
	padding: 0px;
	border: 0px;
	padding: 0px;
	margin: 0px;
/*	background: url('./resource/main/images/header-bg.png') no-repeat scroll 0px -1px;*/
	background:none;
}

#nav { /*	height: 28px;*/
	padding-top: 18px;
	border: 0;
	background: #2e83c6 url('./resource/background/bg1.jpg') no-repeat scroll -60px -1px;
		/*width: 100%;*/
}

#nav li {
	height: 27px;
	margin-top: 1px;
	border-top: 1px;
}

#toolbar-top {
	position: absolute;
	right: 20px;
	top: 0px;
	z-index: 10;
	height: 30px;
}

#changBG {
	cursor:hand;
	border:1px solid #DDD;
	padding:2px;
	position: absolute;
	left: 3px;
	bottom: 5px;
	z-index: 1000;
}
#changBG a{
	text-decoration: none;
	color:#DDD;
}

#toolbar-top a {
	color: #FFF;
	text-shadow:2px 2px 8px #FF0000;
	filter:Glow(Color="#ff0000",Strength="2");
	display: block;
	float: left;
	font: 16px/53px "Microsoft YaHei", tahoma, arial;
	text-align: center;
	width: 100px;
	text-decoration: none;
	outline: medium none;
	cursor: pointer;
	word-break: break-all;
	text-overflow:ellipsis;
	white-space:nowrap;
	overflow:hidden;
	height: 30px;
	line-height: 30px;
	margin: 10px auto;
}

#toolbar-top a:hover {
	color: #FFFFFF;
	font-weight: 700;
}

#clearfix{
	height: 2px; clear: both; overflow: hidden; margin: 0px; padding: 0px; background: #e7eef5;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}

#message-tips {
	color:#f00;
}
/**loading图片--start**/
#logoloading {
	position: absolute;
	top: 35%;
	left: 45%;
	width: 128px;
	height: 128px;
}

#loadDiv{
	z-index: 10001; 
	position: fixed; 
	top: 0; 
	left: 0; 
	height: 100%; 
	width: 100%; 
	background-color: #3a3a3a;
}
/**loading图片--end**/
</style>

<script type="text/javascript">
	var myLayout;
	var addTab;
	var closeTab;
	$ = jQuery;

	$(document)
			.ready(
					function() {

						//天翎官网信息
						$('body').peelback({
							adImage : './resource/main/peel-ad.png',
							peelImage : './resource/main/peel-image.png',
							clickURL : 'http://www.teemlink.com/',
							smallSize : 13,
							bigSize : 400,
							gaTrack : true,
							gaLabel : '#1 Stegosaurus',
							autoAnimate : true
						});
						//背景切换
						var bgIndex = $.cookie('bgIndex');
						bgIndex = bgIndex ? bgIndex : 0;
						var _changeBG = function(bgIndex) {
						
							var _winwidth = $(window).width();
							var _bgsize = function(){if (_winwidth<1200){return "small"} else if (_winwidth>=1200 && _winwidth<1600){return "normal"} else if (_winwidth>=1600){return "large"}}();

							var bgUrl = './resource/background/'+_bgsize+'/bg'+(bgIndex%5+1)+'.jpg';
							$("body").css("background","url('"+bgUrl+"') no-repeat 0px -60px");
							$("#logo").css("background","url('"+bgUrl+"') no-repeat 0px 0px")
							$("#nav").css("background","url('"+bgUrl+"') no-repeat -60px -1px")						
						};
						_changeBG(bgIndex);
						
						$('#changBG').click(function(){
							bgIndex ++;
							$.cookie('bgIndex',bgIndex);
							_changeBG(bgIndex);
						});

						// this layout could be created with NO OPTIONS - but showing some here just as a sample...
						// myLayout = $('body').layout(); -- syntax with No Options
						myLayout = $('body').layout({

							center__paneSelector : "#center",
							west__paneSelector : "#west"

							,
							togglerClass : "togglerClass",
							resizerClass : "resizerClass",
							paneClass : "paneClass",
							spacing_open : 0
							//	some pane-size settings
							,
							west__size : 60,
							center__minWidth : 200

							//	some pane animation settings
							,
							west__animatePaneSizing : true,
							west__fxSpeed_size : 100 // 'fast' animation when resizing west-pane
							,
							west__fxSpeed_open : 400 // 1-second animation when opening west-pane
							,
							west__fxSettings_open : {
								easing : "bounce"
							} // 'bounce' effect when opening

							,
							west__fxName_close : "none" // NO animation when closing west-pane

						//	enable showOverflow on west-pane so CSS popups will overlap north pane
						//,
						//west__showOverflowOnHover : true

						//	enable state management
						//,	stateManagement__enabled:	true // automatic cookie load & save enabled by default

						});
						//if there is no state-cookie, then DISABLE state management initially
						//var cookieExists = !$.isEmptyObject( myLayout.readCookie() );
						//if (!cookieExists) toggleStateManagement( true, false );
						//tabs 
						var tabTitle = $("#tab_title"), tabContent = $("#tab_content"), tabTemplate = "<li><a href='#"+"{href}'>#"
								+ "{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>", tabCounter = 2;

						var tabs = $("#tabs")
								.tabs(
										{
											heightStyle : "fill",
											activate : function(event, ui) {
												ui.newPanel
														.children("iframe")
														.height(
																document.body.clientHeight - 51)
														.width(
																ui.newPanel
																		.width() - 2);
												var href = ui.newTab.find(">a").attr("href");//当选中页签时，左边工具栏回选
												var pos = href.lastIndexOf("#") + 1;
												var $btnA = $("#button_bar>li[tabid*='"+href.substring(pos,href.length)+"']>a");
												$btnA.trigger("click");												
											},
											create : function(event, ui) {
												ui.panel
														.children("iframe")
														.height(
																document.body.clientHeight - 51)
														.width(
																ui.panel
																		.width() - 2);
											}

										});

						addTab = function(id, label, url) {
							var active = tabs.find("[href*='#" + id + "']");

							var index = tabs.find(".ui-tabs-nav > li > a")
									.index(active);
							//如果id已经添加，则选中
							if (index >= 0) {
								tabs.tabs("option", "active", index);
							} else {
								var last = tabs.find(".ui-tabs-nav > li > a")
										.size();
								var li = $(tabTemplate.replace(/#\{href\}/g,
										"#" + id).replace(/#\{label\}/g, label)), tabContentHtml = tabContent
										.val()
										|| "Tab " + (last + 1) + " content.";
								tabs.find(".ui-tabs-nav").append(li);
								var $contentIframe = $("<div id='" + id + "' class='content'><iframe src='"
												+ url
												+ "'frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='auto' allowtransparency='yes'></iframe></div>");
									$contentIframe.find(">iframe").css("background","#fafafa").css("opacity","0.98");
								tabs
										.append($contentIframe);
								tabs.tabs("refresh");
								tabs.tabs("option", "active", last);

							}

							$("#center").hide().show();
						};

						closeTab = function(id) {
							
							var $tabContainerDiv = tabs.find("#" + id);
							var $tabLi = tabs.find(
									".ui-tabs-nav>li>a[href*='#" + id + "']")
									.parent();
							$tabLi.remove();
							$tabContainerDiv.remove();
							tabs.tabs("refresh");
						};

						closeActiveTab = function() {
							var $tabLi = tabs
									.find(".ui-tabs-nav .ui-state-active");
							var id = $tabLi.find(">a").attr("href");
							
							var pos = id.indexOf("#");
							if (pos > 0) {
								id = id.substring(pos);
							}
							var $tabContainerDiv = tabs.find(id);
							$tabLi.remove();
							$tabContainerDiv.remove();
							tabs.tabs("refresh");
						};

						// addTab button: just opens the dialog
						$("#button_bar>li>a").hover(function() {
							var $this = $(this);
							if (!$this.hasClass("active")) {
								var $span = $this.find(">span");
								$this.addClass("hover");
								$span.stop().fadeTo(100, 0.95);
							}
						}, function() {
							var $this = $(this);
							$this.removeClass("hover");
							if (!$this.hasClass("active")) {
								var $span = $this.find(">span");
								$span.stop().fadeTo(100, 0.25);
							}
						}).click(
								function() {
									var $this = $(this);
									$("#button_bar>li>a.active").removeClass(
											"active").find(">span").css(
											'opacity', 0.25);
									$this.addClass("active");
									var $span = $this.find(">span");
									$span.css('opacity', 1);

									var url = $this.attr("_url");
									var tabid = $this.parent().attr("tabid");
									//	alert("url->" + url + " \n tabid->" + tabid);
									var title = $this.children("span").text();
									addTab(tabid, title, url);
								});

						// close icon: removing the tab on click
						tabs.delegate("span.ui-icon-close", "click",
								function() {
									var panelId = $(this).closest("li")
											.remove().attr("aria-controls");
									$("#" + panelId).remove();
									tabs.tabs("refresh");
								});

						tabs
								.bind(
										"keyup",
										function(event) {
											if (event.altKey
													&& event.keyCode === $.ui.keyCode.BACKSPACE) {
												var panelId = tabs.find(
														".ui-tabs-active")
														.remove()
														.attr("aria-controls");
												$("#" + panelId).remove();
												tabs.tabs("refresh");
											}
										});
						$("#manageDomain").bind("click",function(){
							var id = "manageDomain";
							var title = $(this).attr("title");
							var url = $(this).attr("_url");
							addTab("manageDomainTab",title,url);
						});
						
						//刷新站内短信数量
						$("#message-tips").load("../notification/newMessageCount.action",function(data){
						});
						setInterval(function(){
							$("#message-tips").load("../notification/newMessageCount.action",function(data){
							});
						},30000);

						//隐藏loading图片
						$("#iframe-homepage").load(function(){
							$("#loadDiv").fadeOut(200);
						});
						//2秒异常处理，不论是否有load事件被触发，都去掉load层
						setTimeout(function(){
							$("#loadDiv").hide();
						}, 2000);
					});

	function doPersonalSetup() {
		var url = "";
<%
WebUser user = (WebUser) session
					.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
			String userId = user.getId();
			out.println("url = '../user/editPersonal.action?editPersonalId="
					+ userId + 
	"';");%>

		OBPM.dialog.show({
			opener : window,
			width : 920,
			height : 550,
			url : url,
			title : "{*[Setup]*}",
			close : function(rtn) {
			}
		});
	};

jQuery(window).resize(function(){
	jQuery("#tabs").children("div[aria-hidden]").css("height",((document.body.clientHeight - 51)+"px"));
	jQuery("#tabs").children("div[aria-hidden='false']").find("iframe")
		.css("height",((document.body.clientHeight - 51)+"px")).css("width",((document.body.clientWidth - 60)+"px"));
});
</script>

</head>
<body class="ui-layout-container"
	style="zoom: 1; overflow: hidden; width: auto; height: auto; margin: 0px; position: absolute; top: 0px; bottom: 0px; left: 0px; right: 0px;">
	
	<div id='loadDiv'><div id='logoloading'><img src='./resource/main/images/loading.gif'/></div></div>
	<div id="toolbar-top">
		<a onclick="doPersonalSetup()" title="<%=user.getName()%>">{*[Setup]*}<font style="font: 10px/20px 'Microsoft YaHei', tahoma, arial;">[<%=user.getName()%>]</font></a> 
            <%
				if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
					if("true".equals(DefaultProperty.getProperty("saas"))){
						out.println("<a id='controlPanel' title='{*[cn.myapps.core.main.domain_management]*}' href='../../saas/weioa/controlPanel.jsp'>{*[front.Management]*}</a>");
					}else{
						out.println("<a id='manageDomain' title='{*[cn.myapps.core.main.domain_management]*}' _url='../domain/edit.action?domain="+user.getDomainid()+"'>{*[front.Management]*}</a>");
					}
				}
			%>
		<a href="./logout.jsp">{*[Logout]*}</a>
	</div>
	<div id="changBG"><a href="#">换一换&gt&gt</a></div>
	<div id="west" style="overflow: visible; padding: 0px;">
		<div id="logo"><span></span></div>
		<ul id="button_bar">
			<li tabid="tabs_homepage"><a class="app active"
				_url="homepage.jsp"><span class="icon icon-home"></span><span>{*[Home]*}</span></a></li>
			<li tabid="tabs_flowcenter"><a class="app" _url="flowCenter.jsp"><span
					class="icon icon-flowcenter"></span><span>{*[Flow]*}</span></a></li>

			<%
				DomainHelper dh = new DomainHelper();

				ApplicationHelper ah = new ApplicationHelper();
				Collection<ApplicationVO> appList = ah.getListByWebUser(user);

				String applicationId = request.getParameter("application");
				for (ApplicationVO applicationVO : appList) {

					//					if (!applicationVO.isActivated())
					//						continue;
					applicationId = applicationVO.getId();
					String desc = applicationVO.getName().trim();
					String title = desc;
					if (desc != null && desc.length() > 4) {
						desc = desc.substring(0, 3) + ".."
								+ desc.charAt(desc.length() - 1);
					}
					out.print("<li title='" + title + "' tabid='tabs_menu_" + applicationId
							+ "'><a class='app' _url='menu.jsp?application="
							+ applicationId
							+ "'><span class='icon icon-appmenu'></span><span>"
							+ desc + "</span></a></li>\n");
				}
				if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.PM)){
					out.println("<li tabid='tabs_pm'><a class='app' _url='../../pm/index.jsp'><span class='icon icon-knowledge'></span><span class='text'>{*[Task]*}</span></a></li>");
				}
				if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.QM)){
					out.println("<li tabid='tabs_qm'><a class='app' _url='../../qm/index.jsp'><span class='icon icon-knowledge'></span><span class='text'>调查问卷</span></a></li>");				//判断是否开启KM
				}
				//判断是否开户ERP报表
				if (NDataSource.isErpEnable()) {
					out.println("<li tabid='tabs_erp'><a class='app' _url='../../extendedReport/chartIndex.jsp'><span class='icon icon-knowledge'></span><span>ERP报表</span></a></li>");
				}	
				//判断是否开启KM
				if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.KM)){
					out.println("<li tabid='tabs_knowledge'><a class='app' _url='knowledge.jsp'><span class='icon icon-knowledge'></span><span>{*[km.name]*}</span></a></li>");
				}				
			%>
			
			<li tabid="tabs_message"><a class="app" _url="message.jsp"><span
					class="icon icon-message"></span><span>{*[front.message]*}(<font id="message-tips">0</font>)</span></a></li>
			<%
			if (EmailConfig.isUserEmail()) {
				out.println("<li tabid='tabs_email'><a class='app' _url='../share/email/index.jsp'><span class='icon icon-email'></span><span>{*[front.email]*}</span></a></li>");
			}			
			%>
		</ul>
	</div>
	<div id="center" style="padding: 0px;">
		<!-- Tabs -->
		<div id="tabs">
			<ul id="nav">
				<li>
					<a href="#tabs_homepage">{*[Home]*}</a>
				</li>
			</ul>
			<div id="clearfix">&nbsp;</div>
			<div id="tabs_homepage">
				<iframe style='border-top: 0px #e7eef5 solid;' id="iframe-homepage"
					src="homepage.jsp" frameborder='no' border='0' marginwidth='0'
					marginheight='0' scrolling='auto' allowtransparency='yes'></iframe>
			</div>
		</div>
	</div>
</body>
</html>
</o:MultiLanguage>