<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
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
		jQuery("#validate_info").html("{*[page.workflow.subject.notexist]*}");
		return false;
	}
	else {
		jQuery("#validate_info").css("display","none");
		jQuery("#validate_info").html("&nbsp;");
		return true;
	}
}

function ev_ok() {
if (jQuery("#them").val() == "" || jQuery("#them").val() == 'undefined') {
	jQuery("#validate_info").css("display","");
	jQuery("#validate_info").html("{*[page.workflow.subject.notexist]*}");
	return;
}

document.forms[0].action='<s:url action="toworkflowtype"></s:url>';
document.forms[0].submit();
}

</script>
</head>

<body>
<s:form action="toworkflowtype" method="post">
<s:hidden name="content.w_workflowid" />
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
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="31"/></s:include></td>
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table class="marAuto">
				<tr>
					<td class="commFont">{*[Subject]*}:</td>
					<td><s:textfield size="50" cssClass="input-cmd" name="content.w_name" theme="simple" id="them" onblur="validate(this);" /></td>
					<td style="width:200px;"><div id="validate_info" style="display:none; color:red">&nbsp;</div></td>
				</tr>
				<tr>
					<td valign="top" colspan="2"  align="center">
					<button type="button" onClick="forms[0].action='<s:url action="backtoStep2Style"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
					<button type="button" onClick="ev_ok();">{*[Next]*}</button></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3" ><br/>
						*{*[page.wizard.step3.description1]*} <br/>
						*{*[page.wizard.step3.description2]*}
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
