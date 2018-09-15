/**
 * for portal/dispatch/work/list.jsp
 * 
 */

//流程提交
function showFlowSelect(flowid,docid,title) {
	var url = contextPath
			+ '/portal/share/workflow/runtime/flowprcss_dialog.jsp?docid='
			+ docid+"&flowid="+flowid;
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
		showtitle = "Undefind";
	}

	OBPM.dialog.show({
		width : 600,
		height : 420,
		url : url,
		args : {
			docid : docid
		},
		title : showtitle,
		close : function(result) {
			if(result){
				if(result.isHandupOrRecover){
					var _rtn = jQuery.param(result,true);
					if(result._operationMode == 'handup'){
						ev_flowHandup(docid,_rtn);
					}else if(result._operationMode == 'recover'){
						ev_flowRecover(docid,_rtn);
					}
				}else {
					var ftObj = document.getElementById("_flowType");
					if(ftObj){
						ftObj.value = result._flowType;
						delete result._flowType;
					}
					var rtn = jQuery.param(result,true);
					if (rtn) {
						var obj = document.getElementsByName("_nextids");
						for (var i = 0; i < obj.length; i++) {
							if (obj[i].checked) {
								document.getElementById("_nextids").value = obj[i].value;
							}
						}
						var actionUrl = contextPath
								+ "/portal/dynaform/work/flow.action";
						document.forms[0].action = actionUrl + '?_docid='+docid+ '&actionMode=work&' + rtn;
						document.forms[0].submit();
					}
				}
			}
		}
	});
}

//工作委托
function commissionedWork(docid,subject,stateLabel,title,applicationId){
	var url = contextPath
	+ '/portal/share/dynaform/work/commissionedWork.jsp?application='+applicationId+'&docid='+ docid+'&subject='+subject+'&stateLabel='+stateLabel;
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
	showtitle = "Undefind";
	}
	var info ={};
	info.subject = subject;
	info.stateLabel = stateLabel;
	OBPM.dialog.show({
	width : 600,
	height : 220,
	url : url,
	args : {
		docid : docid,
		info:info
	},
	title : showtitle,
	close : function(result) {
		var rtn = result;
		if (rtn) {
			var _actorId = document.getElementsByName("_actorId").value;
			var actionUrl = contextPath
					+ "/portal/dynaform/work/commissionedWork.action";
			document.forms[0].action = actionUrl + '?_docid='+docid+ '&_actorId'+_actorId+'&_newActors='+rtn+"&actionMode=work";
			document.forms[0].submit();
		}
	}
	});
}
//删除记录
function removeWork(docid,msg){
	if(docid && confirm(msg)){
		var actionUrl = contextPath
		+ "/portal/dynaform/work/removeWork.action?_docid="+docid+"&actionMode=work";
		document.forms[0].action = actionUrl;
		document.forms[0].submit();
	}
}

//打开文档
function viewDoc(docid, formid ,signatureExist) {
	var url = docviewAction;
	url += '?_docid=' + docid;
	if (formid) {
		url += '&_formid=' +  formid;
	}
	if(signatureExist){
		url += '&signatureExist=' +  signatureExist;
	}
	
	
	openWindowByType(url,'{*[Select]*}', VIEW_TYPE_NORMAL); 
}

function doList(processType){
	document.getElementsByName("_processType")[0].value = processType;
	var actionUrl = contextPath+"/portal/dynaform/work/workList.action?actionMode=work";
	if(document.getElementsByName("_jumppage")[0]){
		document.getElementsByName("_jumppage")[0].value = '';
	}
	if(document.getElementsByName("_currpage")[0]){
		document.getElementsByName("_currpage")[0].value = '';
	}
	document.forms[0].action = actionUrl;
	document.forms[0].submit();
}

function doCirculatorList(isRead){
	document.getElementsByName("_isRead")[0].value = isRead;
	var actionUrl = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	if(document.getElementsByName("_jumppage")[0]){
		document.getElementsByName("_jumppage")[0].value = '';
	}
	if(document.getElementsByName("_currpage")[0]){
		document.getElementsByName("_currpage")[0].value = '';
	}
	document.forms[0].action = actionUrl;
	document.forms[0].submit();
}

function initTab(){
	var _processType=document.getElementsByName("_processType")[0].value;
	var _isRead = document.getElementsByName("_isRead")[0].value;
	document.getElementById("btnProcessing").className = "btcaption";
	document.getElementById("btnProcessed").className = "btcaption";
	document.getElementById("btnAll").className = "btcaption";
	document.getElementById("btnCirculator_ing").className = "btcaption";
	document.getElementById("btnCirculator_ed").className = "btcaption";

	if(actionMode=="work" && _processType=="processing"){
		document.getElementById("btnProcessing").className = "btcaption-selected";
	}else if(_processType=="processed"){
		document.getElementById("btnProcessed").className = "btcaption-selected";
	}else if(actionMode=="work" && _processType=="all"){
		document.getElementById("btnAll").className = "btcaption-selected";
	}
	if(actionMode=="circulator" && _isRead=="0"){
		document.getElementById("btnCirculator_ing").className = "btcaption-selected";
	}else if(actionMode=="circulator" && _isRead=="1"){
		document.getElementById("btnCirculator_ed").className = "btcaption-selected";
	}
}

function doQuery(actionMode) {
	document.getElementsByName('_currpage')[0].value=1;
	var actionUrl = '';
	if(actionMode == 'work'){
		actionUrl = contextPath+"/portal/dynaform/work/workList.action?actionMode="+actionMode;
	}else if(actionMode == 'circulator'){
		actionUrl = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	}
	document.forms[0].action = actionUrl;
	document.forms[0].submit();
}

function doReset(actionMode){
	if(actionMode == 'work'){
		document.getElementsByName('_subject')[0].value = "";
		document.getElementsByName('_moduleId')[0][0].selected = "selected";
		document.getElementsByName('_flowId')[0].options.length = 0;
	}else if(actionMode == 'circulator'){
		document.getElementsByName('_subject4Circulator')[0].value = "";
	}
	
}

function adjustWorkList(){
	var bodyH=jQuery("body").height()-13;
	var bodyW=jQuery("body").width()-2;
	jQuery("#container").height(bodyH);
	jQuery("#container").width(bodyW);
	var navigateTableH=jQuery("#navigateTable").height();
	var searchTableH = jQuery("#searchFormTable").height();
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#contentTable").height(bodyH-navigateTableH-searchTableH-pageTableH);
}

//流程挂起
function ev_flowHandup(docid,rtn){
//	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/work/flowHandup.action?actionMode=work&_docid=' + docid + '&' + rtn;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	document.forms[0].submit();
}

//流程恢复
function ev_flowRecover(docid,rtn){
//	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/work/flowRecover.action?&actionMode=work&_docid=' + docid + '&' + rtn;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	document.forms[0].submit();
}

function init(){
	initTab();
	adjustWorkList();
}

jQuery(window).load(function(){
	init();
}).resize(function(){
	adjustWorkList();
});