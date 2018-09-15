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
			var isRefresh = $field.attr("_isRefreshOnChanged");
			var name=$field.attr("_name");
			var fieldValue=$field.attr("_fieldValue");
			var title=$field.attr("_title");
			var textFieldId = fieldId + "_text";
			var valueFieldId = fieldId;
			var displayType = $field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var treeTip = $field.attr("_treeTip");
			var subGridView = $field.attr("_subGridView");
			var discript = HTMLDencode($field.attr("_discript"));
			var hiddenValue = $field.attr("_hiddenValue");
			var layoutType = $field.attr("_layoutType");
			var discript = $field.attr("_discript");

			discript = discript ? discript : name;
			isRefresh = (isRefresh == "true");
			subGridView = (subGridView == "true");

			var style = "",
				isHide = false,
				hideText = "",
				readonly = "",
				readonly1 = false,
				isReadOnlyShowValOnly = false,
				horizontalClass = "",
				otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			//文本框
			if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
				isHide = true,
				hideText = ";display:none;";
			}else{
				hiddenValue = "";
			}
			if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED || textType.toLowerCase() == "readonly"){
				readonly = "readonly";
				readonly1 = true;
				if(readOnlyShowValOnly == "true"){
					style += ";display:none;";
					isReadOnlyShowValOnly = true;
				}
			}

			var data = {
				isHide : isHide,
				hideText : hideText,
				name : name,
				style : style,
				treeTip : treeTip,
				readonly : readonly,
				discript : discript,
				isRefresh : isRefresh,
				textFieldId : textFieldId,
				valueFieldId : valueFieldId,
				cssClass : cssClass,
				fieldType : fieldType,
				fieldText : fieldText,
				fieldValue : fieldValue,
				otherAttrsHtml : otherAttrsHtml,
				isReadOnlyShowValOnly : isReadOnlyShowValOnly,
				horizontalClass : horizontalClass,
				hiddenValue : hiddenValue
			};
			
			var $html = $(template("treeDepart-tmpl", data));

			if(!isHide && !readonly1){
				$html.find("span").bind("click", function(){
					showLoadingToast();
					var settings = { textField : textFieldId,
							valueField : valueFieldId,
							limit : limit,
							callback : (isRefresh ? (subGridView ? dy_view_refresh : dy_refresh) : ""),
							readonly : readonly1
					};
					showDepartmentSelect("actionName", settings);
				});
			}
			$html.replaceAll($field);
		});
	};
})(jQuery);