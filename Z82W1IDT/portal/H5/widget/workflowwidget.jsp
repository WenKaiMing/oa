<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<div class="widgetContent" _type="workflow">
<%
		out.println("<input type='hidden' name='pendingList'   _url='../dynaform/work/widgetPendingList.action' />");
		out.println("<input type='hidden' name='processedList' _url='../dynaform/work/widgetProcessedList.action' />");
	%></div>
</o:MultiLanguage>