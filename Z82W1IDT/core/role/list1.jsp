<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<title>{*[Role*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
</head>
<body class="body-back" >
<s:actionerror />
<s:form theme="simple" name="formList" action="listRoles" method="post">
<%@include file="/common/list.jsp"%>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-s-td">
		<td class="nav-s-td" align="left">
			<table width="150" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="create"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					</td>
					<td valign="top">
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="deleteRole"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
<table>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />'
				size="10" /></td>

			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/></td>
		<tr>
	</table>
<table class="list-table" border="0" cellpadding="2" cellspacing="2"
		width="100%">
		<tr>
			<td class="column-head2"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			</tr>
		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
			<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
			<td><a
				href='<s:url action="editRole">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="id" value="id"/>
				<s:param name="tab" value="1" />
				<s:param name="selected" value="%{'btnRole'}" />
				</s:url>'>
				<s:property value="name" /></a></td>
			</tr>
		</s:iterator>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
	<div>
</s:form>
</body>
</o:MultiLanguage></html>
