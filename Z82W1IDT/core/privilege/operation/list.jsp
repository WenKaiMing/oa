<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<title>{*[Activity]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">

jQuery(document).ready(function(){
	cssListTable();
	inittab();
	window.top.toThisHelpPage("application_info_generalTools_operation_list");
});

</script>
</head>
<body id="application_info_generalTools_operation_list" class="body-back">
<s:actionerror />
<s:form theme="simple" name="formList" action="list" method="post">
	<%@include file="/common/list.jsp"%>
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnOperation'}" />
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onClick="forms[0].action='<s:url action="undo"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/reset.gif"></s:url>">{*[Resume]*}{*[all]*}</button>
							<button type="button" class="button-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}{*[all]*}</button>
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
	<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Value]*}:<input class="input-cmd" type="text" name="sm_value" value='<s:property value="#parameters['sm_value']" />' />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/>
				<tr><td>
			</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Name]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="resType"
					css="ordertag">{*[Resource]*}{*[Type]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="code"
					css="ordertag">{*[Code]*}</o:OrderTag></td>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td><a
					href='<s:url action="edit">
					<s:param name="_currpage" value="datas.pageNo" />
					<s:param name="_pagelines" value="datas.linesPerPage" />
					<s:param name="_rowcount" value="datas.rowCount" />
					<s:param name="application" value="#parameters.application" />
					<s:param name="id" value="id"/>
					<s:param name="tab" value="1" />
					<s:param name="selected" value="%{'btnOperation'}" />
					</s:url>'>{*[<s:property value="name" />]*}</a></td>
				<td><s:if test="resType==0">{*[View]*}</s:if>
					<s:elseif test="resType==1">{*[Form]*}</s:elseif>
					<s:elseif test="resType==2">{*[menu]*}</s:elseif>
					<s:elseif test="resType==3">{*[FormField]*}</s:elseif>
					<s:elseif test="resType==4">{*[Folder]*}</s:elseif>
					</td>
					<td><s:property value="code" /></td>
				</tr>
			</s:iterator>
		</table>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
