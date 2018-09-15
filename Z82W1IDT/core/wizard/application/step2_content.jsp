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
<title>{*[Application_Information]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">

<SCRIPT language="javascript">

var application = '<s:property value="%{#parameters.id}"/>';
if(application == null || application == ''){
	application = '<s:property value="content.id" />';
}
var module = '<s:property value="%{#parameters.s_module}"/>';
function ev_onload(){
	if ('<s:property value="#parameters.refresh"/>'=='true') {
		parent.parent.frames['navigator'].location.href="<s:url value='/core/deploy/application/appnavigator.jsp'/>" 
	}
	var dbname = '<s:property value="_dtsname"/>';
	if(dbname != null){
		document.getElementById("dataSource_Value").value=dbname;
	}
}

function doExit() {
	window.location = '<%=contextPath%>/admin/detail.jsp';
}

//同步表单的数据表
function doSynFormTable(){
	document.forms[0].action = '<s:url value="/core/deploy/application/synFormTable.action"></s:url>';
	document.forms[0].submit();
}

function attechmentupload(excelpath){
	 var rtr = uploadFile(excelpath,'logourl','','','','','',application);
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
	 var rtr = uploadFile(excelpath,'videodemo','','','','','',application);
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

jQuery(document).ready(function(){
	if (window.parent.document.getElementById("dtree")) {
		parent.init_ModuleTree();
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
			width: 900,
			height: 500,
			url: url,
			args: {},
			title: '{*[Select]*}{*[DataSource]*}',
			close: function(dataSource) {
				if (dataSource.id == '') {
					document.getElementById("dataSourceId").value='';
					document.getElementById("dataSource_Value").value='';
				}else{
				    document.getElementById("dataSourceId").value = dataSource.id;
				    document.getElementById("dataSource_Value").value =dataSource.name;
				}
			}
	});
}

</SCRIPT>

</head>
<body id="application_info" class="contentBody">
<s:form action="step2_save" theme="simple" method="post" name="formItem">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<!-- 当应用的名称不为空时,显示切换栏 -->
		<tr class="nav-td" style="height:27px;">
			<s:if test='_appName != null && _appName != ""'>
				<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			</s:if>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td  class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td class="contentTitle">
						<s:if test='_appName == null || _appName == ""'>
							<input type="button" name="btn" class="btcaption" value="{*[Information]*}" />
						</s:if>
					</td>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" style="width:118px" id="synFT_btn" title="{*[Synchronization]*}{*[Form]*}{*[Data]*}{*[table]*}" class="button-image" onclick="doSynFormTable();" >
							<img src="<s:url value="/resource/imgnew/act/reset.gif" />" align="top">
							{*[Synchronization]*}{*[Form]*}{*[Data]*}{*[table]*}</button>
						<button type="button" style="width:50px"  id="save_btn" title="{*[Save]*}" class="button-image" onClick="forms[0].submit();">
						<img border="0" src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
						</button>
						<button type="button" style="width:50px" class="button-image" title="{*[Exit]*}" onClick="doExit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
						</button>
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
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">
				<s:hidden name='mode' value="%{#parameters.mode}" />
				<s:hidden name="id" value="%{#parameters.id}" />
				<tr>
					<td class="commFont">{*[Application]*}{*[Name]*}:</td>
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
					<td style="word-break:break-all;">
						<s:hidden id="dataSourceId" name="content.datasourceid"/>
						<input class="input-cmd" type="text" id="dataSource_Value" readonly value=""  style="width:230px;" />
						<input class="button-cmd" onClick="selectDataSource('dataSource_Value','false')" type="button" value="{*[Choose]*}" />
					</td>
					<td colspan="2" align="left"><s:textarea cssClass="input-cmd"  cols="50" rows="2"
						 theme="simple" name="content.description" />
					</td>
				</tr>
				<!-- 软件的图标 -->
				<tr style="display: none;">
					<td class="commFont">{*[Application]*}{*[LogoUrl]*}:</td>
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
