<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
<head>
	<title>{*[cn.myapps.core.sysconfig.content.user_massage_config]*}</title>
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
	<script type="text/javascript">
	function ev_change_login(obj) {	
		if (obj=="0") {

			document.getElementById("con").style.display = '';
			document.getElementById("con1").style.display = '';
			document.getElementById("con2").style.display = '';
			document.getElementById("con3").style.display = '';
			document.getElementById("con4").style.display = '';
			document.getElementById("con5").style.display = '';
			
		} else {

			document.getElementById("con").style.display = 'none';
			document.getElementById("con1").style.display = 'none';
			document.getElementById("con2").style.display = 'none';
			document.getElementById("con3").style.display = 'none';
			document.getElementById("con4").style.display = 'none';
			document.getElementById("con5").style.display = 'none';
		
		}
	}
	//去所有空格   
	String.prototype.trimAll = function(){   
	    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");  
	    }
	jQuery(document).ready(function(){
		var loginCm = '<s:property value = "loginConfig.noticeMethod"/>';
		arr = loginCm.split(",");		
		for(var i = 0;i<arr.length;i++){
			if(arr[i]==1){
				document.getElementsByName("loginConfig.noticeMethod")[0].checked=true;
				}	
			if(arr[i]==2){
				document.getElementsByName("loginConfig.noticeMethod")[1].checked=true;
				}
			if(arr[i]==3){
				document.getElementsByName("loginConfig.noticeMethod")[2].checked=true;
				}
			}
		var noticeAuthor = '<s:property value="loginConfig.noticeAuthor"/>';	
		ev_change_login(noticeAuthor);
	});
	
	function checkNumberic(value){
		var maxUpdateTimes = value;
			if(maxUpdateTimes != "" && maxUpdateTimes <= 0 ){
				alert("规定次数不低于0次");
				document.getElementsByName("loginConfig.maxUpdateTimes")[0].value = "";
			}
	}
	</script>
</head>
<body>
<fieldset>
<legend>{*[cn.myapps.core.sysconfig.content.user_massage_config]*}<span class="tipsStyle">{*[cn.myapps.core.sysconfig.content.user_massage_config]*}</span></legend>
<table class="table_noborder id1">
	<tr>
		<td>{*[cn.myapps.core.sysconfig.loginConfig.password_min_length]*}：<span class="tipsStyle">{*[cn.myapps.core.sysconfig.loginConfig.password_min_length_cue]*}</span></td>
		<td>{*[cn.myapps.core.sysconfig.loginConfig.most_failed_login_attempts]*}：<span class="tipsStyle">{*[cn.myapps.core.sysconfig.loginConfig.time_cue]*}</span></td>
	</tr>
	<tr>
		<td><s:textfield name="loginConfig.length" cssClass="input-cmd" theme="simple" /></td>
		<td><s:textfield name="loginConfig.failLoginTimes" cssClass="input-cmd" theme="simple" /></td>
	</tr>
	
	<tr>
		<td>{*[cn.myapps.core.sysconfig.loginConfig.password_legal]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.loginConfig.modify_password_not_same]*}：<span class="tipsStyle">{*[cn.myapps.core.sysconfig.loginConfig.time_cue]*}</span></td>
	</tr>
	<tr>
		<td><s:radio name="loginConfig.legal" list="#{'1':'{*[Yes]*}','0':'{*[No]*}'}" 
			theme="simple" onblur="" />
		</td>
		<td><s:textfield name="loginConfig.maxUpdateTimes" cssClass="input-cmd" theme="simple" onkeyup="value=value.replace(/[^\d]/g,'')" onblur="checkNumberic(value)"/></td>
	</tr>
    

</table>
</fieldset>
<fieldset>
<legend>{*[cn.myapps.core.sysconfig.loginConfig.password_modify_notice]*}</legend>
<table class="table_noborder id1">


   <tr>
				<td>{*[cn.myapps.core.sysconfig.loginConfig.not_notice_modify_password]*}：
					<s:radio name="loginConfig.noticeAuthor" list="#{'1':'{*[Yes]*}','0':'{*[No]*}'}" 
					onclick = "ev_change_login(this.value)"
			theme="simple" onblur="" />
					</td><td></td>
			</tr>

	<tr id = "con">
		<td>{*[cn.myapps.core.sysconfig.loginConfig.modify_password_expiration]*}：</td>
		<td>{*[cn.myapps.core.sysconfig.loginConfig.password_change_notification_period]*}：</td>
	</tr>
	<tr id = "con1">
		<td><s:textfield name="loginConfig.maxAge" cssClass="input-cmd" theme="simple" /></td>
		<td><s:textfield name="loginConfig.noticeTime" cssClass="input-cmd" theme="simple" /></td>
	</tr>
	
	
	<tr id = "con2">
	<td>{*[cn.myapps.core.sysconfig.loginConfig.notice_method]*}：</td><td>{*[cn.myapps.core.sysconfig.loginConfig.notice_content]*}：</td>
	</tr>
	<TR id = "con3">
	<TD>
   <input type ="checkbox" name="loginConfig.noticeMethod" Value="1" 
						 />{*[SMS]*}    
   <input type ="checkbox" name="loginConfig.noticeMethod" Value="2" 
						 />{*[PersonalMessage]*}					 
   <input type ="checkbox" name="loginConfig.noticeMethod" Value="3" 
						 />{*[Email]*}
						 

					</TD><TD><s:textarea name = "loginConfig.noticeContent"
	cssClass="input-cmd" theme="simple" ></s:textarea></TD>
	</TR>
	<tr id = "con4"><td></td><td></td></tr>
	<tr id = "con5"><td></td><td></td></tr>
</table>
</fieldset>
</body>
</o:MultiLanguage>
</html>