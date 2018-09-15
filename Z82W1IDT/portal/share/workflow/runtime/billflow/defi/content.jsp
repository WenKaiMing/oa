<%@page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.FormProcess"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.constans.*"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.core.user.ejb.*"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page
	import="cn.myapps.core.workflow.storage.definition.ejb.BillDefiVO"%>
<%
	String hostAddress = "http://" + request.getServerName() + ":"
			+ request.getServerPort() + request.getContextPath();
	String language = (String)session.getAttribute("USERLANGUAGE");
	
	String formId = request.getParameter("_formid");
	String moduleId = "";
	if(formId!=null && formId.trim().length()>0){
		FormProcess fp = (FormProcess)ProcessFactory.createProcess(FormProcess.class);
		Form form = (Form)fp.doView(formId);
		if(form !=null){
			moduleId = form.getModule().getId();
		}
	}
%>

<%@page import="cn.myapps.core.superuser.ejb.SuperUserProcess"%><html>
<s:bean
	name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper"
	id="bdh"></s:bean>
<o:MultiLanguage>
	<head>
	<title>{*[Workflow_Info]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<script src="<s:url value='/portal/share/script/check.js'/>"></script>
	<script src="<s:url value='/portal/share/script/util.js'/>"></script>
	<script language="JavaScript">
   var contextPath = "<s:url value='/'/>";
   var moduleId = "<%=moduleId%>";
  var typeName= '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
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
    document.formItem.elements['content.flow'].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
    formItem.submit();
} 

function deSelect(){
	 document.WorkFlowDiagram.deSelect();
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
	var url = contextPath+ '/portal/share/workflow/runtime/billflow/defi/iscripteditorFlow.jsp';
	var t = window.top;
	hiddenDiv();
	OBPM.dialog.show({
	width : t.document.body.clientWidth-200,
	height : t.document.body.clientHeight-100,
	url : url,
	args : {'fieldName' : value,'label' : label,'feedbackMsg' : '','parent' : window},
	title : '{*[cn.myapps.core.resource.script_editor]*}',
	close: function(result) {
		showDiv();
		if (result != null && result != 'undefined' && result != 'null')
		document.WorkFlowDiagram.setScriptValueToFieldName(nodeId,fieldName,result);
	}
	});
}

   function toJson() {
       var limittimecount = document.WorkFlowDiagram.getLimittimecount();
       var timeunit = document.WorkFlowDiagram.getTimeunit();
       var isnotifysuperior = document.WorkFlowDiagram.getIsnotifysuperior();
       var responsibleType = document.WorkFlowDiagram.getResponsibleType();
       var overridetimeeditmode = document.WorkFlowDiagram.getOverridetimeEditMode();
       var overridetimeScript = document.WorkFlowDiagram.getOverrideTimeLimitScript();

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
           }
           // 设置模板
           notification.template = document.WorkFlowDiagram.getTemplate(notificationType);
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



  function flexToParse(text){
	text = decodeURIComponent(text);
	var notificationStrategyJSON = HTMLDencode(text);
	return JSON.parse(notificationStrategyJSON);
}

 function flexToJson2(array){
	return jQuery.json2Str(array);
}

function selectForm(){
	  var url = '<s:url value="/portal/share/workflow/runtime/billflow/defi/selectForm.jsp" />';
	  url = addParam(url, 's_module', moduleId);
	  var obj = new Object();
	  var ieheight = document.body.clientHeight; 
	  obj.fieldPermList = decodeURIComponent(document.WorkFlowDiagram.getFieldpermlist());
	  hiddenDiv();
	  OBPM.dialog.show({
				opener:window.parent.parent,
				width: 700,
				height: ieheight + 30,
				url: url,
				args: {"pObj":obj},
				title: '{*[cn.myapps.core.workflow.select_form]*}',
				close: function(rtn) {
					showDiv();
					var formList = '';
					  var fieldpermlist = '';
					  
					  if (rtn == null) {
					  	rtn = obj.fieldPermList;
					  }
					  
					  if (rtn) {
					  	try {
					  		var list = eval(rtn);
						  	for(var i=0; i<list.length; i++) {
						  		formList += list[i].formname + ",";
						  	}
						  	fieldpermlist = rtn;
					  	} catch(ex) {
					  	}
					  } 
					  
					  if (formList) {
					  	formList = formList.substring(0, formList.lastIndexOf(","));
					  }
					  document.WorkFlowDiagram.editFieldpermlist(fieldpermlist,formList);
				}
		});
	}


function editSubflow() {
   	var url= contextPath + "/portal/share/workflow/runtime/billflow/defi/addSubflow_parentFlowForm.jsp";
   	var actorAttr = new Object();
   	var ieheight = document.body.clientHeight; 
   	var oldAttr = document.WorkFlowDiagram.getCurrToEditSubflow();
   	url = addParam(url, 's_module', moduleId);
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
		opener:window.parent.parent,
		width: 650,
		height: ieheight + 30,
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
		}
});
}


//编辑关联
function editRelation()
{
   	var url=contextPath + "/portal/share/workflow/runtime/billflow/defi/addRelation_parentFlowForm.jsp";
   	var actorAttr = new Object();
   	var oldAttr = document.WorkFlowDiagram.getCurrToEditRelation();
    url = addParam(url, 's_module', moduleId);
    url = addParam(url, 'formId', '<%=formId%>');
    
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
			opener:window.parent.parent,
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

function ev_onsubmit() 
{	var errorMessage = document.WorkFlowDiagram.informationCheck();
	if(errorMessage != "" && errorMessage != null){
		document.WorkFlowDiagram.showErrorMessage(errorMessage);
		return;
	}
	document.getElementsByName('content.flow')[0].value = decodeURIComponent(document.WorkFlowDiagram.saveToXML());
  	if(errorMessage !=""){
  		document.WorkFlowDiagram.showErrorMessage(errorMessage);
		errorMessage="";
		return;
	}
  	document.forms[0].action = '<s:url action="save"></s:url>';
  	formItem.submit();
}

function resize_workflowApplet(){
	var iewidth = jQuery("body").width()-100;
	var ieheight=document.body.clientHeight-150;
	jQuery("#workflowApplet").attr("width",iewidth);
	jQuery("#workflowApplet").attr("height",ieheight);
	jQuery("table[name=test]").attr("height",document.body.clientHeight-50);
	jQuery("#appletcontent").attr("width",iewidth-50);
	window.location.reload();
}

function exit(){
	OBPM.dialog.doClearUpload();
}

window.onload = function(){
	showPromptMsg();
}

/**
 * 显示提示信息
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function showPromptMsg(){
	var funName = typeName;
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		try{
			eval("do" + funName + "(msg);");
		} catch(ex) {
		}
	}
}

function doAlert(msg){
	alert(msg);
}
</script>
	</head>
	<body id="application_module_workflows_info" class="contentBody"
		onresize="resize_workflowApplet()">
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td class="nav-s-td" style="padding-left: 10px;">{*[Workflow_Info]*}</td>
			<td class="nav-s-td" align="right">
			<table align="right" width="120" border=0 cellpadding="0"
				cellspacing="0">
				<tr>
					<td valign="top">
					<button type="button" class="button-image" onClick="ev_onsubmit();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					</td>
					<td valign="top">
					<button type="button" class="button-image" onClick="exit()"><img
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
				*<s:property value="value[0]" />&nbsp;&nbsp;
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
		BillDefiVO contentVO = (BillDefiVO) request
					.getAttribute("content");
			BaseUser user = null;
			user = ((WebUser) request.getSession().getAttribute(
					"FRONT_USER"));
			UserProcess userProcess = (UserProcess) ProcessFactory
					.createProcess(UserProcess.class);
			SuperUserProcess superUserProcess = (SuperUserProcess) ProcessFactory
					.createProcess(SuperUserProcess.class);
			if (contentVO.getAuthorname() != null) {
				user = (UserVO) userProcess.doView(contentVO
						.getAuthorname());
			}
			if (user == null) {
				user = (BaseUser) superUserProcess.doView(contentVO
						.getAuthorname());
			}
			String username = user.getName();
			String userid = user.getId();
	%>
	<table width="100%" name="test">
		<s:form action="save" method="post" id="formItem"
			onsubmit="ev_onsubmit();" theme="simple">
			<input type="hidden" name="s_module"
				value="<%=moduleId %>">
			<input type="hidden" name="_moduleid"
				value="<%=moduleId %>">
			<input type="hidden" name="_docid"
				value="<s:property value='#parameters._docid'/>">
			<input type="hidden" name="_stateId"
				value="<s:property value='#parameters._stateId'/>">
			<input type="hidden" name="disableFlowNode"
				value="<s:property value='#parameters.disableFlowNode'/>">
			<input type="hidden" name="changeFlowCc"
				value="<s:property value='#parameters.changeFlowCc'/>">
			<input type="hidden" name="changeFlowOperator"
				value="<s:property value='#parameters.changeFlowOperator'/>">
			<s:textarea name="message" value="%{#request.message.content}"	cssStyle="display:none" />
			<%@include file="/common/page.jsp"%>
			<tr style="display: none">
				<td colspan="2">
				<table>
					<tr>
						<td>
						<table>
							<tr align="left" style="display: none">
								<td class="commFont commLabel">
								<div id="subject">{*[Subject]*}:</div>
								</td>
								<td><s:label label="{*[Subject]*}" name="content.subject"
									theme="simple" /> <s:hidden name="content.subject" /></td>
								<td class="commFont commLabel">{*[Author]*}:</td>
								<td><input type="hidden" name="content.authorname"
									value="<%=userid%>" /> <s:label
									label="{*[Workflow author]*}" 
									disabled="true" theme="simple" /><input type="hidden" name="authorname"
									value="<%=username%>" /></td>
								<s:if test="content.id">
									<td class="commFont commLabel">{*[LastModify]*}:</td>
									<td><s:date name="content.lastmodify" format="yyyy/MM/dd" /></td>
								</s:if>
								<!-- 
								<td>
								<button type="button" class="button-add" onClick="editElement();"><img
									src="<s:url value="/resource/imgv2/back/workflow/edit.gif"/>"
									alt="{*[Edit]*}"></button>
								</td>
								 -->
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr id="xmlcontent" style="display: none" height="350">
				<td colspan="2"><s:textarea id="flow_container"
					name="content.flow" readonly="true"
					cssStyle="width:700px;height:350px;color:gray">
				</s:textarea></td>
			</tr>
			<tr>
				<td>
				<table>
					<tr>
						<td valign="top"></td>
						<td id="editFlowContent">
						<div id="appletcontent">
						<Script language="JavaScript">
			 var ieheight = document.body.clientHeight;
            var iewidth = document.body.offsetWidth;
            var wWidth = iewidth-50;
            var hHeight=ieheight-50;
            var canvasWidth = wWidth;
            var canvasHeight=hHeight;
            document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
            document.write('id="WorkFlowDiagram" width="'+wWidth+'" height="'+hHeight+'"');
            document.write('codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">');
            document.write('<param name="movie" value="WorkFlowDiagram.swf" />');
            document.write('<param name="quality" value="high" />');
            document.write('<param name="bgcolor" value="#ffffff" />');
            document.write('<param name="FlashVars" value="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'&hostAddress=<%=hostAddress%>&applicationid=<s:property value="#parameters.application"/>&moduleid=<%=moduleId%>&&disableFlowNode=<s:property value='#parameters.disableFlowNode'/>&changeFlowCc=<s:property value='#parameters.changeFlowCc'/>&changeFlowOperator=<s:property value='#parameters.changeFlowOperator'/>&userlanguage=<%=language%>&usbkey=<s:property value='#bdh.usbEnable()'/>"');
            document.write('<param name="allowScriptAccess" value="sameDomain" />');
            document.write('<embed src="WorkFlowDiagram.swf" quality="high" bgcolor="#ffffff"');
            document.write('width="'+wWidth+'" height="'+hHeight+'" name="WorkFlowDiagram" align="middle"');
            document.write('play="true"');
            document.write('loop="false"');
            document.write('quality="high"');
            document.write('allowScriptAccess="sameDomain"');
            document.write('FlashVars="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'&hostAddress=<%=hostAddress%>&applicationid=<s:property value="#parameters.application"/>&moduleid=<%=moduleId%>&disableFlowNode=<s:property value='#parameters.disableFlowNode'/>&changeFlowCc=<s:property value='#parameters.changeFlowCc'/>&changeFlowOperator=<s:property value='#parameters.changeFlowOperator'/>&userlanguage=<%=language%>&usbkey=<s:property value='#bdh.usbEnable()'/>" ');
            document.write('type="application/x-shockwave-flash"');
            document.write('pluginspage="http://www.adobe.com/go/getflashplayer">');
            document.write('</embed>');
            document.write('</object>');
            
            function getXML(){
            	var xml = document.getElementsByName('content.flow')[0].value;
            	return xml;
            }
            function getParams(){
                var subject = document.getElementsByName('content.subject')[0].value;
				var authorname = document.getElementsByName('authorname')[0].value;
				var str ='{"subject":"'+subject+'","authorname":"'+authorname+'","front":true}';
				return str;
            }
            </Script></div></td>
					</tr>
				</table>
				</td>
			</tr>

		</s:form>
	</table>
	</div>
	</body>
</o:MultiLanguage>
</html>
