<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.user.ejb.UserProcess"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.user.ejb.UserProcess"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%
String userid = request.getParameter("userid");
UserProcess userProcess = (UserProcess) ProcessFactory.createProcess(UserProcess.class);
UserVO userVo = (UserVO)userProcess.doView(userid);
WebUser webUser = new WebUser(userVo);
webUser.setEquipment(WebUser.EQUIPMENT_PHONE);
request.getSession().setAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER,webUser);
request.getSession().setAttribute("SKINTYPE", "phone");
new OBPMDispatcher().sendRedirect(request.getContextPath()+"/portal/dispatch/main.jsp",request, response);
%>
