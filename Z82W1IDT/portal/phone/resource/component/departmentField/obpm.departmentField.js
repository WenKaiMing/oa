(function($){
	$.fn.obpmDepartmentField = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var classname=$field.attr("classname");
			var cssclass=$field.attr("class");
			var isRefresh=$field.attr("_isRefreshOnChanged");
			var displayType=$field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType=$field.attr("_textType");
			var subGridView = $field.attr("_subGridView");
			var hiddenValue = $field.attr("_hiddenValue");
			var layoutType = $field.attr("_layoutType");
			var discript = $field.attr("_discript");
			
			discript = discript ? discript : name;
			isRefresh = (isRefresh == "true");
			subGridView = (subGridView == "true");

			var style = "",
				hideText = "",
				readonly = "",
				horizontalClass = "",
				isReadOnlyShowValOnly = false;
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(displayType == PermissionType_HIDDEN || textType.toLowerCase() == "hidden"){
				hideText = ";display:none;";
			}else{	//不是隐藏状态时置空隐藏时显示值
				hiddenValue = '';
			}
			var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性			

			if(textType.toLowerCase() == "readonly" || displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
				readonly = "readonly";
				isReadOnlyShowValOnly = true;
				style += ";display:none;";
			}

			var data = {
					id : id,
					name : name,
					style : style,
					hideText : hideText,
					discript : discript,
					readonly : readonly,
					fieldType : fieldType,
					isRefresh : isRefresh,
					selectedText : "",
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					list : [],
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue
			}
			
			//option
			$field.find("option").each(function(){
				$opt = $(this);
				var selected = $opt.attr("selected");
				var val = $opt.attr("value");
				var cssClass= $opt.attr("class");
				var text = $opt.html();
				val = val ? val : "";
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
			
			var $html = $(template("depart-tmpl", data));

			if (isRefresh){
				$html.find("select").bind("change", function(){
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