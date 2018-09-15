<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="cn.myapps.util.property.DefaultProperty"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%>
<%@page import="cn.myapps.extendedReport.NDataSource"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page
	import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<%@page import="cn.myapps.core.dynaform.work.action.WorkHtmlUtil"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.email.util.EmailConfig"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@ page import="java.util.Calendar" %>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<s:bean
		name="cn.myapps.core.deploy.application.action.ApplicationHelper"
		id="ih" />
	<s:bean name="cn.myapps.core.resource.action.ResourceUtil" id="rUtil" />
	<s:bean name="cn.myapps.core.resource.action.ResourceAction"
		id="ResourceAction" />
	<s:bean name="cn.myapps.core.resource.action.ResourceHelper"
		id="ResourceHelper" />		
	<s:bean name="cn.myapps.core.permission.action.PermissionHelper"
		id="ph">
		<s:param name="user" value="#session['FRONT_USER']" />
	</s:bean>
	<s:bean
		name="cn.myapps.core.personalmessage.action.PersonalMessageHelper"
		id="pmh"></s:bean>
	<%
		DomainHelper dh = new DomainHelper();
		String contextPath = request.getContextPath();
		WorkHtmlUtil workHtmlUtil = new WorkHtmlUtil(request);
		request.setAttribute("workHtmlUtil", workHtmlUtil);
		request.setAttribute("request", request);
		PersonalMessageHelper pmh = new PersonalMessageHelper();
		WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		request.setAttribute("smsCount", pmh.countMessage(user.getId()));
		String userStyle = "";
		String domainid = user.getDomainid();
		if (user.getUserSetup() != null) {
			userStyle = user.getUserSetup().getUserStyle() == null
					? ""
					: (String) user.getUserSetup().getUserStyle();
		}
		Calendar cld = Calendar.getInstance();
		int currentYear = cld.get(Calendar.YEAR);
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge,chrome=1">
<title>{*[page.title]*}abc</title>


<link href="themes/default/style.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="themes/css/core.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="themes/css/print.css" rel="stylesheet" type="text/css"
	media="print" />

<!--[if IE]>
<link href="themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
<![endif]-->

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ResourceUtil.js"/>'></script>

<script src="js/speedup.js" type="text/javascript"></script>
<script src="js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="js/jquery.cookie.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.bgiframe.js" type="text/javascript"></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<script src="js/dwz.core.js" type="text/javascript"></script>
<script src="js/dwz.util.date.js" type="text/javascript"></script>
<script src="js/dwz.validate.method.js" type="text/javascript"></script>
<script src="js/dwz.regional.zh.js" type="text/javascript"></script>
<script src="js/dwz.barDrag.js" type="text/javascript"></script>
<script src="js/dwz.drag.js" type="text/javascript"></script>
<script src="js/dwz.tree.js" type="text/javascript"></script>
<script src="js/dwz.accordion.js" type="text/javascript"></script>
<script src="js/dwz.ui.js" type="text/javascript"></script>
<script src="js/dwz.theme.js" type="text/javascript"></script>
<script src="js/dwz.switchEnv.js" type="text/javascript"></script>
<script src="js/dwz.alertMsg.js" type="text/javascript"></script>
<script src="js/dwz.contextmenu.js" type="text/javascript"></script>
<script src="js/dwz.navTab.js" type="text/javascript"></script>
<script src="js/dwz.tab.js" type="text/javascript"></script>
<script src="js/dwz.resize.js" type="text/javascript"></script>
<script src="js/dwz.dialog.js" type="text/javascript"></script>
<script src="js/dwz.dialogDrag.js" type="text/javascript"></script>
<script src="js/dwz.sortDrag.js" type="text/javascript"></script>
<script src="js/dwz.cssTable.js" type="text/javascript"></script>
<script src="js/dwz.stable.js" type="text/javascript"></script>
<script src="js/dwz.taskBar.js" type="text/javascript"></script>
<!-- script src="js/dwz.ajax.js" type="text/javascript"></script //  不会用到dwz.ajax  -jarod -->
<script src="js/dwz.pagination.js" type="text/javascript"></script>
<script src="js/dwz.database.js" type="text/javascript"></script>
<script src="js/dwz.datepicker.js" type="text/javascript"></script>
<script src="js/dwz.effects.js" type="text/javascript"></script>
<script src="js/dwz.panel.js" type="text/javascript"></script>
<script src="js/dwz.checkbox.js" type="text/javascript"></script>
<script src="js/dwz.history.js" type="text/javascript"></script>
<!--
<script src="bin/dwz.min.js" type="text/javascript"></script>
-->
<script src="js/dwz.regional.zh.js" type="text/javascript"></script>

<script type="text/javascript">
//用于站内短信提醒框pic
var contextPath = '<%= contextPath %>';
var userId = '<%= user.getId() %>';
var close_1 = '<o:Url value='/resource/imgv2/close-1.gif'/>';
var close_2 = '<o:Url value='/resource/imgv2/close-2.gif'/>';

	$(function() {
		DWZ.init("dwz.frag.xml", {
			loginUrl : "login_dialog.html",
			loginTitle : "登录",
			//		loginUrl:"login.html",
			statusCode : {
				ok : 200,
				error : 300,
				timeout : 301
			}, 
			pageInfo : {
				pageNum : "pageNum",
				numPerPage : "numPerPage",
				orderField : "orderField",
				orderDirection : "orderDirection"
			}, 
			debug : false, // 调试模式
			callback : function() {
				initEnv();
				$("#themeList").theme({
					themeBase : "themes"
				}); 
			}
		});
		
		
		$.ajax({
    		url: contextPath + "/message/notification/sendMessageNotificationWhenLogin.action",
    		type:"POST",
    		cache:false,
			success: function(result){
    			if(1==result.status){
    				var totalNumMessage = result.data["size"];//总数量
					if(totalNumMessage && totalNumMessage > 0){
						$("#message-tips").text(totalNumMessage);
					}
				}
    		}
    	})
		
		
	});

	/** myApps|OBPM **/
	
	//注销
	function logout() {
		if (confirm("{*[core.page.logout.confirm]*}?")) {
			window.top.location.href = '<s:url value='/portal/share/security/logout.jsp'/>';
		}
	}

	//刷新待办短信数量 菜单视图总数
	function reflashTotalRow(resourceid, viewid) {
		DWREngine.setAsync(false);
		if (jQuery("#menu_" + resourceid).html() == null
				|| jQuery("#menu_" + resourceid).html() == "") {
			return;
		}
		ResourceUtil.getTotalRowByResourceid(resourceid, function(data) {
			var arr = jQuery("span[name='menuname_" + viewid + "']");
			arr.each(function(i) {
				jQuery(this).html("(" + data + ")");
			});
		});
	}

	//应用切换
	function changeApplication() {
		var doc = window.parent.document;
		doc.getElementById('closeWindow_DIV').style.display = 'block';
		document.forms[0].submit();
	}

	//打开主页
	function openHomePage(){
		navTab._switchTab(0);
		var oApp = document.getElementById("application");
		document.getElementsByName("detail")[0].src = './homepage.jsp?application='+oApp.value;
	}
	
	//打开一个新TAB
	function addTab(id, label, url) {
		var opt = {title:label, data:{}, fresh:true, external:true};
		navTab.openTab(id, url, opt);
	}
	
	//关闭一个TAB
	function closeActiveTab() {
		navTab.closeCurrentTab("");
	}

	//刷新未读消息条数
	setInterval(function(){
		var $dialog = top.$("div.aui_state_lock");
		if($dialog.size()==0 || !$dialog.is(':visible')) {
			$.ajax({
	    		url: contextPath + "/message/notification/sendMessageNotificationWhenLogin.action",
	    		type:"POST",
	    		cache:false,
				success: function(result){
	    			if(1==result.status){
	    				var totalNumMessage = result.data["size"];//总数量
						if(totalNumMessage && totalNumMessage > 0){
							$("#message-tips").text(totalNumMessage);
						}
					}
	    		}
	    	})			
		}
	},30000);

</script>
<style>
.nav li {
	border: 1px solid #red;
}

.nav .select {
	height: 20px;
	line-height: 20px;
}
#header .logo {
 	display:block;
	border:1px solid #fff;
	margin:2px 5px 5px 10px;
	width:46px;
	height:46px;
	<s:if test="#session.FRONT_USER.getDomain().getLogoUrl().length()>0">
	background: #ffffff url('<s:url value="/lib/icon/" /><s:property value="#session.FRONT_USER.getDomain().getLogoUrl()"/>') no-repeat center center;
	</s:if>
	<s:else>
	background: #ffffff url('../share/images/logo/logo-dwz.png') no-repeat center center;
	</s:else>
	
	border-radius: 23px;/*设置图像圆角效果,在这里我直接设置了超过width/2的像素，即为圆形了*/  
    -webkit-border-radius: 23px;/*圆角效果：兼容webkit浏览器*/  
    -moz-border-radius:23px;   
    box-shadow: inset 0 -1px 0 #FFF;/*设置图像阴影效果*/  
    -webkit-box-shadow: inset 0 -1px 0 #CCC; 
	
	position:relative; 
	z-index:2; 
	behavior: url('./resource/main/iecss3.htc') 
 }
 
#header .sn {
    font-size: 28px;
    font-weight: bold;
    color: white;
    display: block;
    padding-top: 12px;
}
</style>
</head>

<body scroll="no">
<s:hidden name="application" id="application" value="%{#parameters.application}" />
<bgsound id="msgSound" loop="1" src="" /><!--站内短信提示声音-->
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<a class="logo fiximg" href="#"></a><span class="sn"><s:property value="#session.FRONT_USER.getDomain().getSystemName()"/></span>
				<ul class="nav">
					<!-- 软件切换 -->
					<li class="changeApplication"><s:form action="change"
							namespace="/portal/application" theme="simple"
							cssStyle="margin:0; padding:0;">
							<s:hidden name="isreload" id="isreload" />
							<s:select name="id" cssClass="select"
								list="#ih.getListByWebUser(#session.FRONT_USER)" listKey="id"
								listValue="name" value="#parameters.application" theme="simple"
								onchange="changeApplication()" onkeypress="changeApplication()" />
						</s:form></li>
					<!-- BEGIN 常用工具 -->					
					<li title="<s:property value="%{#session.FRONT_USER.name}" />" style="text-align: right;width: 50px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: normal;">
						<span><s:property value="%{#session.FRONT_USER.name}" /></span>
					</li>
					<li>
						<a href="javascript:void(0)" onClick="openHomePage();">{*[HomePage]*}</a>
					</li>
					<li><a id="_message" title="消息中心"
						href="<s:url value="/message/message.jsp"/>"
						target="navTab"  external="true" rel="message">
						消息中心
						(<span id='message-tips'></span>)
					</a></li>
					<li><a title="{*[Mobile]*}{*[Message]*}"
						href="frame.jsp?<s:url value='/portal/shortmessage/submission/list.action'><s:param name='application' value='#parameters.application' /></s:url>"
						target="dialog" width="890" height="550">{*[Mobile]*}{*[Message]*}
					</a></li>
					<li><a title="{*[Personal]*}{*[Setup]*}"
						href="frame.jsp?<s:url value='/portal/user/editPersonal.action'><s:param name='application' value='#parameters.application' /><s:param name='domain' value='%{#session.FRONT_USER.domainid}' /><s:param name='editPersonalId' value='%{#session.FRONT_USER.id}' /></s:url>"
						target="dialog" width="935" height="550" rel="personalseup">
							{*[Personal]*}{*[Setup]*} </a></li>
            <%
				if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
					
					if("true".equals(DefaultProperty.getProperty("saas"))){
			%>
			<li>
				<a title="{*[cn.myapps.core.manage.title.domain_info_manage]*}"  href="../../saas/weioa/controlPanel.jsp" >
					{*[front.page.nav.label.manage]*}
				</a>
			</li>
			<%
				}else{
			%>
			<li>
				<a title="{*[cn.myapps.core.manage.title.domain_info_manage]*}"  target="navTab" external="true" rel="domainmanager" href="<s:url value='/portal/domain/edit.action'/>?domain=<s:property value="%{#session.FRONT_USER.domainid}" />&application=<s:property value="%{#parameters.application}" />" >
					{*[front.page.nav.label.manage]*}
				</a>
			</li>
			<%}} %>
					<li><a title="{*[core.dynaform.work.myWork]*}" id="MyWorkId"
						href="./flowCenter.jsp"
						target="navTab"  rel="mywork" external="true">
							{*[core.dynaform.work.flowcenter]*} </a>
					</li>
					<% 
						if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.PM)){
					%>
					<li>
						<a title="任务" href="../../pm/index.jsp"
						target="navTab" rel="task" external="true">{*[Task]*}</a>
					</li>
					<%} %>
					<% 
						if(NDataSource.isErpEnable()){		//判断是否开户ERP报表
						
					%>
					<li>
						<a title="ERP报表" href="../../extendedReport/chartIndex.jsp"
						target="navTab" rel="erp" external="true"> ERP报表 </a>
					</li>
							
					<% 
						}
						if(dh.getModuleConfigByDomain(user.getDomainid(),SystemModuleConfig.KM)){
					%>
					<li>
						<a title="{*[Km]*}" href="../../km/kmindex.jsp"
						target="_blank"> {*[km.name]*} </a>
					</li>
					<%} %>
					<s:if test="@cn.myapps.core.email.util.EmailConfig@isUserEmail()">
						<li>
							<!-- a title="{*[Email]*}" href="<s:url value='/portal/email/list.action'/>?folderid=<s:property value='#folderHelper.getInboxEmailFolderId(#session.FRONT_USER)' />&type=0" target="detail"> -->
							<a title="{*[Email]*}" id="email"
							href="<s:url value='/portal/share/email/index.jsp'/>"
							target="navTab" rel="email" external="true"> {*[Email]*} </a>
						</li>
					</s:if>

					<!-- END 常用工具 -->
					<li><a href="javascript:logout();">{*[Logout]*}</a></li>
				</ul>
				<ul class="themeList" id="themeList">
					<li theme="default"><div class="selected">{*[blue]*}</div></li>
					<li theme="green"><div>{*[green]*}</div></li>
					<li theme="purple"><div>{*[purple]*}</div></li>
					<li theme="silver"><div>{*[silver]*}</div></li>
					<li theme="azure"><div>{*[azure]*}</div></li>
				</ul>
			</div>

			<!-- navMenu -->

		</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse">
						<div></div>
					</div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse">
					<h2>{*[MainMenu]*}</h2>
					<div>{*[Contraction]*}</div>
				</div>

				<div class="accordion" fillSpace="sidebar">

					<s:iterator
						value="#ResourceAction.get_topmenus(#parameters.application,#session.FRONT_USER.domainid)"
						status="tm" id="topMenus">
						<s:if
							test="#ph.checkPermission(#topMenus,#parameters.application,#session.FRONT_USER)">


							<div class="accordionHeader">
								<h2>
									<span>Folder</span>
									<s:property value="#topMenus.description" />
								</h2>
								<s:if test="#rUtil.isShowTotalRow(#topMenus)">
										<span name="showTotalRowMenu\" class="showTotalRowMenu">
											<span name="menuname_<s:property value="#topMenus.actionContent" />" id="menu_<s:property value="#topMenus.id" />">
													(<s:property value="#rUtil.getTotalRowByResourceid(#topMenus.id,#request.request)" />)
											</span>
										</span>
									</s:if>
							</div>
							<div class="accordionContent">
								<ul class="tree treeFolder">
									<s:iterator
										value="#ResourceHelper.searchSubResource(#topMenus.id,1,#session.FRONT_USER.domainid)"
										id="subMenu">
										<s:if test="#ph.checkPermission(#subMenu,#parameters.application,#session.FRONT_USER)">
											<li>
												<a title='<s:property value="#subMenu.description" />'
													href='<s:property value="#subMenu.toUrlString(#session.FRONT_USER,#request.request)" />'
													<s:if test="#subMenu.opentarget==null||#subMenu.opentarget=='' ||#subMenu.opentarget=='detail'">
														target="navTab"
													</s:if>
													<s:else>
														target="_blank"
													</s:else>
													rel="external<s:property value='#subMenu.id' />"
													external="true">
													<s:property value="#subMenu.description" />
													<s:if test="#rUtil.isShowTotalRow(#subMenu)">
														<span name="showTotalRowMenu\">
															<span name="menuname_<s:property value="#subMenu.actionContent" />" id="menu_<s:property value="#subMenu.id" />">
																	(<s:property value="#rUtil.getTotalRowByResourceid(#subMenu.id,#request.request)" />)
															</span>
														</span>
													</s:if>
												</a>
												<s:set name="subMenus2"
													value="#ResourceHelper.searchSubResource(#subMenu.id,1,#session.FRONT_USER.domainid)" />
												<!-- level3 begin -->
											 	<s:iterator value="#subMenus2" id="subMenu2" status="subStatus">
											 		<s:if test="#subStatus.first">
															<ul>
													</s:if>
													<s:if
														test="#ph.checkPermission(#subMenu2,#parameters.application,#session.FRONT_USER)">
														<li title='<s:property value="#subMenu2.description" />'>
															<a href='<s:property value="#subMenu2.toUrlString(#session.FRONT_USER,#request.request)" />'
																<s:if test="#subMenu2.opentarget==null||#subMenu2.opentarget=='' ||#subMenu2.opentarget=='detail'">
																	target="navTab"
																</s:if>
																<s:else>
																	target="_blank"
																</s:else>
																rel="external<s:property value='#subMenu2.id' />"
																external="true">
																<s:property value="#subMenu2.description" />
																<s:if test="#rUtil.isShowTotalRow(#subMenu2)">
																<span name=\"showTotalRowMenu\">
																	<span name="menuname_<s:property value="#subMenu2.actionContent" />" id="menu_<s:property value="#subMenu2.id" />">
																			(<s:property value="#rUtil.getTotalRowByResourceid(#subMenu2.id,#request.request)" />)
																	</span>
																</span>
																</s:if>
															</a>
															<s:set name="subMenus3"
													value="#ResourceHelper.searchSubResource(#subMenu2.id,1,#session.FRONT_USER.domainid)" />
												<!-- level4 begin -->
											 	<s:iterator value="#subMenus3" id="subMenu3" status="subStatus">
											 		<s:if test="#subStatus.first">
															<ul>
													</s:if>
													<s:if
														test="#ph.checkPermission(#subMenu3,#parameters.application,#session.FRONT_USER)">
														<li>
															<a href='<s:property value="#subMenu3.toUrlString(#session.FRONT_USER,#request.request)" />'
																<s:if test="#subMenu3.opentarget==null||#subMenu3.opentarget=='' ||#subMenu3.opentarget=='detail'">
																	target="navTab"
																</s:if>
																<s:else>
																	target="_blank"
																</s:else>
																rel="external<s:property value='#subMenu3.id' />"
																external="true">
																<s:property value="#subMenu3.description" />
																<s:if test="#rUtil.isShowTotalRow(#subMenu3)">
																<span name=\"showTotalRowMenu\">
																	<span name="menuname_<s:property value="#subMenu3.actionContent" />" id="menu_<s:property value="#subMenu3.id" />">
																			(<s:property value="#rUtil.getTotalRowByResourceid(#subMenu3.id,#request.request)" />)
																	</span>
																</span>
																</s:if>
															</a>
														</li>
													</s:if>
													<s:if test="#subStatus.last">
															</ul>
													</s:if>
												</s:iterator>
												<!-- level4 end -->
														</li>
													</s:if>
													<s:if test="#subStatus.last">
															</ul>
													</s:if>
												</s:iterator>
												<!-- level3 end -->
											</li>
										</s:if>
									</s:iterator>
								</ul>
							</div>
						</s:if>

					</s:iterator>

				</div>
			</div>
		</div>
	</div>
	<div id="container">
		<div id="navTab" class="tabsPage">
			<div class="tabsPageHeader">
				<div class="tabsPageHeaderContent">
					<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
					<ul class="navTab-tab">
						<li tabid="main" class="main"><a href="javascript:;"><span><span
									class="home_icon">{*[front.page.tab.label.my_homepage]*}</span></span></a></li>
					</ul>
				</div>
				<div class="tabsLeft">left</div>
				<!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
				<div class="tabsRight">right</div>
				<!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
				<div class="tabsMore">more</div>
			</div>
			<ul class="tabsMoreList">
				<li><a href="javascript:;">{*[front.page.tab.label.my_homepage]*}</a></li>
			</ul>
			<div class="navTab-panel tabsPageContent layoutBox">
				<div class="page unitBox" style='height: 100%'>
				<input id="_smsCount" type="hidden" value='<s:property value="#request.smsCount" />' />
				<input id="_smsPmnew" type="hidden" value='<o:Url value='/resource/imgv2/front/main/newpm.gif'/>' />
				<input id="_smsPm" type="hidden" value='<o:Url value='/resource/imgv2/front/main/pm.gif'/>' />
				<input id="_smsText" type="hidden" value='{*[PersonalMessage]*}' />
					<iframe frameborder="0" name="detail" width="100%"
						height="100%" class="front-table-common"
						src="<s:url value='./homepage.jsp'><s:param name="application" value="%{#parameters.application}"/><s:param name="uuid" value="%{#parameters.uuid}"/></s:url>"></iframe>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		Copyright &copy; <%=currentYear %><a href="http://www.teemlink.com/" target="about"> {*[myapps.teemlink.technology]*} </a>Tel: 400-678-0211
	</div>

</body>
	</html>
</o:MultiLanguage>