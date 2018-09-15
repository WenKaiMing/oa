<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

function ev_user(){
	var url = contextPath+"/core/sysconfig/SynUsersToHx.action";
	jQuery.post(url,function(data){
		if(data == "ok"){
			alert("success");
		}else{
			alert("error");
		}
	});
}

function setHref(s){
	var url = "https://console.easemob.com/index.html#/login?_k=fgh8ly";
	window.open(url);
}

jQuery(document).ready(function(){
	disabledElement();
});
</script>
<body>
<fieldset >
<legend>HX{*[Configuration]*}</legend>
<div id="hximContent">
<div style="float:right;">
	<button type="button" id="gkeBackstage" class="button-image" onclick="setHref(this)" title="GKE{*[cn.myapps.core.sysconfig.im.manage_backstage]*}"><img border="0" src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> HX{*[cn.myapps.core.sysconfig.im.manage_backstage]*}</button>
	<button type="button" id="domain_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_domain]*}" style="display:none;" class="button-image" onClick="ev_domian()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_domain]*}</button>
	<button type="button" id="department_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_department]*}"  style="display:none;" class="button-image" onClick="ev_department()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_department]*}</button>
	<button type="button" id="user_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_user]*}" class="button-image" onClick="ev_user()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_user]*}</button>
	<button type="button" id="cleanData" title="{*[Clear]*}" class="button-image" style="display:none;" onClick="ev_clean()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> 清空数据</button>
</div>
<table class="table_noborder id1">
	<tr>
		<td>ORG_NAME：</td>
		<td>APP_NAME：</td>
	</tr>
	<tr>
		<td><s:textfield id="ip" name="hxImConfig.org_name" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield id="port" name="hxImConfig.app_name" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>CLIENT_ID：</td>
		<td>CLIENT_SECRET：</td>
	</tr>
	<tr>
		<td><s:textfield name="hxImConfig.client_id" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:password name="hxImConfig.client_secret" cssClass="input-cmd" theme="simple" onblur="" showPassword="true"/></td>
	</tr>
	<tr>
		<td>GRANT_TYPE：</td>
		<td>APP_KEY：</td>
	</tr>
	<tr>
		<td><s:textfield name="hxImConfig.grant_type" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield name="hxImConfig.app_key" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
</table>
</div>
</fieldset>
</body>
</html>