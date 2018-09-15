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
	/**
	**初始化USBKEY
	**/
	function initUK(){
		if(!findToken()) return false;
		if(!confirm("您确定要进行初始化操作吗？")) return false;
		var r1,r2,r3,r4,r5;
		var userId = document.getElementsByName("userId")[0];
		var pw = prompt("{*[core.usbkey.tip.inputPassword]*}","");
		if(pw!=null && pw.length>0){
			r1 = GDInitCtrl.InitToken;//初始化usbkey
			if(r1==0){
				r2 = GDInitCtrl.WriteData("11111111", userId.value, "0");
				r3 = GDInitCtrl.GenKey("11111111");//生成密钥对
				r4 = GDInitCtrl.ChangPIN("11111111", pw);//修改密码（ 默认密码为11111111）
				r5 = GDInitCtrl.GetPublicKey;//获取公钥的模
			}
			if(r1==0 && r2==0 && r3==0 && r4==0 && r5==0){
				var pubKey = GDInitCtrl.GetResult;
				DWREngine.setAsync(false);
				UsbKeyUtil.storePublicKey(userId.value,pubKey,function(data){
					if(data==0){
						alert("{*[core.usbkey.tip.successInit]*}");
					}
				});
				DWREngine.setAsync(true);
			}else{
				alert("{*[core.usbkey.tip.faultInit]*}");
			}
		  }else{
			  alert("{*[core.usbkey.tip.inputPassword]*}");
		  }
	}
	/**
	**判断是否连接USBKEY
	**/
	function findToken()
	{
		var result = GDInitCtrl.FindToken;
		if (result == 0)
		{
			return true;
		}
		else
		{
			alert("{*[core.usbkey.tip.usbkeyNotFound]*}");
			return false;
		}
	}
	/**
	**修改PIN密码
	**/
	function changePin()
	{
		if(!findToken()) return false;
		var oldPassword = document.getElementsByName("oldPassword")[0];
		var newPassword = document.getElementsByName("newPassword")[0];
		var result = GDInitCtrl.ChangPIN(oldPassword.value, newPassword.value);
		if (result == 0)
		{
			alert("{*[core.usbkey.tip.successChangePin]*}");
		}
		else
		{
			alert("{*[core.usbkey.tip.faultChangePin]*}");
		}
	}
	/**
	**生成密钥对
	**/
	function GenKey()
	{
		if(!findToken()) return false;
		var pw = prompt("{*[core.usbkey.tip.inputPassword]*}","");
		if(pw!=null && pw.length>0){
			var result = GDInitCtrl.GenKey(pw);
			if (result == 0){
				var r1 = GDInitCtrl.GetPublicKey;//获取公钥的模
				if(r1==0){
					var pubKey = GDInitCtrl.GetResult;
					UsbKeyUtil.storPublicKey(userId.value,pubKey,function(data){
						if(data==0){
							alert("{*[core.usbkey.tip.successGenKey]*}");
							return;
						}
					});
				}
			}
			alert("{*[core.usbkey.tip.faultGenKey]*}");
		 }else {
			 alert("{*[core.usbkey.tip.inputPassword]*}");
		 }
	}
	
	jQuery(document).ready(function(){
		if(navigator.userAgent.indexOf("MSIE")>0) {
		}else {
			document.getElementById("div_content").style.display = "none";
			document.getElementById("div_broser_note").style.display = "";
		}
	});
	
-->
</script>
</head>
<body class="contentBody">
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<s:property escape="false" value="#usbKeyUtil.toActiveXHtmlText()"/>
<div id="div_broser_note" style="display:none;">
	<span style="color: red;font-size: 18">{*[core.usbkey.cfg]*}仅支持IE内核的浏览器！</span>
</div>
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
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<fieldset>
	<legend>{*[core.usbkey.tip.init]*}</legend>
	<table cellpadding="4" width="96%">
		<tr>
			<td colspan="2">{*[core.usbkey.tip.usbkeyInitNotice]*}</td>
		</tr>
		<tr>
			<td><input type="button" value="{*[core.usbkey.tip.init]*}" onclick="initUK();"/></td>
			<td>&nbsp;</td>
		</tr>
	</table>
</fieldset>
<fieldset>
	<legend>{*[core.usbkey.tip.changePin]*}</legend>
	<table cellpadding="4" width="96%">
		<tr>
			<td colspan="2">{*[core.usbkey.tip.usbkeyChangePinNotice]*}</td>
		</tr>
		<tr>
			<td width="15%" align="left">{*[core.usbkey.tip.oldPin]*}：</td>
			<td><INPUT type="password" name="oldPassword"></td>
		</tr>
		<tr>
			<td width="15%" align="left">{*[core.usbkey.tip.newPin]*}：</td>
			<td align="left"><INPUT type="password" name="newPassword"></td>
		</tr>
		<tr>
			<td width="15%" align="left">&nbsp;</td>
			<td align="left"><input type="button" value="{*[core.usbkey.tip.changePin]*}" onclick="changePin();"/></td>
		</tr>
	</table>
</fieldset>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
