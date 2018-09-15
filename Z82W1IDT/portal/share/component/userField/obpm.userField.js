(function($){
	$.fn.obpmUserfield = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var cssClass=$field.attr("class");
			var value=$field.attr("value");
			var getFieldValue=$field.attr("_getFieldValue");
			var limitSum=$field.attr("_limitSum");
			var isRefreshOnChanged=$field.attr("_isRefreshOnChanged");
			var roleid=$field.attr("_roleid");
			var selectUser=$field.attr("_selectUser");
			var add=$field.attr("_add");
			var clearlabel=$field.attr("_clearlabel");
			var subGridView=$field.attr("_subGridView");
			var selectMode=$field.attr("_selectMode");
			var displayType=$field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType = $field.attr("_textType");
			var hiddenValue = $field.attr("_hiddenValue");
			var style = $field.attr("style");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			fieldType = fieldType?fieldType:'';
			cssClass = cssClass?cssClass:'';
			value = value?value:'';
			getFieldValue = getFieldValue?getFieldValue:'';
			limitSum = limitSum?limitSum:'';
			isRefreshOnChanged = (isRefreshOnChanged == 'true');
			subGridView = (subGridView == 'true');
			roleid = roleid?roleid:'';
			selectUser = selectUser?selectUser:'';
			add = add?add:'';
			clearlabel = clearlabel?clearlabel:'';
			selectMode = selectMode?selectMode:'';
			displayType = displayType?displayType:'';
			textType = textType?textType:'';
			hiddenValue = hiddenValue?hiddenValue:'';
			
			var readonly = false;
			var html="";
			
			if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED) {
				readonly= true;
			}
			
			if(readonly && readOnlyShowValOnly == "true"){
				style += ";display:none;";
			}
			style = style?"style='"+style+";'":'';
			
			var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
			
			html +="<input type='hidden' id='" + id + "' name='" + name + "' value='" + getFieldValue + "' fieldType='" + fieldType + "' />";
			if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
				html+="<input type='hidden'";
			}else{
				html+="<textarea type='text' readonly ";
			}
			if(readonly || displayType != PermissionType_MODIFY){ 
				html += " disabled='disabled'";
			}
			html+=style;
			html+=" isRefreshOnChanged='" + isRefreshOnChanged + "'";
			html+=" id='" + id + "_text' class='"+cssClass+"'  filetype='userfield' fieldtype='" + fieldType + "' name='" + name + "_text' " + otherAttrsHtml;
			if(value){
				html+=" title='" + bulitTitle(value) + "'";
			}
			html+=" >" 
			if(value && textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
				html+= value;
			}	
			html+="</textarea>";
			
			if(textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
				if(!(readonly && readOnlyShowValOnly == "true")){
					var settings = "{textField:'" + id +
							"_text',valueField:'" + id +
							"',limitSum:'" + limitSum +
							"',selectMode:'" + selectMode +
							"',callback:'" + (isRefreshOnChanged?(subGridView?"dy_view_refresh(\"" + id + "\")":"dy_refresh(\"" + name + "\")"):"") + 
							"',readonly:" + readonly + "}";
					var clearStr = 'jQuery("#' + id + '_text").attr("value","");'
							+ 'jQuery("#' + id + '_text").attr("title","");'
							+ 'jQuery("#' + id + '_text").val("");'
							+ 'jQuery("#' + id + '").attr("value","");'
							+ (isRefreshOnChanged?(subGridView?'dy_view_refresh("'+ id +'")':'dy_refresh("' + name + '")'):'');
					html+="<span "
					if(!readonly){
						html += " onclick=showUserSelectNoFlow('actionName'," + settings + ",'" + roleid + "')";
					}
					
					html += " style='margin-left:5px;";
					if(!readonly){
						html += "color:#316AC5;cursor: pointer;"
					}else {
						html += "color:#ccc;cursor: not-allowed;"
					}
					html += "' title='"+selectUser+"'>" + add + " </span>";
					
					html+="<span ";
					if(!readonly){
						html += " onclick='" + clearStr + "'";
					}
					html += " style='margin-left:5px;";
					if(!readonly){
						html += "color:#316AC5;cursor: pointer;"
					}else {
						html += "color:#ccc;cursor: not-allowed;"
					}
					html += "' title='"+ clearlabel + "'> " + clearlabel + " </span>";
				}
			}
			if(displayType == PermissionType_HIDDEN){
				html += "<span>"+ hiddenValue +"</span>";
			}
			if(readonly && readOnlyShowValOnly == "true"){
				html += "<span id='" + name + "_show' class='showItem'>" + value + "</span>";
			}
			$field.after(html);
			$field.remove();
		});
	};
			
})(jQuery);

function bulitTitle(names){
	if(names != null && names != ''){
		var array = names.split(";");
		var title = '';
		for(var i = 0; i < array.length; i++){
			if(i != 0 && i%10 == 0){
				title += "\n";
			}
			title += array[i] + ";";
		}
		return title == ''?title:title.substring(0,title.length-1);
	}
	return '';
}