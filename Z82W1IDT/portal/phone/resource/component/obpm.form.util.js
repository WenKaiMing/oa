/**
添加$.version以解决jQuery1.9后不支持version问题
*/
(function(jQuery) {
	if (jQuery.browser)
		return;
	jQuery.browser = {};
	jQuery.browser.mozilla = false;
	jQuery.browser.webkit = false;
	jQuery.browser.opera = false;
	jQuery.browser.msie = false;
	var nAgt = navigator.userAgent;
	jQuery.browser.name = navigator.appName;
	jQuery.browser.fullVersion = '' + parseFloat(navigator.appVersion);
	jQuery.browser.majorVersion = parseInt(navigator.appVersion, 10);
	var nameOffset, verOffset, ix;
	// In Opera, the true version is after "Opera" or after "Version"
	if ((verOffset = nAgt.indexOf("Opera")) != -1) {
		jQuery.browser.opera = true;
		jQuery.browser.name = "Opera";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 6);
		if ((verOffset = nAgt.indexOf("Version")) != -1)
			jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In MSIE, the true version is after "MSIE" in userAgent
	else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
		jQuery.browser.msie = true;
		jQuery.browser.name = "Microsoft Internet Explorer";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 5);
	}
	// In Chrome, the true version is after "Chrome"
	else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
		jQuery.browser.webkit = true;
		jQuery.browser.name = "Chrome";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 7);
	}
	// In Safari, the true version is after "Safari" or after "Version"
	else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
		jQuery.browser.webkit = true;
		jQuery.browser.name = "Safari";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 7);
		if ((verOffset = nAgt.indexOf("Version")) != -1)
			jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In Firefox, the true version is after "Firefox"
	else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
		jQuery.browser.mozilla = true;
		jQuery.browser.name = "Firefox";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In most other browsers, "name/version" is at the end of userAgent
	else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt
			.lastIndexOf('/'))) {
		jQuery.browser.name = nAgt.substring(nameOffset, verOffset);
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 1);
		if (jQuery.browser.name.toLowerCase() == jQuery.browser.name
				.toUpperCase()) {
			jQuery.browser.name = navigator.appName;
		}
	}
	// trim the fullVersion string at semicolon/space if present
	if ((ix = jQuery.browser.fullVersion.indexOf(";")) != -1)
		jQuery.browser.fullVersion = jQuery.browser.fullVersion
				.substring(0, ix);
	if ((ix = jQuery.browser.fullVersion.indexOf(" ")) != -1)
		jQuery.browser.fullVersion = jQuery.browser.fullVersion
				.substring(0, ix);
	jQuery.browser.majorVersion = parseInt('' + jQuery.browser.fullVersion, 10);
	if (isNaN(jQuery.browser.majorVersion)) {
		jQuery.browser.fullVersion = '' + parseFloat(navigator.appVersion);
		jQuery.browser.majorVersion = parseInt(navigator.appVersion, 10);
	}
	jQuery.browser.version = jQuery.browser.majorVersion;
})(jQuery);  


var PermissionType_READONLY = 1;
var PermissionType_MODIFY = 2;
var PermissionType_HIDDEN = 3;
var PermissionType_DISABLED = 4;
var PermissionType_PRINT = 5;

var LayoutType_Vertical = "vertical";	//lable与输入框上下结构
var LayoutType_Horizontal = "horizontal";	//lable与输入框左右结构

var refreshTickets = [];

/**
 * 表单控件重构时调用
 * 通过id获取非后台显式添加（后台开发时在表单源码添加）的其他属性
 * objId:moduleOtherAttrs属性值
 * return:所有元素属性组成的html
 **/
function getOtherProps(objId) {
	var el = jQuery("[moduleOtherAttrs='"+objId+"']")[0], atts = el.attributes, att, html="";
	for (var i=0; i < atts.length; i++) {
		att = atts[i];
		if (att.specified 
				&& att.name.toLowerCase() != "moduleotherattrs" 
				&& att.name != "type" && att.value != "" 
				&& att.name.toLowerCase().indexOf("jquery") == -1) {
			html += " " +att.name+ "='" +att.value+ "'";
		}
	}
	jQuery(el).remove("input");
	return html;
}

/**
 * 表单控件重构时调用
 * 通过对象获取非后台显式添加（后台开发时在表单源码添加）的其他属性
 * obj:获取属性的对象
 * @return:所有元素属性组成的html
 */
function getOtherAttrs(obj) {
	var atts = obj.attributes, att, html="";
	for (var i=0; i < atts.length; i++) {
		att = atts[i];
		if (att.specified 
				&& att.name.toLowerCase() != "moduletype" 
				&& att.name.toLowerCase() != "classname" 
				&& att.name.toLowerCase() != "discript" 
				&& att.name.toLowerCase() != "style" 
				&& att.name.toLowerCase() != "class" 
				&& att.name.toLowerCase() != "value"
				&& att.name != "type" && att.value != "" 
				&& att.name.substr(0,1) != "_"
				&& att.name.toLowerCase().indexOf("jquery") == -1) {
			html += " " +att.name+ "='" +att.value+ "'";
		}
	}
	return html;
}

//当表单配置有待办控件时，把待办load进页面
function loadPedding(){
	jQuery(".ElementDiv").each(
			function(index){
				jQuery(this).load(jQuery(this).attr("src"),{'index':index},function(){
					jQuery("[moduleType='pending']").obpmPending();  //待办元素
				});
			}
		);
}

//--表单控件jquery重构--start--//
/**
 * jquery重构按钮和控件
 * for:表单
 */
function jqRefactor($page){
//	try{
		//$page为子表刷新未激活的父表时需传的父表对象
		var $curPage;
		if($page){
			$curPage = $page;
		}else{			
			$curPage = ajaxPage.getCurPage();
			if($curPage.length <= 0){
				$curPage = $("body form")
			}
			//$($curPage.context).find('form')
		}
		
		var $actButtion = $curPage.find("input[moduleType='activityButton']");
		if($actButtion.size() != 0)
			$actButtion.obpmButton(); //操作按钮

		$curPage.find("input[moduleType='IncludedView']").filter(function(){	//不重构选项卡内的包含元素
			return (jQuery(this).parents("div[moduleType='TabNormal'], ul[moduleType='TabCollapse']").size() == 0);
		}).obpmIncludedView();  		//包含元素
		
		//必须放在选项卡重构前
		// jQuery("div[moduleType='TabNormal']").filter(function(){
		// 	return (jQuery(this).parents("div[moduleType='TabNormal']").size() == 0);
		// }).obpmTabNormalField();  		//页签选项卡

		//必须放在选项卡重构前
		$curPage.find("div[moduleType='TabNormal']").filter(function(){
			return (jQuery(this).parents("div[moduleType='TabNormal']").size() == 0);
		}).obpmTabNormalField();  
		
		$curPage.find("ul[moduleType='TabCollapse']").filter(function(){
			return (jQuery(this).parents("ul[moduleType='TabCollapse']").size() == 0);
		}).obpmTabCollapseField();  		//页签选项卡
		/****/
		//以下控件必须在选项卡后重构
		$curPage.find("input[moduleType='formActivityButton']").obpmButtonField();		//下拉选择框
		$curPage.find("span[moduleType='select']").obpmSelectField();		//下拉选择框
		$curPage.find("input[moduleType='input']").obpmInputField();		//单行文本框
		$curPage.find("textarea[moduleType='textarea']").obpmTextareaField();	//多行文本框
		$curPage.find("span[moduleType='radio']").obpmRadioField();		//单选框
		$curPage.find("span[moduleType='checkbox']").obpmCheckbox();		//复选框
		$curPage.find("select[moduleType='department']").obpmDepartmentField();			//部门选择框
		$curPage.find("input[moduleType='viewDialog']").obpmViewDialog();				//视图选择框
		$curPage.find("input[moduleType='treeDepartment']").obpmTreeDepartmentField();	//树形部门选择框
		$curPage.find("input[moduleType='takePhoto']").obpmTakePhoto();					//在线拍照
		$curPage.find("select[moduleType='selectAbout']").obpmSelectAboutField();  		//左右选择框
		//setTimeout(function(){
		$curPage.find("input[moduleType='dateinput']").obpmDateField();		//日期控件
		$curPage.find("input[moduleType='userfield']").obpmUserfield();  				//用户选择框
		$curPage.find("input[moduleType='suggest']").obpmSuggestField();  				//下拉提示框
		$curPage.find("span[moduleType='uploadFile']").obpmUploadField();  			//文件（图片）上传功能
//			$curPage.find("input[moduleType='uploadToDatabase']").obpmAttachmentUploadToDataBase();  //文件上传到数据库
//			$curPage.find("input[moduleType='ImageUploadToDatabase']").obpmImageUploadToDataBase();  //图片上传到数据库
		$curPage.find("textarea[moduleType='htmlEditor']").obpmHtmlEditorField();  	//HTML编辑器
//			$curPage.find("input[moduleType='fileManager']").obpmFileManager();  		//文件管理功能
//			$curPage.find("input[moduleType='mapField']").obpmMapField();  				//地图功能
//			$curPage.find("input[moduleType='wordField']").obpmWordField();  			//Word编辑器
		$curPage.find("div[moduleType='flowHistoryField']").obpmFlowHistoryField();  			//流程历史控件
		$curPage.find("div[moduleType='flowReminderHistoryField']").obpmFlowReminderHistoryField();	//流程催办历史控件
		$curPage.find("input[moduleType='weixingpsfield']").obpmWeixinGpsField();  			//微信gps控件
		$curPage.find("input[moduleType='surveyField']").obpmSurveyField();//问卷调查控件
		$curPage.find("input[moduleType='weixinrecordfield']").obpmWeixinRecord();
		$curPage.find("input[moduleType='qrcodefield']").obpmQRCodeField();//二维码控件
//			loadPedding();	//待办			
			//formOneRow();//表单显示为一行
		//},1);
//	}catch(ex){
//		alert(ex);
//		alert("表单构建失败，请重试或联系管理员");
//	}
}
//--表单控件jquery重构--end--//



//--表单刷新重计算--start--//
var isRefreshLoading = false;	//是否正在执行刷新重计算，表单保存时使用
var dy_token = true;

function dy_getFormid() {
	return formid;
}

/**
 * 刷新重计算
 * 
 **/
var fieldsTemp = {};
var divsTemp = {};

/**
 * 添加字段值到缓存变量中
 * @param fieldName
 * @returns
 */
function addField2Temp(fieldName) {
	var $curPage = hasParentForm(ajaxPage.getCurPage())
	var oFld = $curPage.find("[name=" + fieldName + "]");
	if (oFld) {
		// alert(fieldName +" | "+oFld.length +" | "+ oFld.tagName);
		fieldsTemp[fieldName] = oFld[0];
	}

	return fieldsTemp[fieldName];
}

/**
 * 替换表单控件dom
 * 刷新请求后台返回后执行
 * @param divid : 字段id
 * @param fieldName ：字段名
 * @param fieldHTML ：后台输出的字段html
 * @param isDecode ：是否需要解码处理
 */
function refreshField(divid, fieldName, fieldHTML, isDecode) {
	try {
		//添加刷新ticket
		refreshTickets.push(divid);
		console.log(refreshTickets)
		
		var $curPage = hasParentForm(ajaxPage.getCurPage());
		var d = $curPage.find("#" + divid)[0];
		if($("#"+divid).is(":visible")){
			var $divid = $curPage.find("#"+divid).addClass("refreshItem");
			var spanHeight = $curPage.find("#"+divid).css("display","block").height();
			$divid.height(spanHeight);
		}
		if (d) {
			var regExp = /<script.*>(.*)<\/script>/gi;
			
			if (isDecode == true) {
				fieldHTML = HTMLDencode(fieldHTML);
			}
			//	alert(fieldName + ": " + fieldHTML);
			d.innerHTML = fieldHTML; // 1.插入HTML

			if (regExp.test(fieldHTML)) { // 2.执行脚本
				eval(RegExp.$1);
			}
			// alert(fieldHTML);
			addField2Temp(fieldName);
		}
		
		//移除刷新ticket
		refreshTickets.splice($.inArray(divid,refreshTickets),1);
		console.log(refreshTickets)
	} catch (ex) {

	}
}

/**
 * 获取单（复）选框的值
 * @param fldName
 * @returns {String}
 */
function getCheckedListStr(fldName) {
	var rtn = null; // 不更改原有值
	var flds = ajaxPage.getCurPage().find("[name=" + fldName + "]");
	if (flds && flds.size() > 0) {
		if (flds[0].type == 'checkbox' || flds[0].type == 'radio') {
			rtn = '';
			for (i = 0; i < flds.length; i++) {
				if (flds[i].checked && flds[i].value) {
					rtn += flds[i].value + ";";
				}
			}

			rtn = rtn.substring(0, rtn.lastIndexOf(';'));
		} else {
			rtn = flds[0].value;
		}
	}
	return rtn;
}

/**
 * 获取字段值--刷新表单时调用
 * @param fieldName
 * @returns
 */
function ev_getValue(fieldName) {
	var rtn = null;
	try {
		var tempFld = fieldsTemp[fieldName];

		tempFld = addField2Temp(fieldName);

		if (tempFld) {
			// alert(fieldName + " tempFld: " + tempFld.type);
			if (tempFld.type == 'radio' || tempFld.type == 'checkbox') {
				rtn = getCheckedListStr(fieldName);
			}
			else if (tempFld.type == "select-multiple"){
				var v = '';
				for(var i = 0; i < tempFld.length; i++){
					if(tempFld[i].selected)
						v += tempFld[i].value + ";";
				}
				rtn = v.substring(0, v.lastIndexOf(';'));
			}
			else {
				rtn = tempFld.value;
			}
		}
	} catch (ex) {
		alert("util.js(ev_getValue)." + fieldName + ": " + ex.message);
	}

	return rtn;
}

/**
 * 判断是否有父表单并返回jq对象
 */
function hasParentForm($curPage){
	var hash = location.hash;
	var parentFormIndex = hash.indexOf("parentForm");
	if(parentFormIndex >= 0){
		var parentFormParam = hash.substr(parentFormIndex);
		var parentFormId = parentFormParam.substr(parentFormParam.indexOf("=")+1);
		$curPage = $("body > form#"+parentFormId);
	}
	return $curPage;
}

/**
 * 刷新重计算时获取所有字段值提交到后台
 * @param withParentid
 * @returns {___anonymous11161_11162}
 */
function dy_getValuesMap(withParentid) {
	var $curPage = hasParentForm(ajaxPage.getCurPage());
	var hash = location.hash;
	var parentFormIndex = hash.indexOf("parentForm");
	//判断是否有父表单参数
	if(parentFormIndex >= 0){
		var parentFormParam = hash.substr(parentFormIndex);
		var parentFormId = parentFormParam.substr(parentFormParam.indexOf("=")+1);
		$curPage = $("body > form#"+parentFormId);
	}
	$curPage.find("input[moduleType='surveyField']").obpmSurveyField("getValue");
	var valuesMap = {};
	var mapVal = "";
	var mapVals = new Array();
	if($curPage.find("#dy_refreshObj").size() > 0){
		mapVal = $curPage.find("#dy_refreshObj").attr("mapVal");
	}
	if(mapVal)
		mapVals = mapVal.split(";");
	if (document.getElementsByName('_selects')) {
		var selects = getCheckedListStr('_selects');
		valuesMap['_selectsText'] = (selects && selects != null) ? selects : '';
	}
	for(var i=0; i<mapVals.length; i++){
		valuesMap[mapVals[i]] = ev_getValue(mapVals[i]);
	}
	
	if ($("input[name='parentid']").length > 0
			&& withParentid) {
		valuesMap['parentid'] = $("input[name='parentid']").val();
	}
	if ($("input[name='application']").length > 0) {
		valuesMap['application'] = $("input[name='application']").val();
	}
	return valuesMap;
}

//文字和表单控件同一行显示
function formOneRow(){
	$("body").append("<div id='text-width' style='display:none'>"+$(this).text()+"</div>")
	var $title = $("#_formHtml label.field-title"); 
	$title.each(function(){
		if($(this).parent(".formfield-wrap[id^='weixinImageUpload']").size()==0){
			var $title_width = $("#text-width").width(); 
			if($title_width < $(window).width()/2){
				//alert($title_width+" "+$(window).width()/2);
				$(this).addClass("field-title-left");
				$(this).next().addClass("contactField-right");
				$(this).parent(".formfield-wrap").addClass("formfield-wrap-box");
		    }
		}
		$("#text-width").html("");
	})
}


var FormDoc = FormDoc || {};
/**
 * 刷新重计算前获取焦点对象的标签名和名称
 */
FormDoc.getFocusObj = function(){
	var obj = {
			tagName : "",
			name : ""
	};
	var activeEle = document.activeElement;
	obj.tagName = activeEle.tagName;
	obj.name = activeEle.name;
	return obj;
};

/**
 * 刷新重计算后根据对象的标签名和名称设置焦点
 */
FormDoc.setFocusObj = function(obj){
	if(obj && obj.tagName && obj.name){
		$(obj.tagName + "[name='" + obj.name + "']").focus();
	}
};

/**
 * 刷新重计算触发时调用的方法
 * @param actfield:触发刷新的字段
 */
function dy_refresh(actfield) {
	var $curPage = hasParentForm(ajaxPage.getCurPage());	
	var $dy_refreshObj = $curPage.find("#dy_refreshObj");
	var formid = $dy_refreshObj.attr("formid");
	var docid = $dy_refreshObj.attr("docid");
	var userid = $dy_refreshObj.attr("userid");
	var flowid = $dy_refreshObj.attr("flowid");
	
	try {
		if (dy_token) {
			if(typeof FormHelper !="undefined"){
				dy_token = false;
				showLoadingToast();
				isRefreshLoading = true;
				if (document.getElementById('tabid')) {
					var _tabid = document.getElementById('tabid').value;
				}
				FormHelper.refresh(_tabid,
						formid, actfield,
						docid,
						userid,
						dy_getValuesMap(true), flowid, function(str) {
							try {
								var focusObj = FormDoc.getFocusObj();
								eval(str);
								$curPage.find("#flowprocessDiv").hide();//隐藏流程面板，使得下次点击展开时能够进行重新加载。
								jqRefactor();
								if(hasParentForm()){
									jqRefactor(hasParentForm(ajaxPage.getCurPage()));
								}
								if($curPage.find(".refreshItem").find("iframe").size()>0){
									$curPage.find(".refreshItem").find("iframe").each(function(){
										$(this).height($(this).parent("span").height());
									})
								}
								$curPage.find(".refreshItem").css("height","auto").removeClass("refreshItem");
								FormDoc.setFocusObj(focusObj);
							} catch (ex) {
								alert('form: ' + ex.message);
							};
							hideLoadingToast();
							isRefreshLoading = false;
							dy_token = true;
						});
			}
		}
	} catch (ex) {
		hideLoadingToast();
		isRefreshLoading = false;
		alert('form: ' + ex.message);
	}
}
//--表单刷新重计算--end--//