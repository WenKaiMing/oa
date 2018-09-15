<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="java.util.*"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Role]*}{*[Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
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
		// 写死type参数测试
		var url = contextPath + '/core/permission/list.action?roleid=<s:property value="content.id" />&type=0&applicationid='+applicationid+'&pageNo=1&date='+myDate;
		wy = '200px';
		wx = '200px';
		OBPM.dialog.show({
				opener:window.parent,
				width: 1000,
				height: 520,
				url: url,
				args: {},
				title: '{*[Configuration]*}{*[Resources]*}',
				close: function(rtn) {
				}
		});
	}
</script>

<body id="application_info_generalTools_role_info" class="contentBody">
<s:form action="save" method="post" theme="simple">
	<table cellpadding="0" cellspacing="0" width="100%" style="border-bottom: 1px solid;">
		<tr>
			<td valign="top" align="right">
				<s:if test="content.id!=null">
					<button type="button" class="button-image" onClick="configureResources()"><img
					src="<s:url value="/resource/imgnew/act/plugin.png"/>" border=0>{*[Resources]*}{*[Authorize]*}</button>
				</s:if>
				<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="saveAndNew"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
				<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
			</td>
		</tr>
	</table>
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
	<table class="table_noborder id1">
		<s:hidden name="tab" value="1" />
		<s:hidden name="selected" value="%{'btnRole'}" />
			<tr>
				<td class="commFont" align="left">{*[Name]*}:</td>
			</tr>
			<tr>
				<td><!-- ww:textfield cssClass="input-cmd" onblur="checkSpace(this)" label="{*[Name]*}" name="content.name"  /> -->
				<s:textfield cssClass="input-cmd" onblur="checkSpace(this)"
					label="{*[Name]*}" name="content.name" /></td>
					
			</tr>
		<s:hidden name="content.applicationid"	value="%{#parameters.application}" />
	</table>
	<s:if test="content.id!=null&&content.id.trim().length()>0">
		<iframe scrolling="no" id="frame" name="Frame" border="0"
			src="<s:url value='/portal/user/listRole.action'/>?sm_userRoleSets.roleId=<s:property value="content.id" />"
			width="100%" frameborder="0" /></iframe>
	</s:if>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
