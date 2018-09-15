<%@ page pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.myapps.core.macro.runner.IRunner"%>
<%@page import="cn.myapps.core.macro.runner.JavaScriptFactory"%>
<%@page import="cn.myapps.core.workflow.storage.definition.ejb.BillDefiVO"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.core.workflow.storage.definition.ejb.BillDefiProcess"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.FlowStateRTProcess"%>

<%
	String contextPath = request.getContextPath();
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String applicationid = request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String docid=request.getParameter("docid");
	String flowid=request.getParameter("flowid");
	String instanceId = "";
	BillDefiProcess flowProcess = (BillDefiProcess)ProcessFactory.createProcess(BillDefiProcess.class);
	BillDefiVO flowVO = (BillDefiVO)flowProcess.doView(flowid);
	if(applicationid == null || applicationid == ""){
		applicationid = flowVO.getApplicationid();
	}
	String s_module = flowVO.getModule().getId();
	DocumentHtmlBean dochtmlBean = new DocumentHtmlBean();
	dochtmlBean.setHttpRequest(request);
	dochtmlBean.setHttpResponse(response);
	dochtmlBean.setWebUser(webUser);
    request.setAttribute("dochtmlBean", dochtmlBean);
%>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<o:Url value='/resource/css/style.jsp'/>" />
	<link rel="stylesheet" href="<o:Url value='/resource/css/dialog.css'/>"
		type="text/css" media="all" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<link rel="stylesheet"
		href='<s:url value="/resource/css/dtree.css" />' type="text/css">
	<script src='<s:url value="/portal/share/script/util.js"/>'></script>
	<script src='<s:url value="/portal/share/script/dtree.js"/>'></script>
	<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script language="JavaScript">
var contextPath = '<s:url value="/" />';

//最后提交的信息（json格式）
var submitTo="";
var nodeids="";

//是否指定审批人
var isToPerson=false;
//如果指定审批人，审批人是否为空
var isNullUser;
//nextNode type checkbox || radio
var isCheckbox;

//有没有回退操作
var back
//是否需要USBKEY身份认证
var isUsbKeyVerify = '<s:property value="#parameters.isUsbKeyVerify" />';

//用户确定事件
function doConfirm(){
	var isHandup = document.getElementsByName("isHandup")[0];
	if(isHandup){
		alert("{*[cn.myapps.core.workflow.suspend.suspended]*}");
		return false;
	}
	if(!checkIsSelectCirculator()){
		return;
	}
	var isToPersonStr ='';
	if(document.getElementById("isToPerson")!=null){
		isToPersonStr = document.getElementById("isToPerson").value;
	}
	if(isToPerson || isToPersonStr =='true'){//流程节点是否配置指定审批人
			prepareReturn();
		var _flowType = '';
		if(document.getElementById("_flowType") != null){
			_flowType = document.getElementById("_flowType").value;
		}
		if(_flowType == '80'){
			if(isNullUser){
				alert ('{*[cn.myapps.core.workflow.choose_specify_auditor]*}');
				return;
			}
		}else if(_flowType == '81'){
			var input_back = null;
			if(document.getElementById("input_back") != null){
				input_back = document.getElementById("input_back").value;
			}
			if(input_back !=null && input_back == ''){
				alert ('{*[cn.myapps.core.workflow.choose_specify_auditor]*}');
				return;
			}
			//回退操作,清空指定审批人信息
			document.getElementById("submitTo").value = '';
		}
	}
	biuldCirculatorInfoStr();
	var data = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
	var nextids = data['_nextids'];
	var principal = data['submitTo'];
	
	//if (isNullUser) {
	//	alert("请选择接受人");
	//	return;
	//}
	
	if (nextids && nextids.length > 0) {
		if(isUsbKeyVerify == 'true'){
			usbkeyVerify(data);
		}else{
			//OBPM.dialog.doReturn(jQuery.param(data,true));
			OBPM.dialog.doReturn(data);
		}
		
	} else {
		alert("请选择一项操作");
	}
}

function ev_flowHandup(nodertId){
	var _attitude = document.getElementsByName("_attitude")[0].value;
	var rtn = 'isHandupOrRecover=true&_operationMode=handup&nodertId=' + nodertId + '&_attitude=' + _attitude;
	var data = jQuery.par2Json(rtn);
	OBPM.dialog.doReturn(data);
}

function ev_flowRecover(nodertId){
	var _attitude = document.getElementsByName("_attitude")[0].value;
	var rtn = 'isHandupOrRecover=true&_operationMode=recover&nodertId=' + nodertId + '&_attitude=' + _attitude;
	var data = jQuery.par2Json(rtn);
	OBPM.dialog.doReturn(data);
}

/**
* USBKEY身份认证
**/
function usbkeyVerify(data){
	var url = contextPath + '/portal/share/security/usbkeyAuth_dialog.jsp?application=<%=applicationid%>';
	OBPM.dialog.show({
		width: 350,
		height: 250,
		url: url,
		args: {},
		title: '{*[core.sysconfig.usbkey.authenticate]*}',
		close: function(result) {
			if(result =="true") {
				OBPM.dialog.doReturn(jQuery.param(data,true));
			}
		}
	});
	return false;
		
}

var selectFlag = false;
function showUserSelect(actionName, settings) {
	var url = contextPath + '/portal/share/user/selectbyflow.jsp?application=<%=applicationid%>';
	url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
	var valueField = document.getElementById(settings.valueField);
	var value = "";
	if (valueField){
		value = valueField.value;
	}
	
	var ids = document.getElementById(settings.hiddenIds).value;
	OBPM.dialog.show({
		width: 500,
		height: 400,
		url: url,
		args: {parentObj: window, idField: "submitTo", nameField: settings.textField, readonly: settings.readonly, "applicationid":'<%=applicationid%>',"defValue":ids},
		title: '{*[cn.myapps.core.workflow.user_select]*}',
		close: function(result) {
			selectFlag = true;
			var rtn = result;
			var field = document.getElementById(settings.textField);
			if (field) {
				if (rtn) {
					isToPerson = true;
					if (rtn[0] && rtn.length > 0) {
						var rtnValue = '';
						var rtnText = '';
						//userid多个以","分隔
						var selectedNode=document.getElementById(settings.nextNodeId);
						//用户选择曾经选过的节点
						var submitTo = document.getElementById("submitTo").value;
						if(submitTo==null || submitTo==""){
                             submitTo = "[";
						}else{
							if(submitTo.lastIndexOf("]")!=-1){
							 	submitTo = submitTo.substr(0,submitTo.lastIndexOf("]"));
							 	submitTo = submitTo +',';
							}
						}
						var start=submitTo.indexOf(settings.nextNodeId)+settings.nextNodeId.length+34;
						if(submitTo.indexOf(settings.nextNodeId)>0){
							var strfront=submitTo.substr(0,start);
							var strtemp=submitTo.substr(start+1,submitTo.length);
							if(strtemp.substr(strtemp.length-1,strtemp.length)==","){
								strtemp = strtemp.substr(0,strtemp.length-1);
							}
							var strfoot=strtemp.substr(strtemp.indexOf("]",0)-1,strtemp.length);
							submitTo=strfront;
							for (var i = 0; i < rtn.length; i++) {
								rtnValue += rtn[i].value + ";";
								rtnText += rtn[i].text + ";";
								submitTo+="\""+rtn[i].value+"\",";
							}
							//submitTo= submitTo.replace('"userids":"','"userids":"[');
							submitTo=submitTo.substring(0,submitTo.length-2);
							submitTo+=strfoot;

							document.getElementById(settings.hiddenIds).value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
						}
						else{
							submitTo+="{\"nodeid\":\""+settings.nextNodeId+"\",\"isToPerson\":\"true\",\"userids\":\"[";
							var userids="";
							for (var i = 0; i < rtn.length; i++) {
								rtnValue += rtn[i].value + ";";
								rtnText += rtn[i].text + ";";
								userids+="\\\""+rtn[i].value+"\\\",";
							}
							userids=userids.substring(0,userids.length-1); 
							submitTo+=userids+"]\"}";

							document.getElementById(settings.hiddenIds).value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
						}
						document.getElementById("submitTo").value = submitTo+"]";
						valueField.value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
						var text  = rtnText.substring(0, rtnText.lastIndexOf(";"));
						field.value = text;
						field.title = text;
					}
				} else {
					if (rtn == '') { // 清空
						field.value = '';
						field.title = '';
						document.getElementById("submitTo").value = '';
						document.getElementById(settings.hiddenIds).value = '';
						isToPerson = false;
					}
				}
		
				if (settings.callback) {
					settings.callback(valueField.name);
				}
			}
		}
	});
}

//返回前参数的准备
function prepareReturn(){
	if(selectFlag){
		var submitTo = document.getElementById("submitTo").value;
		//submitTo=submitTo.substring(0,submitTo.length-1);
		//获取节点的name集合
		var nextNodes=document.getElementsByName("_nextids");
		//获取节点是否指点审批人isToPerson集合
		//var isToPersons=document.getElementsByName("isToPerson");
		var elength=nextNodes.length;
		var back = document.getElementById("back");
		if (back != null) {
			elength=nextNodes.length-1;
			if(back.selectedIndex>0){
				submitTo=submitTo.replace('\'false\'','\'true\'');
			}
		}
		for(var i=0;i<elength;i++){
			if(nextNodes[i].checked){
				if(document.getElementById("input_"+i)!=null && document.getElementById("input_"+i).value==""){
					isNullUser=true;
				}else{
					isNullUser=false;
				}
				//var start=submitTo.indexOf(nextNodes[i].value)+nextNodes[i].value.length+16;
				//submitTo=submitTo.substr(0,start)+"true"+submitTo.substr(start+4,start.length);
			}
		}
		//submitTo=submitTo+"]";
		
		document.getElementById("submitTo").value=submitTo;
	}

		var nextNodes=document.getElementsByName("_nextids");
		//获取节点是否指点审批人isToPerson集合
		//var isToPersons=document.getElementsByName("isToPerson");
		var elength=nextNodes.length;
		for(var i=0;i<elength;i++){
			if(nextNodes[i].checked){
				if(document.getElementById("input_"+i)!=null && document.getElementById("input_"+i).value==""){
					isNullUser=true;
					break;
				}else{
					isNullUser=false;
				}
			}
		}
	selectFlag = false;
}


function doReturn(){
	var sis = document.getElementsByName("_nextids");
	var array = new Array();
	  if (sis != null && sis.length > 0) {
		for (var i=0; i<sis.length; i++) {
			var e = sis[i];
		if (e.type == 'checkbox') {
				if (e.checked && e.value) {
			    	var rtn = {};
			    	rtn.text = e.text;
			    	rtn.value = e.value;
			    	array.push(rtn);
			    }
			}
	 	}
	  }
	  
	  OBPM.dialog.doReturn(array);
}
function doCancel(){
	window.close();
}

function init(){
	OBPM.dialog.resize(document.body.scrollWidth+20, document.body.scrollHeight+70);
}


function showBackUserSelect(docid){
	var back = document.getElementById("back");
	var imgid ="back";
	if(back != null && back.selectedIndex>0){
		var nextNodeId = back.value;
		showUserSelect('actionName', {nextNodeId:nextNodeId, docid:docid, textField:'input_' + imgid + '',valueField: 'input_'+ imgid + '', readonly: false});
	}
}
</script>

	<style>
.btn-ul {
	list-style-image: none;
	margin-left: 0;
	padding-left: 0;
}

.btn-ul li {
	float: left;
	display: inline;
	word-break: keep-all;
	margin-right: 5px;
	margin-bottom: 3px;
}
</style>
	<title>flow process</title>
	</head>
	<body onload="init()" style="overflow-x: hidden;">
	<table width="90%" height="100%">
	<tr><td valign="top" height="100%" align="center">
	<s:form id="flowprocess" name="flowprocess" action="" method="post" theme="simple">
		<%
				Document doc = null;
				if(doc ==null && docid != null && docid.trim().length()>0){
					DocumentProcess process = (DocumentProcess) ProcessFactory.createRuntimeProcess(DocumentProcess.class, flowVO.getApplicationid());
					doc = (Document)process.doView(docid);
				}
				
				if(!StringUtil.isBlank(doc.getStateid())){
					FlowStateRTProcess stateProcess = (FlowStateRTProcess) ProcessFactory.createRuntimeProcess(FlowStateRTProcess.class, doc.getApplicationid());
					if(stateProcess.isMultiFlowState(doc)){//有多个没完成是流程实例
						doc.setState(stateProcess.getCurrFlowStateRT(doc, webUser, null));//绑定一个可执行的文档实例
						doc.setMulitFlowState(stateProcess.isMultiFlowState(doc, webUser));//是否存在多个可执行实例
					}
				}
				//统一从document里获取，可能有种情况是前台手动调整流程
				flowVO = doc.getFlowVO();
				instanceId = doc.getStateid();
				
				
				//Form form = FormHelper.get_FormById(doc.getFormid());
				//Activity flowAct = form.getActivityByType(ActivityType.WORKFLOW_PROCESS);
				//String fshowtype=request.getParameter("fshowtype");
				String fshowtype= "";
				if (doc != null && doc.getParent() == null && !doc.getIstmp())
					if (!StringUtil.isBlank(doc.getFlowid())) {
						IRunner r = JavaScriptFactory.getInstance(request.getSession().getId(), doc.getApplicationid());
						r.initBSFManager(doc,doc.get_params(), webUser, new ArrayList<ValidateMessage>());
						
						StateMachineHelper helper = new StateMachineHelper(doc);
						String htmlText = helper.toFlowDialogHtmlText(doc, webUser,fshowtype);
		%>
		<s:token name="token" />
		<%
			if (helper.isDisplyFlow) {
				String flowHistoryHtmlText="";
		%>
		<table width="98%" style="margin: 1px; padding: 1px" border="0" cellspacing="1" cellpadding="1">
			<tr><td align="center">
				<input type="button" value="{*[Confirm]*}" onClick="doConfirm()" /> 
				<input type="button" value="{*[Cancel]*}" onClick="OBPM.dialog.doExit()" />
			</td></tr>
			<tr>
				<td colspan="3">
					<fieldset> 
		    			<legend>{*[core.workflow.storage.runtime.view.choose.approve.node]*}</legend> 
		    			<div id="flowHtmlText" class="flowHtmlText">
						<table width="100%" border="0">
							<%=htmlText%>
							<tr>
								<td>{*[cn.myapps.core.workflow.approve_remarks]*}:</td>
								<td>
									<s:textarea rows="3" name="_attitude" cssStyle="width:100%;" /> 
								</td>
							</tr>
						</table>
						</div>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="right">
				<fieldset> 
	    			<legend>{*[cn.myapps.core.workflow.flow_history]*}</legend> 
					<%
						if (doc!=null && doc.getParent()==null && !doc.getIstmp()) {
							flowHistoryHtmlText = StateMachineHelper.toHistoryHtml(doc, 4);
						}
					%>
					<%=flowHistoryHtmlText%>
				</fieldset><br>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<fieldset> 
		    			<legend>{*[cn.myapps.core.workflow.flow_diagram]*}</legend>
						<table width="100%">
							<tr>
								<td>{*[Caption]*}：</td>
								<td><div>1、<font color="red"><b>{*[core.workflow.storage.runtime.view.RedLine]*}</b></font>{*[core.workflow.storage.runtime.view.currentNode]*}；2、<font
									color="green"><b>{*[core.workflow.storage.runtime.view.GreenLine]*}</b></font>{*[core.workflow.storage.runtime.view.processedLine]*}；3、<b>{*[core.workflow.storage.runtime.view.BlackLine]*}</b>
									{*[core.workflow.storage.runtime.view.processingLine]*}；</div></td>
							</tr>
							<tr>
								<td></td><td><div>4、<span style="background-color:yellow;"><b>{*[core.workflow.storage.runtime.view.YellowBackground]*}</b>
									</span>{*[core.workflow.storage.runtime.view.workflowTerminated]*}。</div></td>
							</tr>
						</table>
						<div style="overflow-y:hidden;overflow-x:auto;width:100%;text-align: center;">
						<img name="flowImg" src="<%= "../../../uploads/billflow/" + instanceId +  ".jpg" %>?tempid=<%=Math.random()%> "/>
						</div>
					</fieldset>
				</td>
			</tr>
			<input type="hidden" id="_flowType" name="_flowType" value="80" />
			<s:hidden id="submitTo" name="submitTo" value=""></s:hidden>
			<s:hidden id="_subFlowApproverInfo" name="_subFlowApproverInfo" value=""></s:hidden>
			<s:hidden id="_circulatorInfo" name="_circulatorInfo" value=""></s:hidden>
			<s:hidden id="_subFlowApproverInfoAll" name="_subFlowApproverInfoAll" value=""></s:hidden>
		</table>
		<%
			}
					}
		%>
	</s:form>
	</td></tr>
	</table>
	</body>
	<script language="JavaScript">
	var contextPath = '<%= request.getContextPath()%>';

	/**回选之前选中的节点**/
	if (window.attachEvent) {    
		window.attachEvent('onload', ev_loadFLow);    
	}    
	else {    
		window.addEventListener('load', ev_loadFLow, false);   
	}  
	
	function ev_setFlowType(isOthers, element, flowOperation,imgid) {//设置流程类型
		//拿回所选的下一节点的id
		var nextNodeId=element.value;
		var elements = document.getElementsByName('_nextids');
		back = document.getElementById('back');
		//用户选择下一节点
		if (element.id != 'back') {
			if(element.type != 'checkbox'){
				var elength=elements.length;
				if (back != null) {
					elength=elements.length-1;
				}
			}
			else{
				var isToPerson=document.getElementById("isToPerson").value;
				if(isToPerson=="true"){
					for (var i=0; i < elements.length; i++) {
						document.getElementById("selectUserImg_"+i).style.display="";
					}
				}
			}
			if (back != null) {
				back.selectedIndex = 0;
			}
			if (isOthers && element.type != 'checkbox') {
				for (var i=0; i < elements.length; i++) {
					if (elements[i].type == 'checkbox') {
						elements[i].checked = false;
						document.getElementById("selectUserImg_"+i).style.display="";
					}
				}
			}
		} 
		//用户选择回退
		else {
			var elements = document.getElementsByName('_nextids');
			for (var i=0; i < elements.length; i++) {
				elements[i].checked = false;
				if(document.getElementById("input_"+i)){
					//回退操作,清空指定审批人文本框
					document.getElementById("input_"+i).value = "";
				}
				if(document.getElementById("input_hidden_id_"+i)){
					//回退操作,清空指定审批人ids
					document.getElementById("input_hidden_id_"+i).value = "";
				}
			}
			if (back != null && back.selectedIndex>0) {
				//回退操作,清空指定审批人信息
				document.getElementById("submitTo").value = '';
			}
		}
		
		if (document.getElementById('_flowType')){
			document.getElementById('_flowType').value = flowOperation;
		}
	}

	function ev_validation(el, actid) {
		var nextids = document.getElementsByName('_nextids');
		var flag = false;
		
		makeAllFieldAble();
		
		if (nextids != null) {
			for (var i=0; i<nextids.length; i++) {
				if (nextids[i].type != 'select-one') {
					if (nextids[i].checked) {
						flag = true;
						break;
					}
				} else {
					if (nextids[i].value != null 
					&& nextids[i].value != '') {
						flag = true;
						break;
					}
				}
			}
			
			if (flag) {
				document.forms[0].action='<s:url action="action" namespace="/portal/dynaform/activity" />?_activityid=' + actid;
				document.forms[0].submit();
			}
			else {
				alert('{*[page.workflow.chooseaction]*}');
			}
		}
		else {
			alert ('{*[page.workflow.noaction]*}');
		}
	}

	function ev_viewHis() {
		if (his.style.display == "") {
			his.style.display = "none";
		}
		else {
			his.style.display = "";
		}
		ev_onload();
	}
	var docid='<%=docid%>';
	function ev_viewHistory() {
    	var flag = true;
        var dateTime = new Date().getTime();
		var url = "<o:Url value='/workflow/runtime/flowhis.jsp' />?_docid=" +docid+ "flowid=<%=flowVO.getId()%>&dateTime=" + dateTime;
		//showFrameByDiv(url, '{*[Workflow_History]*}', 700, 550);
		OBPM.dialog.show({
			width: 600,
			height: 400,
			url: url,
			args: {},
			title: '{*[Workflow_History]*}',
			close: function(result) {
				var rtn = result;
			}
		});
	}
	
	function ev_viewFlow() {
		var dateTime = new Date().getTime();
		var url = '<s:url namespace="/portal/dynaform/document" action="viewFlow" />?_docid='+docid+'&dateTime=' + dateTime;
		//showFrameByDiv(url, '{*[Workflow_Diagram]*}', 700, 550);
		OBPM.dialog.show({
			width: 600,
			height: 400,
			url: url,
			args: {},
			title: '{*[Workflow_Diagram]*}',
			close: function(result) {
				var rtn = result;
			}
		});
	}

	/**回选之前选中的节点**/
	function ev_loadFLow(){
		var checkedNodeListStr = '<s:property value="#request._nextids" />';
		var nextEls = document.getElementsByName("_nextids");
		//当前的提交节点是否可多选
		if(nextEls.type=="checkbox"){
			isCheckbox=true;
		}else{
			isCheckbox=false;
		}
		if (nextEls.length == 0) {
			return;
		}
		
		// 初始化流程选中项
		if (checkedNodeListStr) {
			var checkedNodeList = checkedNodeListStr.split(',');
			for (var i=0; i < nextEls.length; i++) {
				if (nextEls[i].type != 'select-one') {
					if (checkedNodeList.indexOf(nextEls[i].value) != -1) {
						nextEls[i].click();
					}
				} else {
					selectOne(nextEls[i], checkedNodeList[0], function(oSelect){
						oSelect.onchange();
					});
				}
			}
		}
	}

	/*
	*	子流程节点选择审批人	
	*/
	function showUserSelectOnSubFlow(actionName, settings){
		var url = contextPath + '/portal/share/user/selectApprover4Subflow.jsp?application=<%=applicationid%>';
		url += "&docid=" + settings.docid + "&instanceId=" + settings.instanceId+"&numberSetingType=" + settings.numberSetingType+"&instanceTotal=" + settings.instanceTotal+"&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		var jsonStr = jQuery("input[name='_subFlowApproverInfoAll']").val();
		//var nodeid = "123456789";
		var value = '';
		OBPM.dialog.show({
			width: 700,
			height:500,
			url: url,
			args: {value: value, readonly: settings.readonly,numberSetingType: settings.numberSetingType,instanceTotal: settings.instanceTotal,nodeid: settings.nextNodeId,jsonStr: jsonStr},
			//args: {"instanceTotal": 5,"nodeid": nodeid,"jsonStr": jsonStr},
			title: '{*[cn.myapps.core.workflow.user_select]*}',
			close: function(jsonObj) {
				if(jsonObj != null){
					//alert(JSON.stringify(jsonObj));
					jQuery("input[name='_subFlowApproverInfoAll']").val(JSON.stringify(jsonObj));
					//去除names属性
					var approverObj = JSON.parse(jsonObj.approver);
					var nameStr = "";
					//alert(approverObj.length);
					for(var i = 0; i < approverObj.length; i++){
						if(i != 0)nameStr += ',';
						nameStr += approverObj[i].names;
						delete approverObj[i].names;
					}
					jQuery("input[name="+ settings.textField +"]").val(nameStr);
					jsonObj.approver = approverObj;
					//alert("after delete ==> " + JSON.stringify(jsonObj));
					jQuery("input[name='_subFlowApproverInfo']").val(JSON.stringify(jsonObj));
				}
				//组装 json 字符串 并赋值到 一个name为“_subFlowApproverInfo”隐藏域里 作为参数提交到后台处理
			}
		});
	}
	var circulatorInfos =[];
	/**
	*指定抄送人
	*
	**/
	function selectCirculator(actionName, settings) {
		var url = contextPath + '/portal/share/user/selectCirculatorByFlow.jsp?application=<%=applicationid%>';
		url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		var valueField = document.getElementById(settings.valueField);
		var value = "";
		if (valueField){
			value = valueField.value;
		}
		OBPM.dialog.show({
			width: 610,
			height: 450,
			url: url,
			args: {
				// p1:当前窗口对象
				"parentObj" : window,
				// p2:存放userid的容器id
				"targetid" : "_circulatorInfo",
				// p3:存放username的容器id
				"receivername" : settings.textField,
				// p4:默认选中值, 格式为[userid1,userid2]
				"defValue": settings.defValue,
				//选择用户数
				"limitSum": settings.limitSum,
				//选择模式
				"selectMode":settings.selectMode
			},
			title: '{*[cn.myapps.core.workflow.user_select]*}',
			close: function(result) {
				selectFlag = true;
				var rtn = result;
				var field = document.getElementById(settings.textField);
				if (field) {
					if (rtn) {
						var rtnValue = '';
						var rtnText = '';
						for (var i = 0; i < rtn.length; i++) {
							rtnValue += '"'+ rtn[i].value + '",';
							rtnText += rtn[i].text + ";";
						}
						if(rtnValue.length>0){
							rtnValue = rtnValue.substring(0,rtnValue.length-1);
							rtnValue = '['+rtnValue+']';
							var circulatorInfo ='{circulator:'+rtnValue+'}';
							circulatorInfos[0] = circulatorInfo;
							//addCirculatorInfo(circulatorInfos,settings.nextNodeId,circulatorInfo);
							biuldCirculatorInfoStr();
						}
						var text = (rtnText == ''? rtnText:rtnText.substring(0,rtnText.length-1));
						field.value = text;
						field.title = text;
					}else {
						if (rtn == '') { // 清空
							field.value = '';
							field.title = '';
							circulatorInfos[0] ='';
							document.getElementById("_circulatorInfo").value = '';
						}
					}
				}
			}
		});
	}
	
	function addCirculatorInfo(Obj,nodeId,info){
		var falg =true;
		for(var i=0;i<Obj.length;i++){
			var tmp =Obj[i];
			if(tmp.indexOf(nodeId)>0){
				Obj[i] =info;
				falg = false;
				break;
			}
		}
		if(falg){
			Obj.push(info);
		}
	}
	
	function biuldCirculatorInfoStr(){
		var result ='';
		if(circulatorInfos.length>0){
			result+='['
		}
		for(var i=0;i<circulatorInfos.length;i++){
			result+=circulatorInfos[i]+',';
		}
		if(result.length>0){
			result = result.substring(0,result.length-1);
			result+=']';
			
			jQuery("input[name='_circulatorInfo']").val(result);
		}
		//alert("result==" +result);

		//alert(jQuery("input[name='_circulatorInfo']").val());
		
	}
	
	function checkIsSelectCirculator(){
		var obj = document.getElementById("_circulator");
		/* if(obj){
			if(obj.value.length<=0){
				alert("请选择抄送人！");
				return false;
			}
		} */
		
		return true;
	}
</script>
	</html>
</o:MultiLanguage>
