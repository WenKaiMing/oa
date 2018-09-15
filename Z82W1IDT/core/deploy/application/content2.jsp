<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String username = user.getName();
	boolean isSuperAdmin = user.isSuperAdmin();
%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[App]*}</title>
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>'
		type="text/css">
<SCRIPT language="javascript">
var application = '<s:property value="%{#parameters.id}"/>';
if(application == null || application == ''){
	application = '<s:property value="content.id" />';
}
function submit()
{ 
	document.forms[0].action = document.forms[0].action + "?refresh=true";
	document.forms[0].submit();
}
//应用的信息退出回前一个页面(即软件列表)
function ev_exist(){
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
function ev_onload()
{
	if ('<s:property value="#parameters.refresh"/>'=='true') {
		parent.parent.frames['navigator'].location.href="<s:url value='/core/deploy/application/appnavigator.jsp'/>" 
	}
	var dbname = '<s:property value="_dtsname"/>';
	if(dbname != null){
		document.getElementById("dataSource_Value").value=dbname;
	}
}

function IsDigit(){
	return ((event.keyCode>=48)&&(event.keyCode<=57));
}
//去两边空格   
String.prototype.trim = function(){   
    return this.replace(/(^\s*)|(\s*$)/g, "");   
};   
function PeripheralTrim(){   
    var tmp = document.getElementById("content.name").value.trim();   
    document.getElementById("content.name").value = tmp;   
}
function attechmentupload(excelpath){
	 var rtr = uploadFile(excelpath,'logourl','','','','','',application);
	 if(rtr!=null&&rtr!='') {
		if (rtr.indexOf("_") < 0)
	   		formItem.elements['content.logourl'].value = rtr;
		else
			formItem.elements['content.logourl'].value = rtr.substring(0,rtr.indexOf("_"));
	 }
}

function attechmentupload2(excelpath){
	 var rtr = uploadFile(excelpath,'videodemo','','','','','',applicationid);
	 if(rtr!=null&&rtr!='') {
		 if (rtr.indexOf("_") < 0)
			 formItem.elements['content.videodemo'].value = rtr;
		 else
	   		formItem.elements['content.videodemo'].value = rtr.substring(0,rtr.indexOf("_"));
	 }
}
//选择数据源
function selectDataSource(){
	wx = '1000px';
  	wy = '500px';
  	var url =  contextPath + "/core/dynaform/dts/datasource/listAllDts.action?s_applicationid=" + 
	application  + "&application=" + application;
	var rtn = showframe('{*[DataSource]*}', url);
	if (rtn != null) {
		if (rtn == '') {
			document.getElementById("dataSourceId").value='';
		  	document.getElementById("dataSource_Value").value='';
	  	}else{
	    	var t = rtn.split(";");
	    	document.getElementById("dataSourceId").value = t[0];
	    	document.getElementById("dataSource_Value").value = t[1];
	  	}
	}
}
</SCRIPT>
	</head>
	<body style="margin: 0px;" onLoad="ev_onload()">
	<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper"
		id="fh" />
	<table width="100%">
		<tr>
			<td width="10" style="padding-left: 11px;" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3">&nbsp;</td>
			<td width="200" class="text-label">{*[cn.myapps.core.deploy.application.application_information]*}</td>
			<td>
			<table width="100%" border="0" >
				<tr>
					<td>&nbsp;</td>
					<td width="60" valign="top">
					<button type="button" id="save_btn" title="{*[Save]*}" class="button-image"
						onClick="forms[0].submit()"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
					</button>
					</td>
					<s:if test="_appName != null && _appName != ''">
					   <td class="line-position2"  width="70" valign="top" >
					   <button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="copy"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_21.gif"/>">{*[Copy]*}</button>
 					   </td>
					</s:if>
					<td class="line-position2" valign="top">
						<button type="button" class="button-image" onClick="ev_exist();">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[cn.myapps.core.deploy.application.back_to_application_list]*}
						</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td colspan="4"
				style="border-top: 1px solid dotted; border-color: black;">&nbsp;
			</td>
		</tr>
	</table>

	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentTable" style="padding-left: 10px;">
	<table class="table_noborder id1">
		<s:form action="copysave" theme="simple" method="post" name="formItem">
			<%@include file="/common/page.jsp"%>
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
				<td style="word-break:break-all;">
					<s:hidden id="dataSourceId" name="content.datasourceid"/>
					<input class="input-cmd" type="text" id="dataSource_Value" readonly value=""  style="width:303px;" />
					<input class="button-cmd" onClick="selectDataSource()" type="button" value="{*[Choose]*}" />
				</td>
				<td colspan="2" align="left"><s:textarea cssClass="input-cmd"  cols="50" rows="2"
					 theme="simple" name="content.description" />
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
		</s:form>
	</table>
	</div>
	</body>
</o:MultiLanguage>
</html>
