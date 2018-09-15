<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{*[core.usbkey.cfg]*}</title>

<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src='<s:url value="/dwr/interface/UsbKeyUtil.js"/>'></script>
<script>
<!--
	var ntkologinobj;
	var ntkosignctl;
	function initLoginOcx()
	{
		ntkologinobj = document.all("ntkoekeyloginocx");
		ntkosignctl = document.all("ntkosignctl");
		if(!ntkologinobj)
		{
			alert("EKEY控件初始化失败！");
		}
	}
	/**
	**初始化USBKEY
	**/
	function initUK(){
		if(!confirm("您确定要进行初始化操作吗？")) return false;
		var userId = document.getElementsByName("userId")[0].value;
		var userName = document.getElementsByName("userName")[0].value;
		//var pw = prompt("{*[core.usbkey.tip.inputPassword]*}","");
		try{
			ntkologinobj.Username = userId;
			ntkologinobj.Password = "";
			ntkologinobj.SaveToEkey();
			ntkosignctl.SetEkeyUser(userName);
			if(0 == ntkosignctl.StatusCode){
				alert("EKEY初始化成功！");
			}
		}
		catch(e)
		{
			alert("写入EKEY错误："+ e);
		}
	}
	function ResetEkeyUserPin()
	{
		var adminPassword = document.all("adminPassword").value;
		var newUserPassword1 = document.all("newUserPassword1").value;
		var newUserPassword2 = document.all("newUserPassword2").value;
		if( (newUserPassword1.length<4) || (newUserPassword1.length>16) )
		{
	        alert('EKEY访问口令必须是4-16位.');
	        return false;	
		}
		if( newUserPassword1 != newUserPassword2)
		{
			alert('两次新口令不符合，请重新输入.');
	        return false;
		}
	    ntkologinobj.ResetEkeyUserPassword(adminPassword,newUserPassword1);
	    if(0 == ntkologinobj.StatusCode)
		{
			alert("重设EKEY用户口令成功!");
		}
		else
		{
			alert("重设EKEY用户口令失败!");
		}
	}
	
	jQuery(document).ready(function(){
		initLoginOcx();
	});
	
-->
</script>
</head>
<body class="contentBody">
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<script >

document.write('<object id="ntkoekeyloginocx" classid="clsid:55014A9B-C5DE-466c-9A85-0A1C50B498C2"     ');
document.write('codebase="ntkoekeylogin.cab#version=5,0,2,2" width=0px height=0px >    ');
document.write('<param name="BackColor" value="16744576">   ');
document.write('<param name="ForeColor" value="16777215">   ');
document.write('<param name="EkeyType" value="1">   ');
document.write('<SPAN STYLE="color:red">不能装载EKEY登录控件。请在检查浏览器的选项中检查浏览器的安全设置。</SPAN>   ');
document.write('</object>   ');

document.write('<object id="ntkosignctl" classid="clsid:97D0031E-4C58-4bc7-A9BA-872D5D572896"    ');
document.write('codebase="ntkosigntoolv3.cab#version=4,0,0,6" width=0px height=0px>   ');
document.write('<param name="BackColor" value="16744576">   ');
document.write('<param name="ForeColor" value="16777215">   ');
document.write('<param name="IsShowStatus" value="-1">   ');
document.write('<param name="EkeyType" value="1">   ');
document.write('<SPAN STYLE="color:red">不能装载印章管理控件。请在检查浏览器的选项中检查浏览器的安全设置。</SPAN>   ');
document.write('</Object>   ');
</script>
<div class="ui-layout-center" id="div_content">
<s:form name="usbkeycfg" id="usbkeycfg" action="" method="post" theme="simple">
<div id="contentActDiv">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[core.usbkey.cfg]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="exit_btn" title="{*[Exit]*}" class="justForHelp button-image" onclick="OBPM.dialog.doReturn();" /><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</div>
			</td></tr>
	</table>
</div>
<div id="contentMainDiv" class="contentMainDiv">
	<s:hidden name="userId" value="%{#parameters._userId}"/>
	<s:hidden name="userName" value="%{#parameters._userName}"/>
<fieldset>
	<legend>{*[core.usbkey.user_bingding_ekey]*}</legend>
	<table cellpadding="4" width="96%">
		<tr>
			<td colspan="2">{*[core.usbkey.tip.user_bingding_ekey]*}</td>
		</tr>
		<tr>
			<td><input type="button" value="{*[core.usbkey.user_bingding_ekey]*}" onclick="initUK();"/></td>
			<td>&nbsp;</td>
		</tr>
	</table>
</fieldset>
<fieldset>
	<legend>{*[core.usbkey.tip.changePin]*}</legend>
	<table cellpadding="4" width="96%">
	<tr>
	<td width="120px">{*[core.usbkey.cfg.lable.admin_pw]*}:</td>
	<td align="left"><input id="adminPassword" value=""></td>
	</tr>
	<tr>
	<td width="120px">{*[core.usbkey.cfg.lable.new_pw]*}:</td>
	<td align="left"><input id="newUserPassword1" value=""></td>
	</tr>
	<tr>
	<td width="120px">{*[core.usbkey.cfg.lable.new_pw2]*}:</td>
	<td align="left"><input id="newUserPassword2" value=""></td>
	</tr>
	<tr><td colspan="2"><button onClick="ResetEkeyUserPin()">{*[core.usbkey.cfg.btn.lable.change_pw]*}</button></td></tr>
	</table>
</fieldset>
<fieldset>
	<legend>{*[core.usbkey.tip.driver_download]*}</legend>
	<table cellpadding="4" width="96%">
		<tr>
			<td colspan="2">{*[core.usbkey.tip.driver_download.tip]*}</td>
		</tr>
		<tr>
		<td valign="top">
		<a href="NTKOEKEYUser_4.0.exe" target="_blank">{*[core.usbkey.driver_download.link]*}</a>
		</td>
		</tr>
	</table>
</fieldset>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
