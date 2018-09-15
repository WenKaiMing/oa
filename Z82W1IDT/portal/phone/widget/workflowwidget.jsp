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
		WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String appId = request.getParameter("appid");

	ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
	Collection<ApplicationVO> appList = process.queryAppsByDomain(user.getDomainid(),1,Integer.MAX_VALUE);

		for (ApplicationVO applicationVO : appList) {
			if (!applicationVO.isActivated())
				continue;
			String applicationId = applicationVO.getId();
			if(applicationId.equals(appId)){
				out.println("<input type='hidden' name='pendingList' refreshId='" + applicationId + "' _appId='" + applicationId + "' _appName='"
						+ applicationVO.getName() + "' _url='../dynaform/work/pendingList.action?application=" + applicationId + "' />");
				out.println("<input type='hidden' name='processedList' refreshId='" + applicationId + "' _appId='" + applicationId + "' _appName='"
						+ applicationVO.getName() + "' _url='../dynaform/work/processedList.action?application=" + applicationId + "' />");
			}
		}
	%></div>
</o:MultiLanguage>