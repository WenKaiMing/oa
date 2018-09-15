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
			var readOnlyShowValOnly =$field.attr("readOnlyShowValOnly");
			var style=$field.attr("style");
			var displayType = $field.attr("_displayType");
			var hiddenValue = $field.attr("_hiddenValue");
			var subGridView = $field.attr("_subGridView");

			if(isBorderType == "true" && readOnlyShowValOnly == undefined){	//旧数据兼容
				readOnlyShowValOnly = isBorderType;
			}
			
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			var html="";
			var height = "";
			var width = "";
			if(!style) style="";
			if(style.indexOf("height") < 0){
				height = ";height:60px;";
			}
			if(style.indexOf("width") < 0){
				width = ";width:200px;";
			}
			if(displayType == PermissionType_HIDDEN){
				html += "<textarea style='display:none' name='" + name + "'>" + value + "</textarea><span>"+ hiddenValue +"</span>";
			}else if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED) {
				if(readOnlyShowValOnly == "true"){
					html+= "<textarea class='form-control' style='display:none;' name='" + name + "'>" + value + "</textarea>";
					html += "<div id='" + name + "_show' style='" + style + ";display:inline-block;word-break: break-all;'>" + value + "</div>"
				}else{
					html+= "<textarea class='form-control' disabled name='" + name + "' style='" + style + "'>" + value + "</textarea>";					
				}
			}else{
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				html+="<textarea ";
				html+="id=\"" + id + "\" name=\""+name+"\" class=\""+cssClass+"\" classname=\""+classname+
					"\" fieldType=\""+fieldType+"\" title=\"" + value + "\"" + otherAttrsHtml;
				if(isRefreshOnChanged){
					if(subGridView){
						html += " onchange=\"dy_view_refresh(this.id)\"";
					}else{
						html += " onchange=\"dy_refresh(this.id)\"";
					}
				}
				html += " style=\"" + style + height + width;
				html += "\"";
				html+=">";
				html+=value;
				html+="</textarea>";
			}
			$field.after(html);
			$field.remove();
		});
	};
})(jQuery);