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
			var discript = $field.attr("_discript");
			discript = discript ? discript : name;
			var isCommonFilter = $field.attr("_isCommonFilter");
			isCommonFilter = (isCommonFilter == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			var hiddenValue = $field.attr("_hiddenValue");

			fieldValue = fieldValue ? fieldValue : "";
			style = style ? style : "vertical-align: bottom;width: auto;height: 34px;display: inherit;margin-right:4px;";
			
			var html="";
			var readonly = false;
			//if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				//文本框				
				html += "<textarea disabled ";
				html += " id='" + textFieldId + "'";
				html += " name='show_" + name + "'";
				html += " discript='"+discript+"'";
				html += " class='form-control " + cssClass + "'";
				html += " isCommonFilter='"+isCommonFilter+"'";//是否常用搜索
				html += " fieldType='" + fieldType + "'";
				html += otherAttrsHtml;
				if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
					style += ";display:none;";
				}
				if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly"
							 || displayType == PermissionType_DISABLED){
					readonly = true;
					if(readOnlyShowValOnly == "true"){
						style += ";display:none;";
					}
				}

				if(style) html += " style='" + style + "' ";
				html += " >" + fieldText + "</textarea>";
				
				//隐藏域
				html += "<input type='hidden' id='" +valueFieldId + "'";
				html += " name='" + name + "'";
				html += " discript='"+discript+"'";
				html += " fieldType='" + fieldType + "'";
				html += " value='" + fieldValue + "'";
				html += " />";
				//按钮
				if(textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
					if(!(readonly && readOnlyShowValOnly == "true")){
						
						html += "<span class='btn btn-default'";
						var settings = "{textField:'" + textFieldId +
							"',valueField:'" + valueFieldId +
							"',limit:'" + limit +
							"',callback:" + (isRefreshOnChanged?(subGridView?"dy_view_refresh":"dy_refresh"):"''") + 
							",readonly:" + readonly + "}";
						
						var clearStr = 'jQuery("#' + textFieldId + '").val("");'
							+ 'jQuery("#' + textFieldId + '").attr("title","");'
							+ 'jQuery("#' + valueFieldId + '").attr("value","");'
							+ (isRefreshOnChanged?(subGridView?'dy_view_refresh("'+ valueFieldId +'")':'dy_refresh("' + name + '")'):'');
						if(!readonly){
							html += " onclick=\"showDepartmentSelect('actionName'," + settings + ")\"";
							html += " style='cursor: pointer;margin-right:4px;'";
						}else{
							html += " style='cursor: not-allowed;color:#ccc;margin-right:4px;'";
						}
						html += " title='" + treeTip + "'";
						html += " >添加</span>"
						html += "<span class='btn btn-default'";

						if(!readonly){
							html += " onclick='" + clearStr + "'";
							html += " style='cursor: pointer;margin-right:4px;'";
						}else{
							html += " style='cursor: not-allowed;color:#ccc;margin-right:4px;'";
						}
						html += " title='清除'> 清除 </span>";
					}
				}
				if(readonly){
					if(readOnlyShowValOnly == "true"){
						html += "<span id='" + name + "_show'>" + fieldText + "</span>";
					}
				}
				if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
					html += "<span>"+ hiddenValue +"</span>";
				}
			//}
			this.parentNode.innerHTML = html;
		});
	};
})(jQuery);