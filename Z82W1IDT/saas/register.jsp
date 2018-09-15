<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>{*[page.km.register_title]*}</title>


<link type="text/css" rel="stylesheet" href="resource/css/register.css" />

<style type="text/css">
.content .reg-infoBox{width:480px}
.mobConfirm{}
.mobConfirm li{padding:8px 0 8px 80px; position:relative;zoom:1}
.mobConfirm li .tit{ position:absolute;left:0;top:12px;font-size:14px}
.mobConfirm li .btn,
.mobConfirm li .btn-disable{font-size:12px;}
.mobConfirm-mdf .ipt{width:222px}
.mobConfirm-mdf .btn,
.mobConfirm-mdf .btn-disable{width:192px; text-align:center}
</style>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="resource/script/jquery.placeholder.1.3.js"></script>

<script type="text/javascript" src="resource/script/qwrap.js"></script>
<script type="text/javascript">

function ev_onsubmit(){
	var domainname = document.getElementById("domainname");
	var loginemail = document.getElementById("loginemail");
	var mainPwdIpt = document.getElementById("mainPwdIpt");
	var mainCfmPwdIpt = document.getElementById("mainCfmPwdIpt");
	var mainAcceptIpt = document.getElementById("mainAcceptIpt");
	
	if(domainname.value=="")
	{
	    alert("{*[page.km.domain_not_null]*}");
	    return false;
	}
	if(loginemail.value=="")
	{
	    alert("{*[page.km.email_not_null]*}");
	    return false;
	}
	else
	{
	    reg=/^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/gi;
	    if(!reg.test(loginemail.value))
	    {
	        alert("{*[page.km.illegal_email]*}");
	        return false;
	    }
	}
	
	if(mainPwdIpt.value.length<6) {
		alert("{*[page.km.password_number]*}");
		return false;
	}
	else {
		if(mainPwdIpt.value != mainCfmPwdIpt.value) {
			alert("{*[page.km.password_error]*}");
			return false;
		}
	}
	
	if(!mainAcceptIpt.checked) {
		alert("{*[page.km.service_tip]*}");
		return false;
	}
	
	document.forms[0].submit();
	
	return true;
	
}
</script>

</head>
<body>

<form id="submitForm" name="submitForm" method=POST action="register.action">
<div id="msg" class="transparent_message">
	<s:if test="hasFieldErrors()">
		<div class="msgSub" msgType="error">
			<s:iterator value="fieldErrors">
				*<s:property value="value[0]" />&nbsp;&nbsp;
			</s:iterator>
		</div>
	</s:if>
</div>
<div class="content" id="mainSection">
	
<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
<div class="content-tit"><h1>{*[page.km.register_tip]*}</h1></div>
<div id="mMaskD" class="mainBody-wp">
	<div class="m-mask" style="display:none;"></div>
	<div class="mainBody">
		<div id="regMain" class="regForm">
			<div id="nameDl" class="regForm-item mainBody-hasFocus-focusArea">
				<div class="regForm-item-tit"><span class="txt-impt">*</span>{*[page.km.domain_name]*}</div>
				<div class="regForm-item-ct">
					<input id="domainname" name="domainname" type="text" class="ipt" style="ime-mode:disabled;font-weight:normal" autocomplete="off"/>
					<div id="nameTips" class="tips">
						<span class="txt-tips">{*[page.km.domain_name_tip]*}</span>
					</div>
				</div>
			</div>
			<div id="nameDl" class="regForm-item mainBody-hasFocus-focusArea">
				<div class="regForm-item-tit"><span class="txt-impt">*</span>{*[page.km.email]*}</div>
				<div class="regForm-item-ct">
					<input id="loginemail" name="loginemail" type="text" class="ipt" style="ime-mode:disabled;font-weight:normal" autocomplete="off"/><span class="txt-tips">（*{*[page.km.domain_account]*}）</span>
					<div id="nameTips" class="tips">
						<span class="txt-tips">{*[page.km.email_tip]*}</span>
					</div>
				</div>
			</div>
			<div id="mainPwdDl" class="regForm-item">
				<div class="regForm-item-tit"><span class="txt-impt">*</span>{*[page.km.password]*}</div>
				<div class="regForm-item-ct">
					<input id="mainPwdIpt" name="mainPassword" type="password" class="ipt norWidthIpt" style="ime-mode:disabled"/>
				</div>
			</div>
			<div id="mainCfmPwdDl" class="regForm-item">
				<div class="regForm-item-tit"><span class="txt-impt">*</span>{*[page.km.confirm_password]*}</div>
				<div class="regForm-item-ct">
					<input id="mainCfmPwdIpt" name="mainConfirmPassword" type="password" class="ipt norWidthIpt" style="ime-mode:disabled"/>
					<div id="mainCfmPwdTips" class="tips">
						<span class="txt-tips">{*[page.km.password_tip]*}</span>
					</div>
				</div>
			</div>
			<div id="mainAcceptDl" class="regForm-item">
				<div class="regForm-item-ct txt-tips">
					<label></label><input id="mainAcceptIpt" type="checkbox" checked="checked" tabindex="-1"/>{*[page.km.agree]*}<a href="agreement.html" target="_blank" tabindex="-1">"{*[page.km.terms_of_service]*}"</a>{*[page.km.detail]*}
					<div id="mainAcceptTips"></div>
				</div>
			</div>
			<div class="regForm-item">
				<div class="regForm-item-ct">
					<a id="mainRegA" href="javascript:void(0);" onclick="ev_onsubmit()" class="btnReg">{*[page.km.register]*}</a>
				</div>
			</div>
		</div>
	</div>
	<div class="mainBody-side">
		<div class="regExt">
			
			<img src="resource/img/reg_phone.gif" alt="客户服务">
			<div class="intro">
				<p>{*[page.km.service_tel]*}： <strong>800 678 0211</strong></p>
			</div>
			<div class="tips">
				{*[page.km.tel_tip_a]*}<br>{*[page.km.tel_tip_b]*}
			</div>
			
		</div>
	</div>
	<div class="clear"></div>
</div>
</div>
<div class="content" id="secondarySection" style="display:none"></div>
<div class="footer">
	<a tabindex="-1" href="http://www.teemlink.com" target="_blank">{*[page.km.about_teemlink]*}</a>&nbsp;&nbsp;<a tabindex="-1" href="http://www.teemlink.com/bbs/" target="_blank">{*[page.km.forum]*}</a>&nbsp;&nbsp;|&nbsp;&nbsp;{*[page.km.teemlink_tip]*}&nbsp;&copy;&nbsp;2013
</div>
<div id="maskDiv" class="g-mask" style="display:none;z-index: 199"></div>
</form>
</body>
</html>
</o:MultiLanguage>