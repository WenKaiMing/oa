<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.resource.copy_mobilemenu]*}</title>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
	<script src="<s:url value='/script/util.js'/>"></script>

	<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
	<script type="text/javascript">
	function doCopy(){
		var listform = document.forms["formItem"];
		var _selects = window.parent.getSelects();
		if(_selects == false){
			alert("请勾选要复制的菜单");
			return false;
		}
		formItem.action='<s:url action="copyResource"></s:url>?menus=' + _selects;
		formItem.submit();
	}

	jQuery(document).ready(function(){
		window.top.toThisHelpPage("application_info_generalTools_menu_copy");
		window.parent.init_MenuTree();
	});
	</script>
	</head>
	<body id="application_info_generalTools_menu_copy" style="padding: 0px;margin: 0px;overflow: hidden;">
	<%@include file="/common/page.jsp"%>
	<s:bean name="cn.myapps.core.resource.action.ResourceHelper" id="rh" />
	<table width="100%">
		<tr>
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3">&nbsp;</td>
			<td width="200" class="text-label">{*[cn.myapps.core.resource.copy_mobilemenu]*}</td>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td>&nbsp;</td>
					<td width="60" valign="top">
					<button type="button" class="button-image" onClick="doCopy()"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Copy]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td colspan="4"
				style="border-top: 1px solid dotted; border-color: black;">
			&nbsp;</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:form action="save" method="post" theme="simple" name="formItem"
		validate="true">
		<%@include file="/common/page.jsp"%>
		<table width="80%">
			
			<tr>
				<td class="commFont commLabel" align="right">{*[cn.myapps.core.resource.copy_to_mobilemenu]*}:</td>
				<td><s:select cssClass="input-cmd" name="_dest" id="_dest"
					list="get_menusOfMobile(#parameters.application)" /></td>
			</tr>
		</table>

		</s:form>
	</body>
</o:MultiLanguage>
</html>
