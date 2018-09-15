/**
 * 按钮操作URL
 */
var activityAction = contextPath + "/portal/dynaform/activity/action.action";
var docviewAction = contextPath + '/portal/dynaform/document/view.action';

/**
 * 文件下载按钮对应的Function
 */
function doFileDonwload(actid) {
	if (actid) {
		var url = activityAction;
		var newUrl = url + '?_activityid=' + actid;
		
		if(ev_runbeforeScriptforview(actid)){
			document.forms[0].action = newUrl;
			document.forms[0].target = "_blank";
			document.forms[0].submit();
			document.forms[0].target = "";
		}
	}
}

/**
 * Excel导入按钮事件
 * 
 * @param {}
 *            actid 按钮ID
 * @param {}
 *            impcfgid 导入配置ID
 */
function ev_excelImport(actid, impcfgid) {
	var parentid = "";
	if (document.getElementsByName("parentid")) {
		parentid = document.getElementsByName("parentid")[0].value;
	}
	
	var application = "";
	if (document.getElementsByName("application")) {
		application = document.getElementsByName("application")[0].value;
	}

	var isRelate = "";
	if(document.getElementsByName("isRelate")){
		var relateObj = document.getElementsByName("isRelate");
		if(relateObj.length != 0)
			isRelate = relateObj[0].value;
	}
	var _viewid = document.getElementsByName("_viewid")[0].value;
	if (impcfgid) {
		var url = importURL; // importURL在各页面中定义
		url += "?parentid=" + parentid;
		url += "&id=" + impcfgid;
		url += "&application=" + application;
		url += "&isRelate=" + isRelate;
		url += "&_activityid=" + actid;
		url += "&_viewid=" + _viewid;
		url += "&actionType = excelImport";
		OBPM.dialog.show({
			width : 530,
			height : 420,
			url : url,
			args : {},
			title : 'Excel导入',
			close : function(result) {
				document.forms[0].submit();
			}
		});
	}
}

/**
 * 打开下载窗口
 * 
 * @param {}
 *            fileName 文件名称
 */
function openDownloadWindow(fileName) {
	if (fileName) {
		var url = downloadURL + '?filename=' + encodeURI(fileName);
		top.window.open(url);
	}
}

/**
 * 页面重载
 */
function ev_reload() {
	// window.location.href = window.location.href+'&';
	document.forms[0].submit();
}

function ev_search() {
	$(document).find("form:eq(0)").find("[name='_currpage']").val("1");
	document.forms[0].submit();
}

/**
 * 清空字段内容
 */
function ev_resetAll() {
	var elements = document.forms[0].elements;
	for (var i = 0; i < elements.length; i++) {
		
		if(jQuery(elements[i]).attr('fieldType')=='TextAreaField'){
			elements[i].value = "";
		}
		if(jQuery(elements[i]).attr('fieldType')=='UserField'){
			elements[i].value = "";
			
			if(jQuery(elements[i]).attr('readonlyshowvalonly') == "true"){
				jQuery(elements[i]).text("");
			}
			
		}
		if(jQuery(elements[i]).attr('fieldType')=='SelectAboutField'){
			var	originalName = elements[i].name;
			var	idDx = originalName + "ms2side__dx";
			var	idSx = originalName + "ms2side__sx";
			jQuery("#" + idDx).children().appendTo(jQuery("#" + idSx));
			jQuery("#" + idDx).children().remove();
			jQuery(elements[i]).find('option').attr("selected", false);
			jQuery(elements[i]).find("[text='']").attr("selected", true);
		}
		if(elements[i].type == 'checkbox'){
			elements[i].checked = false;
		}
		if(elements[i].type == 'radio'){
			elements[i].checked = false;
		}
		if(jQuery(elements[i]).attr('fieldType')=='TreeDepartmentField'){
			elements[i].value = "";
			elements[i+1].value = "";
		}
		// alert(elements[i].id + ": "+elements[i].type + " resetable-->" +
		// elements[i].resetable);
		if (elements[i].type == 'text'|| elements[i].resetable) {
			elements[i].value = "";
			
		} else if (elements[i].type == 'select-one') {
			// 还原至第一个选项
			if (elements[i].options.length >= 1) {
				elements[i].options[0].selected = true;
			}
		}
		
		//清空只读值
		var readOnlySpanId = "#"+jQuery(elements[i]).attr('name')+"_show";
		if(jQuery(readOnlySpanId)){
			jQuery(readOnlySpanId).text("");
		}
	}
	
	
	jQuery("#searchFormTable").find("input[type='hidden'][id!='dy_refreshObj']").val("");//清除隐藏文本框控件的值
	/*
	for (var i = 0; i < arrObject.length; i++) {
		arrObject[i].save("");
	}
	*/
}

/**
 * 表单提交(由按钮触发的事件)
 * 
 * @param {}
 *            activityId 操作ID
 * @param {}
 *            isCheckSelect 是否检查有选择项
 */
function ev_submit(activityId, isCheckSelect, operation,isConfirm,confirmMsg) {
	var flag = true;
	if (isCheckSelect) {
		flag = isSelectedOne("_selects");
	}
	if (flag) {
		if(ev_runbeforeScriptforview(activityId)){
			var formAction = contextPath + '/portal/dynaform/activity/handle.action' + '?_activityid=' + activityId;
			if (operation) {
				formAction += "&operation=" + operation;
			}
			if(isConfirm){
				var rtn = window.confirm(confirmMsg);
				if (!rtn){
					if(toggleButton("button_act")) return false;
					return;
				}
			}
			if(toggleButton("button_act")) return false;
			document.forms[0].action = formAction;
			document.forms[0].submit();
		}
	} else {
		if(toggleButton("button_act")) return false;
	}
	//hidden();
}

var ifExpToExl = true;
function ev_expToExl(activityId, filename, expSub){
	var oldActionUrl = document.forms[0].action;
	if(!ifExpToExl){
		alert("已导出，需要再次导出请刷新页面！");
		return;
	}

	if(ev_runbeforeScriptforview(activityId)){
		var url = contextPath + '/portal/dynaform/activity/handle.action' + '?_activityid=' + activityId + "&filename=" + filename + "&isExpSub=" + expSub;
		document.forms[0].action = url;
		document.forms[0].submit();
		ifExpToExl = false;
	}
	
	document.forms[0].action = oldActionUrl;
	
}

//批量提交
function doBatchApprove(activityId,isCheckSelect){
	if(!isSelectedOne("_selects","至少选择一条记录！")){
		return;
	}
	if(jQuery("#inputAuditRemarkDiv" + activityId).attr("id")){
		artDialog.prompt('请输入审批意见：',function(val,win){
			jQuery('#_attitude' + activityId).val(val);
			ev_submit(activityId,true);
		},true);
	}
}

// 键盘事件
function setEnter(event) {
	if (event.keyCode == 13) {
		event.keyCode = 9;
	}
}

function enterKeyDown(e) {
	if (e.keyCode == 13 || e.which == 13) { // 13 代表Enter
		document.getElementsByName('_currpage')[0].value = 1;
		document.forms[0].submit();
	}
}

function ev_exportToExcel(activityId, isConfirm, content){
	if(isConfirm){
		var rtn = window.confirm(content);
		if(!rtn){
			return;
		}
	}
	ev_submit(activityId);
}

/** 调整包含元素iframe高度--所有皮肤视图
 * iframeid: iframeid
 * viewType：1:列表视图(LISTVIEW),
 * 			 2:日历视图(CALENDARVIEW), 
 * 			 3:树形视图(TREEVIEW),
 * 			 4:地图视图(MAPVIEW),
 * 			 5:网格视图(GRIDVIEW),
 * 			 6:甘特视图(GANTTVIEW).
 */
function ev_resize4IncludeView(divid,iframeid,type){
	if(divid != "" && type != ""){
		var spanObj = parent.document.getElementById(divid);
		if(spanObj){
			var iframeObj = spanObj.getElementsByTagName("iframe");
			//jQuery("#" + divid + " iframe[id=" + iframeid + "]",parent.document)
			jQuery(iframeObj).each(function(){
				switch(type){
					case "MAPVIEW"://地图视图
						try{
							var activityH = jQuery("#activityTable").height();
							var searchH = 0;
							if(jQuery("#searchFormTable").size() != 0)
								searchH = jQuery("#searchFormTable").height();
							jQuery(this).css("height",(searchH + 670));
						}catch(ex){
							setTimeout(function(){
								jQuery(this).css("height",(searchH + 670));
							},300);
						}
						break;
						
					case "DISPLAYVIEW"://嵌入视图
						var formListH= document.getElementById('formList').offsetHeight;
						if(formListH > 410){
							formListH = 450;
						}else if(formListH < 100){
							formListH = 150;
						}else{
							formListH = formListH + 40;
						}
						//包含元素固定高度时不重新布局
						var fixation = jQuery(this).attr("fixation");
						if(fixation=="true"){
							jQuery(this).css("height",jQuery(this).attr("fixationHeight"));
						}else {
							jQuery(this).css("height",formListH);
						}
						break;
					case "CALENDARVIEW"://日历视图
						var actH = jQuery("#activityTable").height();
						var dataH= jQuery('#cal_viewcontent').height();
						var bodyH = actH + dataH;
						if(bodyH > 100){
							jQuery(this).css("height",(bodyH + 20));
						}
						break;
					case "TREEVIEW"://树形视图
						var bodyW = jQuery("body").width();
						jQuery(this).css("height",700);
						if(ie) jQuery(this).css("width",bodyW-4);
						break;
					case "GANTTVIEW"://甘特视图
						var iframeH = jQuery("#container").height();
						if(iframeH > 100)
							jQuery(this).css("height",(iframeH + 20));
						break;
					case "GRIDVIEW"://网格视图
						var fixation = jQuery(this).attr("fixation");
						if(fixation && fixation != "true"){		//固定高度时不自适应
							var actH = $("#gridview-container").find(".activity__bd").outerHeight();	//网格视图的操作按钮高度
							var gridTableHd = $("#gridview-container").find(".obpm-view__table-hd_scroll").outerHeight();	//网格视图的table的列头高度
							var gridViewH = 0;	//网格视图的table的body的高度
							var $tr = $("#gridview-container").find("#obpm-view__table").find(">tr");
							var gridViewH = 0;
							if($tr.size()>0){
								gridViewH = ($tr.eq(0).outerHeight()) * $tr.size();
							}
							var pageH = $("#isPagination").height();	//网格视图的table的分页高度
							var iframeH = actH + gridTableHd + gridViewH + pageH +20;
							
							if(editingRows && editingRows.length > 0){
								jQuery(this).css("height",iframeH + 300);
							}else{
								jQuery(this).css("height",iframeH);
							}
						}
						
						break;
					case "LISTVIEW"://列表视图
						break;
				}
			});
		}
	}
}

function ev_runbeforeScriptforview(actid){
	var flag = false;
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

/** 当菜单视图显示记录数时，视图数据增删会刷新菜单记录数
 * for: default/dwz/fresh/gentle
 * viewType：1:列表视图(LISTVIEW),
 * 			 2:网格视图(GRIDVIEW).
 */
function refreshMenuTotalRows(){
	var menuId = "menu_" + jQuery("#resourceid").val();
	jQuery("body",parent.document).find("#" + menuId).html("(" + totalRows + ")");
}

//点击把隐藏的查询表格显示出来
function isSearch(){
	$("#searchFormTable").slideToggle("fast",function(){
		if($("[isCommonFilter='true']").size() > 0){
			var $searchActivePanel = $(".search-active-panel");
			var $searchFormTable = $("#searchFormTable");
			if($searchFormTable.is(":visible")){
				$searchActivePanel.find("[isCommonFilter='true']").each(function(){
					var $this = $(this);
					var $span = $this.parents("span[id$='_divid']");
					var id = $this.attr("id");
					$span.find("[isCommonFilter='true']").removeAttr("placeholder");
					var $placeholder = $searchFormTable.find("span[_isCommonFilterID='"+id+"']");
					if($searchActivePanel.find("span[_isCommonFilterID='"+id+"']").size() <= 0){
						$span.before("<span _isCommonFilterID='"+id+"' style='display:none'></span>");
					}
					$span.removeClass("form-group");
					$span.find('span[data-title]').remove();
					$placeholder.before($span);
				}); 
				$searchActivePanel.find(".search-senior").text("收起");
				$(".search-btns>[onclick='modifyActionBack();']").hide();
			}else{
				$searchFormTable.find("[isCommonFilter='true']").each(function(){
					var $this = $(this);
					var $span = $this.parents("span[id$='_divid']");
					var id = $this.attr("id");
					var name = $this.attr("name");
					var discript = $this.attr("discript");
					discript = discript ? discript : name;
					var fieldType = $this.attr("fieldType");
					
					if(fieldType == "RadioField" || fieldType == "CheckboxField"){
						name = $this.data("label");
					}
					
					if($this.attr("type") == "text"){
						$span.find("[isCommonFilter='true']").attr("placeholder",discript);
					}
					var $placeholder = $("#activityTable").find("span[_isCommonFilterID='"+id+"']");
					if($searchFormTable.find("span[_isCommonFilterID='"+id+"']").size() <= 0){
						$span.before("<span _isCommonFilterID='"+id+"' style='display:none'></span>");
					}
					$span.addClass("form-group");
					$span.prepend('<span data-title style="vertical-align: middle;">'+ discript +': </span>')
					$placeholder.before($span);

				}); 
				$searchActivePanel.find(".search-senior").text("高级");
				$(".search-btns>[onclick='modifyActionBack();']").show();
			}
		}
	});
}