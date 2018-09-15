<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Message]*}</title>
</head>
<%@include file="/portal/share/personalmessagecommonAttachment.jsp" %>
<%
PersonalMessageHelper pmh = new PersonalMessageHelper();
request.setAttribute("pmh", pmh);
%>
<script type="text/javascript">
</script>
<style>
</style>

<body style="margin:30px;">
<s:form id="subNewMsg" name="formList" method="post" theme="simple" action="">
<s:bean name="cn.myapps.core.personalmessage.action.PersonalMessageHelper"  id="pmh" />
<s:bean name="cn.myapps.core.user.action.UserUtil"  id="userUtil" />
<div style="border-bottom:2px solid red;padding:5px;">
<h1 align="center" color="red"><s:property value='#request.PersonalMessageVO.body.title' /></h1>
<font size="4" align="left" color="red">[<s:property value="#pmh.findDisplayText(#request.PersonalMessageVO.type)" />]</font>
<font size="4" align="right" color="black">{*[Date]*}:<s:date name="#request.PersonalMessageVO.sendDate" format="yyyy-MM-dd HH:mm:ss" /></font>
</div>
<div style="margin-top:2px;border-top:1px solid red;border-bottom:1px solid black;padding-top:30px;height:60%;">
<s:property escape="false" value="#pmh.htmlDecodeEncoder(#request.PersonalMessageVO.body.content)" />
<br/>
<br/>
</div>
<div style="border-top:1px solid black;border-bottom:1px solid black;margin-top:1px; padding:5px 0px 5px 0px;">
{*[Attachment]*}:
<s:property escape="false" value="#pmh.findAttachmentsByIds(#request.PersonalMessageVO.attachmentId,#request.PersonalMessageVO.outbox)" />
<br/>
<br/>
{*[From]*}
<s:property value="#userUtil.findUserName(#request.PersonalMessageVO.senderId)" />
{*[To]*}
<s:property value="#pmh.findUserNamesByMsgIds(#request.PersonalMessageVO.receiverId)" />
</div>
</s:form>
</body>
</o:MultiLanguage></html>
