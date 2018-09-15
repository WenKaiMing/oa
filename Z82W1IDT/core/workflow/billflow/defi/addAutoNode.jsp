<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<%String contextPath = request.getContextPath();%>
<head>
<script src='<s:url value="/script/datePicker/WdatePicker.js"/>'></script>
<script language="javaScript">
var contextPath = '<%=contextPath%>';
function ev_ok() {
    var actorAttr = new Object();
    actorAttr.name = formItem.name.value;
    actorAttr.statelabel = formItem.statelabel.value;
    
    var issplits = document.getElementsByName("issplit");
    if(issplits[0].checked){
	    actorAttr.issplit = issplits[0].value;
	}else{
	    actorAttr.issplit = false;
	}
    
    var isgathers = document.getElementsByName("isgather");
    if(isgathers[0].checked){
	    actorAttr.isgather = isgathers[0].value;
	}else{
	   actorAttr.isgather = false;
	}
    
    var autoAuditTypes = document.getElementsByName("autoAuditType");
    for(var m=0; m<autoAuditTypes.length; m++){
		if (autoAuditTypes[m].checked) {
			actorAttr.autoAuditType = autoAuditTypes[m].value;
		}
	}
	
	actorAttr.delayDay = document.getElementById("delayDay").value;
    actorAttr.delayHour = document.getElementById("delayHour").value;
    actorAttr.delayMinute = document.getElementById("delayMinute").value;
   	actorAttr.auditDateTime = document.getElementById("auditDateTime").value;

   	actorAttr.splitStartNode = document.getElementById("splitStartNode").value;//聚和开始节点
    
    var validators = [{fieldName: "name", type: "required", msg: "{*[page.name.notexist]*}"}];
    if(document.getElementById("splitStartNode").value=="" && actorAttr.isgather){
		validators.push({fieldName: "splitStartNode", type: "required", msg: "{*[请选择分散开始节点]*}"});
	}
    if (doValidate(validators)) {
    	OBPM.dialog.doReturn(actorAttr);
    }
  }
function ev_close() {
    OBPM.dialog.doReturn();
}

/**
  * 切换审批类型
  */
function ev_changeType(type){
	var oTR0 = document.getElementById("dateTime_TR");
	var oTR1 = document.getElementById("delayTime_TR");
	oTR0.style.display = "none";
	oTR1.style.display = "none";
	
	if (!type) {
		return;
	}
	
	var typeCode = eval(type);
	
	switch(typeCode) {
		case 1:
			break;
		case 2:
			oTR0.style.display = "block";
			break;
		case 3:
			oTR1.style.display = "block";
			break;
		default:
			break;
	}
}

window.onload = function (){
	var obj=OBPM.dialog.getArgs()['oldAttr'];
    try{
      if(obj!= null){
      	if(obj.name!=null){
      		formItem.name.value=obj.name;
      	}
      	if(obj.statelabel!=null) {
      	      	formItem.statelabel.value=obj.statelabel;
      	}
      	
      	if (obj.issplit) {
      		var els = document.getElementsByName("issplit");
      		if(obj.issplit == true){
				els[0].checked = true;
			}
      	}
      	if (obj.isgather) {
      		var els = document.getElementsByName("isgather");
      		if(obj.isgather == true){
				els[0].checked = true;
				document.getElementById("splitStartNode").style.display="";
				document.getElementById("splitStartNodeLabel").style.display="";
			}
      	}
      	
      	var els = document.getElementsByName("autoAuditType");
      	if (obj.autoAuditType){
      		for(var i=0; i<els.length; i++){
				if(obj.autoAuditType == els[i].value){
					els[i].checked = true;
					break;
				}
			}
      	}
      	
      	if(obj.delayDay) {
      		document.getElementById("delayDay").value = obj.delayDay;
      	}
      	
      	if(obj.delayHour) {
      		document.getElementById("delayHour").value = obj.delayHour;
      	}
      	
      	if(obj.delayMinute) {
      		document.getElementById("delayMinute").value = obj.delayMinute;
      	}
      	
      	if(obj.auditDateTime) {
      		document.getElementById("auditDateTime").value = obj.auditDateTime;
      	}

      	var selectList=document.getElementById("splitStartNode");
		selectList.options.add(new Option("--{*[Select]*}--",""));
		if(obj.getAllSplitNode!=null){
			var nodes = obj.getAllSplitNode.split(",");
			for(var i=0; i<nodes.length; i++) {
				var stropt = nodes[i];
				if(stropt!=''){
					var opt =stropt.split("=");
					selectList.options.add(new Option(opt[1],opt[0]));
				}
			}
		}

		if(obj.splitStartNode!=null){
			selectList.value = obj.splitStartNode;
		}
      	
      	ev_changeType(obj.autoAuditType);
      	window.top.toThisHelpPage("application_module_workflows_autonode");
      }
    }catch(ex){
    	ev_changeType(0);
    }
}  

function isgatherEvent(s){
	if(s == true || s == 'true'){
		document.getElementById("splitStartNode").style.display="";
		document.getElementById("splitStartNodeLabel").style.display="";
	}else{
		document.getElementById("splitStartNode").style.display='none';
		document.getElementById("splitStartNodeLabel").style.display="none";
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>

<body>

<table width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.workflow.auto_node_info]*}</td>
		<td align="right">
		<table border=0 cellpadding="0" cellspacing="0">
			<tr>
				
				<td  valign="top">
				<button type="button" class="button-image"
					onClick="ev_ok();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td valign="top">
				<button type="button" class="button-image"
					onClick="ev_close();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">&nbsp;
		
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>

	<s:form  method="post" id="formItem" theme="simple">
		<table border="0" width="100%">	  
		  <tr>
		  	<td width="60%" class="commFont">{*[Name]*}:</td>
		  </tr>
		  <tr>
		  	<td align="left">
				 <s:textfield cssClass="input-cmd" label="{*[Name]*}" name="name" size="50"/>
			</td>
		  </tr>
		  
		<tr>
			<td width="60%" class="commFont">{*[State_Label]*}:</td>
		</tr>
		<tr>
		  	<td align="left">
				  <s:textfield cssClass="input-cmd" name="statelabel" size="50"/>
			</td>
		</tr>
	
		<tr bgcolor="#FFFFFF">
			<td width="60%" class="commFont">{*[Distribute]*}:</td>
		</tr>
		<tr>
			<td align="left">
				<input type="radio" name="issplit" id="issplit0" value="true">{*[step-by-step_approval_current_node,select_multiple_nodes]*}<br/>
				<input type="radio" name="issplit" id="issplit1" value="false" checked>{*[step-by-step_approval_current_node_only_choose]*}  
			</td>
		</tr>

		<tr bgcolor="#FFFFFF">
			<td class="commFont">{*[Centralized]*}:</td>
		</tr>
		<tr>
			<td align="left">
				<input type="radio" name="isgather" id="isgather0"  onclick="isgatherEvent(this.value)" value="true">{*[step-by-step_approval_node,select_multiple_nodes]*}
				<br/>
				&nbsp;&nbsp;<font id="splitStartNodeLabel" color="red"  style="display:none">分散{*[StartNode]*}:</font><select id="splitStartNode" name="splitStartNode" style="display:none"></select>
				<br/>
				<input type="radio" name="isgather" id="isgather1"  onclick="isgatherEvent(this.value)" value="false" checked>{*[multiple-step_approval_nodes,completion_one_node,arrival_process]*}  
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
			<td width="60%" class="commFont">{*[Auto.Audit.Type]*}:</td>
		</tr>
		<tr>
			<td align="left">
				<input type="radio" name="autoAuditType" value="1" onClick="ev_changeType(this.value)" checked >{*[Immediately]*}
				<input type="radio" name="autoAuditType" value="2" onClick="ev_changeType(this.value)">{*[Specify]*}
				<input type="radio" name="autoAuditType" value="3" onClick="ev_changeType(this.value)">{*[Delay]*}
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF" id="dateTime_TR">
			<td class="commFont">{*[DateTime]*}:
				<input type='text' id="auditDateTime" name='auditDateTime' class='Wdate' size='50' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'})" />
			</td>
		</tr>
		<tr bgcolor="#FFFFFF" id="delayTime_TR">
			<td class="commFont">{*[DelayTime]*}: 
				<input type='text' id="delayDay" name='delayDay' size='5'/>{*[Day]*}
				<input type='text' id="delayHour" name='delayHour' size='5'/>{*[Hour]*}
				<input type='text' id="delayMinute" name='delayMinute' size='10'/>{*[Minute]*}
			</td>
		</tr>
		</table>
	</s:form>
</body>
</o:MultiLanguage></html>