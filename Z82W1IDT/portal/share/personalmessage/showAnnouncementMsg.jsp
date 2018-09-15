<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Message]*}</title>
<%
ParamsTable params = ParamsTable.convertHTTP(request);
%>
<script type="text/javascript" src="../share/personalmessage/scripts/action.js"></script>
<%@include file="commonAttachment.jsp" %>
<script>
(function(){
	jQuery.ajax({
		type: "POST",
		cache: false,
		url: "<s:url value='/portal/personalmessage/show.action' />",
		data: "id=<%=params.getParameterAsString("id")%>&read=true&messageType=3",
		success: function(result) {
			jQuery(".sender").text(result.sendTitular? result.sendTitular : result.senderName);
			jQuery(".content").html(result.body.content);
			jQuery(".title").text(result.body.title);
			jQuery(".sendDate").text(result.sendDate);
			jQuery(".attachment_list").html(getAttachmentLinks(result.attachmentIds, result.attachmentNames));
		},
		error: function(result) {
			alert("{*[core.email.attachment.delete.error]*}！");
		}
	});
})();
</script>
</head>

<body style="margin:30px;">
	<s:form id="subNewMsg" name="formList" method="post" theme="simple" action="">
	<div style="border-bottom:2px solid red;padding:5px;">
		<h1 align="center" color="red"><span class="title"></span></h1>
		<font size="4" align="right" color="black">{*[Date]*}:<span class="sendDate"></span></font>
	</div>
	<div style="margin-top:2px;border-top:1px solid red;border-bottom:1px solid black;padding-top:30px;height:60%;">
		<div class="content"></div>
		<div class="whitespace-line"></div>
		<div class="whitespace-line"></div>
	</div>
	<div style="border-top:1px solid black;border-bottom:1px solid black;margin-top:1px; padding:5px 0px 5px 0px;">
	    <div class="attachment"><span style="font-size:13px">{*[Attachment]*}:</span><span class="attachment_list"></span></div>		
		<div class="whitespace-line"></div>
		<div class="whitespace-line"></div>
		<div class="sendInfo" style="font-size:13px"><span class="sender"></span><span>&nbsp;发</span></div>	
	</div>
	</s:form>
</body>
</o:MultiLanguage></html>
