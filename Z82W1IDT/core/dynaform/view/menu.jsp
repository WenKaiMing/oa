<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<s:bean id="resourceUtil" name="cn.myapps.core.resource.action.ResourceHelper" />

<html>
<o:MultiLanguage>

<head>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ResourceUtil.js"/>'></script>
<title>{*[menu]*}</title>
<script type="text/javascript">

function initMenus(){
	ResourceUtil.get_menus(null,'00','<s:property value="#parameters.application"/>',
			'content.superior.id',null,function(str) {var func=eval(str);func.call()});
}

function confirmBtn(){
	var name = document.getElementById("description");
	if(name.value==''){
		alert("{*[page.name.notexist]*}");
		return false;
	}
	document.forms[0].submit();
}
</script>

</head>
<body onload="initMenus();">
<s:form name="menu" action="createMenuByView" namespace="/core/resource" method="post" theme="simple">
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.dynaform.view.new_menu]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" onclick="confirmBtn();">{*[Confirm]*}</button>&nbsp;&nbsp;
					<button type="button" onclick="OBPM.dialog.doReturn();">{*[Cancel]*}</button>
				</div>
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
	<table class="table_noborder id1">
		<tr>
			<td align="left" width="100%">{*[cn.myapps.core.dynaform.view.menu_name]*}：</td>
		</tr>
		<tr>
			<td align="left" width="100%">
				<s:textfield id="description" name="content.description" required="true" cssClass="input-cmd" />
			</td>
		</tr>
		<tr>
			<td align="left" width="100%">{*[cn.myapps.core.dynaform.view.superior_menu]*}：</td>
		</tr>
		<tr>
			<td align="left" width="100%">
				<s:select cssClass="input-cmd" name="content.superior.id" list="{}" />
				<!-- #vh.get_MenuTree(#parameters.application) -->
			</td>
		</tr>
		<tr>
			<td>
				<s:hidden name="_viewid" value="%{#parameters.viewid[0]}"/>
				<s:hidden name="application" value="%{#parameters.application[0]}" />
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage>
</html>