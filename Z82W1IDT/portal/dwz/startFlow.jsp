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
<%@ taglib uri="myapps" prefix="o"%>

<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
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

.topMenuCol {
	padding: 10px;
	margin: 10px;
	float: left;
	background-color: #fff;
	width: 220px;
	overflow: hidden;
	border-left: 1px dashed #ddd;
	width: 220px;
	display:none;
}

.topMenu .topMenuCol:last-child {
	border-right: 1px dashed #ddd;
}

.topMenuCol li,.topMenuCol ul {
/*	list-style-type: none; */
}

li.topMenuItem ul {
	font: 9pt;
	font-weight: normal; 
}

.topMenuCol li {
	padding: 10 0px 10px 0;
	background: url(resource/launchpad/dotted.gif) 0 30px repeat-x;
}

.topMenuCol li.topMenuItem {
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

.open {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jia+.png) 10px 20px no-repeat;
}

.close {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jian-.png) 10px 20px no-repeat;
}
</style>
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>


<script type="text/javascript">
	$(function() {

		$(".topMenu")
				.each(
						function(index) {
							var $sortable = $("<div class='topMenuCol'></div><div class='topMenuCol'></div><div class='topMenuCol'></div><div class='topMenuCol'></div>");
							$(this)
									.children("li")
									.each(
											function(i) {
												$($sortable.get(i % 3)).show().append(
														$(this).addClass(
																"topMenuItem").prepend("<img src='resource/launchpad/topmenudot.png'/>&nbsp;"));
											});

							$(this).append($sortable).addClass(
									"sortIndex" + index);
							$(this).find(".topMenuCol").sortable(
									{
										connectWith : ".sortIndex" + index
												+ " .topMenuCol",
										update : function(event, ui) {
											//回调函数
										}
									});
						});

		$(".topMenuItem")
		//动画效果
		.mouseenter(function() {
			$(this).css("background-color", "#f9f9f9");
		}).mouseleave(function() {
			$(this).css("background-color", "#fff");
		}).find("li[_href!='']").each(
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
													parent.parent.addTab($a
															.attr("_menuId"),
															$a.attr("_title"),
															url);
												});
							});
				});

		//添加折叠、展开按钮
		$("#menu dl>dt").each(
				function() {
					if ($(this).siblings("dd").find("li").size()==0)$(this).parent().hide();
					$(this).html(
							"<span class='appTitle'>" + this.innerHTML
									+ ":</span>");
				}).append("<a href='#' class='open'>{*[list.open]*}</a>").delegate(".open",
				"click", function() {
					$(this).parent().siblings("dd").show();
				}).append("<a href='#' class='close'>{*[list.fold]*}</a>").delegate(
				".close", "click", function() {
					$(this).parent().siblings("dd").hide();
				});

	});
</script>
</head>
<body>
	<div id="menu">
		<%
		WebUser user = (WebUser) session.getAttribute("FRONT_USER");
		ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
		Collection<ApplicationVO> appList = process.queryAppsByDomain(user.getDomainid(),1,Integer.MAX_VALUE);

			String applicationId = request.getParameter("application");
			for (ApplicationVO applicationVO : appList) {

				if (!applicationVO.isActivated())
					continue;

				applicationId = applicationVO.getId();

				out.print("<dl><dt id='" + applicationId + "' class='page'>"
						+ applicationVO.getName() + "</dt><dd>\n");
				ResourceAction resource = new ResourceAction();

				ResourceHelper resourceHelper = new ResourceHelper();

				PermissionHelper permissionHelper = new PermissionHelper();

				Collection<ResourceVO> topMenus = resource.get_topmenus4FlowCenter(
						applicationId, user.getDomainid());

				StringBuffer topMenuHtml = new StringBuffer();

				for (ResourceVO topMenu : topMenus) {
					String topMenuUrl = topMenu.toUrlString(user, request);
					Collection<ResourceVO> secondMenus = resourceHelper
							.searchSubResource4flowCenter(topMenu.getId(), 1,
									user.getDomainid());
					if (permissionHelper.checkPermission(topMenu,
							applicationId, user)) {

						StringBuffer secondMenuHtml = new StringBuffer();
						for (ResourceVO secondMenu : secondMenus) {
							boolean isPermission = permissionHelper
									.checkPermission(secondMenu, applicationId,
											user);

							if (permissionHelper.checkPermission(secondMenu,
									applicationId, user)) {

								Collection<ResourceVO> thirdMenus = resourceHelper
										.searchSubResource4flowCenter(secondMenu.getId(),
												1, user.getDomainid());

								StringBuffer thirdMenuHtml = new StringBuffer();
								for (ResourceVO thirdMenu : thirdMenus) {
									String thirdMenuUrl = thirdMenu
											.toUrlString(user, request);
									if (permissionHelper.checkPermission(
											thirdMenu, applicationId, user)) {

										//组合三级菜单
										if (("00".equals(thirdMenu
												.getLinkType())
												&& thirdMenuUrl != null && thirdMenuUrl
												.trim().length() > 0)) {
											thirdMenuHtml
													.append("<li id='"
															+ thirdMenu.getId()
															+ "' _href='"
															+ thirdMenuUrl
															+ "'>")
													.append(thirdMenu
															.getDescription())
													.append("</li>\n");
										}
									}
								}

								//组合二级菜单，没有url，且没有子菜单，则不输出
								String secondMenuUrl = secondMenu.toUrlString(
										user, request);
								if (thirdMenuHtml.length() > 0
										|| ("00".equals(secondMenu
												.getLinkType())
												&& secondMenuUrl != null && secondMenuUrl
												.trim().length() > 0)) {
									secondMenuHtml.append(
											"<li id='" + secondMenu.getId()
													+ "' _href='"
													+ secondMenuUrl + "'>")
											.append(secondMenu.getDescription()
													+ "\n");
									if (thirdMenuHtml.length() > 0) {
										secondMenuHtml
												.append("<ul class='thirdMenu'>")
												.append(thirdMenuHtml)
												.append("</ul>\n");
									}
									secondMenuHtml.append("</li>\n");
								}
							}

						}

						//组合顶级菜单，没有url，且没有子菜单，则不输出
						if (secondMenuHtml.length() > 0
								|| ("00".equals(topMenu.getLinkType())
										&& topMenuUrl != null && topMenuUrl
										.trim().length() > 0)) {
							topMenuHtml.append(
									"<li id='" + topMenu.getId() + "'_href='"
											+ topMenuUrl + "'>").append(
									topMenu.getDescription());
							if (secondMenuHtml.length() > 0) {
								topMenuHtml.append("<ul class='secondMenu'>")
										.append(secondMenuHtml)
										.append("</ul>\n");
							}
							topMenuHtml.append("</li>\n");
						}
					}
				}

				out.println("<ul class='topMenu'>" + topMenuHtml + "</ul>");
				out.println("</dd></dl>");
			}
		%>
	</div>
</body>
</html>
</o:MultiLanguage>