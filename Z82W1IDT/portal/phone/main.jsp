<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.email.util.EmailConfig"%>
<%@ page import="cn.myapps.core.sysconfig.ejb.KmConfig"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
String appId = request.getParameter("application");
String jumpToUrl = request.getParameter("jumpToUrl");
WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String appName = "微OA365";
if (appId!=null && appId.trim().length()>0 && !appId.equals("null")) {
	ApplicationHelper ah = new ApplicationHelper();
	ApplicationVO appVO = ah.getApplicationById(appId);
	appName = appVO.getName();
}

SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String _date=dateFormater.format(new Date());
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!doctype html>
<html>
<head>
<title><%=appName%></title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<%@ include file="./dynaform/document/content-tmpl.jsp"%>
<%@ include file="./dynaform/view/listView-tmpl.jsp"%>
<%@ include file="./resource/common/include_css.jsp" %>
</head>
<body>
	<div class="phone-main-nav-panel">
        <section class="phone-main-nav-trigger" style="display:none;">
			<i class="iconfont if-phone-plus"></i>
		</section> 
		<section class="phone-main-nav-close" style="display:none">
			<i class="iconfont if-phone-close"></i>
		</section> 
		<div class="phone-main-nav-modal">
			<nav>
				<ul class="phone-main-nav">
					<li title="homePage"><span>主页</span><i class="iconfont if-phone-home home"></i></li>
					<li title="flowCenter"><span>流程</span><i class="iconfont if-phone-workflow flowCenter"></i></li>
					<li title="menu"><span>菜单</span><i class="iconfont if-phone-sender menu"></i></li>
				</ul>
			</nav>
		</div>
    </div>
	
	<!-- loadingtoast -->
	<div id="loadingToast" class="weui_loading_toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<div class="weui_loading">
				<div class="weui_loading_leaf weui_loading_leaf_0"></div>
				<div class="weui_loading_leaf weui_loading_leaf_1"></div>
				<div class="weui_loading_leaf weui_loading_leaf_2"></div>
				<div class="weui_loading_leaf weui_loading_leaf_3"></div>
				<div class="weui_loading_leaf weui_loading_leaf_4"></div>
				<div class="weui_loading_leaf weui_loading_leaf_5"></div>
				<div class="weui_loading_leaf weui_loading_leaf_6"></div>
				<div class="weui_loading_leaf weui_loading_leaf_7"></div>
				<div class="weui_loading_leaf weui_loading_leaf_8"></div>
				<div class="weui_loading_leaf weui_loading_leaf_9"></div>
				<div class="weui_loading_leaf weui_loading_leaf_10"></div>
				<div class="weui_loading_leaf weui_loading_leaf_11"></div>
			</div>
			<p class="weui_toast_content">数据加载中</p>
		</div>
	</div>
	<!-- 消息提醒--start -->
	<div id="msg" class="transparent_message animated">
		<div class="msg-box">
			<div id="tip" class="tip"></div>
			<div class="msgSub" msgType="notice">
			</div>
		</div>
	</div>
	<div id="msgBack" class="msg-toast"></div>
	<!-- 消息提醒--end -->
	
	<form id="homePage" class="bd cur"></form>
	<form id="flowCenter" class="bd"></form>
	<form id="menu" class="bd"></form>
</body>
<script>
var contextPath = '<%=request.getContextPath()%>';
</script>
<%@ include file="./resource/common/include_js.jsp" %>
<script>
//main-js
var obpmPhone = {
	bar1 : "<s:url value='/portal/phone/resource/images/banner01.png'/>",
	bar2 : "<s:url value='/portal/phone/resource/images/banner02.png'/>",
	bar3 : "<s:url value='/portal/phone/resource/images/banner03.png'/>",
	pendingNum : "",
	processingNum : "",
	mulLanguage : {
		selectStr : '{*[Select]*}'	//createDoc(),viewDoc
	}
};

var jumpToUrl = '<%=jumpToUrl%>';
var serviceTime = '<%=_date%>';
var is_bouncy_nav_animating = false;
var appName = "<%=appName%>";
var action = '<%=request.getParameter("action")%>';
var appId = '<%= request.getParameter("application")%>';	//email_transpond(),viewDoc()

//form-js
var title_uf = '{*[UserField]*}';
var title_df = '{*[DepartmentField]*}';
var title_more = '{*[More]*}';
var title_addAuditor = '{*[cn.myapps.core.workflow.add_auditor]*}';
var title_upload = '{*[Upload]*}';
var title_map = '{*[map]*}';
var title_onlinetakephoto = '{*[OnLineTakePhotoField]*}';
var loadError = "{*[page.can.not.load.document]*}";//see ntkoofficecontrol.js
var checkBrowserSettings = '{*[page.check.browser.security.settings]*}';//see ntkoofficecontrol.js
var closeStr = '{*[Close]*}';	//showHistoryRecord
var HistoryRecord ='{*[History]*}{*[Record]*}';	//showHistoryRecord
var visit_from_weixin = '<s:property value="#session.visit_from_weixin"/>';	

//listView-js
var isOpenAbleScriptShow = '{*[page.core.dynaform.forddin]*}';	//judgeOperating()
var isedit = '';
var enbled='';
var selectStr = '{*[Select]*}';	//createDoc(),viewDoc
var someInformation= '{*[cn.myapps.core.workflow.input_audit_remark]*}';	//on_doflow
var okMessage = '{*[OK]*}';	//on_doflow()
var cancelMessage = '{*[Cancel]*}';	//on_doflow()
var USER = {
	id : "<%=webUser.getId()%>"
};

//获取ua 判断是不是ios 录音控件中使用
var u = navigator.userAgent, app = navigator.appVersion;
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
template.config("escape",false);

function loadFlow(){
	FlowCenter.multilingual = {
			subject : "{*[Subject]*}",
			State : "{*[State]*}",
			Current_Processor : "{*[Current_Processor]*}",
			flow_last_time : "{*[flow.last_time]*}",
			Activity : "{*[Activity]*}"
	};
	showLoadingToast();
	FlowCenter.load();
}

if(jumpToUrl && jumpToUrl != "null"){
	jumpToPage(jumpToUrl);
}else{
	if(location.hash == ""){
		if(action && action != '' && action != 'null'){
			location.hash = "#"+action;
		}else{
			location.hash = "#homePage";
		}
	}
}

//首页注册监听事件
mainBindEvent();

var visit_from_weixin = '<s:property value="#session.visit_from_weixin"/>';	
if(visit_from_weixin =="true"){
	weixinApiInit();
}
//路由
ajaxPage.Router.init();
</script>
</html>
</o:MultiLanguage>