<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.security.action.LoginHelper"%>
<%@page import="cn.myapps.util.http.CookieUtil"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.util.property.DefaultProperty"%>
<%@page import="cn.myapps.core.sso.SSOUtil"%>

<%
	session.removeAttribute(Web.SESSION_ATTRIBUTE_DEBUG);
	LoginHelper.logout(request, response);
	
	OBPMDispatcher dispatcher = new OBPMDispatcher();
	String url = SSOUtil.getLogoutRedirect();
	if (StringUtil.isBlank(url)) {
		url = request.getContextPath() + dispatcher.getDispatchURL("/", request, response);
	}
	
%>


<script>
  //parent.window.location = 'http://yun.weioa365.com';
  parent.window.location = '<%=url%>'
</script>