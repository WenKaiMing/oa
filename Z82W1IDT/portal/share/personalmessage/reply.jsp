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
		<script>
		$(function(){
			$("#receivername").text("<%=webUser.getName()%>");
			$("#receiverid").val("<%=webUser.getId()%>");
		});
		</script>
	</head>

	<body class="body-front" style="margin: 0px; overflow-x: hidden;background-color:rgb(242,242,242);font-size=62.5%">
		<div id="container" style="padding:0 20px">
			<div id="activityTable" style="width: 100%; height: 9%">
				<s:form id="subNewMsg" action="save" method="post" theme="simple">
					<table width="100%" height="100%" align="center" id="tb" >
						<tr  >
							<td class="tdClass" style="width:100px;color:blue"><span style="font-size:0.8em;font-weight:bold">{*[Reply]*}：</span>
								<span  style="font-size:0.8em" id="receivername" name="receivername" style="color:blue"></span>
								<s:textfield cssClass="input-cmd" cssStyle="display:none" id="receiverid" name="receiverid" value=""/></td>
						</tr>
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
						<tr   id="tr_operations">
							<td class="commFont trClass" style="padding-left:40%">	
								<a class="confirm-button operation" href="###" operation="submit">{*[Confirm]*}</a>&nbsp;&nbsp;&nbsp;
								<a class="operation" href="###" operation="cancel">{*[Cancel]*}</a></td>
						</tr>
					</table>
				<div id="usersDiv" style="display: none"></div>
				<div id="userBackDiv" style="display: none"></div>
				<s:hidden id="domainid" name="content.domainid"	value="%{#parameters.domain}" />
				<s:hidden id="application" name="application" value="11de-f053-df18d577-aeb6-19a7865cfdb6" />
				</s:form>
			</div>
		</div>
	</body>
</o:MultiLanguage>
</html>