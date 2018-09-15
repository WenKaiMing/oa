<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<% 
WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
String username = user.getName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html>
<o:MultiLanguage>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{*[DomainLevel_Info]*}</title>

<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css" />
</head>
<body>
<!-- Navigate Table -->
<table  border="0" style=' width:100%;height:22px;background-color: #9EA4A9; font-family: Arial, Helvetica;font-size: 12px; background-image: none; color: white;'>
<tr><td style="padding-left:11px;">{*[Hello]*}, <%=username%> <a title="Edit Profile" class="nav_table_edit" 
		href="<s:url value='/core/superuser/editPersonal.action'><s:param name='editPersonalId' value='#session["USER"].id'/></s:url>"
		target="main"> [{*[Edit]*}]</a>&nbsp;&nbsp;<a class="nav_table" href="<s:url value='/admin/detail.jsp'/>">{*[Home]*}</a>&nbsp;>>&nbsp;<a class="nav_table" href="<s:url value='/core/domain/level/list.action'/>">{*[DomainLevel_List]*}</a>&nbsp;>>&nbsp;{*[DomainLevel_Detail]*}
</td>
</tr>
</table>
<table width="100%"  style='background: url(<s:url value="/resource/imgnew/index_07.gif" />); height:8px;'>
<tr>
	<td></td>
</tr>
</table>
<s:form action="save" method="post" theme="simple">

<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[DomainLevel_Info]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
						<button type="button" class="button-image"
			onclick="forms[0].action='<s:url action="save" />';forms[0].submit();">
		<img src="<s:url value='/resource/imgnew/act/act_4.gif'/>" />{*[Save]*}</button>
					</td>
					<td class="line-position2" width="70" valign="top">
						<button type="button" class="button-image"
			onclick="forms[0].action='<s:url action="list"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>" />{*[Exit]*}</button>
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


		<%@include file="/common/basic.jsp" %>

<s:hidden name="content.id" />
<s:hidden name="content.sortId" />
	<table border="0">
		<tr>
			<td class="commFont commLabel">{*[Level]*}{*[Name]*}:</td>
			<td><s:textfield cssStyle="width:300px;" cssClass="input-cmd" name="content.name" /></td>
		</tr>
		<tr>
			<s:bean name="cn.myapps.core.user.action.UserUtil"
		id="uh" />	
			<td class="commFont commLabel">{*[Level]*}:</td>
			<td><s:radio label="{*[Level]*}" name="content.level"
				theme="simple"
				list="#uh.getDomainLevels()" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[UserCount]*}:</td>
			<td><s:textfield cssStyle="width:300px;" cssClass="input-cmd" name="content.userCount" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[MobileUserCount]*}:</td>
			<td><s:textfield cssStyle="width:300px;" cssClass="input-cmd" name="content.mobileUserCount" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[Price]*}:</td>
			<td><s:textfield cssStyle="width:300px;" cssClass="input-cmd" name="content.price" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[Description]*}:</td>
			<td><s:textarea cssClass="input-cmd" cols="43" rows="2" cssStyle="width:300px;"
				label="{*[Description]*}" name="content.description" /></td>
		</tr>

	</table>
</s:form>
<s:if test="content.id!=null&&content.id.trim().length()>0">
	<iframe scrolling="no" id="frame" name="Frame" border="0" src="<s:url value='/core/domain/level/holdDomain.action'/>?sm_level.id=<s:property value="content.id" />"
		width="786" height="500" frameborder="0" />
	</iframe>
		
</s:if>
</body>
</o:MultiLanguage></html>
