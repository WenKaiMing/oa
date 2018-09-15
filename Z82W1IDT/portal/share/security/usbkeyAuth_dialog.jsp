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

function verify(){
	if(!findToken()) return false;
	var r1,r2,userId,signText,result;
	var pw = document.getElementsByName("password")[0].value;
	if(!pw || pw.length<=0){
		alert("{*[page.login.password]*}");
		return false;
	}
	r1 = GDInitCtrl.ReadData(pw, "100", "0");
	DWREngine.setAsync(false);
	if(r1==0){
		userId = GDInitCtrl.GetResult;
		UsbKeyUtil.getRandomCode4Flow(userId,function(randomCode){
			if(randomCode.length>0){
				r2 = GDHidCtrl.SignMsg(pw,randomCode);
				if(r2==0){
					signText = GDHidCtrl.GetResult;
					UsbKeyUtil.verifyUK(userId,randomCode,signText,function(data){
						DWREngine.setAsync(true);
						result = data;
						if(result == "true"){
							OBPM.dialog.doReturn(result);
							return false;
						}
					});
				}
			}
		});
	}
	if(r1!=0 || r2!=0 || result=="false"){
		alert('USBKEY认证失败，请重试！');
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
	
	jQuery(document).ready(function(){
		if(navigator.userAgent.indexOf("MSIE")>0) {
		}else {
			document.getElementById("div_content").style.display = "none";
			document.getElementById("div_broser_note").style.display = "";
		}
	});
	
	jQuery(document).ready(function(){
		if(navigator.userAgent.indexOf("MSIE")>0) {
			findUsbKey();
		}else {
			document.getElementById("contentMainDiv").style.display = "none";
			document.getElementById("div_broser_note").style.display = "";
		}
	});
	
	function findUsbKey(){
		var result = GDInitCtrl.FindToken;
		if(result == 0){
			showTip('');
			document.getElementById("div_btn_findToken").style.display = "none";
			document.getElementById("div_btn_verify").style.display = "";
			document.getElementById("password").disabled = false;
		}else {
			showTip('{*[core.usbkey.tip.usbkeyNotfound]*}');
			document.getElementById("div_btn_findToken").style.display = "";
			document.getElementById("div_btn_verify").style.display = "none";
			document.getElementById("password").disabled = true;
		}
	}
	
	function showTip(content) {
		document.getElementById("tipsArea").innerHTML = content;
	}
	
-->
</script>
</head>
<body class="contentBody">
<div style="display:none;">
	<OBJECT id="GDInitCtrl" classid="clsid:0F7C23A0-233A-4D9E-915B-E7EA2E0C873D" height="0" width="0" VIEWASTEXT>
	</OBJECT>
	<OBJECT id="GDHidCtrl" classid="clsid:220ED87A-CB03-45A8-A81E-1C5597E11186" height="0" width="0" VIEWASTEXT>
	</OBJECT>
</div>
<div id="div_broser_note" style="display:none;">
	<span style="color: red;font-size: 18">USBKEY身份认证功能仅支持IE内核的浏览器！</span>
</div>
<div class="ui-layout-center" id="div_content">
<s:form name="usbkeyauth" id="usbkeyauth" action="" method="post" theme="simple">
<div id="contentActDiv">
	<table class="table_noborder">
			<tr>
			<td>
				<div class="actbtndiv">
					<button type="button" id="exit_btn" title="{*[Exit]*}" class="justForHelp button-image" onclick="OBPM.dialog.doReturn();" /><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</div>
			</td></tr>
	</table>
</div>
<div id="contentMainDiv" class="contentMainDiv">
	<s:hidden name="userId" value="%{#parameters._userId}"/>
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table cellpadding="4" cellspacing="0" border="0"  width="95%" align="center">
	<tr>
		<td colspan="2"><div id="noteArea" style="color: blue;">{*[core.usbkey.tip.doflowNotice]*}</div></td>
	</tr>
	<tr>
		<td width="16%">{*[Password]*}：</td>
		<td><input type="password" name="password" id="password" value="" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><div id="tipsArea" style="color: red;">&nbsp;</div></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<div id="div_btn_verify">
		<input type="button" id="btn_verify" onclick="verify();" alt="{*[core.usbkey.tip.verify]*}" value="{*[core.usbkey.tip.verify]*}"/>
		</div>
		<div id="div_btn_findToken">
		<input type="button" id="btn_findToken" onclick="findUsbKey()" alt="{*[core.usbkey.tip.findUsbKey]*}" value="{*[core.usbkey.tip.findUsbKey]*}"/>
		</div>
		</td>
	</tr>
	</table>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
