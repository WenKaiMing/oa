(function($){
	$.fn.obpmTextareaField =function(){
		return this.each(function(){
			var $field = jQuery(this);
			var id =$field.attr("_id");
			var value =$field.val();
			var name =$field.attr("_name");
			var cssClass =$field.attr("_cssClass");
			var classname =$field.attr("classname");
			var isRefreshOnChanged =$field.attr("_isRefreshOnChanged");
			var fieldType =$field.attr("_fieldType");
			var isBorderType =$field.attr("_isBorderType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var displayType = $field.attr("_displayType");
			var hiddenValue = $field.attr("_hiddenValue");
			var subGridView = $field.attr("_subGridView");
			var discript = $field.attr("_discript");
			var layoutType = $field.attr("_layoutType");
			var isReadOnly = false,
				isHide = false,
				isReadOnlyShowValOnly = false,
				placeholderTip="请输入文本",
				readonly = "",
				horizontalClass = "",
				style = "";	//宽度等样式会影响控件布局，手机端不应采用
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(isBorderType == "true" && readOnlyShowValOnly == undefined){	//旧数据兼容
				readOnlyShowValOnly = isBorderType;
			}
			
			value = value ? value : "";
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			discript = discript ? discript : name;
			
			if(displayType == PermissionType_HIDDEN){
				isHide = true;
			}
			
			if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
				placeholderTip = "";
				isReadOnly = true;
				readonly = "readonly";
				cssClass += " readCls";
				if(readOnlyShowValOnly == "true"){
					isReadOnlyShowValOnly = true;
				}
			}
			
			if(isReadOnlyShowValOnly || isHide){
				style += ";display:none;"; 
			}

			var data = {
					id : id,
					name : name,
					value : value,
					style : style,
					isHide : isHide,
					discript : discript,
					cssClass : cssClass,
					readonly : readonly,
					displayType : displayType,
					isReadOnly : isReadOnly,
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					horizontalClass : horizontalClass,
					placeholderTip : placeholderTip,
					hiddenValue : hiddenValue
			};
			
			var html = template("textarea-tmpl", data);
			var $html = $(html);
			if(isRefreshOnChanged){
				$html.find("textarea").bind("change", function(){
					if(subGridView){
						dy_view_refresh(this.id);
					}else{
						dy_refresh(this.id);
					}
				});
			}
			$html.replaceAll($field);
		});
	};
})(jQuery);