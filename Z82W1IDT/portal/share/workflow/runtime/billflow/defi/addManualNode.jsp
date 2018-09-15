<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
   String contextPath = request.getContextPath();
	//response.setHeader("Pragma","No-Cache");   
	//response.setHeader("Cache-Control","No-Cache");   
	//response.setDateHeader("Expires",   0);  
 %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>{*[Add a manual node]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css" />

<script type="text/javascript" src='<s:url value="addManualNode.js"/>'></script>
<script type='text/javascript' src='<s:url value="/dwr/interface/SummaryCfgHelper.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/ddtabmenu.js"/>'></script>
<script src="<s:url value='/portal/share/script/util.js'/>"></script>

<script language="JavaScript">
  var contextPath = '<%=contextPath%>';
  
function ev_ok() {
	var actorAttr = new Object();
	actorAttr.name = tmp.name.value;
	actorAttr.statelabel = tmp.statelabel.value;
	actorAttr.namelist = tmp.namelist.value;
	actorAttr.userList = tmp.userList.value;
	//--------------------------------
	
	var isCarbonCopy = document.getElementById("isCarbonCopy");//是否开启抄送功能
	if(isCarbonCopy.checked){
		actorAttr.isCarbonCopy =true;
		
	}else{
		actorAttr.isCarbonCopy =false;
	}
	var isSelectCirculator = document.getElementById("isSelectCirculator");
	if(isSelectCirculator.checked){
		actorAttr.isSelectCirculator =true;
	}else{
		actorAttr.isSelectCirculator =false;
	}
	actorAttr.circulatorEditMode = getCirculatorEditMode();
	actorAttr.circulatorNamelist = tmp.circulatorNamelist.value;
	actorAttr.circulatorNamelistByUser = tmp.circulatorNamelistByUser.value;
	actorAttr.circulatorListScript = tmp.circulatorListScript.value;
	//--------------------------------
	var isFrontEdit = document.getElementById("isFrontEdit");//是否可前台手动调整流程
	if(isFrontEdit.checked){
		actorAttr.isFrontEdit =true;
	}else{
		actorAttr.isFrontEdit =false;
	}
	
	var passcondition = eval("tmp.passcondition");
	actorAttr.passcondition = 0;
	for(var i=0; i< passcondition.length; i++){
	  if(passcondition[i].checked){
		  actorAttr.passcondition = passcondition[i].value;
		  break;
	  }
	}

	actorAttr.fieldpermlist = tmp.fieldpermlist.value;
	actorAttr.formname = tmp.formname.value;
	var issplit = document.getElementsByName('issplit');
	if(issplit[0].checked){
	    actorAttr.issplit = issplit[0].value;
	}else{
	    actorAttr.issplit = false;
	}
	var isgather = document.getElementsByName('isgather');
	if(isgather[0].checked){
	    actorAttr.isgather = isgather[0].value;
	}else{
	   actorAttr.isgather = false;
	}
	
	// set actor edit mode
	var notificationStrategyJSON =document.getElementById("notificationStrategyJSON");
	//notificationStrategyJSON.value="";
	var toJsonNottifiaction = toJson();
	//toJsonNottifiactionValue = toJsonNottifiaction.replace(/"/g,"");
	notificationStrategyJSON.value = toJsonNottifiaction;
	actorAttr.notificationStrategyJSON= tmp.notificationStrategyJSON.value;
	actorAttr.actorEditMode = getActorEditMode();
	actorAttr.actorListScript = tmp.actorListScript.value;

	var cback = eval('tmp.cBack');//可否回退
	if(cback[0].checked){
	    actorAttr.cBack = cback[0].value;
	}else{
	    actorAttr.cBack = false;
	}
	var backtype = eval('tmp.backType');//回退模式
	if(backtype[0].checked){
		 actorAttr.backType = backtype[0].value;
	}else{
		 actorAttr.backType = backtype[1].value;
	}
	var isToPerson = document.getElementById("isToPerson");//回退是否指的审批人
	if(isToPerson.checked){
		actorAttr.isToPerson =isToPerson.value;
	}else{
		actorAttr.isToPerson =false;
	}
	
	actorAttr.bnodelist = tmp.bnodelist.value; //回退节点列表(保存)
	var retracementEditMode = document.getElementById("retracementEditMode");//回撤编辑模式
		if(retracementEditMode.checked){
			actorAttr.retracementEditMode = retracementEditMode.value;
		}else{
			actorAttr.retracementEditMode = 0;
		}

	var cRetracement = document.getElementsByName("cRetracement");//可否回撤
		if(cRetracement[0].checked && cRetracement[0].id=='cRetracement'){
			actorAttr.cRetracement =cRetracement[0].value;
		}else if(cRetracement[0].id=='cRetracement'){
			actorAttr.cRetracement =false;
		}else if(cRetracement[2].checked && cRetracement[2].id=='retracementEditMode'){
			actorAttr.retracementEditMode =1;
		}
	
	actorAttr.retracementScript = tmp.retracementScript.value;//回撤脚本

	actorAttr.splitStartNode = document.getElementById("splitStartNode").value;//聚和开始节点
	
	
	// 校验部分
	var validators = [{fieldName: "name", type: "required", msg: "{*[page.name.notexist]*}"}];
	validators.push({fieldName: "statelabel", type: "required", msg: "{*[page.statelabel.notexist]*}"});//状态标签校验
	if ((jQuery("emailMode").val() || jQuery("smsMode").val()) && jQuery("overdueType").val()) {
		validators.push({fieldName: "limittimecount", type: "is-positive-number", msg: "{*[workflow.limittimecount.positive]*}"});
		if (document.getElementsByName("timeunit")[0].value == "0") {
			validators.push({fieldName: "limittimecount", type: "equal-great-than", msg: "{*[workflow.limittimecount.great.than]*}", args:{value:0.5}});
		}
		
	}
	if(document.getElementById("splitStartNode").value=="" && actorAttr.isgather){
		validators.push({fieldName: "splitStartNode", type: "required", msg: "{*[请选择分散开始节点]*}"});
	}
	if (getActorEditMode() == 0) {
		validators.push({fieldName: "namelist", type: "required", msg: "{*[page.workflow.manualnode.choosegroup]*}"});
	}
	if (getActorEditMode() == 1) {
		validators.push({fieldName: "actorListScript", type: "required", msg: "{*[cn.myapps.core.workflow.input_auditing_script]*}"});
	}
	if (getActorEditMode() == 2) {
		validators.push({fieldName: "userList", type: "required", msg: "{*[cn.myapps.core.workflow.select_audit_user]*}"});
	}
	if (getBackType() == 1) {
		validators.push({fieldName: "bnodelist", type: "required", msg: "{*[page.workflow.manualnode.choosegroup]*}"});
	}
	if (toJsonNottifiaction == "{}") {
		var sendModes = document.getElementsByName("sendMode");//sendMode
		var sendModeFlag = true;
		for (var i = 0; i < sendModes.length; i++) {
			if (sendModes[i].checked) {
				validators.push({fieldName: "notificationType", type: "required", msg: "{*[page.workflow.manualnode.choosesendnotftype]*}"});
				sendModeFlag = false;
				break;
			}
		}
		if (sendModeFlag) {
			var notifications = document.getElementsByName("notificationType");
			for (var i = 0; i < notifications.length; i++) {
				//alert(notifications[i].checked + ":" + notifications[i].value);
				if (notifications[i].checked) {
					validators.push({fieldName: "sendMode", type: "required", msg: "{*[page.workflow.manualnode.choosesendmode]*}"});
					break;
				}
			}
		}
	}
    if (doValidate(validators)) {
    	//window.returnValue = actorAttr;
   	 	OBPM.dialog.doReturn(actorAttr);
    }
}

function getActorEditMode(){
	var oActorEditModes = document.getElementsByName("actorEditMode");
	for(var i=0; i< oActorEditModes.length; i++){
		if(oActorEditModes[i].checked){
		  	return oActorEditModes[i].value;
	  	}
	}
}
function getCirculatorEditMode(){
	var oActorEditModes = document.getElementsByName("circulatorEditMode");
	for(var i=0; i< oActorEditModes.length; i++){
		if(oActorEditModes[i].checked){
		  	return oActorEditModes[i].value;
	  	}
	}
}
//回撤编辑模式 0|1
function getRetracementEditMode(){
	var retracementEditMode = document.getElementsByName("cRetracement");
	for(var i=0; i< retracementEditMode.length; i++){
		if(retracementEditMode[i].checked){
		  	return retracementEditMode[i];
	  	}
	}
}
//流程回退类型 0|1
function getBackType(){
	var backType = document.getElementsByName("backType");
	for(var i=0; i< backType.length; i++){
		if(backType[i].checked){
		  	return backType[i].value;
	  	}
	}
}
//流程能否回退   'true'|'false'
function getcBack(){
	var cBack = document.getElementsByName("cBack");
	for(var i=0; i< cBack.length; i++){
		if(cBack[i].checked){
		  	return cBack[i].value;
	  	}
	}
}

function ev_close() {
    OBPM.dialog.doReturn();
}

function getPasscondition(){
  var passcondition = eval("tmp.passcondition");//审核通过{*[Condition]*}（{*[Or]*}、{*[and]*}、强制{*[and]*}、{*[User-defined]*})
  var condition;
  for(var i=0; i< passcondition.length; i++){
	if(passcondition[i].checked){
	  condition = passcondition[i].value;
	}
  }
  return condition;
}

function changeCondition(){
  //tmp.namelist.value = '';
  //tmp.namelist_bak.value = '';
  
	var condition = getPasscondition();
  	
  	var namelistVal = tmp.namelist.value;
  	if (namelistVal) {
  		if (namelistVal.indexOf('(') != -1 || namelistVal.indexOf('{') != -1) {
  			namelistVal = namelistVal.substring(1, namelistVal.length - 1);
  		}
  		if(condition == '0'){
			tmp.namelist.value = "(" + namelistVal + ")";
		}else if(condition == '1'){
			tmp.namelist.value = "{" + namelistVal + "}";
		}else if(condition == '2'){
			tmp.namelist.value = "{" + namelistVal + "}";
		}
  	}
  	//return true;
}

function selectForm(){
  var url = '<s:url value="/portal/workflow/billflow/defi/selectForm.jsp" />';
  //url = addParam(url, 'formtype', '1');
  url = addParam(url, 's_module', "<s:property value='#parameters.s_module'/>");
  var obj = new Object();
  obj.fieldPermList = tmp.fieldpermlist.value;
 // var rtn = window.showModalDialog(url,obj,"dialogHeight:550px; dialogWidth:750px; dialogTop: 120px; dialogLeft:120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;");
  
  OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {"pObj":obj},
			title: '{*[cn.myapps.core.workflow.select_form]*}',
			close: function(rtn) {
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
				  
				  tmp.formname.value = formList;
				  tmp.fieldpermlist.value = fieldpermlist;
			}
	});
}

//Design和Code模式互换
function modeChange(selectedIndex) { 
	for(var i=0;i<3;i++) {
			var oEditMode = document.getElementById('actorEditModeTR' + i);
			oEditMode.style.display = 'none';
		}
		var oSelectedEditMode = document.getElementById('actorEditModeTR' + selectedIndex);
		oSelectedEditMode.style.display = '';
	}
</script>

<script>
var oldAttrs=OBPM.dialog.getArgs()['oldAttr'];
function selectBackNodes(target, multiselect){
	var flowid = '<s:property value="#parameters.flowid"/>'
	var nodeid = oldAttrs.id;
	var url = contextPath + '/portal/workflow/billflow/defi/selectlist.jsp?flowid='+flowid+'&nodeid='+nodeid+'&target='+target;
	//alert("url----->"+url);
	var oField = document.getElementById('bnodelist');
	var rtn = window.showModalDialog(url, oField, "dialogHeight:400px; dialogWidth:300px; resizable:yes; status:no; scroll:auto;");
	if (rtn == undefined) return;
	var rtnArray = rtn.split(",");
	if (rtnArray == null || rtnArray == 'undefined') {
	}
	else if (rtnArray == '') {
		tmp.bnodelist.value = '';
	}
	else {
		if(multiselect){
			tmp.bnodelist.value = '';
			//去掉重复
			var array = new Array(rtnArray.length);
			var count = 0;
			for (var n = 0; n < rtnArray.length; n++) {
				var flag = false;
				for (var m = 0; m < rtnArray.length; m++) {
				
					if (array[m] != rtnArray[n]) {
						if (m + 1 == rtnArray.length) {
							flag = true;
						}
						continue;
					}
					else {
						break;
					}
				}				
				if (flag) {
					array[count] = rtnArray[n];
					count++;
				}
			}
			
			// 数组复制
			var newArray = array.slice(0 , count); 
			tmp.bnodelist.value = newArray[0]
			for (var i=1; i < newArray.length; i++) {
				var t = newArray[i];
				tmp.bnodelist.value += ';'+t;
			}
		}else{
			var t = rtn;
			tmp.bnodelist.value = t + ";";
		}
	}
	if(rtn){
		oField.value = tmp.bnodelist.value;
	} else if (rtn == '') {
		oField.value = '';
	}
	parseBackNodeList();
}

function selectField(actionName, field, multiselect){
	var condition = getPasscondition();
	var url = contextPath + '/portal/role/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}
	var oField = document.getElementById('namelist');
	OBPM.dialog.show({
			opener:window.parent.parent,
			width: 300,
			height: 500,
			url: url,
			args: {"oField":oField},
			title: '{*[cn.myapps.core.workflow.select_role]*}',
			close: function(rtn) {
				if (rtn == undefined) 
					return;
				var rtnArray = rtn.split(",");
				
				if (rtnArray == null || rtnArray == 'undefined') {
				}
				else if (rtnArray == '') {
					tmp.namelist.value = '';
				}
				else {
					if(multiselect){
						tmp.namelist.value = '';
						//去掉重复
						var array = new Array(rtnArray.length);
						var count = 0;
						for (var n = 0; n < rtnArray.length; n++) {
							var flag = false;
							for (var m = 0; m < rtnArray.length; m++) {
							
								if (array[m] != rtnArray[n]) {
									if (m + 1 == rtnArray.length) {
										flag = true;
									}
									continue;
								}
								else {
									break;
								}
							}				
							if (flag) {
								array[count] = rtnArray[n];
								count++;
							}
						}
						
						// 数组复制
						var newArray = array.slice(0 , count); 
						for (var i=0; i < newArray.length; i++) {
							var t = newArray[i];
							tmp.namelist.value += t + ';';
						}
					}else{
						var t = rtn;
						tmp.namelist.value = t + ";";
					}
				}
				
				if(condition == '0'){
					tmp.namelist.value = "(" + tmp.namelist.value + ")";
				}else if(condition == '1'){
					tmp.namelist.value = "{" + tmp.namelist.value + "}";
				}else if(condition == '2'){
					tmp.namelist.value = "{" + tmp.namelist.value + "}";
				}
				
				if(rtn){
					oField.value = tmp.namelist.value;
				} else if (rtn == '') {
					oField.value = '';
				}
				parseRoles();
			}
	});
}
/*
 * 选择审批人
 */
function selectUsers(action, field, multiselect){
	var condition = getPasscondition();
	var url = contextPath + '/portal/share/user/selectUserByAll4ManualNode.jsp?application=' + '<s:property value="%{#parameters.application}" />';
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}
	var oField = document.getElementById('userList');
	OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {"oField":oField},
			title: '{*[cn.myapps.core.workflow.select_user]*}',
			close: function(rtn) {
				if (rtn == undefined) 
					return;
				var rtnArray = rtn.split(",");
				
				if (rtnArray == null || rtnArray == 'undefined') {
				}
				else if (rtnArray == '') {
					tmp.userList.value = '';
				}
				else {
					if(multiselect){
						tmp.userList.value = '';
						//去掉重复
						var array = new Array(rtnArray.length);
						var count = 0;
						for (var n = 0; n < rtnArray.length; n++) {
							var flag = false;
							for (var m = 0; m < rtnArray.length; m++) {
							
								if (array[m] != rtnArray[n]) {
									if (m + 1 == rtnArray.length) {
										flag = true;
									}
									continue;
								}
								else {
									break;
								}
							}				
							if (flag) {
								array[count] = rtnArray[n];
								count++;
							}
						}
						
						// 数组复制
						var newArray = array.slice(0 , count); 
						for (var i=0; i < newArray.length; i++) {
							var t = newArray[i];
							tmp.userList.value += t + ';';
						}
					}else{
						var t = rtn;
						tmp.userList.value = t + ";";
					}
				}
				
				if(condition == '0'){
					tmp.userList.value = "(" + tmp.userList.value + ")";
				}else if(condition == '1'){
					tmp.userList.value = "{" + tmp.userList.value + "}";
				}else if(condition == '2'){
					tmp.userList.value = "{" + tmp.userList.value + "}";
				}
				
				if(rtn){
					oField.value = tmp.userList.value;
				} else if (rtn == '') {
					oField.value = '';
				}
				parseUsers();
			}
	});
}

/*
 * 选择抄送人
 */
function selectCirculators(action, field, multiselect){
	var condition = getPasscondition();
	var url = contextPath + '/portal/share/user/selectUserByAll4ManualNode.jsp?application=' + '<s:property value="%{#parameters.application}" />';
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}
	var oField = document.getElementById('circulatorNamelistByUser');
	OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {"oField":oField},
			title: '{*[cn.myapps.core.workflow.select_user]*}',
			close: function(rtn) {
				if (rtn == undefined) 
					return;
				var rtnArray = rtn.split(",");
				
				if (rtnArray == null || rtnArray == 'undefined') {
				}
				else if (rtnArray == '') {
					tmp.circulatorNamelistByUser.value = '';
				}
				else {
					if(multiselect){
						tmp.circulatorNamelistByUser.value = '';
						//去掉重复
						var array = new Array(rtnArray.length);
						var count = 0;
						for (var n = 0; n < rtnArray.length; n++) {
							var flag = false;
							for (var m = 0; m < rtnArray.length; m++) {
							
								if (array[m] != rtnArray[n]) {
									if (m + 1 == rtnArray.length) {
										flag = true;
									}
									continue;
								}
								else {
									break;
								}
							}				
							if (flag) {
								array[count] = rtnArray[n];
								count++;
							}
						}
						
						// 数组复制
						var newArray = array.slice(0 , count); 
						for (var i=0; i < newArray.length; i++) {
							var t = newArray[i];
							tmp.circulatorNamelistByUser.value += t + ';';
						}
					}else{
						var t = rtn;
						tmp.circulatorNamelistByUser.value = t + ";";
					}
				}
				
				if(condition == '0'){
					tmp.circulatorNamelistByUser.value = "(" + tmp.circulatorNamelistByUser.value + ")";
				}else if(condition == '1'){
					tmp.circulatorNamelistByUser.value = "{" + tmp.circulatorNamelistByUser.value + "}";
				}else if(condition == '2'){
					tmp.circulatorNamelistByUser.value = "{" + tmp.circulatorNamelistByUser.value + "}";
				}
				
				if(rtn){
					oField.value = tmp.circulatorNamelistByUser.value;
				} else if (rtn == '') {
					oField.value = '';
				}
				parseCirculatorUsers();
			}
	});
}

/***************************初始化模板选项*********************************/
function initTempleateOptions(selectid){
	var application ='<s:property value='#parameters.application'/>';
	SummaryCfgHelper.createSummaryOptions(selectid,application,'',function(str){
		var func = eval(str);
	    func.call();
	});
}

function initTemplate(){
	initTempleateOptions('sendTemplate');
	initTempleateOptions('rejectTemplate');
	initTempleateOptions('overdueTemplate');
	initTempleateOptions('arriveTemplate');
}
/***************************初始化模板选项结束*********************************/
var oldAttrs;
function ev_init() {
	oldAttrs=OBPM.dialog.getArgs()['oldAttr'];
	if(oldAttrs!=null){
		tmp.namelist.value=oldAttrs.namelist;
		tmp.userList.value=oldAttrs.userList;
		tmp.name.value=oldAttrs.name;
		if (oldAttrs.statelabel!=null) {
			tmp.statelabel.value=oldAttrs.statelabel;
		}
		tmp.fieldpermlist.value = HTMLDencode(oldAttrs.fieldpermlist);
		
		if(oldAttrs.formname == null){
			oldAttrs.formname = '';
		}
		
		tmp.formname.value = oldAttrs.formname;

		var isFrontEdit = document.getElementById("isFrontEdit");//是否可前台手动调整流程
		if(oldAttrs.isFrontEdit){
			isFrontEdit.checked =true;
		}
		
		var issplit = eval('tmp.issplit');
		for(var i=0; i<issplit.length; i++){
			if(oldAttrs.issplit){
				issplit[0].checked = true;
				break;
			}
		}
		
		
		var isgather = eval('tmp.isgather');
		for(var i=0; i<isgather.length; i++){
			if(oldAttrs.isgather){
				isgather[0].checked = true;
				document.getElementById("splitStartNode").style.display="";
				document.getElementById("splitStartNodeLabel").style.display="";
				break;
			}
		}
		var passcondition = eval("tmp.passcondition");//审核通过{*[Condition]*}（{*[Or]*}、{*[and]*}、强制{*[and]*}、{*[User-defined]*})
		for(var i=0; i< passcondition.length; i++){
			if(passcondition[i].value == oldAttrs.passcondition){
			passcondition[i].checked = true;
			break;
			}
		}
		var cback = eval('tmp.cBack');//可否回退
		if(oldAttrs.cBack || oldAttrs.retracementScript==null){
			cback[0].checked = true;
			
		}else{
			cback[1].checked = true;
			}
		cBackChange(getcBack());
		
		var backtype = eval('tmp.backType');//回退模式
		for(var i=0; i<backtype.length; i++){
			if(backtype[i].value == oldAttrs.backType){
				backtype[i].checked = true;
				break;
				}
		}
		backTypeChange(getBackType());

		var isToPerson = document.getElementById("isToPerson");//回退是否指的审批人
		if(oldAttrs.isToPerson){
			isToPerson.checked =true;
		}
		
		var bnodelist = document.getElementById("bnodelist");//回退节点列表(保存)
		if(oldAttrs.bnodelist){
			bnodelist.value =oldAttrs.bnodelist;
		}
		
		var dbnodelist = document.getElementById("dbnodelist");//回退节点列表(显示)
		parseBackNodeList();//解析回退节点列表(显示)
		
		var retracementEditMode = document.getElementById("retracementEditMode");//回撤编辑模式
		if(oldAttrs.retracementEditMode==1){
			retracementEditMode.checked = true;
			document.getElementById("retracementScriptSetup").style.display = '';
		}
		retracementEditModeChange(getRetracementEditMode());
		

		var cRetracement = document.getElementsByName("cRetracement");//可否回撤
		if(oldAttrs.cRetracement){
			if(oldAttrs.retracementEditMode==0)cRetracement[0].checked = true;
		}else{
			if(oldAttrs.retracementEditMode==0)cRetracement[1].checked = true;
			}
		var retracementScript = document.getElementById("retracementScript");//回撤脚本
		if(oldAttrs.retracementScript){
			retracementScript.value = oldAttrs.retracementScript;
		}

		var selectList=document.getElementById("splitStartNode");
		selectList.options.add(new Option("--{*[Select]*}--",""));
		if(oldAttrs.getAllSplitNode!=null){
			var nodes = oldAttrs.getAllSplitNode.split(",");
			for(var i=0; i<nodes.length; i++) {
				var stropt = nodes[i];
				if(stropt!=''){
					var opt =stropt.split("=");
					selectList.options.add(new Option(opt[1],opt[0]));
				}
			}
		}

		if(oldAttrs.splitStartNode!=null){
			selectList.value = oldAttrs.splitStartNode;
		}
		tmp.circulatorNamelist.value=oldAttrs.circulatorNamelist;
		tmp.circulatorNamelistByUser.value=oldAttrs.circulatorNamelistByUser;
		var isCarbonCopy = document.getElementById("isCarbonCopy");
		
		if(oldAttrs.isCarbonCopy){
			isCarbonCopy.checked =true;
			onCcCheckboxClick(isCarbonCopy);
			
		}
		var isSelectCirculator = document.getElementById("isSelectCirculator");
		if(oldAttrs.isSelectCirculator){
			isSelectCirculator.checked =true;
		}
		var circulatorEditMode = document.getElementsByName("circulatorEditMode");
		circulatorEditModeChange(oldAttrs.circulatorEditMode);
		setCheck(circulatorEditMode, oldAttrs.circulatorEditMode);
		tmp.circulatorListScript.value=HTMLDencode(oldAttrs.circulatorListScript);
		
		
		var els = document.getElementsByName("actorEditMode");
		setCheck(els, oldAttrs.actorEditMode);
		tmp.actorListScript.value = HTMLDencode(oldAttrs.actorListScript);
		DWREngine.setAsync(false);
		initTemplate();
		
	}
	modeChange(getActorEditMode());
	var notificationStrategyJSON =  HTMLDencode(oldAttrs.notificationStrategyJSON);
	if(notificationStrategyJSON){
		parseJson(notificationStrategyJSON);
	}
	parseRoles();
	parseUsers();
	parseCirculatorRoles();
	parseCirculatorUsers();
	initTabs();
	ddtabmenu.definemenu("div_notificationType", -1);
	//window.top.toThisHelpPage("application_module_workflows_handnode");
}

function initTabs() {
	var send = document.getElementById("sendType");
	var arrive = document.getElementById("arriveType");
	var reject = document.getElementById("rejectType");
	var overdue = document.getElementById("overdueType");
	showTab(send, 'tab_send');
	showTab(arrive, 'tab_arrive');
	showTab(reject, 'tab_reject');
	showTab(overdue, 'tab_overdue');
}


var showedTabs = {};
function showTab(oCheck, targetitemid){
	var targetitem = document.getElementById(targetitemid);
	
	if (targetitem) {
		if (oCheck.checked) {
			targetitem.style.display = "";
			ddtabmenu.showsubmenu('div_notificationType', targetitem);
			showedTabs[targetitemid] = targetitem;
		} else {
			targetitem.style.display = "none";
			delete showedTabs[targetitemid];
			var flag = true;
			for (itemid in showedTabs){
				ddtabmenu.showsubmenu('div_notificationType', showedTabs[itemid]);
			}
			if (flag) {
				var targetcontent = document.getElementById(targetitem.rel);
				targetcontent.style.display = "none";
			}
		}
	}
}

function parseRoles(){
     var rolelists = "";
     var roleLis = "";
     var namelist = jQuery('#namelist').val();
     var namelist_bak =jQuery('#namelist_bak');
     if(namelist!=null){
       var rolelist = namelist.substring(1,namelist.length-1);
       var roles  = rolelist.split(";");
       for(var i=0; i< roles.length; i++){
             var role = roles[i];
             var rr = role.split("|");
             if(rr[1] == 'undefined' || rr[1] == null){
             }else{
             	roleLis += rr[1] + ";";
             	rolelists =roleLis.substring(0,roleLis.length-1);
             }
       }
    }
    namelist_bak.val(rolelists);
    return rolelists;
}

function parseUsers(){
    var userlists = "";
    var userLis = "";
    var userList = jQuery('#userList').val();
    var userList_bak = jQuery('#userList_bak');
    if(userList!=null){
      var userlist = userList.substring(1,userList.length-1);
      var users  = userlist.split(";");
      for(var i=0; i< users.length; i++){
            var user = users[i];
            var rr = user.split("|");
            if(rr[1] == 'undefined' || rr[1] == null){
            }else{
            	userLis += rr[1] + ";";
            	userlists =userLis.substring(0,userLis.length-1);
            }
      }
   }
   userList_bak.val(userlists);
   return userlists;
}

function parseBackNodeList(){
	var rntlist = "";
    var nodeLis = "";
    var bnodelist = jQuery('#bnodelist').val();
    var dbnodelist = jQuery('#dbnodelist');
    if(bnodelist!=null){
      var nodes  = bnodelist.split(";");
      for(var i=0; i< nodes.length; i++){
            var node = nodes[i];
            var nn = node.split("|");
            if(nn[1] == 'undefined' || nn[1] == null){
            }else{
            	nodeLis += nn[1] + ";";
            	rntlist =nodeLis.substring(0,nodeLis.length-1);
            }
      }
   }
   dbnodelist.val(rntlist);
   return rntlist;
}

function cBackChange(value){
	var backSetup = document.getElementById('backSetup');
	if(value=='true'){
	backSetup.style.display = '';
	}else{
		backSetup.style.display = 'none';
	}
}
function retracementEditModeChange(obj){
	var retracementScriptSetup = document.getElementById('retracementScriptSetup');
	if(obj.id=='cRetracement'){
		retracementScriptSetup.style.display = 'none';
	}else if(obj.id=='retracementEditMode'){
		retracementScriptSetup.style.display = '';
	}
}
function backTypeChange(value){
	var back_cus_step = document.getElementById('back_cus_step');
	if(value ==0){
		back_cus_step.style.display = 'none';
	}else if(value ==1){
		back_cus_step.style.display = '';
	}
}


jQuery(document).ready(function(){
	jQuery("#nod_container > ul > li").click(function(){
		jQuery("#nod_container li.on").removeClass("on");
		jQuery("#nod_container div.on").removeClass("on");
		jQuery(this).addClass("on");
		jQuery("#"+jQuery(this).attr("id")+"_set").addClass("on");
	});
	ev_init();
});
function isgatherEvent(s){
	if(s == true || s == 'true'){
		document.getElementById("splitStartNode").style.display="";
		document.getElementById("splitStartNodeLabel").style.display="";
	}else{
		document.getElementById("splitStartNode").style.display='none';
		document.getElementById("splitStartNodeLabel").style.display="none";
	}
}
function onCcCheckboxClick(obj){
	if(obj.checked){
		document.getElementById("cc_div").style.display='';
	}else{
		document.getElementById("cc_div").style.display='none';
	}
}
function circulatorEditModeChange(selectedIndex) {
	for(var i=0;i<3;i++) {
		var oEditMode = document.getElementById('circulatorEditModeTR' + i);
		oEditMode.style.display = 'none';
	}
	var oSelectedEditMode = document.getElementById('circulatorEditModeTR' + selectedIndex);
	oSelectedEditMode.style.display = '';
}

function selectCirculatorNamelist(actionName, field, multiselect){
	var condition = getPasscondition();
	var url = contextPath + '/portal/role/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}
	var oField = document.getElementById('circulatorNamelist');
	OBPM.dialog.show({
			opener:window.parent.parent,
			width: 300,
			height: 500,
			url: url,
			args: {"oField":oField},
			title: '{*[cn.myapps.core.workflow.select_role]*}',
			close: function(rtn) {
				if (rtn == undefined) 
					return;
				var rtnArray = rtn.split(",");
				
				if (rtnArray == null || rtnArray == 'undefined') {
				}
				else if (rtnArray == '') {
					tmp.circulatorNamelist.value = '';
				}
				else {
					if(multiselect){
						tmp.circulatorNamelist.value = '';
						//去掉重复
						var array = new Array(rtnArray.length);
						var count = 0;
						for (var n = 0; n < rtnArray.length; n++) {
							var flag = false;
							for (var m = 0; m < rtnArray.length; m++) {
							
								if (array[m] != rtnArray[n]) {
									if (m + 1 == rtnArray.length) {
										flag = true;
									}
									continue;
								}
								else {
									break;
								}
							}				
							if (flag) {
								array[count] = rtnArray[n];
								count++;
							}
						}
						
						// 数组复制
						var newArray = array.slice(0 , count); 
						for (var i=0; i < newArray.length; i++) {
							var t = newArray[i];
							tmp.circulatorNamelist.value += t + ';';
						}
					}else{
						var t = rtn;
						tmp.circulatorNamelist.value = t + ";";
					}
				}
				
				if(condition == '0'){
					tmp.circulatorNamelist.value = "(" + tmp.circulatorNamelist.value + ")";
				}else if(condition == '1'){
					tmp.circulatorNamelist.value = "{" + tmp.circulatorNamelist.value + "}";
				}else if(condition == '2'){
					tmp.circulatorNamelist.value = "{" + tmp.circulatorNamelist.value + "}";
				}
				
				if(rtn){
					oField.value = tmp.circulatorNamelist.value;
				} else if (rtn == '') {
					oField.value = '';
				}
				parseCirculatorRoles();
			}
	});
}


function parseCirculatorRoles(){
    var rolelists = "";
    var roleLis = "";
    var namelist = jQuery('#circulatorNamelist').val();
    var namelist_bak = jQuery('#circulatorNamelist_bak');
    if(namelist!=null){
      var rolelist = namelist.substring(1,namelist.length-1);
      var roles  = rolelist.split(";");
      for(var i=0; i< roles.length; i++){
            var role = roles[i];
            var rr = role.split("|");
            if(rr[1] == 'undefined' || rr[1] == null){
            }else{
            	roleLis += rr[1] + ";";
            	rolelists =roleLis.substring(0,roleLis.length-1);
            }
      }
   }
   namelist_bak.val(rolelists);
   return rolelists;
}

function parseCirculatorUsers(){
    var userlists = "";
    var userLis = "";
    var namelist = jQuery('#circulatorNamelistByUser').val();
    var namelist_bak = jQuery('#circulatorNamelistByUser_bak');
    if(namelist!=null){
      var userlist = namelist.substring(1,namelist.length-1);
      var users  = userlist.split(";");
      for(var i=0; i< users.length; i++){
            var user = users[i];
            var rr = user.split("|");
            if(rr[1] == 'undefined' || rr[1] == null){
            }else{
            	userLis += rr[1] + ";";
            	userlists =userLis.substring(0,userLis.length-1);
            }
      }
   }
   namelist_bak.val(userlists);
   return userlists;
}
</script>
</head>
<body style="overflow: hidden;">
<form name="tmp" method="post">
<div id="header">
<table width="100%" cellspacing="4" cellpadding="0">
	<tr height="27px;">
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.workflow.manualnode_info]*}</td>
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
</table>
</div>
<input type="hidden" name="siteid">
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<%@include file="/common/page.jsp"%>
<div id="nod_container">

	<ul>
		<li id="basic" class="on">{*[cn.myapps.core.workflow.basic_info]*}</li>
		<li id="staff">{*[cn.myapps.core.workflow.auditor_setup]*}</li>
		<li id="cc">{*[cn.myapps.core.workflow.send_setup]*}</li>
		<li id="shenpi">{*[cn.myapps.core.workflow.audit_setup]*}</li>
		<li id="operate">{*[cn.myapps.core.workflow.activity_setup]*}</li>
		<li id="notice_remind">{*[Notification]*}</li>
		
	</ul>
	<div id="basic_set" class="on">
		<table class="table_noborder"  border="1" style="border: #e0e0e0";>
			<tr>
				<td class="commFont" style="width:50%;">{*[Name]*}:</td>
				<td class="commFont">{*[State_Label]*}:</td>
				
			</tr>
			<tr>
				<td align="left"><input class="input" style="width:300px;" type="text" name="name"></td>
				<td align="left"><input class="input" style="width:300px;" type="text" name="statelabel"></td>
			</tr>
			<tr style="display: none;">
				<td class="commFont">
					<div id="formview1">{*[cn.myapps.core.workflow.binding_form]*}:</div>
				</td>
				<td class="commFont">
				</td>
			</tr>
			<tr style="display: none;">
				<td align="left" style="font-size:12px;">
					<div id="formview2">
						<input type="text" style="width:250px;" class="input" name="formname" value="" disabled="disabled">
						&nbsp;<input class="button-cmd" onClick="selectForm()" type="button" value="{*[Form]*}" />
						<input type="hidden" name="fieldpermlist" value=""> 
					</div>
				</td>
				<td>
					<input name="isFrontEdit" type="checkbox" id="isFrontEdit" value="true" />{*[cn.myapps.core.workflow.front_manual_adjustment_flow]*}
				</td>
			</tr>
		</table>
	</div>
	<div id="staff_set">
		<table class="table_noborder" border="1" style="border: #e0e0e0";>
			<tr>
				<td class="commFont" colspan="2">{*[cn.myapps.core.workflow.auditing_edit_mode]*}:</td>				
			</tr>
			<tr>
				<td align="left" class="commFont" colspan="2">
					<input type="radio" name="actorEditMode" value="0" onClick="modeChange(this.value)" checked>{*[Roles]*}
					<input type="radio" name="actorEditMode" value="1" style="display: none;" onClick="modeChange(this.value)">
					<input type="radio" name="actorEditMode" value="2" onClick="modeChange(this.value)">{*[User]*}
					<input name="isToPerson" type="checkbox" id="isToPerson" value="true" />{*[core.workflow.allows.designated.next.approval]*}
				</td>
			</tr>
			<tr id="actorEditModeTR0">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[cn.myapps.core.workflow.audit_role]*}: </td>
				</tr>
				<tr>
					<td align="left">
					    <input type="text" class="input" style="width:90%;" id="namelist_bak" readonly value="">
					 	<input type="text" class="input" name="namelist" id="namelist" readonly value="" style="display:none">
						<input class="button-cmd" onClick="selectField('rolelist','namelist', 'true')" type="button" value="{*[Choose]*}" />
					</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr id="actorEditModeTR1">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[cn.myapps.core.workflow.auditing_script]*}:</td>
				</tr>
				<tr>
					<td align="left" width="100%">
						<textarea style="width:100%;" name="actorListScript" rows="5"></textarea>
					</td>
					<td valign="bottom">
						<button type="button" class="button-image" onclick="openIscriptEditor('actorListScript','{*[cn.myapps.core.workflow.script_editor]*}',
						'{*[cn.myapps.core.workflow.auditing_script]*}','name','{*[Save]*}{*[Success]*}');">
						<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
					</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr id="actorEditModeTR2">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[cn.myapps.core.workflow.audit_user]*}: </td>
				</tr>
				<tr>
					<td align="left">
					    <input type="text" class="input" style="width:90%;" id="userList_bak" readonly value="">
					 	<input type="text" class="input" name="userList" id="userList" readonly value="" style="display:none">
						<input class="button-cmd" onClick="selectUsers('','userList', 'true')" type="button" value="{*[Choose]*}" />
					</td>
				</tr>
				</table>
			</td>
			</tr>
		</table>
	</div>
	<div id="cc_set">
		<table class="table_noborder" border="1" style="border: #e0e0e0";>
			<tr>
				<td class="commFont" colspan="2">{*[cn.myapps.core.workflow.open_send_or_not]*}:</td>				
			</tr>
			<tr>
				<td align="left" class="commFont" colspan="2">
					<input name="isCarbonCopy" type="checkbox" id="isCarbonCopy" value="true" onclick="onCcCheckboxClick(this)" />{*[开启抄送功能]*}
				</td>
			</tr>
			<tr><td class="commFont" colspan="2"><div id="cc_div" style="display: none"><table width="100%">
			<tr>
				<td class="commFont" colspan="2">{*[cn.myapps.core.workflow.send_edit_model]*}:</td>				
			</tr>
			<tr>
				<td align="left" class="commFont" colspan="2">
					<input type="radio" name="circulatorEditMode" value="0" onClick="circulatorEditModeChange(this.value)" checked>{*[Roles]*}
					<input type="radio" name="circulatorEditMode" value="1" style="display: none;" onClick="circulatorEditModeChange(this.value)">
					<input type="radio" name="circulatorEditMode" value="2" onClick="circulatorEditModeChange(this.value)">{*[User]*}
					<input name="isSelectCirculator" type="checkbox" id="isSelectCirculator" value="true" />{*[core.workflow.allows.designated.next.circulator]*}
				</td>
			</tr>
			<tr id="circulatorEditModeTR0">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[Role]*}: </td>
				</tr>
				<tr>
					<td align="left">
					    <input type="text" class="input" style="width:90%;" id="circulatorNamelist_bak" readonly value="">
					 	<input type="text" class="input" name="circulatorNamelist" id="circulatorNamelist" readonly value="" style="display:none">
						<input class="button-cmd" onClick="selectCirculatorNamelist('rolelist','circulatorNamelist', 'true')" type="button" value="{*[Choose]*}" />
					</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr id="circulatorEditModeTR1">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[cn.myapps.core.workflow.auditing_script]*}:</td>
				</tr>
				<tr>
					<td align="left" width="100%">
						<textarea style="width:100%;" name="circulatorListScript" rows="5"></textarea>
					</td>
					<td valign="bottom">
						<button type="button" class="button-image" onclick="openIscriptEditor('circulatorListScript','{*[cn.myapps.core.workflow.script_editor]*}',
						'{*[cn.myapps.core.workflow.auditing_script]*}','name','{*[Save]*}{*[Success]*}');">
						<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
					</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr id="circulatorEditModeTR2">
			<td colspan="2">
				<table style="width:100%;">
				<tr>
					<td class="commFont">{*[User]*}: </td>
				</tr>
				<tr>
					<td align="left">
					    <input type="text" class="input" style="width:90%;" id="circulatorNamelistByUser_bak" readonly value="">
					 	<input type="text" class="input" name="circulatorNamelistByUser" id="circulatorNamelistByUser" readonly value="" style="display:none">
						<input class="button-cmd" onClick="selectCirculators('rolelist','circulatorNamelistByUser', 'true')" type="button" value="{*[Choose]*}" />
					</td>
				</tr>
				</table>
			</td>
			</tr>
			</table></div></td></tr>
		</table>
	</div>
	<div id="shenpi_set">
		<table class="table_noborder"  border="1" style="border: #e0e0e0";>
			<tr>
				<td class="commFont">{*[cn.myapps.core.workflow.distribute]*}:</td>
				<td class="commFont">{*[cn.myapps.core.workflow.centralized]*}:</td>
			</tr>
			<tr>
				<td align="left">
				 <input type="radio" name="issplit" id="issplit" value="true">{*[step-by-step_approval_current_node,select_multiple_nodes]*}<br/>
				 <input type="radio" name="issplit" id="issplit" value="false" checked>{*[step-by-step_approval_current_node_only_choose]*}  
				</td>
				<td align="left">
				 <input type="radio" name="isgather" id="isgather" onclick="isgatherEvent(this.value)" value="true">{*[step-by-step_approval_node,select_multiple_nodes]*}
				 <br/>
				&nbsp;&nbsp;<font id="splitStartNodeLabel" color="red"  style="display:none">{*[cn.myapps.core.workflow.disperse_startnode]*}:</font><select id="splitStartNode" name="splitStartNode" style="display:none"></select>
				<br/>
				 <input type="radio" name="isgather" id="isgather"  onclick="isgatherEvent(this.value)" value="false" checked>{*[multiple-step_approval_nodes,completion_one_node,arrival_process]*}  
				</td>
			</tr>
		</table>
	</div>
	<div id="operate_set">
		<table class="table_noborder" border="1" style="border: #e0e0e0";>
			<tr>
				<td class="commFont">{*[cn.myapps.core.workflow.return_setup]*}:</td>
				<td class="commFont">{*[cn.myapps.core.workflow.retracement_setup]*}:</td>
			</tr>
			<tr>
				<td align="left">
				 <input type="radio" name="cBack" id="cBack" value="true" onClick="cBackChange(this.value)" checked>{*[cn.myapps.core.workflow.allow_return]*}
				 <input type="radio" name="cBack" id="cBack" value="false" onClick="cBackChange(this.value)" >{*[cn.myapps.core.workflow.not_allow_return]*}
				</td>
				<td align="left">
					<input type="radio" name="cRetracement" id="cRetracement" value="true" onClick="retracementEditModeChange(this)" >cn.myapps.core.workflow.can_retracement
 					<input type="radio" name="cRetracement" id="cRetracement" value="false" onClick="retracementEditModeChange(this)" checked>cn.myapps.core.workflow.can_not_retracement
 					<input style="display: none;" type="radio" name="cRetracement" id="retracementEditMode" value="1" onClick="retracementEditModeChange(this)"><div style="display: none;">{*[cn.myapps.core.workflow.script]*}</div>
				</td>
			</tr>
			<tr>
				<td align="left">
					<div id="backSetup" style="width:100%;">
						<table style="width:100%;">
							<tr>
								<td align="left">
									<input type="radio" name="backType" id="backType" value="0" onClick="backTypeChange(this.value)" checked>{*[cn.myapps.core.workflow.default_return]*}
					 				<input style="display: none;" type="radio" name="backType" id="backType" value="1" onClick="backTypeChange(this.value)" ><div style="display: none;">{*[cn.myapps.core.workflow.customized_return]*}</div>
					 				
								</td>
							</tr>
							<td align="left">
								<div id="back_cus_step" style="width:100%;" >
									<table style="width:100%;">
										<tr >
											<td align="left" class="commFont">{*[cn.myapps.core.workflow.node_list]*}:</td>
											<td align="left">
											<input type="hidden" name="bnodelist" id="bnodelist" value="">
											<input type="text" class="input" name="dbnodelist" id="dbnodelist" readonly value="">
											<input class="button-cmd" onClick="selectBackNodes('bnodelist','true')" type="button" value="{*[Choose]*}" /></td>
										</tr>
										
										
										
									</table>
								</div>
								
							</tr>
						</table>
					
					</div>
				</td>
				<td align="left">
					
					 
					<div id="retracementScriptSetup" style="width:100%; display: none;">
						<table style="width:100%;">
							<tr>
								<td align="left" width="100%">
									<textarea style="width:100%;" name="retracementScript" rows="5"></textarea>
								</td>
								<td valign="bottom">
									<button type="button" class="button-image" onclick="openIscriptEditor('retracementScript','{*[cn.myapps.core.workflow.script_editor]*}',
									'{*[cn.myapps.core.workflow.retracement_setup]*}','name','{*[Save]*}{*[Success]*}');">
									<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
								</td>
							</tr>
						</table>
					</div>
					
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[Condition_Type]*}:</td>
				<td class="commFont">
				</td>
			</tr>
			<tr>
				<td align="left" style="font-size:12px;">
					<input type="radio" name="passcondition" value="0" onClick="changeCondition()" onChange="changeCondition()" checked>{*[through_any_approval,node_through]*}<br> 
					<input type="radio" name="passcondition" value="1" onClick="changeCondition()" onChange="changeCondition()">{*[through_all_approval,node_through]*}<br>
				 	<!-- <input type="radio" name="passcondition" value="2" onClick="changeCondition()" onChange="changeCondition()">{*[the_current_approval_approval_who_decide_next_step]*} -->
				 </td>
				<td>
				</td>
			</tr>
		</table>
	</div>
	<div id="notice_remind_set">
		<table class="table_noborder"  border="1" style="border: #e0e0e0";>
			<tr id="notification">
				<td colspan="2" class="commFont">{*[Notification]*}:</td>
			</tr>
			<tr>
				<td colspan="2">
					<table border="0" bordercolor="#c3c3c3" cellspacing="0" style="height:100%; width:100%; align:left">
						<tr>
							<td class="commFont" nowrap="nowrap">{*[SendMode]*}:
								<input type="checkbox" name="sendMode" id="emailMode" value=0>{*[E-mail]*}
								<input type="checkbox" name="sendMode" id="smsMode" value=1>{*[cn.myapps.core.workflow.mobile_sms]*}
								<input type="checkbox" name="sendMode" id="msgMode" value=2>{*[PersonalMessage]*}
							</td>
						</tr>
						<tr>
							<td class="commFont">{*[cn.myapps.core.workflow.notification_type]*}:
								<input type="checkbox" name="notificationType" id="sendType" value="send" onclick="showTab(this, 'tab_send')">{*[Send]*}
								<input type="checkbox" name="notificationType" id="arriveType" value="arrive" onclick="showTab(this, 'tab_arrive')">{*[cn.myapps.core.workflow.arrive]*}
								<input type="checkbox" name="notificationType" id="rejectType" value="reject" onclick="showTab(this, 'tab_reject')">{*[cn.myapps.core.workflow.reject]*}
								<input type="checkbox" name="notificationType" id="overdueType" value="overdue" onclick="showTab(this, 'tab_overdue')">{*[cn.myapps.core.workflow.overdue]*}
							</td>
						</tr>
						<tr>
							<td>	
								<DIV id="div_notificationType" class="basictab">
									<ul>
										<li><a href='#' id='tab_send' rel='content_send' style='display:none;'>{*[Send]*}</a></li>
										<li><a href='#' id='tab_arrive' rel='content_arrive' style='display:none;'>{*[cn.myapps.core.workflow.arrive]*}</a></li>
										<li><a href='#' id='tab_reject' rel='content_reject' style='display:none;'>{*[cn.myapps.core.workflow.reject]*}</a></li>
										<li><a href='#' id='tab_overdue' rel='content_overdue' style='display:none;'>{*[cn.myapps.core.workflow.overdue]*}</a></li>
									</ul>
								</DIV>
							</td>
						</tr>
						<tr>
							<td>	
								<!-- container start -->	
								<DIV class="tabcontainer">
									<!-- -----------------------------SendNotice------------------------------------------- -->
									<div id='content_send' class="tabcontent" style='display:none;'>
										<table border="0" cellpadding="2" cellspacing="0" style="height:100%; width:100%; align:left">
											<tr><td class="commFont">
													{*[Receiver]*}:
													<input type="checkbox" name="sendReceiver" id="sendSubmitter" value=1>{*[cn.myapps.core.workflow.submitter]*}
													<input type="checkbox" name="sendReceiver" id="snedAuthor" value=16>{*[Author]*}
													<input type="checkbox" name="sendReceiver" id="sendOrigPrincipal" value=256 >{*[cn.myapps.core.workflow.origPrincipal]*}
												</td>
												<td class="commFont">
									      			{*[SendFormat]*}:
													<select name="sendTemplate" id="sendTemplate">
													</select>
										  		</td>
											</tr>
										</table>
									</div>
									
									<!-- -----------------------------ArrivesNotice------------------------------------------- -->
									<div id='content_arrive' class="tabcontent" style='display:none;'>
										<table border="0" cellpadding="2" cellspacing="0" style="height:100%; width:100%; align:left">
											<tr><td class="commFont">
									      		{*[SendFormat]*}:
												<select name="arriveTemplate" id="arriveTemplate">
												</select>
										  	</td>
										  	<td align="left"><input type="checkbox" id="smsApproval" name="smsApproval" />{*[smsApproval]*}</td>
										  	</tr>
										</table>
									</div>
									
									<!-- -----------------------------RejectNotice------------------------------------------- -->
									<div id='content_reject' class="tabcontent" style='display:none;'>
										<table border="0" cellpadding="2" cellspacing="0" style="height:100%; width:100%; align:left">
											<tr id="reject">
												<td class="commFont">{*[cn.myapps.core.workflow.rejectType]*}:
												 <select id="responsibleType">
								                       <option value="1">{*[cn.myapps.core.workflow.submitter]*}</option>
								                       <option value="16" selected="selected">{*[Author]*}</option>
								                       <option value="256">{*[cn.myapps.core.workflow.pending_personal]*}</option>
								                    </select>	
												</td>
												<td class="commFont">{*[SendFormat]*}:
													<select name="rejectTemplate" id="rejectTemplate">
													</select>
										  		</td>
											</tr>
										</table>
									</div>
									<!-- -----------------------------OverdueNotice------------------------------------------- -->
									<div id='content_overdue' class="tabcontent" style='display:none;'>
										<table border="0" cellpadding="2" cellspacing="0" style="height:100%; width:100%; align:left">
											<tr>
												<td class="commFont">{*[cn.myapps.core.workflow.isnotify_superior]*}:
												   	<input type="checkbox" name="isnotifysuperior" id="isnotifysuperior" value="true">
												</td>
												<td class="commFont">
													{*[TimeLimit]*}:
													<input type="text" class="input" name="limittimecount" value="" maxlength="3" size="3">
												    {*[Unit]*}:
													<select name="timeunit">
														<option value="0" selected="selected">{*[Hour]*}</option>
														<option value="1">{*[Day]*}</option>
													</select>
												</td>
												<td class="commFont">
										      		{*[SendFormat]*}:
										      		<select name="overdueTemplate" id="overdueTemplate">
													</select>
											  	</td>
											</tr>
										</table>
									</div>
								</DIV> 
								<!-- container end -->		
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<input id="notificationStrategyJSON" type="hidden" name="notificationStrategyJSON" />
</div>
</form>
</body>
</o:MultiLanguage></html>
