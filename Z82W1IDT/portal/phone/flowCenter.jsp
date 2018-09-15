<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="myapps" prefix="o"%>
<!-- flowcenter -->
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="java.util.*"%>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="applicationHelper" />
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<div class="weui_tab">
	<div class="weui_navbar">
		<div class="weui_navbar_item weui_bar_item_on" _for="startFlow">
			<div class="navbar-item-box">
				<i class="iconfont if-phone-adduser"></i>
				<div class="navbar-title">{*[flow.start]*}</div>
			</div>
		</div>
		<div class="weui_navbar_item" _for="pending">
			<div class="navbar-item-box">
				<i class="iconfont if-phone-clock"></i>
				<div class="navbar-title">{*[flow.Pending]*}</div>
				<span style="display:none;"></span>
			</div>
		</div>
		<div class="weui_navbar_item" _for="processing">
			<div class="navbar-item-box">
				<i class="iconfont if-phone-chat"></i>
				<div class="navbar-title">{*[flow.processing]*}</div>
				<span style="display:none;"></span>
			</div>
		</div>
		<div class="weui_navbar_item" _for="finished">
			<div class="navbar-item-box">
				<i class="iconfont if-phone-searcherror"></i>
				<div class="navbar-title">{*[History]*}</div>
			</div>
		</div>
	</div>
	

	
	<div class="weui_tab_bd">
		<div id="flow-center-panel" style="height: 100%;padding-bottom: 50px;overflow: auto;background-color: #fff;">
			<div id="startFlow" name="flowCenterDiv">
			<div class="launch">
			<div class="noApp">无菜单内容</div>
				<%
				WebUser user = (WebUser) request.getSession().getAttribute(
					Web.SESSION_ATTRIBUTE_FRONT_USER);
					ApplicationHelper ah = new ApplicationHelper();
					Collection<ApplicationVO> appList = ah.getListByDomainId(user.getDomainid());
					String appIdCur = request.getParameter("application");
		
				int appNum = 0;
				
					String applicationId = request.getParameter("application");
					for (ApplicationVO applicationVO : appList) {
						appNum++;
						if (!applicationVO.isActivated())
							continue;
		
						applicationId = applicationVO.getId();
		
						out.print("<dl id='appNum_"+applicationId+"' class='menu_dl'><dt class='app'>"
								+ "<span class='appTitle'>"
								+ applicationVO.getName() + "</span></dt>"
								+ "<dd class='menu'>\n");
						ResourceAction resource = new ResourceAction();
		
						ResourceHelper resourceHelper = new ResourceHelper();
		
						PermissionHelper permissionHelper = new PermissionHelper();
		
						Collection<ResourceVO> topMenus = resource.get_topmenus4MobileFlowCenter(
								applicationId, user.getDomainid());
		
						StringBuffer topMenuHtml = new StringBuffer();
		
						for (ResourceVO topMenu : topMenus) {
							String topMenuUrl = topMenu.toUrlString(user, request);
							Collection<ResourceVO> secondMenus = resourceHelper
									.searchSubResource4MobileflowCenter(topMenu.getId(), 1,
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
												.searchSubResource4MobileflowCenter(secondMenu.getId(),
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
														_icon = "/portal/phone/resource/images/icon_menu_default.png";
														_color = "";
													}
													
													if (desc3 != null && desc3.length() > 5) {
														//desc3 = desc3.substring(0, 4) + ".."
														//		+ desc3.charAt(desc3.length() - 1);
													}
													thirdMenuHtml.append(
														"<li id='"
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
										String secondMenuUrl = secondMenu.toUrlString(
												user, request);
										if (thirdMenuHtml.length() > 0
												|| ("00".equals(secondMenu
														.getLinkType())
														&& secondMenuUrl != null && secondMenuUrl
														.trim().length() > 0)) {
											String desc2 = secondMenu.getDescription();
											if (desc2 != null && desc2.length() > 5) {
												//desc2 = desc2.substring(0, 4) + ".."
												//		+ desc2.charAt(desc2.length() - 1);
											}
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
												_icon = "/portal/phone/resource/images/icon_menu_default.png";
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
												.append("<a class='second_title'>"+desc2+ "</a>\n");
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
										_iconType = "img";
										_icon = "/portal/phone/resource/images/icon_menu_default.png";
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
				<!-- <ul class="nav nav-tabs launch-tab" role="tablist"></ul> -->
				<div class="tab-content launch-tab-content"></div>
			</div>
			</div>
			<div id="pendingApp" data-enhance="false" style="display: none;">
			<%
		
				for (ApplicationVO appVO1 : appList) {
					if (!appVO1.isActivated())
						continue;
					String appid1 = appVO1.getId();
					out.println("<ul style='display:none' refreshId='" + appid1 + "' _appId='" + appid1 + "' _appName='"
							+ appVO1.getName() + "' _url='../dynaform/work/pendingList.action?application=" + appid1 + "'>");
					out.println("Loading......</ul>");
				}
			%>
			</div>
			<div id="pending" name="flowCenterDiv" style="display:none;" class="pending">
			</div>
			<div id="processingApp" data-enhance="false" style="display: none;">
				<%
					for (ApplicationVO appVO2 : appList) {
						if (!appVO2.isActivated())
							continue;
						if (appIdCur != null && appIdCur.trim().length() > 0 && !appIdCur.equalsIgnoreCase("null") && !appIdCur.equals(appVO2.getId())) 
							continue;
						String appId2 = appVO2.getId();
						out.println("<ul refreshId='" + appId2 + "' _appId='" + appId2 + "' _appName='"
								+ appVO2.getName() + "' _url='../dynaform/work/processedList.action?application=" + appId2 + "'>");
			
						out.println("</ul>");
					}
				%>
			</div>
			<div id="processing" name="flowCenterDiv" style="display:none;" class="pending">
			</div>
			<div id="finished" name="flowCenterDiv" style="display:none;" class="finished">			
				<div class="card_app">
		    		<div id="searchForm" class="search-box">
			    		<input id="application" type="hidden" name="application" value="<%=appIdCur%>" />
		    			<a id="finish-pend" class="ui-btn ui-btn-b ui-corner-all btn finish-pend pull-left">
		    				<span class="finish-pend-icon">
		    					<i class="fa fa-square-o" aria-hidden="true">
		    					</i>
		    				</span>我发起的
		    			</a>
		    			<input name="_subject" id="_subject" class="subject1 search pull-left" placeholder="主题" type="text" value='<s:property value="#parameters._subject"/>'>
		    			<button id="searchBtn" class="ui-btn ui-btn-b ui-corner-all btn search-btn pull-left"><!-- {*[Search]*} -->
		    				<span class="icon icon-search"></span>
		    			</button>
		    			<input id="_currpage" type="hidden" name="_currpage" value="1" />
						<input id="_pagelines" type="hidden" name="_pagelines" value="15" />
						<input id="_isMyWorkFlow" type="hidden" name="_isMyWorkFlow" value="" />
		  			</div>
				</div>
				<div id="content-load-panel" style="display:none;">
					<div id="content-space" class="text-center">
						<div class="content-space-icon icon-619 icon iconfont">&#xe619;</div>
						<div class="content-space-icon icon-61a icon iconfont" style="display:none;">&#xe61a;</div>
						<div class="content-space-h1">当前没有任何查询</div>
						<div class="content-space-h2">点击查询的结果将显示在这里</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



</o:MultiLanguage>