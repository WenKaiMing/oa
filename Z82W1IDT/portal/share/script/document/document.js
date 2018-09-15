/**
 * 前台皮肤表单页面私有
 */
var activityAction = contextPath + '/portal/dynaform/activity/action.action';
var printAction = contextPath + '/portal/dynaform/document/print.action';

var OPEN_TYPE_DIV = 0x0000115;

/**
 * save and start workflow button
 */
var SAVE_SARTWORKFLOW = 4;
/**
 * 按钮类型保存并新建(新建有一条有旧数据Document)
 */
var SAVE_NEW_WITH_OLD=12;
/**
 * 按钮类型为保存并新建(新建一条空Document)
 */
var SAVE_NEW_WITHOUT_OLD = 17;
/**
 * 按钮类型为更新Document.
 */
var DOCUMENT_UPDATE = 34;

/**
 * 按钮类型为关闭窗口.
 */
var CLOSE_WINDOW = 8;
/**
 * 按钮类型为跳转.
 */
var JUMP = 32;
/**
 * 按钮类型为跳转页面.
 */
var JUMP_PAGE = 39;
/**
 * 按钮类型为转发.
 */
var DISPATCHER  = 37;
/**
 * 按钮类型为返回.
 */
var BACK = 10;
/**
 * 离开表单页面是否检验
 */
var fieldValChanged = false;

/**
 * 表单修改后，是否保存
 */
function ifSubSaveForm(){
	var ifSubSave = true;
	jQuery("#toAll").find("iframe[name='display_view']").each(function(){
		var $conWin = jQuery(this)[0].contentWindow;
		if($conWin && typeof $conWin.getFieldValChanged=="function"){
			if($conWin.getFieldValChanged()){   //表单修改过返回true;
				if(confirm("确实要保存主表单吗?\r\n子表单数据已修改且未保存！\r\n按“确定”继续，或按“取消”留在当前页面。")){
					$conWin.getFieldValChanged(false);
					return false;
				}else{
					ifSubSave = false;
					return false;
				}
			}
		}
	});
	return ifSubSave;
}

/**
 * 后台预览的时候判断页面是否重构完成
 */
var isComplete =  false;

function doSave(type, actid) {
	if(isRefreshLoading){	//刷新重计算未执行完时延时保存
		setTimeout(function(){
			doSave(type, actid);
		},200);
		return false;
	}
	var oOperation = document.getElementById("operation");
	if (oOperation) {
		oOperation.value = "doSave";
	}
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	setHTMLValue();//设置html控件值
	var retvalue = doWordSave();
	if(!retvalue) {
		alert('Word文档已经被其他用户更新， 请刷新页面加载最新的Word文档！');
		return;
	}
	var isword = false;

	if (!isword || isword == 'false') {
		
		ev_action(type, actid);
	} else {
		
		if (retvalue >= 0) { // 有返回值才保存
			ev_action(type, actid);
		}
	}
}

/**
 * Word文档保存
 * @return
 */
function doWordSave(){
	var retvalue = true;
	var $wordIframes = jQuery("iframe[_type='word']");
	$wordIframes.each(function(){
		var t = jQuery(this);
		if (t.attr("_type") == 'word') {// word文档保存
			isword = true;
			var wordIframe = window.frames[t.attr("id")];
			if(wordIframe){
				if(typeof wordIframe.doSave == "function"){
					retvalue = wordIframe.doSave();
					if(retvalue){
						if(retvalue.indexOf("$$")>=0){
							retvalue = false;
							return false;
						}else{
							document.getElementsByName("content.versions")[0].value = retvalue;
							retvalue = true;
						}
					}
				}
			}
		}
	});
	return retvalue;
}

function ev_action(types, actid) {
	var rtnVal = beforeAct(types);
	var subFormIsSave = ifSubSaveForm();
	/*
	if(beforeAct(types)){
		if (!confirm("文档已修改，还没保存！确定要离开吗？"))
			return;
	}*/
	if(rtnVal && subFormIsSave){
		ev_action2(types, actid);
	}else {//恢复按钮状态
		recoveryButSta("button_act");
	}
}

function ev_action2(type, actid) {
	if(type=="8") {//处理按钮类型为关闭的情况,如不处理,会有空指针错误
		window.close();
	}
	ignoreFormCheck();
	var url = activityAction;
	makeAllFieldAble();
	if (actid) {
		var view_id = document.getElementById("view_id").value;
		//待办页表单不是弹出框时，关闭窗口的处理
		/*if(view_id==null||view_id.length<1){
			var appid=jQuery("#applicationid").val();
			//location.href=contextPath+"/portal/share/welcome.jsp?application="+appid;
			//return false;
		}*/
		var newUrl = url + '?_activityid=' + actid + '&view_id=' + view_id;
	}
	try {
		document.forms[0].action = newUrl;
		document.forms[0].submit();
	} catch (ex) {
		if(toggleButton("button_act")) return false;
	}
}


/**表单布局调整--start**/

/**
 * 当表单为子视图以当前区域打开时调整装载文档的iFrame的高度
 * for:所有皮肤
 */
function resizeParentWin() {
	var viewEle = document.getElementById("view_id");
	if(viewEle){
		var iframeid = viewEle.value;
		if (iframeid && iframeid!="") {
			var oIFrame = jQuery("iframe[id="+iframeid+"]",window.parent.document)[0];
			if (oIFrame) {
				var iFrameH = document.getElementById('toAll').clientHeight + 50;
				if(iFrameH>400){
					iFrameH = 400;
				}else if(iFrameH<50){
					iFrameH = 50;
				}
				oIFrame.style.height = iFrameH+"px";
			}
		}
	}
}

/**
 * 调整表单页面布局
 * for:default/gentle/fresh/dwz
 */
function adjustDocumentLayout4form(){
	var bodyH=document.body.clientHeight;
	jQuery("#container").height(bodyH-10);
	var activityTableH = "";
	if(jQuery("#activityTable").attr("id")=="activityTable"){
	activityTableH=jQuery("#activityTable").height();
	}
	jQuery("#contentTable").height(bodyH-activityTableH-15);
}

/**
 * 当MainLeft的内容高度小于body时，调整MainLeft高度
 * for blue/brisk
 */
function resizeMainLeft(){
	var bodyH=document.body.clientHeight;
	var conTabH=jQuery("#contentTable").css("height");
	var numofcon=conTabH.replace(/px/, "");
	if(numofcon<=bodyH){
		jQuery("#MainLeft").height(bodyH);
	}
}

/**
 * 当为弹出框时，调整当前窗口
 */
var resize_count = 0;
function resizeWindow(){

	var actH = jQuery("#activityTable").height(),
		allH = jQuery("#toAll").height(),
		conH = actH + allH;
	var w = jQuery("#container").width(),
		h = conH > 600 ? 600 : conH + 70;

	if(allFrameIsLoaded() && w>=600){
		OBPM.dialog.resize(w, h);
	}else {
		setTimeout(function() {
			if(resize_count<4){
				resize_count++;
				resizeWindow();
			}
		},200);
	}
} 


/******end ****/
/**
 * 电子签章判断
 * for:default/gentle/fresh/dwz/blue/brisk
 */
function Signatures4Judge(){
	if(navigator.userAgent.indexOf("MSIE")<=0 && navigator.userAgent.indexOf("TRIDENT")<=0) {
		return;
	}
	if(document_content.SignatureControl!=null){
		document_content.SignatureControl.ShowSignature(contentId);
	}
}

/**
 * 显示提示信息
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function showPromptMsg(){
	var funName = typeName;
	var url = urlValue;
	url+="&_refreshDocument=true";
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		eval("do" + funName + "(msg , url);");
	}
}

/**
 * 刷新对应菜单的总记录数
 * for:default/gentle/fresh/dwz/blue/brisk
 */
function refresh4Record(){
	var atrr=jQuery("#resourceid").val();
	var resourceid=atrr.split(",")[0];
	var viewid='';
	if(jQuery("#_viewid").attr("id")=="_viewid"){
		viewid=jQuery("#_viewid").val();
	}else{
		viewid=jQuery("#view_id").val();
	}
	if(resourceid!=null && resourceid!=''){
		if(typeof(window.parent.reflashTotalRow) == "function")
			window.parent.reflashTotalRow(resourceid,viewid);
	}
}

/**
 * 电子邮件的转发
 * for:default/dwz
 */
function email_transpond(transpond, actid){
	var applicationid = application;
	var docid = docidR;
	var formid = formidR;
	var signatureExist = document.getElementById("signatureExist").value;
	var handleUrl = window.location.toString();
	var url = "../share/dynaform/view/activity/emailTranspond.jsp?application=" + applicationid;
	if(ev_runbeforeScript(actid)){
		OBPM.dialog.show({
    		opener:window.parent.parent,
    		width: 700,
    		height: 300,
    		args: {"_activityid":actid,"application":applicationid, "docid":docid, "formid":formid, "transpond":transpond, "handleUrl":handleUrl, "signatureExist":signatureExist},
    		url: url,
    		title: '转发',
    		close: function() {
    			
    		}
    	});
	}
}

/**
 * 初始化在选中节点创建时，的当前节点的上级节点
 * for:所有皮肤
 */
function Initialization4Node(){
	var backUrl = document.getElementById("_backURL");
	var _backURL = backUrl.value;
	var index = _backURL.indexOf("_backURL");
	if(index > -1){
		var backURL = _backURL.substring(0,index) + 
		encodeURIComponent(_backURL.substring(index, _backURL.length));
	}
	var els = document.getElementsByName(super_node_fieldNameR);
	if (els && els.length > 0) {
		if (nodeR){
			els[0].value = nodeR;
		}
	}
}

/**
 * 超时操作
 * for:default/dwz
 */
function timeout4Doc(){
	DWREngine.setTimeout(1000 * 30); // 1分钟后超时
	DWREngine.setErrorHandler(function(msg){
		alert("Error: " + msg); // 显示错误信息
		if (dy_unlock){ // 解除锁定
			dy_unlock();
		}
	});
}

/**
 * 遍历设置固定操作按钮宽度
 * for:gentle
 */
function operationButtonsW(){
	jQuery(".button-document").each(function(){
		jQuery(this).width(jQuery(this).children(".btn_mid").width()+65);
	});
}

/**
 * 遍历设置固定操作按钮宽度
 * for:fresh
 */
function operationButtonsW2(){
	jQuery(".button-document").each(function(){
	      jQuery(this).width(jQuery(this).children(".btn_mid").width()+18);
  });
}

/**
 * 遍历设置固定操作按钮宽度
 * for:brisk
 */
function operationButtonsW4(){
	jQuery(".button-document").each(function(){
	      jQuery(this).width(jQuery(this).children(".btn_mid").width()+65);
  });
}

/**
 * 查看待办内容
 * @param docid
 * @param formid
 * @param summaryCfgId
 * @return
 */
function viewDoc(docid, formid,summaryCfgId) {
	if (docid && formid) {
		var viewDocURL = viewDocUrl;
		viewDocURL += "?_docid=" + docid;
		viewDocURL += "&_formid=" + formid;
		viewDocURL += "&summaryCfgId=" + summaryCfgId;
		viewDocURL += "&application=" + application;
		viewDocURL += '&_backURL=' + backUrl;
		window.location.href = viewDocURL;
	}
}

/**
 * 更多待办或待阅弹出层
 * for:dwz
 */
function doMoreDocR(summaryCfgId){
	var url = escapeR;
		url += "&summaryCfgId=" + summaryCfgId;
	OBPM.dialog.show({
			opener:window.parent.parent,
			width: 800,
			height: 500,
			url: url,
			args: {},
			title: '{*[More]*}{*[Pending]*}',
			close: function(rtn) {
			}
	});
}

/**
 * 刷新父窗口
 */
function ev_reloadParent() {
	var oOperation = document.getElementById("operation");
	try {
		if (!oOperation || oOperation.value != 'doSave') {
			return;
		}
		var openType=jQuery("#openType").val();
		//弹出层打开
		if(openType==277){
			var windowObj=window.parent.windowObj;
			if (windowObj.treeview) { // 刷新父窗口树型对象
				windowObj.selectedNode = jQuery("#treedocid").val();
				var parentid=jQuery("#treedocid").val();
				if(parentid==null || parentid==""){
					parentid="root";
				}
				windowObj.treeview.jstree("refresh", "#"+parentid);
			}
		}
		
		if (parent) {
			if (parent.treeview) { // 刷新父窗口树型对象
				parent.selectedNode = OBPM("#treedocid").val();
//				parent.treeview.jstree("refresh", "#"
//								+ OBPM("#treedocid").val());
				parent.treeview.jstree("refresh", "#root");//替代了上面的方法，刷新整棵树，临时处理，会影响性能
				parent.treeview.jstree("");
			}
			if (parent.parentWindow) {
				// parent.parent.ev_reload();
			}
		} else {
		}
	} catch (ex) {
	} finally {
		oOperation.value = '';
	}
}

/**
 * 表单数据是否发生改变
 * @param form
 * @return
 */
function is_change(form) {
	var lst = form.elements, tag;
	for (var i = 0; i < lst.length; i++) {
		tag = lst[i].tagName;
		if (/select/i.test(tag)) {
			var opts = lst[i].options, hasdefault = false, istrue = false;
			for (var j = 0; j < opts.length; j++) {
				if (opts[j].defaultSelected != opts[j].selected)
					istrue = j;
				hasdefault |= opts[j].defaultSelected;
			}
			if (!hasdefault && istrue > 0 || hasdefault && istrue !== false)
				return true;

		} else if (/input|button/i.test(tag)
				&& /checkbox|radio/i.test(lst[i].type)) {
			if (lst[i].defaultChecked != lst[i].checked)
				return true;

		} else {
			if (lst[i].defaultValue != lst[i].value)
				return true;

		}
	}
	return false;
}
function ev_print(withFlowHis, actid) {
	var id = document.getElementsByName("content.id")[0].value;
	var applicationid = document.getElementsByName("content.applicationid")[0].value;
	var formid = document.getElementsByName("_formid")[0].value;
	var flowid = document.getElementsByName("_flowid")[0].value;
	var _templateForm = document.getElementsByName("_templateForm")[0].value;
	var signatureExist = document.getElementById("signatureExist").value;
	
	if (!id) {
		alert("{*[Please]*} {*[Save]*}");
	} else {
		var url = activityAction + '?_docid=' + id;
		url += '&_formid=' + formid;
		url += '&_signatureExist=' + signatureExist;
		url += '&_activityid=' + actid;
		url += '&application=' + applicationid;
		if (withFlowHis && flowid) {
			url += '&_flowid=' + flowid;
		}
		if(_templateForm){
			url += '&_templateForm=' + _templateForm;
		}
	}
	if(ev_runbeforeScript(actid)){
		if (parent != top) {
			parent.open(url);
		} else {
			window.open(url);
		}
	}
}
/**
 * 电子签章按钮对应的Function
 */
function DoSignature() {
	if(navigator.userAgent.indexOf("MSIE")<=0) {
		return;
	}
	var ajax = null;
	if (window.ActiveXObject) {
		try {
			ajax = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {
			alert("创建Microsoft.XMLHTTP对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
		}
	} else {
		if (window.XMLHttpRequest) {

			try {
				ajax = new XMLHttpRequest();
			} catch (e) {
				alert("创建XMLHttpRequest对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
			}
		}
	}

	var url = document.getElementById("mGetDocumentUrl").value;
	var mLoginname = document.getElementById("mLoginname").value;
	var docid = document.getElementsByName("content.id")[0].value;
	var formid = document.getElementsByName("formid")[0].value;
	var applicationid = document.getElementsByName("applicationid")[0].value;
	url = url + "?_docid=" + docid + "&_formid=" + formid + "&_applicationid="
			+ applicationid;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 4 && ajax.status == 200) {
			if (ajax.responseText == "false") {
				return;
			}
			var documentName = ajax.responseText.split(',');
			var fildsList = "";
			for (var i = 0; i < documentName.length; i++) {
				if (i != documentName.length - 1) {
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i] + ";");
				} else {
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i]);
				}

			}
			if (document_content.SignatureControl != null) {
				document_content.SignatureControl.FieldsList = fildsList; // 所保护字段
				document_content.SignatureControl.Position(460, 260); // 签章位置，屏幕坐标
				document_content.SignatureControl.UserName = "lyj"; // 文件版签章用户
				document_content.SignatureControl.DivId="contentTable"; //设置签章显示位置
				document_content.SignatureControl.RunSignature(); // 执行签章操作
			} else {
				alert("请安装金格iSignature电子签章HTML版软件");
				document.getElementById("hreftest").click();
			}

		}

	};

	ajax.open("POST", url);

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(null);
}
// flex动态打印按钮click事件脚本
function ev_flexPrint(activityId, printerid, withFlowHis) {
	var id = document.getElementsByName("content.id")[0].value;
	var formid = document.getElementsByName("_formid")[0].value;

	if(ev_runbeforeScript(activityId)){
		if (!id) {
			alert("{*[Please]*} {*[Save]*}");
		} else {
			var url = contextPath
					+ '/portal/dynaform/activity/action.action?_activityid='+activityId+'&_printerid='
					+ printerid + '&_docid=' + id;
			if (parent != top) {
				document.forms[0].action = url;
				document.forms[0].target = "_blank";
				document.forms[0].submit();
				document.forms[0].target = "";
			} else {
				document.forms[0].action = url;
				document.forms[0].target = "_blank";
				document.forms[0].submit();
				document.forms[0].target = "";
			}
		}
	}
}

// JumpTo操作按钮 点击事件
function ev_JumpTo(activityId, jumpType, targetList, jumpMode) {
	switch (jumpMode) {
		case 0 :
			ev_Jump(activityId, jumpType, targetList);
			break;
		case 1 :
			ev_dispatcherPage(activityId);
			break;
		default :
			break;
	}
}

// 跳转操作 点击事件
function ev_Jump(activityId, jumpType, targetList) {
	var olist = targetList.split(";");
	var formid;
	for (var i = 0; i < olist.length; i++) {
		formid = olist[0].split("|")[0];
	}

	switch (jumpType) {
		case 0 :
			doNew(activityId, formid);
			break;
		default :
			break;
	}
}
// 新建操作
function doNew(activityId, formId) {
	var applicationid = document.getElementById("application").value;
	var docid = document.getElementsByName("content.id")[0].value;
	var view_id = document.getElementById("view_id").value;
	var signatureExist = document.getElementsByName("signatureExist")[0].value;
	var formid = document.getElementsByName("formid")[0].value;
	var backUrl = document.getElementsByName("_backURL")[0].value;
	var docviewAction = contextPath + '/portal/dynaform/document/view.action';
	var newAction = contextPath + '/portal/dynaform/activity/handle.action?_activityid=' + activityId;
	var url = newAction + "&applicationid=" + applicationid + "&application=" + applicationid + "&_jumpForm=" + formid + "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1&_backURL="
			+ encodeURIComponent(docviewAction + "?_docid="+docid+"&application="+applicationid+"&_formid="+formid+"&view_id="+
					view_id+"&signatureExist="+signatureExist+"&_backURL="+encodeURIComponent(backUrl));
	window.location.href = url;
}

/** *******editing at 2010-10-11******* */

/** **具体用途没确定 function** */

function displayProcessor() {
	var processorDiv = document.getElementById("processorDiv");
	if (processorDiv) {
		if (processorDiv.style.display == "none") {
			processorDiv.style.display = "block";
		} else {
			processorDiv.style.display = "none";
		}
	}
}

/** ***文件的导入导出、下载 function******* */

function doFileDonwload(actid) {
	var id = document.getElementsByName("content.id")[0].value;
	if (!id) {
		alert("{*[Please]*} {*[Save]*}");
		return;
	}
	if(ev_runbeforeScript(actid)){
		if (actid) {
			var url = contextPath + "/portal/dynaform/activity/action.action";
			var newUrl = url + '?_activityid=' + actid;
			document.forms[0].action = newUrl;
			document.forms[0].target = "_blank";
			document.forms[0].submit();
			document.forms[0].target = "";
		}
	}
}

function doExportToPDF(actid) {
	var id = document.getElementsByName("content.id")[0].value;
	if (!id) {
		alert("{*[Please]*} {*[Save]*}");
	} 
	
	if(ev_runbeforeScript(actid)){
		var url = contextPath + '/portal/dynaform/activity/handle.action' + '?_activityid=' + actid;
		document.forms[0].action = url;
		document.forms[0].submit();
	}
}

/** ***for document js function *** */
function addItem(s1id, s2id, s3id) {
	var source = document.getElementById(s1id);
	var target = document.getElementById(s2id);
	for (var i = 0; i < source.length; i++) {
		if (source.options(i).selected == true) {
			var Opt = document.createElement("option");
			Opt.value = source.options(i).value;
			Opt.text = source.options(i).text;
			var k = 0;
			for (var j = 0; j < target.length; j++) {
				if (source.options(i).value == target.options(j).value) {
					k = 1;
				}
			}
			if (k == 0) {
				target.options.add(Opt);
				getOptionsValue(target, s3id);
				k = 0;
			}
		}
	}
}

function delItem(s1id, s2id, s3id) {
	var source = document.getElementById(s1id);
	var target = document.getElementById(s2id);
	var str = document.getElementById(s3id).value;
	var save = document.getElementById(s3id);
	for (var x = target.length - 1; x >= 0; x--) {
		var opt = target.options[x];
		if (opt.selected) {
			target.options[x] = null;
			var cols = new Array();
			cols = jQuery.parseJSON(str);
			var optValue = opt.value;
			for (var i = 0; i < cols.length; i++) {
				if (cols[i] == optValue) {
					removeElement(i, cols);
					save.value = jQuery.json2Str(cols);
				}
			}
		}
	}
}

function blackValue(inputID, sid1, sid2) {
	var select = document.getElementById(sid1);
	var select2 = document.getElementById(sid2);
	var inputValue = document.getElementById(inputID).value;
	if (inputValue == null || inputValue == "") {
		for (var i = 0; i < select.length; i++) {
			select.options[i].selected = false;
			select2.options[i].selected = false;
		}
	}
	url += '&_formid=' + formid;
	for (var i = 0; i < select.length; i++) {
		select.options[i].selected = false;
		select2.options[i].selected = false;
	}
	for (var i = 0; i < select.length; i++) {
		if (select(i).value.indexOf(inputValue) != -1) {
			select.options[i].selected = true;
			select2.options[i].selected = true;
			break;
		}
	}
}

function returnValue(boxId, sid2, sid) {
	var select2 = document.getElementById(sid2);
	var index = select2.selectedIndex;
	// alert(index);
	var seleValue = select2.options[index].text;

	var select = document.getElementById(sid);
	for (var i = 0; i < select.length; i++) {
		if (select(i).value == seleValue) {
			select.options[i].selected = true;
		}
	}
	var box = document.getElementById(boxId);
	GradientClose(box);
	document.getElementById(sid).style.display = "";

}

function removeElement(index, array) {
	if (index >= 0 && index < array.length) {
		for (var i = index; i < array.length; i++) {
			array[i] = array[i + 1];
		}
		array.length = array.length - 1;
	}
	return array;
}

function getOptionsValue(target, s3id) {
	var fileid = target;
	var save = document.getElementById(s3id);
	var columns = new Array();
	for (var i = 0; i < fileid.options.length; i++) {
		var filename = fileid.options[i].value;
		columns.push(filename);
		save.value =jQuery.json2Str(columns);
	}
}

/**
 *流程提交(显示方式为弹出)
 */
function showFlowSelect(el, actid, title,isUsbKeyVerify) {
	var flowid=document.getElementById("_flowid").value;
	var docid = document.getElementById("_docid").value;
	// var fshowtype=document.getElementById("fshowtype").value;
	var url = contextPath + '/portal/share/workflow/runtime/flowprcss_dialog.jsp?docid='+ docid+'&flowid='+flowid+'&isUsbKeyVerify='+isUsbKeyVerify;
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
			if(result.isHandupOrRecover){
				var _rtn = jQuery.param(result,true);
				if(result._operationMode == 'handup'){
					ev_flowHandup4dialog(_rtn);
				}else if(result._operationMode == 'recover'){
					ev_flowRecover4dialog(_rtn);
				}
			}else {
				var ftObj = document.getElementById("_flowType");
				var cuObj = document.getElementById("_currid");
				if(ftObj){
					ftObj.value = result._flowType;
					delete result._flowType;
				}
				if(cuObj){
					delete result._currid;
				}
				var rtn = jQuery.param(result,true);
				if (rtn) {
					unbindBeforeUnload();//取消绑定beforeunload事件
					var obj = document.getElementsByName("_nextids");
					for (var i = 0; i < obj.length; i++) {
						if (obj[i].checked) {
							document.getElementsByName("_nextids")[0].value = obj[i].value;
						}
					}
					var actionUrl = contextPath
							+ "/portal/dynaform/activity/action.action";
					document.forms[0].action = actionUrl + '?_activityid=' + actid
							+ '&' + rtn;
					
					if(ev_runbeforeScript(actid)){
						if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
						makeAllFieldAble();
	        			document.forms[0].submit();
					}
				}
			}
		}
	});
}

// 启动流程
function startWorkFlow(acttype, actid,editMode,title) {
	if(editMode ==null || editMode==0){
		startWorkFlowBySelect(acttype, actid,editMode,title);
	}else if(editMode==1){
		startWorkFlowByScript(acttype, actid,editMode);
	}
	
}


function startWorkFlowBySelect(acttype, actid,editMode,title){
	// var flowid=document.getElementById("_flowid").value;
	var docid = document.getElementById("_docid").value;
	var formid = document.getElementById("_formid").value;
	// var moduleid=document.getElementById("moduleid").value;
	var url = contextPath
			+ '/portal/share/workflow/runtime/startWorkFlow.jsp?_docid=' + docid
			+ '&formid=' + formid;
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
		showtitle = "Undefind";
	}
	tempAllDisabledField();
	makeFieldState(false);
	jQuery.ajax({
		type: 'POST',
		async:false, 
		url: contextPath + '/portal/dynaform/document/beforeStartWorkFlow.action?_docid=' + docid + '&formid=' + formid,
		dataType : 'text',
		data: jQuery(document.forms[0]).serialize(),
		success:function(result) {
			OBPM.dialog.show({
						width : 600, // 默认宽度
						height : 420, // 默认高度
						url : url,
						args : {},
						title : showtitle,
						close : function(result) {
							if (result) {
								unbindBeforeUnload();//取消绑定beforeunload事件
								var actionUrl = contextPath
										+ "/portal/dynaform/activity/action.action"
										+ '?_activityid=' + actid +'&_editMode='+editMode+'&' + result;
								if(ev_runbeforeScript(actid)){
									document.forms[0].action = actionUrl;
									makeAllFieldAble();
									document.forms[0].submit();
								}
								makeFieldState(true);
							}
							makeFieldState(true);
						}
					});
		},
		error: function(result) {
			alert("启动流程失败");
		}
	});
}

function startWorkFlowByScript(acttype, actid,editMode){
	setHTMLValue(); //设置html控件值
	var actionUrl = contextPath
	+ "/portal/dynaform/activity/action.action"
	+ '?_activityid=' + actid+'&_editMode='+editMode;
	
	if(ev_runbeforeScript(actid)){
		var rtnVal = beforeAct(acttype);
		if(rtnVal){
			makeAllFieldAble();
			document.forms[0].action = actionUrl;
			document.forms[0].submit();
		}
	}
}

/**
 * 临时存放所有disabled=true的元素,启动流程按钮使用
 */
var tempField = new Array();
/**
 * 临时存放所有disabled=true的元素,启动流程按钮使用
 */
function tempAllDisabledField(elements) {
	if (!elements) {
		elements = document.forms[0].elements;
	}
	for (var i = 0; i < elements.length; i++) {
		var element = elements[i];
		if (element.disabled == true) {
			// alert("****type->" + element.type);
			tempField[i] = element;
		}
	}
}
/**
 * 临时存放元素的disabled属性,启动流程按钮使用
 * @param boolean true or false
 * @return
 */
function makeFieldState(booleanVal){
	for (var i = 0; i < tempField.length; i++) {
		var element = tempField[i];
		if (element && element.disabled == !booleanVal) {
			// alert("****type->" + element.type);
			jQuery(element).attr("disabled",booleanVal);
		}
	}
}

//流程回撤
function doRetracement() {
	ignoreFormCheck();
	var action = contextPath + '/portal/dynaform/document/retracement.action';
	
	document.getElementsByName("_flowType")[0].value = "retracement";
	document.forms[0].action = action;
	makeAllFieldAble();
	document.forms[0].submit();
}

/**
 * 页面跳转时提示用户是否保存修改
 * 2011-5-26 by dolly
 **/
function addChange() {
	var myform = document.forms[0];
	for (var i = 0; i < myform.elements.length; i++) {
		var element = myform.elements[i];
		jQuery(element).bind('change',function(){
			setFieldValChanged(true);
		}).bind("keydown",function(e){
			 var key = e.which;
			 if (this.type != "textarea" && key == 13) {
			 	e.preventDefault(); //按enter键时阻止表单默认行为
			 }
		});
		
	}
}

//返回表单是否修改的变量
function getFieldValChanged() {
	return fieldValChanged;
}

//设置表单是否修改的变量
function setFieldValChanged(val) {
	return fieldValChanged = val;
}

//日期控件值改变时设置fieldValChanged
function dateCompareVal(obj){
	var oldVal = obj.getAttribute("oldValue");
	var val = obj.value;
	if(val != oldVal){
		fieldValChanged=true;
	}
}
/**
 * 表单内容修改后离开页面提示保存
 * @param actTypes：操作类型
 * @return
 */
function beforeAct(actTypes){
	var actType = parseInt(actTypes);
	if(actType==CLOSE_WINDOW || actType==JUMP || actType==JUMP_PAGE || actType==DISPATCHER || actType==BACK){
		if(fieldValChanged){//表单内容被修改
			if(!confirm('您确定要离开此页面吗?\r\n数据已修改！\r\n按“确定”离开此页面，或按“取消”留在当前页面。')){
				return false;
			}else{
				unbindBeforeUnload();//取消绑定beforeunload事件
			};
		}
	}else{
		unbindBeforeUnload();//取消绑定beforeunload事件
	}
	return true;
}

/**
 * 表单内容被修改的取消绑定beforeunload事件
 * 2013-4-10 by frank
 */
function unbindBeforeUnload(){
	jQuery(window).unbind("beforeunload");
}
/**
 * 打开表单光标焦点定位
 * 2011-5-26 by dolly
 */
function setFirstFocus(){
	if(jQuery(':input :text :first').attr("fieldtype")!="DateField"){
		if(!jQuery(':input :text :first').attr("disabled") || jQuery(':input :text :first').attr("readonly")){
			jQuery(':input :text :first').focus();
		}
	}
}

/**
	编辑审批人
 */
function editAuditor(){
	var actionUrl = contextPath
	+ "/portal/dynaform/document/editAuditor.action";
	
	var oCurridArray = document.getElementsByName("_currid");
	// 当前节点ID
	var currid = '';
	if (oCurridArray && oCurridArray.length > 0) {
		currid = oCurridArray[0].value;
	}
	// 目标文本框
	var oFiled = document.getElementById("auditorList");
	if (oFiled) {
		var map = oFiled.value ? jQuery.parseJSON(oFiled.value): {};
		showUserSelectNoFlow('', {
					minUser: 1,
					defValue: map[currid],
					callback: function(result) {
						// prototype1_6.js
						if (result) {
							if(result && result.length>0 && result.indexOf(';')<0){
								result = result+';';
							}
							var userlist = result.split(";");
							// 为当前节点设置
							map[currid] = userlist;
							oFiled.value = jQuery.json2Str(map);
							document.forms[0].action = actionUrl;
							makeAllFieldAble();
							document.forms[0].submit();
						}
					}
				});
	}
	
	
}

/**
 * 加签
 */
function addAuditor(){
	var docid = document.getElementById("_docid").value;
	var url = contextPath + "/portal/share/dynaform/document/addAuditor.jsp?_docid=" + docid + "&application=" + application;
	var actionUrl = contextPath
	+ "/portal/dynaform/document/addAuditor.action";
	
	var oCurridArray = document.getElementsByName("_currid");
	// 当前节点ID
	var currid = '';
	if (oCurridArray && oCurridArray.length > 0) {
		currid = oCurridArray[0].value;
	}
	OBPM.dialog.show({
		width: 580,
		height: 400,
		url: url,
		args: {},
		title: title_addAuditor,
		close: function(result) {
			if(result){
				var map = {};
				var obj = eval('(' + result + ')');
				map[currid] = obj.userlist;
				document.getElementById("auditorList").value = jQuery.json2Str(map);
				makeAllFieldAble();
				document.forms[0].action = actionUrl;
				document.forms[0].submit();
			}
		}
	});
}

/**
 * 加载word
 * word控件嵌套在选项卡中时处理
 */
var initWords = [];
function initWord(iframe){
	var falg = false;
	for(var i=0;i<initWords.length;i++){
		if(iframe.id == initWords[i]){
			falg = true;
			break;
		}
	}
	if(!falg && iframe.clientHeight==0){
		if(typeof(iframe.contentWindow.init_documenet) == "function"){
			iframe.contentWindow.init_documenet();
		}
		if (iframe.clientHeight > 0) {
			initWords.push(iframe.id);
		}
	}
}

/**前台流程表单添加title属性**/
function showFlowState(objCls){
	if(jQuery("." + objCls).size() != 0){
		var str = jQuery("." + objCls).text();
		var s = str.replace(/(^\s*)/, "");
		var t = s.replace(/(\s*$)/, "");  
		jQuery("." + objCls).attr("title",t);
	}
}

/**
 * Dispatcher按钮
 * @param actid
 * @return
 */
function ev_dispatcherPage(actid){
	var datas = jQuery("#document_content").serialize();
	var url = activityAction + '?_activityid=' + actid;
	if(ev_runbeforeScript(actid)){
		var html = '<input type="hidden" name="formData" value="'+datas+'" />';
		jQuery("#document_content").append(html);
		document.forms[0].action = url;
		makeAllFieldAble();
		document.forms[0].submit();
	}
}

/**
 * html编码转换
 * @param str
 * @return
 */
function htmlEncode(str){
   return str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
}

/**
 * 保存时设置值
 * @return
 */
function setHTMLValue(){
	jQuery("[moduleType='htmlEditor']").each(function(){
		var str = jQuery(this).parent().find("iframe").contents().find(".editMode").html();
		jQuery(this).html(htmlEncode(str));
	});
}


/**
 *  当为数字控件而输入的值不是数字时，重置为上一个值
 */
var origValue = "";
var resetWhenNonNumeric = function (input){
	var re = /^([\-]?[\.]?[0-9]*|[0-9]*)[0-9\.\,]*$/;
//	var re = /^([\-]{1}[0-9]*|[0-9]*)\.?[0-9]*$/;

	if (!re.test(input.value)) {
		for(var i = 0; i < input.value.length; i++){
			var s = input.value.charAt(i);
			if(i == 0 && s == "-"){
				continue; //第一个数为“-”的时候跳过。
			}
			if(isNaN(s) && s != "." && s != ","){
				input.value = input.value.substring(0,i);
				break;
			}
		}
		return false;
	} else {
		origValue = input.value;
	}
};

/**
 *  当输入的内容不是数字0-9和"-,."的时候，不能输入;
 */
function isNumeric(event) {
	var keyCode = event.keyCode?event.keyCode:event.which;
	//当键盘输入的是0-9或",.-",回退键tab键的时候，允许输入
	if((keyCode >= 48 && keyCode <= 57) || (keyCode >= 44 && keyCode <= 46) || keyCode == 8 || keyCode == 9 || keyCode == 118){
		event.returnValue = true;
	}else {
		//!+"\v1"判断是不是ie浏览器
		if(!+"\v1"){
			event.returnValue = false;
		}else{
			event.preventDefault();
		}
	}
}
function clearData() {
    var tipDiv = document.getElementById("tipDiv");
    var messageDiv = document.getElementById("messageDiv");
     if(tipDiv){
      tipDiv.innerHTML="";
      tipDiv.style.border = "black 0px solid";
     }
     if(messageDiv){
        messageDiv.innerHTML="";
        messageDiv.style.border = "black 0px solid";
     }
 
  
}

/*
 * 判断表单中的iframe是否都加载完
 */
function allFrameIsLoaded(){
	var flag = true;
	for(var i=0;i<frames.length;i++){
		if(frames[i].document.readyState != "complete"){
			flag = false;
			break;
		}
	}
	return flag;
}

/*
 * 表单公用的初始化方法
 * for:所有皮肤
 */
function initFormCommon(){
	jqRefactor(); //表单控件jquery重构
	WorkFlow.init();	//流程状态和历史初始化
	setFirstFocus(); //打开表单光标焦点定位
	setTimeout(function(){
		showPromptMsg();	//显示提示信息
	},300);
	refresh4Record(); //刷新对应菜单的总记录数
	ev_reloadParent();	//刷新父窗口
	Signatures4Judge(); // 电子签章判断
	Initialization4Node(); //初始化在选中节点创建时，的当前节点的上级节点
	timeout4Doc();//超时操作
	resizeParentWin();//当表单为子视图以当前区域打开时resaize父窗口的显示区域
	setTimeout(function(){
		resizeParentWin();	//当表单为子视图以当前区域打开时调整父窗口高度
	},2000);
	jQuery("[modulType='showHistoryRecord']").showHistoryRecord();
	addChange(); //页面跳转时提示用户是否保存修改
	if(jQuery("#dwzUnbind").size()<1){
		jQuery(window).bind("beforeunload",function(e){
			if(fieldValChanged){//表单内容被修改
				return "数据已修改！";
			}
		});
	}
	if(typeof(obpmLoad) == "function") obpmLoad();
	isComplete = true; //后台预览的时候判断页面是否重构完成
//	setTimeout(function() {
//		resizeWindow();// 当为弹出框时，调整当前窗口
//	},300);
}
//给后台preview.jsp表单预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}
//查看流程图表
function ev_viewFlow(title) {
	var dateTime = new Date().getTime();
	var _instanceId = document.getElementsByName("content.stateid")[0].value;
	//var url = '<ww:url namespace="/portal/dynaform/document" action="viewFlow" />?_docid=<ww:property value="content.id" />&_instanceId=<ww:property value="content.stateid" />&dateTime=' + dateTime;
	var url = contextPath + "/portal/dynaform/document/viewFlow.action?_docid=" + contentId + "&_instanceId=" + _instanceId + "&dateTime=" + dateTime;
	//showFrameByDiv(url, '{*[Workflow_Diagram]*}', 700, 550);
	OBPM.dialog.show({
		width: 600,
		height: 420,
		url: url,
		args: {},
		title: title,
		ok:true,
		okVal:'Close',
		close: function(result) {
			var rtn = result;
		}
	});
}

//查看流程历史
function ev_viewHistory(title) {
	var flag = true;
    var dateTime = new Date().getTime();
    var _instanceId = document.getElementsByName("content.stateid")[0].value;
    var application = document.getElementById("applicationid").value;
	//var url = "<ww:url value='/portal/share/workflow/runtime/flowhis.jsp' />?_docid=<ww:property value='content.id' />&flowStateId=<ww:property value='content.stateid' />&application=<%=dochtmlBean.getDoc().getApplicationid()%>&dateTime=" + dateTime;
	var url = contextPath + "/portal/dynaform/document/showFlowHistory.action?flowStateId=" + _instanceId + "&application=" + application + "&dateTime=" + dateTime;
	//showFrameByDiv(url, '{*[Workflow_History]*}', 700, 550);
	OBPM.dialog.show({
		width: 510,
		height: 540,
		url: url,
		args: {},
		title: title,
		ok:true,
		okVal:'Close',
		close: function(result) {
		}
	});
}

//ajax执行操作按钮的执行前脚本
function ev_runbeforeScript(actid){
	var flag = false;//执行完脚本后,是否进行下一步提交
	jQuery.ajax({
		type: 'POST',
		async:false, 
		url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + actid,
		dataType : 'text',
		data: jQuery("#document_content").serialize(),
		success:function(result) {
			if(result != null && result != ""){
				result = result.replace(/\n/g,"<br/>");
				result = result.replace(/\r/g,"<br/>");
	        	var jsmessage = eval("(" + result + ")");
	        	var type = jsmessage.type;
	        	var content = jsmessage.content;
	        	
	        	if(type){
	        		if(type == '16'){
		        		alert(content);
		        		flag = false;
		        	}
		        	
		        	if(type == '32'){
		        		var rtn = window.confirm(content);
		        		if(!rtn){
		        			flag = false;
		        		}else {
		        			flag = true;
		        		}
		        	}
	        	}else {
	        		flag = true;
	        	}
	        	
	        	if(flag){
	        		var changedField = jsmessage.changedField;
	        		if(changedField){
	        			var fields = changedField.split(";");
	        			for(var i=0; i<fields.length; i++){
	        				var field = fields[i].split(":");
	        				if(document.getElementsByName(field[0])){
	        					document.getElementsByName(field[0])[0].value = field[1];
	        				}
	        			}
	        		}
	        	}
	        }else {
	        	flag = true;
	        }
		},
		error: function(result) {
			alert("运行脚本出错");
		}
	});
	
	return flag;
}

//弹出层流程挂起
function ev_flowHandup4dialog(_rtn){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowHandup.action?' + _rtn;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}

//弹出层流程恢复
function ev_flowRecover4dialog(_rtn){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowRecover.action?' + _rtn;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}

//流程挂起
function ev_flowHandup(nodertId){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowHandup.action?nodertId=' + nodertId;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}

//流程恢复
function ev_flowRecover(nodertId){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowRecover.action?nodertId=' + nodertId;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}

//文件下载
function downloadFile(name,path){
	var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ encodeURI(name) + "&filepath=" + path);
	var _tmpwin = window.open(url,"_blank");
	_tmpwin.location.href = url;
}

//前台用户调整流程
function editFlowByFrontUser(disableFlowNode,changeFlowOperator,changeFlowCc,title) {
	var flag = true;
    var dateTime = new Date().getTime();
	var docid = document.getElementsByName("content.id")[0].value;
	var stateid = document.getElementsByName("content.stateid")[0].value;
	var flowid = document.getElementById("flowid").value;
	var formid = document.getElementsByName("_formid")[0].value;
	var applicationid = document.getElementsByName("content.applicationid")[0].value;
	var url = contextPath + "/portal/share/workflow/runtime/billflow/defi/view.action?_formid="+formid+"&_docid="+docid+"&content.id="+docid+"&_stateId="+stateid+"&id="+flowid+"&application="+applicationid+"&dateTime=" + dateTime;
	url += "&disableFlowNode="+disableFlowNode+"&changeFlowOperator="+changeFlowOperator+"&changeFlowCc="+changeFlowCc;

	OBPM.dialog.show({
		width: 1000,
		height: 550,
		url: url,
		args: {},
		title: '调整流程',
		close: function(result) {
			if(result){
				unbindBeforeUnload();//取消绑定beforeunload事件
			}
			var docid = document.getElementById("_docid").value;
			var stateid = document.getElementsByName("content.stateid")[0].value;
			var applicationid = document.getElementsByName("content.applicationid")[0].value;
			StateMachineUtil.toFlowHtmlTextByState(docid,stateid,applicationid, function(rtn){
				var textEl = document.getElementById("flowHtmlText");
				if(textEl){
					var html = '<table class="table_noborder" width="100%">';
					html+='<tr>' +rtn;
					html+='</tr></table>';
					textEl.innerHTML = html;
				}
			});
			
		}
	});
}
//流程终止
function terminateFlow() {

	artDialog.prompt('请输入审批意见：',function(val,win){
		jQuery('[name=_attitude]').val(val);
		
		ignoreFormCheck();
		var url = contextPath
				+ '/portal/dynaform/document/terminateFlow.action';
		
		var application = document.getElementsByName("application")[0].value;
		var id = document.getElementsByName("content.id")[0].value;
		document.forms[0].action = url;
		makeAllFieldAble();
		document.forms[0].submit();
	},true,"","终止流程");
	
}
