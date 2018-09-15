<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String username = user.getName();
%>

<html>
<o:MultiLanguage>
	<head>
	<title>{*[Domains]*}</title>
	<script src="<s:url value="/script/list.js"/>"></script>

	<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>'
		type="text/css" />
	</head>
	<body style="margin: 0px; padding: 0px">

	<s:form name="formList" action="list" method="post" id="listform">
		<!-- Navigate Table -->

		<table width="100%"
			style='background: url(< ww : url value = "/resource/imgnew/index_07.gif"/ >); height: 8px;'>
			<tr>
				<td></td>
			</tr>
		</table>

		<table width="100%">
			<tr>
				<td width="10" class="image-label"><img
					src="<s:url value="/resource/image/email2.jpg"/>" /></td>
				<td width="3">&nbsp;</td>
				<td width="200" class="text-label">{*[Domain_List]*}</td>
				<td>
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td>&nbsp;</td>
						<td class="line-position2" width="70" valign="top">
						<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="removeDomain"/>';forms[0].submit();"><img
							src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Remove]*}</button>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"
					style="border-top: 1px solid dotted; border-color: black;">
				&nbsp;</td>
			</tr>
		</table>

		<s:if test="hasFieldErrors()">
			<span class="errorMessage"><br>
			<s:iterator value="fieldErrors">
				<script>
		window.setTimeout("alert('* '+'<s:property value="value[0]" />,{*[page.cannot.delete]*}')",200);
		</script>
			</s:iterator> </span>
		</s:if>

		
		<table class="list-table" border="0" cellpadding="0" cellspacing="2"
			width="100%">
			<%@include file="/common/basic.jsp"%>
			<s:hidden name="sm_level.id" value="%{#parameters.sm_level.id}" />
			<tr>
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Domain]*}{*[Name]*}</o:OrderTag></td>
				<td class="column-head" scope="col">{*[Manager]*}</td>
				<td class="column-head" scope="col"><o:OrderTag field="status"
					css="ordertag">{*[Status]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<s:if test="#index.odd == true">
					<tr class="table-text">
				</s:if>
				<s:else>
					<tr class="table-text2">
				</s:else>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td><s:property value="name" /></td>
				<td>|<s:iterator value="users" status="user">
					<s:property value="loginno" /> | 
				</s:iterator></td>
				<td><s:if test="status == 1">
					{*[Enable]*}
				</s:if> <s:else>
					{*[Disable]*}
				</s:else></td>
				</tr>
			</s:iterator>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
		<div>
	</s:form>
	</body>
</o:MultiLanguage>
</html>



