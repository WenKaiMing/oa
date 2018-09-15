<%@page import="cn.myapps.core.domain.ejb.DomainVO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page
	import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.constans.Web"%>

<%@page import="cn.myapps.util.property.DefaultProperty"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.sso.SSOUtil"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%><o:MultiLanguage>
	<%
		String httpHead = request.getServerName();
		ApplicationVO appvo = null;
		String welcomePage = null;
		String accept = request.getHeader("Accept");
		if (accept != null && accept.trim().length() > 0) {
			if (accept.indexOf("j2me") > 0) {
				response.sendRedirect(request.getContextPath() + "/mobile.wml");
			} else {
				String url = "/portal/share/security/login.jsp";
				if (Web.AUTHENTICATION_TYPE_SSO.equals(PropertyUtil.get(Web.AUTHENTICATION_TYPE))) {
					// 单点登录模式直接跳转到登录后主页面
					if (!StringUtil.isBlank(SSOUtil.getLoginRedirect())) {
						url = SSOUtil.getLoginRedirect();
					}
					new OBPMDispatcher().sendRedirect(url, request, response);
				} else {
					new OBPMDispatcher().forward(url,request, response);
				}
			}
		}
	%>
</o:MultiLanguage>