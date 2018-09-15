<%@ page pageEncoding="UTF-8"%>
<o:MultiLanguage>
<%@include file="/common/tags.jsp"%>
<script src="<s:url value='/script/util.js'/>"></script>
		<tr id="tr_refreshMode" style="display: none;">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.field.refreshMode]*}:</td>
			<td colspan="4">
			<s:radio name="refreshMode" value="0"
				list="#{'0':'{*[cn.myapps.core.dynaform.form.field.refreshMode.global]*}','1':'{*[cn.myapps.core.dynaform.form.field.refreshMode.local]*}'}"
				onclick="refreshModeChange(this.value)" theme="simple" /></td>
		</tr>

		<tr id="tr_refreshMode_local" style="display: none;">
			<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.field.refreshFields]*}:</td>
			<td colspan="4">
			<table border="0" width="100%">
				<tr>
				<td>&nbsp;</td>
				<td align="right">
					<input type="button" value="{*[Add]*}" onclick="addLocalRefreshMappRows()"/> 
				</td></tr>
				<tbody id="refreshMode_local_mapping"> 
				<tr>
					<th align="left">{*[cn.myapps.core.dynaform.form.webeditor.label.fieldName]*}</th>
					<th align="right"></th>
				</tr>
				</tbody>
			</table>
			</td>
		</tr>
<script>
var $optionsDiv ;     //文本编辑器内容

var formFields;

var localRefreshMappRowIndex = 1;

function  _getFormFields(){
	 //初始化表单数据
	  formFields = new Object();
	  var formHtml = "";
	  formHtml = oDOM.body.innerHTML;
	  var reg = new RegExp("&lt;","g");
	  formHtml = formHtml.replace(reg,"<");
	  reg = new RegExp("&gt;","g");
	  formHtml = formHtml.replace(reg,">");
	  $optionsDiv = jQuery("#optionsDiv");
	  if($optionsDiv.length==0){
		$optionsDiv = jQuery("<div id='optionsDiv' style='display: none'>" + formHtml + "</div>");
 	}else{
		$optionsDiv.html(formHtml);
	  }
	  formFields[""]="选择";
	  //初始化表单校验数据
	  var tn = jQuery("input[name='name']").val();
	  $optionsDiv.find("*").each(function(){
	    	var name = jQuery(this).attr("name");
	    	var id = jQuery(this).attr("id");
	    	
	    	if(name){
	    		var cn = jQuery(this).attr("classname");
	    		if(cn && (cn=="cn.myapps.core.dynaform.form.ejb.FlowHistoryField"
	    				|| cn=="cn.myapps.core.dynaform.form.ejb.flowreminderhistoryfield"
	    				|| cn=="cn.myapps.core.dynaform.form.ejb.ImageUploadToDataBaseField"
	    				|| cn=="cn.myapps.core.dynaform.form.ejb.InformationFeedbackField"
   						|| cn=="cn.myapps.core.dynaform.form.ejb.ReminderField"
						|| cn=="cn.myapps.core.dynaform.form.ejb.weixingpsfield"
						|| cn=="cn.myapps.core.dynaform.form.ejb.weixinrecordfield"
						|| cn=="cn.myapps.core.dynaform.form.ejb.AttachmentUploadToDataBaseField"
						|| cn=="cn.myapps.core.dynaform.form.ejb.TreeDepartmentField"
						|| name==tn)){
	    		}else{
	    			
	    			formFields[name] = name;
	    		}
	    		
	    	}else if( !name &&id ){ // hotfix :兼容计算脚本刷新重计算
	    		var cn = jQuery(this).attr("classname");
	    		if(cn && cn == "cn.myapps.core.dynaform.form.ejb.CalctextField"){
	    			formFields[name] = "计算脚本_" + id;
	    		}
	    	}
	    });
}

function refreshOnChangedClick(el){
	if(el.checked){
		 document.getElementById("tr_refreshMode").style.display='';
		 document.getElementById("tr_refreshMode_local").style.display='';
	}else{
		document.getElementById("tr_refreshMode").style.display='none';
		document.getElementById("tr_refreshMode_local").style.display='none';
	}
}

function refreshModeChange(value){
	var tr_refreshMode_local = document.getElementById("tr_refreshMode_local");
	switch (value) {
	case '0':
		tr_refreshMode_local.style.display='none';
		break;
	case '1':
		tr_refreshMode_local.style.display='';
		break;
	default:
		break;
	}
}

var getLocalRefreshMappFldName = function(data) {
	var s =''; 
	s +='<select id="refreshMode_local_fldname'+ localRefreshMappRowIndex +'" name="refreshMode_local_fldname" value="' + data.fldname + '" >';
	s +='<option value="">{*[Select]*}</option>';	
	s +='</select>';
	return s ;
};
var getLocalRefreshMappDelete = function(data) {
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delLocalRefreshMappRow(this.parentNode.parentNode)"/>'
  	localRefreshMappRowIndex ++;
  	return s;
};

// 根据数据增加行
function addLocalRefreshMappRows(datas) {
	var cellFuncs = [getLocalRefreshMappFldName, getLocalRefreshMappDelete];

	var rowdatas = datas;
	
	if (!datas) {
		var data = {fldname:''};
		rowdatas = [data];
	}
	
	DWRUtil.addRows("refreshMode_local_mapping", rowdatas, cellFuncs);
	var fldValues = new Array();
	
	if (datas) { //设置默认值
		for(var i=0;i<datas.length;i++) {
			fldValues[i] = datas[i].fldname;
		}
	} else {
		var fldSels = document.getElementsByName("refreshMode_local_fldname");
		for(var i=0;i<fldSels.length;i++) {
			fldValues[i] = fldSels[i].value;
		}
	}
	_addAllfldOptions(fldValues);
	resize();
}

//添加所有fldname元素的options
function _addAllfldOptions(defValues) {
	  //添加选项并设置回显
	  var fldSels = document.getElementsByName("refreshMode_local_fldname");
	  for(var i=0;i<fldSels.length;i++) {
		  	DWRUtil.removeAllOptions(fldSels[i].id);
			DWRUtil.addOptions(fldSels[i].id, formFields);
			if(defValues !=null){
				if (defValues[i] != null && defValues[i] !="") {    // 设置column name 默认选项
					DWRUtil.setValue(fldSels[i].id, defValues[i]);
				}
			}
		}
}
// 删除一行
function delLocalRefreshMappRow(row) {
	refreshMode_local_mapping.deleteRow(row.rowIndex-1);
	localRefreshMappRowIndex --;
	resize();
}
function getRefreshFieldsValue() {
	var flds = document.getElementsByName("refreshMode_local_fldname");
	var str = '';
	for (var i=0;i<flds.length;i++) {
		if (flds[i].value != '' && flds[i].value != '') {
			str += HTMLEncode(flds[i].value)+";";
		}
	}
	str = str.substring(0, str.length - 1);
	return  str;
}

function initLocalRefreshMappRow(str){
	if(!formFields){
		_getFormFields();
	}
	if(!str || str.length==0) return;
	var datas = [];
	var fields = str.split(";");
	for(var i=0;i<fields.length;i++){
		var data = {fldname:fields[i]};
		datas.push(data);
	}
	addLocalRefreshMappRows(datas);
}

</script>
</o:MultiLanguage>