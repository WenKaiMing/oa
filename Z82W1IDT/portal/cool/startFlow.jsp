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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.menu_dl {
	padding-left: 50px;
	margin-top: 30px;
}

li {
	list-style-type: none;
}

.app {
	border-bottom: 2px solid #ccc;
	padding-bottom: 5px;
	width: 97%;
}

.app .appTitle {
	font-size: 20px;
	font-weight: bold;
	font-family: Microsoft YaHei, tahoma, arial;
	height: 30px;
	line-height: 30px;
	vertical-align: top;
	color: #666;
	background-image: url('resource/launchpad/app.png');
	background-repeat: no-repeat;
	padding-left: 34px;
}

.menu {
	margin: 0px;
}

.topMenu {
	margin-top: 34px;
	margin-left: 0;
	padding-left: 0px;
}

.topMenu .topMenuItem {
	margin-bottom: 50px;
	width: 40%;
	display: block;
	float: left;
	padding-left: 60px;
}

.topMenu .topMenuItem .topMenu_title {
	height: 32px;
	line-height: 32px;
	vertical-align: top;
	font-size: 18px;
	font-family: Microsoft YaHei, tahoma, arial;
	color: #666;
	display: block;
	background-image: url('resource/launchpad/menu.png');
	background-repeat: no-repeat;
	padding-left: 40px;
}

.secondMenu {
	margin-top: 15px;
	margin-left: 0;
	padding-left: 30px;
}

.secondMenu .secondMenuItem {
	margin-bottom: 20px;
	float: left;
	width: 48%;
}

.secondMenu .secondMenuItem .second_title{
	font-family: Microsoft YaHei, tahoma, arial;
	color: #666;
	margin-left: 8px;
}

.secondMenu .secondMenuItem .linkText{
	cursor: pointer;
	padding-right: 20px;
	background: url(resource/launchpad/arrow-right.gif) right no-repeat;
}

.secondMenu .secondMenuItem .linkText:HOVER{
	color: #42aad4;
}

.thirdMenu {
	margin-left: 0;
	margin-top: 8px;
	padding-left: 15px;
}

.thirdMenu .thirdMenuItem {
	height: 25px;
	line-height: 25px;
}

.thirdMenu .thirdMenuItem .third_title {
	font-family: Microsoft YaHei, tahoma, arial;
	font-size: 14px;
	color: #666;
	margin-left: 8px;
}

.thirdMenu .thirdMenuItem .linkText {
	cursor: pointer;
	padding-right: 20px;
	background: url(resource/launchpad/arrow-right.gif) right no-repeat;
}

.thirdMenu .thirdMenuItem .linkText:HOVER {
	color: #42aad4;
}

.noApp {
	height: 32px;
	line-height: 32px;
	font-size: 18px;
	font-family: Microsoft YaHei, tahoma, arial;
	color: #666;
	padding-left: 20px;
}
</style>
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(function() {
		//构建菜单
		$(".topMenu").each(function(index) {
			jQuery(this).append("<div style='clear:both;'></div>").children("li").each(function(i){	//一级菜单
				jQuery(this).addClass("topMenuItem")
					.children("span").addClass("topMenu_title").end()
					.find(".secondMenu").append("<div style='clear:both;'></div>").children("li").each(function(){	//二级菜单
						jQuery(this).addClass("secondMenuItem")
							.prepend("<img src='resource/launchpad/topmenudot.png'>")
							.children("a").addClass("second_title").end()
							.find(".thirdMenu").children("li").each(function(){	//三级菜单
								jQuery(this).addClass("thirdMenuItem")
								.prepend("<img src='resource/launchpad/dot.png'>")
								.children("a").addClass("third_title");
							});
					});
				if(i%2==0){	//避免换行不能对齐
					jQuery(this).css("clear","left");
				}
			});
		});
		
		//添加click事件
		$(".topMenuItem").find("li[_href!='']").each(function() {
			var $li = jQuery(this);
			$li.children("a").each(function(){
				var $a = $(this);
				$a.addClass("linkText")
					.attr("_menuId",$li.attr("id"))
					.attr("_title",$a.text())
					.attr("_link",$li.attr("_href"))
					.click(function(){
						var url = $a.attr("_link");
						if (url.indexOf("_backURL=")<=0) {//添加returnURL，实现返回时关闭当前TAB
							url += url.indexOf("?")>0 ? "&_backURL=<%=closeUrlStr%>" : "?_backURL=<%=closeUrlStr%>";
						}
						parent.parent.addTab($a.attr("_menuId"),
								$a.attr("_title"),
								url);
					});
			});
		});
		
		//隐藏无菜单的软件
		$(".menu_dl").each(function(){
			if($(this).find(".menu .topMenuItem").size()<=0){
				$(this).find(".app").css("display","none");
			}else{
				$(".noApp").css("display","none");	//隐藏无发起内容的提示
			}
		});

		//插入横向分隔线，不显示
		$(".topMenuItem").each(function(i){
			if(i%2==1){
				$(this).after($("<div style='clear:both;height:0px;font-size:0px;'></div>"));
			}
		});
		
		//显示分隔线
		$(".topMenuItem").each(function(i){
			if(i%2==0){
				$(this).css("border-right","1px solid #ccc");
			}else {
				$(this).css("border-left","1px solid #ccc");
				$(this).css("margin-left","-1px");
			}
		});
	});
</script>
</head>
<body>
	<div class="noApp">无发起内容</div>
		<%
		WebUser user = (WebUser) session.getAttribute("FRONT_USER");
		ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
		Collection<ApplicationVO> appList = process.queryAppsByDomain(user.getDomainid(),1,Integer.MAX_VALUE);

			String applicationId = request.getParameter("application");
			for (ApplicationVO applicationVO : appList) {

				if (!applicationVO.isActivated())
					continue;

				applicationId = applicationVO.getId();

				out.print("<dl class='menu_dl'><dt class='app'>"
						+ "<span class='appTitle'>"
						+ applicationVO.getName() + "</span></dt>"
						+ "<dd class='menu'>\n");
				ResourceAction resource = new ResourceAction();

				ResourceHelper resourceHelper = new ResourceHelper();

				PermissionHelper permissionHelper = new PermissionHelper();

				Collection<ResourceVO> topMenus = resource.get_topmenus(
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
											String desc3 = thirdMenu.getDescription();
											if (desc3 != null && desc3.length() > 5) {
												desc3 = desc3.substring(0, 4) + ".."
														+ desc3.charAt(desc3.length() - 1);
											}
											thirdMenuHtml
													.append("<li id='"
															+ thirdMenu.getId()
															+ "' _href='"
															+ thirdMenuUrl
															+ "'>")
													.append("<a>"+desc3+"</a>")
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
									String desc2 = secondMenu.getDescription();
									if (desc2 != null && desc2.length() > 5) {
										desc2 = desc2.substring(0, 4) + ".."
												+ desc2.charAt(desc2.length() - 1);
									}
									secondMenuHtml.append(
											"<li id='" + secondMenu.getId()
													+ "' _href='"
													+ secondMenuUrl + "'>")
											.append("<a>"+desc2
													+ "</a>\n");
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
											+ topMenuUrl + "'>").append("<span>"+
									topMenu.getDescription()+"</span>");
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
</body>
</html>
</o:MultiLanguage>