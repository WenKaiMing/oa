<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.domain.ejb.DomainVO"%>
<%@ page import="cn.myapps.constans.Environment"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%@ page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.email.util.EmailConfig"%>
<%@ page import="cn.myapps.extendedReport.NDataSource"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String userId = user.getId();
	String contextPath = request.getContextPath();
	DomainHelper dh = new DomainHelper();
%>

<%
String mainMenuStr = "";
String menuStr = "";
String menuAppStr = "";
Collection<String> applicationIds = user.getApplicationIds();
for (String applicationId_ : applicationIds) {
	ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
	ApplicationVO applicationVO = (ApplicationVO) process.doView(applicationId_);	
	if(applicationVO == null){
		continue;
	}
	if (!applicationVO.isActivated()){
		continue;
	}
		
	String applicationId = applicationVO.getId();							
	String desc = applicationVO.getName().trim();
	String title = desc;
	
	menuAppStr += "{\"appid\":\""+applicationId+"\",";
	menuAppStr += "\"appTitle\":\""+title+"\",";
	menuAppStr += "\"appType\":\"menu\",";
	menuAppStr += "\"appMenu\":[]},";
}


//判断是否开启ERP报表				
if(NDataSource.isErpEnable()){
	
	menuStr += ",{\"appid\":\"tabs_erp\",\"appTitle\":\"ERP\",\"appType\":\"other\",\"appMenu\":[";
	menuStr += "{\"listId\":\"tabs_erp_report\",\"listUrl\":\"../../extendedReport/erpReport/goodsonhand.jsp\",\"listTitle\":\"ERP报表\"},";
	menuStr += "{\"listId\":\"tabs_erp_data\",\"listUrl\":\"../../extendedReport/erpSearch/searchDept.jsp\",\"listTitle\":\"ERP数据查询\"},";
	menuStr += "{\"listId\":\"tabs_erp_add\",\"listUrl\":\"../../extendedReport/erpOrder/orderPurchase.jsp\",\"listTitle\":\"ERP订单\"}]}";
}

//判断是否开启KM
if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.KM)){
	menuStr += ",{\"appid\":\"tabs_knowledge\",\"appTitle\":\"{*[km.name]*}\",\"appType\":\"other\",\"appMenu\":[";
	menuStr += "{\"listId\":\"hotest\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_01.png\",\"listUrl\":\"../../km/disk/listHotest.action\",\"listTitle\":\"{*[cn.myapps.km.disk.popular_share]*}\"},";
	menuStr += "{\"listId\":\"newest\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_02.png\",\"listUrl\":\"../../km/disk/listNewest.action\",\"listTitle\":\"{*[cn.myapps.km.latest_upload]*}\"},";
	menuStr += "{\"listId\":\"publicDisk\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_03.png\",\"listUrl\":\"../../km/disk/view.action?_type=1\",\"listTitle\":\"{*[cn.myapps.km.disk.public_disk]*}\"},";
	menuStr += "{\"listId\":\"personalDisk\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_04.png\",\"listUrl\":\"../../km/disk/view.action?_type=2\",\"listTitle\":\"{*[cn.myapps.km.disk.my_disk]*}\"},";
	menuStr += "{\"listId\":\"archiveDisk\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_05.png\",\"listUrl\":\"../../km/disk/view.action?_type=5\",\"listTitle\":\"{*[cn.myapps.km.disk.archive_disk]*}\"}";
	
	if(dh.isKmDomainAdmin(user)){
		menuStr += ",{\"listId\":\"adminMessage\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_05.png\",\"listUrl\":\"../../km/admin/admin.jsp?domain="+user.getDomainid()+"\",\"listTitle\":\"企业管理员\"}";
	}
	menuStr += "]}";
	//隐藏KM百科
	//menuStr += "{\"listId\":\"baike\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_km_06.png\",\"listUrl\":\"../../km/baike/entry/doInit.action\",\"listTitle\":\"{*[km.encyclopedia]*}\"}]}";	
}

//pm
if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.PM)){
	menuStr += ",{\"appid\":\"tabs_pm\",\"appTitle\":\"{*[front.task]*}\",\"appType\":\"other\",\"appMenu\":[";
	menuStr += "{\"listId\":\"tabs_pm_task\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_pm_01.png\",\"listUrl\":\"../../pm/h5-task.jsp#task\",\"listTitle\":\"{*[front.task.my_task]*}\"},";
	menuStr += "{\"listId\":\"tabs_pm_project\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_pm_02.png\",\"listUrl\":\"../../pm/h5-task.jsp#project\",\"listTitle\":\"{*[front.task.project]*}\"}]}";
}

//qm
if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.QM)){
	menuStr += ",{\"appid\":\"tabs_qm\",\"appTitle\":\"{*[front.survey]*}\",\"appType\":\"other\",\"appMenu\":[";
	menuStr += "{\"listId\":\"tabs_qm_homepage\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_qm_01.png\",\"listUrl\":\"../../qm/answer/index.jsp\",\"listTitle\":\"{*[front.survey.home_page]*}\"},";
	menuStr += "{\"listId\":\"tabs_qm_center\",\"topMenuIconType\":\"img\",\"topMenuIcon\":\"/portal/H5/resource/images/icon_menu/icon_menu_qm_02.png\",\"listUrl\":\"../../qm/questionnaire/list.action\",\"listTitle\":\"{*[front.survey.issued]*}\"}]}";
}


if(applicationIds.size() <= 0){
	menuStr = menuStr.substring(1);
}else{
	menuStr = menuAppStr.substring(0,menuAppStr.length()-1) + menuStr;
}

//结束
mainMenuStr = "{\"menuList\":[" + menuStr + "]}";
%>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="renderer" content="webkit">
<!-- webkit|ie-comp|ie-stand : chrome内核|ie兼容内核|ie标准内核 -->
<title>
	<s:if test="#session.FRONT_USER.getDomain().getSystemName().length()>0">
	<s:property value="#session.FRONT_USER.getDomain().getSystemName()"/></s:if>
	<s:else>{*[front.teemlink]*} OA</s:else>
</title>
<link rel="shortcut icon" type="images/x-icon" href="<s:url value='../share/images/logo/logo32x32.ico'/>" media="screen" />
<link href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>" rel="stylesheet" />
<script src="resource/js/jquery-1.11.3.min.js"></script>
<script src="resource/component/artDialog/jquery.artDialog.source.js?skin=aries"></script>
<%
boolean isDebug = false;
if(isDebug){
%>
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="resource/css/animate.css" />
<link rel="stylesheet" href="resource/css/main.css" />

<script src="resource/js/bootstrap.min.js"></script>
<script src="resource/js/jquery.slimscroll.min.js"></script>
<script src="resource/script/template.js"></script>
<script src="resource/script/common.js"></script>
<script src="resource/js/obpm.main.core.js"></script>
<script src="resource/js/obpm.main.service.js"></script>

<!-- 弹出层插件--start -->

<script src="resource/component/artDialog/plugins/iframeTools.source.js"></script>
<script src="resource/component/artDialog/obpm-jquery-bridge.js"></script>
<!-- 弹出层插件--end -->

<!-- 通知插件--start -->
<link rel="stylesheet" href="resource/component/showMessage/sweetalert/sweetalert.css" />
<link rel="stylesheet" href="resource/component/showMessage/toastr/toastr.css" />
<script src="resource/component/showMessage/sweetalert/sweetalert.min.js"></script>
<script src="resource/component/showMessage/toastr/toastr.min.js"></script> 
<script src="resource/component/showMessage/obpm.showMessage.js"></script>
<!-- 通知插件--end -->
<%
}else{
%>
<%@ include file="/portal/H5/resource/common/main_css.jsp" %>
<%@ include file="/portal/H5/resource/common/main_js.jsp" %>
<%
}
%>
<script>
	var current_page = '{*[front.current_page]*}';
	var contextPath = "<%=contextPath%>";	//膏药，兼容getAvatar方法
</script>
</head>
<body>
<input type="hidden" id="userId" name="userId" value="<%=userId%>">
<input type="hidden" id="contextPath" name="contextPath" value="<%=contextPath%>">
<textarea id="main-menu-data" style="display:none"><%=mainMenuStr%></textarea>
<div id="wrapper">
	<!-- top-navbar -->
	<nav class="header navbar">
		<div class="header-inner">
			<div class="navbar-item logo text-center">
				<img src='<s:url value="/portal/share/images/logo/logo-H5.png"/>' title="{*[page.title]*}" />
			</div>
			<div class="navbar-item weather text-center">
				<div style="width: 150px;line-height: normal;margin: 15px 15px 0;">
    				<div id="tp-weather-widget" style="right:0"></div>
					<script>(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.charset="utf-8";P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.seniverse.com/widget/chameleon.js"))</script>
					<script>
						tpwidget("init", {   
						    	"flavor": "slim",
						        "location": "WX4FBXXFKE4F",
						        "geolocation": "enabled",
						        "language": "zh-chs",
						        "unit": "c",
						        "theme": "chameleon",
						        "container": "tp-weather-widget",
						        "bubble": "enabled",
						        "alarmType": "circle",
						        "color": "#FFFFFF",
						        "uid": "UB9ACFFF2B",
						        "hash": "a4ec733b40d2ee9219b4cb93e0b67159"
						});
						tpwidget("show");
					</script>
				</div>
			</div>
			<div class="navbar-item navbar-tabs">
				<div class="navbar-tabs-panel">
					<ul class="navbar-tabs-ul">
						<li class="navbar-tabs-item selected" data-id="tabs_homepage">
							<a class="tab-btn-title" data-id="tabs_homepage" data-url="homepage.jsp">
								<div class="nav-title">{*[Home]*}</div>
							</a>
						</li>
					</ul>
				</div>
				
				<div id="navbar-tabs-preview">
					<a><div class="iconfont-h5" title="预览">&#xe048;</div><span class="badge">1</span></a>
				</div>
			</div>
			<div class="navbar-item navbar-menu text-center clearfix">
				
				<div class="top-user pull-right">
					
	    			<div class="user-box dropdown">
	    				<span class="badge" style="display:none"></span>
						<%
							if (user.getAvatarUri() != "" && user.getAvatarUri() != null) {
								out.println("<img src='"+ user.getAvatarUri() + "' class=\"dropdown-toggle\" data-toggle=\"dropdown\" aria-expanded=\"true\" />");
							} else {
								out.println("<img src='resource/images/t002.png' class=\"dropdown-toggle\" data-toggle=\"dropdown\" aria-expanded=\"true\" />");
							}
						%>
						<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
							<li class="user-message" role="presentation">
								<a title="消息中心" data-url="<s:url value="/message/message.jsp"/>">
									<i class="fa fa-volume-up"></i>消息中心 <span class="badge" style="display:none"></span>
								</a>
							</li>
							<li class="user-manageDomain" role="presentation">
								<%
									if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
										if("true".equals(DefaultProperty.getProperty("saas"))){
											out.println("<a id='controlPanel' title='{*[cn.myapps.core.main.domain_management]*}' href='../../saas/weioa/controlPanel.jsp'><span class='iconfont-h5'>&#xe054;</span>{*[front.Management]*}</a>");
										}else{
											out.println("<a id='manageDomain' title='{*[cn.myapps.core.main.domain_management]*}' _url='../domain/edit.action?domain="+user.getDomainid()+"'><span class='iconfont-h5'>&#xe054;</span>{*[front.Management]*}</a>");
										}
									}
								%>
							</li>
							<li class="user-person-setting" role="presentation"><a role="menuitem" tabindex="-1" href="#"><span  class="iconfont-h5">&#xe04a;</span>{*[PersonalSettings]*}</a></li>
							<li class="user-logout" role="presentation">
								<a data-toggle="modal" data-target="#myModal"><span  class="iconfont-h5">&#xe049;</span>{*[Logout]*}</a>
							</li>  
						</ul>
					</div>
				</div>
				<div class="message-popup" style="display:none">
					<div class="message-popup-close"><i class="fa fa-times"></i></div>
					<ul>
						<li data-id="0" style="display:none"><span class="message-popup-num"></span><span>新消息提醒</span><span class="message-popup-active" data-url="<s:url value="/message/message.jsp"/>">点击查看</span></li>
						<li data-id="1" style="display:none"><span class="message-popup-num"></span><span>新公告提醒</span><span class="message-popup-active" data-url="<s:url value="/message/message.jsp?active=announcement"/>">点击查看</span></li>
						<li data-id="2" style="display:none"><span class="message-popup-num"></span><span>新回复提醒</span><span class="message-popup-active" data-url="<s:url value="/message/message.jsp?active=comment"/>">点击查看</span></li>
						<li data-id="3" style="display:none"><span class="message-popup-num"></span><span>新事项提醒</span><span class="message-popup-active" data-url="<s:url value="/message/message.jsp?active=notice"/>">点击查看</span></li>
					</ul>
				</div>
				<div class="top-tool-bar pull-right">
					<%
					if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER) && DomainVO.WEIXIN_PROXY_TYPE_CLOUD.equals(user.getDomain().getWeixinProxyType())){
					%>
		 			<!-- <div class="b_setting fl"><a href="http://yun.weioa365.com/weixin/main?siteId=<%=Environment.getMACAddress() %>&domainId=<%=user.getDomainid()%>"><div class="iconfont-h5" title="微信设置">&#xe04a;</div></a></div> -->
					<%} %>
      				<!--<div class="b_exit fl"><a href="./logout.jsp"><div class="glyphicon"  title="注销">&#xe017;</div></a></div> -->   
    			</div>
    			
			</div>
		</div>
	</nav>
	<!-- left-sidebar -->
	<div class="sidebar">
 		<div class="menu">
 			<ul id="tabs_flowcenter" class="tabs_menu sidebar-menu">
		        <li tabid="tabs_flowcenter" menu="show" class="active">
		        	<a href="#flowMeun" class="nav-header menu-first" data-toggle="collapse" >
		        		<span class="icon_main_menu icon_flowcenter"></span><h5>{*[front.workflowcenter]*}</h5>
		        	</a>
		        	<ul id="flowMeun" class="nav nav-list collapse menu-second in">
				        <li tabid="launch" menu="open" data-title="{*[front.workflowcenter.new]*}"><a data-url="startFlow.jsp"><span class="main-menu_title">{*[front.workflowcenter.new]*}</span></a></li>
					    <li tabid="pending" menu="open" data-title="{*[front.workflowcenter.pending]*}"><a data-url="pending.jsp"><span class="main-menu_title">{*[front.workflowcenter.pending]*}</span></a></li>
					    <li tabid="processed" menu="open" data-title="{*[front.workflowcenter.tracking]*}"><a data-url="processing.jsp"><span class="main-menu_title">{*[front.workflowcenter.tracking]*}</span></a></li>
					    <!-- <li tabid="finished" menu="open"><a data-url="finished.jsp">{*[front.workflowcenter.history]*}</a></li> -->
					    <li tabid="dashboard" menu="open" data-title="{*[front.workflowcenter.analyze]*}"><a data-url="dashboard.jsp"><span class="main-menu_title">{*[front.workflowcenter.analyze]*}</span></a></li>
			    	</ul>	    	
		        </li>
   			</ul>
 			<ul id="tabs_menu" class="tabs_menu sidebar-menu"></ul>
 		</div>
 		<div id="menu-list-box" class="menu-list text-center clearfix"></div>
 		<div class="arrow-zoom" data-zoom="out"><i class="fa fa-caret-left"></i></div>
 	</div>
 	
 	<div class="sidebar-small text-center sidebar-hidden">
 		<div class="menu-small-mask"></div>
 		
 		<div class="arrow-zoom" data-zoom="in"><i class="fa fa-caret-right"></i></div>
 	</div>
 	
 	<!-- right-page -->
  	<div id="tabs" class="page-wrapper tab-content">  	
		<div id="tabsLoading" class="tabs-loading" style="z-index:1;"></div>
		<div class="tabs-item-wrapper fadeInRightMain animated tab-pane active" id="tabs_homepage" style='z-index:2;position: relative;background: #f6f7fb;'>
			<iframe style='border-top: 0px #e7eef5 solid;width:100%;height:100%' id="iframe-homepage" _tags="window" src="homepage.jsp" frameborder='no' border='0' marginwidth='0' marginheight='0' width='' scrolling='auto' allowtransparency='yes'></iframe>
		</div>	
	</div>
</div>

<div id="tabsPreview">
	<ul class="tabs-preview-panel">
		<li data-id="tabs_homepage" class="animatedFast zoomIn active" >
			<a href="#tabs_homepage" data-url="homepage.jsp">
				<div class='status-box'><span class='status'>{*[front.current_page]*}</span></div>
				<div class="nav-title">{*[Home]*}</div>
			</a>
			<img src="../share/images/logo/tab-home.jpg" style="width: 100%;height: 100%;">
			<i class='ui-icon ui-icon-close glyphicon glyphicon-lock' role='presentation'></i>
		</li>
	</ul>
	<div class="nav-closeAll">
		<a class="nav-closeAll-btn">{*[front.close_all]*}</a>
	</div>
</div>

<!-- 遮挡层 -->
<div id="backBlur" style="display:none"></div>

<!-- 退出弹出层 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel"><div class="glyphicon"  title="{*[Logout]*}">&#xe017;</div></h4>
			</div>
			<div class="modal-body">{*[front.logout.logout_or_not]*}</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">{*[front.logout.cancel]*}</button>
				<a href="./logout.jsp" style="display:inline-block"><button type="button" class="btn btn-primary">{*[front.logout.exit]*}</button></a>
			</div>
		</div>
	</div>
</div>

</body>
<script type="text/html" id="atp-main-menu-item">
{{each menuList as value i}}
<div class="menu-item pull-left{{if i+1 == menuList.length && (i+1)%2 == 1}} w100{{else}} w50{{/if}}">
<a title="{{value.appTitle}}" data-id="{{value.appid}}" data-type="{{value.appType}}" data-num="{{i}}">
{{value.appTitle}}
</a>
</div>
{{/each}}
</script>
<script type="text/html" id="atp-main-menu-list">
<div class="main-menu-app-title">{{appTitle}}</div>
{{if appType == "menu"}}
{{each topMenuList as _topMenuList i}}
<li tabid="{{_topMenuList.topMenuId}}" data-title="{{_topMenuList.topMenuTitle}}" menu="{{if _topMenuList.topMenuUrl == "" && _topMenuList.secondMenuList.length > 0}}show{{else}}open{{/if}}" target="{{_topMenuList.topMenuTarget}}">
	<a title="{{_topMenuList.topMenuTitle}}" href="#{{_topMenuList.topMenuId}}" data-url="{{_topMenuList.topMenuUrl}}" class="nav-header menu-first {{if (_topMenuList.topMenuUrl == "" && _topMenuList.secondMenuList.length > 0) || (_topMenuList.topMenuUrl != "" && _topMenuList.secondMenuList.length > 0)}}collapsed{{else}}menu-first-link{{/if}}" data-toggle="collapse" >
		<span class="icon_main_menu">
			{{if _topMenuList.topMenuIconType == "img"}}
			<img src="{{contextPath}}{{_topMenuList.topMenuIcon}}" />
			{{else}}
			<i class="{{_topMenuList.topMenuIcon}}" style="color:{{_topMenuList.topMenuColor}}"></i>
			{{/if}}
		</span>
		<h5>
			<span class="main-menu_title">{{_topMenuList.topMenuTitle}}</span>
			{{if _topMenuList.isShowTotalRow_topMenu == "true"}}
				<span class="main-menu_count">({{_topMenuList.totalRow_topMenu}})</span>
			{{/if}}
		</h5>
	</a>
	{{if _topMenuList.secondMenuList.length > 0}}
	<ul id="{{_topMenuList.topMenuId}}" class="nav nav-list collapse menu-second">
		{{each _topMenuList.secondMenuList as _secondMenuList}}
		<li tabid="{{_secondMenuList.secondMenuId}}" data-title="{{_secondMenuList.secondMenuTitle}}" menu="{{if _secondMenuList.secondMenuUrl == "" && _secondMenuList.thirdMenuList.length > 0}}show{{else}}open{{/if}}" target="{{_secondMenuList.secondMenuTarget}}">
		<a title="{{_secondMenuList.secondMenuTitle}}" {{if (_secondMenuList.secondMenuUrl == "" && _secondMenuList.thirdMenuList.length > 0) || _secondMenuList.secondMenuUrl != "" && _secondMenuList.thirdMenuList.length > 0}}href="#{{_secondMenuList.secondMenuId}}" data-toggle="collapse" class="menu-second-pop"{{/if}} data-url="{{_secondMenuList.secondMenuUrl}}">
			<span class="main-menu_title">{{_secondMenuList.secondMenuTitle}}</span>
			{{if _secondMenuList.isShowTotalRow_secondMenu == "true"}}
				<span class="main-menu_count">({{_secondMenuList.totalRow_secondMenu}})</span>
			{{/if}}
		</a>
		{{if _secondMenuList.thirdMenuList.length > 0}}
		<ul id="{{_secondMenuList.secondMenuId}}" class="collapse menu-third">
			{{each _secondMenuList.thirdMenuList as _thirdMenuList}}
			<li tabid="{{_thirdMenuList.thirdMenuId}}" data-title="{{_thirdMenuList.thirdMenuTitle}}" menu="open" class="menu-third-li" target="{{_thirdMenuList.thirdMenuTarget}}">
			<a title="{{_thirdMenuList.thirdMenuTitle}}" data-url="{{_thirdMenuList.thirdMenuUrl}}">
				<span class="main-menu_title">{{_thirdMenuList.thirdMenuTitle}}</span>
				{{if _thirdMenuList.isShowTotalRow_thirdMenu == "true"}}
					<span class="main-menu_count">({{_thirdMenuList.totalRow_thirdMenu}})</span>
				{{/if}}
			</a></li>
			{{/each}}
		</ul>
		{{/if}}
		</li>
		{{/each}}
	</ul>
	{{/if}}	    	
</li>
{{/each}}
{{else}}


{{each appMenu as _appMenu i}}
<li tabid="{{_appMenu.listId}}" menu="open" {{if i == 0}}class="active"{{/if}}>
<a data-url="{{_appMenu.listUrl}}">
	<span class="icon_main_menu">
		{{if _appMenu.topMenuIconType == "img"}}
		<img src="{{contextPath}}{{_appMenu.topMenuIcon}}" />			
		{{else}}
		<i class="{{_appMenu.topMenuIcon}}"></i>
		{{/if}}
	</span>
	<h5>
		<span class="main-menu_title">{{_appMenu.listTitle}}</span>
	</h5>
</a>
</li>
{{/each}}

{{/if}}
</script>


<script type="text/html" id="atp-main-menu-small-list">
{{if appType == "menu"}}
{{each topMenuList as _topMenuList i}}
<li>
		<span class="icon_main_menu">
			{{if _topMenuList.topMenuIconType == "img"}}
			<img src="{{contextPath}}{{_topMenuList.topMenuIcon}}" />
			{{else}}
			<i class="{{_topMenuList.topMenuIcon}}" style="color:{{_topMenuList.topMenuColor}}"></i>
			{{/if}}
		</span> 	
</li>
{{/each}}
{{else}}


{{each appMenu as _appMenu i}}
<li>
	<span class="icon_main_menu">
		{{if _appMenu.topMenuIconType == "img"}}
		<img src="{{contextPath}}{{_appMenu.topMenuIcon}}" />			
		{{else}}
		<i class="{{_appMenu.topMenuIcon}}"></i>
		{{/if}}
	</span>
</li>
{{/each}}

{{/if}}
</script>


<script>
Main.init();
var addTab = Main.renderTabs.addTab;
</script>

</html>
</o:MultiLanguage>