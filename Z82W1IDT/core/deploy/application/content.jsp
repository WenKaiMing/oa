<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<% 
WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
String username = user.getName();
boolean isSuperAdmin = user.isSuperAdmin();
String contextPath = request.getContextPath();
%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="fh" />
<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.deploy.application.application_information]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">

<SCRIPT language="javascript">

var application = '<s:property value="%{#parameters.id}"/>';
if(application == null || application == ''){
	application = '<s:property value="content.id" />';
}
var module = '<s:property value="%{#parameters.s_module}"/>';
function ev_onload(){
	if ('<s:property value="#parameters.refresh"/>'=='true') {
		parent.parent.frames['navigator'].location.href="<s:url value='/core/deploy/application/appnavigator.jsp'/>";
	}
	var dbname = '<s:property value="_dtsname"/>';
	if(dbname != null){
		document.getElementById("dataSource_Value").value=dbname;
	}
}

//应用的信息退出回前一个页面(即软件列表)
function ev_exist(){
	//var page = '?_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>';
	var app_name = '<s:property value="content.name" />';
	if(application == null || application == ''){
		document.forms[0].action='<s:url action="list-apps"/>';
		document.forms[0].submit();
	} else {
		if(parent && parent.name != null && parent.name != ''){
			parent.document.forms[0].action='<s:url action="list-apps"/>';
			parent.document.forms[0].submit();
		} else {
			document.forms[0].action='<s:url action="list-apps"/>';
			document.forms[0].submit();
		}
	}
}

//生成概览,2.6版本新增
function doOverview(){
	var form = document.forms[0];
	form.action = '<s:url action="createOverview"/>';
	form.submit();
}

//同步表单的数据表
function doSynFormTable(){
	document.forms[0].action = '<s:url value="/core/deploy/application/synFormTable.action"></s:url>';
	document.forms[0].submit();
}

function doSave(){
	var form = document.forms[0];
	form.action = '<s:url action="update"/>';
	form.submit();
}

function attechmentupload(excelpath){
	 var rtr = uploadFile(excelpath,'logourl','','','','','',applicationid);
	 if(rtr) {
		if (rtr.indexOf("_") < 0)
	   		formItem.elements['content.logourl'].value = rtr;
		else
			formItem.elements['content.logourl'].value = rtr.substring(0,rtr.indexOf("_"));
	 } else if (rtr == '') {
	 	formItem.elements['content.logourl'].value = rtr;
	 }
}

function attechmentupload2(excelpath){
	 var rtr = uploadFile(excelpath,'videodemo','','','','','',applicationid);
	 if(rtr) {
		 if (rtr.indexOf("_") < 0)
			 formItem.elements['content.videodemo'].value = rtr;
		 else
	   		formItem.elements['content.videodemo'].value = rtr.substring(0,rtr.indexOf("_"));
	 } else if (rtr == '') {
	 	formItem.elements['content.videodemo'].value = rtr;
	 }
}

function submit(){
	document.forms[0].action='<s:url value="/core/deploy/application/addupdate.action"></s:url>';
	document.forms[0].submit();
}
//去两边空格   
String.prototype.trim = function(){   
    return this.replace(/(^\s*)|(\s*$)/g, "");   
};   
function PeripheralTrim(){
    var tmp = document.getElementById("content.name").value.trim();   
    document.getElementById("content.name").value = tmp;   
}   

function isInteger(obj){
    var tmp = obj.value.trim();
    if(tmp == "" || isNaN(tmp) || tmp < 0 || !(/^\d+$/.test(tmp))){
    	alert("请输入一个整数。");
    	tmp = "0";
    }
    obj.value = tmp;
}   

jQuery(document).ready(function(){
	if (window.parent.document.getElementById("dtree")) {
		parent.init_ModuleTree();
	}
	
	var orderId = document.getElementById("content.orderId").value;   
	if(orderId == ""){
		document.getElementById("content.orderId").value = "0";
	}
	
	ev_onload();
	var appname='<s:property value="content.name" />';
	var appdescription='<s:property value="content.description" />';
	var appdatasourceid='<s:property value="content.content.datasourceid" />';
	if(appname!="" && appdescription!=""){
		window.top.toThisHelpPage("application_info");
	}else{
		window.top.toThisHelpPage("application_new");
	}
	
});

//选择数据源
function selectDataSource(){
  	var url =  contextPath + "/core/dynaform/dts/datasource/listAllDts.action?s_applicationid=" + 
	application  + "&application=" + application;
	OBPM.dialog.show({
			opener:window.parent,
			width: 800,
			height: 600,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.deploy.application.select_dataSource]*}',
			close: function(dataSource) {
				window.top.toThisHelpPage("application_info");
				if(dataSource){
					if (dataSource.id == '') {
						document.getElementById("dataSourceId").value='';
						document.getElementById("dataSource_Value").value='';
					}else{
					    document.getElementById("dataSourceId").value = dataSource.id;
					    document.getElementById("dataSource_Value").value =dataSource.name;
					}				
				}
			}
	});
}
</SCRIPT>

</head>
<body id="application_info" class="contentBody" >
<s:form action="update" theme="simple" method="post" name="formItem">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_description" value="%{#parameters.sm_description}"/>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr class="nav-td" style="height:27px;">
			<s:if test='_appName != null && _appName != ""'>
				<td rowspan="3" width="100%"><div><%@include file="/common/commontab.jsp"%></div></td>
			</s:if>
			<s:if test='_appName == null || _appName == ""'>
				<td class="nav-td" width="100%">&nbsp;</td>
			</s:if>
				<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td" >
			<s:if test='_appName == null || _appName == ""'>
				<td  class="nav-s-td" style="padding-left: 10px;"><div style="height: 100%;"></div></td>
			</s:if>
			<td class="nav-s-td" align="right">
				<table class="table_noborder" width="100%">
					<tr><td>
						<div style="text-align: right; width:330px;height:24px;">
							<img align="left" style="height:24px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" style="float:left;width:100px;" id="synFT_btn" title="{*[cn.myapps.core.deploy.application.synchronization_table_date]*}" class="button-image" onclick="doSynFormTable();" >
							<span style="display: block;width:100%;white-space: nowrap;overflow: hidden;text-overflow:ellipsis;">
							<img src="<s:url value="/resource/imgnew/act/reset.gif" />" align="top">
							{*[cn.myapps.core.deploy.application.synchronization_data_table]*}</span></button>
						<button type="button" id="exp_btn" style="float:left;width:80;" class="button-image" title="{*[cn.myapps.core.deploy.application.create_overview]*}" onClick="doOverview();">
							<span style="display: block;width:100%;white-space: nowrap;overflow: hidden;text-overflow:ellipsis;">
							<img src="<s:url value="/resource/imgnew/act/act_11.gif"/>" align="top">
							{*[cn.myapps.core.deploy.application.create_overview]*}</span></button>
						<button type="button" style="float:left;width:60px"  id="save_btn" title="{*[Save]*}" class="button-image" onClick="doSave()">
							<img border="0" src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top">
							{*[Save]*}</button>
						<button type="button" style="float:left;width:60px" class="button-image" title="{*[Exit]*}" onClick="ev_exist()">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>" align="top">
							{*[Exit]*}</button>
						</div>
					</td></tr>
				</table>
			</td>
	</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
	<div class="navigation_title" >{*[cn.myapps.core.deploy.application.basic_info]*}</div>
		<table class="table_noborder id1">
				<s:hidden name='mode' value="%{#parameters.mode}" />
				<s:hidden name="id" value="%{#parameters.id}" />
				<tr>
					<td class="commFont">{*[cn.myapps.core.deploy.application.application_name]*}:</td>
					<td class="commFont">{*[Type]*}:</td>
				</tr>
				<tr>
				  	<td align="left"><s:textfield  cssClass="input-cmd" theme="simple" name="content.name" id="content.name" onblur="PeripheralTrim()"/></td>
				  	<td align="left"><s:select cssClass="input-cmd" theme="simple" name="_type"  list="#fh.getApplicationType()" /></td>
			    </tr>
				<tr class="seperate">
			      	<td class="commFont" align="left">{*[DataSource]*}:</td>
			      	<td class="commFont"   >{*[Description]*}:</td>
			    </tr>
			    <tr>
					<td style="word-break:break-all;width:50%;">
						<s:hidden id="dataSourceId" name="content.datasourceid"/>
						<input class="input-cmd" type="text" id="dataSource_Value" readonly value=""  style="width:230px;" />
						<input class="button-cmd" onClick="selectDataSource()" type="button" value="{*[Choose]*}" />
					</td>
					<td colspan="2" align="left" style="width:50%"><s:textarea cssClass="input-cmd"  cols="50" rows="2"
						 theme="simple" name="content.description" />
					</td>
				</tr>
				<tr class="seperate">
			      	<td class="commFont" align="left">{*[OrderNumber]*}:</td>
			    </tr>
				<tr class="seperate">
				  	<td align="left"><s:textfield cssClass="input-cmd" theme="simple" name="content.orderId" id="content.orderId" onblur="isInteger(this)"/></td>
			    </tr>
				<tr class="seperate">
			      	<td class="commFont" align="left">{*[cn.myapps.core.deploy.application.label.state]*}:</td>
			      	<td class="commFont" align="left"></td>
			    </tr>
			    <tr>
					<td colspan="2" align="left">
						<s:radio list="#{'true':'{*[core.workflow.storage.runtime.proxy.activation]*}','false':'{*[core.workflow.storage.runtime.proxy.disable]*}'}" name="content.activated" value="content.activated.toString()" theme="simple"/>
					</td>
					<td >
					</td>
				</tr>
				<!-- 软件的图标 -->
				<tr style="display: none;">
					<td class="commFont">{*[cn.myapps.core.deploy.application.application_logo]*}:</td>
					<td class="commFont" align="left"></td>
				</tr>
				<tr style="display: none;">
					<td align="left" width="50%">
						<s:textfield id="videodemo" name="content.logourl"  cssStyle="width:328px;" readonly="true" theme="simple"/>
		      	       <button type="button" name='logoUrl' class="button-image" onClick="attechmentupload('EXCELTEMPLATE_PATH')">
		      	       <img src="<s:url value="/resource/image/search.gif"/>"></button>
					</td>
				</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
