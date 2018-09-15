<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loose.dtd"> -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>

<%@page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="java.util.*"%>

<%@page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>

<%
	String contextPath = request.getContextPath();
	String closeUrlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/closeTab.jsp",request,response);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
#menu {
	float: left;
	width: 96%;
	margin-left: 20px;
	font-size: 9pt;
}

#menu .appTitle {
	float: left;
	width: 130px;
}

#menu dl dt {
	border-bottom: 2px solid #bbb;
	padding: 10px;
}

#menu dl dt a {
	text-decoration: none;
}

dl {
	float: left;
	width: 100%;
}

.topMenu {
	float: left;
}

.open {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jia+.png) 10px 20px no-repeat;
}

.close {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jian-.png) 10px 20px no-repeat;
}

.topMenu, .topMenu li { float:left; width:900px;}
.secondMenu {text-indent:10px;}
.secondMenu li { width: 160px; padding:8px; margin-right:20px; background: url(resource/launchpad/dotted.gif) 0 30px repeat-x;text-indent:0;}

.thirdMenu {display:none;}

.topMenuItem {
	padding-top:15px;
	font-size: 10pt;
	font-weight: bold;
	background: url(resource/launchpad/solid.gif) 0 30px repeat-x;
	list-style-type: none;
}

li a {
	padding: 8px 20px 8px 0;
	background: url(resource/launchpad/arrow-right.gif) right 12px no-repeat;
	text-decoration: none;
	color: #294f88
}

li a:hover {
	color: #00f;
	background-image: url(resource/launchpad/arrow-right-dark.gif)
}


</style>
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<script type="text/javascript" src="./resource/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>


<script type="text/javascript">
	$(function() {
		$(".topMenu>li").addClass("topMenuItem").prepend("<img src='resource/launchpad/topmenudot.png'/>&nbsp;");
		$(".secondMenu").find("li[_href!='']").each(
				function() {
					$li = $(this);
					$li.contents().filter(function() {
						return this.nodeType == 3;//处理文本节点
					}).each(
							function() {
								$textNode = $(this);
								$textNode.wrap(
										"<a _menuId='" + $li.attr("id")
												+ "' _title='"
												+ $textNode.text()
												+ "' _link='"
												+ $li.attr("_href")
												+ "' href='#'></a>")
										.parent("a").click(
												function() {
													$a = $(this);
													var url = $a.attr("_link");
													if (url.indexOf("_backURL=")<=0) {//添加returnURL，实现返回时关闭当前TAB
														url += url.indexOf("?")>0 ? "&_backURL=<%=closeUrlStr%>" : "?_backURL=<%=closeUrlStr%>";
													}
													parent.addTab($a
															.attr("_menuId"),
															$a.attr("_title"),
															url);
												});
							});
				});
		//
		$(".thirdMenu").parent().click(function(){
			$(this).find("ul").toggle();
			
		});
		
		//添加折叠、展开按钮
		$("#menu dl>dt").each(
				function() {
					if ($(this).siblings("dd").find("li").size()==0)$(this).parent().hide();
					$(this).html(
							"<span class='appTitle'>" + this.innerHTML
									+ ":</span>");
				}).append("<a href='#' class='open'>展开</a>").delegate(".open",
				"click", function() {
					$(this).parent().siblings("dd").show();
				}).append("<a href='#' class='close'>折叠</a>").delegate(
				".close", "click", function() {
					$(this).parent().siblings("dd").hide();
				});


	});
</script>
</head>
<body>
	<div id="menu">
		<%
			ApplicationHelper ah = new ApplicationHelper();
			Collection<ApplicationVO> appList = ah.getAppList();

			String applicationId = request.getParameter("application");
			for (ApplicationVO applicationVO : appList) {

				if (!applicationVO.isActivated()
						|| !applicationVO.getId().equals(applicationId))
					continue;

				applicationId = applicationVO.getId();

				out.print("<dl><dt id='" + applicationId + "' class='page'>"
						+ applicationVO.getName() + "</dt><dd>\n");
				ResourceAction resource = new ResourceAction();

				ResourceHelper resourceHelper = new ResourceHelper();

				PermissionHelper permissionHelper = new PermissionHelper();

				WebUser user = (WebUser) session.getAttribute("FRONT_USER");

				Collection<ResourceVO> topMenus = resource.get_topmenus(
						applicationId, user.getDomainid());

				StringBuffer topMenuHtml = new StringBuffer();

				for (ResourceVO topMenu : topMenus) {
					Collection<ResourceVO> secondMenus = resourceHelper
							.searchSubResource(topMenu.getId(), 1,
									user.getDomainid());
					if (permissionHelper.checkPermission(topMenu,
							applicationId, user)) {
						topMenuHtml.append(
								"<li id='" + topMenu.getId() + "'_href='"
										+ topMenu.toUrlString(user, request)
										+ "'>")
								.append(topMenu.getDescription());

						StringBuffer secondMenuHtml = new StringBuffer();
						for (ResourceVO secondMenu : secondMenus) {
							boolean isPermission = permissionHelper
									.checkPermission(secondMenu, applicationId,
											user);

							if (permissionHelper.checkPermission(secondMenu,
									applicationId, user)) {

								secondMenuHtml.append(
										"<li id='"
												+ secondMenu.getId()
												+ "' _href='"
												+ secondMenu.toUrlString(user,
														request) + "'>")
										.append(secondMenu.getDescription()
												+ "\n");

								Collection<ResourceVO> thirdMenus = resourceHelper
										.searchSubResource(secondMenu.getId(),
												1, user.getDomainid());

								StringBuffer thirdMenuHtml = new StringBuffer();
								for (ResourceVO thirdMenu : thirdMenus) {
									if (permissionHelper.checkPermission(
											thirdMenu, applicationId, user)) {

										thirdMenuHtml
												.append("<li id='"
														+ thirdMenu.getId()
														+ "' _href='"
														+ thirdMenu
																.toUrlString(
																		user,
																		request)
														+ "'>")
												.append(thirdMenu
														.getDescription())
												.append("</li>\n");
									}
								}

								if (thirdMenuHtml.length() > 0) {
									secondMenuHtml
											.append("<ul class='thirdMenu'>")
											.append(thirdMenuHtml)
											.append("</ul>\n");
								}

								secondMenuHtml.append("</li>\n");
							}

						}

						if (secondMenuHtml.length() > 0) {
							topMenuHtml.append("<ul class='secondMenu'>")
									.append(secondMenuHtml).append("</ul>\n");
						}

						topMenuHtml.append("</li>\n");
					}
				}

				out.println("<ul class='topMenu'>" + topMenuHtml + "</ul>");
				out.println("</dd></dl>");
			}
		%>
	</div>
</body>
</html>
