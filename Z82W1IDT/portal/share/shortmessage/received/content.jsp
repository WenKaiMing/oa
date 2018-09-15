<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[ReceivedMessage]*}</title>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
</head>
<script type="text/javascript">
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<o:Url value="/core/resource/resourcechoice.jsp" />';

function checkSpace(obj) {
	var regex = /[^\w\u4e00-\u9fa5]/g;
	obj.value = obj.value.replace(regex, '');
}
wx = '600px'; 
wy = '600px';
</script>
<body style="overflow:hidden;margin-left:0px;margin-top:5px; margin-right:5px;" class="body-front">
<div id="container">
<div id="activityTable">
		<table class="act_table" width="100%" border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td>
<span class="button-document"><a href="###" onclick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><span><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</span></a></span>					
				</td>
			</tr>
		</table>
</div>
<div id="dataTable">
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:form action="save" method="post" theme="simple">
	<%@include file="/common/page.jsp"%>
	<s:hidden name="sm_parent" value="%{#parameters.sm_parent}"/>
	<table width="80%">
		<tr>
			<td class="commFont commLabel">{*[Sender]*}:</td>
			<td colspan="3"><span id="sendername"></span><s:textfield  readonly="true"  cssClass="input-cmd" cssStyle="display:block" id="sender" name="content.sender" /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[ReceivedDate]*}:</td>
			<td colspan="3"><s:textfield cssClass="input-cmd"  name="content.receiveDate"  readonly="true"  /></td>
		</tr>
		<tr>
			<td class="commFont commLabel">{*[Content]*}:</td>
			<td colspan="3"><s:textarea id="content" cssClass="input-cmd"
					theme="simple" cols="80" rows="6" name="content.content" readonly="true" /></td>
			<!--<td><s:richtexteditor allowFlashUpload="false" 
							allowLinkUpload="false" 
							toolbarStartExpanded="false" 
							autoDetectLanguage="true" 
					name="content.content" cssStyle="height:300px;"/></td-->
		</tr>
	</table>
	<s:hidden name="content.applicationid" value="%{#parameters.application}" />
</s:form>
</div>
</div>
</body>
</o:MultiLanguage></html>