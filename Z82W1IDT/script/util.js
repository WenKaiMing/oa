var ie = document.all ? 1 : 0;

var wx = screen.availWidth + 'px';
var wy = screen.availHeight + 'px';


/*****修改（调整）页面大小 function editing at 2010-10-11****/
/* 重新调整窗口大小
 * bodyid : 当前页面body对象
 * tabContainerid :
 * contentTabid : centet obj
 * minRectangleid(boolean) ：窗口缩小到600X400是出现滚动条
 */
function reSizePage(bodyid,tabContainerid,contentTabid,minRectangleid){
	var obj = document.getElementById(tabContainerid);
	var contentObj = document.getElementById(contentTabid);
	//var browserHeight = document.documentElement.offsetHeight;
	//var browserWidth = document.documentElement.offsetWidth;
	var browserHeight = document.body.offsetHeight;
	var browserWidth = document.body.offsetWidth;
	//alert("body.W-->"+document.body.offsetWidth+"      getBodyid.W-->"+document.getElementById(bodyid).offsetWidth);
	if(!minRectangleid){
		if(browserWidth<600){
			contentObj.style.overflow="auto";
		}else{
			contentObj.style.overflow="hidden";
		}
		if(browserHeight<400){
			contentObj.style.overflow="auto";
		}
	}else{
		contentObj.style.overflow="auto";
	}
	if (obj) {
		obj.style.height = browserHeight-5 + "px";
		obj.style.width = browserWidth +"px";
		contentObj.style.height = browserHeight-55 + "px";
		contentObj.style.width = browserWidth-3 + "px";
	}
}

// 调整父窗口对应的IFrame大小
function adjustFrameSize(){
	var iframeid = document.getElementById("_viewid").value;
	var oIFrame = parent.document.getElementById(iframeid);
	if(oIFrame){
		oIFrame.style.height = document.getElementById('doc_divid').offsetHeight + 40;
	}
}

// 调整本窗口内容高度
function adjustContentTable() {
	var container = document.getElementById("container");
	var contentTable = document.getElementById("contentTable");
	var activityTable = document.getElementById("activityTable");
	var containerHeight = document.body.clientHeight-10;
	var containerWidth = document.body.clientWidth-5;
	if (containerHeight <= 0) {
		containerHeight = 480;
	}
	if (containerWidth <= 0) {
		containerWidth = 640;
	}
	
	if(containerHeight){
		container.style.height = containerHeight + 'px';
		
		var contentTableHeight = containerHeight;
		if (activityTable) {
			contentTableHeight = contentTableHeight - activityTable.offsetHeight;
		}
		contentTable.style.height = contentTableHeight+ 'px';
		//contentTable.style.width = containerWidth + 'px';
	} 
	container.style.visibility = "visible";
}

/******end ****/

function doBack() {
	window.history.back();
}

function exit() {
	parent.close();
}

function doExit() {
	window.close();
}

function doEmpty() {
	window.returnValue = "";
	window.close();
}

function doEnter() {
	var rtn = document.uploadForm.fileFileName.value;
	window.returnValue = rtn;
	window.close();
}
// Trim whitespace from left and right sides of s.
function trim(s) {
	return s.replace(/^\s*/, "").replace(/\s*$/, "");
}

function showViewDialog(str, viewid, fieldname, className) {
	wx = '640px';
	wy = '480px';

	var url = contextPath
			+ '/portal/share/dynaform/view/dialogFram.jsp?_viewid=' + viewid;
	url += '&className=' + className;

	var rtn = window.showModalDialog(url, str, 'font-size:9pt;dialogWidth:'
					+ wx + ';dialogHeight:' + wy + ';status:no;scroll=no;');

	var field = document.getElementById(fieldname);
	if (field) {
		if (rtn) {
			field.value = rtn.id;
		} else {
			field.value = '';
		}
		dy_view_refresh();
	}
}

function showWordDialog(title, str, docid, formName, value, fieldname, versions, opentype, displayType, saveable,  isOnlyRead,signature,isSignature) {
	
	wx = '900px';
	wy = '600px';
	var field = document.getElementById(fieldname);
	var _versions = document.getElementById(versions);
	var application = document.getElementById("application").value;
	var url = contextPath + '/portal/dynaform/document/newword.action?_docid='
		+ docid + "&type=word&_fieldname=" + fieldname + "&_opentype="
		+ opentype+"&_displayType="+displayType
		+ "&saveable=" + saveable
		+ "&isSignature=" + isSignature
		+ "&application=" + application
		+ "&formname=" + encodeURI(formName)
		+"&isOnlyRead="+isOnlyRead
		+"&signature="+signature
		+ "&versions=" + _versions.value;
	
	if (field == null) {
		url += '&filename=' + value;
	} else {
		url += '&filename=' + field.value;
	}
	// div弹出式
	if (opentype == '3' || opentype == 3 ) {
		OBPM.dialog.show({
					width : 900,
					height : 600,
					url : url,
					args : {},
					title : title,
					close : function(result) {
						var fieldVal = '';
						if (result) {
							var rv = result.split(';');
							fieldVal = rv[0];
							_versions.value = rv[1];
						}
						if (field && fieldVal != '') {
							field.value = fieldVal;
						}
					}
				});
	} else {
		var rtn = window.showModalDialog(url, str, 'font-size:9pt;dialogWidth:'
						+ wx + ';dialogHeight:' + wy + ';status:no;scroll=no;');
		if (field) {
			if (rtn) {
				field.value = rtn;
			} else {
				field.value = '';
			}
			doc.frames['main_iframe'].frames['detail'].dy_view_refresh("");
		}
	}

}

function headerElements(d) {
	var oSelect;
	var doc = window.top;
	if (doc) {
		oSelect = doc.document.getElementsByTagName("SELECT");
	} else {
		doc = window.top;

		if (doc) {
			oSelect = doc.document.getElementsByTagName("SELECT");
		} else {
			doc = window.top.document;
			oSelect = doc.getElementsByTagName("SELECT");
		}
	}
	if (oSelect.length > 0) {
		for (var i = 0; i < oSelect.length; i++) {
			oSelect[i].disabled = d;
		}
	}
}

/**
 * 隐藏document中的select元素
 */
function hiddenElement() {
	var falg = true;
	headerElements(falg);
}

function showElement() {
	var falg = false;
	headerElements(falg);
}

/*
 * 获得word控件的返回值
 */
function getWordValue(field, rtn) {
	var fields = parent.document.getElementById(field);
	if (fields) {
		if (rtn) {
			fields.value = rtn;
		} else {
			fields.value = '';
		}
	}
}

/**
 * 获取左右选择框值
 * 
 * @param {}
 *            fieldName
 */
function getSelectAboutFieldValue(name, rightId) {
	var oRight = document.getElementById(rightId);
	var valueList = "";
	if (oRight && oRight.options.length > 0) {
		for (var i = 0; i < oRight.options.length; i++) {
			valueList += oRight.options(i).value + ";";
		}
		valueList = valueList.substring(0, valueList.lastIndexOf(";"));
	}

	return valueList;
}

function showViewDialogField(title, str, viewid, mappStr, params, openType, viewType, divWidth, divHeight, maximization) {
	var url = contextPath + '/portal/share/dynaform/view/dialogTemp.jsp';
	url += '?_viewid=' + viewid;
	url += '&datetime=' + new Date().getTime();
	url += '&' + jQuery.param(params,true);
	if(divWidth == null || divWidth == "" && maximization == false){
		url += '&_defaultSize=true';//后台显示大小为默认时，允许页面根据内容设置弹出层大小
	}
	var width = 640;
	var height = 400;
	if(divWidth != "" && divWidth.trim().length > 0){
		width = divWidth;
	}
	
	if(divHeight != "" && divHeight.trim().length > 0){
		height = divHeight;
	}
	OBPM.dialog.show({
				width : width, // 默认宽度
				height : height, // 默认高度
				url : url,
				args : {'html': new String(str), 'parent': window},
				maximization: maximization,
				title : title,
				close : function(result) {
					var rtn = result;
					// 0x0000011 为树形视图, 0x0000010为日历视图
					if (viewType!=0x0000011 && viewType!=0x0000010) {
						if(params.selectOne=="false"|| params.selectOne==false){
							getDialogValue(mappStr, rtn);
						}else{
							getDialogSelectValue(mappStr, rtn);
						}
					} else {
						getDialogValue(mappStr, rtn);
					}
					
					
					
					dy_view_refresh("");
				}
			});
}

function getDialogSelectValue(mappStr,rtn){
	var mappStr = HTMLDencode(mappStr);
	var mapps = mappStr.split(";");
	if (rtn != undefined) {
		for (var i = 0; i < mapps.length; i++) {
			var rel = mapps[i].split(":");
			var colName = rel[0];
			var fldName = rel[1];
			var valStr = rtn;
			
			//alert(valStr);
			var fields = document.getElementsByName(fldName);
			
			if (fields.length > 0
					&& fields[0].tagName.toUpperCase() == 'SELECT') {
				if (!isOptionExisted(fields[0], valStr)) {
					var oOption = document.createElement("OPTION");
					oOption.text = "";
					oOption.value = valStr;
					fields[0].add(oOption);
				}
				selectOne(fields[0], valStr);
			} else if (fields.length > 0
					&& (fields[0].type.toUpperCase() == 'RADIO' || fields[0].type
							.toUpperCase() == 'CHECKBOX')) {
				for (n = 0; fields.length > n; n++) {
					var vals = valStr.split(";");
					if (vals.indexOf(fields[n].value) != -1) {
						fields[n].checked = true;
					} else {
						fields[n].checked = false;
					}
				}
			} else {
				if (fields.length == 0) {
					fields.value = valStr;
				} else {
					fields[0].value = valStr;
				}
			}
		}
		return true;
	} else {
		return false;
	}
}


function doAfterPopup(value) {
	var mappStr = window.top.document.getElementById("mappStr");
	getDialogValue(mappStr.value, value);
	window.top.frames['main_iframe'].frames['detail'].dy_view_refresh('');
}

function getDialogValue(mappStr, rtn) {
	var mappStr = HTMLDencode(mappStr);
	var mapps = mappStr.split(";");
	var isOptionExisted = function(oSel, selectedText) {
		for (var i = 0; i < oSel.options.length; i++) {
			if (oSel.options[i].text == selectedText) {
				return true;
			}
		}
		return false;
	}
	var selectOne = function(oSel, selectedText) {
		for (n = 0; oSel.options.length > n; n++) {
			if (selectedText == oSel.options[n].text) {
				oSel.options[n].selected = true;
			}
		}
	}
	if (rtn != undefined) {
		if (rtn) {
			rtn = jQuery.parseJSON(rtn);
		}
		for (var i = 0; i < mapps.length; i++) {
			var rel = mapps[i].split(":");
			var colName = rel[0];
			var fldName = rel[1];
			var valStr = '';
			if (jQuery.jQueryValues(rtn).length > 0) {
				var values = jQuery.jQueryValues(rtn);//jquery-obpm-extend.js
				jQuery.each(values,function(val) {
							if (values[val][colName] != undefined)
								valStr += values[val][colName] + ";";
						});
			}
			valStr = valStr.substring(0, valStr.lastIndexOf(";"));
			valStr = HTMLDencode(valStr);
			var reg = /&nbsp;/g;
			valStr = valStr.replace(reg, "");
			if(valStr=="&nbsp"){
				valStr = "";
			}
			//alert(valStr);
			var fields = document.getElementsByName(fldName);
			
			if (fields.length > 0
					&& fields[0].tagName.toUpperCase() == 'SELECT') {
				if (!isOptionExisted(fields[0], valStr)) {
					var oOption = document.createElement("OPTION");
					oOption.text = "";
					oOption.value = valStr;
					fields[0].add(oOption);
				}
				selectOne(fields[0], valStr);
			} else if (fields.length > 0
					&& (fields[0].type.toUpperCase() == 'RADIO' || fields[0].type
							.toUpperCase() == 'CHECKBOX')) {
				for (n = 0; fields.length > n; n++) {
					var vals = valStr.split(";");
					if (vals.indexOf(fields[n].value) != -1) {
						fields[n].checked = true;
					} else {
						fields[n].checked = false;
					}
				}
			} else {
				if (fields.length == 0) {
					fields.value = valStr;
				} else {
					fields[0].value = valStr;
				}
			}
		}
		return true;
	} else {
		return false;
	}
}
function selectDate(d) {
	var arg = new Object();
	arg.str_datetime = d;
	arg.time_comp = false;
	var rtn = window.showModalDialog(contextPath + '/script/calendar.html',
			arg, 'dialogWidth=400px;dialogHeight=240px;status:no;scroll=no;');
	// alert("rtn->"+ rtn);
	return (rtn == null ? "" : rtn);
}

function selectDatetime(d) {
	var arg = new Object();
	arg.str_datetime = d;
	arg.time_comp = true;
	var rtn = window.showModalDialog(contextPath + '/script/calendar.html',
			arg, 'dialogWidth=210px;dialogHeight=240px;status:no;scroll=no;');
	return (rtn == null ? "" : rtn);
}

function selectTime(t) {
	var rtn = window.showModalDialog(contextPath + '/js/time.htm', t,
			'dialogWidth=260px;dialogHeight=50px;status:no;scroll=no;');
	return (rtn == null ? "" : rtn);
}

function selectDeptEx(fieldId, fieldName, parentDept, multiSelect, selectChild,
		selectUrl) {
	if (fieldId == null) {
		return;
	}

	var rtn = selectDept(parentDept, multiSelect, selectChild, selectUrl);

	if (rtn == null || rtn == 'undefined') {
	} else if (rtn == '') {
		fieldId.value = '';
		if (fieldName != null)
			fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			if (fieldName != null)
				fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				if (fieldName != null)
					fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn.split(';');
			fieldId.value = t[0];
			if (fieldName != null)
				fieldName.value = t[1];
		}
	}
}

function selectDeptByChildEx(fieldId, fieldName, childDept, multiSelect,
		selectChild, selectUrl) {
	if (fieldId == null) {
		return;
	}

	var rtn = selectDeptByChild(childDept, multiSelect, selectChild, selectUrl);

	if (rtn == null || rtn == 'undefined') {
	} else if (rtn == '') {
		fieldId.value = '';
		if (fieldName != null)
			fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			if (fieldName != null)
				fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				if (fieldName != null)
					fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn.split(';');
			fieldId.value = t[0];
			if (fieldName != null)
				fieldName.value = t[1];
		}
	}
}

function selectGroupEx(fieldId, fieldName, type, multiSelect, selectUrl) {
	if (fieldId == null) {
		return;
	}

	var rtn = selectGroup(type, multiSelect, selectUrl);

	if (rtn == null || rtn == 'undefined') {
	} else if (rtn == '') {
		fieldId.value = '';
		if (fieldName != null)
			fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			if (fieldName != null)
				fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				if (fieldName != null)
					fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn.split(';');
			fieldId.value = t[0];
			if (fieldName != null)
				fieldName.value = t[1];
		}
	}
}

function selectUserEx(fieldId, fieldName, type, multiSelect, parentDept,
		selectChild) {
	if (fieldId == null) {
		return;
	}
	var rtn = selectUser(type, multiSelect, parentDept, selectChild);

	if (rtn == null || rtn == 'undefined') {
	} else if (rtn == '') {
		fieldId.value = '';
		if (fieldName != null)
			fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			if (fieldName != null)
				fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				if (fieldName != null)
					fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn.split(';');
			fieldId.value = t[0];
			if (fieldName != null)
				fieldName.value = t[1];
		}
	}

}

function selectAll(oldValue, multiSelect, selectChild) {
	wx = '600px';
	wy = '400px';
	var url = contextPath + '/core/department/select.action';

	// alert("oldValue->" + oldValue);
	var selectid = "";
	if (oldValue != null && oldValue != "") {
		oldValue = oldValue.replace("(", "");
		oldValue = oldValue.replace(")", "");
		oldValue = oldValue.replace("{", "");
		oldValue = oldValue.replace("}", "");
		var tmp = oldValue.split(";");
		for (var i = 0; i < tmp.length; i++) {
			var t = tmp[i].split("|");
			if (t != null && t[0] != '') {
				selectid = selectid + t[0] + ";";
			}
		}
	}
	url = url + '?SELECTEDID=' + selectid;

	if (multiSelect != null && multiSelect) {
		url = url + '&MULTISELECT=TRUE';
	}
	if (selectChild != null && selectChild) {
		url = url + '&SELECTCHILD=TRUE';
	}
	//
	// if (type == 'U' && parentDept != null) {
	// url = url + '&sm_deptid=' + parentDept;
	// }
	// alert("url->"+url);
	var rtn = showframe('', url);

	return rtn;
}

function selectAllEx(fieldId, fieldName, multiSelect, selectChild) {
	if (fieldId == null) {
		return;
	}

	var rtn = selectAll(fieldId.value, multiSelect, selectChild);

	if (rtn == null || rtn == 'undefined') {
	} else if (rtn == '') {
		fieldId.value = '';
		if (fieldName != null)
			fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			if (fieldName != null)
				fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				if (fieldName != null)
					fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn.split(';');
			fieldId.value = t[0];
			if (fieldName != null)
				fieldName.value = t[1];
		}
	}
}

/**
 * 显示前台弹出框
 * 
 * @param {}
 *            options
 */
function showfrontframe(options) {
	var title = options.title;
	var querystr = options.url;
	var width = options.w ? options.w : 300;
	var height = options.h ? options.h : 400;
	
	var arg = new Object();
	arg.title = title;
	arg.url = querystr;
	arg.windowObj = options.windowObj;
	
	
	var url = contextPath + '/portal/share/frame.jsp?title=' + title;
	OBPM.dialog.show({
				width : width,
				height : height,
				url : url,
				args : arg,
				title : title,
				close : function(result) {
					var rtn = result;
					options.callback(rtn);
				}
			});
}

function showframe(title, querystr, isDiv) {
	var pth = window.location.pathname;
	var pos1 = pth.lastIndexOf("/");
	var pos2 = pth.lastIndexOf("\\");
	var pos = Math.max(pos1, pos2);
	querystr.title = title;
	if (querystr.url != null) {
		if (!(querystr.url.indexOf("/") == 0 || querystr.url.indexOf("\\") == 0))
			querystr.url = pth.substring(0, pos) + "/" + querystr.url;
	} else {
		if (!(querystr.indexOf("/") == 0 || querystr.indexOf("\\") == 0))
			querystr = pth.substring(0, pos) + "/" + querystr;
	}
	var arg = new Object();
	arg.title = title;
	arg.url = querystr;
	arg.window = this.window;
	// alert(isDiv);
	if (!isDiv) {
		return parent.showModalDialog(
				contextPath + '/frame.jsp?title=' + title, arg,
				'resizable=yes;help=no;status=no;font-size:9pt;dialogWidth:'
						+ wx + ';dialogHeight:' + wy + ';status:no;scroll:no;');
	} else {
		showFrameByDiv(arg.url, arg.title);
	}
}

// 以div的方式弹出(showfrmae)
function showFrameByDiv(url, title, wx, wy) {
	var doc;
	if (window.top) {
		var div1 = window.top.document.getElementById("closeWindow_DIV");

		if (div1) {
			hiddenElement();

			doc = window.top.document;
		} else {
			hiddenElement();
			doc = window.document;
		}

		doc.getElementById('dbody').innerHTML = "<iframe id='FrameContent' name='FrameContent' style='border:0px;width:720px;height:540px;z-index:1000;overflow:auto' frameborder='0' />";
		var popWin = doc.getElementById('PopWindows');

		if (wx && wy && popWin) {
			popWin.style.top = 30 + "px";
			popWin.style.width = wx + 'px';
			popWin.style.height = wy + 'px';
			doc.getElementById('dbody').style.width = wx - 5 + 'px';
			doc.getElementById('dbody').style.height = wy - 30 + 'px';
			doc.getElementById("dheader_title").innerHTML = "<font size=2>"
					+ title + "</font>";
			var left = (doc.body.clientWidth - parseInt(popWin.style.width))
					/ 2 + "px";
			var top = (doc.body.clientHeight - parseInt(popWin.style.height))
					/ 2 + "px";
			popWin.style.left = left;
			popWin.style.top = top;
			popWin.style.display = "block";
		}

		doc.getElementById('closeWindow_DIV').style.display = 'block';

		popWin.style.display = 'block';

		doc.getElementById('FrameContent').src = url;
		hidemenu();
	}
}

/* 隐藏鼠标右击菜单 */
function hidemenu() {
	window.top.document.oncontextmenu = function() {
		return false;
	}
}

/* 显示鼠标右击菜单 */
function showmenu() {
	window.top.document.oncontextmenu = function() {
		return true;
	}
}

/* 隐藏div */
function closePopWindows() {
	var doc;
	var popWindows = window.top.document.getElementById('PopWindows');
	if (popWindows) {
		showElement();
		doc = window.top.document;
	} else {
		showElement();
		doc = window.document;
	}
	var view_id = document.getElementById("view_id");
	if (view_id) {
		view_id = view_id.value;
	}
	// 隐藏弹出Div
	doc.getElementById('closeWindow_DIV').style.display = 'none';
	doc.getElementById('PopWindows').style.display = 'none';
	doc.getElementById('dbody').style.height = '100%';
	doc.getElementById('PopWindows').style.height = '0px';
	doc.getElementById('dbody').innerHTML = '';
	doc.getElementById('dheader_title').innerHTML = '';
	showmenu();
	var frames = doc.frames['main_iframe'].frames['detail'].document[view_id];
	if (frames) {
		frames.ev_reload();
	}
	doc.frames['main_iframe'].frames['detail'].dy_view_refresh(""); // 执行refresh的方法
}

function closeParentDiv() {
	var frameContent = window.frames['FrameContent'];
	var FrameContent_dialog = window.parent.frames['FrameContent_dialog'];
	if (frameContent) {
		try {
			if (window.document.getElementById('FrameContent')) {
				window.document.getElementById('FrameContent').style.display = 'none';
				window.document.getElementById('closeWindow_DIV').style.display = 'none';
				window.document.getElementById('PopWindows').style.display = 'none';
				window.document.getElementById('dbody').style.height = '100%';
				window.document.getElementById('PopWindows').style.height = '0px';
			}
			frameContent.closePopWindows();
		} catch (e) {

		}
	}
	if (FrameContent_dialog) {
		FrameContent_dialog.closePopWindows();
	}
}

function shownomodalframe(title, querystr) {
	var x = 0;
	var y = 0;
	var w = screen.availWidth - 10;
	var h = screen.availHeight - 30;

	var pth = window.location.pathname;
	var pos1 = pth.lastIndexOf("/");
	var pos2 = pth.lastIndexOf("\\");
	var pos = Math.max(pos1, pos2);

	querystr.title = title;

	if (querystr.url != null) {
		if (!(querystr.url.indexOf("/") == 0 || querystr.url.indexOf("\\") == 0))
			querystr.url = pth.substring(0, pos) + "/" + querystr.url;
		return window.open(contextPath + "/frame.jsp?" + querystr.url
						+ "&title=" + title, '', 'left=' + x + ', top=' + y
						+ ', height=' + h + ', width=' + w
						+ ', menubar=no, toolbar=no, resizable=yes');
	} else {
		if (!(querystr.indexOf("/") == 0 || querystr.indexOf("\\") == 0))
			querystr = pth.substring(0, pos) + "/" + querystr;
		return window.open(contextPath + "/frame.jsp?" + querystr + "&title="
						+ title, '', 'left=' + x + ', top=' + y + ', height='
						+ h + ', width=' + w
						+ ', menubar=no, toolbar=no, resizable=yes');
	}
}

function setToday(obj) {
	if (document.getElementById(obj) != null && document.getElementById(obj).value == '')
		document.getElementById(obj).value = getToday;;
}

function getToday() {
	var d, s = '';
	d = new Date();
	s += d.getYear() + '-';
	s += (d.getMonth() + 1) + "-";
	s += d.getDate();
	return (s);
}

function addParam(url, name, val) {
	if (url != null && name != null) {
		if (url.indexOf('?') == -1) {
			url = url + '?' + name + '=' + val;
		} else {
			url = url + '&' + name + '=' + val;
		}
	}
	return url;
}
function formatdate(str) {
	var ret, ary;
	ary = str.split("-");
	ret = ary[1] + "/" + ary[2] + "/" + ary[0];
	return ret;
}
function getYear(str) {
	var ret, ary;
	ary = str.split("-");
	return ary[0];
}

function getMonth(str) {
	var ret, ary;
	ary = str.split("-");
	return ary[1];
}

function getDay(str) {
	var ret, ary;
	ary = str.split("-");
	return ary[2];
}

function checkDuringDate(startdate, enddate) {
	if (document.getElementById(startdate) != null && document.getElementById(enddate).value == '')
		return true;
	if (document.getElementById(startdate) != null && document.getElementById(enddate).value == '')
		return true;

	var sd = Date.parse(formatdate(document.getElementById(startdate).value));
	var ed = Date.parse(formatdate(document.getElementById(enddate).value));

	return ed >= sd;
}

function getSelectedValue(Obj) {
	if (Obj != null && Obj.options.length > 0) {
		return Obj.options[Obj.selectedIndex].value;
	}
	return "";
}

function selectOne(Obj, value, callback) {
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

function selectMulti(fieldName, values) {
	var oSelect = document.getElementsByName(fieldName);
	if (oSelect && oSelect.multiple) {
		for (i = 0; i < oSelect.options.length; ++i) {
			if (values.indexOf(oSelect.options[i].value)) {
				oSelect.selectedIndex = i;
				break;
			}
		}
	}
}

function checkSelection(obj) {
	var b = false;
	if (obj != null) {
		for (i = 0; i < obj.length; ++i) {
			if (obj[i].checked) {

				return true;
			}
		}
	}
	return false;
}

function checkDates(startdate, startdatename, enddate, enddatename) {
	if (document.getElementById(startdate).value == ''
			|| document.getElementById(startdate).value == '1900-01-01') {
		alert('??????' + startdatename);
		return false;
	}

	if (document.getElementById(enddate).value == ''
			|| document.getElementById(enddate).value == '1900-01-01') {
		alert('??????' + enddatename);
		return false;
	}

	var sd = Date.parse(formatdate(document.getElementById(startdate).value));
	var ed = Date.parse(formatdate(document.getElementById(enddate).value));
	if (!(ed > sd)) {
		alert(enddatename + '????????' + startdatename);
		return false;
	}
	if (parseInt(getYear(document.getElementById(startdate).value))
			- parseInt(getYear(document.getElementById(enddate).value)))
		if (!window.confirm(startdatename + enddatename + '?????????????????'))
			return false;

	return true;
}

function checkDuplicateSKU(obj, count) {
	for (i = 1; i < count; ++i) {
		if (document.getElementById(obj + i) != null && document.getElementById(obj + i).value != '') {
			var ivar = document.getElementById(obj + i).value;

			for (j = 1; j < count; ++j) {
				if (i != j && document.getElementById(obj + j) != null
						&& document.getElementById(obj + j).value != '') {
					var jvar = document.getElementById(obj + j).value;
					if (ivar == jvar)
						return true;
				}
			}
		}
	}
	return false;
}

function setCheck(els, value) {
	for (i = 0; i < els.length; ++i) {
		if (typeof(value) == "object") {
			els[i].checked = (value.indexOf(els[i].value) >= 0);
		} else {
			els[i].checked = els[i].value == value;
		}
	}
}

function putToValuesMap(valuesMap, fldName, value) {
	var oFld = document.getElementById(fldName);
	if (oFld) {
		valuesMap[fldName] = value;
	}
}

function selectEmailEx(fieldId, fieldName, multiSelect, showLayer, selectLayer,
		DLayer, GLayer, ULayer) {
	if (fieldId == null)
		return;
	var rtn = selectOrg(fieldId, fieldName, multiSelect, showLayer,
			selectLayer, DLayer, GLayer, ULayer);
	if (rtn == 'undefined') {

	} else if (rtn == '') {
		fieldId.value = '';
		fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				fieldName.value += t[2] + ';';
			}
		} else {
			var t = rtn[0].split(';');
			fieldId.value = t[0];
			fieldName.value = t[2];
		}
	}
}

// ????????????
function selectOrg(fieldId, fieldName, multiSelect, showLayer, selectLayer,
		DLayer, GLayer, ULayer) {
	wx = '500px';
	wy = '500px';
	var url = contextPath + '/framework/selectOrg.do?x=';
	if (fieldId != null)
		url = url + '&FieldID=' + fieldId.value;
	if (fieldName != null)
		url = url + '&FieldName=' + fieldName.value;
	if (multiSelect != null && multiSelect)
		url = url + '&MultiSelect=true';
	if (showLayer != null)
		url = url + '&ShowLayer=' + showLayer;
	if (selectLayer != null)
		url = url + '&SelectLayer=' + selectLayer;
	if (DLayer != null)
		url = url + '&DLayer=' + DLayer;
	if (GLayer != null)
		url = url + '&GLayer=' + GLayer;
	if (ULayer != null)
		url = url + '&ULayer=' + ULayer;
	var rtn = showframe('????', url);
	// var rtn = window.open(url,"_blank","");
	return (rtn == null ? "" : rtn);
}

function selectOrgEx(fieldId, fieldName, multiSelect, showLayer, selectLayer,
		DLayer, GLayer, ULayer) {
	if (fieldId == null)
		return;
	var rtn = selectOrg(fieldId, fieldName, multiSelect, showLayer,
			selectLayer, DLayer, GLayer, ULayer);
	if (rtn == 'undefined') {

	} else if (rtn == '') {
		fieldId.value = '';
		fieldName.value = '';
	} else {
		if (multiSelect != null && multiSelect) {
			fieldId.value = '';
			fieldName.value = '';
			for (var i = 0; i < rtn.length; i++) {
				var t = rtn[i].split(';');
				fieldId.value += t[0] + ';';
				fieldName.value += t[1] + ';';
			}
		} else {
			var t = rtn[0].split(';');
			fieldId.value = t[0];
			fieldName.value = t[1];
		}
	}
}

function uploadshowframe(title, querystr, uploadFrontFileName) {
	var pth = window.location.pathname;
	var pos1 = pth.lastIndexOf("/");
	var pos2 = pth.lastIndexOf("\\");
	var pos = Math.max(pos1, pos2);
	querystr.title = title;
	if (querystr.url != null) {
		if (!(querystr.url.indexOf("/") == 0 || querystr.url.indexOf("\\") == 0))
			querystr.url = pth.substring(0, pos) + "/" + querystr.url;
	} else {
		if (!(querystr.indexOf("/") == 0 || querystr.indexOf("\\") == 0))
			querystr = pth.substring(0, pos) + "/" + querystr;
	}
	// alert(querystr);
	return window.showModalDialog(contextPath + '/frame.jsp?title=' + title,
			querystr, 'font-size:9pt;dialogWidth:' + 645 + 'px;dialogHeight:'
					+ 460 + 'px;status:no;scroll=no;');
}

function HTMLEncode(text) {
	var textold;
	do {
		textold = text;
		
		text = text.replace(/&/g, "@amp;") ;
		text = text.replace(/"/g, "@quot;") ;
		text = text.replace(/</g, "@lt;") ;
		text = text.replace(/>/g, "@gt;") ;
		text = text.replace(/'/g, "@#146;") ;
		text = text.replace(/\ /g,"@nbsp;");
		text = text.replace(/\r/g,'&#10;');
		text = text.replace(/\n/g,'&#13;');
	} while (textold != text);

	return text;
}

function HTMLDencode(text) {
	var textold;
	if(text){
		do {
			textold = text;
			
			text = text.replace("@amp;", "&");
			text = text.replace('@quot;', '"');
			text = text.replace("@lt;", "<");
			text = text.replace("@gt;", ">");
			text = text.replace("@#146;", "'");
			text = text.replace("@nbsp;", " ");
			text = text.replace("&nbsp;", " ");
			text = text.replace("&#10;", "\r");
			text = text.replace("&#13;", "\n");
		} while (textold != text);
		return text;
	}else return '';
	
}

// 单击列头排序
function sortTable(nColName) {
	var colEl = document.getElementsByName("_sortCol")[0];
	var oColName = colEl.value;
	changeStatus(oColName, nColName);
	document.forms[0].submit();
}

// 改变排序状态
function changeStatus(oCol, nCol) {
	var statusEl = document.getElementsByName("_sortStatus")[0];
	var colEl = document.getElementsByName("_sortCol")[0];
	if (oCol != nCol && oCol.toUpperCase() != nCol.toUpperCase()) {
		statusEl.value = "ASC";
		colEl.value = nCol;
	} else {
		if (statusEl.value == "ASC") {
			statusEl.value = "DESC";
			colEl.value = nCol;
		} 
		/*
		else if (statusEl.value == "DESC") {
			statusEl.value = "";
			colEl.value = "";
		} 
		*/
		else {
			statusEl.value = "ASC";
			colEl.value = nCol;
		}
	}
}

function showLoadingImageInArea(showArea, imageSrc, text) {
	if (showArea) {
		if (!jQuery("#" + 'imageZone')) {
			var imgZone = document.createElement('<DIV class="commFont">');
			var html = '';
			if (imageSrc) {
				html += '<img src="' + imageSrc + '">';
			}
			if (text) {
				html += text;
			}
			imgZone.id = 'imageZone';
			imgZone.innerHTML = html;
			showArea.appendChild(imgZone);
		} else {
			jQuery("#" + 'imageZone').show();
		}
	}
}

function doAlert(msg) {
	if (msg) {
		alert(msg);
	}
}

function doConfirm(msg, url) {
	if (msg) {
		if (confirm(msg)) {
			makeAllFieldAble();
			document.forms[0].action = url;
			document.forms[0].submit();
		}
	}
}

function makeAllFieldAble(elements) {
	if (!elements) {
		elements = document.forms[0].elements;
	}
	for (var i = 0; i < elements.length; i++) {
		var element = elements[i];
		if (element.disabled == true) {
			// alert("****type->" + element.type);
			element.disabled = false;
		}
	}
}

function toggleButton(btnName) {
	var isBreak = false;
	var button_acts = document.getElementsByName(btnName);
	for (var i = 0; i < button_acts.length; i++) {
		if(button_acts[i].getAttribute("isLoad") == "false"){
			isBreak = true;
		}else{
			button_acts[i].setAttribute("isLoad","false");
			button_acts[i].style.color = "gray";
		}
	}
	return isBreak; 
}

/**
 * 所有校验
 */
var Validations = {
	"great-than" : function(v, els, args) { // 是否大于args.value
		var isPositiveNumber = Validations["is-positive-number"];
		if (isPositiveNumber(v)) {
			return new Number(v) > args.value;
		}
		return false;
	},
	"equal-great-than" : function(v, els, args) { // 是否大于args.value
		var isPositiveNumber = Validations["is-positive-number"];
		if (isPositiveNumber(v)) {
			return new Number(v) >= args.value;
		}
		return false;
	},
	"is-positive-number" : function(v) {// 是否为正数
		return /^\d+\.*\d*$/.test(v);
	},
	"required-one" : function(v, els) { // 是否必须选中一个
		return jQuery.each(els,function(n,value){
			if(!!value){
				return value;
			}
		});
	},
	"required" : function(v) { // 是否必须
		if (v && v != '0') {
			return true;
		}
		return false;
	}
}

/**
 * 通过返回true, 不通过返回false, 依赖Prototype validator = {fieldName: "需校验的字段名称", type:
 * "调用的校验function(如：required)", msg:"错误信息" }; validators = [validator1,
 * validator2];
 */
function doValidate(validators) {
	var msg = "";
	for (var i = 0; i < validators.length; i++) {
		var validator = validators[i];
		var els = document.getElementsByName(validator.fieldName);
		var validation = Validations[validator.type];
		var isPassed = false;
		if (els && els.length > 1) {
			isPassed = validation(jQuery(els[0]).val(), els);
		} else {
			isPassed = validation(jQuery(els[0]).val(), els, validator.args);
		}
		if (!isPassed)
			msg += validator.msg + ", ";
	}

	if (validators && validators.length > 0) {
		msg = msg.substring(0, msg.lastIndexOf(","));
	}

	var errorId = "error";
	if (msg) {
		alert(msg);
		return false;
	}
	return true;
}

// 验证是否安装了flashplayer
function flashChecker() {
	var hasFlash = 0;// 是否安装了flash
	var flashVersion = 0;// flash版本

	if (document.all) {
		var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
		if (swf) {
			hasFlash = 1;
			VSwf = swf.GetVariable("$version");
			flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
		}
	} else {
		if (navigator.plugins && navigator.plugins.length > 0) {
			var swf = navigator.plugins["Shockwave Flash"];
			if (swf) {
				hasFlash = 1;
				var words = swf.description.split(" ");
				for (var i = 0; i < words.length; ++i) {
					if (isNaN(parseInt(words[i])))
						continue;
					flashVersion = parseInt(words[i]);
				}
			}
		}
	}
	return {
		f : hasFlash,
		v : flashVersion
	};
}



/*
 * common js
 * 2010-9-25
 */
function showDialogByDiv(title,url,width,height,isReload) {
	OBPM.dialog.show({
				width : width, // 默认宽度
				height : height, // 默认高度
				url : url,
				args : {},
				title : title,
				close : function(result) {
					var rtn = result;
					//alert("test1");
					if(isReload)
						window.location.reload();
				}
			});
}

/*
 *打开 iscript 编辑器
 *参数说明：
 * fieldName：页面上保存脚本的控件的名称
 * title：弹出层的标题
 * labelTypeName：脚本 label 的类型 如'函数库'、‘校验脚本’ 、‘操作’等
 * labelFieldName:保存脚本所属的对象的名称控件名称  如值脚本所属的字段名称控件的Name
 * feedbackMsg：保存成功的提示内容
 * 2010-12-7
 */
function openIscriptEditor(fieldName,title,labelTypeName,labelFieldName,feedbackMsg){
	//var iscriptContent = document.getElementsByName(fieldName)[0].value;
	var url = contextPath
	+ '/core/macro/editor/iscripteditor/iscripteditor.jsp';
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
	showtitle = "Undefind";
	}
	var label = labelTypeName;
	if(labelFieldName){
		var labelField = "Undefind";
		if(document.getElementsByName(labelFieldName) && document.getElementsByName(labelFieldName)[0].value.length>0){
			labelField = document.getElementsByName(labelFieldName)[0].value;
		}
		label += '-'+labelField;
	}
	var t = window.top;
	OBPM.dialog.show({
	width : t.document.body.clientWidth-200,
	height : t.document.body.clientHeight-100,
	//width : 600,
	//height: 400,
	url : url,
	args : {'fieldName' : fieldName,'label' : label,'feedbackMsg' : feedbackMsg,'parent' : window},
	title : showtitle});
}

/**
 * 刷新后台软件树形菜单,页面需要一个隐藏字段用作判断(<ww:hidden id="refreshid" name="refresh" />)
 * @param {} isRefreshField 是否刷新字段
 */
function refreshApplicationTree(isRefreshField){
	var oRefresh = document.getElementById(isRefreshField);
	if (oRefresh) {
		if (oRefresh.value == 'leftFrame') {
			try{
		   		parent.init_ModuleTree();
		   	} catch(ex) {
		   		//alert(ex.message);
		   		if(parent != null && parent.name == 'applicationframe' && parent.parent.name == 'detail'){
			   		try{
				   		parent.parent.init_ModuleTree();
			   		} catch (e) {
						alert(e.message);
				   	}
		   		}
		   	}
		} else {
			// 第一次加载后刷新
			oRefresh.value = 'leftFrame';
		}
	}
}

/**
 * 获取本地Cookie
 * @param cookie_name cookie名称
 * @return
 */
function getCookie(cookie_name) {
	var allcookies = document.cookie;
	var cookie_pos = allcookies.indexOf(cookie_name);
	// 如果找到了索引，就代表cookie存在，
	// 反之，就说明不存在。
	if (cookie_pos != -1) {
		// 把cookie_pos放在值的开始，只要给值加1即可。
		cookie_pos += cookie_name.length + 1;
		var cookie_end = allcookies.indexOf(";", cookie_pos);
		if (cookie_end == -1) {
			cookie_end = allcookies.length;
		}
		return unescape(allcookies.substring(cookie_pos, cookie_end));
	}
	return null;
}


/**
 * 隐藏的iframe控件，避免遮挡
 * @return
 */
function hiddenDocumentFieldIncludeIframe(){
	jQuery("iframe").each(function(){
		/*
		 * firebug报错:jQuery(this)... is undefined
		 * 
		if(jQuery(this).attr("src").indexOf("newword")>-1 || jQuery(this).attr("src").indexOf("baidumap")>-1){
			jQuery(this).css("visibility","hidden");
		}
		*/
		try{
			if(jQuery(this).attr("src").indexOf("newword")>-1 || jQuery(this).attr("src").indexOf("baidumap")>-1){
				jQuery(this).css("visibility","hidden");
			}
		}
		catch(e){
			return;
		}
	});
}

/*
 * 显示被隐藏的iframe控件
 */
function showDocumentFieldIncludeIframe(){
	jQuery("iframe").each(function(){
		if(jQuery(this).attr("src") != undefined && jQuery(this).attr("src") != "undefined"){
			if(jQuery(this).attr("src").indexOf("newword")>-1 || jQuery(this).attr("src").indexOf("baidumap")>-1){
				jQuery(this).css("visibility","visible");
			}
		}
	});
}

/*
 * URL转码
 */
function URLDecode( text ){
	if ( !text )
		return '' ;

	text = text.replace( /&gt;/g, '>' ) ;
	text = text.replace( /&lt;/g, '<' ) ;
	text = text.replace( /&amp;/g, '&' ) ;

	return text ;
}