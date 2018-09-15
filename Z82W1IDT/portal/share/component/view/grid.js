var activityAction = contextPath + '/portal/dynaform/activity/action.action';

// 正在编辑的字段
var editingElements = [];

// 已发生改变的数据
var modifiedRecords = {};

// 编辑前的数据
var origRecords = {};

// 编辑前的表格行模型
var origTRs = {};

// 正在编辑的表格行
var editingRows = [];

// 新建但尚未保存的表格行
var newRows = [];

// obpm.subGridView.js中赋值
var oTable = null;

var selectionName = "_selects";

/**
 * 离开表单页面是否检验
 */
var fieldValChanged = false;


//返回表单是否修改的变量
function getFieldValChanged() {
	return fieldValChanged;
}

//设置表单是否修改的变量
function setFieldValChanged(val) {
	return fieldValChanged = val;
}
/**
* 当前表格是否要显示操作列
* 编辑状态显示，非编辑状态隐藏
* @param {}
*            rowId 表格行ID
* @return {}
*/
function showOrHideActionTd(){
	var hasEditTr = false;	//不存在正在编辑的行
	var $gridTableTr = $("#gridTable #dataBody >tr");
	$gridTableTr.each(function(){
		if($(this).hasClass("grid-rowselected")){
			hasEditTr = true;
			return false;
		}
	});
	var i = $gridTableTr.eq(0).find(">td").size()-1;
	if($gridTableTr.size() > 0 && !hasEditTr){
		$("#gridTable #dataBody >tr").each(function(){
			$(this).find(">td").eq(i).removeClass("show").addClass("hide");
		});
		$("#gridTable >thead >tr >td").eq(i).removeClass("show").addClass("hide");
		$("#bak_table_gridTable table >thead >tr >td").eq(i).removeClass("show").addClass("hide");
	}else{
		$("#gridTable #dataBody >tr").each(function(){
			$(this).find(">td").eq(i).removeClass("hide").addClass("show");
		});
		$("#gridTable >thead >tr >td").eq(i).removeClass("hide").addClass("show");
		$("#bak_table_gridTable table >thead >tr >td").eq(i).removeClass("hide").addClass("show");
	}
}

/**
 * 编辑行
 * 
 * @param {}
 *            rowId
 */
function doRowEdit(rowId, event) {
	$("div.actBtn[autoBuild='true']").show();
	// 没有正在编辑的表格行，及不为当前编辑行时，进行模式切换
	if (isEditAble(rowId)) {
		origTRs[rowId] = jQuery("#"+ rowId).clone(true)[0]; // 保留原TR模型
		origRecords[rowId] = getRecordById(rowId); // 保留原TR数据
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i] == null || columnModel[i] == "" || columnModel[i] == undefined){
				continue;
			}
			var editorId = rowId + "_" + columnModel[i];
			doEdit(editorId);
		}
		var $el = null;
		if ($el = jQuery(event)) {
			// 获取"Show DIV"的下一个元素"Edit DIV"中的Editor
			try {
				var currentEditorId = $el.next().children().eq(0).attr("id");
				doSelect(currentEditorId); // 当前选中的编辑器ID
			} catch (ex) {
				// alert(ex);
			}
		}
		jQuery("#"+ rowId).removeClass('table-tr-onchange');
		jQuery("#"+ rowId).addClass('grid-rowselected');
		showOrHideActionTd();	//当前表格是否要显示操作列
		jQuery("#" + rowId).bind('change',function(){
			setFieldValChanged(true);
		}).bind("keydown",function(e){
			 var key = e.which;
			 if (this.type != "textarea" && key == 13) {
			 	e.preventDefault(); //按enter键时阻止表单默认行为
			 }
		});
		/**
		 * 点击行编辑的时候,重计算本文档
		 */
		if(event){
			DocumentUtil.doRefreshRow4subGridView(rowId, getGridParams(), function(rtn) {
				var oTR = eval(rtn);
				var record = _getRecordByRefreshTR(oTR);
				for (var i = 0; i < columnModel.length; i++) {
					if(columnModel[i].indexOf("$") >= 0) break;	//列是系统字段名时，返回
					var editorId = rowId + "_" + columnModel[i];
					var data = record[columnModel[i]];
					var $edit = jQuery("#"+ editorId);
					if ($edit && data) {
						if($edit.attr("type")== 'radio' || $edit.attr("type")== 'checkbox'){
							jQuery.each($("input[name=editorId]"),function(){
								if($(this).val()==data){
									$(this).prop("checked",true);
								}else{
									$(this).prop("checked",false);
								}
							});
						}else{
							$edit.val(data);
						}
					}
				}
			});
		}
		editingRows.push(rowId);
		//jquery重构按钮和控件
		jqRefactor();
		ev_resize4IncludeViewPar(); // 调整高度
		
		
		
	}
	fixTableScroll("gridTable","table_gridView");  
}

/**
 * 当前表格行是否可编辑
 * 
 * @param {}
 *            rowId 表格行ID
 * @return {}
 */
function isEditAble(rowId) {
	if(jQuery.inArray(rowId,editingRows)==-1){
		return isedit = true ;
	}else{
		return isedit = false;
	};
}

/**
 * 选中编辑器
 * 
 * @param {}
 *            id
 */
function doSelect(id) {
	var $editor = jQuery("#"+ id);
	if (!$editor) {
		return;
	}
	switch ($editor.attr("fieldType")) {
		case "InputField" :
			$editor.select();
			break;
		case "NumberField" :
			$editor.select();
			break;
		case "SelectField" :
			$editor.focus();
			break;
		case "CheckboxField" :
			break;
		case "RadioField" :
			break;
		case "TextAreaField" :
			$editor.select();
			break;
		case "DateField" :
			$editor.focus();
			break;
		default :
			break;
	}
}

/**
 * 编辑单元格
 * 
 * @param {}
 *            id 编辑器ID
 */
function doEdit(editorId) {
	jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","");
	if(editorId.indexOf("$") >= 0) return;	//列是系统字段名时，返回
	var editor = jQuery("#" + editorId);
	if (!editor) {
		return;
	}
	if(editor.attr("fieldtype") == "SuggestField"){editor.parent().parent().parent().css("overflow","");}
	var editDiv = jQuery("#" + editorId + "_edit");
	var showDiv = jQuery("#" + editorId + "_show");
	if (showDiv && editDiv) {
		editDiv.show();
		showDiv.hide();
	}
}

/**
 * 表格行编辑后操作
 * 
 * @param String
 *            rowId 行ID
 */
function doAfterRowEdit(rowId) {
	if (jQuery.inArray(rowId,editingRows) != -1) {
		for (var i = 0; i < columnModel.length; i++) {
			doAfterEdit(rowId + "_" + columnModel[i]);
		}
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==rowId;
		},true);
		newRows=jQuery.grep(newRows,function(val,key){
			return val==rowId;
		},true);
		jQuery("#" + rowId).removeClass('grid-rowselected');
		showOrHideActionTd();	//当前表格是否要显示操作列
		ev_resize4IncludeViewPar();
		
		jQuery(".imgClick").bind("click",function(event){
			event.stopPropagation();
		});
	}
}

/**
 * 编辑后操作
 * 
 * @param {}
 *            id 编辑器ID
 */
function doAfterEdit(id) {
	if(id.indexOf("$") >= 0) return;	//列是系统字段名时，返回
	var editor = jQuery("#" + id);
	if (!editor) {
		return;
	}
	var editDiv = jQuery("#" + id + "_edit");
	var showDiv = jQuery("#" + id + "_show");
	var rtn = "&nbsp";
	var value = editor.val();
	var fieldType = "";
	if(editor){
		fieldType = editor.attr("fieldtype");
	}
	var pre = editor.parent();
	var showType = "";	//真实值；显示值
	var displayType = "";	//显示部分；显示全部
	if(pre){
		showType = pre.attr("showType");
		displayType = pre.attr("displayType");
	}
	switch (fieldType) {
		case 'UserField' :
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = jQuery("#" + id + "_text").val();
			}
			break;	
		case 'SelectField' :
			if (editor.find("option").length > 0) {
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
					value = editor.find("option:selected").text();
					else
					value = editor.find("option:selected").val();
				}
			}
			break;
		case 'RadioField' :
			var els = document.getElementsByName(editor.attr("name"));
			for (var i = 0; i < els.length; i++) {
				if (els[i].checked) {
					if(displayType == "01")
						value = showDiv.html();
					else{
						if(showType == "01")
							value = els[i].getAttribute("text");
						else
							value = els[i].value;
					}
				}
			}
			break;
		case 'SelectAboutField' :
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
				else{
					var edit_id = jQuery("#"+ id + "_edit");
					var selectName = jQuery("#"+ id).attr("name");
					var selectedVal ="";
					var optionSize = jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").size();
					jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").each(function(i){
						selectedVal += jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").eq(i).text();
						if(i != optionSize - 1){
							selectedVal+=";" ;
						}
					});
					value = selectedVal;
				}
			}
			break;
		case 'SuggestField' :
			var pre = editor.parent().parent();
			var showType = "";
			if(pre) {
				showType = pre.attr("showType");
				displayType = pre.attr("displayType");
			}
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).attr("text");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'TreeDepartmentField' :
			var show_id = document.getElementById(editor.attr("id") + "_text");
			var getV = jQuery(show_id).val();
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getV;
			}
			break;
		case 'OnLineTakePhotoField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		case 'CheckboxField' :
			var getT = jQuery("#" + editor.attr("id") + "_show").attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'AttachmentUploadField' :
			var pre = editor.parent().parent().parent().parent().parent();
			var showType = "";
			if(pre){
				showType = pre.attr("showType");
				displayType = pre.attr("displayType");
				}
			if(editor.attr("id")){
				var show_id = document.getElementById(editor.attr("id") + "_show");
				var getT = jQuery(show_id).attr("title");
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
						value = getT;
				}
			}
//			var fileInfo = new Object(value.split(";")[0] + "..."); // 查看upload.js
//			value = fileInfo.showName;
			break;
		case 'AttachmentUploadToDataBaseField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var getT = jQuery("#" + editor.attr("id") + "_show").attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'ImageUploadField' :
			var pre = editor.parent().parent().parent().parent().parent();
			var showType = "";
			if(pre) {
				showType = jQuery(pre).attr("showType");
				displayType = jQuery(pre).attr("displayType");
			}
			if(editor.attr("id")){
				var name = editor.attr("id").substring(editor.attr("id").indexOf("_") + 1);
				var getT = jQuery("div[name=" + name + "_gridView]").html();
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
						value = getT;
				}
			}
//			if (value) {
//				var fileInfo = new Object(value.split(";")[0]); // 查看upload.js
				// value = '<img border="0" src="'+ fileInfo.url +'" width="40"
				// height="20" broder="0"/>';
//				value = fileInfo.showName;
//			}
			break;
		case 'ImageUploadToDataBaseField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		case 'FileManagerField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		default :
			if(showType == "01" || displayType == "01")
				value = showDiv.html();
			break;
	}
	if (value) {
		rtn = value;
	}
	
	showDiv.html(rtn);
	if(fieldType =='FileManagerField'){
		var uploadListId = 'uploadList_'+editor.attr("id");
		var eidtorIdDiv = uploadListId+'div';
		jQuery("#"+ eidtorIdDiv).find(".imgList").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".showImgIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".showImgIcon").hide();
		});
		jQuery("#"+ eidtorIdDiv).find("img[type='previous']").click(function(event) {
			event.stopPropagation();
			doPrevious(uploadListId);
		});
		jQuery("#"+ eidtorIdDiv).find("img[type='next']").click(function(event) {
			event.stopPropagation();
			doNext(uploadListId);
		});
	}
	if(fieldType =='OnLineTakePhotoField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".takePhotoImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".takePhotoIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".takePhotoIcon").hide();
		});
	}
	if(fieldType =='ImageUploadField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".bigImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".smallIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".smallIcon").hide();
		});
	}
	if(fieldType =='ImageUploadToDataBaseField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".bigImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".smallIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".smallIcon").hide();
		});
	}
	showDiv.show();
	editDiv.hide();

	// var record = getRecord(editor);
	// modifiedRecords[record.id] = record; // 放入已修改队列
	editingElements=jQuery.grep(editingElements,function(val,key){
		return val==id;
	},true);
}

/**
 * 返回编辑器所对应的表格行数据
 * 
 * @param {}
 *            editor
 * @return {}
 */
function getRecord(currentEditor) {
	var origTR = currentEditor.parent().parent().parent();
	if(jQuery(currentEditor).attr("GridType")=='uploadFile'){//文件（图片上传）
		origTR = origTR.parent().parent().parent().parent();
	}
	if(jQuery(currentEditor).attr("GridType")=='fileManager'){//文件管理
		origTR = origTR.parent().parent().parent().parent();
	}
	if(jQuery(currentEditor).attr("GridType")=='imageUpload2DataBase'){//图片上传到数据库
		origTR = origTR.parent().parent().parent().parent();
	}
	if(jQuery(currentEditor).attr("GridType")=='AttachmentUploadToDataBase'){//文件上传到数据库
		origTR = origTR.parent().parent().parent().parent();
	}
	if(jQuery(currentEditor).attr("GridType")=='suggestField'){//下拉提示框
		origTR = origTR.parent();
	}
	return _getRecordByTR(origTR);
}

function getRecordById(id) {
	var oTR = jQuery("#" + id);
	return _getRecordByTR(oTR);
}

/**
 * 私有方法
 * 
 * @param {}
 *            origTR
 * @return {}
 */
function _getRecordByTR(origTR) {
	var record = {};
	if (origTR) {
		record.id = origTR.attr("id");
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") >= 0) break;	//列是系统字段名时，返回
			var id = origTR.id + "_" + columnModel[i];
			var editor = jQuery("#" + origTR.attr("id") + "_" + columnModel[i])[0];
			if (editor) {
				var itemValue = '';
				var formType = jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]).attr("type");

				if(formType == 'radio' || formType == 'checkbox'){
					jQuery("[id='" + origTR.attr("id") + "_" + columnModel[i] + "']:checked").each(function(){
						if(jQuery(this).val() != "")
							itemValue += jQuery(this).val() + ";";
					});
					itemValue = itemValue.substring(0,itemValue.length-1);
				}else{
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i],origTR).val();
				}
				if(jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]).val()==null){
					itemValue='';
				}
				record[columnModel[i]] = itemValue;
			}
		}
	}
	return record;
}

function _getRecordByRefreshTR(origTR) {
	var record = {};
	if (origTR) {
		record.id = origTR.attr("id");
		var editor;
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") < 0)
				editor = jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]);
			if (editor && columnModel[i].indexOf("$") < 0) {
				var itemValue = '';
				var formType = jQuery("[name='" + origTR.attr("id") + "_" + columnModel[i] + "']").attr("type");
				var fieldType = editor.attr("fieldtype");
				if(fieldType == 'SelectField'){
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i]).val();
				}else if(formType == 'radio' || formType == 'checkbox'){
					jQuery("[name='" + origTR.attr("id") + "_" + columnModel[i] + "']:checked").each(function(){
						itemValue += jQuery(this).val() + ";";
					});
					itemValue = itemValue.substring(0,itemValue.length-1);
				}else{
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i],origTR).val();
				}
				
				if(editor.attr("value")==null){
					itemValue='';
				}
				record[columnModel[i]] = itemValue;
			}
		}
	}
	return record;
}

function createRow(config) {
	var oTR =jQuery("<tr id=" + config.id + " class=" + config.cssClass + "></tr>");
	return oTR;
}

function createColumn(config, content) {
	var cssclass="";
	var cssstyle="";
	if(config.cssClass){
		cssclass = " class=" + config.cssClass + "";
	};
	if(config.style){
		cssstyle=" style=" + config.style + "";
	};
	var oTD = jQuery("<td " + cssclass + " " + cssstyle + "></td>");
	oTD.html(content);
	return oTD;
}

function getGridParams() {
	// 获取act table 下的输入值
	var params = jQuery.par2Json(decodeURIComponent(jQuery('#acttable input,#acttable select,#acttable textarea').serialize()),true);
	return params;
}

/**
 * 新建操作
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doNew(activityId) {
	jQuery.ajax({
		type: 'POST',
		async:false, 
		url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + activityId,
		dataType : 'text',
		data: jQuery("#formList").serialize(),
		success:function(result) {
			if(result != null && result != ""){
	        	var jsmessage = eval("(" + result + ")");
	        	var type = jsmessage.type;
	        	var content = jsmessage.content;
	        	
	        	if(type == '16'){
	        		alert(content);
	        		return;
	        	}
	        	
	        	if(type == '32'){
	        		var rtn = window.confirm(content);
	        		if(!rtn){
	        			return;
	        		}else {
	        			jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","");
	        			DocumentUtil.doNew(activityId, getGridParams(), function(rtn) {
	        						var oTR = eval(rtn);
	        						if (oTR) {
	        							insertRow(oTR[0], oTable.rows.length);
	        							newRows.push(oTR.attr("id"));
	        							doRowEdit(oTR.attr("id"));
	        						}

	        						jQuery("#" + oTR.attr("id")).bind('change',function(){
	        							setFieldValChanged(true);
	        						}).bind("keydown",function(e){
	        							 var key = e.which;
	        							 if (this.type != "textarea" && key == 13) {
	        							 	e.preventDefault(); //按enter键时阻止表单默认行为
	        							 }
	        						});
	        						//jquery重构按钮和控件
	        						jqRefactor();
	        						ev_resize4IncludeViewPar(); // 调整高度
	        					});
	        		}
	        	}
	        }else {
	        	jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","");
	        	DocumentUtil.doNew(activityId, getGridParams(), function(rtn) {
	        				var oTR = eval(rtn);
	        				if (oTR) {
	        					insertRow(oTR[0], oTable.rows.length);
	        					newRows.push(oTR.attr("id"));
	        					doRowEdit(oTR.attr("id"));
	        				}

    						jQuery("#" + oTR.attr("id")).bind('change',function(){
    							setFieldValChanged(true);
    						}).bind("keydown",function(e){
    							 var key = e.which;
    							 if (this.type != "textarea" && key == 13) {
    							 	e.preventDefault(); //按enter键时阻止表单默认行为
    							 }
    						});
    						showOrHideActionTd();	//当前表格是否要显示操作列	
	        				//jquery重构按钮和控件
	        				jqRefactor();
	        				ev_resize4IncludeViewPar(); // 调整高度
	        			});
	        }
		},
		error: function(result) {
			alert("运行脚本出错");
		}
	});
	
}

/**
 * 新建行
 */
function subGridCreateTr(oTR){
	if (oTR) {
		insertRow(oTR[0], 0);
		newRows.push(oTR.attr("id"));
		doRowEdit(oTR.attr("id"));
	}

	jQuery("#" + oTR.attr("id")).bind('change',function(){
		setFieldValChanged(true);
	}).bind("keydown",function(e){
		 var key = e.which;
		 if (this.type != "textarea" && key == 13) {
		 	e.preventDefault(); //按enter键时阻止表单默认行为
		 }
	});
	
	//jquery重构按钮和控件
	jqRefactor();
	ev_resize4IncludeViewPar(); // 调整高度
}


/**
 * 插入行
 * 
 * @param {}
 *            oTR
 */
function insertRow(oTR, index) {
	var origTR = oTable.rows[index];
	if (origTR) {
		oTable.insertBefore(oTR, origTR); // origTR为空则插入到最后一行
	} else {
		oTable.appendChild(oTR);
	}
}

/**
 * 删除行
 * 
 * @param {}
 *            oTR
 */
function removeRow(oTR) {
	if(oTR != null){
		oTable.removeChild(oTR);
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==oTR.id;
		},true);
	}
	ev_resize4IncludeViewPar();
}

/**
 * 删除操作
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doRemove(activityId) {
	var flag = false;
	jQuery.ajax({
		type: 'POST',
		async:false, 
		url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + activityId,
		dataType : 'text',
		data: jQuery("#formList").serialize(),
		success:function(result) {
			if(result != null && result != ""){
	        	var jsmessage = eval("(" + result + ")");
	        	var type = jsmessage.type;
	        	var content = jsmessage.content;
	        	
	        	if(type == '16'){
	        		alert(content);
	        		return;
	        	}
	        	
	        	if(type == '32'){
	        		var rtn = window.confirm(content);
	        		if(!rtn){
	        			return;
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
	
	if(flag){
		var selects = document.getElementsByName(selectionName);
		if (selects && selects.length > 0) {
			var deleteTRs = [];
			var selectedIds = [];
			for (var i = 0; i < selects.length; i++) {
				if (selects[i].checked) {
					selectedIds.push(selects[i].value);
					deleteTRs.push(document.getElementById(selects[i].value));
				}
			}
			if (selectedIds.length > 0) {
				//params[selectionName] = selectedIds.join(";");
				if(!confirm("确定要删除您选择的记录吗?")){
					return;
				}
				DocumentUtil.doRemove(activityId, selectedIds, getGridParams(),
						function(rtn) {
							for (var i = 0; i < deleteTRs.length; i++) {
								removeRow(deleteTRs[i]);
								// 父窗口刷新
								if (typeof(parent.dy_refresh)=="function") {
									if(window.top !=window.self){//顶级打开的时候，不执行
										parent.dy_refresh("");
									}	
								}
								//刷新list
								if(location.href.replace(/#/g, "").indexOf("_viewid")>0){
									//location.replace(location.href.replace(/#/g, ""));
									document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action";
									document.forms[0].submit();
								}else{
									//if(location.href.replace(/#/g, "").indexOf("?")>0){
									//location.replace(location.href.replace(/#/g, "")+"&_viewid="+_viewid);
									//}else{
									//location.replace(location.href.replace(/#/g, "")+"?_viewid="+_viewid);
									//}
									document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action";
									document.forms[0].submit();
								}
								if(location.href.replace(/#/g, "").indexOf("action.action")>0){
									var frontUrlIndex = location.href.replace(/#/g, "").indexOf("activity");
									var frontUrl = location.href.replace(/#/g, "").substring(0, frontUrlIndex);
									location.replace(frontUrl+"view/displayView.action?_viewid="+_viewid);
								}
							}
							
							if(rtn){
								var obj = eval("(" + rtn + ")");
								if(obj.funName == 'Alert'){
									alert(obj.content);
								}else if(obj.funName == 'Confirm'){
									confirm(obj.content);
								}
							}
						});
			}
			else{
				alert("请选择要删除的数据!");
				return false;
			}
		}
	}
}

/**
 * 单独删除操作
 * 
 * @param {}
 *            id
 */
function doSingleRemove(rowId, application) {
	if (rowId) {
		DocumentUtil.doSingleRemove(rowId, application, function(rtn) {
					if (rtn) {
						eval(rtn);
					} else {
						removeRow(document.getElementById(rowId));
						//刷新list
						if(location.href.replace(/#/g, "").indexOf("_viewid")>0){
							location.replace(location.href.replace(/#/g, ""));
						}else{
							if(location.href.replace(/#/g, "").indexOf("?")>0){
							location.replace(location.href.replace(/#/g, "")+"&_viewid="+_viewid);
							}else{
							location.replace(location.href.replace(/#/g, "")+"?_viewid="+_viewid);
							}
						}
						if(location.href.replace(/#/g, "").indexOf("action.action")>0){
							var frontUrlIndex = location.href.replace(/#/g, "").indexOf("activity");
							var frontUrl = location.href.replace(/#/g, "").substring(0, frontUrlIndex);
							location.replace(frontUrl+"view/displayView.action?_viewid="+_viewid);
						}
					}
				});
	}
}

/**
 * 保存操作
 * 
 * @param {}
 *            activityId 按钮ID
 */
function doSave(activityId) {
	var saveRecords = [];
	for (var i = 0; i < editingRows.length; i++) {
		var record = getRecordById(editingRows[i]);
		saveRecords.push(record);
	}
	DocumentUtil.doSave(activityId, jQuery.json2Str(saveRecords), getGridParams(),
			function(rtn) {
				if (rtn) {
					if(rtn.indexOf("obpm:") == 0){
						rtn = rtn.substring(5);
						showError(rtn);
					}else{
						eval(rtn);
					}
				} else {
					for (var i = 0; i < saveRecords.length; i++) {
						doAfterRowEdit(saveRecords[i].id);
					}
					// 父窗口刷新
					if (typeof(parent.dy_refresh)=="function") {
						if(window.top !=window.self){//顶级打开的时候，不执行
							parent.dy_refresh("");
						}
					}
					//刷新list
					var qs ='';
					if(parentid.length>0){
						qs ='&parentid='+parentid+'&isRelate='+isRelate;
					}
					var _currpage = document.getElementsByName('_currpage')[0].value;
					var _divid = document.getElementsByName('divid')[0].value;
					if(location.href.replace(/#/g, "").indexOf("_viewid")>0){
						//location.replace(location.href.replace(/#/g, ""));
						document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action";
						document.forms[0].submit();
					}else{
						//if(location.href.replace(/#/g, "").indexOf("?")>0){
						//location.replace(location.href.replace(/#/g, "")+"&_viewid="+_viewid+qs+"&_currpage="+_currpage+"&divid="+_divid);
						//}else{
						//location.replace(location.href.replace(/#/g, "")+"?_viewid="+_viewid+qs+"&_currpage="+_currpage+"&divid="+_divid);
						//}
						document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action";
						document.forms[0].submit();
					}
					if(location.href.replace(/#/g, "").indexOf("action.action")>0){
						var frontUrlIndex = location.href.replace(/#/g, "").indexOf("activity");
						var frontUrl = location.href.replace(/#/g, "").substring(0, frontUrlIndex);
						location.replace(frontUrl+"view/displayView.action?_viewid="+_viewid+qs+"&_currpage="+_currpage);
					}
					
				}
				jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
			});
}

/**
 * 获取修改过的记录
 */
function getModifiedRecords() {
	return jQuery.jQueryValues(modifiedRecords);//jquery-obpm-extend.js
}

/**
 * 查询操作
 */
function doQuery(activityId) {
	ev_submit(activityId);
}
function modifyActionBack(){
	document.getElementsByName('_currpage')[0].value=1;
	document.forms[0].action=contextPath + "/portal/dynaform/view/displayView.action?isQueryButton=true";
	document.forms[0].target="";
	document.forms[0].submit();
}
/**
 * 刷新操作
 * 
 * @param {}
 *            editorId
 */

function doRefresh(editorId) {
	var record = getRecord(jQuery("#"+ editorId));
	DocumentUtil.doRefresh(jQuery.obj2Str(record), getGridParams(),
			function(rtn) {
				if(rtn.indexOf("obpm:") == 0){
					rtn = rtn.substring(5);
					showError(rtn);
				}else{
					eval(rtn);
				}
				//jquery重构按钮和控件
				jqRefactor();
			});
}


/**
 * 取消所有操作, 还原表格行
 * 
 **/
function doCancelAll(){
	$("div.actBtn[autoBuild='true']").hide();
	if(editingRows.length>0){
		var tempEditingRows = editingRows;
		for (var i = 0; i <=tempEditingRows.length; i++) {
			doCancel(tempEditingRows[i]);
		}
	}
	jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
	if(isSetWidth){
		jQuery("#gridTable").css("table-layout","fixed");
	}
}

/**
 * 取消操作, 还原表格行
 * 
 * @param {}
 *            rowId
 */
function doCancel(rowId) {
	if(editingRows.length==1){
		$("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
		$("div.actBtn[autoBuild='true']").hide();
	}
	var currentTR = document.getElementById(rowId);
	if (jQuery.inArray(rowId,newRows) != -1) { // 新建行取消操作
		var application = document.getElementsByName("application")[0].value;
		removeRow(document.getElementById(rowId));
	} else if (jQuery.inArray(rowId,editingRows) != -1) { // 编辑行取消操作
		var origTR = origTRs[rowId];

		// 还原模型
		insertRow(origTR, currentTR.rowIndex);
		oTable.removeChild(currentTR);
		// 清空temp元素
		fieldsTemp = {};
		divsTemp = {};
		// 还原数据
		var record = origRecords[rowId];
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") >= 0) break;	//列是系统字段名时，返回
			var editorId = rowId + "_" + columnModel[i];
			var data = record[columnModel[i]];
			if (jQuery("#"+ editorId)) {
				jQuery("#" + editorId).val(data);
			}
			if(jQuery("#"+ editorId).attr("fieldtype") == "SuggestField"){jQuery("#"+ editorId).parent().parent().parent().css("overflow","hidden");}
			var editDiv = jQuery("#" + rowId + "_" + columnModel[i]+ "_edit");
			var showDiv = jQuery("#" + rowId + "_" + columnModel[i] + "_show");
			showDiv.show();
			editDiv.hide();
		}
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==rowId;
		},true);
		newRows=jQuery.grep(newRows,function(val,key){
			return val==rowId;
		},true);
		jQuery("#" + rowId).removeClass('grid-rowselected');
		ev_resize4IncludeViewPar();
	}
	showOrHideActionTd();	//当前表格是否要显示操作列
	if(isSetWidth){
		jQuery("#gridTable").css("table-layout","fixed");
	}
	
	if($("#gridTable").find("input[value='取消']:visible").size()<=0){
		$("div.actBtn[autoBuild='true']").hide();
	}
	fixTableScroll("gridTable","table_gridView");  
}

function showNotice(msg) {
	alert(msg);
}

function showError(msg) {
	alert(msg);
}

/*
 * 视图打印(网格视图时)
 */
function ev_printview(actid) {
	var viewid = document.getElementsByName("_viewid")[0].value;
	var signatureExist = document.getElementById("signatureExist").value;
	
	var url = activityAction + '?_viewid=' + viewid;
	url += '&_signatureExist=' + signatureExist;
	url += '&_activityid=' + actid;
	url += '&application=' + application;
	
	if(ev_runbeforeScriptforgrid(actid)){
		if (parent != top) {
			parent.open(url);
		} else {
			window.open(url);
		}
	}
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
	if(ev_runbeforeScriptforgrid(actid)){
		var url = activityAction + '?_activityid=' + actid;
    	document.forms[0].action = url;
    	//document.forms[0].target = '_blank';
    	document.forms[0].submit();
    	//document.forms[0].target = '';
	}
}

function ev_runbeforeScriptforgrid(actid){
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

//文件下载
function downloadFile(name,path){
	var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ encodeURI(name) + "&filepath=" + path);
	window.open(url);
}
