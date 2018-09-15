<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<% 
WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
String username = user.getName();
%>

<html><o:MultiLanguage>
<head>
<title>{*[DomainLevels]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<script>

function query() {
	var listform = document.getElementById("listform");
	
		listform.submit();
}

</script>
<link rel="stylesheet"
	href='<s:url value="/resource/css/main.css"/>'
	type="text/css" />
</head>
<body>
<!-- Navigate Table -->
<table  border="0" style=' width:100%;height:22px;background-color: #9EA4A9; font-family: Arial, Helvetica;font-size: 12px; background-image: none; color: white;'>
<tr><td style="padding-left:11px;">{*[Hello]*}, <%=username%> <a title="Edit Profile" class="nav_table_edit" 
		href="<s:url value='/core/superuser/editPersonal.action'><s:param name='editPersonalId' value='#session["USER"].id'/></s:url>"
		target="main"> [{*[Edit]*}]</a>&nbsp;&nbsp;<a class="nav_table" href="<s:url value='/admin/detail.jsp'/>">{*[Home]*}</a>&nbsp;>>&nbsp;{*[DomainLevel_List]*}
</td>
</tr>
</table>
<table width="100%"  style='background: url(<s:url value="/resource/imgnew/index_07.gif" />); height:8px;'>
<tr>
	<td></td>
</tr>
</table>
<s:form name="formList" action="list" method="post" id="listform">
<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[DomainLevel_List]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					</td>
					<td class="line-position2" width="70" valign="top">
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="delete"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>	
	<table width="100%">
		<tr>
			<td class="head-text">
			{*[Level]*}{*[Name]*}:
			<input class="input-cmd" type="text" name="sm_name"
				value='<s:property value="#parameters['sm_name']"/>' size="10" />
			{*[Level]*}:
			<input class="input-cmd" id="sm_level"  type="text" name="sm_level"
				value='<s:property value="#parameters['sm_level']"/>' size="10" />
			<input class="button-cmd" type="button"  value="{*[Query]*}" onclick="query()" />
			<input class="button-cmd" type="button" value="{*[Reset]*}"
				onclick="resetAll()" />
			</td>

			<td align="right">
				&nbsp;
			</td>
		<tr>
	</table>

	<table class="list-table" border="0" cellpadding="0" cellspacing="2"
		width="100%">
			<%@include file="/common/basic.jsp" %>
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Level]*}{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="level"
				css="ordertag">{*[Level]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="description"
				css="ordertag">{*[Description]*}</o:OrderTag></td>
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
			<td><a
				href='<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				</s:url>'><s:property
				value="name" /></a></td>
			<td>
				<a
				href='<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				</s:url>'><s:property
				value="level" /></a></td>
			</td>
			<td>
				<a
				href='<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				</s:url>'><s:property
				value="description" /></a></td>
			</td>
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
</o:MultiLanguage></html>



