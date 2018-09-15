<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%

LoginHelper.logoutAdmin(session);

%>
<%@page import="cn.myapps.core.security.action.LoginHelper"%>
<script>
  parent.window.location = '<s:url value="/saas/admin/login.jsp "/>';
</script>