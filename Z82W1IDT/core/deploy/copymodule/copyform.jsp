<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@page
	import="cn.myapps.core.deploy.module.action.ModuleHelper,cn.myapps.core.deploy.module.ejb.ModuleVO,cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>
<html>
<o:MultiLanguage>
	<head>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
		id="moduleHelper" />
	<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh" />
	<title>{*[Form]*}</title>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<script src="<s:url value='/script/check.js'/>"></script>
	<script src="<s:url value='/script/util.js'/>"></script>
	<script src="<s:url value='copymodule.js'/>"></script>
	<script type="text/javascript">
		  var moduleid = '<s:property value='#parameters.s_module'/>';
		  function ev_action(){
			   var moduleId = '<s:property value='#parameters.s_module'/>';
			   document.forms[0].action='<s:url action="copyform"></s:url>';
			   document.forms[0].submit();
		   }
		   function ev_init(){
	          FormHelper.getFormNameCheckBox(moduleid,'formName',function(str)
			  {
			  var func=eval(str)});
		   }
   
	</script>
	</head>
	<body onload="ev_init()">
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table width="100%" align="center">
		<tr bgcolor="#CCCCCC">
			<td width="80%" height="26" class="STYLE2" class="commFont">{*[page.copymodule.chooseform]*}</td>
		</tr>
	</table>
	<s:form action="save" method="post" theme="simple">
	<%@include file="/common/page.jsp"%>
		<s:bean name="cn.myapps.core.remoteserver.action.RemoteServerHelp"
			id="rsh" />
		<table border="0" align="center" width="100%">
			<s:hidden name="s_module" value="%{#parameters.s_module}" />
			<s:hidden name="moduleid" value="%{content.moduleId}" />
			<tr>
				<td class="commFont" align="right"><div>{*[FormList]*}:</div></td>
				<td width="60%" ><div id="formName" name="formName" class="commFont"></div></td>
			</tr>
			<tr align="center">
				<td colspan="2" align="center" valign="top">
				<button type="button" onClick="doCancel();">{*[Cancel]*}</button>
				&nbsp;
				<button type="button" onClick="ev_action();">{*[CopyForm]*}</button>
				</td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>
