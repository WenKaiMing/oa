<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.security.action.LoginHelper"%>
<%@page import="cn.myapps.util.http.CookieUtil"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.util.property.DefaultProperty"%>

<%
	String debug = (String) session.getAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	session.removeAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	LoginHelper.logout(request, response);
	
	OBPMDispatcher dispatcher = new OBPMDispatcher();
	String url = SSOUtil.getLogoutRedirect();
	if (StringUtil.isBlank(url)) {
		url = request.getContextPath() + dispatcher.getDispatchURL("/portal/share/security/login.jsp", request, response);
		// 是否为Debug
		if (!StringUtil.isBlank(debug)) {
			url = request.getContextPath() + dispatcher.getDispatchURL("/portal/share/security/login.jsp?debug=true", request, response);
		}
	}
%>


<%@page import="cn.myapps.core.sso.SSOUtil"%><script>
  parent.window.location = '<%=url%>'
</script>