<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<head>
<title>{*[Workflows]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script type="text/javascript">
function doSelect(result){
	OBPM.dialog.doReturn(result);
}
</script>
</head>
<body class="body-back" style="overflow: auto;">
<s:form name="formList" action="selectsubform" method="post" theme="simple">
<%@include file="/common/list.jsp"%>	
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">

<table class="table_noborder">
	<tr>
		<td class="nav-s-td">{*[cn.myapps.core.workflow.form_list]*}</td>
		<td class="nav-s-td">
			<table width="120" align="right" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn('');">
							<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
					</td>
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">
							<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table class="table_noborder" style="margin-top: 5px;margin-bottom: 5px;">
	<tr>
		<td width="25%">
		{*[Module]*}:
		<input class="input-cmd" type="text" name="sm_module.name"
			value='<s:property value="#parameters['sm_module.name']"/>' size="10" />
		</td>
		<td width="25%">
		{*[Name]*}:
		<input class="input-cmd" type="text" name="sm_name"
			value='<s:property value="#parameters['sm_name']"/>' size="10" />
		</td>
		<td class="head-text">
			<input class="button-cmd" type="submit"  value="{*[Query]*}" />
			<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()" />
		</td>
	<tr>
</table>

<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table border="0" width="100%" align="center" cellpadding="2" cellspacing="2"
		width="100%">
		<tr>
			<th class="column-head" ><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></th>
			<th class="column-head" ><o:OrderTag field="module" css="ordertag">{*[Module]*}</o:OrderTag></th>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
				<td>
					<a href="javascript:doSelect('<s:property value="id" />;<s:property value="name" />')">
						<s:property value="name" />
					</a>
				</td>
				<td>
					<a href="javascript:doSelect('<s:property value="id" />;<s:property value="name" />')">
						<s:property value="module.name" />
					</a>
				</td>
			</tr>
		</s:iterator>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
