<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.resource.action.ResourceAction"%>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<%@page import="cn.myapps.core.resource.action.ResourceHelper"%>
<%@page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.core.resource.action.ResourceUtil"%>
<%@page import="java.util.*"%>
<%@page import="cn.myapps.core.permission.action.PermissionHelper"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
	String contextPath = request.getContextPath();
	String closeUrlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/closeTab.jsp",request,response);
%>

<%
WebUser user = (WebUser) session.getAttribute("FRONT_USER");
Collection<String> applicationIds = user.getApplicationIds();
String applicationId = request.getParameter("application");
String menuStr = "";


for (String applicationId_ : applicationIds) {
	ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
	ApplicationVO applicationVO = (ApplicationVO) process.doView(applicationId_);

	if(applicationVO == null){
		continue;
	}
				
	if (!applicationVO.isActivated()|| !applicationVO.getId().equals(applicationId)){
		continue;
	}

	applicationId = applicationVO.getId();

	menuStr += "{\"appTitle\": \""+applicationVO.getName()+"\",\"appType\": \"menu\",\"contextPath\": \""+contextPath+"\",\"topMenuList\":[";
	
	ResourceAction resource = new ResourceAction();
	ResourceHelper resourceHelper = new ResourceHelper();
	ResourceUtil rUtil = new ResourceUtil();
	PermissionHelper permissionHelper = new PermissionHelper();
	Collection<ResourceVO> topMenus = resource.get_topmenus(applicationId, user.getDomainid());
	int menuSize1 = 0;
	
	for (ResourceVO topMenu : topMenus) {
		Collection<ResourceVO> secondMenus = resourceHelper.searchSubResource(topMenu.getId(), 1,user.getDomainid());
		if (permissionHelper.checkPermission(topMenu,applicationId, user)) {
			menuSize1++;
			boolean isShowTotalRow_topMenu = rUtil.isShowTotalRow(topMenu);
			String totalRow_topMenu = "0";
			if(isShowTotalRow_topMenu){
				totalRow_topMenu = rUtil.getTotalRowByResourceid(topMenu.getId(),request);
				if(Integer.parseInt(totalRow_topMenu)>99) totalRow_topMenu = "99+";
			}
			String desc1 = topMenu.getDescription();
			String mul1 = topMenu.getMultiLanguageLabel();
			String target1 = topMenu.getOpentarget();
			String _target1 = "";
			if (target1==null || "".equals(target1) || "null".equals(target1) || "detail".equals(target1)) {
				_target1="navTab";
			}else{
				_target1="blank";
			}
			String ico1 = topMenu.getIco();
			JSONObject icoJson1 = null;
			if(!StringUtil.isBlank(ico1)){
				icoJson1 = JSONObject.fromObject(ico1);
			}
			
			String _iconType1 = null;
			String _icon1 = null; 
			String _color1 = null;
			if(icoJson1 != null && "font".equals(icoJson1.getString("icontype"))) {
				_iconType1 = "font";
				_icon1 = icoJson1.getString("icon");
				_color1 = icoJson1.getString("iconFontColor");
			} else if (icoJson1 != null && "img".equals(icoJson1.getString("icontype"))) {
				_iconType1 = "img";
				_icon1 = icoJson1.getString("icon");
				_color1 = "#000";
			} else {//兼容旧图标
				_iconType1 = "img";
				_icon1 = "/portal/H5/resource/images/icon_menu_default.png";
				_color1 = "";
			}
			
			menuStr += "{\"topMenuTitle\":\""+desc1+"\",";
			menuStr += "\"topMenuId\":\""+topMenu.getId()+"\",";
			menuStr += "\"topMenuUrl\":\""+topMenu.toUrlString(user, request)+"\",";
			menuStr += "\"topMenuTarget\":\""+_target1+"\",";
			menuStr += "\"topMenuIconType\":\""+_iconType1+"\",";
			menuStr += "\"topMenuIcon\":\""+_icon1+"\",";
			menuStr += "\"topMenuColor\": \""+_color1+"\",";
			menuStr += "\"isShowTotalRow_topMenu\": \""+isShowTotalRow_topMenu+"\",";
			menuStr += "\"totalRow_topMenu\": \""+totalRow_topMenu+"\",";
			menuStr += "\"secondMenuList\": [";
			int menuSize2 = 0;
			                              
			for (ResourceVO secondMenu : secondMenus) {
				boolean isPermission = permissionHelper.checkPermission(secondMenu, applicationId,user);
				if (permissionHelper.checkPermission(secondMenu,applicationId, user)) {
					menuSize2++;
					boolean isShowTotalRow_secondMenu = rUtil.isShowTotalRow(secondMenu);
					String totalRow_secondMenu = "0";
					if(isShowTotalRow_secondMenu){
						totalRow_secondMenu = rUtil.getTotalRowByResourceid(secondMenu.getId(),request);
						if(Integer.parseInt(totalRow_secondMenu)>99) totalRow_secondMenu = "99+";
					}
					String desc2 = secondMenu.getDescription();
					String mul2 = secondMenu.getMultiLanguageLabel();
					String target2 = secondMenu.getOpentarget();
					String _target2 = "";
					if (target2==null || "".equals(target2) || "null".equals(target2) || "detail".equals(target2)) {
						_target2="navTab";
					}else{
						_target2="blank";
					}
					String ico2 = secondMenu.getIco();
					JSONObject icoJson2 = null;
					if(!StringUtil.isBlank(ico2)){
						icoJson2 = JSONObject.fromObject(ico2);
					}
					String _iconType2 = null;
					String _icon2 = null; 
					String _color2 = null;
					if(icoJson2 != null && "font".equals(icoJson2.getString("icontype"))) {
						_iconType2 = "font";
						_icon2 = icoJson2.getString("icon");
						_color2 = icoJson2.getString("iconFontColor");
					} else if (icoJson2 != null && "img".equals(icoJson2.getString("icontype"))) {
						_iconType2 = "img";
						_icon2 = icoJson2.getString("icon");
						_color2 = "#000";
					} else {//兼容旧图标
						_iconType2 = "img";
						_icon2 = "/portal/H5/resource/images/icon_menu_default.png";
						_color2 = "";
					}
					
					menuStr += "{\"secondMenuTitle\":\""+desc2+"\",";
					menuStr += "\"secondMenuId\":\""+secondMenu.getId()+"\",";
					menuStr += "\"secondMenuUrl\":\""+secondMenu.toUrlString(user, request)+"\",";
					menuStr += "\"secondMenuType\":\""+secondMenu.getLinkType()+"\",";
					menuStr += "\"secondMenuTarget\":\""+_target2+"\",";
					menuStr += "\"secondMenuIconType\":\""+_iconType2+"\",";
					menuStr += "\"secondMenuIcon\":\""+_icon2+"\",";
					menuStr += "\"secondMenuColor\": \""+_color2+"\",";
					menuStr += "\"isShowTotalRow_secondMenu\": \""+isShowTotalRow_secondMenu+"\",";
					menuStr += "\"totalRow_secondMenu\": \""+totalRow_secondMenu+"\",";
					menuStr += "\"thirdMenuList\": [";

					Collection<ResourceVO> thirdMenus = resourceHelper.searchSubResource(secondMenu.getId(),1, user.getDomainid());

					StringBuffer thirdMenuHtml = new StringBuffer();
					int menuSize3 = 0; 
					for (ResourceVO thirdMenu : thirdMenus) {	
						if (permissionHelper.checkPermission(thirdMenu, applicationId, user)) {
							menuSize3++;
							boolean isShowTotalRow_thirdMenu = rUtil.isShowTotalRow(thirdMenu);
							String totalRow_thirdMenu = "0";
							if(isShowTotalRow_thirdMenu){
								totalRow_thirdMenu = rUtil.getTotalRowByResourceid(thirdMenu.getId(),request);
								if(Integer.parseInt(totalRow_thirdMenu)>99) totalRow_thirdMenu = "99+";
							}
							String desc3 = thirdMenu.getDescription();
							String mul3=thirdMenu.getMultiLanguageLabel();
							String target3 = thirdMenu.getOpentarget();
							String _target3 = "";
							if (target3==null || "".equals(target3) || "null".equals(target3) || "detail".equals(target3)) {
								_target3="navTab";
							}else{
								_target3="blank";
							}
							String ico3 = thirdMenu.getIco();
							JSONObject icoJson3 = null;
							if(!StringUtil.isBlank(ico3)){
								icoJson3 = JSONObject.fromObject(ico3);
							}
							
							String _iconType3 = null;
							String _icon3 = null; 
							String _color3 = null;
							if(icoJson3 != null && "font".equals(icoJson3.getString("icontype"))) {
								_iconType3 = "font";
								_icon3 = icoJson3.getString("icon");
								_color3 = icoJson3.getString("iconFontColor");
							} else if (icoJson3 != null && "img".equals(icoJson3.getString("icontype"))) {
								_iconType3 = "img";
								_icon3 = icoJson3.getString("icon");
								_color3 = "#000";
							} else {//兼容旧图标
								_iconType3 = "img";
								_icon3 = "/portal/H5/resource/images/icon_menu_default.png";
								_color3 = "";
							}
							
							menuStr += "{\"thirdMenuTitle\":\""+desc3+"\",";
							menuStr += "\"thirdMenuId\":\""+thirdMenu.getId()+"\",";
							menuStr += "\"thirdMenuUrl\":\""+thirdMenu.toUrlString(user, request)+"\",";
							menuStr += "\"thirdMenuType\":\""+thirdMenu.getLinkType()+"\",";
							menuStr += "\"thirdMenuTarget\":\""+_target3+"\",";
							menuStr += "\"thirdMenuIconType\":\""+_iconType3+"\",";
							menuStr += "\"thirdMenuIcon\":\""+_icon3+"\",";
							menuStr += "\"thirdMenuColor\": \""+_color3+"\",";
							menuStr += "\"isShowTotalRow_thirdMenu\": \""+isShowTotalRow_thirdMenu+"\",";
							menuStr += "\"totalRow_thirdMenu\": \""+totalRow_thirdMenu+"\"},";
						}
					}
					if(menuSize3 > 0){
						menuStr = menuStr.substring(0,menuStr.length()-1) + "]},";
					}else{
						menuStr += "]},";
					}
				}
			}
			if(menuSize2 > 0){
				menuStr = menuStr.substring(0,menuStr.length()-1) + "]},";
			}else{
				menuStr += "]},";
			}         
		}
	}
	if(menuSize1 > 0){
		menuStr = menuStr.substring(0,menuStr.length()-1) + "]}";
	}else{
		menuStr += "]}";
	}
}
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%=menuStr%>
</o:MultiLanguage>