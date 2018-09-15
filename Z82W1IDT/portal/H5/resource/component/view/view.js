/**
 * 窗口打开类型 为普通模式打开新的窗口
 */
var OPEN_TYPE_NORMAL = 0x0000001;
/**
 * 窗口打开类型 弹出框显示
 */
var OPEN_TYPE_POP = 0x0000010;
/**
 * 窗口打开类型 在父窗口区域显示
 */
var OPEN_TYPE_PARENT = 0x0000100;
/**
 * 窗口打开类型 当前区域显示
 */
var OPEN_TYPE_OWN = 0x0000110;
/**
 * 窗口打开类型 网格显示
 */
var OPEN_TYPE_GRID = 0x0000120;
/**
 * 窗口打开类型 弹出层显示
 */
var OPEN_TYPE_DIV = 0x0000115;
/**
 * 一般视图
 * 
 * @type Number
 */
var VIEW_TYPE_NORMAL = 0x0000010;
/**
 * 子视图
 * 
 * @type Number
 */
var VIEW_TYPE_SUB = 0x0000011;

var activityAction = contextPath + '/portal/dynaform/activity/action.action';
var importURL = contextPath
		+ '/portal/share/dynaform/dts/excelimport/importbyid.jsp';
var downloadURL = contextPath + '/portal/share/download.jsp'; // Excel下载URL

/**
 * 文档新建 (DocumentCreate)
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doNew(activityId) {
	createDoc(activityId); // 查看相应的jsp页面
}

function openWindowByType(action, title, viewType, actid) {
	if(toggleButton("button_act")) return false;
	
	var flag = false;
	
	if(actid){
		jQuery.ajax({
			type: 'POST',
			async:false, 
			url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + actid,
			dataType : 'text',
			data: jQuery("#formList").serialize(),
			success:function(result) {
				if(result != null && result != ""){
		        	var jsmessage = eval("(" + result + ")");
		        	var type = jsmessage.type;
		        	var content = jsmessage.content;
		        	
		        	if(type == '16'){
		        		alert(content);
		        		document.forms[0].submit();
		        	}
		        	
		        	if(type == '32'){
		        		var rtn = window.confirm(content);
		        		if(!rtn){
		        			document.forms[0].submit();
		        		}else {
		        			flag = true;
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
	} else {
		flag = true;
	}

	if(flag){
		// View的openType(打开类型)
		var openType = OPEN_TYPE_NORMAL;
		var url = action;
	
		if (viewType == VIEW_TYPE_SUB) {
			var isRelate = document.getElementsByName("isRelate");
			url += "&isSubDoc=true";
			if (isRelate){
	            if (isRelate.length>0){
	            	var relate = isRelate[0].value;
	            	url += "&isRelate="+relate;
	            }
			}
		}
	
		if (document.getElementsByName("_openType")[0]) {
			openType = document.getElementsByName("_openType")[0].value;
		}
	
		var parameters = getQueryString();
	
		resetBackURL(); // view.js
	
		if (openType == OPEN_TYPE_NORMAL) {
			if (isHomePage()) { // 首页单独处理
				url += "&_backURL="
						+ encodeURIComponent(contextPath
								+ "/portal/dispatch/homepage.jsp");
				url += "&" + parameters;
				parent.location = appendApplicationidByView(url);
			} else {
				document.forms[0].action = url;
				document.forms[0].submit();
			}
		} else if (openType == OPEN_TYPE_POP || openType == OPEN_TYPE_DIV) {
			var oSelects = document.getElementsByName("_selects");
			var _selects="";
			if(oSelects){
				for(var i=0;i<oSelects.length;i++){
					if(oSelects[i].checked){
						_selects+="&_selects="+oSelects[i].value;
					}
				}
			}
			url += "&" + parameters + "&openType=" + openType+_selects;
			url = appendApplicationidByView(url);
			var w = document.body.clientWidth - 25;
			var h = document.body.clientHeight - 100;
			showfrontframe({
						title : "",
						url : url,
						w : w,
						h : h,
						windowObj : window.parent,
						callback : function(result) {
							setTimeout(function(){//通过右上角的关闭图标关闭弹出层后会显示加载进度条，加延迟后没有这个问题
								document.forms[0].submit();
							},1);
						}
					});
		} else if (openType == OPEN_TYPE_OWN) {
			var id = document.getElementsByName("_viewid")[0].value;
			if (viewType == VIEW_TYPE_SUB) {
				var sub_divid = parent.document.getElementById('sub_divid');
				var doc_obj = parent.document.getElementById(id);
				if (sub_divid) {
					sub_divid.value = doc_obj.src;
				}
	//			if (doc_obj) {
					//url += "&" + parameters;
					//doc_obj.src = url;
					document.forms[0].action = url;
					document.forms[0].submit();
	//			}
			} else {
				document.forms[0].action = url;
				document.forms[0].submit();
			}
	
		} else {
			if(toggleButton("button_act")) return false;
		}
	}
}

/**
 * 检查URL是否带上application参数，没有就添加
 * <p>提交表单不能使用本方法：<code>document.forms[0].submit()</code></p>;
 * @param url 返回带有application参数的URL
 * @returns
 */
function appendApplicationidByView(url) {
	var appObject = document.getElementsByName("application")[0];
	if (appObject && url.indexOf("application") < 0) {
		if (url.indexOf("?") >= 0) {
			url += "&application=" + appObject.value;
		} else {
			url += "?application=" + appObject.value;
		}
	}
	return url;
}

/**
 * 父窗口是否为首页
 * 
 * @return {如果是返回true,否则false}
 */
function isHomePage() {
	if (parent
			&& parent.location.href.toLowerCase().substring(0,parent.location.href.toLowerCase().indexOf("?")).indexOf("homepage.jsp") != -1) {
		return true;
	}
	return false;
}

/**
 * 获取查询表单中的参数
 * 
 * @return {}
 */
function getQueryString() {
	var parameters = "";
	if (document.getElementsByName("_viewid")[0]) {
		parameters += "_viewid="
				+ document.getElementsByName("_viewid")[0].value;
	}
	if (document.getElementsByName("parentid")[0]) {
		parameters += "&parentid="
				+ document.getElementsByName("parentid")[0].value;
	}
	if (typeof(dy_getValuesMap) == "function") {
		// dy_getValuesMap为SearchForm中的方法
		parameters += "&" + jQuery.param(dy_getValuesMap(false),true);
	}
	return parameters;
}

/**
 * 文档删除 (DocumentDelete)
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doRemove(activityId) {
	var checkboxs = document.getElementsByName("_selects");
	var isSelect = false;
	for (var i = 0; i < checkboxs.length; i++) {
		if (checkboxs[i].checked == true) {
			isSelect = true;
			break;
		}
	}
	if (isSelect) {
		if (activityId != null && activityId != "") {
			var rtn = window.confirm("确定要删除您选择的记录吗？");
			if (!rtn)
				return;
		}
	} else {
		alert("请选择要删除的数据！");
		return false;
	}

	ev_submit(activityId, false, "doDelete");
}

/**
 * 文档查询 (DocumentQuery)
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doQuery(activityId) {
	ev_submit(activityId);
}

/**
 * 重新设置BackURL
 */
function resetBackURL() {
	var oBackURL = document.getElementsByName("_backURL")[0];
	if (oBackURL && oBackURL.value) {
		// 序列化查询表单字段
		var params = jQuery("form").serialize(); 
		//var backURL = oBackURL.value.substring(0, oBackURL.value.indexOf("?"));
		if (oBackURL.value.indexOf("?") != -1) {
			oBackURL.value = oBackURL.value;
			if (params) { // 没有查询表单
				var paramArrary = params.split("&");
				for(var i=0;i<paramArrary.length;i++){
					if(oBackURL.value.indexOf(paramArrary[i])!=-1 || paramArrary[i].indexOf("_backURL") != -1){//防止在backURL后面再拼多一次backURL,导致第二个backURL后面的参数不生效
					}else{
						oBackURL.value += "&" + paramArrary[i];
					}
				}
				
			}
		} else {
			oBackURL.value = oBackURL.value;
			if (params) {
				oBackURL.value += "?" + params;
			}
		}
	}
}

/**
 * 批量签章按钮对应的Function
 */
function DoBatchSignature() {
	if(navigator.userAgent.indexOf("MSIE")<0){
		alert("金格iSignature电子签章HTML版只支持IE，如果要签章请用IE浏览器");
		return;
	}
	var mLength = document.getElementsByName("_selects").length;
	var vItem;
	var DocumentList = "";
	for (var i = 0; i < mLength; i++) {
		vItem = document.getElementsByName("_selects")[i];
		if (vItem.checked) {
			if (i != mLength - 1) {
				DocumentList = DocumentList + vItem.value + ";";
			} else {
				DocumentList = DocumentList + vItem.value;
			}
		}
	}
	// alert(DocumentList);
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

	var url = document.getElementById("mGetBatchDocumentUrl").value;
	var mLoginname = document.getElementById("mLoginname").value;
	var DocumentID = document.getElementById("DocumentID").value;
	var ApplicationID = document.getElementById("ApplicationID").value
	var FormID = document.getElementById("FormID").value
	url = url + "?DocumentID=" + DocumentID + "&ApplicationID2="
			+ ApplicationID + "&FormID2=" + FormID;

	ajax.onreadystatechange = function() {

		if (ajax.readyState == 4 && ajax.status == 200) {

			if (ajax.responseText == "false") {

				return;
			}

			var documentName = ajax.responseText.split(',');
			// var buffer = [];
			var fildsList = "";
			for (var i = 0; i < documentName.length; i++) {

				if (i != documentName.length - 1) {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i] + ";");
				} else {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i]);
				}

			}
			// alert(fildsList);
			// buffer.join("");
			// alert(buffer);
			// alert(formList.SignatureControl);
			if (formList.SignatureControl != null) {
				if (DocumentList == "") {
					alert("请选择需要签章的文档。");
				}
				formList.SignatureControl.FieldsList = fildsList; // 所保护字段
				formList.SignatureControl.Position(460, 275); // 签章位置
				formList.SignatureControl.DocumentList = DocumentList; // 签章页面ID
				formList.SignatureControl.WebSetFontOther("True", "同意通过", "0",
						"宋体", "11", "000128", "True"); // 默认签章附加信息及字体,具体参数信息参阅技术白皮书
				formList.SignatureControl.SaveHistory = "false"; // 是否自动保存历史记录,true保存
				// false不保存
				// 默认值false
				formList.SignatureControl.UserName = "lyj"; // 文件版签章用户
				formList.SignatureControl.WebCancelOrder = 0; // 签章撤消原则设置,
				// 0无顺序 1先进后出
				// 2先进先出 默认值0
				// formList.SignatureControl.DivId = "contentTable"; //签章所在层
				formList.SignatureControl.AutoCloseBatchWindow = true;
				formList.SignatureControl.RunBatchSignature();
			} else {
				alert("请安装金格iSignature电子签章HTML版软件");
				document.getElementById("hreftest2").click();
			}

		}

	};

	ajax.open("POST", url);

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(null);

}

/**
 * 刷新父窗口
 */
function ev_reloadParent() {
	try {
		// operation属性在detail.jsp页面中获取
		if (operation != 'doSave' && operation != 'doDelete') {
			return;
		}

		if (parent) {
			if (parent.treeview) { // 刷新父窗口树型对象
				parent.selectedNode = OBPM("#treedocid").val();
//				parent.treeview.jstree("refresh", "#"
//								+ OBPM("#treedocid").val());
				parent.treeview.jstree("refresh", "#root");//替代了上面的方法，刷新整棵树，临时处理，会影响性能
			}
		}
	} catch (ex) {
	}
}

/** *********front js********* */
function showAction(viewMode, addType) {
	document.getElementsByName("viewMode")[0].value = viewMode;

	// var url = '<%=request.getAttribute("backURL")%>';
	//var url = document.getElementById("backURL").value;
	var url = formList.action;
	var index = url.indexOf('?');
	if(index > -1){
		url = url.substring(0, index);
	}
	if (addType) {
		url += '?addType=' + addType;
		//url += '&application=' + document.getElementsByName("_application")[0].value;
	}else{
		//url += '?application=' + document.getElementsByName("_application")[0].value;
	}
	formList.action = url;
	formList.submit();
}

function showActions(viewMode) {
	showAction(viewMode, null);
}

// valueMap是一个对象。
function ev_selectone(valueMap) {
	var value = jQuery.json2Str(valueMap);
	if (isEdit != false && isEdit != 'false') {
		OBPM.dialog.doReturn("{id:" + value + "}");
	}
}

// 隐藏iframe
function hidden() {
	var id = document.getElementById("_viewid").value;
	var doc_obj = parent.document.getElementById(id);
	// alert(doc_obj);
	if (doc_obj) {
		doc_obj.style.display = 'none';
	}
}

// 调整窗口
function adjustDataIteratorSize() {
	var container = document.getElementById("container");
	var searchForm = document.getElementById("searchFormTable");
	var pageTable = document.getElementById("pageTable");
	var activityTable = document.getElementById("activityTable");
	var dataTable = document.getElementById("dataTable");
	var containerHeight = document.body.clientHeight;
	if (container && containerHeight > 0) {
		container.style.height = containerHeight + 'px';
		var dataTableHeight = containerHeight;
	}
	
	if (dataTableHeight > 0) {
		if (activityTable) {
			dataTableHeight = dataTableHeight - activityTable.offsetHeight;
		}
		if (searchForm) {
			dataTableHeight = dataTableHeight - searchForm.offsetHeight;
		}
		if (pageTable) {
			dataTableHeight = dataTableHeight - pageTable.offsetHeight;
		}
		dataTable.style.width = "100%";
		if(dataTableHeight > 7)
			dataTable.style.height = dataTableHeight - 7 + 'px';
	}
	
	//container.style.visibility = "visible";
}

/**
 * 生成帮助 BuildHelp
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doBuild(activityId) {
	ev_submit(activityId, false, "");
}

/*
 * 视图打印
 */

function ev_printview(actid) {
	var viewid = document.getElementsByName("_viewid")[0].value;
	var signatureExist = document.getElementById("signatureExist").value;
	var url = activityAction;
	url += '?_signatureExist=' + signatureExist;
	url += '&_activityid=' + actid;  
	url += '&isprint=true';
	
	if(ev_runbeforeScriptforview(actid)){
		var fmmy = document.forms[0]; 
		fmmy.action=url;
		fmwin = window.open("about:blank", "_my_submit_win");   
		fmmy.target="_my_submit_win"; 
		fmmy.submit();
		fmmy.target="";
	}
	
//	var viewid = document.getElementsByName("_viewid")[0].value;
//	var signatureExist = document.getElementById("signatureExist").value;
//	
//	var url = activityAction;
//	url += '?_signatureExist=' + signatureExist;
//	url += '&_activityid=' + actid;  
//	url += '&isprint=true';
//	 var fmmy = document.forms[0]; 
//	 fmmy.action=url;
//	 fmwin = window.open("about:blank", "_my_submit_win");   
//	 fmmy.target="_my_submit_win"; 
//	 fmmy.submit();
	 
}
/*
 * 显示右边任务内容
 */
function showTaskContent(index){
}

//JumpTo操作按钮 点击事件
function ev_JumpTo(activityId, jumpType, targetList, jumpMode) {
	ev_dispatcherPage(activityId);
}

/**
 * Dispatcher按钮
 * @param actid
 * @return
 */
function ev_dispatcherPage(actid){
	if(ev_runbeforeScriptforview(actid)){
		var url = activityAction + '?_activityid=' + actid;
    	document.forms[0].action = url;
    	//document.forms[0].target = '_blank';
    	document.forms[0].submit();
    	//document.forms[0].target = '';
	}
}

/**
 * 把表单中只读的控件设置成非只读
 * 列表、折叠、网格视图查询表单执行时使用
 */
function makeAllFieldAble(){
	var elements = document.forms[0].elements;
	for (var i = 0; i < elements.length; i++) {
		var element = elements[i];
		if (element.disabled == true) {
			element.disabled = false;
		}
	}
}

function modifyActionBack(){
	makeAllFieldAble();	//把表单中只读的控件设置成非只读
	var curDateTime = (new Date()).getTime();
	document.getElementsByName('_currpage')[0].value=1;
	document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action?isQueryButton=true&_time="+curDateTime;
	document.forms[0].target="";
	document.forms[0].submit();
    }

function ev_subFormView(){
	document.getElementsByName('_currpage')[0].value=1;
	document.forms[0].action=contextPath + "/portal/dynaform/view/subFormView.action?isQueryButton=true";
	document.forms[0].target="";
	document.forms[0].submit();
}

function runscript(docid, colid,obj){
	var data = {};
	var url = contextPath + '/portal/dynaform/view/runScript.action' + '?docid=' + docid + '&columnId=' + colid;
	if(obj){
		var view = jQuery(obj).parents("div[type=includedView]");
		data = DisplayView.span2Json(obj);
	}else{
		data = jQuery(document.forms[0]).serialize();
	}
	
	jQuery.post(url,data,function(result){
		if(result && result.length>0){
			alert(result);
		}
		if(obj){
			var action = DisplayView.getAction(obj);
			DisplayView.postForm(obj,action,data);
		}else{
			document.forms[0].submit();
		}
		
	});
}

//操作列跳转按钮的方法
function jumptoform(formId, jumpMapping, title){
	var showW = top.document.documentElement.clientWidth;
	showW = showW - showW/10;
	var showH = top.document.documentElement.clientHeight;
	showH = showH - showH/10;
	var obj = eval(jumpMapping);
	var str = "";
	if(obj){
		str += "&";
		for(var i=0; i<obj.length; i++){
			var agr = obj[i].name;
			var colValue = obj[i].value;
			str += encodeURIComponent(agr) + "=" + encodeURIComponent(colValue) + "&";
		}
		str = str.substring(0, str.length-1);
	}

	var applicationid = document.getElementById("ApplicationID").value;
	var view_id = document.getElementsByName("_viewid")[0].value;
	var newAction = contextPath + '/portal/dynaform/document/newWithJump.action';
	var url = newAction + "?applicationid=" + applicationid + "&application=" + applicationid 
				+ "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1" + str
				+ "&_backURL="
				+ "&openType=16";
	
	showfrontframe({
		title : title,
		url : url,
		w : showW,
		h : showH,
		windowObj : window.parent,
		callback : function(result) {
		}
	});
}
