<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.sysconfig.content.system_config_info]*}</title>
<style type="text/css">
	.email_title{
		background-image: url("<s:url value='/resource/imgnew/email-titil-bg.gif'/>");
		height: 30px;
		text-align: center;
	}
	.email_title font{
		background-color: #FFFFFF;
		text-align: center;
	}
</style>
<script type="text/javascript">
var useClient = '<s:property value="emailConfig.isUseClient"/>';
jQuery("document").ready(function(){
	ev_emailClientchange(useClient);
	if (window.ActiveXObject){
		jQuery(".email_title").css("width","100%");
		jQuery(".email_title font").attr("size","1");
	}
});

function ev_emailClientchange(val) {
	if(val == true || val == 'true'){
		document.getElementsByName("emailConfig.functionDomain")[0].disabled = false;

		document.getElementsByName("emailConfig.trash")[0].disabled = false;
		document.getElementsByName("emailConfig.sender")[0].disabled = false;
		document.getElementsByName("emailConfig.draft")[0].disabled = false;
		document.getElementsByName("emailConfig.removed")[0].disabled = false;
	
		document.getElementsByName("emailConfig.fetchServer")[0].disabled = false;
		document.getElementsByName("emailConfig.fetchServerPort")[0].disabled = false;
		document.getElementsByName("emailConfig.fetchProtocol")[0].disabled = false;
		document.getElementsByName("emailConfig.fetchssl")[0].disabled = false;
		document.getElementsByName("emailConfig.fetchssl")[1].disabled = false;
		document.getElementsByName("emailConfig.smtpServer")[0].disabled = false;
		
		document.getElementsByName("emailConfig.smtpServerPort")[0].disabled = false;
		document.getElementsByName("emailConfig.smtpAuthenticated")[0].disabled = false;
		document.getElementsByName("emailConfig.smtpAuthenticated")[1].disabled = false;
		document.getElementsByName("emailConfig.smtpssl")[0].disabled = false;
		document.getElementsByName("emailConfig.smtpssl")[1].disabled = false;

	} else {
		document.getElementsByName("emailConfig.functionDomain")[0].disabled = true;

		document.getElementsByName("emailConfig.trash")[0].disabled = true;
		document.getElementsByName("emailConfig.sender")[0].disabled = true;
		document.getElementsByName("emailConfig.draft")[0].disabled = true;
		document.getElementsByName("emailConfig.removed")[0].disabled = true;
	
		document.getElementsByName("emailConfig.fetchServer")[0].disabled = true;
		document.getElementsByName("emailConfig.fetchServerPort")[0].disabled = true;
		document.getElementsByName("emailConfig.fetchProtocol")[0].disabled = true;
		document.getElementsByName("emailConfig.fetchssl")[0].disabled = true;
		document.getElementsByName("emailConfig.fetchssl")[1].disabled = true;
		document.getElementsByName("emailConfig.smtpServer")[0].disabled = true;
		
		document.getElementsByName("emailConfig.smtpServerPort")[0].disabled = true;
		document.getElementsByName("emailConfig.smtpAuthenticated")[0].disabled = true;
		document.getElementsByName("emailConfig.smtpAuthenticated")[1].disabled = true;
		document.getElementsByName("emailConfig.smtpssl")[0].disabled = true;
		document.getElementsByName("emailConfig.smtpssl")[1].disabled = true;
	}
}

</script>

</head>
<body>
<fieldset>
<legend>{*[cn.myapps.core.sysconfig.email.system_email_config]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_host]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_address]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.sendHost" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="emailConfig.sendAddress" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_account]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_password]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.sendAccount" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:password name="emailConfig.sendPassword" cssClass="input-cmd" theme="simple" onblur="" showPassword="true"/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email._cc_address]*}：</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.ccAddress" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td>&nbsp;</td>
	</tr>
</table>
</fieldset>
<fieldset>
<legend>{*[cn.myapps.core.sysconfig.authConfig.basic_config]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email.is_use_email_client]*}：</td>
	</tr>
	<tr>
		<td>
			<s:radio name="emailConfig.isUseClient" list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" 
			theme="simple" onclick="ev_emailClientchange(this.value)" />
		</td>
	</tr>
	<tr>
		<td colspan="2">{*[cn.myapps.core.sysconfig.email.email.email_function_domain]*}：</td>
	</tr>
	<tr id="e2">
		<td><s:textfield name="emailConfig.functionDomain" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td>&nbsp;</td>
	</tr>
</table>
<table id="t1" class="table_noborder id1">
	<tr>
		<td class="email_title" colspan="2"><font>{*[cn.myapps.core.sysconfig.email.email.email_clientAndServer_file_mapping]*}</font></td>
	</tr>
	<tr>
		<td>{*[trash]*}：</td>
		<td>{*[send]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.trash" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="emailConfig.sender" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[Draft]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.email_deleted]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.draft" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="emailConfig.removed" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
</table>
</fieldset>
<fieldset id="t2">
<legend>{*[cn.myapps.core.sysconfig.email.is_need_certificate]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td class="email_title" colspan="2"><font>{*[cn.myapps.core.sysconfig.email.email_income_config]*}</font></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email_income_server]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.email_income_server_port]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.fetchServer" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="emailConfig.fetchServerPort" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[email.income.protocol]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.is_need_certificate]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.fetchProtocol" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:radio name="emailConfig.fetchssl" list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple"/></td>
	</tr>
	<tr>
		<td class="email_title" colspan="2"><font>{*[cn.myapps.core.sysconfig.email.email_send_config]*}</font></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_server]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.email_send_server_port]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="emailConfig.smtpServer" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="emailConfig.smtpServerPort" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.email.enable_accessories]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.email.is_need_certificate]*}：</td>
	</tr>
	<tr>
		<td>
			<s:radio name="emailConfig.smtpAuthenticated" list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple"/>
		</td>
		<td>
			<s:radio name="emailConfig.smtpssl" list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple"/>
		</td>
	</tr>
</table>
</fieldset>
</body>
</o:MultiLanguage>
</html>