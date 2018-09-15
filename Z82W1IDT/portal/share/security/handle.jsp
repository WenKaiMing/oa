<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.util.http.HttpRequestDeviceUtils"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.workflow.notification.dao.EmailTranspondHelper" %>
<%
	WebUser user= (WebUser)request.getSession( ).getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	
	if(HttpRequestDeviceUtils.isMobileDevice(request) ){
	user.setEquipment(WebUser.EQUIPMENT_PHONE);
	}
	request.getSession().setAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER,user) ;
	
	if(user.getEquipment()==WebUser.EQUIPMENT_PHONE){// 来访设备是Phone自动踢转到Phone皮肤
	
	request.getSession().setAttribute("SKINTYPE","phone");
	}
	//由处理url过来的跳到需要处理的url地址
	EmailTranspondHelper.initJump(request, response);
%>
