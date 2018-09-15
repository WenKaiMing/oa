<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@page
	import="cn.myapps.core.deploy.module.action.ModuleHelper,cn.myapps.core.deploy.module.ejb.ModuleVO,cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>
<html><o:MultiLanguage>
<head>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" />
<s:bean name="cn.myapps.core.remoteserver.action.RemoteServerHelp" id="rsh" />
<title>{*[cn.myapps.core.deploy.module.module_info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script src="<s:url value='/core/deploy/module/calendar.js'/>"></script>
<script src="<s:url value='/core/deploy/module/popselect.js'/>"></script>
<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
<script>
	var cdr = new Calendar("cdr");
 	document.write(cdr);
 	cdr.showMoreDay = true;
 	
 	var sel = new PopSelect("sel");
 	document.write(sel);
</script>
<SCRIPT language="javascript">
var contextPath = "<s:url value='/'/>";

function selectFirstTime() {
		var firstTime = selectDate(formItem.elements['content.inuredate'].value);
		formItem.elements['content.inuredate'].value = firstTime;
	}

function ev_onload(){
	refreshApplicationTree("refreshid");
}

function on_commit(){
   var url = '<s:url action ="listelement"/>'+'?id='+document.getElementsByName('content.id')[0].value;
   var Attr = new Object();
   Attr = window.showModalDialog(url,Attr);
   if(Attr && Attr.iscommit) {
     document.forms[0].action = '<s:url action ="commit"/>';
     document.forms[0].submit();
   }
   
}

//去所有空格   
String.prototype.trimAll = function(){   
    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
};   

function checkName(s){
	var temp=document.getElementsByName('content.name')[0].value.trimAll();
	document.getElementsByName('content.name')[0].value = temp;
}

function checkOrderNumber(s){
	var temp=document.getElementsByName('content.m_orderno')[0].value.trimAll();
	document.getElementsByName('content.m_orderno')[0].value = temp;
}

function doSave(){
	if(document.getElementsByName('content.name')[0].value==""){
		alert("{*[page.name.notexist]*}");
	}else{
		var thisForm = document.getElementById("thisForm");
		thisForm.action='<s:url action="save"></s:url>';
		thisForm.submit();
	}
}
OBPM(document).ready(function(){
	ev_onload();
	init_SuperiorList();
	window.top.toThisHelpPage("application_module_info");
});

//初始化上级模块选项
function init_SuperiorList(){
	var appid = '<s:property value="#parameters.application" />';
	var currentModuleid = '<s:property value="content.id" />';
	var superiorid = '<s:property value="content.superior.id" />';
	var selId = jQuery("#superiorList").attr("id");
	ModuleHelper.getModuleSelected(appid, currentModuleid, function(options){
		init_Option(selId, superiorid, options);
	});
}

function init_Option(selId, defVal, options){
	DWRUtil.removeAllOptions(selId);
	DWRUtil.addOptions(selId, options);
	DWRUtil.setValue(selId, defVal);
}

</SCRIPT>
</head>
<body id="application_module_info" class="contentBody">
<s:form action="save" method="post" theme="simple" name="thisForm" id="thisForm">
	<table class="table_noborder" style="width: 100%;">
		<tr>
			<td class="nav-s-td contentTitle">{*[Module]*}</td>
			<td class="nav-s-td" align="right">
			<table align="right" width="60" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" valign="top">
					<button type="button" class="button-image"
						onClick="doSave()"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
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
	<div id="contentMainDiv" class="contentMainDiv" style="padding-top: 10px;">
		<table class="table_noborder id1">
				<s:hidden name="content.id" />
				<s:hidden name="content.sortId" />
				<s:hidden name="application" />
				<s:hidden id="refreshid" name="refresh" value="%{#parameters.refresh}"/>
				<tr>
					<td class="commFont">{*[cn.myapps.core.deploy.module.module_name]*}:</td>
					<td class="commFont">{*[cn.myapps.core.deploy.module.superior_module]*}:</td>
				</tr>
				<tr>
					<td align="left"><s:textfield size="50" cssClass="input-cmd" label="{*[Name]*}" name="content.name" theme="simple" onblur="checkName(this.value)"/></td>
					<td align="left"><s:select cssClass="input-cmd" theme="simple"
						name="_superiorid" list="{}" id="superiorList" /></td>
				</tr>
				<tr>
					<td class="commFont">{*[cn.myapps.core.deploy.module.module_description]*}:</td>
					<td class="comFont">{*[cn.myapps.core.deploy.module.module_ordernumber]*}</td>
					<td></td>
				</tr>
				<tr>
					<td align="left"><s:textarea cols="50" rows="6" cssClass="input-cmd" theme="simple" name="content.description" /></td>
					<td align="left" valign="top"><s:textfield size="50" cssClass="input-cmd" label="{*[OrderNumber]*}" name="content.orderno" theme="simple" onblur="checkOrderNumber(this.value)"/></td>
				</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
