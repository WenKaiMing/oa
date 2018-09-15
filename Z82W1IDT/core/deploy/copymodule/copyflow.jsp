<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
		id="moduleHelper" />
	<s:bean name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper"
		id="bh" />
	<title>{*[cn.myapps.core.deploy.copymodule.copy_flow]*}</title>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<script src="<s:url value='/script/check.js'/>"></script>
	<script src="<s:url value='/script/util.js'/>"></script>
	<script src="<s:url value='copymodule.js'/>"></script>
	<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script type="text/javascript">
	var moduleid = '<s:property value='#parameters.s_module'/>';
	function ev_init(){
	           StateMachineUtil.getBillDefiNameCheckBox(moduleid,'flowlist',function(str){
	           var func=eval(str)});
	}
	</script>	
	</head>
	<body onload="ev_init();">
	<table width="100%">
		<tr bgcolor="#CCCCCC">
			<td width="80%" height="26" class="STYLE2" class="commFont">{*[page.copymodule.chooseflow]*}</td>
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
				<td width="20%"><div align="right">{*[cn.myapps.core.deploy.copymodule.flow_list]*}:</div></td>
				<td width="40%"><div class="commFont"  id="flowlist"></div></td>
			</tr>
			<tr>
				<td colspan="2" align="center" valign="top">
				<button type="button"
					onClick="doCancel();">{*[Cancel]*}</button>
				&nbsp;
				<button type="button"
					onClick="forms[0].action='<s:url action="copyflow"></s:url>';forms[0].submit();">{*[CopyFlow]*}</button>
				</td>
			</tr>
		</table>

	</s:form>
	</body>
</o:MultiLanguage>
</html>
