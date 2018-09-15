<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>
<%@ include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<s:bean name="cn.myapps.core.dynaform.summary.action.SummaryCfgHelper" id="sh">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<html><o:MultiLanguage>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper"
	id="viewHelper">
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="/script/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ActivityUtil.js"/>'></script>
<script language="JavaScript" src="dialog.js"></script>
<script language="JavaScript" src="script.js"></script>
<script language="JavaScript" src="sequence.js"></script>
<link href="../css/dialog.css" rel="stylesheet" type="text/css" />
<script src="common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>

<SCRIPT language="JavaScript">
var sAction = URLParams['action'] ;
var sTitle = "{*[Insert]*}";
var oControl;
var oSeletion;
var sRangeType;
var contextPath = '<%=request.getContextPath()%>';

var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;

var oActiveEl = dialog.Selection.GetSelectedElement() ;
function ev_init(fn1,fn2,fn3,fn4,fn5) {
	var instance = '<%= request.getParameter("application")%>';
	var mdlid = '<%= request.getParameter("moduleid")%>';
	var def1 = document.getElementsByName(fn1)[0].value;
	var def2 =  document.getElementsByName(fn2)[0].value;
	var def3 =  document.getElementsByName(fn3)[0].value;
	var def4 =  document.getElementsByName(fn4)[0].value;
	var def5 =  document.getElementsByName(fn5)[0].value;
	var beforescript = document.getElementById("beforescriptid");
	var afterscript = document.getElementById("afterscriptid");
	
	if (!document.getElementsByName(fn1)[0].value){def1 = oActiveEl && oActiveEl.getAttribute('actType') ? oActiveEl.getAttribute('actType') : ''}
	if (!document.getElementsByName(fn2)[0].value){def2 = oActiveEl && oActiveEl.getAttribute('actionView') ? oActiveEl.getAttribute('actionView') : ''}
	if (!document.getElementsByName(fn3)[0].value){def3 = oActiveEl && oActiveEl.getAttribute('actionForm') ? oActiveEl.getAttribute('actionForm') : ''}
	if (!document.getElementsByName(fn4)[0].value){def4 = oActiveEl && oActiveEl.getAttribute('actionFlow') ? oActiveEl.getAttribute('actionFlow') : ''}
	if (!document.getElementsByName(fn5)[0].value){def5 = oActiveEl && oActiveEl.getAttribute('actionPrint') ? oActiveEl.getAttribute('actionPrint') : ''}
	else if (document.getElementsByName(fn1)[0].value=='none'){
		def2 = 'none';
		def3 = 'none';
		def4 = 'none';
		def5 = 'none'
	}

	jumpMode_tr.style.display = "none";
	jumpActProp_tr.style.display = "none";
	jumpActOpenType_tr.style.display = "none";
	dispatcherMode_tr.style.display = "none";
	dispatcherUrl_tr.style.display = "none";
	dispatcherParams_tr.style.display = "none";
	transpond_tr.style.display = "none";


	
	oview_tr.style.display = "none";
	oflow_tr.style.display = "none";	
	oform_tr.style.display = "none";
	oprint_tr.style.display = "none";
	ofilename_tr.style.display = "none";
	approve_tr.style.display = "none";
	beforescript.style.display = "";
	afterscript.style.display = "";
	oexcelconfig_tr.style.display = "none";
	editMode_tr.style.display = "none";
	startFlowScript_tr.style.display = "none";
	fshowtype_tr.style.display = "none";
	withOld_tr.style.display = "none";
	
	var func = new Function("ev_init('"+fn1+"','"+fn2+"','"+fn3+"','"+fn4+"','"+fn5+"')");
	
	document.getElementsByName(fn1)[0].onchange = func;
	
	ActivityUtil.createFormTypeExceptJUMPAndDispatcher(fn1,def1,function(str) {var func=eval(str);func.call();removeDeprecatedActivityTypeOption();}); // 创建表单选项
	
	ActivityUtil.createOnActionView(fn2,def1,mdlid,def2,instance,function(str) {var func=eval(str);func.call()});
	ActivityUtil.createOnActionForm(fn3,def1,mdlid,def3,instance,function(str) {var func=eval(str);func.call()});
	ActivityUtil.crateOnActionFlow(fn4,def1,mdlid,def4,function(str) {var func=eval(str);func.call()});
	ActivityUtil.createOnActionPrint(fn5,def1,mdlid,def5,function(str) {var func=eval(str);func.call()});
	switch (def1.toString()) { 
		case '1':
			oview_tr.style.display = "";
			break;
		case '5':
			oflow_tr.style.display = "";
			break;
		case '6':
			afterscript.style.display = "none";
			break;
		case '2':
			oform_tr.style.display = "";
			break;
		case '18':
			oform_tr.style.display = "";
			break;
		case '20':
			approve_tr.style.display = "";
			break;
		case '26':
			ofilename_tr.style.display = "";
			break;
		case '27':
			oexcelconfig_tr.style.display = "";
			break;
		case '30':
			oprint_tr.style.display = "";
			break;
		case '39':
			dispatcherMode_tr.style.display = "";
			dispatcherUrl_tr.style.display = "";
			dispatcherParams_tr.style.display = "";
			break;
		case '37':
			transpond_tr.style.display = "";
			break;
		case '41'://流程处理动作类型
			editMode_tr.style.display = "";
			fshowtype_tr.style.display="";
			document.getElementById("_editMode_2").style.display = "";
			if(document.getElementsByName("flowMode")[0].checked){
				oflow_tr.style.display = "";
			}else if(document.getElementsByName("flowMode")[1].checked){
				
			}else if(document.getElementsByName("flowMode")[2].checked){
				startFlowScript_tr.style.display = "";
			}
				
			break;
		case '42':
			withOld_tr.style.display = "";
			break;
		case '43':
			jumpMode_tr.style.display = "";
			jumpActOpenType_tr.style.display = "";
			document.getElementById("beforescriptid").style.display = "none";
			document.getElementById("afterscriptid").style.display = "none"; // 隐藏执行后脚本
			initJumpMode();
			initJumpActOpenType();
			break;
		default:
			break;
		}
}

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<5;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";
	
	for (var i=1;i<5;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
	resize();
}

//document.write("<title>{*[ButtonField]*}{*[Property]*}（" + sTitle + "）</title>");

function setSelectAttr(){
	for(i=0;i<temp.actType.options.length;i++){
		if(oActiveEl.getAttribute('actType')==temp.actType.options[i].value){
		    temp.actType.selectedIndex = i;
			break;
		}
	}
	for(i=0;i<temp.actionFlow.options.length;i++){
		if(temp.actionFlow.options[i].value==GetAttribute( oActiveEl, 'actionFlow' )){
		    temp.actionFlow.selectedIndex = i;
			break;
		}
	} 
	for(i=0;i<temp.actionView.options.length;i++){
		if(GetAttribute(oActiveEl, 'actionView')==temp.actionView.options[i].value){
		    temp.actionView.selectedIndex = i;
			break;
		} 
	}
	for(i=0;i<temp.actionForm.options.length;i++){
		if(GetAttribute(oActiveEl, 'actionForm')==temp.actionForm.options[i].value){
		    temp.actionForm.selectedIndex = i;
			break;
		}
	}

	for(i=0;i<temp.actionPrint.options.length;i++){
		if(GetAttribute(oActiveEl, 'actionPrint')==temp.actionForm.options[i].value){
		    temp.actionPrint.selectedIndex = i;
			break;
		}
	}
	
	for(i=0;i<temp.impmappingconfigid.options.length;i++){
		if(oActiveEl.getAttribute('impmappingconfigid')==temp.impmappingconfigid.options[i].value){
		    temp.impmappingconfigid.selectedIndex = i;
			break;
		} 
	}
}
//初始值
function InitDocument(){
	var editMode;
	oEditor.FCKLanguageManager.TranslatePage(document);
	ev_init('content.type','_onActionViewid','_onActionFormid','_onActionFlowid','_onActionPrintid');
	//初始化ispatcherMode
	initDispatcherMode();
	//初始化ispatcherParams
	initDispatcherParams();
	
	if ( oActiveEl && (oActiveEl.tagName == 'INPUT'))
	{
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}
		// 脚本部分
		if(oActiveEl.getAttribute('refreshOnChanged')!=null){
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		}else{
			temp.refreshOnChanged.checked = false;
		}
			
		if(oActiveEl.getAttribute('calculateOnRefresh')!=null){
			temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		}else{
			temp.calculateOnRefresh.checked = false;
		}
		
		if(oActiveEl.getAttribute('hiddenScript')!=null){
			temp.hiddenScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenScript'));
		}

			
		if(oActiveEl.getAttribute('hiddenValue')!=null){
			temp.hiddenValue.value = HTMLDencode(oActiveEl.getAttribute('hiddenValue'));
		}

		if(oActiveEl.getAttribute('hiddenPrintScript')!=null){
			temp.hiddenPrintScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenPrintScript'));
		}

		if(oActiveEl.getAttribute('printHiddenValue')!=null){
			temp.printHiddenValue.value = HTMLDencode(oActiveEl.getAttribute('printHiddenValue'));
		}

		if(oActiveEl.getAttribute('readonlyScript')!=null){
			temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));	
		}

		if(oActiveEl.getAttribute('fileNameScript')!=null){
			temp.fileNameScript.value = HTMLDencode(oActiveEl.getAttribute('fileNameScript'));
		}

		if(oActiveEl.getAttribute('stateToShow')!=null){
			temp.stateToShow.value = HTMLDencode(oActiveEl.getAttribute('stateToShow'));
		}

		if(oActiveEl.getAttribute('approveLimit')!=null){
			temp.approveLimit.value = HTMLDencode(oActiveEl.getAttribute('approveLimit'));
		}

		if(oActiveEl.getAttribute('beforeActionScript')!=null){
			temp.beforeActionScript.value = HTMLDencode(oActiveEl.getAttribute('beforeActionScript'));
		}

		if(oActiveEl.getAttribute('afterActionScript')!=null){
			temp.afterActionScript.value = HTMLDencode(oActiveEl.getAttribute('afterActionScript'));
		}

		//新增页面跳转属性
		if(oActiveEl.getAttribute('dispatcherMode')!=null){
		initmaximization(oActiveEl.getAttribute('dispatcherMode'));
		}

		if(oActiveEl.getAttribute('dispatcherUrl')!=null){
		temp.dispatcherUrl.value = HTMLDencode(oActiveEl.getAttribute('dispatcherUrl'));
		}

		if(oActiveEl.getAttribute('jumpType')!=null){
			var value = HTMLDencode(oActiveEl.getAttribute('jumpType'));
			document.getElementsByName('jumpType')[value].click();
		}

		if(oActiveEl.getAttribute('jumpMode')!=null){
			setJumpModeValue(oActiveEl.getAttribute('jumpMode') + '');
		}

		if(oActiveEl.getAttribute('jumpActOpenType')!=null){
			setJumpActOpenTypeValue(oActiveEl.getAttribute('jumpActOpenType') + '');
		}

		if(oActiveEl.getAttribute('targetList')!=null){
			temp.targetList.value = HTMLDencode(oActiveEl.getAttribute('targetList'));
		}
		if(oActiveEl.getAttribute('flowMode')!=null){
			setRadioValue('flowMode',oActiveEl.getAttribute('flowMode'));
		}

		if(oActiveEl.getAttribute('startFlowScript')!=null){
			temp.startFlowScript.value = HTMLDencode(oActiveEl.getAttribute('startFlowScript'));
		}

		if(oActiveEl.getAttribute('transpond')!=null){
			temp.transpond.value = HTMLDencode(oActiveEl.getAttribute('transpond'));
		}
		
		if(oActiveEl.getAttribute('withOld')!=null){
			temp.withOld.checked = oActiveEl.getAttribute('withOld') == "true";
		}else{
			temp.withOld.checked = false;
		}
		
		if(oActiveEl.getAttribute('mobile')!=null){
			//temp.mobile.checked = oActiveEl.getAttribute('mobile') == "true";
			temp.mobile.checked = true;
		}else{
			temp.mobile.checked = false;
		}
		//------------------------
	    if(oActiveEl.getAttribute('filtercondition')!=null){
			temp.filtercondition.value = oActiveEl.getAttribute('filtercondition');		
	    }
	    /*
	    if(oActiveEl.getAttribute('refreshFields')!=null){
	    	initLocalRefreshMappRow(oActiveEl.getAttribute('refreshFields'));
		}
	     var refreshMode="0";
	    if(oActiveEl.getAttribute('refreshMode')!=null){
	    	refreshMode = oActiveEl.getAttribute('refreshMode');
		}
	    var refreshModes = document.getElementsByName("refreshMode");
		for(var i=0;i<refreshModes.length;i++){
			if(refreshModes[i].value == refreshMode){
				refreshModes[i].checked=true;
				break;
			}
		}
		refreshModeChange(refreshMode); 
	    refreshOnChangedClick(document.getElementsByName("refreshOnChanged")[0]);*/
	    //------------------------
		window.setTimeout("setSelectAttr()",300);//firefox中加载机制不同，延迟等数据加载完成后再设置
	}
	else
		oActiveEl = null ;
	//------------------------------------------------------------------------	
	var moduleSelect = document.getElementById("moduleSelect");
	var formSelect = document.getElementById("formSelect");
	var targetList = document.getElementById("targetList").value;
	var formDefValue ='';
	if(targetList){
		formDefValue = targetList.split("|")[0];
		moduleSelect.value =  targetList.split("|")[1];
	}
	// before initialize
	moduleSelect.onchange = function(){
		addFormOptions(moduleSelect, formSelect.id, formDefValue);
		moduleSelect.onchange = function(){
			addFormOptions(moduleSelect, formSelect.id);
		};
	};

	moduleSelect.onchange();
	
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	//SelectField( 'name' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_button");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();
	 _getFormFields();
}
function cleanPromptVal(){
	jQuery("#beforeScriptButton").click(function(){
		if(jQuery("#beforeActionScript").val() == jQuery("#beforeActionScript").attr("title"))
			jQuery("#beforeActionScript").val("");
		openIscriptEditor('beforeActionScript','{*[Script]*}{*[Editor]*}','{*[ActionScript]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#afterScriptButton").click(function(){
		if(jQuery("#afterActionScript").val() == jQuery("#afterActionScript").attr("title"))
			jQuery("#afterActionScript").val("");
		openIscriptEditor('afterActionScript','{*[Script]*}{*[Editor]*}','{*[AfterActionScript]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#readonlyScriptButton").click(function(){
		if(jQuery("#readonlyScript").val() == jQuery("#readonlyScript").attr("title"))
			jQuery("#readonlyScript").val("");
		openIscriptEditor('readonlyScript','{*[Script]*}{*[Editor]*}','{*[ReadOnly_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenScriptButton").click(function(){
		if(jQuery("#hiddenScript").val() == jQuery("#hiddenScript").attr("title"))
			jQuery("#hiddenScript").val("");
		openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenPrintScriptButton").click(function(){
		if(jQuery("#hiddenPrintScript").val() == jQuery("#hiddenPrintScript").attr("title"))
			jQuery("#hiddenPrintScript").val("");
		openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}')
	});
}
function selectedOne(Obj, value, callback) {
	if (Obj != null) {
		for (i = 0; i < Obj.options.length; ++i)
			if (Obj.options[i].value == value) {
				Obj.selectedIndex = i;
				if (callback) {
					callback(Obj);
				}
				break;
			}
	}
}

function getSelectedValueById(id){
	var actType = document.getElementById(id);
	var temp;
	if(actType!=null){
		temp= actType.options[actType.selectedIndex].value;
	}
	return temp;
}

function getJumpModeValue(name){
	var jumpmode = document.getElementsByName(name);
	var temp = 0;
	for (var i=0;i < jumpmode.length;i++){  
		if (jumpmode[i].checked) {
			temp = jumpmode[i].value;
			break;
		}		
	}
	return temp;
}
function setJumpModeValue(value){
	var typevalue = oActiveEl.getAttribute('actType');
	var jumpmode = document.getElementsByName('jumpMode');
	if (value && typevalue == '43') {
		jumpmode[value].click();
	}		
}

function getJumpActOpenTypeValue(name){
	var jumpActOpen = document.getElementsByName(name);
	var temp = 0;
	for (var i=0;i < jumpActOpen.length;i++){  
		if (jumpActOpen[i].checked) {
			temp = jumpActOpen[i].value;
			break;
		}		
	}
	return temp;
}
function setJumpActOpenTypeValue(value){
	var typevalue = oActiveEl.getAttribute('actType');
	var jumpActOpenType = document.getElementsByName('jumpActOpenType');
	if (value && typevalue == '43') {
		jumpActOpenType[value].click();
	}		
}

function setRadioValue(name,value){
	var radio = document.getElementsByName(name);
	for (var i=0;i < radio.length;i++){ 
		if(!radio[i].checked && radio[i].value==value){
			radio[i].click();
			break;
		}
	}
}

function Ok(){
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(ev_check()){
	oEditor.FCKUndo.SaveUndoStep() ;
	//初始化initJumpMode
	//initJumpMode();
	initTargetList();
	initDispatcherMode();
	var typeSelect = document.getElementsByName('content.type')[0];
	if(typeSelect.value == 39 || typeSelect.value == 43) {
		//保存前把参数(json格式)赋给隐藏域
		document.getElementsByName('content.dispatcherParams')[0].value = buildQueryString();
		
	}
	var className="cn.myapps.core.dynaform.form.ejb.ButtonField";
	var id=getFieldId();	
	
	//--------------------
	/* var refreshModeEls=document.getElementsByName("refreshMode");  
	var refreshMode="0";   
	for(var i=0;i<refreshModeEls.length;i++){
	  if(refreshModeEls[i].checked){
		  refreshMode = refreshModeEls[i].value;
		  break;
      }
    } */
	//--------------------
	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'INPUT', {
									classname: className,
									id: id,
									type:"button",
									value:temp.name.value,
									name: GetE('name').value,
									hiddenScript:HTMLEncode(GetE('hiddenScript').value),
									hiddenValue:HTMLEncode(GetE('hiddenValue').value),
									hiddenPrintScript:HTMLEncode(GetE('hiddenPrintScript').value),
									printHiddenValue:HTMLEncode(GetE('printHiddenValue').value),
									readonlyScript:HTMLEncode(GetE('readonlyScript').value),
									refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
									calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
									mobile: HTMLEncode(temp.mobile.checked+""),
									fileNameScript:HTMLEncode(temp.fileNameScript.value),
								    stateToShow:temp.stateToShow.value,
								    approveLimit:temp.approveLimit.value,
								    beforeActionScript:HTMLEncode(temp.beforeActionScript.value),
								    afterActionScript:HTMLEncode(temp.afterActionScript.value),
									
								    dispatcherUrl:HTMLEncode(temp.dispatcherUrl.value),
								    dispatcherMode:getdispatcherMode(),
								    dispatcherParams:HTMLEncode(temp.dispatcherParams.value),
								    actType:HTMLEncode(getSelectedValue(temp.actType)),
								   	actionView:HTMLEncode(getSelectedValue(temp.actionView)),
								   	actionForm:HTMLEncode(getSelectedValue(temp.actionForm)),
								   	actionFlow:HTMLEncode(getSelectedValue(temp.actionFlow)),
								   	transpond:HTMLEncode(temp.transpond.value),
								    actionPrint:HTMLEncode(GetE('actionPrint').value),
								    jumpType:GetE('jumpType').value,
								    jumpMode:getJumpModeValue('jumpMode'),
								    jumpActOpenType:getJumpActOpenTypeValue('jumpActOpenType'),
								    targetList:GetE('targetList').value,
								    flowMode:getJumpModeValue('flowMode'),
								    withOld:HTMLEncode(temp.withOld.checked+""),
								    startFlowScript:HTMLEncode(temp.startFlowScript.value),
								    flowShowType:HTMLEncode(getSelectedValue(temp.flowShowType)),
									//refreshMode:refreshMode,
									//refreshFields:HTMLEncode(getRefreshFieldsValue()),
								   	impmappingconfigid:HTMLEncode(getSelectedValue(temp.impmappingconfigid))
									} 
								   ) ;	
	//alert("temp._onActionViewid.options[temp._onActionViewid.selectedIndex].value-->"+temp._onActionViewid.options[temp._onActionViewid.selectedIndex].value);
	return true;
	}
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	return false;
}

function initmaximization(value){
	  var maximization = document.getElementsByName('dispatcherMode');
	  if(maximization.length>0){
	  for(var i=0;i<maximization.length;i++){
	  if(maximization[i].value == value){
	  maximization[i].checked=true;
	  }
	  }
	  }
	}

function getdispatcherMode(){
	  var value= '';
	  var dispatcherMode = document.getElementsByName('dispatcherMode');	  
	  if(dispatcherMode.length>0){
	  for(var i=0;i<dispatcherMode.length;i++){
	  if(dispatcherMode[i].checked){
	     value = dispatcherMode[i].value;
	  }
	  }
	  }
	  return value;
	}

function addFormOptions(oModule, relatedFormId, defValues) {
	FormHelper.get_formListByModuleType(oModule.value, function(options) {
		var oFormSelect = document.getElementById(relatedFormId);
		//DWRUtil.removeAllOptions(oSelectedList.id);
		addOptions(relatedFormId, options, defValues);
	});
}

function addOptions(relatedFormId, options, defValues){
	var el = document.getElementById(relatedFormId);
	if(relatedFormId){
		DWRUtil.removeAllOptions(relatedFormId);
		DWRUtil.addOptions(relatedFormId, options);
		if (defValues) {
			DWRUtil.setValue(relatedFormId, defValues);
		}
		if (el.onchange && typeof(el.onchange) == "function") {
			el.onchange();
		}
	}
}

//onclick JumpMode
function ev_jumpMode_click(object){
	if(object){
		if(object.value == 0){
			document.getElementById('jumpActProp_tr').style.display = "";
			document.getElementsByName("jumpType")[0].checked = true;
			document.getElementById('_jumpType_ul').style.display = "none";
			document.getElementById('dispatcherMode_tr').style.display = "none";
			document.getElementById('dispatcherUrl_tr').style.display = "none";
			document.getElementById('dispatcherParams_tr').style.display = "none";
		}else{
			document.getElementById('jumpActProp_tr').style.display = "none";
			document.getElementById('dispatcherMode_tr').style.display = "none";
			document.getElementById('dispatcherUrl_tr').style.display = "";
			document.getElementById('dispatcherParams_tr').style.display = "";
		}
	}
}

//初始化 TargetList
function initTargetList(){
	var selectList = document.getElementById("formSelect");
	var targetList = document.getElementById("targetList");
	setSelectedValuesToField(targetList, selectList);
}
function setSelectedValuesToField(oField, oSel, separator){
	if (!oField || oSel.value == "") return;
	oField.value = '';
	var moduleid = document.getElementById("moduleSelect").value;
	oField.value +=oSel.value +"|"+moduleid;
}

//初始化JumpMode
function initJumpMode(){
	var types = document.getElementsByName("jumpMode");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
		types[0].click();
	}
}

//初始化jumpActOpenType
function initJumpActOpenType(){
	var types = document.getElementsByName("jumpActOpenType");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
		types[0].click();
	}
}

//初始化DispatcherMode
function initDispatcherMode(){
	var types = document.getElementsByName("dispatcherMode");
	var flag = true;
	for (var i=0;i < types.length;i++){  
		if (types[i].checked) {
			types[i].click(); // on type change;
			flag = false;
			break;
		}		
	}
	if (flag) {
	  	types[0].click();
	}
}

//初始化DispatcherParams
function initDispatcherParams(){
	//回显已设置的参数
	//var str = document.getElementsByName('content.dispatcherParams')[0].value;
	var dispatcherParams = oActiveEl && oActiveEl.getAttribute('dispatcherParams')? HTMLDencode(oActiveEl.getAttribute('dispatcherParams')) : '';
	temp.dispatcherParams.value = dispatcherParams;
	var datas = parseRelStr(dispatcherParams);
	addRows(datas);
}

//生成请求参数
function buildQueryString(){
	var pkey = document.getElementsByName("paramKey");
	var pvalue = document.getElementsByName("paramValue");
	var str = '[';
	for (var i=0;i<pkey.length;i++) {
		if (pkey[i].value != '' && pvalue[i].value != '' ){
				str += '{';
				str += pkey[i].name +':\''+pkey[i].value+'\',';
				str += pvalue[i].name +':\''+pvalue[i].value+'\'';
				str += '},';
		}
	}
	str += ']';
	return  str;	

}

//根据mapping str获取data array
function parseRelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();	
	}
}

var rowIndex = 0;
var getParamKey = function(data) {
		if (data != null && data != undefined) {
	  	var s =''; 
		s +='<input type="text" id="paramKey'+ rowIndex +'" name="paramKey" style="width:100" value="'+HTMLDencode(data.paramKey)+'" />';
		return s; 
	}
};

var getParamValue = function(data) {
	if (data != null && data != undefined) {
	  	var s =''; 
		s +='<input type="text" id="paramValue'+ rowIndex +'" name="paramValue" style="width:100" value="'+HTMLDencode(data.paramValue)+'" />';
		return s; 
	}
};

var getDelete = function(data) {
	if (data != null && data != undefined) {
		
	  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
	  	rowIndex ++;
	  	return s;
	}
};

//根据数据增加行
function addRows(datas) {
	var cellFuncs = [getParamKey, getParamValue, getDelete];

	var rowdatas = datas;
	if (!datas || datas.length == 0) {
		var data = {paramKey:'', paramValue:''};
		rowdatas = [data];
	}
	DWRUtil.addRows("tb", rowdatas, cellFuncs);
	
}

//删除一行
function delRow(elem, row) {
	if (elem) {
		elem.deleteRow(row.rowIndex);
		//rowIndex --;
	}
}




//检查内容是否完成正确
function ev_check(){
	var typeSelect = document.getElementsByName('content.type')[0];
   if(temp.name.value==''){
 	 alert("{*[page.name.notexist]*}");
	  return false;
   }else if(HTMLEncode(getSelectedValue(temp.actType))==0){
	   alert("{*[please.choose.type]*}");
      return false;
   }else if(typeSelect.value == 26 && HTMLEncode(temp.fileNameScript.value)==''){
	   alert("文件名称脚本必填");
	   //window.showMessage("error", "{*[文件名称脚本必填]*}");
	   return false;
   }else if(typeSelect.value == 37 && HTMLEncode(temp.transpond.value)==''){
	   alert("请选择摘要模板");
	   return false;
   }else if(typeSelect.value == 43){
		var moduleSelect = document.getElementsByName('moduleSelect')[0].value;
		var formSelect = document.getElementById('formSelect').value;
	    var jumpMode = document.getElementsByName('jumpMode');
	    var dispatcherUrl = document.getElementById("dispatcherUrl").value;
		if(jumpMode[0].checked && (!moduleSelect || !formSelect)){
			alert("{*[page.core.dynaform.activity.content.jump.validate]*}");
			return false;
		}else if(jumpMode[1].checked && dispatcherUrl.replace(/(^\s*)|(\s*$)/g, "")==""){
			alert("{*[cn.myapps.core.dynaform.activity.content.tips.dispatcher_url_must_be]*}");
			return false;
		}
	}
   /* var refreshMode="0";
   var refreshModeEls=document.getElementsByName("refreshMode");  
   for(var i=0;i<refreshModeEls.length;i++){
   	if(refreshModeEls[i].checked){
   		refreshMode = refreshModeEls[i].value;
 	  	break;
      }
   }
   var refreshOnChangedEls=document.getElementsByName("refreshOnChanged");
   if(refreshMode=="1" && getRefreshFieldsValue().length==0 && refreshOnChangedEls[0].checked){
 		alert('{*[cn.myapps.core.dynaform.form.field.valid.msg.refreshfield_not_empty]*}');
 		return false;
 	} */
   return !checkStartChar(temp.name.value);
}

function checkStartChar(value){
	return IsDigit(value,"{*[page.name.check]*}");
}

function IsDigit(s,msg){
    var patrn = /^(?![0-9])[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
                 
	if(s=="action"){
		if (!patrn.exec(s)) alert(msg);
	   	alert("action为关键字，不能作为字段名！");
	   	return true;
   	}else if (!patrn.exec(s)){
		alert(msg);
		return true;
	}
	return false;
} 

function selectField(actionName, field){
	var applicationid = '<%= request.getParameter("application")%>';
	var url = contextPath + '/core/workflow/statelabel/'+ actionName +'.action?application=' + applicationid;
	//alert("url-->"+url);
	if (field != '' && field != null) {
		url = url + '&field=' + field;
	}
	//alert("url-->"+url);
	var oField = document.getElementsByName('content.' + field)[0];
	//var rtn = window.showModalDialog(url, oField, "dialogHeight:400px; dialogWidth:300px; status:no; scroll:no;");
	OBPM.dialog.show({
		width: 300,
		height: 400,
		url: url,
		args: {},
		title: '选择状态',
		close: function(rtn) {
			if(rtn){
				oField.value = rtn;
			} else if (rtn == '') {
				oField.value = rtn;
			}
		}
	});
}

/**
 * 删除过时的操作按钮动作类型选项
 */
function removeDeprecatedActivityTypeOption(){
	if(oActiveEl==null || oActiveEl==undefined){
		var types = document.getElementsByName('content.type')[0];
		for(var i=0;i<types.options.length;i++){
			var value = types.options[i].value;
			if(value==33 || value==4 || value==5 || value==12 || value==17 || value==9 || value==32 || value==39){//需要屏蔽的动作类型
				 types.options.remove(i);
				 removeDeprecatedActivityTypeOption();
			}
		}
	}else{
		document.getElementsByName('content.type')[0].disabled = true;
	}
}
function ev_onEditMode_click(value){
	if(value==0){
		startFlowScript_tr.style.display = "none";
		oflow_tr.style.display = "none";
		fshowtype_tr.style.display="";
	} else if(value==1){
		startFlowScript_tr.style.display = "";
		oflow_tr.style.display = "none";
	} else if(value==2){
		startFlowScript_tr.style.display = "none";
		oflow_tr.style.display = "";
	}
}
</script>

</HEAD>

<BODY onload="InitDocument()">

<s:form name="temp" theme="simple">
		<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
			id="mh">
			<s:param name="applicationid" value="%{#parameters.application}" />
		</s:bean>
		<input type="hidden" id="targetList" name="targetList" value="">
		<table border="0" cellpadding="3" cellspacing="0" width="520px">
			<tr align=center>
				<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(2)" id="card2">{*[Hidden_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(3)" id="card3">{*[Hidden_Print_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(4)" id="card4">{*[ReadOnly_Script]*}</td>
				<td width=2></td>
			</tr>
			<tr style="overflow:auto;height:215px;width:100%">
				<td id="error" valign="middle" colspan="12" bgcolor="#ffffff" align="center"
					width="100%">
				<!-- content1 -->
				<div style="overflow-y:auto;height:250px;">
				<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1" width="520px">
					<tr>
						<td class="commFont commLabel">{*[Name]*}:</td>
						<td align="left"><s:textfield id="name" name="name" cssStyle="width:100%;"/></td>
					</tr>
					
					<tr>
						<td align="left" colspan="2" style="padding-left: 140px;">
							<input type=checkbox name="refreshOnChanged" style="display: none;" value="true"><!-- {*[cn.myapps.core.dynaform.activity.reflash]*}<br/> -->
							<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
							<input type="checkbox" name="mobile" value="true" checked style="display:none" /><!-- {*[cn.myapps.core.dynaform.activity.phone]*}<br/> -->
						</td>
					</tr>
					<tr>
					    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.action]*}:</td>
						<td align="left"><s:select id="actType" cssStyle="width:100%" emptyOption="true" name="content.type" list="{}" /></td>
					</tr>
					
					<tr id="withOld_tr">
					    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.withold]*}:</td>
						<td align="left"><s:checkbox id="withOld" name="withOld" theme="simple" value="false"/></td>
					</tr>
					
					<tr id="transpond_tr" style="display:none">
					    <td class="commFont commLabel">{*[core.dynaform.form.activity.transpond.template]*}:</td>
						<td align="left"><s:select id="transpond" emptyOption="false" name="transpond" 
							list="#sh.getSummaryByFormIdAndScope(#parameters.formid,1)" /></td>
					</tr>
			
					<tr id="oview_tr">
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.onActionView]*}:</td>
						<td align="left"><s:select id="actionView" cssStyle="width:100%;" emptyOption="true" name="_onActionViewid" list="{}" /></td>
					</tr>
			
					<tr id="oform_tr">
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.onActionForm]*}</td>
						<td align="left"><s:select id="actionForm" cssStyle="width:100%;" emptyOption="true"  name="_onActionFormid" list="{}" /></td>
					</tr>
					
										
					<tr id ="editMode_tr">
			  			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.process_startup_mode]*}:</td>
						<td>
						<div id="_editMode_2"><input type="radio" name="flowMode" value="2" onClick="ev_onEditMode_click(this.value)" checked>{*[cn.myapps.core.dynaform.activity.attr.editMode.predefined]*}</div>
						<div><input type="radio" name="flowMode" value="0" onClick="ev_onEditMode_click(this.value)" >{*[cn.myapps.core.dynaform.activity.attr.editMode.select_by_user]*}</div>
						<div><input type="radio" name="flowMode" value="1" onClick="ev_onEditMode_click(this.value)">{*[cn.myapps.core.dynaform.activity.attr.editMode.iscript]*}</div>
						</td>
					</tr>
			
					<tr id="oflow_tr">
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.onActionFlow]*}</td>
						<td align="left"><s:select id="actionFlow" cssStyle="width:100%;" emptyOption="true" name="_onActionFlowid" list="{}" /></td>
					</tr>
					
										
					<tr id ="startFlowScript_tr">
			  			<td class="commFont commLabel">{*[StartFlowScript]*}:</td>
						<td><s:textarea id="startFlowScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.start_flow_script]*}*/" cssClass="input-cmd" cssStyle="width:92%;" name="startFlowScript" cols="50" rows="3" />
						<button type="button" class="button-image" onclick="openIscriptEditor('content.startFlowScript','{*[Script]*}{*[Editor]*}','{*[StartFlowScript]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="Open with IscriptEditor" src="<s:url value='/resource/image/editor.png' />"/></button>
						</td>
					</tr>
					
					<tr id="fshowtype_tr">
					    <td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.flowInfoShowType]*}:</td>
						<td align="left">
							<s:select id="flowShowType" cssStyle="width:350px;" emptyOption="false" name="flowShowType" list="#{'ST01':'{*[cn.myapps.core.dynaform.activity.flowInfoShowType.default]*}','ST02':'{*[cn.myapps.core.dynaform.activity.flowInfoShowType.div]*}','ST03':'{*[cn.myapps.core.dynaform.activity.flowInfoShowType.hide]*}'}" />
						</td>
					</tr>
			
					<tr id="ofilename_tr">
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.filePathScript]*}:</td>
						<td><s:textarea id="fileNameScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.new_file_and_return]*}*/" cssClass="input-cmd" cssStyle="width:92%;" name="content.fileNameScript" cols="50" rows="3" />
						<button type="button" style="border:0px;cursor: pointer;" onclick="openIscriptEditor('content.fileNameScript','{*[Script]*}{*[Editor]*}','{*[cn.myapps.core.dynaform.activity.label.filePathScript]*}','name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
						</td>
					</tr>
	
					<tr id="oexcelconfig_tr">
						<s:bean name="cn.myapps.core.dynaform.dts.excelimport.config.action.ImpHelper" id="hepler" />
						<td class="commFont commLabel">{*[Import]*}{*[MappingConfig]*}:</td>
						<td><s:select id="impmappingconfigid" name="_impmappingconfigid" cssStyle="width:350px;" list="#hepler.get_allMappingConfig(#parameters.application)" listKey="id" listValue="name" theme="simple" emptyOption="true" /></td>
					</tr>
		
		<tr id="jumpMode_tr">
			<td class="commFont commLabel">{*[Type]*}:</td>
			<td>
				<div><input type="radio" name="jumpMode" value="0" onClick="ev_jumpMode_click(this)" >{*[cn.myapps.core.dynaform.activity.type.jump.form]*}
				<input type="radio" name="jumpMode" value="1" onClick="ev_jumpMode_click(this)">{*[cn.myapps.core.dynaform.activity.type.jump.url]*}</div>
				<!-- 
				<s:radio id="jumpMode" name="jumpMode"
						theme="simple" cssStyle="width:25px;" onclick="ev_jumpMode_click(this)"
						list="#{0:'{*[跳转到动态表单]*}',1:'{*[跳转到指定URL]*}'}"></s:radio>
				 -->
			</td>
		</tr>
		<tr id="jumpActProp_tr" style="display:none">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.jumpConfig]*}:</td>
			<td align="left">
				<div id="jumpActProp">
					<ul id="_jumpType_ul">
						{*[cn.myapps.core.dynaform.activity.label.action]*}：<s:radio id="jumpType" name="jumpType"
							 theme="simple" cssStyle="width:25px;"
							list="#{0:'{*[New]*}'}"></s:radio>
					</ul>
				    <ul>
					 	{*[Module]*}： <s:select id="moduleSelect" name="moduleSelect"
						list="#mh.getModuleSel(#parameters.application)"
						cssClass="input-cmd" onchange="addFormOptions(this, 'formSelect')"  />
		 			</ul>
					 <ul>
					 	{*[cn.myapps.core.dynaform.activity.label.targetForm]*}：<s:select id="formSelect" cssClass="input-cmd" name="formName" theme="simple" list="{}"/>
					  </ul>
				</div>
				</td>
		</tr>
		<tr id="dispatcherMode_tr">
			<td class="commFont commLabel">{*[DispatcherMode]*}:</td>
			<td><s:radio id="dispatcherMode" name="dispatcherMode"
						theme="simple" cssStyle="width:25px;" 
						list="#{0:'{*[Forward]*}',1:'{*[Redirect]*}'}"></s:radio>
			</td>
		</tr>
		
		<tr id="dispatcherUrl_tr">
			<td class="commFont commLabel">{*[DispatcherUrl]*}{*[Script]*}:</td>
			<td><s:textarea id="dispatcherUrl" cssClass="input-cmd" cssStyle="width:350px;" name="content.dispatcherUrl" cols="50" rows="3" />
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('content.dispatcherUrl','{*[Script]*}{*[Editor]*}','{*[DispatcherUrl]*}{*[Script]*}','name','{*[Save]*}{*[Success]*}');">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
			</td>
		</tr>
		
		<tr id="dispatcherParams_tr">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.parameter]*}:</td>
			<td>
				<table class="" border=1 cellpadding="0"
					cellspacing="0" bordercolor="" width="350px">
					<tbody id="tb">
						<tr>
							<td align="left" class="commFont">{*[cn.myapps.core.dynaform.activity.label.parameterName]*}</td>
							<td align="left" class="commFont">{*[cn.myapps.core.dynaform.activity.label.parameterValue]*}</td>
							<td align="left"><input type="button" value="{*[Add]*}"
								onclick="addRows()" /></td>
						</tr>
					</tbody>
				</table>
				<s:hidden id="dispatcherParams" name="content.dispatcherParams" />
			</td>
		</tr>
	
		<tr id="jumpActOpenType_tr" style="display:none">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.jumpActOpenType]*}</td>
			<td align="left">
				<div>
					<input type="radio" name="jumpActOpenType" value="0">{*[cn.myapps.core.dynaform.activity.label.opentype_currentpage]*}
					<input type="radio" name="jumpActOpenType" value="1">{*[cn.myapps.core.dynaform.activity.label.opentype_poplayer]*}
					<input type="radio" name="jumpActOpenType" value="2">{*[cn.myapps.core.dynaform.activity.label.opentype_tab]*}
					<input type="radio" name="jumpActOpenType" value="3">{*[cn.myapps.core.dynaform.activity.label.opentype_newpage]*}
				</div>
			</td>
		</tr>		
					<tr>
						<td class="commFont commLabel">{*[StateToShow]*}:</td>
						<td><s:textfield id="stateToShow" readonly="true" cssStyle="100%" cssClass="input-cmd" name="content.stateToShow" />
							
						<button type="button" class="button-image" onClick="selectField('statelist','stateToShow');">
							<img src="<s:url value="/resource/image/search.gif"/>">
						</button>
						</td>
					</tr>
				
					<tr id="approve_tr">
						<td class="commFont commLabel">{*[Approve]*}{*[To]*}:</td>
						<td><s:textfield id="approveLimit" cssStyle="width:100%" readonly="true" cssClass="input-cmd" name="content.approveLimit" />
							
						<button type="button" class="button-image" onClick="selectField('statelist','approveLimit');">
							<img src="<s:url value="/resource/image/search.gif"/>">
						</button>
						</td>
					</tr>
					
					<tr id="oprint_tr">
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.onActionPrint]*}</td>
						<td align="left"><s:select id="actionPrint" cssStyle="width:350px;" emptyOption="true" name="_onActionPrintid" list="{}" /></td>
					</tr>
			
					<tr id ="beforescriptid">
				  		<td class="commFont commLabel">{*[BeforeActionScript]*}:</td>
						<td>
							<s:textarea id="beforeActionScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_action_script]*}*/" cssClass="input-cmd" cssStyle="width:92%;"  name="beforeActionScript" cols="50" rows="3" />
							<button type="button" id="beforeScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
					
					
					<tr id ="afterscriptid">
				  		<td class="commFont commLabel">{*[AfterActionScript]*}:</td>
						<td>
							<s:textarea  id="afterActionScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_after_action_script]*}*/" cssClass="input-cmd" cssStyle="width:92%;" name="afterActionScript" cols="50" rows="3" />
							<button type="button" id="afterScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
					
				</table>
				
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="100%" id="content2">
					<tr>
						<td>
							<textarea id="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" name="hiddenScript" style="width:96%" rows="10"></textarea>
							<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input type="text" id="hiddenValue" name="hiddenValue" /></td>
					</tr>
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="100%"
					id="content3">
					<tr>
						<td>
							<textarea id="hiddenPrintScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" name="hiddenPrintScript"  style="width:96%" rows="10"></textarea>
							<button type="button" id="hiddenPrintScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" id="printHiddenValue" name="printHiddenValue" /></td>
					</tr>
					
				</table>
				<table border="1" cellpadding="3" cellspacing="1" class="content" width="95%"
					id="content4">
					<tr>
						<td>
							<textarea id="readonlyScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" name="readonlyScript" style="width:96%" rows="10"></textarea>
							<button type="button" id="readonlyScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
	
			
			
		</table>
</s:form>

<script language=javascript>
cardClick(1);
</script>

</BODY>
</o:MultiLanguage>
</HTML>
