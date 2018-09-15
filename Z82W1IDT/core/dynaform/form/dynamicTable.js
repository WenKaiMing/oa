var rowIndex = 1;

var FIELD_NAME = 'mFieldName';
var COLUMN_NAME = 'mColumnName';
var MAPPING_STR = 'mappingStr';
var TABLE_NAME_ID = 'tableName';
var FORM_NAME_ID = 'name';

var getFieldHtml = function(data) {
	var s = '';
	s += '<select id="field' + rowIndex + '" name="' + FIELD_NAME + '" onchange="dupFieldValidation(this)">';
	s += '<option value="' + data.fieldName + '" selected>' + emptyOption
			+ '</option>'
	s += '</select>';

	return s;
};

var getColumnHtml = function(data) {
	var s = '';
	s += '<select id="column' + rowIndex + '" name="' + COLUMN_NAME + '" onchange="dupColumnNameValidation(this)">';
	s += '<option value="' + data.columnName + '" selected>' + emptyOption
			+ '</option>'
	s += '</select>';

	return s;
};

var getDeleteHtml = function(data) {
	var s = '<input type="button" value="' + deleteBtn
			+ '" onclick="delRow(mappingtb, this.parentNode.parentNode)"/>';
	rowIndex++;
	return s;
};

/**
 * 初始化表格行
 */
function initRows() {
	var oMappingStr = document.getElementById(MAPPING_STR);
	if (oMappingStr && oMappingStr.value) {
		var mapping = jQuery.parseJSON(oMappingStr.value);
		var oTableName = document.getElementById(TABLE_NAME_ID);

		if (mapping.tableName) {
			oTableName.value = mapping.tableName;
		}
		var mappingID = document.getElementById("mappingID");
		var mstr = mapping.columnMappings;
		if(mstr){
			
			for(i=0;i<mstr.length;i++){
				if(mstr[i].fieldName=="MAPPINGID"){
					mappingID.value = mstr[i].columnName;
				}
			}
			addRows(mapping.columnMappings);
		}
	} else {
		addRows();
	}
	
}

/**
 * 设置映射字符串
 */
function setMappingStr() {
	var oMappingStr = document.getElementById(MAPPING_STR);
	var fieldNames = document.getElementsByName(FIELD_NAME);
	var columnNames = document.getElementsByName(COLUMN_NAME);
	var oFormName = document.getElementById(FORM_NAME_ID);
	var oTableName = document.getElementById(TABLE_NAME_ID);

	var array = new Array();
	for (var i = 0; i < fieldNames.length; i++) {
		if (fieldNames[i].value || columnNames[i].value) { // 任一字段有值则保存
			array.push({
						fieldName : fieldNames[i].value,
						columnName : columnNames[i].value
					});
		}
	}

	if (oMappingStr) {
		oMappingStr.value = jQuery.json2Str({
			formName : oFormName.value,
			tableName : oTableName.value,
			columnMappings : array
	});
	}
}

/**
 * 根据数据增加行
 * 
 * @param {}
 *            datas
 */
function addRows(datas) {
	var cellFuncs = [getFieldHtml, getColumnHtml, getDeleteHtml];
	var rowdatas = datas;
	if (!datas) {
		var data = {
			fieldName : '',
			columnName : ''
		};
		rowdatas = [data];
	}
	DWRUtil.addRows("mappingtb", rowdatas, cellFuncs);
	addFldOptions();
	addColOptions();
}

function addFldOptions() {
	var options = {
		'' : emptyOption,
		'MAPPINGID' : pk
	};

	//Alvin  2014-12-26
	if(typeof FCKeditorAPI != "undefined" && FCKeditorAPI.GetInstance("_templatecontext")!=null){
		var formHtml = "";
		if(FCKeditorAPI.GetInstance("_templatecontext").EditorDocument){
			formHtml = FCKeditorAPI.GetInstance("_templatecontext").EditorDocument.body.innerHTML;
		}else{
			formHtml = document.getElementById("formItem_content_templatecontext").value;
		}
		
		var reg = new RegExp("&lt;","g");
		formHtml = formHtml.replace(reg,"<");
		reg = new RegExp("&gt;","g");
		formHtml = formHtml.replace(reg,">");
		
		var $optionsDiv = jQuery("#optionsDiv");
		if($optionsDiv.length==0){
			$optionsDiv = jQuery("<div id='optionsDiv' style='display: none'>" + formHtml + "</div>");
			jQuery("#eWebEditor").append($optionsDiv);
		}else{
			$optionsDiv.html(formHtml);
		}
	    jQuery("#optionsDiv").find("*").each(function(){
	    	var optionsName = jQuery(this).attr("name");
	    	if(optionsName){
	    		var cn = jQuery(this).attr("classname");
	    		if(cn && cn=="cn.myapps.core.dynaform.form.ejb.FlowHistoryField"){
	    			
	    		}else{
	    			options[optionsName] = optionsName;
	    		}
	    	}
	    });
	    addMappingOptions(FIELD_NAME, options);
	}
	
}

/**
 * 添加数据库列选项
 */
function addColOptions(isCleanDef) {
	var oField = document.getElementById(TABLE_NAME_ID);
	if (oField && oField.value) {
		FormHelper.getDataBaseColumnMap(oField.value, application, function(
						options) {
					addMappingOptions(COLUMN_NAME, options, isCleanDef);
				});
	}
}

/**
 * 删除一行
 * 
 * @param {}
 *            id 行ID
 * @param {}
 *            row 行对象
 */
function delRow(elem, row) {
	if (elem) {
		elem.deleteRow(row.rowIndex);
		rowIndex--;
	}
}

/**
 * 
 * @param {}
 *            elemName
 * @param {}
 *            options
 */
function addMappingOptions(elemName, options, isCleanDef) {
	var elems = document.getElementsByName(elemName);
	for (var i = 0; i < elems.length; i++) {
		var defVal = elems[i].value; // 默认值
		DWRUtil.removeAllOptions(elems[i].id);
		DWRUtil.addOptions(elems[i].id, options);
		if (isCleanDef != true) {
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}
}
