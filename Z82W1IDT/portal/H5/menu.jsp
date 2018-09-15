<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>

<%@page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="java.util.*"%>

<%@page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%
	String contextPath = request.getContextPath();
	String closeUrlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/closeTab.jsp",request,response);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="resource/css/myapp.css" />
<link rel="stylesheet" href="resource/css/launch.css" />
<link rel="stylesheet" href="resource/css/animate.css" />
<script src="resource/js/jquery-1.11.3.min.js"></script>
<script src="resource/script/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	
	var $appTitle = $(".appTitle");
	var $topBox = $(".top_menu_box");
	var $secondBox = $(".second_menu_box");
	var $thirdBox = $(".third_menu_box");
	
	$("li.topMenuItem").each(function(){
		var $this = $(this);
		
		if(($this).find(">ul>li").size()<=0){
			var $topMenuItem = $("<span id='icon_" + $this.attr("id") + "' data-toggle='tooltip' data-placement='bottom' data-target='"+$this.attr("_target")+"' title='" + $this.find(">.topMenu_title").text() + "'><i class='menuLiIcon'><img src='resource/images/Newly-build1.png'></i><i class='menuLiTxt'>" + $this.find(">.topMenu_title").text() + "</i></span>").appendTo($topBox);
		}else{
			var $topMenuItem = $("<span id='icon_" + $this.attr("id") + "' data-toggle='tooltip' data-placement='bottom' data-target='"+$this.attr("_target")+"' title='" + $this.find(">.topMenu_title").text() + "'><i class='menuLiIcon'><img src='resource/images/File3.png'><img class='menuLiArrow' src='resource/images/Triangle.png'></i><i class='menuLiTxt'>" + $this.find(">.topMenu_title").text() + "</i></span>").appendTo($topBox);
		}

		//menu1
		$topMenuItem.click(function(){
			var topMenuId = $(this).attr("id").substring(5);
			var $topMenuLi = $("#"+topMenuId).find(">ul>li");
			$topBox.find("span").removeClass("active");
			$(this).addClass("active");
			//$secondBox.slideUp();
			$secondBox.empty();
			$thirdBox.empty();
			
			
			if ($topMenuLi.size()<=0) {
				urlLink(topMenuId);
			}
			else {
				
				$topMenuLi.each(function(){
					
					if($(this).find(">ul>li").size()<=0){
						var $secondMenuItem = $("<span id='icon_" + $(this).attr("id") + "' data-toggle='tooltip' data-placement='bottom' data-target='"+$(this).attr("_target")+"' title='" + $(this).find(">.second_title").text() + "'><i class='menuLiIcon'><img src='resource/images/Newly-build1.png'></i><i class='menuLiTxt'>" + $(this).find(">.second_title").text() + "</i></span>").appendTo($secondBox);
					}else{
						var $secondMenuItem = $("<span id='icon_" + $(this).attr("id") + "' data-toggle='tooltip' data-placement='bottom' data-target='"+$(this).attr("_target")+"' title='" + $(this).find(">.second_title").text() + "'><i class='menuLiIcon'><img src='resource/images/File4.png'><img class='menuLiArrow' src='resource/images/Triangle.png'></i><i class='menuLiTxt' >" + $(this).find(">.second_title").text() + "</i></span>").appendTo($secondBox);
					}
					
					//menu2
					$secondMenuItem.click(function(){
						var secondMenuId = $(this).attr("id").substring(5);
						var $secondMenuLi = $("#"+secondMenuId).find(">ul>li");
						$secondBox.find("span").removeClass("active");
						$(this).addClass("active");
						//$thirdBox.slideUp();
						$thirdBox.empty();
						
						if ($secondMenuLi.size()<=0){
							urlLink(secondMenuId);
						}
						else {
							$secondMenuLi.each(function(){
								var $thirdMenuItem = $("<span id='icon_" + $(this).attr("id") +"' data-toggle='tooltip' data-placement='bottom' data-target='"+$(this).attr("_target")+"' title='" + $(this).find(">.third_title").text() +"'><i class='menuLiIcon'><img src='resource/images/Newly-build1.png'></i>" + $(this).find(">.third_title").text() + "</span>").appendTo($thirdBox);
								 // var $thirdMenuItem = $("<span id='icon_" + $(this).attr("id") + "' data-toggle='tooltip' data-placement='bottom' title='" + $(this).find(">.third_title").text() + "'><i class='menuLiIcon'><img src='resource/images/File2.png'><img class='menuLiArrow' src='resource/images/Triangle.png'></i><i class='menuLiTxt' >" + $(this).find(">.second_title").text() + "</i></span>").appendTo($thirdBox);
								//menu3
								$thirdMenuItem.click(function(){
									var thirdMenuId = $(this).attr("id").substring(5);
									urlLink(thirdMenuId);
								});
								$thirdBox.slideDown("fast");
							});
							$("[data-toggle='tooltip']").tooltip();
						}
					});
					$("[data-toggle='tooltip']").tooltip();
					
				});
				$secondBox.slideDown("fast");	
			}
			$("[data-toggle='tooltip']").tooltip();
		});
	});
	//点击之后的span右下角图标更改
	$(".top_menu_box span").click(function(){
		$(this).find(".menuLiArrow").attr("src","resource/images/Triangle02.png");
		$(this).siblings().find(".menuLiArrow").attr("src","resource/images/Triangle.png");
		$(".second_menu_box span").click(function(){
			$(this).find(".menuLiArrow").attr("src","resource/images/Triangle02.png");
			$(this).siblings().find(".menuLiArrow").attr("src","resource/images/Triangle.png");
		});
	});
	
	//隐藏无菜单的软件
	$(".menu_dl").each(function(){
		if($(this).find(".menu .topMenuItem").size()<=0){
			$(this).find(".app").hide();
			$(".app_Title").hide();
		}else{
			$(".app_Title").html("<div><i class='iconfont-h5'>&#xe04b;</i>" + $appTitle.text() + "</div>");
			$(".noApp").hide();	//隐藏无发起内容的提示
		}
	});

	function urlLink(liId){

		var $a = $("#"+liId);	
		var url = $a.attr("_href");
		var target = $a.attr("_target");
		
		if (url.indexOf("_backURL=")<=0) {//添加returnURL，实现返回时关闭当前TAB
			url += url.indexOf("?")>0 ? "&_backURL=../../../portal/H5/closeTab.jsp" : "?_backURL=../../../portal/H5/closeTab.jsp";
		}
		if (top && top.addTab && target != "_blank") {
			top.addTab($a.attr("id"),
					$a.text(),
					url);
		}
		else {
			window.open(url, $a.text());
		}
	};
	$("[data-toggle='tooltip']").tooltip();
});




</script>
</head>
<body>
<div class="con_right">
<div class="launch">
	<!-- <div class="noApp">无菜单内容</div> -->
	<div class="app_Title"></div>
	<div class="app_List">
		<div class="top_menu_box clearfix"></div>
		<div class="second_menu_box clearfix" style="display:none"></div>
		<div class="third_menu_box clearfix" style="display:none"></div>
		<div class="noApp">
			<table height="100%" width="100%" border="0">
				<tr>
					<td align="center" valign="middle">
						<div class="content-space-pic iconfont-h5">&#xe050;</div>
						<div class="content-space-txt text-center">没有菜单</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
		<%
		WebUser user = (WebUser) session.getAttribute("FRONT_USER");
		    Collection<String> applicationIds = user.getApplicationIds();

			String applicationId = request.getParameter("application");
			for (String applicationId_ : applicationIds) {

				ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
				ApplicationVO applicationVO = (ApplicationVO) process.doView(applicationId_);
				
				 if(applicationVO == null)
					continue; 
				 if (!applicationVO.isActivated()|| !applicationVO.getId().equals(applicationId))
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
					Collection<ResourceVO> secondMenus = resourceHelper
							.searchSubResource(topMenu.getId(), 1,
									user.getDomainid());
					if (permissionHelper.checkPermission(topMenu,
							applicationId, user)) {
						String desc1 = topMenu.getDescription();
						String mul1 = topMenu.getMultiLanguageLabel();
						String target1 = topMenu.getOpentarget();
						String _target1 = "";
						if ((mul1== null || mul1.length()==0) && desc1 != null && desc1.length() > 8) {
							//desc1 = desc1.substring(0, 6) + ".."
							//		+ desc1.charAt(desc1.length() - 1);
						}
						if (target1==null || "".equals(target1) || "null".equals(target1) || "detail".equals(target1)) {
							_target1="navTab";
						}else{
							_target1="_blank";
						}
						topMenuHtml.append(
								"<li id='" + topMenu.getId() + "'_href='"
										+ topMenu.toUrlString(user, request)
										+ "' _target='"+_target1+"' class='topMenuItem'>")
								.append("<span class='topMenu_title'>"+desc1+"</span>");

						StringBuffer secondMenuHtml = new StringBuffer();
						for (ResourceVO secondMenu : secondMenus) {
							boolean isPermission = permissionHelper
									.checkPermission(secondMenu, applicationId,
											user);

							if (permissionHelper.checkPermission(secondMenu,
									applicationId, user)) {
								String desc2 = secondMenu.getDescription();
								String mul2 = secondMenu.getMultiLanguageLabel();
								String target2 = secondMenu.getOpentarget();
								String _target2 = "";
								if ((mul2== null || mul2.length()==0) && desc2 != null && desc2.length() > 8) {
									//desc2 = desc2.substring(0, 6) + ".."
									//		+ desc2.charAt(desc2.length() - 1);
								}

								if (target2==null || "".equals(target2) || "null".equals(target2) || "detail".equals(target2)) {
									_target2="navTab";
								}else{
									_target2="_blank";
								}

								
								secondMenuHtml.append(
										"<li id='" 
												+ secondMenu.getId()
												+ "' _href='"
												+ secondMenu.toUrlString(user,request) 
												+ "' _type='" + secondMenu.getLinkType() 
												+ "' _target='" + _target2
												+ "' class='secondMenuItem'>").append("<a class='second_title'>"+desc2+"</a>" + "\n");

								
								
								
								Collection<ResourceVO> thirdMenus = resourceHelper
										.searchSubResource(secondMenu.getId(),
												1, user.getDomainid());

								StringBuffer thirdMenuHtml = new StringBuffer();
								for (ResourceVO thirdMenu : thirdMenus) {
									if (permissionHelper.checkPermission(
											thirdMenu, applicationId, user)) {

										String desc3 = thirdMenu.getDescription();
										String mul3=thirdMenu.getMultiLanguageLabel();
										String target3 = thirdMenu.getOpentarget();
										String _target3 = "";
										if ((mul3== null || mul3.length()==0) && desc3 != null && desc3.length() > 8) {
											//desc3 = desc3.substring(0, 6) + ".."
											//		+ desc3.charAt(desc3.length() - 1);
										}
										
										if (target3==null || "".equals(target3) || "null".equals(target3) || "detail".equals(target3)) {
											_target3="navTab";
										}else{
											_target3="_blank";
										}
										
										thirdMenuHtml
												.append("<li id='"
														+ thirdMenu.getId()
														+ "' _href='"
														+ thirdMenu
																.toUrlString(
																		user,
																		request)
														+ "' _type='"+ thirdMenu.getLinkType() +"' _target='" + _target3 +"' class='thirdMenuItem'>")
												.append("<a class='third_title'>"+desc3+"</a>")
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
</div>
</body>
</o:MultiLanguage>
</html>
