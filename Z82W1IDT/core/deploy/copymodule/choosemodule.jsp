<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
		id="moduleHelper" />
	<title>{*[Module]*}</title>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<script src="<s:url value='/script/util.js'/>"></script>
	<script src="<s:url value='copymodule.js'/>"></script>
	<script type="text/javascript">
	function ev_action(){
	   var moduleId = document.getElementsByName('content.moduleList')[0].value;
	   var application = '&application=<s:property value="application"/>';
	   if(moduleId=='' || moduleId==null){
	      alert("请选择你要复制的模块!");
	   }else{
	   		document.forms[0].action='<s:url action="toStep2"></s:url>?s_module='+moduleId+'&'+application;
	   		document.forms[0].submit();
	   }
	}
	</script>
	</head>
	<body>
	<table width="100%">
		<tr bgcolor="#CCCCCC">
			<td width="80%" height="26" class="STYLE2" class="commFont">{*[page.copymodule.choosemodule]*}</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	
	<s:form action="save" method="post" theme="simple">
		<table class="table_noborder id1" border=0 width=97%>
			<s:hidden name="content.sortId" />
			<tr>
				<td class="commFont commLabel">{*[cn.myapps.core.deploy.copymodule.new_module_name]*}:</td>
				<td><s:textfield size="50" cssClass="input-cmd" label="{*[Name]*}"
					name="content.modulename" theme="simple" /></td>
			</tr>
			<tr>
				<td class="commFont commLabel">{*[cn.myapps.core.deploy.copymodule.new_description]*}:</td>
				<td><s:textarea cols="50" rows="4" cssClass="input-cmd" theme="simple" name="content.description" /></td>
			</tr>
			<tr>
				<td class="commFont commLabel">{*[cn.myapps.core.deploy.copymodule.module_list]*}:</td>
				<td><s:select cssClass="input-cmd" theme="simple" name="content.moduleList"
					list="#moduleHelper.getModuleSel(#parameters.application)" /></td>
			</tr>
			<tr>
			<td class="commFont commLabel">{*[Superior]*}:</td>
				<td><s:select cssClass="input-cmd" theme="simple" name="_superiorid"
				list="#moduleHelper.getModuleSel(#parameters.application)" /></td>
			</tr>
			<tr>
				<td class="commFont commLabel">{*[cn.myapps.core.deploy.copymodule.copy_module]*}:</td>
				<td><s:radio label="" name="_isCopyModuel"
					list="#{'true':'{*[cn.myapps.core.deploy.copymodule.yes]*}','false':'{*[cn.myapps.core.deploy.copymodule.no]*}'}" value="'true'"
					theme="simple" /></td>
			</tr>
			<s:hidden name="content.moduleId"></s:hidden>
			<tr>
				<td colspan="2" align="center" valign="top"><font size="2"
					style="text-align: center;">请选择你要复制的模块！[复制模块名]和[复制模块描述]用户可以为空，当为空时，系统默认为你所选择的模块名。
				<br>
				如用户复制新的模块请选择[是],如只在原来的模块上复制表单,视图，流程请选择[否]. </font></td>
			</tr>

			<tr>
				<td colspan="2" align="center" valign="top">
				<button type="button" onClick="history.back();">{*[Return]*}</button>
				&nbsp;
				<button type="button" onClick="ev_action();">{*[Next]*}</button>
				</td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>
