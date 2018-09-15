<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
<head>
	<title>{*[cn.myapps.core.sysconfig.content.system_config_info]*}</title>
</head>
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
<body>
<fieldset>
<legend>{*[cn.myapps.core.sysconfig.authConfig.basic_config]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td>LDAP{*[cn.myapps.core.sysconfig.ldap.server_url]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.ldap.user_dn]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.url" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="ldapConfig.dirStructure" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>baseDN：</td>
		<td>{*[cn.myapps.core.sysconfig.ldap_pooled]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.baseDN" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:radio name="ldapConfig.pooled" list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap_manager]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.ldap.ldap_managerpassword]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.manager" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><input type="password" name="ldapConfig.managerPassword" class="input-cmd" onblur="" value='<s:property value="ldapConfig.managerPassword"/>'/></td>
	</tr>
	<!--<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.ldap_domain]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.domain" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
--></table>
</fieldset>
<fieldset>
<legend>LDAP{*[cn.myapps.core.sysconfig.ldap.user_field_mapping_config]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.user_class]*}: </td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.userClass" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.user_id]*}：</td>
		<td>{*[User_Name]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.id_" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="ldapConfig.name_" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.user_loginno]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.ldap.user_login_password]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.loginno_" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="ldapConfig.loginpwd_" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.email_address]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.ldap.telephone]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.email_" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="ldapConfig.telephone_" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
</table>
</fieldset>

<fieldset>
<legend>{*[cn.myapps.core.sysconfig.ldap.department_field_mapping_config]*}</legend>
<table class="table_noborder id1">
	<tr>
		<td>{*[cn.myapps.core.sysconfig.ldap.department_class]*}: </td>
		<td>{*[cn.myapps.core.sysconfig.ldap.top_department]*}: </td>
	</tr>
	<tr>
		<td><s:textfield name="ldapConfig.deptClass" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="ldapConfig.enterDept" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
</table>
</fieldset>
</body>
</o:MultiLanguage>
</html>