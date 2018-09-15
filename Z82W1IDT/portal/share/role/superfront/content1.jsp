<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="java.util.*"%>
<html><o:MultiLanguage>
<head>
<title>{*[Role]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
<script>
</script>	
</head>
<script>
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading...]*}';

function checkSpace(obj) {
	var regex = /[^\w\u4e00-\u9fa5^(^)^（^）]/g;
	obj.value = obj.value.replace(regex, '');
}

//配置资源
function configureResources(){
	var myDate=new Date().toString();
	var applicationid = document.getElementsByName("content.applicationid")[0].value;
	var url = contextPath + '/core/permission/list.action?roleid=<s:property value="content.id" />&application='+applicationid+'&applicationid='+applicationid+'&pageNo=1&date='+myDate;
	wy = '200px';
	wx = '200px';
	var value= window.showModalDialog(contextPath + '/portal/share/frame.jsp?title={*[Configuration]*}{*[Resources]*}',
			url, 'font-size:9pt;dialogWidth:' + 950 + 'px;dialogHeight:'
			+ 600 + 'px;status:no;scroll=no;resizable=yes;');
}

function doExit() {
	OBPM.dialog.doReturn();
}

jQuery(document).ready(function(){
	if(window.top.document.getElementById("helper")){
		window.top.toThisHelpPage("application_info_generalTools_role_info");
	}
});
</script>
<body id="application_info_generalTools_role_info" style="margin: 0;padding: 0;">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td class="nav-s-td" align="right">
			<table width="150" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="saveAndNewRole"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="saveRole"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					<button type="button" class="button-image" onClick="doExit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<%@include file="/portal/share/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<s:form action="saveRole" method="post" theme="simple"> 
		<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">	
			<tr><td class="commFont" align="left" >{*[Name]*}:</td></tr>
			<tr><td>
			<!-- ww:textfield cssClass="input-cmd" onblur="checkSpace(this)" label="{*[Name]*}" name="content.name"  /> -->
			<s:textfield cssClass="input-cmd" onblur="checkSpace(this)" label="{*[Name]*}" name="content.name" />
			</td></tr>
		</table>	
		<s:hidden name="content.applicationid" value="%{#parameters.application}" />	
		</s:form>
		</td>
	</tr>
</table>

</body>

</o:MultiLanguage></html>
