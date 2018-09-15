<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp" %>

<%String contextPath = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[DataSource]*}</title>
</head>
<s:bean name="cn.myapps.core.workflow.engine.StateMachineHelper" id="sh"/>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
	
<script type="text/javascript">
function IsDigit(){
	return ((event.keyCode>=48)&&(event.keyCode<=57));
}
jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_workflowMonitor_info");
});

//用户确定事件
function doConfirm(){
	var _nextNodeId = document.getElementsByName("_nextNodeId")[0].value;
	if (_nextNodeId && _nextNodeId.length > 0) {
		OBPM.dialog.doReturn(_nextNodeId);
	} else {
		alert("请选择节点");
	}
}


function doCancel(){
	OBPM.dialog.doExit();
}

</script>

<body id="bodyid" class="contentBody" style="overflow: hidden;">
	<div id="contentActDiv">
		<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[core.workflow.storage.runtime.intervention.summary]*}:  <s:property value="content.summary" /></div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="doConfirm();">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[core.workflow.storage.runtime.intervention.button.label.ok]*}
					</button>
					<button type="button" class="button-image" onClick="doCancel();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div >
		<s:form id="formItem" theme="simple" action="doFlow" method="post">
			<s:hidden name="content.id" />
			<s:hidden name="content.domainid" />
			<s:hidden name="content.applicationid" />
			<s:hidden name="application" value="%{#parameters.application}" />
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="3">
	  <tr>
	    <td colspan="2" bgcolor="#85B5D9"><span style="font-size: 14;font-weight: bold">{*[core.workflow.storage.runtime.intervention.label.flow_information]*}:</span></td>
      </tr>
	  <tr>
	    <td width="15%">{*[core.workflow.storage.runtime.intervention.label.flow_name]*}:</td>
	    <td width="85%">&nbsp;<s:property value="content.flowName" /></td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.label.current_node]*}:</td>
	    <td>&nbsp;<s:property value="content.stateLabel" /></td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.initiator]*}:</td>
	    <td>&nbsp;<s:property value="content.initiator" /></td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.firstProcessTime]*}:</td>
	    <td>&nbsp;<s:date name="content.firstProcessTime" format="yyyy-MM-dd HH:mm:ss" /> </td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.lastAuditor]*}:</td>
	    <td>&nbsp;<s:property value="content.lastAuditor" /></td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.lastProcessTime]*}:</td>
	    <td>&nbsp;<s:date name="content.lastProcessTime" format="yyyy-MM-dd HH:mm:ss" /> </td>
      </tr>
	  <tr>
	    <td colspan="2" bgcolor="#85B5D9"><span style="font-size: 14;font-weight: bold">{*[Process]*}:</span></td>
      </tr>
	  <tr>
	    <td>{*[core.workflow.storage.runtime.intervention.label.submit_to]*}:</td>
	    <td>&nbsp;<s:select name="_nextNodeId" list="#sh.getOtherNodeList(content.docId,application)" emptyOption="true"  listKey="id" listValue="statelabel" theme="simple"/></td>
      </tr>
</table>
		</s:form>
		<form action="" method="post"></form>
	</div>
</body>
</o:MultiLanguage>
</html>