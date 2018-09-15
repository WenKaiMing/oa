<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<html><o:MultiLanguage>
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">   
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="0">
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {color: #000000}
-->
</style>
<script type="text/javascript">
function validate(obj) {
	if (obj.value == "" || obj.value == 'undefined') {
		jQuery("#validate_info").css("display","");
		jQuery("#validate_info").html("{*[cn.myapps.core.user.please_input_name]*}");
		return false;
	}
	else {
		jQuery("#validate_info").css("display","none");
		jQuery("#validate_info").html("&nbsp;");
		return true;
	}
}

function ev_ok() {
if (jQuery("#des").val() == "" || jQuery("#des").val() == 'undefined') {
	jQuery("#validate_info").css("display","");
	jQuery("#validate_info").html("{*[cn.myapps.core.user.please_input_name]*}");
	return;
}

document.forms[0].action='<s:url action="tostep5"></s:url>';
document.forms[0].submit();
}
</script>
</head>

<body>
<s:form action="save" method="post">
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="4"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table class="marAuto">
	   			<tr><td class="commFont">{*[Name]*}:</td><td><s:textfield size="50" cssClass="input-cmd" label="{*[Description]*}" name="content.r_description"  theme="simple" id="des" onblur="validate(this);" /></td>
	   				<td style="width:100px;"><div id="validate_info" style="display:none; color:red">&nbsp;</div></td></tr>
       			<tr><td class="commFont">{*[SerialNum]*}:</td><td><s:textfield size="50" cssClass="input-cmd" label="{*[Description]*}" name="content.r_orderno"  theme="simple"/></td><td>&nbsp;</td></tr>
       			<tr>
       				<td class="commFont">{*[Superior]*}:</td>
       				<td><s:select cssClass="input-cmd" theme="simple" name="content.r_superior" list="#vh.get_MenuTree(#parameters.application)" /></td>
       				<td>&nbsp;</td>
       			</tr>
        		<tr><td valign="top" colspan="2"  align="center">
        		<button type="button" onClick="forms[0].action='<s:url action="toworkflowRole"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
        		<button type="button" onClick="ev_ok();">{*[Next]*}</button></td><td>&nbsp;</td></tr>
				<tr>
					<td colspan="3"><br/>
						*{*[page.wizard.step4.menu.description1]*}<br/>
						*{*[page.wizard.step4.menu.description2]*}<br/>
						*{*[page.wizard.step4.menu.description3]*}<br/>
						*{*[page.wizard.step4.menu.description4]*}
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
