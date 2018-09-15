<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@ page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@ page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@ page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@ page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link rel="stylesheet" href="<o:Url value='/resource/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/css/main.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>" />
<script src="resource/js/jquery-1.11.3.min.js"></script>
<script src="resource/js/bootstrap.min.js"></script>
<script src="resource/js/jquery.masonry.min.js"></script>
<script src="resource/js/jquery.nicescroll.js"></script>
<script src="resource/js/jquery.cookie.js"></script>
<script src="resource/js/holmes.js"></script>
<script src="resource/script/flowCenter.js"></script>
<script src="resource/script/common.js"></script>
<script src="./resource/script/template.js"></script>
<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script type="text/javascript">
var contextPath = '<%=contextPath%>';
$(function() {
	FC.initStartFlow();
});
</script>
</head>
<body>
<div id="startflow_html_box">
<%	
WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
ApplicationHelper ah = new ApplicationHelper();
Collection<ApplicationVO> apps = ah.getListByWebUser(user);
for (ApplicationVO applicationVO : apps) {
	String applicationId = applicationVO.getId();
	
	out.print("<dl class='menu_dl' data-appid='"+applicationId+"'><dt class='app'>"
			+ "<span class='appTitle'>"
			+ applicationVO.getName() + "</span></dt>"
			+ "<dd class='menu'>\n");
	
	ResourceAction resource = new ResourceAction();
	ResourceHelper resourceHelper = new ResourceHelper();
	PermissionHelper permissionHelper = new PermissionHelper();
	Collection<ResourceVO> topMenus = resource.get_topmenus4FlowCenter(applicationId, user.getDomainid());

	StringBuffer topMenuHtml = new StringBuffer();
	for (ResourceVO topMenu : topMenus) {
		String topMenuUrl = topMenu.toUrlString(user, request);
		Collection<ResourceVO> secondMenus = resourceHelper.searchSubResource4flowCenter(topMenu.getId(), 1,user.getDomainid());
		if (permissionHelper.checkPermission(topMenu,applicationId, user)) {
			StringBuffer secondMenuHtml = new StringBuffer();
			for (ResourceVO secondMenu : secondMenus) {
				boolean isPermission = permissionHelper.checkPermission(secondMenu, applicationId,user);

				if (permissionHelper.checkPermission(secondMenu,applicationId, user)) {
					Collection<ResourceVO> thirdMenus = resourceHelper.searchSubResource4flowCenter(secondMenu.getId(),1, user.getDomainid());

					StringBuffer thirdMenuHtml = new StringBuffer();
					for (ResourceVO thirdMenu : thirdMenus) {
						String thirdMenuUrl = thirdMenu.toUrlString(user, request);
						if (permissionHelper.checkPermission(thirdMenu, applicationId, user)) {
							//组合三级菜单
							if (("00".equals(thirdMenu
									.getLinkType())
									&& thirdMenuUrl != null && thirdMenuUrl
									.trim().length() > 0)) {
								String desc3 = thirdMenu.getDescription();
								String ico = thirdMenu.getIco();
								JSONObject icoJson = null;
								if(!StringUtil.isBlank(ico)){
									icoJson = JSONObject.fromObject(ico);
								}
								
								String _iconType = null;
								String _icon = null; 
								String _color = null;
								if(icoJson != null && "font".equals(icoJson.getString("icontype"))) {
									_iconType = "font";
									_icon = icoJson.getString("icon");
									_color = icoJson.getString("iconFontColor");
								} else if (icoJson != null && "img".equals(icoJson.getString("icontype"))) {
									_iconType = "img";
									_icon = icoJson.getString("icon");
									_color = "#000";
								} else {//兼容旧图标
									_iconType = "img";
									_icon = "/portal/H5/resource/images/icon_menu_default.png";
									_color = "";
								}
								thirdMenuHtml
										.append("<li id='"
												+ thirdMenu.getId()
												+ "' _href='"
												+ thirdMenuUrl
												+ "' _iconType='"
												+ _iconType
												+ "' _icon='"
												+ _icon
												+ "' _color='"
												+ _color
												+ "' class='thirdMenuItem'>")
										.append("<a class='third_title'>"+desc3+"</a>")
										.append("</li>\n");
							}
						}
					}

					//组合二级菜单，没有url，且没有子菜单，则不输出
					String secondMenuUrl = secondMenu.toUrlString(user, request);
					if (thirdMenuHtml.length() > 0
							|| ("00".equals(secondMenu
									.getLinkType())
									&& secondMenuUrl != null && secondMenuUrl
									.trim().length() > 0)) {
						String desc2 = secondMenu.getDescription();
						String ico = secondMenu.getIco();
						JSONObject icoJson = null;
						if(!StringUtil.isBlank(ico)){
							icoJson = JSONObject.fromObject(ico);
						}
						
						String _iconType = null;
						String _icon = null; 
						String _color = null;
						if(icoJson != null && "font".equals(icoJson.getString("icontype"))) {
							_iconType = "font";
							_icon = icoJson.getString("icon");
							_color = icoJson.getString("iconFontColor");
						} else if (icoJson != null && "img".equals(icoJson.getString("icontype"))) {
							_iconType = "img";
							_icon = icoJson.getString("icon");
							_color = "#000";
						} else {//兼容旧图标
							_iconType = "img";
							_icon = "/portal/H5/resource/images/icon_menu_default.png";
							_color = "";
						}
						secondMenuHtml.append(
								"<li id='" + secondMenu.getId()
								+ "' _href='"
								+ secondMenuUrl 
								+ "' _iconType='"
								+ _iconType 
								+ "' _icon='"
								+ _icon 
								+ "' _color='"
								+ _color + "' class='secondMenuItem'>")
								.append("<a class='second_title'>"+desc2
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
				String ico = topMenu.getIco();
				JSONObject icoJson = null;
				if(!StringUtil.isBlank(ico)){
					icoJson = JSONObject.fromObject(ico);
				}
				
				String _iconType = null;
				String _icon = null; 
				String _color = null;
				if(icoJson != null && "font".equals(icoJson.getString("icontype"))) {
					_iconType = "font";
					_icon = icoJson.getString("icon");
					_color = icoJson.getString("iconFontColor");
				} else if (icoJson != null && "img".equals(icoJson.getString("icontype"))) {
					_iconType = "img";
					_icon = icoJson.getString("icon");
					_color = "#000";
				} else {//兼容旧图标
					_iconType = "font";
					_icon = "fa fa-th-large";
					_color = "";
				}
				topMenuHtml.append(
						"<li id='" + topMenu.getId() + "'_href='"
								+ topMenuUrl
								+ "' _iconType='"
								+ _iconType 
								+ "' _icon='"
								+ _icon 
								+ "' _color='"
								+ _color + "' class='topMenuItem'>").append("<span class='topMenu_title'>"+
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
</div>

<div id="startflow" class="menu_content">
	<div class="content-space" id="content-space" style="display:none">
		<table height="100%" width="100%" border="0">
			<tr>
				<td align="center" valign="middle">
					<div class="content-space-pic iconfont-h5">&#xe050;</div>
					<div class="content-space-txt text-center">没有发起菜单</div>
				</td>
			</tr>
		</table>
	</div>
	
	
	<ul class="nav nav-tabs startflow-tabs" role="tablist">
	    <div class="startflow-top-group pull-right">
	    	<div class="input-group search-group pull-right">
				<input id="startflow-search" name="search"  type="text" class="form-control" placeholder="请输入搜索内容" data-list=".startflow-content" autocomplete="off" aria-describedby="basic-addon2">
				<span class="input-group-addon" id="basic-addon2"><i class="fa fa-search"></i></span>
			</div>
	    	<div class="btn-group pull-right" role="group">
			  <button type="button" class="btn btn-startflow active" data-view="list"><i class="fa fa-list"></i></button>
			  <button type="button" class="btn btn-startflow" data-view="icon"><i class="fa fa-th-large"></i></button>
			</div>
			
	    </div>
	</ul>
<div class="startflow-content-box">
	<div class="tab-content startflow-content"></div>
</div>
</div>
</body>

<script type="text/html" id="atp-startflow-tabs">
{{each appList as _appList}}
{{if _appList.topMenuList.length > 0}}
<li class=""><a href="#{{_appList.appId}}" data-toggle="tab">{{_appList.appTitle}}</a></li>
{{/if}}
{{/each}}
</script>

<script type="text/html" id="atp-startflow">
{{each appList as _appList}}
<div role="tabpanel" class="tab-pane fade" id="{{_appList.appId}}">
<div class="startflow-list" >
	{{each _appList.topMenuList as _topMenu}}
	<div class="search-item menu-item">
		{{if _topMenu.secondMenuList.length > 0}}
		<div class="menu-title"><h4><span class="menu-nolink">{{_topMenu.topMenuTitle}}</span></h4></div>
		<ul class="menu-ul">
			{{each _topMenu.secondMenuList as _secondMenu}}
			{{if _secondMenu.thirdMenuList.length > 0}}
			{{each _secondMenu.thirdMenuList as _thirdMenu}}
			<li class="menu-li"><a class="menu-link" data-id="{{_thirdMenu.thirdMenuId}}" data-url="{{_thirdMenu.thirdMenuUrl}}">{{#_thirdMenu.thirdMenuIcon}} {{_thirdMenu.thirdMenuTitle}}</a></li>
			{{/each}}
			{{else}}
			<li class="menu-li"><a class="menu-link" data-id="{{_secondMenu.secondMenuId}}" data-url="{{_secondMenu.secondMenuUrl}}">{{#_secondMenu.secondMenuIcon}} {{_secondMenu.secondMenuTitle}}</a></li>
			{{/if}}
			{{/each}}
		</ul>
		{{else}}
		<div class="menu-title"><h4><a class="menu-link" data-id="{{_topMenu.topMenuId}}" data-url="{{_topMenu.topMenuUrl}}">{{_topMenu.topMenuTitle}}</a></h4></div>
		{{/if}}
		<div class="menu-border-bottom"></div>
	</div>
	{{/each}}
</div>
<div class="startflow-icon" style="display:none">
	{{each _appList.topMenuList as _topMenu}}
	<div class="search-item menu-item-icon">
		{{if _topMenu.secondMenuList.length > 0}}
		<div class="menu-title"><h5>{{_topMenu.topMenuTitle}}</h5></div>
		<ul class="menu-ul-icon">
			{{each _topMenu.secondMenuList as _secondMenu}}
			{{if _secondMenu.thirdMenuList.length > 0}}
			{{each _secondMenu.thirdMenuList as _thirdMenu}}
			<li class="menu-li-icon text-center">
				<a class="menu-link" data-id="{{_thirdMenu.thirdMenuId}}" data-url="{{_thirdMenu.thirdMenuUrl}}" title="{{_thirdMenu.thirdMenuTitle}}">
					<div class="menu-link-icon"><i class="fa fa-th-large 1"></i></div>
					<div class="menu-link-text">{{_thirdMenu.thirdMenuTitle}}</div>
				</a>
			</li>
			{{/each}}
			{{else}}
			<li class="menu-li-icon text-center">
				<a class="menu-link" data-id="{{_secondMenu.secondMenuId}}" data-url="{{_secondMenu.secondMenuUrl}}" title="{{_secondMenu.secondMenuTitle}}">
					<div class="menu-link-icon">{{#_secondMenu.secondMenuIcon}}</div>
					<div class="menu-link-text">{{_secondMenu.secondMenuTitle}}</div>
				</a>
			</li>
			{{/if}}
			{{/each}}
		</ul>
		{{else}}
		<div class="menu-title"><h5><a class="menu-link" data-id="{{_topMenu.topMenuId}}" data-url="{{_topMenu.topMenuUrl}}"><i class="fa fa-th-large"></i> {{_topMenu.topMenuTitle}}</a></h5></div>
		{{/if}}
	</div>
	{{/each}}
</div>
</div>
{{/each}}
</script>
</html>
</o:MultiLanguage>