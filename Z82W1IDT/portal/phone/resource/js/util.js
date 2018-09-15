var ie = document.all ? 1 : 0;

var screenWidthX = screen.availWidth + 'px';
var screenWidthY = screen.availHeight + 'px';

function doExit() {
	window.close();
}

function doEmpty() {
	window.returnValue = "";
	window.close();
}
// Trim whitespace from left and right sides of s.
function trim(s) {
	return s.replace(/^\s*/, "").replace(/\s*$/, "");
}

function showViewDialog(str, viewid, fieldname, className) {
	screenWidthX = '640px';
	screenWidthY = '480px';

	var url = contextPath
			+ '/portal/share/dynaform/view/dialogFram.jsp?_viewid=' + viewid;
	url += '&className=' + className;

	var rtn = window.showModalDialog(url, str, 'font-size:9pt;dialogWidth:'
					+ screenWidthX + ';dialogHeight:' + screenWidthY + ';status:no;scroll=no;');

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

function showWordDialog(title, str, docid, formName, value, fieldname, versions, opentype, displayType, saveable, isOnlyRead,signature,isSignature) {
	screenWidthX = '900px';
	screenWidthY = '600px';
	var field = document.getElementById(fieldname);
	var _versions = document.getElementById(versions);
	var application = document.getElementById("application").value;
	var url = contextPath + '/portal/dynaform/document/dostart.action?_docid='
		+ docid + "&type=word&_fieldname=" + fieldname + "&_opentype="
		+ opentype+"&_displayType="+displayType
		+ "&saveable=" + saveable
		+ "&isSignature=" + isSignature
		+ "&application=" + application
		+ "&formname=" + encodeURI(formName)
		+"&isOnlyRead="+isOnlyRead
		+"&signature="+signature;
	
	if(_versions)url+= "&versions=" + _versions.value;
	
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
							if(_versions){
								_versions.value = rv[1];
							}
						}
						if (field && fieldVal != '') {
							field.value = fieldVal;
						}
					}
				});
	} else {
		var rtn = window.showModalDialog(url, str, 'font-size:9pt;dialogWidth:'
						+ screenWidthX + ';dialogHeight:' + screenWidthY + ';status:no;scroll=no;');
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

function showWordDialogWithView(title, str, docid, value, fieldname, opentype, displayType, saveable, isOnlyRead, signature, isSignature) {
	screenWidthX = '900px';
	screenWidthY = '600px';
	var field = document.getElementById(fieldname);
	var application = document.getElementById("application").value;
	var url = contextPath + '/portal/dynaform/document/dostart.action?_docid='
		+ docid + "&type=word&_fieldname=" + fieldname + "&_opentype="
		+ opentype+"&_displayType="+displayType
		+ "&saveable=" + saveable
		+ "&application=" + application
		+"&isOnlyRead="+isOnlyRead
		+"&signature="+signature
		+"&isSignature="+isSignature;
	   
	
	if (field == null) {
		url += '&filename=' + value;
	} else {
		url += '&filename=' + field.value;
	}
	// div弹出式
	OBPM.dialog.show({
				width : 900,
				height : 600,
				url : url,
				args : {},
				title : title,
				close : function() {
					
				}
			});

}
/**
 * 获取左右选择框值
 * 
 * @param {}
 *            fieldName
 */

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
	divWidth = divWidth.replace(/(^\s*)|(\s*$)/g, "");
	if(divWidth.length > 0){
		width = divWidth;
	}

	divHeight = divHeight.replace(/(^\s*)|(\s*$)/g, "");
	if(divHeight.length > 0){
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
				selectOne(fields[0], valStr);//选中text为valStr的选项
				DWREngine.setAsync(false);
				jQuery(fields[0]).change();//手动调用onchange方法
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
				var isRefreshOnChanged = jQuery(fields).attr("isRefreshOnChanged");
				isRefreshOnChanged = (isRefreshOnChanged == "true");
				if (fields.length == 0) {
					fields.value = valStr;
				} else {
					fields[0].value = valStr;
				}
				if(isRefreshOnChanged) {DWREngine.setAsync(false);dy_refresh(fldName);}
			}
		}
		return true;
	} else {
		return false;
	}
}

/**
 * 视图选择框单选和多选选择后执行的方法
 * @param mappStr：字段映射关系
 * @param rtn：视图选择框中的返回值
 * @returns {Boolean}
 */
function getDialogValue(mappStr, rtn) {

	if (!mappStr || !rtn) {
		return false;
	}
	
	//选项是否存在
	var isOptionExisted = function(oSel, selectedText) {
		for (var i = 0; i < oSel.options.length; i++) {
			if (oSel.options[i].text == selectedText) {
				return true;
			}
		}
		return false;
	};
	
	//选择选项
	var selectOne = function(oSel, selectedText) {
		for (n = 0; oSel.options.length > n; n++) {
			if (selectedText == oSel.options[n].text) {
				oSel.options[n].selected = true;
				return true;
			}
		}
		return false;
	};
	
	//数据转换
	var conversionVal = function(valStr){
		var reg = /&nbsp;/g;
		var reg1 = /%&0000/g;
		var reg2 = /%&0001/g;
		var reg3 = /%23/g;
		valStr = valStr.replace(reg, "");
		valStr = valStr.replace(reg1, "\r");
		valStr = valStr.replace(reg2, "\n");
		valStr = valStr.replace(reg3, "#");
		
		if(valStr=="&nbsp"){
			valStr = "";
		}
		return valStr;
	};
	
	//转换JSON格式的对象
	var conversionJSONVal = function(valStr) {
		if(valStr != null && valStr != "null" &&  valStr != null && valStr != ""){
			var json = "";
			try{
				json = JSON.parse(valStr);
			}catch(e){
				try{
					var jsonArray = new Array();
				    var strs= new Array();
				    strs = valStr.split(";");
				    for(var index = 0 ;  index < strs.length ; index ++ ){
				    	try{
				    		json = JSON.parse(strs[index]);
					    	for(var arr in json ){
					    		jsonArray.push(json[arr]);
					    	}
				    	}catch(e){
				    		
				    	}
				  }
				  valStr = JSON.stringify(jsonArray);
				}catch(e){
					valStr = ""
				}
			}
		   }
		return valStr ;
	};
	
	//从JSON格式的对象中获取显示值
	var getShowValFromValStr = function(valStr) {
		if(valStr != null && valStr != "null" &&  valStr != null && valStr != ""){
			if(valStr.indexOf("[{") >= 0 ){
                var _valStr = valStr.substring(1,valStr.length-1); 
				var json = "";
				try{
					json = JSON.parse(_valStr);
					valStr = json["key"];
				}catch(e){
					
				}
			}
		 }
		return valStr ;
	};
	
	//设置字段数据
	var setFieldVal = function(fldName, valStr){

		var fields = ajaxPage.getCurPage().find("[name='" + fldName + "']");
		
		if(!fields || fields.length == 0){
			console.error("视图选择框映射字段'" + fldName + "'不存在！");
			return false;
		}
		
		var _tagName = fields[0].tagName.toUpperCase();
		var _type = fields[0].type ? fields[0].type.toUpperCase() : "";
		var _fieldtype = fields[0].getAttribute("fieldtype");

		if (_tagName == 'SELECT' && _fieldtype != "DepartmentField") {	//下拉、左右选择
//			if (!isOptionExisted(fields[0], valStr)) {
//				var oOption = document.createElement("OPTION");
//				oOption.text = "";
//				oOption.value = valStr;
//				fields[0].add(oOption);
//			}
			var isSelect = selectOne(fields[0], valStr);//选中text为valStr的选项
			if(!isSelect){	//text未选中时使用value选中，value为真实值，text为显示值，保证两个有其一就可以选中
				$(fields[0]).val(valStr);
				valStr = $(fields[0]).find("option[value="+valStr+"]").text();
			}
			var fldShow = document.getElementById(fldName + "_show");
			if(fldShow){
				fldShow.innerText = valStr;
			}
			
			DWREngine.setAsync(false);
			jQuery(fields[0]).change();		//手动调用onchange方法
		} else if ((_type == 'RADIO' || _type == 'CHECKBOX')) {	//单（多）选框
			for (n = 0; fields.length > n; n++) {
				var vals = valStr.split(";");
				for(j=0;j<vals.length;j++){
					if(vals[j] == fields[n].value || vals[j] == fields[n].getAttribute("text")){
						fields[n].checked = true;
						break;
					} else {
						fields[n].checked = false;
					}
				}
			}
		}else if(_fieldtype == "AttachmentUploadField"){		//文件上传控件
			var $field ;
			$.each(fields,function (index){
				var uploadlist = $(this).attr("uploadlist");
				if( uploadlist != undefined && uploadlist != null &&  uploadlist != "" ){
					$field = $(this);
					return false;
				}
				});
			valStr = conversionJSONVal(valStr);
			$field.siblings().remove();
			$field.attr("value",valStr).obpmUploadField();  			//文件（图片）上传功能
		}else if(_fieldtype == "ImageUploadField"){		//图片上传控件
			valStr = conversionJSONVal(valStr);
			var $field = jQuery(fields[0]);
			$field.siblings().remove();
			$field.removeData("weixinImageUpload").attr("value",valStr).obpmUploadField();  			//文件（图片）上传功能
		}else if(_fieldtype == "UserField"){      // 用户选择框

			if(valStr != null){
				var userStr = eval("(" + valStr + ")");
				var rtnValue = fields[0].id;
				var rtnText = rtnValue+"_text";
				$("#"+rtnValue).val(userStr[0].value);
				$("#"+rtnText).append(userStr[0].key);
				$("#"+rtnText).attr("value", userStr[0].key);
				var fldShow = document.getElementById(fldName + "_show");
				if(fldShow){
					fldShow.innerText = userStr[0].key;
				}
			}
		}else if(_fieldtype == "DepartmentField"){

			if(valStr != null){
//				fields[0].value = valStr;
//				var textStr = $(fields[0]).find("option[value="+valStr+"]").text();	//显示值
//				var fldShow = document.getElementById(fldName + "_show");
//				if(fldShow){
//					fldShow.innerText = textStr;
//				}
				var userStr = eval("(" + valStr + ")");
				var rtnValue = fields[0].id;
				var rtnText = rtnValue+"_text";
				$("#"+rtnValue).val(userStr[0].value);
				$("#"+rtnText).append(userStr[0].key);
				$("#"+rtnText).attr("value", userStr[0].key);
				var fldShow = document.getElementById(fldName + "_show");
				if(fldShow){
					fldShow.innerText = userStr[0].key;
				}
			}
		}else if(_fieldtype == "DateField"){      //日期选择框
			fields[0].value = valStr;
			var fldShow = document.getElementById(fldName + "_show");
			if(fldShow){
				fldShow.innerText = valStr;
			}
		}else if(_fieldtype == "TreeDepartmentField"){
			
			if(valStr != null){
				var userStr = eval("(" + valStr + ")");
				var rtnValue = fields[0].id;
				var rtnText = rtnValue+"_text";
				$("#"+rtnValue).val(userStr[0].value);
				$("#"+rtnText).val(userStr[0].key);
				var fldShow = document.getElementById(fldName + "_show");
				if(fldShow){
					fldShow.innerText = userStr[0].key;
				}
			}
		}else if(_fieldtype == "SuggestField"){ // 智能搜索框
			
			if(valStr != null){
				var suggestStr = eval("(" + valStr + ")");
				var suggestField = fields[0].id;
				var suggestField_show = suggestField + "_show";
				var value = suggestStr.value? suggestStr.value:'';
				var key = suggestStr.key? suggestStr.key:'';
				$("#"+suggestField).val(value);
				$("#"+suggestField_show).val(key);
				var fldShow = document.getElementById(fldName + "_show1");
				if(fldShow){
					fldShow.innerText = key;
				}
			}
		} else {	//其他控件
			
			valStr = getShowValFromValStr(valStr);
			
			if(_tagName == "TEXTAREA"){
				fields[0].value = HTMLDencode(valStr);
			}else{
				fields[0].value = valStr;
			}
			if(_type.toUpperCase() == 'HIDDEN' || _tagName == "TEXTAREA" || _tagName == "INPUT"){	//hotfix 建议重构（控件只读时只显示值）
				var fldShow = document.getElementById(fldName + "_show");
				if(fldShow){
					if(_tagName == "TEXTAREA"){
						fldShow.innerText = HTMLDencode(valStr);
					}else if(_tagName == "INPUT" && _fieldtype != "SuggestField"){	//单行
						fldShow.innerText = valStr;
					}else{
						fldShow.value = valStr;
					}
				}
			}
			
			var isRefreshOnChanged = jQuery(fields).attr("isRefreshOnChanged");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			if(isRefreshOnChanged) {	//设置了触发刷新的控件，值修改后执行刷新动作
				DWREngine.setAsync(false);
				dy_refresh(fldName);
			}
		}
	};
	
	var mappStr = HTMLDencode(mappStr);
	var mapps = mappStr.split(";");

	rtn = eval("(" + rtn + ")");
//	rtn = JSON.parse(rtn);	//转成json对象
	/**
	 * 数据结构说明
	 * rtn:
	 * 单选：{id:{'字段id1':'val1','字段id2':'val2'}}
	 * 多选：	{"docid1":{
					"字段id1":"val1",
					"id1_doc":"val2"},
				"docid2":{
					"字段id1":"val21",
					"字段id2":"val22"}
				}
		rtnObj:
		单选：{'字段id1':'val1','字段id2':'val2'}
		多选：	{
					"字段id1":"val1;val21",
					"id1_doc":"val2;val22"}
	 */
	var rtnObj = {};
	for(var i in rtn){
		var tem = rtn[i];
		
		for(var o in tem){
			rtnObj[o] = rtnObj[o] ? (rtnObj[o] + ";" + tem[o]) : tem[o];
		}
	}
	
	for (var i = 0; i < mapps.length; i++) {	//循环字段
		var rel = mapps[i].split(":");
		var colName = rel[0];	//字段id
		var fldName = rel[1];	//字段name
		var valStr = '';
		
		valStr = rtnObj[colName];
		valStr = HTMLDencode(valStr);
		valStr = conversionVal(valStr);		//数据转换
		
		setFieldVal(fldName, valStr);			//设置字段值
	}
}

function selectAll(oldValue, multiSelect, selectChild) {
	screenWidthX = '600px';
	screenWidthY = '400px';
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
				contextPath + '/portal/share/frame.jsp?title=' + title, arg,
				'resizable=yes;help=no;status=no;font-size:9pt;dialogWidth:'
						+ screenWidthX + ';dialogHeight:' + screenWidthY + ';status:no;scroll:no;');
	} else {
		showFrameByDiv(arg.url, arg.title);
	}
}


/* 显示鼠标右击菜单 */
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
	var oFld = document.getElementsByName(fldName)[0];
	if (oFld) {
		valuesMap[fldName] = value;
	}
}
// ????????????
function selectOrg(fieldId, fieldName, multiSelect, showLayer, selectLayer,
		DLayer, GLayer, ULayer) {
	screenWidthX = '500px';
	screenWidthY = '500px';
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

function characterDencode(text){
	var textold;
	if(text){
		do {
			textold = text;
			
			text = text.replace("@amp;", "&");
			text = text.replace('@quot;', '"');
			text = text.replace("@lt;", "<");
			text = text.replace("@gt;", ">");
			text = text.replace("@#146;", "&apos;");
			text = text.replace("@nbsp;", " ");
			text = text.replace("&nbsp;", " ");
			text = text.replace("&#10;", "\r");
			text = text.replace("&#13;", "\n");
		} while (textold != text);
		return text;
	}else return '';
};

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

function doAlert(msg) {
	if (msg) {
		alert(msg);
		if(isCloseDialog && isCloseDialog == 'true')
			OBPM.dialog.doExit();
	}
}

function doConfirm(msg, url) {
	if (msg) {
		if (confirm(msg)) {
			if(url){
//				makeAllFieldAble();
				document.forms[0].action = url;
				document.forms[0].submit();
			}
		}
	}
}

//function makeAllFieldAble(elements) {
//	if (!elements) {
//		elements = document.forms[0].elements;
//	}
//	for (var i = 0; i < elements.length; i++) {
//		var element = elements[i];
//		if (element.disabled == true) {
//			// alert("****type->" + element.type);
//			element.disabled = false;
//		}
//	}
//}
var fontColor = "";
//设置按钮为灰色且不能再操作
function toggleButton(btnName) {
	var isBreak = false;
	var button_acts = document.getElementsByName(btnName);
	for (var i = 0,length = button_acts.length; i < length; i++) {
		if(button_acts[i].getAttribute("isLoad") == "false"){
			isBreak = true;
		}else{
			button_acts[i].setAttribute("isLoad","false");
			button_acts[i].style.color = "gray";
		}
	}
	return isBreak;
}

//恢复按钮状态且可操作
function recoveryButSta(btnName) {
	var button_acts = document.getElementsByName(btnName);
	for (var i = 0,length = button_acts.length; i < length; i++) {
			button_acts[i].setAttribute("isLoad","");
			button_acts[i].style.color = "";
	}
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

/*
 * common js for front
 * 2010-9-25
 */
function showDialogByDiv(title,url,width,height,isReload) {
	if(!width || width == "") width = "800";
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
//						window.location.reload();
						document.forms[0].submit();
				}
			});
}

/**
 * 刷新后台软件树形菜单,页面需要一个隐藏字段用作判断(<ww:hidden id="refreshid" name="refresh" />)
 * @param {} isRefreshField 是否刷新字段
 */
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

/**
 * 浏览器判断
 * return brow:ie6/ie7/ie8/ie9/firefox/chrome/safari
 */
function getBrowser(){
	var brow = "";
	if(navigator.userAgent.indexOf("MSIE")>0) { 
	   	var browser = navigator.appName 
		var version = navigator.appVersion.split(";"); 
		var trim_Version = version[1].replace(/[ ]/g,"");
		
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
		{ 
			brow = "ie6";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
		{ 
			brow = "ie7";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
		{ 
			brow = "ie8";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
		{ 
			brow = "ie9";
		}
	}  
	if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
		brow = "firefox";
	}  
	if(isChrome=navigator.userAgent.indexOf("Chrome")>0) {  
		brow = "chrome";
	}
	if(isSafari=navigator.userAgent.indexOf("Safari")>0) {  
		brow = "safari";
	}
	return brow;
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
