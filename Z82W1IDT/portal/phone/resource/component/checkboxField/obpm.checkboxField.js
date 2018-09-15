(function($){
	$.fn.obpmCheckbox = function(){
			return this.each(function(){
				var $field = jQuery(this);
				var name = $field.attr('_name');
				var displayType = $field.attr('_displayType');
				var textType = $field.attr('_textType');
				var isRefresh = $field.attr('_isRefreshOnChanged');
				var classname = $field.attr('classname');
				var cssClass = $field.attr('_class');
				var getLayout= $field.attr('_getLayout');
				var discript = $field.attr("_discript");
				var hiddenValue = $field.attr("_hiddenValue");
				var layoutType = $field.attr("_layoutType");
				var readonly = "",
					style = "",
					horizontalClass = "",
					layout = "";
				
				isRefresh = (isRefresh == "true");
				
				if(layoutType == LayoutType_Horizontal){
					horizontalClass = "isVertical";
				}
				if(displayType == PermissionType_HIDDEN){
					style = ";display:none;";
				}else{
					hiddenValue = "";
				}
				if(textType && textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED ||displayType == PermissionType_READONLY){
					readonly = "disabled";
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
						list : [],
						horizontalClass : horizontalClass,
						hiddenValue : hiddenValue
				};
				$field.find("span").each(function(i){
					var $div = jQuery(this);
					var value = $div.attr('value');
					var text = $div.attr('text');
					var checkedListSize = $div.attr('checkedListSize');
					var isDef = $div.attr('isDef');
					var checkedListContains = $div.attr('checkedListContains');
					var checked = "";
					if(checkedListSize >0 && checkedListContains=='true' || (checkedListSize <= 0 && isDef =='true')){
						checked ="checked";
					}

					var _list = {
							i : i+1,
							value : value,
							checked : checked,
							text : text
					};
					data.list.push(_list);
				});
				
				var $html = $(template("checkbox-tmpl", data));
				if(isRefresh){
					$html.find("input").bind("click",function(){
						dy_refresh(this.id);
					});
				}
				$html.replaceAll($field);
			});
	};
})(jQuery);