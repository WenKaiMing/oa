<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@page
	import="cn.myapps.core.deploy.module.action.ModuleHelper,cn.myapps.core.deploy.module.ejb.ModuleVO,cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>
<html>
<o:MultiLanguage>
	<head>
	<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
		id="moduleHelper" />
	<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh" />
	<title>{*[CopyView]*}</title>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src="<s:url value='/script/check.js'/>"></script>
	<script src="<s:url value='/script/util.js'/>"></script>
	<script src="<s:url value='copymodule.js'/>"></script>
	<script type="text/javascript">
	
	 var moduleid = '<s:property value='#parameters.s_module'/>';
	 var application = '<s:property value='#parameters.application'/>';
	function ev_init(){
	    ViewHelper.getViewNameCheckBox(moduleid,'viewList',application,function(str)
		  {
		 var func=eval(str)});
	}
	
	</script>
	</head>
	<body onload="ev_init();">
	<table width="100%">
		<tr bgcolor="#CCCCCC">
			<td width="80%" height="26" class="STYLE2" class="commFont">{*[page.copymodule.chooseview]*}</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:form action="save" method="post" theme="simple">
		<s:bean name="cn.myapps.core.remoteserver.action.RemoteServerHelp"
			id="rsh" />
		<table border="0" align="center">
			<s:hidden name="content.id" />
			<s:hidden name="content.sortId" />
			<s:hidden name="applicationId" value="%{#parameters.applicationId}" />
			<s:hidden name="application" value="%{#parameters.application}" />
			<s:hidden name="s_module" value="%{#parameters.s_module}" />
			<s:hidden name="moduleid" value="%{content.moduleId}" />
			<tr>
				<td width="20%"><div align="right">{*[ViewList]*}:</div></td>
				<td><div id="viewList" class="commFont" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" valign="top">
				<button type="button"
					onClick="doCancel();">{*[Cancel]*}</button>
				&nbsp;
				<button type="button"
					onClick="forms[0].action='<s:url action="copyview"></s:url>';forms[0].submit();">{*[CopyView]*}</button>
				</td>
			</tr>
		</table>

	</s:form>
	</body>
</o:MultiLanguage>
</html>
