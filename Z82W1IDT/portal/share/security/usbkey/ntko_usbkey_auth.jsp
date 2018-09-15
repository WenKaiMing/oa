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
<script>
<!--
var ntkologinobj;
function initLoginOcx()
{
	ntkologinobj = document.all("ntkoekeyloginocx");
	if(!ntkologinobj)
	{
		alert("EKEY登录控件初始化失败！");
	}
}

function verify(){
	var userId = '<s:property value="#session.FRONT_USER.id"/>';
	try{		
		ntkologinobj.ReadFromEkey();
		if(0!=ntkologinobj.StatusCode)
		{		
			return false;
		}
		else
		{
			var id = ntkologinobj.Username;
			//alert(id);
			if(id==userId){
				OBPM.dialog.doReturn("true");
			}else{
				alert('非法使用EKEY，此EKEY与本人资料不符，请联系管理员！');
			}
		}
	}
	catch(e)
	{
		alert("从EKEY读取用户登录信息错误："+e);
		return false;
	}
}

jQuery(document).ready(function(){
	if(navigator.userAgent.indexOf("MSIE")>0) {
		initLoginOcx();
	}
});
	
-->
</script>
</head>
<body class="contentBody">
<script src="ntkoGenEkeyLogOcxObj.js"></script>
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
		<td colspan="2"><div id="noteArea" style="display: none">{*[core.usbkey.tip.doflowNotice]*}</div></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><div id="tipsArea" style="color: red;">&nbsp;</div></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<div id="div_btn_verify">
		<input type="button" id="btn_verify" onclick="verify();" alt="{*[core.usbkey.ekey.btn.verify]*}" value="{*[core.usbkey.ekey.btn.verify]*}"/>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<hr></hr>
		<span style="color: red">{*[core.usbkey.ekey.verify.tip]*}</span>
		</td>
	</tr>
	</table>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
