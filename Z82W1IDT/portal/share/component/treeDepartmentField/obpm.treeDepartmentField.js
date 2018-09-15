(function($){
	$.fn.obpmTreeDepartmentField =function(){
		return this.each(function(){
			var $field =jQuery(this);
			var textType=$field.attr("_textType");
			var fieldId = $field.attr("_fieldId");
			var fieldType = $field.attr("_fieldType");
			var cssClass=$field.attr("_cssClass");
			var fieldText=$field.attr("_fieldText");
			var limit = $field.attr("_limit");
			var isRefreshOnChanged = $field.attr("_isRefreshOnChanged");
			var name=$field.attr("_name");
			var fieldValue=$field.attr("_fieldValue");
			var title=$field.attr("_title");
			var style =$field.attr("style");
			var textFieldId = fieldId + "_text";
			var valueFieldId = fieldId;
			var displayType = $field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var treeTip = $field.attr("_treeTip");
			var subGridView = $field.attr("_subGridView");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			var hiddenValue = $field.attr("_hiddenValue");
			
			var html="";
			
			var readonly = false;
			//if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				//文本框
				html += "<textarea ";
				html += " id='" + textFieldId + "'";
				html += " class='" + cssClass + "'";
				html += " fieldType='" + fieldType + "'";
				if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly"
					 || displayType == PermissionType_DISABLED){
					readonly = true;
					html += " disabled ";
				}
				html += otherAttrsHtml;
				html += " style=\"";	//style
				if(style) html += style + ";";
				if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN
						|| readonly){
					if(readOnlyShowValOnly == "true"){
						html += ";display:none;";
					}
				}
				
				html += "\"";
				html += " >" + fieldText + "</textarea>";
				
				//隐藏域
				html += "<input type='hidden' id='" +valueFieldId + "'";
				html += " name='" + name + "'";
				html += " fieldType='" + fieldType + "'";
				html += " value='" + fieldValue + "'";
				html += " />";
				if(textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
					if(!(readonly && readOnlyShowValOnly == "true")){
					//按钮
						html += "<input type='button' class='button_searchdel3'";
						var settings = "{textField:'" + textFieldId +
							"',valueField:'" + valueFieldId +
							"',limit:'" + limit +
							"',callback:" + (isRefreshOnChanged?(subGridView?"dy_view_refresh":"dy_refresh"):"''") + 
							",readonly:" + readonly + "}";
	
						if(!readonly){
							html += " onclick=\"showDepartmentSelect('actionName'," + settings + ")\"";
						}

						if(!readonly){
							html += " style='cursor: pointer;'";
						}else{
							html += " style='cursor: not-allowed;'";
						}
						html += " title='" + treeTip + "'";
						html += " />";
						
						var clearStr = 'jQuery("#' + textFieldId + '").val("");'
							+ 'jQuery("#' + textFieldId + '").attr("title","");'
							+ 'jQuery("#' + valueFieldId + '").attr("value","");'
							+ (isRefreshOnChanged?(subGridView?'dy_view_refresh("'+ valueFieldId +'")':'dy_refresh("' + name + '")'):'');
			
						html += "<input type='button' ";
						if(!readonly){
							html += " onclick='" + clearStr + "'";
						}
						if(!readonly){
							html += " style='cursor: pointer;margin-left:4px'";
						}else{
							html += " style='cursor: not-allowed;color:#ccc;margin-left:4px'";
						}
						
						html += " title='" + treeTip + "'";
						html += " value='清除'/>";
					}
				}
				if(displayType == PermissionType_HIDDEN){
					html += "<span>"+ hiddenValue +"</span>";
				}
				if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly"
					 || displayType == PermissionType_DISABLED){
					if(readOnlyShowValOnly == "true"){
						html += "<span id='" + name + "_show' class='showItem'>" + fieldText + "</span>";
					}
				}
			//}
			this.parentNode.innerHTML = html;
		});
	};
})(jQuery);