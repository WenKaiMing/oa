(function($){
	$.fn.obpmDepartmentField = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var classname=$field.attr("classname");
			var cssclass=$field.attr("class");
			var isRefreshOnChanged=$field.attr("_isRefreshOnChanged");
			var innerhtml = $field.html();
			var style=$field.attr("style");
			var displayType=$field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType=$field.attr("_textType");
			var subGridView = $field.attr("_subGridView");
			var hiddenValue = $field.attr("_hiddenValue");
			var discript = $field.attr("_discript");
			discript = discript ? discript : name;
			var isCommonFilter = $field.attr("_isCommonFilter");
			isCommonFilter = (isCommonFilter == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			var html="";
			var readonly = false;
			var isHide = false;
			if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" 
					|| displayType == PermissionType_DISABLED){
				readonly = true;
			}
			if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
				isHide = true;
			}
			
			
			//if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				html+="<select class='form-control component-select' id ='"+id+"' isCommonFilter='"+isCommonFilter+"' fieldType='"+fieldType+"'";

				if (readonly || isHide) {
					html += " disabled ";
				}
				if(isHide || (readonly && readOnlyShowValOnly == "true")){
					style += ";display:none;";
				}
				if(style) html += " style=\"" + style + ";\"";
				
				html += "' classname='"+classname+"' class='" + cssclass + "' discript='"+discript+"' name='"+name+"' ";
				html+=" isRefreshOnChanged='" + isRefreshOnChanged + "'" + otherAttrsHtml;
				
				if (isRefreshOnChanged){
					if(subGridView){
						html += " onchange='dy_view_refresh(this.id)'";
					}else{
						html += " onchange='dy_refresh(this.id)'";
					}
				}
				html+=">";
				html += "" + innerhtml;
				html += "</select>";
				if(readonly){
					if(readOnlyShowValOnly == "true"){
						html += "<span id='" + name + "_show'>" + $field.find("option:selected").text() + "</span>";
					}
				}
				if(isHide){
					html += "<span>"+ hiddenValue +"</span>";
				}
			//}
			this.parentNode.innerHTML = html;	
		});
	};
})(jQuery);