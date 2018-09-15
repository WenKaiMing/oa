<%@ page pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess"%>
<%@page
	import="cn.myapps.core.dynaform.document.ejb.DocumentProcessBean"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<s:bean name="cn.myapps.core.dynaform.activity.action.ActivityUtil"
	id="actUtil" />
<%@page import="cn.myapps.util.StringUtil"%>
<%
	String contextPath = request.getContextPath();
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String docid = request.getParameter("_docid");
	WebUser webUser = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	Form form = FormHelper.get_FormById(request.getParameter("formid"));
	//String fshowtype = request.getParameter("fshowtype");
	//Activity flowAct = form.getActivityByType(ActivityType.WORKFLOW_PROCESS);
	//String fshowtype=flowAct.getFlowShowType();
	//String moduleid = request.getParameter("moduleid");
	String moduleid = form.getModule().getId();
	request.setAttribute("moduleid",moduleid);
	ParamsTable params = (ParamsTable) session.getAttribute("params");
	if(params == null)
		params = new ParamsTable();
	Document tempDoc = form.createDocument(params, webUser);
	webUser.putToTmpspace(docid, tempDoc);
	
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
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
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
var back;

//用户确定事件
function doConfirm(){
	//prepareReturn();
	var data = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()),true);	
	var selectFlow = data['selectFlow'];
	var nextids = data['_nextids'];
	var principal = data['submitTo'];
	if (isNullUser) {
		alert("请选择接受人");
		return;
	}
	if (!selectFlow || selectFlow.length < 0) {
		alert("请选择流程");
		return;
	}
	if (nextids && nextids.length > 0) {
		OBPM.dialog.doReturn(jQuery.param(data,true));
	} else {
		alert("请选择一项操作");
	}
}
//返回前参数的准备
function prepareReturn(){
	submitTo=submitTo.substring(0,submitTo.length-1);
	//获取节点的name集合
	var nextNodes=document.getElementsByName("_nextids");
	//获取节点是否指点审批人isToPerson集合
	var isToPersons=document.getElementsByName("isToPerson");
	var elength=nextNodes.length;
	if (back != null) {
		elength=nextNodes.length-1;
	}
	for(var i=0;i<elength;i++){
		if(isToPersons[i].checked && nextNodes[i].checked){
			if(document.getElementById("input_"+i).value=="" || document.getElementById("input_"+i).value==null){
				isNullUser=true;
			}else{
				isNullUser=false;
			}
			if(submitTo.length>0){
				var start=submitTo.indexOf(nextNodes[i].value)+nextNodes[i].value.length+16;
				submitTo=submitTo.substr(0,start)+"true"+submitTo.substr(start+4,start.length);
			}
		}
	}
	if(submitTo.length>0){
		submitTo="["+submitTo+"]";
		document.getElementById("submitTo").value=submitTo;
	}
}

function selectUser(settings) {
	var url = contextPath + '/portal/share/user/selectbydept.jsp';
	var valueField = document.getElementById("input_0");
	var value = "";
	if (valueField){
		value = valueField.value;
	}
	OBPM.dialog.show({
		width: 300,
		height: 400,
		url: url,
		args: {value: value, readonly: settings.readonly},
		title: '{*[cn.myapps.core.workflow.user_select]*}',
		close: function(result) {
			var rtn = result;
			var field = document.getElementById("input_0");
			if (field) {
				if (rtn) {
					isToPerson = true;
					if (rtn[0] && rtn.length > 0) {
						var rtnValue = '';
						var rtnText = '';
						//userid多个以","分隔
						var selectedNode=document.getElementById("input_0");
						//用户选择曾经选过的节点
						var start=submitTo.indexOf(settings.nextNodeId)+settings.nextNodeId.length+34;
						if(submitTo.indexOf(settings.nextNodeId)>0){
							var strfront=submitTo.substr(0,start);
							var strtemp=submitTo.substr(start+1,submitTo.length);
							var strfoot=strtemp.substr(strtemp.indexOf("]",0)-1,strtemp.length);
							submitTo=strfront;
							for (var i = 0; i < rtn.length; i++) {
								rtnValue += rtn[i].value + ";";
								rtnText += rtn[i].text + ";";
								submitTo+="'"+rtn[i].value+"',";
							}
							submitTo=submitTo.substring(0,submitTo.length-2);
							submitTo+=strfoot;
						}
						else{
							submitTo+="{\"nodeid\":'"+settings.nextNodeId+"',\"isToPerson\":'fals',\"userids\":\"[";
							var userids="";
							for (var i = 0; i < rtn.length; i++) {
								rtnValue += rtn[i].value + ";";
								rtnText += rtn[i].text + ";";
								userids+="'"+rtn[i].value+"',";
							}
							userids=userids.substring(0,userids.length-1); 
							submitTo+=userids+"]\"},";
						}
						valueField.value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
						field.value = rtnText.substring(0, rtnText.lastIndexOf(";"));
					}
				} else {
					if (rtn == '') { // 清空
						field.value = '';
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

function chooseWorkFlow(obj){
	if(obj && (obj.value == '' || obj.value == null)){
		return;
	}
	var docid='<%=docid%>';
	var moduleid='<%=moduleid%>';
	document.getElementById("nodelist").style.display="";
	DWREngine.setAsync(false);
	StateMachineUtil.getFirstNodeListByDocidAndFlowid(docid,obj.value,'startNode',function(str){var func=eval(str)});
}

function showSelectUserDiv(obj){
	var ob=document.getElementById("opra_"+obj.id);
	if(ob.style.display=="none"){
		ob.style.display="";
	}else{
		ob.style.display="none";
	}
}

function init(){
	var scrW = document.body.scrollWidth;
	var scrH = document.body.scrollHeight;
	if(scrW < 700 || scrH < 400) return;
	OBPM.dialog.resize(scrW, scrH+70);
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
	<body onload="init()">
	<table width="100%" height="100%">
		<tr>
			<td align="center">
			<input type="button" name="confirm" value="{*[Confirm]*}" onClick="doConfirm()" />
			<input type="button" name="cancel" value="{*[Cancel]*}"
				onClick="OBPM.dialog.doExit()" /></td>
		</tr>
		<tr>
			<td valign="top" height="100%" align="center"><s:form
				id="flowprocess" name="flowprocess" action="" method="post"
				theme="simple" >
				<fieldset> 
	    			<legend>{*[cn.myapps.core.workflow.switch]*}</legend> 
					<table width="90%" style="margin: 0px; padding: 0px" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">{*[cn.myapps.core.workflow.choose_start_workflow]*}：</td>
							<td align="left"><s:select id="selectFlow"
								onchange="chooseWorkFlow(this)" cssStyle="width:200px;"
								emptyOption="false" name="selectFlow"
								list="#actUtil.getFlowsByModuleid(#request.moduleid)" /></td>
							<td></td>
						</tr>
						<tr id="nodelist" style="display:none">
							<td align="right">{*[cn.myapps.core.workflow.commit_to]*}：</td>
							<td align="left" colspan="2"><div class="commFont"  id="startNode"></div></td>
							<s:hidden id="submitTo" name="submitTo" value=""></s:hidden>
						</tr>
						<tr>
							<td  colspan="3"><div class="commFont"  id="flowlist"></div></td>
						</tr>
					</table>
				</fieldset>
			</s:form></td>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{*[Caption]*}：{*[page.workflow.select.form]*}!
			</td>
		</tr>
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
		var isToPersons=document.getElementsByName("isToPerson");
		back = document.getElementById('back');
		//用户选择下一节点
		if (element.id != 'back') {
			if(element.type != 'checkbox'){
				var elength=elements.length;
				if (back != null) {
					elength=elements.length-1;
				}
				for (var i=0; i < elength; i++) {
					//指定审批人不勾选
					isToPersons[i].checked=false;
					//隐藏审批人文本框
					document.getElementById("input_"+i).style.display="none";
					//隐藏审批人选择图标
					document.getElementById("selectUserImg_"+i).style.display="none";
				}
				//document.getElementById("selectUserImg_"+imgid).style.display="";
			}
			else{
				for (var i=0; i < elements.length; i++) {
					document.getElementById("selectUserImg_"+i).style.display="";
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
		if(toggleButton("button_act")) return false;
		
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
				if(toggleButton("button_act")) return false;
				alert('{*[page.workflow.chooseaction]*}');
			}
		}
		else {
			if(toggleButton("button_act")) return false;
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
		var url = "<o:Url value='/workflow/runtime/flowhis.jsp' />?_docid="+docid+"&dateTime=" + dateTime;
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
		} else {
			for (var i=0; i < nextEls.length; i++) {
				nextEls[i].click();
				if (nextEls[i].type == 'radio') {
					break;
				}
			}
		}
	}
</script>
	</html>
</o:MultiLanguage>
