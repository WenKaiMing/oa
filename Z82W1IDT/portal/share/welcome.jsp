<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.core.homepage.action.HomePageHelper"%>
<%@ page import="cn.myapps.core.user.action.UserDefinedHelper"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.page.action.PageHelper"%>

<%@page import="cn.myapps.core.security.CheckCookieHelper"%>
<%@page import="cn.myapps.util.property.DefaultProperty"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%
	WebUser webUser = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	//String applicationid = request.getParameter("application");
	String applicationId = (String) request
			.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
	UserDefinedHelper pageHelper = new UserDefinedHelper();
	pageHelper.setApplicationid(applicationId);
	String contextPath = request.getContextPath();
	String changePage = CheckCookieHelper.getRequestPage(request);
	String obpmUrlStr = "";
	if (changePage != null && changePage.trim().length() > 0) {
		obpmUrlStr = changePage;
	} else if (pageHelper.isHomePageExist(webUser)
			|| PageHelper.hasDefaultHomePage(webUser, applicationId)) {
		obpmUrlStr = "../../portal/dispatch/homepage.jsp?application=" + applicationId;
	} else {
		obpmUrlStr = "../../portal/dispatch/closeTab.jsp";
	}
	obpmUrlStr = new OBPMDispatcher().getDispatchURL(obpmUrlStr, request, response);
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>welcome.jsp</title>
	<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
	<script language="javascript">
	//loading show
	function dy_lock() {
		jQuery("#loadingDivBack").fadeTo(300,0.4);
	}

	//loading hide
	function dy_unlock() {
		jQuery("#loadingDivBack").fadeOut(200);
	}
	
	function ev_onload() {
		dy_lock();
		dy_unlock();
		window.location.href = "<%=obpmUrlStr%>";
	}
</script>
	</head>
	<body onLoad="ev_onload();" bgcolor="#FFFFFF"
		text="#000000" leftmargin="0" topmargin="0" marginwidth="0"
		marginheight="0">
		<!-- 遮挡层 -->
		<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
			<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
				<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
			</div>
		</div>
	</body>
</o:MultiLanguage>
</html>
