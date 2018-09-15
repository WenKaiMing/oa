<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Module]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script type="text/javascript">
function validate(obj) {
		if (obj.value == "" || obj.value == 'undefined') {
			jQuery("#validate_info").css("display","");
			jQuery("#validate_info").html("{*[page.name.notexist]*}");
			return false;
		}
		else {
			jQuery("#validate_info").css("display","none");
			jQuery("#validate_info").html("&nbsp;");
			return true;
		}
}
//去所有空格   
String.prototype.trimAll = function(){   
    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
};
function checkOrderNumber(s){
	var temp=document.getElementsByName('content.m_order')[0].value.trimAll();
	document.getElementsByName('content.m_order')[0].value = temp;
}
function ev_ok() {
	if (jQuery("#name").val() == "" || jQuery("#name").val() == 'undefined') {
		jQuery("#validate_info").css("display","");
		jQuery("#validate_info").html("{*[page.name.notexist]*}");
		return;
	}
	
	document.forms[0].action='<s:url action="toStep2"></s:url>';
	document.forms[0].submit();
}
jQuery(document).ready(function(){
	window.top.toThisHelpPage("application_popmenu_wizard_info");
});

</script>

</head>
<body style="text-align:center;">
<table width="99%">
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
</table>
<s:form action="toStep2" method="post">
<s:hidden name="content.moduleid" />
<%@include file="/common/page.jsp"%>
<table width="99%">
	<tr style="height:100px;">
		<td style="text-align: center">
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="1"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
		<table class="marAuto">
		<tr>
			<td class="commFont commLabel">{*[Name]*}</td>
			<td><s:textfield cssStyle="width:300px;" onblur="validate(this);" cssClass="input-cmd" label="{*[Name]*}" name="content.m_name" theme="simple" id="name" /><div id="validate_info" style="display:none; color:red">&nbsp;</div></td>
		</tr>
		<tr>
		    <td class="commFont CommLabel">{*[OrderNumber]*}</td>
			<td><s:textfield cssStyle="width:300px;" onblur="checkOrderNumber(this.value);" cssClass="input-cmd" label="{*[OrderName]*}" name="content.m_order" theme="simple" id="order" /></td>
			<td style="width:100px;"></td>
		</tr>
        <tr>
        	<td class="commFont commLabel">{*[Description]*}:</td>
        	<td><s:textarea cssStyle="width:300px;" rows="4" cssClass="input-cmd"  theme="simple" name="content.m_description" id="des" /></td>
        	<td>&nbsp;</td>
        </tr>
        <tr >
        	<td colspan="2" align="center" valign="top"><button type="button" onClick="forms[0].action='<s:url action="cancel?refresh=rightFrame"></s:url>';forms[0].submit();">{*[Cancel]*}</button>&nbsp;<button type="button" onClick="ev_ok()">{*[Next]*}</button></td>
        </tr>

		<tr>
			<td colspan="3"><br/>
				*{*[page.wizard.step1.description1]*}。<br/>
				*{*[page.wizard.step1.description2]*}
			</td>
		</tr>
	</table>
	</td>
	</tr>
</table>

</s:form>

</body>
</o:MultiLanguage></html>
