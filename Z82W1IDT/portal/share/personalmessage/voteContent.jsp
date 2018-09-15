<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid = webUser.getDomainid();
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
		<title></title>
		<%@ include file="commonContent.jsp" %>
	</head>
	
	<body class="body-front" style="margin: 0px; overflow-x: hidden; background-color:rgb(242,242,242);">
		<div id="container" style="padding:0 20px">
			<div id="activityTable" style="width: 100%; height:9%">
				<s:form id="subNewMsg" action="save" method="post" theme="simple">
					<table width="100%" height="100%" align="center" id="tb" >
						<input type="hidden" name="content.type" value="2"/>
						<tr  >
							<td  class="tdClass"><span style="font-size:0.8em;color:blue;" >{*[Receiver]*}：</span>
								<s:textfield id="receivername" name="receivername" cssStyle="width:20%;font-size:0.8em;border: 0 none black" readonly="true" value="%{#parameters.receivername}"/>
								<s:textfield cssClass="input-cmd" cssStyle="display:none" id="receiverid" name="receiverid" value=""/>
								<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#receiverid').attr('id'),jQuery('#receivername').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
								</td>
						</tr>
						<%-- <tr  id="tr_title">
							<td class="tdClass trClass"  ><span style="font-size:0.8em;font-weight:bold" >{*[Title]*}&nbsp;&nbsp;&nbsp;：</span>&nbsp;<s:textfield cssClass="" cssStyle="width:78%;"  name="content.body.title" /></a>
							</td>
						</tr>--%>
						<tr    id="tr_attachments">
							<td class="tdClass trClass"  ><span style="font-size:0.8em;font-weight:bold" >{*[Attachment]*}&nbsp;&nbsp;&nbsp;：</span>&nbsp;
							<span id="attaid" style='display:inline'>
								<input type="hidden" name="attachments" value="<s:property value="attachments" />" />	
							</span>
							<input type='button' value='{*[Upload]*}..' onclick="Upload();">
							</td>
						</tr>
						<tr   id="tr_content">
							<td class="trClass"><textarea name="content.body.content" class="xheditor" style="height:240px; width:100%; ">
								<s:property value="content.body.content" /></textarea></td>
						</tr>
						<tr id="tr_optionsType">
							<td class="tdClass trClass"  ><span style="font-size:0.8em;font-weight:bold" >
								{*[Options]*}{*[Type]*}：<s:radio  name="content.radioOrCheckbox" list="#{'0':'{*[RadioField]*}','1':'{*[CheckboxField]*}'}" value="0" theme="simple" /></span>
							</td>
						</tr>
						<tr><td class="tdClass trClass" >
							<span style="font-size:0.8em;font-weight:bold" >{*[Options]*}：
								<font color="red" >({*[Format]*}：{*[Options]*}1;{*[Options]*}2)</font></span>
						</td></tr>
						<tr id="tr_options">
							<td class="tdClass trClass"  >
								<s:textarea id="content.voteOptions" name="content.voteOptions" cssStyle="width:580px;height:80px"></s:textarea>
							</td>
						</tr>
						<tr id="tr_operations">
							<td class="commFont trClass" style="padding-left:40%">	
								<a class="confirm-button operation" href="###" operation="submit">{*[Confirm]*}</a>&nbsp;&nbsp;&nbsp;
								<a class="operation" href="###" operation="cancel">{*[Cancel]*}</a></td>
						</tr>
					</table>
				<div id="usersDiv" style="display: none"></div>
				<div id="userBackDiv" style="display: none"></div>
				<s:hidden id="domainid" name="content.domainid"	value="%{#parameters.domain}" />
				<s:hidden id="application" name="application" value="" />
				</s:form>
			</div>
		</div>
	</body>
</o:MultiLanguage>
</html>
