<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.constans.*"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%
String contextPath = request.getContextPath();
String language = (String)session.getAttribute("USERLANGUAGE");
String hostAddress = request.getScheme()+"://"+ request.getServerName() + ":"+ request.getServerPort() + request.getContextPath();
%>

<%@page import="cn.myapps.core.workflow.storage.definition.ejb.BillDefiVO"%>
<%@page import="cn.myapps.core.user.ejb.UserProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.core.superuser.ejb.SuperUserProcess"%>
<%@page import="cn.myapps.core.user.ejb.BaseUser"%>
<s:bean
	name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper"
	id="bdh"></s:bean>
<html>

<s:bean
	name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper"
	id="bdh"></s:bean>
<o:MultiLanguage>
<head>
<title>{*[Workflow_Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script src='<s:url value="/dwr/interface/FieldMappingUtil.js"/>'></script>
<script language="JavaScript">
   var contextPath = "<%=contextPath%>";
   cmdReturn = 'core/workflow/list.action';
   cmdSave = 'core/workflow/save.action';
   cmdEdit = 'core/workflow/edit.action';
   var currentId = "appletcontent";
   var isEditNow = false;
   var errorMessage = "";
   
function getMessage(){
	var $msgDivObj = jQuery("#msg").find(".msgSub");
	var msgType = $msgDivObj.attr("msgType");	//消息类型
	var content = $msgDivObj.html();
	if(jQuery.trim(content) != ""){
		if(msgType == "error"){
			document.WorkFlowDiagram.showErrorMessage(jQuery.trim(content));
		}else{
			document.WorkFlowDiagram.showSuccessMessage(jQuery.trim(content));
		}
	}
}
   
function ev_save() 
{
	document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
    formItem.submit();
} 

function tempsubject(sj){
	sj = decodeURIComponent(sj);
	document.getElementsByName('content.subject')[0].value=sj;
}

function deSelect(){
	 document.WorkFlowDiagram.deSelect();
}

function addManualNode()
{
	document.WorkFlowDiagram.addManualNode()
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addStartNode()
{
	document.WorkFlowDiagram.addStartNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addAbortNode()
{
	document.WorkFlowDiagram.addAbortNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addTerminateNode()
{
	document.WorkFlowDiagram.addTerminateNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addSuspendNode()
{
	document.WorkFlowDiagram.addSuspendNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}


function addCompleteNode()
{
	document.WorkFlowDiagram.addCompleteNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}


function addAutoNode()
{
	document.WorkFlowDiagram.addAutoNode();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addSubflow()
{
	document.WorkFlowDiagram.addSubFlow();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function addRelation()
{
	document.WorkFlowDiagram.addRelation();
	window.top.toThisHelpPage("application_module_workflows_info");
}

function removeElement()
{ 
  if(document.WorkFlowDiagram.isAssignBack()){
         alert("{*[It's a specified return-to node,can't delete]*}");
    	 return;
    }else if (isEditNow){
    	alert("{*[It's a node whom is editing,can't delete]*}");
    }else{
  		 document.WorkFlowDiagram.removeElement();
  }
}
function moveElement()
{
	
}

function hiddenDiv(){
	var isFirefox = navigator.userAgent.indexOf("Firefox")>0?true:false;
	//是火狐浏览器不给定位，因为定位后再返回会刷新flash。
	if(!isFirefox){
		document.getElementById("appletcontent").style.position="absolute";
		document.getElementById("appletcontent").style.top=-1000+"px";
	}
}
function showDiv(){
	document.getElementById("appletcontent").style.position="static";
}


function editSubflow() {
   	var url= contextPath + "/core/workflow/billflow/defi/addSubflow_parentFlowForm.jsp";
   	var actorAttr = new Object();
    var ieheight = document.body.clientHeight; 
   	var oldAttr = document.WorkFlowDiagram.getCurrToEditSubflow();
   	url = addParam(url, 's_module', '<s:property value="#parameters.s_module"/>');
   	url = addParam(url, 'application', '<s:property value="#parameters.application"/>');
   	if (oldAttr == null) 
   		return;
  	var attr = {};
  	attr.name = oldAttr.name;
  	attr.statelabel = oldAttr.statelabel;
  	attr.subFlowDefiType = oldAttr.subFlowDefiType;
  	attr.subflowid = oldAttr.subflowid;
  	attr.subflowname = oldAttr.subflowname;
  	attr.subflowScript = oldAttr.subflowScript;
  	attr.numberSetingContent = oldAttr.numberSetingContent;
  	attr.numberSetingType = oldAttr.numberSetingType;
  	attr.paramPassingType = oldAttr.paramPassingType;
  	attr.parentFlowFormId = oldAttr.parentFlowFormId;
  	attr.subFlowFormId = oldAttr.subFlowFormId;
  	attr.parentFlowFormName = oldAttr.parentFlowFormName;
  	attr.subFlowFormName = oldAttr.subFlowFormName;
  	attr.fieldMappingXML = oldAttr.fieldMappingXML;
  	attr.paramPassingScript = oldAttr.paramPassingScript;
  	attr.callback = oldAttr.callback;
  	attr.callbackScript = oldAttr.callbackScript;
  	attr.issplit = oldAttr.issplit;
  	attr.isgather = oldAttr.isgather;
  	attr.splitStartNode = oldAttr.splitStartNode;
  	attr.isToPerson = oldAttr.isToPerson;
  	hiddenDiv();
  	OBPM.dialog.show({
			//opener:window.parent.parent,
			width: 650,
			height: ieheight + 20,
			url: url,
			args: {"oldAttr":attr},
			title: '{*[Params.transfer.type]*}',
			close: function(actorAttr) {
				showDiv();
				if(actorAttr!=null){
					document.WorkFlowDiagram.editSubFlow(
					    	actorAttr.name,
					    	actorAttr.statelabel,
					    	actorAttr.subFlowDefiType,
					    	actorAttr.subflowid,
					    	actorAttr.subflowname,
					    	actorAttr.subflowScript,
					    	actorAttr.numberSetingContent,
					    	actorAttr.numberSetingType,
					    	actorAttr.paramPassingType,
					    	actorAttr.parentFlowFormId,
					    	actorAttr.subFlowFormId,
					    	actorAttr.parentFlowFormName,
					    	actorAttr.subFlowFormName,
					    	actorAttr.fieldMappingXML,
					    	actorAttr.paramPassingScript,
					    	actorAttr.callback,
					    	actorAttr.callbackScript,
					    	actorAttr.isgather,
					    	actorAttr.splitStartNode,
					    	actorAttr.isToPerson,
					    	actorAttr.issplit
					    	);
   				}
   				//window.top.toThisHelpPage("application_module_workflows_info");
			}
	});
}



/**
 * 给流程编辑器脚本调用
 * @param WorkFlowDiagram流程编辑器对象
 * @param fieldName
 * @param title
 * @return
 */
function flexOpenIsCriptEditor(str){
	str = decodeURIComponent(str);
	var strs = JSON.parse(str);
	var nodeId = strs.nodeId;
	var fieldName = strs.fieldName;
	var label = strs.label;
	var value = decodeURIComponent(document.WorkFlowDiagram.getScriptValueToFieldName(nodeId,fieldName));
	var url = contextPath+ '/core/macro/editor/iscripteditor/iscripteditorFlow.jsp';
	var t = window.top;
	hiddenDiv();
	OBPM.dialog.show({
	width : t.document.body.clientWidth-200,
	height : t.document.body.clientHeight-100,
	url : url,
	args : {'fieldName' : value,'label' : label,'feedbackMsg' : '','parent' : window},
	title : '{*[cn.myapps.core.workflow.script_editor]*}',
	close: function(result) {
		showDiv();
		if (result != null && result != 'undefined' && result != 'null')
		document.WorkFlowDiagram.setScriptValueToFieldName(nodeId,fieldName,result);
	}
	});
}

//编辑关联
function editRelation()
{
   	var url=contextPath + "/core/workflow/billflow/defi/addRelation_parentFlowForm.jsp";
   	var actorAttr = new Object();
   	var oldAttr = document.WorkFlowDiagram.getCurrToEditRelation();
    url = addParam(url, 's_module', '<s:property value="#parameters.s_module"/>');
   	if (oldAttr == null) return;
   	
  	var attr = {};
  	attr.name = oldAttr.name;
  	attr.condition = oldAttr.condition;
  	attr.action = oldAttr.action;
  	attr.validateScript = oldAttr.validateScript;
  	attr.filtercondition = oldAttr.filtercondition;
  	attr.editMode = oldAttr.editMode;
  	attr.processDescription = oldAttr.processDescription;
  	hiddenDiv();
  	OBPM.dialog.show({
			//opener:window.parent.parent,
			width: 600,
			height: 500,
			url: url,
			args: {"oldAttr":attr},
			title: '{*[Path_Condition_Script]*}',
			close: function(actorAttr) {
				showDiv();
				if(actorAttr!=null){
				     document.WorkFlowDiagram.editRelation(actorAttr.name,actorAttr.condition,actorAttr.action,
     								actorAttr.validateScript,actorAttr.filtercondition,actorAttr.editMode,actorAttr.processDescription);
   				}
			}
	});
}


function selectForm(){
	  var url = '<s:url value="/core/workflow/billflow/defi/selectForm.jsp" />';
	  url = addParam(url, 's_module', "<s:property value='#parameters.s_module'/>");
	  var obj = new Object();
	  var ieheight = document.body.clientHeight;
	  obj.fieldPermList = decodeURIComponent(document.WorkFlowDiagram.getFieldpermlist());
	  obj.activityPermList = decodeURIComponent(document.WorkFlowDiagram.getActivityPermList());
	  hiddenDiv();
	  OBPM.dialog.show({
				//opener:window.parent.parent,
				width: 700,
				height: ieheight + 20,
				url: url,
				args: {"pObj":obj},
				title: '{*[cn.myapps.core.workflow.select_form]*}',
				close: function(rtn) {
					showDiv();
					var formList = '';
					  var fieldpermlist = '';
					  
					  if (rtn.fieldPermList == null) {
						  rtn.fieldPermList = obj.fieldPermList;
					  }
					  
					  if (rtn.fieldPermList) {
					  	try {
					  		var list = eval(rtn.fieldPermList);
					  		
						  	for(var i=0; i<list.length; i++) {
						  		formList += list[i].formname + ",";
						  	}
						  	fieldpermlist = rtn.fieldPermList;
					  	} catch(ex) {
					  	}
					  } 
						 
					  if (formList) {
					  	formList = formList.substring(0, formList.lastIndexOf(","));
					  }
					  
					  var activity_FormList = '';
					  var activityPermList = '';

					  if (rtn.activityPermList == null) {
					  	  rtn.activityPermList = obj.activityPermList;
					  }

					  if (rtn.activityPermList) {
					  	try {
					  		var list = eval(rtn.activityPermList);
					  		
					  	  	for(var i=0; i<list.length; i++) {
					  	  		activity_FormList += list[i].formname + ",";
					  	  	}
					  	  	activityPermList = rtn.activityPermList;
					  	} catch(ex) {
					  	}
					  } 
					  	 
					  if (activity_FormList) {
					  	activity_FormList = activity_FormList.substring(0, activity_FormList.lastIndexOf(","));
					  }
					  formList = "字段:["+formList+"]操作按钮:["+activity_FormList+"]";
					  document.WorkFlowDiagram.editFieldpermlist(fieldpermlist,activityPermList,formList);
					  
				}
		});
	}


function ev_onsubmit() 
{
  	var modify = document.getElementsByName('modify')[0].checked;
  	var tempsubject = document.getElementsByName('content.subject')[0].value;
  	if (!modify) {
  		var errorMessage = decodeURIComponent(document.WorkFlowDiagram.informationCheck());
  		if(errorMessage != "" && errorMessage != null){
  			document.WorkFlowDiagram.showErrorMessage(errorMessage);
  			return;
  		}
  		document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
	}
  	if(tempsubject == ''){
  		document.WorkFlowDiagram.showErrorMessage('{*[page.workflow.subject.notexist]*}');
		return false;
	}
  	document.forms[0].action = '<s:url action="save"></s:url>';
	document.forms[0].submit();
}

function ev_switchsheet(id) {
/* 	document.getElementById('appletcontent').style.display="none"; */
	var isChrome = navigator.userAgent.indexOf("Chrome")>0?true:false;
	if(isChrome){
		document.getElementById('xmlcontent').style.display="none";
		document.getElementById(id).style.display = "";
		if (id != currentId)
		if (id == 'appletcontent') {
			var xml = document.getElementsByName('content.flow')[0].value;
			document.WorkFlowDiagram.loadXML(xml);
			document.getElementsByName('modify')[0].checked = false;
			document.getElementById("appletcontent").style.position="static";
			document.getElementsByName('content.flow')[0].style.color = 'gray';
		} else {
			document.getElementById("appletcontent").style.position="absolute";
			document.getElementById("appletcontent").style.top=-1000+"px";
			document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
			errorMessage = "";
		}
		currentId = id;	
	}else{
		document.getElementById('appletcontent').style.display="none";
		document.getElementById('xmlcontent').style.display="none";
		document.getElementById(id).style.display = "";
		if (id != currentId)
		if (id == 'appletcontent') {
			var xml = document.getElementsByName('content.flow')[0].value;
			document.WorkFlowDiagram.loadXML(xml);
			document.getElementsByName('modify')[0].checked = false;
			document.getElementsByName('content.flow')[0].style.color = 'gray';
		} else {
			document.getElementsByName('content.flow')[0].value = document.WorkFlowDiagram.saveToXML();
			errorMessage = "";
		}
		currentId = id;	
	}
}

/* function ev_switchsheet(id) {
	document.getElementById('appletcontent').style.display="none";
	document.getElementById('xmlcontent').style.display="none";
	document.getElementById(id).style.display = "";
	if (id != currentId)
	if (id == 'appletcontent') {
		var xml = document.getElementsByName('content.flow')[0].value;
		document.WorkFlowDiagram.loadXML(xml);
		document.getElementsByName('modify')[0].checked = false;
		document.getElementsByName('content.flow')[0].style.color = 'gray';
	} else {
		document.getElementsByName('content.flow')[0].value = document.WorkFlowDiagram.saveToXML();
		errorMessage = "";
	}
	currentId = id;	
} */

function textAlert(k){
	alert(k);
}

function ev_init() {
	var height = document.body.clientHeight;
}



function checkJRE(){
	 try{   
	    if(document.getElementById('workflowApplet').isActive()){
			//alert('yes');
	    }   
	    }catch(error){   
	        if(confirm('您的浏览器暂不支持此控件,是否要下载安装')){
	         window.open('http://www.java.com/zh_CN/');
	        }           
	    } 
	} 
	
jQuery(document).ready(function(){
	ev_init();
	window.top.toThisHelpPage("application_module_workflows_info");

	jQuery(window).resize(function(){
		resize_workflowApplet();
	});
	jQuery("table[name=test]").attr("height",document.body.clientHeight-50);
	
});

function resize_workflowApplet(){
	var iewidth = jQuery("body").width()-100;
	var ieheight=document.body.clientHeight-150;
	jQuery("#workflowApplet").attr("width",iewidth);
	jQuery("#workflowApplet").attr("height",ieheight);
	jQuery("table[name=test]").attr("height",document.body.clientHeight-50);
}
/* 签入
*/
function ev_checkin(){
	document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
	document.forms[0].action='<s:url action="checkin"></s:url>';
	document.forms[0].submit();
}
/*
* 签出
*/
function ev_checkout(){
	document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
	document.forms[0].action='<s:url action="checkout"></s:url>';
	document.forms[0].submit();
}

   function toJson() {
       var limittimecount = document.WorkFlowDiagram.getLimittimecount();
       var timeunit = document.WorkFlowDiagram.getTimeunit();
       var isnotifysuperior = document.WorkFlowDiagram.getIsnotifysuperior();
       var responsibleType = document.WorkFlowDiagram.getResponsibleType();
       var overridetimeeditmode = document.WorkFlowDiagram.getOverridetimeEditMode();
       var overridetimeScript = decodeURIComponent(document.WorkFlowDiagram.getOverrideTimeLimitScript());

       var map = {};
       var notificationTypeArray = document.WorkFlowDiagram.getNotificationTypeArray();
       for (var i = 0; i < notificationTypeArray.length; i++) {
           // 创建提醒,设置发送方式
           var notificationType = notificationTypeArray[i];
           var notification = createNotification(notificationType);
           if (!notification) {
               continue;
           }
           map[notificationType] = notification;
           // 根据不同的类型配置属性
           if (notificationType == 'send') {
               var receiverArray = document.WorkFlowDiagram.getSendReceiver();
               // 接收者处理
               notification.receiverTypes = receiverArray;
           } else if (notificationType == 'arrive') {
               // 短信审批
               notification.smsApproval = document.WorkFlowDiagram.getSmsApproval();
           } else if (notificationType == 'reject') {
               notification.responsibleType = responsibleType;
           } else if (notificationType == 'overdue') {
               notification.limittimecount = limittimecount;
               notification.timeunit = timeunit;
               notification.isnotifysuperior = document.WorkFlowDiagram.getCheckBoxValue2();
               notification.editMode = overridetimeeditmode;
               notification.limittimeScript = overridetimeScript;
           } else if (notificationType == 'reminder') {
        	   notification.responsibleType = responsibleType;
           }
           // 设置模板
           if(notificationType != 'reminder') {
           		notification.template = document.WorkFlowDiagram.getTemplate(notificationType);
           }
       }
       return jQuery.json2Str(map);
   }

   function createNotification(type) {//新增了一个参数，type ，用来标示是 那个一种发送方式里面的 方法， 例如 “发送”，方式里的发送到手机方法
       var sendModeCodes = document.WorkFlowDiagram.getCheckBoxValue(type);
       if (sendModeCodes.length > 0) {
           var notification = new Object();
           notification.sendModeCodes = sendModeCodes;
           return notification;
       } else {
           return null;
       }
   }

jQuery(document).ready(function(){
	var ieheight = document.body.clientHeight;
    var iewidth = document.body.offsetWidth;
    var hHeight=ieheight-25;
    if(navigator.userAgent.indexOf("MSIE")<=0) {
    	hHeight=hHeight-25;
	}
    jQuery("#appletcontent").width(iewidth);
    if(hHeight<300){
    	 jQuery("#appletcontent").height(300);
    }else{
    	 jQuery("#appletcontent").height(hHeight);
    }
	jQuery(window).resize(function(){
		var ieheight = document.body.clientHeight;
        var iewidth = document.body.offsetWidth;
        var hHeight=ieheight-80;
        if(navigator.userAgent.indexOf("MSIE")<=0) {
        	hHeight=hHeight-25;
		}
        jQuery("#appletcontent").width(iewidth);
        if(hHeight<300){
        	 jQuery("#appletcontent").height(300);
        }else{
        	 jQuery("#appletcontent").height(hHeight);
        }
	});
});

function flexToParse(text){
	text = decodeURIComponent(text);
	var notificationStrategyJSON = HTMLDencode(text);
	return JSON.parse(notificationStrategyJSON);
}

function flexToJson2(array){
	return jQuery.json2Str(array);
}

</script>
</head>
<body id="application_module_workflows_info" class="contentBody">
<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr>
		<td class="nav-s-td" style="padding-left: 10px;">{*[Workflow_Info]*}</td>
		<td class="nav-s-td" align="right">
		<table align="right" width="220" border=0 cellpadding="0" cellspacing="0">
			<tr>
			<s:if test="checkoutConfig == 'true'">
				<s:if test="content.id !=null && content.id !='' && !content.checkout">
				<!-- 签出按钮 -->
				<td align="left">
					<button type="button" class="button-image" style="width:50px" onClick="ev_checkout()"><img
						src="<s:url value="/resource/imgnew/act/checkout.png" />"
						align="top">{*[core.dynaform.form.checkout]*}</button>
					</td>
				</s:if>
				<s:elseif test="content.id !=null && content.id !='' && content.checkout && #session['USER'].id == content.checkoutHandler">
				<!-- 签入按钮 -->
				<td align="left">
					<button type="button" class="button-image" style="width:50px" onClick="ev_checkin()"><img
						src="<s:url value="/resource/imgnew/act/checkin.png" />"
						align="top">{*[core.dynaform.form.checkin]*}</button>
					</td>
				</s:elseif>
				</s:if>
				
				<s:if test="checkoutConfig == 'true'">
				<s:if test="(content.checkout && #session['USER'].id == content.checkoutHandler) || (!content.checkout && content.checkoutHandler == null)">
				<!-- 签出 -->
				<td align="left">
					<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="ev_onsubmit()">
					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
						align="top">{*[Save]*}</button>
					</td>
				</s:if>
				<s:elseif test="content.checkout && #session['USER'].id != content.checkoutHandler">
				<!-- 签入-->
				<td align="left">
					<button type="button" id="save_btn" style="width:50px" class="button-image" disabled="disabled" onClick="ev_onsubmit();">
					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
						align="top">{*[Save]*}</button>
					</td>
				</s:elseif>
				<s:if test="!content.checkout && content.checkoutHandler == '' ">
							<!-- 没有签出-->
							<td align="left">
								<button type="button" id="save_btn" style="width:50px" class="button-image"  onClick="alert('{*[message.update.before.checkout]*}')">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
				</s:if>
				</s:if>
				<s:else>
					<td align="left">
					<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="ev_onsubmit()">
					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
						align="top">{*[Save]*}</button>
					</td>
				</s:else>
				<td valign="top">
				<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div id="msg" class="transparent_message" style="display: none;">
	<s:if test="hasFieldErrors()">
		<div class="msgSub" msgType="error">
			<s:iterator value="fieldErrors">
				*<s:property value="value[0]" />
			</s:iterator>
		</div>
	</s:if>
	<s:elseif test="hasActionMessages()">
		<div class="msgSub" msgType="notice">
			<s:iterator value="actionMessages">
				<s:property />
			</s:iterator>
		</div>
	</s:elseif>
</div>
<div id="contentMainDiv" class="contentMainDiv">
	<%
		BillDefiVO contentVO = (BillDefiVO)request.getAttribute("content");
	    UserProcess userProcess = (UserProcess)ProcessFactory.createProcess(UserProcess.class);
	    SuperUserProcess superUserProcess = (SuperUserProcess)ProcessFactory.createProcess(SuperUserProcess.class);
		BaseUser user = null;
			user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
			String userid = user.getId();
			String username = user.getName();
			//if(contentVO!=null && contentVO.getAuthorname()!=null && !contentVO.getAuthorname().equals(userid)){
			//	userid = contentVO.getAuthorname();
			//	if(superUserProcess.doView(userid)!=null){
			//		username = ((BaseUser)superUserProcess.doView(userid)).getName();
			//	}else if(userProcess.doView(userid)!=null){
			//		username = ((BaseUser)userProcess.doView(userid)).getName();
		//		}
		//	}
			
	%>
		<s:form action="save" method="post" id="formItem"
			onsubmit="ev_onsubmit();" theme="simple">
			<input type="text" id = "flexmulti" name = "flexmulti" style="display: none" />
			<input type="hidden" name="s_module"
				value="<s:property value='#parameters.s_module'/>">
			<input type="hidden" name="_moduleid"
				value="<s:property value='#parameters.s_module'/>">
			<s:hidden name='content.checkout' />
			<s:hidden name="content.checkoutHandler" />
			<s:hidden name="sm_subject" value="%{#parameters.sm_subject}" />
			<%@include file="/common/page.jsp"%>
			<s:hidden cssClass="input-cmd" id="content.subject" label="{*[Subject]*}" name="content.subject" theme="simple" />
			<s:hidden cssClass="input-cmd"  id="authorname" value="%{#session.USER.name}" theme="simple" />
			<s:hidden cssClass="input-cmd"  name="content.authorname" value="%{#session.USER.id}" theme="simple" />
			<s:if test="content.id">
			<s:date name="content.lastmodify" format="yyyy/MM/dd"/>
			</s:if>
			<div id="xmlcontent" style="display: none">
				<table>
					<tr>
						<td class="commFont">{*[Modify]*}: <s:checkbox name="modify"
							theme="simple"
							onclick="document.getElementsByName('content.flow')[0].readOnly = !this.checked;document.getElementsByName('content.flow')[0].style.color = this.checked ? 'black' : 'gray'" /></td>
					</tr>
					<tr>
						<td><s:textarea id="flow_container" name="content.flow"
							readonly="true" cssStyle="width:700px;height:350px;color:gray">
						</s:textarea></td>
					</tr>
				</table>
			</div>
			<div id="appletcontent">
			<Script language="JavaScript">
            var ieheight = document.body.clientHeight;
            var iewidth = document.body.offsetWidth;
            var objectStyle="";
            var wWidth = iewidth;
            var hHeight=ieheight-80;
            if(navigator.userAgent.indexOf("MSIE")<=0) {
            	objectStyle="style='display:block;'";
            	hHeight=hHeight-25;
			}
            var canvasWidth = wWidth;
            var canvasHeight=hHeight;
            document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
            document.write('id="WorkFlowDiagram" '+objectStyle+' width="100%" height="100%"');
            document.write('codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">');
            document.write('<param name="movie" value="../../../common/flash/WorkFlowDiagram.swf" />');
            document.write('<param name="quality" value="high" />');
            document.write('<param name="bgcolor" value="#ffffff" />');
            document.write('<param name="FlashVars" value="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'&hostAddress=<%=hostAddress%>&applicationid=<s:property value="#parameters.application"/>&moduleid=<s:property value='#parameters.s_module'/>&userlanguage=<%=language%>&usbkey=<s:property value='#bdh.usbEnable()'/>"');
            document.write('<param name="allowScriptAccess" value="sameDomain" />');
            document.write('<embed src="../../../common/flash/WorkFlowDiagram.swf" quality="high" bgcolor="#ffffff" ');
            document.write('width="100%" height="100%" name="WorkFlowDiagram" align="middle"');
            document.write('play="true"');
            document.write('loop="false" ');
            document.write('quality="high" ');
            document.write('FlashVars="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'&hostAddress=<%=hostAddress%>&applicationid=<s:property value="#parameters.application"/>&moduleid=<s:property value='#parameters.s_module'/>&userlanguage=<%=language%>&usbkey=<s:property value='#bdh.usbEnable()'/>" ');
            document.write('allowScriptAccess="sameDomain" ');
            document.write('type="application/x-shockwave-flash" ');
            document.write('pluginspage="http://www.adobe.com/go/getflashplayer">');
            document.write('</embed>');
            document.write('</object>')
            
            function getXML(){
            	var xml = document.getElementsByName('content.flow')[0].value;
            	return xml;
            }
            function getParams(){
                var subject = document.getElementsByName('content.subject')[0].value;
				var authorname = document.getElementById('authorname').value;
				var str ='{"subject":"'+subject+'","authorname":"'+authorname+'"}';
				return str;
            }
            </Script>
			</div>
		</s:form>
	</div>
	</body>
</o:MultiLanguage>
</html>
