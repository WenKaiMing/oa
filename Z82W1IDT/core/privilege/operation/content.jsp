<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Resources]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script type="text/javascript" src="<s:url value='/script/privilege/resources/resources.js'/>"></script>
</head>
<script>
var contextPath='<%= request.getContextPath() %>';
	function ev_onload() {
		inittab();
		
	}

	function checkSpace(obj) {
		var regex = /[^\w\u4e00-\u9fa5^(^)^（^）]/g;
		obj.value = obj.value.replace(regex, '');
	}

	
	jQuery(document).ready(function(){
		ev_onload();
		window.top.toThisHelpPage("application_info_generalTools_operation_info");
	});
</script>
<body id="application_info_generalTools_operation_info" class="contentBody">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
							src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<div id="contentMainDiv" class="contentMainDiv">
	<s:form action="save" method="post" theme="simple">
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnOperation'}" />
	<s:hidden name="content.applicationid" value="%{#parameters.application}" />
	<%@include file="/common/page.jsp"%>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table class="id1" width="50%">
		<tr>
			<td class="commFont" align="left" >{*[Name]*}:</td>
			<td>
				{*[<s:property value="content.name" />]*}
			</td>
		</tr>
		<tr>
			<td class="commFont" align="left" >{*[Resource]*}{*[Type]*}:</td>
			<td>
				<s:if test="content.resType==0">{*[View]*}</s:if>
					<s:elseif test="content.resType==1">{*[Form]*}</s:elseif>
					<s:elseif test="content.resType==2">{*[menu]*}</s:elseif>
					<s:elseif test="content.resType==3">{*[FormField]*}</s:elseif>
					<s:elseif test="content.resType==4">{*[Folder]*}</s:elseif>
			</td>
		</tr>
		<tr>
			<td class="commFont" align="left" >{*[Code]*}:</td>
			<td>
				<s:property value="content.code" />
			</td>
		</tr>
	</table>	
	</s:form>
</div>
</body>

</o:MultiLanguage></html>
