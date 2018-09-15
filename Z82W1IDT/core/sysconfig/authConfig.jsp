<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>{*[cn.myapps.core.sysconfig.content.auth_config ]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function ev_change(value) {
		var loginAuth = document.getElementsByName("authConfig.loginAuth")[0].value;
		document.getElementById("smscfg").style.display = 'none';
		document.getElementById("usbkeycfg").style.display = 'none';
		document.getElementById("sso").style.display = 'none';
		if (value == 'sso') {	
			//document.getElementById("sso").disabled = false;
			document.getElementById("sso").style.display = '';
			
		}else if(value == 'ssl_pkcs12'){
			document.getElementById("sso").style.display = none;
			document.getElementById("span_tab2").style.display = 'none';
			document.getElementById("smscfg").style.display = 'none';	
		}else {
			document.getElementById("span_tab2").style.display = 'none';
			//document.getElementById("sso").disabled = true;
			document.getElementById("sso").style.display = 'none';
		}
		if(value !='sso' && loginAuth == 'cn.myapps.core.sso.autherticator.DefaultLoginAuthenticator'){
			document.getElementById("smscfg").style.display = '';	
			//document.getElementById("usbkeycfg").style.display = '';//暂时屏蔽uk功能
		}
		ev_controlAuth();
	}
	function ev_changeSSOType(value) {

		document.getElementById("cas_tips").style.display = 'none';
		if(value == "cn.myapps.core.sso.CasUserSSO") {
			//document.getElementById("cas").disabled = false;
			document.getElementById("cas").style.display = '';
			document.getElementById("ad").style.display = 'none';
			document.getElementById("cas_tips").style.display = '';
		} else if(value == "cn.myapps.core.sso.ADUserSSO") {
			//document.getElementById("cas").disabled = true;
			document.getElementById("cas").style.display = 'none';
			document.getElementById("ad").style.display = '';
		} else if(value == "cn.myapps.core.sso.CookieUserSSO"){
			document.getElementById("cas").style.display = 'none';
			document.getElementById("ad").style.display = 'none';
		}
		ev_controlAuth();
	}
	function ev_changeAuth(val) {		
		if(val == 'cn.myapps.core.sso.autherticator.ADLoginAuthenticator'){
			document.getElementsByName("authConfig.loginAuth")[1].checked = true;			
			document.getElementById("span_tab2").style.display = '';
			//document.getElementById("ldap1").style.display = '';
			document.getElementById("user.synchronize.config").style.display = '';
			document.getElementById("logout_url_label").style.display = 'none';
			document.getElementById("logout_url_input").style.display = 'none';
		} else {
			document.getElementsByName("authConfig.loginAuth")[0].checked = true;				
			document.getElementById("span_tab2").style.display = 'none';
			//document.getElementById("ldap1").style.display = 'none';
			document.getElementById("user.synchronize.config").style.display = 'none';
			document.getElementById("logout_url_label").style.display = '';
			document.getElementById("logout_url_input").style.display = '';
		}
		var authType = '';
		if(document.getElementsByName('authConfig.authType')[0].checked){
			authType = document.getElementsByName('authConfig.authType')[0].value;
		}else{
			authType = document.getElementsByName('authConfig.authType')[1].value;
		}
		ev_change(authType);
	}

	// 选择LDAP只能在单点登录且方式为AD的时候
	function ev_controlAuth(){
		var sso = document.getElementsByName("authConfig.authType")[1].checked;
		var ssoAuth = document.getElementsByName("authConfig.ssoAuth")[0].value;
		if(sso && ssoAuth == 'cn.myapps.core.sso.ADUserSSO'){
			//选中LDAP登录验证方式
			document.getElementsByName("authConfig.loginAuth")[1].click();
		}else{
			//选中默认登录验证方式
			document.getElementsByName("authConfig.loginAuth")[0].click();
		}
	}
	
	jQuery(document).ready(function(){
		var sso = '<s:property value="authConfig.authType"/>';
		var ssoType = '<s:property value="authConfig.ssoAuth"/>';
		var ldap = '<s:property value="authConfig.loginAuth"/>';
		var smsAuth = '<s:property value="authConfig.smsAuthenticate"/>';
		var usbkeyAuth = '<s:property value="authConfig.usbkeyAuthenticate"/>';
		ev_change(sso);
		ev_changeSSOType(ssoType);
		ev_changeAuth(ldap);
		ev_smsAuthChange(smsAuth);
		ev_usbkeyAuthChange(usbkeyAuth);
		//ev_smsAuthLoad(document.getElementById("authConfig.smsTimeout"));
		var str = document.getElementsByName('authConfig.usbkeyRangeIps')[0].value;
		var datas = parseRelStr(str);
		addRows(datas);
		var ssoTypeVal = document.getElementsByName("authConfig.ssoSaveType")[0].value;
		ssoSaveTypeChange(ssoTypeVal);
	});
	function ev_smsAuthChange(obj){
		if(obj == false || obj == 'false'){
			document.getElementById("authConfig.smsTimeout").disabled = true;
			document.getElementById("authConfig.smsContent").disabled = true;
			document.getElementsByName("authConfig.smsAffectMode")[0].disabled = true;
			document.getElementsByName("authConfig.smsAffectMode")[1].disabled = true;
			document.getElementsByName("authConfig.smsAffectMode")[2].disabled = true;
			document.getElementById("authConfig.smsStartRangeIp").disabled = true;
			document.getElementById("authConfig.smsEndRangeIp").disabled = true;
		}else{
			document.getElementById("authConfig.smsTimeout").disabled = false;
			document.getElementById("authConfig.smsContent").disabled = false;
			document.getElementsByName("authConfig.smsAffectMode")[0].disabled = false;
			document.getElementsByName("authConfig.smsAffectMode")[1].disabled = false;
			document.getElementsByName("authConfig.smsAffectMode")[2].disabled = false;
			if(document.getElementsByName("authConfig.smsAffectMode")[0].checked){
				document.getElementById("authConfig.smsStartRangeIp").disabled = true;
				document.getElementById("authConfig.smsEndRangeIp").disabled = true;
			}else{
				document.getElementById("authConfig.smsStartRangeIp").disabled = false;
				document.getElementById("authConfig.smsEndRangeIp").disabled = false;
			}
			

			var temp = document.getElementsByName("authConfig.smsAffectMode");
			for(var i=0; i<temp.length; i++){
				if(temp[i].checked){
					ev_iprangeChange(temp[i].value);
					break;
				}
			}
		}
	}
	function ev_usbkeyAuthChange(obj){
		if(obj == false || obj == 'false' || obj ==''){
			document.getElementById("dr_affectMode_lable").style.display = "none";
			document.getElementById("dr_affectMode_field").style.display = "none";
			document.getElementById("tb_usbkeyRangeIps").style.display = "none";
			document.getElementById("td_affectRange").style.display = "none";
			
		}else{
			document.getElementById("dr_affectMode_lable").style.display = "";
			document.getElementById("dr_affectMode_field").style.display = "";
			document.getElementById("tb_usbkeyRangeIps").style.display = "";
			document.getElementById("td_affectRange").style.display = "";
		}
	}

	function ev_iprangeChange(value){
		if(value != "all"){
			document.getElementById("authConfig.smsStartRangeIp").disabled = false;
			document.getElementById("authConfig.smsEndRangeIp").disabled = false;
		}else{
			document.getElementById("authConfig.smsStartRangeIp").disabled = true;
			document.getElementById("authConfig.smsEndRangeIp").disabled = true;
		}
	}
</script>
<script type="text/javascript">
//生成mapping Json
function buildMappingJsonStr(){
	var pkey = document.getElementsByName("startIP");
	var pvalue = document.getElementsByName("endIP");
	var str = '[';
	for (var i=0;i<pkey.length;i++) {
		if (pkey[i].value != '' && pvalue[i].value != '' ){
				str += '{';
				str += pkey[i].name +':\''+pkey[i].value+'\',';
				str += pvalue[i].name +':\''+pvalue[i].value+'\'';
				str += '},';
		}
	}
	str += ']';
	return  str;	

}
function ev_smsAffectModeChange(value){
	document.getElementById("authConfig.smsStartRangeIp").disabled = false;
	document.getElementById("authConfig.smsEndRangeIp").disabled = false;
	if(value =='all'){
		document.getElementById("authConfig.smsStartRangeIp").disabled = true;
		document.getElementById("authConfig.smsEndRangeIp").disabled = true;
	}
	
}
//根据mapping str获取data array
function parseRelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();	
	}
}

var rowIndex = 0;
var getParamKey = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="startIP'+ rowIndex +'" name="startIP" style="width:100" value="'+HTMLDencode(data.startIP)+'" />';
	return s; 
	}
};

var getParamValue = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="endIP'+ rowIndex +'" name="endIP" style="width:100" value="'+HTMLDencode(data.endIP)+'" />';
	return s;
	}
};

var getDelete = function(data) {
	if(data){
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(\'_tb\', this.parentNode.parentNode)"/>';
  	rowIndex ++;
  	return s;
	}
};

//根据数据增加行
function addRows(datas) {
	var cellFuncs = [getParamKey, getParamValue, getDelete];

	var rowdatas = datas;
	if (!datas || datas.length == 0) {
		var data = {paramKey:'', paramValue:''};
		rowdatas = [data];
	}
	
	DWRUtil.addRows("_tb", rowdatas, cellFuncs);
	
}

// 删除一行
function delRow(id, row) {
	var elem = jQuery("#"+ id);
	if (elem) {
		elem.deleteRow(row.rowIndex);
		//rowIndex --;
	}
}

function ssoSaveTypeChange(val){
	if(val == 'none'){
		document.getElementsByName("authConfig.ssoKeyLoginAccount")[0].disabled = true;
		document.getElementsByName("authConfig.ssoKeyDomain")[0].disabled = true;
		document.getElementsByName("authConfig.ssoKeyEmail")[0].disabled = true;
		document.getElementsByName("authConfig.ssoDataEncryption")[0].disabled = true;
	}else{
		document.getElementsByName("authConfig.ssoKeyLoginAccount")[0].disabled = false;
		document.getElementsByName("authConfig.ssoKeyDomain")[0].disabled = false;
		document.getElementsByName("authConfig.ssoKeyEmail")[0].disabled = false;
		document.getElementsByName("authConfig.ssoDataEncryption")[0].disabled = false;
	}
}
</script>
</head>
<body>
	<fieldset>
		<legend>{*[cn.myapps.core.sysconfig.authConfig.basic_config]*}</legend>
		<table width="100%">
			<tr>
				<td>{*[cn.myapps.core.sysconfig.authConfig.auth_pattern]*}：</td>
				<td style="display: none;">{*[cn.myapps.core.sysconfig.authConfig.auth_type]*}：</td>
			</tr>
			<tr>
				<td><s:radio name="authConfig.authType" list="#{'default':'{*[cn.myapps.core.sysconfig.authConfig.interface_login]*}','sso':'{*[cn.myapps.core.sysconfig.authConfig.sso_login]*}','ssl_pkcs12':'{*[cn.myapps.core.sysconfig.authConfig.authType.ssl_pkcs12]*}'}"
						onclick="ev_change(this.value)" theme="simple" /></td>
				<td style="display: none;">
					<span id='span_DefaultLoginAuthenticator'>
						<input type="radio" name="authConfig.loginAuth" value="cn.myapps.core.sso.autherticator.DefaultLoginAuthenticator" onclick ="ev_changeAuth(this.value)"/>{*[default]*}
					</span>
					<span id='span_ADLoginAuthenticator'>
						<input type="radio" name="authConfig.loginAuth" value="cn.myapps.core.sso.autherticator.ADLoginAuthenticator" onclick ="ev_changeAuth(this.value)"/>AD域
					</span>
				</td>
			</tr>
			
			<tr id="smscfg" style="display: none;">
				<td width="50%">
					<table>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.sms_authenticate]*}：</td>
						</tr>
						<tr>
							<td>
								<s:checkbox name="authConfig.smsAuthenticate"  onclick="ev_smsAuthChange(this.checked)" fieldValue="true" label="{*[cn.myapps.core.sysconfig.authConfig.sms]*}" theme="simple"/>{*[Open]*}
							</td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.sms_affect_mode]*}：</td>
						</tr>
						<tr>
							<td>
								<s:radio name="authConfig.smsAffectMode" list="#{'all':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_all]*}','match':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_match]*}','exclude':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_exclude]*}'}" theme="simple" onclick="ev_smsAffectModeChange(this.value);" />
							<!--  	<s:hidden id="authConfig.smsAffectMode.hidden"
								name="authConfig.smsAffectMode"/> -->
							</td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.sms_affect_range]*}：</td>
						</tr>
						<tr>
							<td>
								<s:textfield id="authConfig.smsStartRangeIp" name="authConfig.smsStartRangeIp"
								cssStyle="width:140px;" theme="simple"/>
								<s:textfield name="authConfig.smsEndRangeIp" id="authConfig.smsEndRangeIp"
								cssStyle="width:140px;" theme="simple"/>
							<!--  	<s:hidden id="authConfig.smsStartRangeIp.hidden"
								name="authConfig.smsStartRangeIp"/>
								<s:hidden id="authConfig.smsEndRangeIp.hidden"
								name="authConfig.smsEndRangeIp"/> -->
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.sms_timeout]*}：</td>
						</tr>
						<tr>
							<td><s:textfield id="authConfig.smsTimeout" name="authConfig.smsTimeout"
								cssStyle="width:280px;" theme="simple"/>
							  <!-- <s:hidden id="authConfig.smsTimeout.hidden"
								name="authConfig.smsTimeout"/> -->	
								</td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.sms_content]*}：</td>
						</tr>
						<tr>
							<td>
								<s:textarea id="authConfig.smsContent" name="authConfig.smsContent" rows="4" cssStyle="width:280px;" theme="simple"/>
							   <!--   <s:hidden id="authConfig.smsContent.hidden"
								name="authConfig.smsContent"/>-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr id="usbkeycfg" style="display: none;">
				<td width="50%">
					<table>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.authConfig.usbkey_authenticate]*}：</td>
						</tr>
						<tr>
							<td>
								<s:checkbox name="authConfig.usbkeyAuthenticate"  onclick="ev_usbkeyAuthChange(this.checked)" fieldValue="true" label="{*[cn.myapps.core.sysconfig.authConfig.usbkey_authenticate]*}" theme="simple"/>{*[Open]*}
							</td>
						</tr>
						<tr id="dr_affectMode_lable">
							<td>USBKey身份认证{*[cn.myapps.core.sysconfig.authConfig.sms_affect_mode]*}：</td>
						</tr>
						<tr id="dr_affectMode_field">
							<td>
								<s:radio name="authConfig.usbkeyAffectMode" list="#{'all':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_all]*}','match':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_match]*}','exclude':'{*[cn.myapps.core.sysconfig.authConfig.affect_mode_exclude]*}'}" theme="simple" />
							</td>
						</tr>
						<tr id="td_affectRange">
							<td>USBKey身份认证{*[cn.myapps.core.sysconfig.authConfig.sms_affect_range]*}：</td>
						</tr>
						<tr>
							<td>
								<table class="table_hasborder" id="tb_usbkeyRangeIps" border=1 cellpadding="0" cellspacing="0" bordercolor="gray" >
									<tbody id="_tb">
											<tr>
												<td align="left" class="commFont">{*[cn.myapps.core.sysconfig.authConfig.start_ip]*}</td>
												<td align="left" class="commFont">{*[cn.myapps.core.sysconfig.authConfig.end_ip]*}</td>
												<td align="left"><input type="button" value="{*[Add]*}" onclick="addRows()" /></td>
											</tr>
									</tbody>
								</table>
								 <s:hidden id="authConfig.usbkeyRangeIps" name="authConfig.usbkeyRangeIps"/>
							</td>
						</tr>
					</table>
				</td>
				<td>
				</td>
			</tr>
			<tr id="sso" style="display: none;">
				<td width="50%">
					<table>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.sso_type]*}：<span id="cas_tips" style="display:none;color:green;">({*[cn.myapps.core.sysconfig.sso_type.cas_tips]*})</span></td>
						</tr>
						<tr>
							<td><s:select name="authConfig.ssoAuth"
								list="#{'cn.myapps.core.sso.CookieUserSSO':'cookie',
								'cn.myapps.core.sso.CasUserSSO':'{*[cn.myapps.core.sysconfig.cas_server]*}',
								'cn.myapps.core.sso.ADUserSSO':'AD/LDAP'}"
								cssStyle="width:280px;" onchange="ev_changeSSOType(this.value)" theme="simple">
							</s:select></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.homepage_redirect_url]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.ssoRedirect"
								cssStyle="width:280px;" theme="simple" /></td>
						</tr>
						<tr id="logout_url_label">
							<td>{*[cn.myapps.core.sysconfig.logout_redirect_url]*}：</td>
						</tr>
						<tr id="logout_url_input">
							<td><s:textfield name="authConfig.ssoLogoutRedirect"
								cssStyle="width:280px;" theme="simple" /></td>
						</tr>
					</table>
				</td>
				<td>
					<table id="cas" class="id1">
						<tr>
							<td>{*[cn.myapps.core.sysconfig.local_server_name]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.localServerName"
								cssClass="input-cmd" theme="simple" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.login_url]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.casLoginUrl"
								cssStyle="width:100%;" theme="simple" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.url_prefix]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.casUrlPrefix"
								cssStyle="width:100%;" theme="simple" /></td>
						</tr>
					</table>
					<table id="ad" class="id1">
						<tr>
							<td>{*[cn.myapps.core.sysconfig.controller]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.adDomainController"
								cssClass="input-cmd" theme="simple" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.ad_default_domain]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.adDefaultDomain"
								cssStyle="width:100%;" theme="simple" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.ad_admin_loginno]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.adadminloginno"
								cssStyle="width:100%;" theme="simple" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.ad_admin_loginnopw]*}：</td>
						</tr>
						<tr>
							<td><input type="password" name="authConfig.adadminloginnopw"
								value='<s:property value="authConfig.adadminloginnopw"/>' class="input-cmd" /></td>
						</tr>
						<tr>
							<td>{*[cn.myapps.core.sysconfig.ad_login_domain]*}：</td>
						</tr>
						<tr>
							<td><s:textfield name="authConfig.adlogindomain"
								cssStyle="width:100%;" theme="simple" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</fieldset>
	<fieldset id="user.synchronize.config" style="display:none">
		<legend>{*[cn.myapps.core.sysconfig.user_synchronize._config]*}</legend>
		<table class="id1" width="100%">
			<tr>
				<td>{*[cn.myapps.core.sysconfig.default_email_address]*}：</td>
				<td>{*[cn.myapps.core.sysconfig.default_password]*}：</td>
			</tr>
			<tr>
				<td><s:textfield name="authConfig.ssoDefaultEmail"
					cssClass="input-cmd" theme="simple" /></td>
				<td><s:textfield name="authConfig.ssoDefaultPassword"
					cssClass="input-cmd" theme="simple" /></td>
			</tr>
		</table>
	</fieldset>
	<fieldset>
		<legend>{*[cn.myapps.core.sysconfig.after_auth_user_info_save_config]*}</legend>
		<table class="id1" width="100%">
			<tr>
				<td>{*[cn.myapps.core.sysconfig.save_type]*}：</td>
				<td>{*[cn.myapps.core.sysconfig.data_encryption_type]*}：</td>
			</tr>
			<tr>
				<td><s:select name="authConfig.ssoSaveType"
					list="#{'none':'{*[none]*}','cookie':'Cookie','session':'Session'}"
					cssClass="input-cmd" theme="simple" onchange="ssoSaveTypeChange(this.value)"></s:select></td>
				<td><s:select name="authConfig.ssoDataEncryption"
					list="#{'none':'','base64':'Base64'}" cssClass="input-cmd"
					theme="simple"></s:select></td>
			</tr>
			<tr>
				<td>{*[cn.myapps.core.sysconfig.user_loginno_key_name]*}：</td>
				<td>{*[cn.myapps.core.sysconfig.domain_key_name]*}：</td>
			</tr>
			<tr>
				<td><s:textfield name="authConfig.ssoKeyLoginAccount"
					cssClass="input-cmd" theme="simple" /></td>
				<td><s:textfield name="authConfig.ssoKeyDomain"
					cssClass="input-cmd" theme="simple" /></td>
			</tr>
			<tr>
				<!-- <td>{*[cn.myapps.core.sysconfig.user_login_password_key_name]*}：</td>  -->
				<td>{*[cn.myapps.core.sysconfig.user_email_key_name]*}：</td>
			</tr>
			<tr>
				<!-- <td><s:textfield name="authConfig.ssoKeyPassword"
					cssClass="input-cmd" theme="simple" /></td> -->
				<td><s:textfield name="authConfig.ssoKeyEmail"
					cssClass="input-cmd" theme="simple" /></td>
			</tr>
		</table>
	</fieldset>
</body>
</html>