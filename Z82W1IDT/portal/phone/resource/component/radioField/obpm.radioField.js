(function($){
	$.fn.obpmRadioField= function(){
		return this.each(function(){
			var $field = jQuery(this);
			var name =$field.attr('_name');
			var isRefresh=$field.attr('_isRefreshOnChanged');
			var classname=$field.attr('classname');
			var cssClass=$field.attr('_cssClass');
			var displayType = $field.attr("_displayType");
			var textType = $field.attr("_textType");
			var valueList = $field.attr("_valueList");
			var discript = $field.attr("_discript");
			var hiddenValue = $field.attr("_hiddenValue");
			var getLayout= $field.attr('_getLayout');
			var layoutType = $field.attr("_layoutType");
			isRefresh = (isRefresh == "true");
			
			var style = "",
				readonly = ""
				layout = "",
				horizontalClass = "",
				list = [];
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "isVertical";
			}
			if(textType && textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
				readonly = "disabled";
			}
			if(displayType == PermissionType_HIDDEN){
				style += ";display:none;";
			}else{
				hiddenValue = "";
			}
			if(getLayout !="" && getLayout.toLowerCase() == "vertical"){
				layout = "<br/>";
			}

			var data = {
					name : name,
					discript : (discript? discript : name),
					cssClass : cssClass,
					style : style,
					isRefresh : (isRefresh ? "isRefresh" : ""),
					readonly : readonly,
					layout : layout,
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue,
					list : []
			};
			$field.find("span").each(function(i){
				var $div = jQuery(this);
				var value = $div.attr('value');
				var text = $div.attr('get0ption');
				var getValue = $div.attr('getValue');
				var isDef = $div.attr('isDef');
				var checked = "";

				if((valueList && valueList.split(";")[0]==getValue)
						|| isDef == "true"){
					checked = "checked";
				}
				var _list = {
						i : i+1,
						value : value,
						checked : checked,
						text : text
				};
				data.list.push(_list);
			});
			
			var $html = $(template("radio-tmpl", data));
			if(isRefresh){
				$html.find("input").bind("click", function(){
					dy_refresh(this.id);
				});
			}
			$html.replaceAll($field);
		});
	};
})(jQuery);