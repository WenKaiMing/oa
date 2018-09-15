<%@page import="cn.myapps.util.http.HttpRequestDeviceUtils"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
WebUser user = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String returnUrl = request.getParameter("returnUrl") !=null? request.getParameter("returnUrl") : "";
String applicationId = request.getParameter("application");

//判断来访者的设备类型
if(HttpRequestDeviceUtils.isMobileDevice(request)){
	user.setEquipment(WebUser.EQUIPMENT_PHONE);
}

request.getSession().setAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER, user);

if(user.getEquipment()==WebUser.EQUIPMENT_PHONE){//来访设备是Phone 自动跳转到Phone皮肤
	request.getSession().setAttribute("SKINTYPE", "phone");
}

new OBPMDispatcher().sendRedirect(request.getContextPath()+"/portal/dispatch/main.jsp?application="+applicationId+"&action="+request.getParameter("action")+"&returnUrl="+returnUrl,request, response);
return;
%>