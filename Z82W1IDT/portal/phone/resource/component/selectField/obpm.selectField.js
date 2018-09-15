(function($) {
	$.fn.obpmSelectField = function() {
		return this.each(function() {
			var $field = jQuery(this);
			var id = $field.attr("_id");
			var name = $field.attr("_name");
			var isRefresh = $field.attr("_isRefreshOnChanged");
			var textType = $field.attr("_textType");
			var displayType = $field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var fieldType = $field.attr("_fieldType");
			var subGridView = $field.attr("_subGridView");
			var discript = $field.attr("_discript");
			var hiddenValue = $field.attr("_hiddenValue");
			var onchange = $field.attr("onchange");
			var layoutType = $field.attr("_layoutType");

			isRefresh = (isRefresh == "true");
			subGridView = (subGridView == "true");
			
			var style = "",
				readonly = "",
				hideText = "",
				horizontalClass = "",
				isReadOnlyShowValOnly = false;
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" 
				||displayType == PermissionType_DISABLED ||textType.toLowerCase() == "disabled"){
				readonly = "disabled";
				if(readOnlyShowValOnly == "true"){
					style += ";display:none;";
					isReadOnlyShowValOnly = true;
				}
			}
			if (textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN) {
				hideText = ";display:none;"
			}else{	//不是隐藏状态时置空隐藏时显示值
				hiddenValue = '';
			}
			
			if(onchange){
				if(onchange.indexOf("'") >= 0 || onchange.indexOf('"') >= 0){
					console.log("onchange值不能包含引号！");
				}
			}

			var data = {
					name : name,
					selectedText : "",
					hideText : hideText,
					style : style,
					fieldType : fieldType,
					readonly : readonly,
					discript : (discript ? discript : name),
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					list : [],
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue
			};
			
			//option
			$field.find("span").each(function(){
				$option = jQuery(this);
				var selected = $option.attr("isSelected");
				var val = $option.attr("value");
				var text = $option.html();
				var cssClass= $option.attr("cssClass");
				selected = (selected == "true");
				val = val?val:"";
				if(selected){
					data.selectedText = text;
					selected = "selected";
				}
				var _list = {
						val : val,
						text : text,
						cssClass : cssClass,
						selected : selected
				};
				data.list.push(_list);
			});
			
			var $html = $(template("select-tmpl", data));
			
			if(isRefresh){
				$html.find("select").bind("change", function(){
					if(subGridView){
						dy_view_refresh(this.id);
					}else{
						dy_refresh(this.id);
					}
					try{
						eval(onchange);	//执行用户自定义的onchange方法
					}catch(ex){
						console.log("自定义change方法执行错误：" + ex);
					}
				});
			}
			$html.replaceAll($field);
		});
	};
})(jQuery);