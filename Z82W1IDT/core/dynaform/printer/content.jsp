<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.dynaform.printer.info]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style>
body {
        margin-left: 0px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
}
html,body,#DynamicPrinter{
margin:0px;
padding:0px;
width:100%;
height:100%;
overflow:hidden;
}
</style>
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
<script type="text/javascript">

var isFlashLoad = false;

function bodyLoad(){
	document.getElementById('context').style.height = document.body.offsetHeight-35 +"px";
}
function ev_switchpage(sId) {
	document.getElementById('span_tab1').className="btcaption";
	document.getElementById('span_tab2').className="btcaption";
	document.getElementById('1').style.display="none";
	var isChrome = navigator.userAgent.indexOf("Chrome")>0 ? true:(navigator.userAgent.indexOf("Firefox")>0 ? true:false);
	if(isChrome){
		if(sId == "1"){
			jQuery("#context").height(0);
		}else{
			jQuery("#context").height(document.body.offsetHeight-35);
		}
	}else{
		document.getElementById('2').style.display="none";
	}
	if (jQuery("#"+ sId)) {
		document.getElementById('span_tab'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
	}
	mode = sId;
}

function clearXML(){
	var tempFormid = document.getElementsByName("content.relatedForm")[0].value;
	var aa= window.confirm("{*[cn.myapps.core.dynaform.printer.switch_form]*},{*[cn.myapps.core.dynaform.printer.content_clear]*},{*[cn.myapps.core.dynaform.printer.goon_or_not]*}?");
	if (aa){
		document.getElementsByName("content.template")[0].value = "";
		/*document.DynamicPrinter.clearAllChild();  */
		if(isFlashLoad){
			document.DynamicPrinter.onload();
		}
	}else{
		
	}
}

function doGetHeight(){
	return jQuery(document).height();
}

function ev_save() {
	var printer;
	if (navigator.appName.indexOf("Microsoft") != -1) {
		 printer = document.getElementById("DynamicPrinter");
	}else{
		 printer = document.getElementsByName('DynamicPrinter')[0];
	}
	if (printer && isFlashLoad){
		var xmlContent = printer.doSynTemplate();
		document.getElementsByName("content.template")[0].value = xmlContent;
	}
	
	var temp = document.getElementById('content.template').value;
	if(temp == ''){
		showMessage("error", '{*[page.content.notexist]*}');
		return false;
	}
	var url ='<s:url value="/core/dynaform/printer/save.action"/>';
	document.forms[0].action = url;
	document.forms[0].submit();
}

function flashLoad(){
	isFlashLoad = true;
}

function flexSave(strxml){
	document.getElementsByName("content.template")[0].value = strxml;
	return "{*[Save_Success]*}";
}

function flexGetTemplate(){
	var template = document.getElementsByName("content.template")[0].value;
	return template;
}

function doGetFormid(){
	return document.getElementsByName("content.relatedForm")[0].value;
}

function doCfgPrint(){
	var formid =document.getElementsByName("content.relatedForm")[0].value;
	var url = '<s:url value="/core/dynaform/printer/dynaprinter.jsp"/>';
	url += '?formid='+formid;
	window.showModalDialog(url,'newwindow','dialogHeight:600px', 'dialogWidth:900px');
}

jQuery(document).ready(function(){
	bodyLoad();
	window.top.toThisHelpPage("application_module_print_info");
});


/* 签入
*/
function ev_checkin(){
	var printer = document.getElementById('DynamicPrinter');
	if (printer && isFlashLoad){
		var xmlContent = printer.doSynTemplate();
	}
	document.forms[0].action='<s:url action="checkin"></s:url>';
	document.forms[0].submit();
}
/*
* 签出
*/
function ev_checkout(){
	var printer = document.getElementById('DynamicPrinter');
	if (printer && isFlashLoad){
		var xmlContent = printer.doSynTemplate();
	}
	document.forms[0].action='<s:url action="checkout"></s:url>';
	document.forms[0].submit();
}
</script>
</head>
<body id="application_module_print_info" class="contentBody">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
		<td class="nav-s-td">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left: 10px;">
					<div id="sec_tab1">
					<div class="listContent"><input type="button" id="span_tab1"
						name="spantab1" class="btcaption" onClick="ev_switchpage('1')"
						value="{*[Basic]*}" /></div>
					<div class="listContent nav-seperate"><img
						src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
					</div>
					<div class="listContent"><input type="button" id="span_tab2"
						name="spantab2" class="btcaption" onclick="ev_switchpage('2')"
						value="{*[Content]*}" /></div>
					</div>
					</td>
				</tr>
			</table>
			</td>
			<td class="nav-s-td" align="right">
			<table width="150" border=0 cellpadding="0" cellspacing="0">
				<tr>
				<s:if test="checkoutConfig == 'true'">
				  <s:if test="content.id !=null && content.id !='' && !content.checkout">
					<!-- 签出按钮 -->
					<td align="left">
						<button type="button" class="button-image" style="width:50px" onClick="ev_checkout()"><img
							src="<s:url value="/resource/imgnew/act/checkout.png" />"
							align="top">{*[core.dynaform.form.checkout]*}</button>
						</td>
					</s:if>
					<s:elseif test="content.id !=null && content.id !='' && content.checkout && #session['USER'].id == content.checkoutHandler">
					<!-- 签入按钮 -->
					<td align="left">
						<button type="button" class="button-image" style="width:50px" onClick="ev_checkin()"><img
							src="<s:url value="/resource/imgnew/act/checkin.png" />"
							align="top">{*[core.dynaform.form.checkin]*}</button>
						</td>
					</s:elseif>
					</s:if>
					<td valign="top" style="display: none">
					<button type="button" class="button-image" onClick="ev_preview()"><img
						src='<s:url value="/resource/imgnew/act/preview.gif" />'>{*[Preview]*}</button>
					</td>
					<s:if test="checkoutConfig == 'true'">
						<s:if test="(content.checkout && #session['USER'].id == content.checkoutHandler)  || (!content.checkout && content.checkoutHandler ==null) ">
						<!-- 签出 -->
						<td align="left">
							<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="ev_save()">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
								align="top">{*[Save]*}</button>
							</td>
						</s:if>
						<s:elseif test="content.checkout && #session['USER'].id != content.checkoutHandler">
						<!-- 签入-->
						<td align="left">
							<button type="button" id="save_btn" style="width:50px" class="button-image" disabled="disabled" onClick="ev_save()">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
								align="top">{*[Save]*}</button>
							</td>
						</s:elseif>
						<s:if test="!content.checkout && (content.checkoutHandler == '') ">
							<!-- 没有签出-->
							<td align="left">
								<button type="button" id="save_btn" style="width:50px" class="button-image"  onClick="alert('{*[message.update.before.checkout]*}')">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
						</s:if>
						</s:if>
						<s:else>
							<td align="left">
							<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="ev_save()">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
							align="top">{*[Save]*}</button>
							</td>
						</s:else>
					<td>
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div style="width: 100%;" id="clientdiv" class="contentMainDiv">
		<s:form name="dynaprinter"	action="save" theme="simple" method="post">
		<%@include file="/common/page.jsp"%>
		<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
		<input type="hidden" name="s_module"
			value="<s:property value='#parameters.s_module'/>" />
		<input type="hidden" name="_moduleid"
			value="<s:property value='#parameters.s_module'/>" />
		<s:hidden name='content.checkout' />
		<s:hidden name="content.checkoutHandler" />
		<table width="100%">
			<tr id="1">
				<td>
				<table cellpadding="0" cellspacing="0" width="100%" class="id1">
					<tr>
						<td class="commFont">{*[Name]*}:</td>
						<td class="commFont">{*[Description]*}:</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.name" /></td>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.description" maxlength="255"/></td>
					</tr>
					<tr class="seperate">
						<td class="commFont">{*[cn.myapps.core.dynaform.printer.relative_form]*}:</td>
						<td style="display: none" class="commFont">打印定制:   <button type="button" class="button-class" onClick="doCfgPrint()">
							<img src="<s:url value="/resource/imgnew/act/act_7.gif"/>">配置打印</button></td>
					</tr>
					<tr>
						<td><s:select name="content.relatedForm"
							list="#fh.get_normalFormList(#parameters.application)"
							listKey="id" id="relatedForm" listValue="name" theme="simple"
							cssClass="input-cmd" onchange="clearXML()"/></td>
						<td>
						<s:textarea name="content.template" id="content.template"
							cssClass="input-cmd" theme="simple" 
							  cssStyle="display: none" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			
			
			<tr id="2" style="display: none">
				<td >
       
         	 <div id="context" style="width:100%;">
	         	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				id="DynamicPrinter" width="100%" height="100%"
				codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
				<param name="movie" value="../../common/flash/DynamicPrinter.swf" />
				<param name="quality" value="high" />
				<param name="wmode" value="opaque">
				<param name="bgcolor" value="#869ca7" />
				<param name="allowScriptAccess" value="sameDomain" />
				<embed src="../../common/flash/DynamicPrinter.swf" quality="high" bgcolor="#869ca7"
					width="100%" height="100%" name="DynamicPrinter" align="middle" wmode="opaque"
					play="true"
					loop="false"
					quality="high"
					allowScriptAccess="sameDomain"
					type="application/x-shockwave-flash"
					pluginspage="http://www.adobe.com/go/getflashplayer">
				</embed>
				</object>
         	 </div>
			</td>
			</tr>
			</table>
			</s:form>
			</div>
</body>
</o:MultiLanguage>
</html>