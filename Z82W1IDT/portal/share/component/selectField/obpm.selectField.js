(function($) {
	$.fn.obpmSelectField = function() {
		return this.each(function() {
			var $field = jQuery(this);
			var id = $field.attr("_id");
			var name = $field.attr("_name");
			var innerhtml = $field.children().html();
			var isRefreshOnChanged = $field.attr("_isRefreshOnChanged");
			var textType = $field.attr("_textType");
			var displayType = $field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var fieldType = $field.attr("_fieldType");
			var style =$field.attr("style");
			var subGridView = $field.attr("_subGridView");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			var hiddenValue = $field.attr("_hiddenValue");
			var onchange = $field.attr("onchange");
			var _text = "";
			
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			var html = "";
				if(onchange){
					$field.removeAttr("onchange");
					if(onchange.indexOf("'") >= 0 || onchange.indexOf('"') >= 0){
						alert("onchange值不能包含引号！");
						onchange = "";
					}
				}else{
					onchange = "";
				}
				if(subGridView){
					$field.removeAttr("subGridView");
				}
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				html += "<select ";
				html += " id='" + id + "' name='" + name + "' fieldType='" + fieldType
						+ "' "  + otherAttrsHtml;
				if (isRefreshOnChanged) {
					if(subGridView){
						onchange += ";dy_view_refresh(\"" + id + "\")";
					}else{
						onchange += ";dy_refresh(\"" + id + "\")";
					}
				}
				html += " onchange='" + onchange + "'";
				if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" 
					|| displayType == PermissionType_DISABLED ||textType.toLowerCase() == "disabled"
					|| textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN) {
					html += " disabled ";
				}
				html += " style=\"";	//style
				if(style) html += style + ";";
				if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" 
					|| displayType == PermissionType_DISABLED ||textType.toLowerCase() == "disabled") {
					if(readOnlyShowValOnly == "true"){
						html += " display:none;";
					}
				}
				if (textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN) {
					html += " display:none;";
				}
				html += "\"";
				html += ">";
				//option
				$field.find("span").each(function(){
					$option = jQuery(this);
					var isSelected = $option.attr("isSelected");
					var val = $option.attr("value");
					var text = $option.html();
					var cssClass= $option.attr("cssClass");
					isSelected = isSelected == "true"?true:false;
					val = val?val:"";
					var optHtml = "<option value=\"" + val + "\" class=\"" + cssClass + "\"";
					if(isSelected) {
						optHtml += " selected=\"true\"";
						_text = text;
					}
					optHtml += " >" + text + "</option>";
					html += optHtml;
				});
				html += "</select>";
				if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly"
					|| displayType == PermissionType_DISABLED){
					if(readOnlyShowValOnly == "true"){
						html += "<span id='" + name + "_show' >" + _text + "</span>";
					}
				}
				if(displayType == PermissionType_HIDDEN){
					html += "<span>"+ hiddenValue +"</span>";
				}
				this.parentNode.innerHTML = html;
		});
	};
})(jQuery);