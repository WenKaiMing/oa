(function($){
	$.fn.obpmCheckbox = function(){
			return this.each(function(){
				var $field = jQuery(this);
				var name = $field.attr('_name');
				var displayType = $field.attr('_displayType');
				var textType = $field.attr('_textType');
				var isRefreshOnChanged = $field.attr('_isRefreshOnChanged');
				var classname = $field.attr('classname');
				var cssClass = $field.attr('_class');
				var getLayout= $field.attr('_getLayout');
				isRefreshOnChanged = (isRefreshOnChanged == "true");
				var hiddenValue = $field.attr("_hiddenValue");
				var html="";
				//if(displayType != PermissionType_HIDDEN){
					var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
					html +="<span style='white-space: pre-wrap;'>";
					html +="<input type='checkbox' value=\"\" name='" + name + "' style='display:none' checked />";
					$field.find("span").each(function(){
						var $div = jQuery(this);
						var value = $div.attr('value');
						var text = $div.attr('text');
						var checkedListSize = $div.attr('checkedListSize');
						var isDef = $div.attr('isDef');
						var checkedListContains = $div.attr('checkedListContains');
						var divHtml="";
						divHtml +="<input type='checkbox' value=\"" + value + "\" text='" + text + "' name='" + name + "' class='"+ cssClass +"' isRefreshOnChanged='" + isRefreshOnChanged + "'";
						if(textType && textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED ||displayType == PermissionType_READONLY){
							divHtml +=" disabled='disabled'";
						}
						if(displayType == PermissionType_HIDDEN){
							divHtml += " style='display:none;'";
						}
						if(isRefreshOnChanged){
							divHtml +=" onclick='dy_refresh(this.id)'";
						}
						if(checkedListSize >0 && checkedListContains=='true' || (checkedListSize <= 0 && isDef =='true')){
							divHtml +=" checked='true'";
						}
						divHtml +=" classname='" + classname + "' " + otherAttrsHtml + "";
						divHtml +=">";
						divHtml +="<span";
						if(displayType == PermissionType_HIDDEN){
							divHtml += " style='display:none;'";
						}
						divHtml += ">" + text + "</span>";
						divHtml +="</input>";
						if(getLayout !="" && getLayout.toLowerCase() == "vertical"){
							divHtml +="<br/>";
						}
						html += divHtml;
					});
					if(displayType == PermissionType_HIDDEN){
						html += "<span>"+ hiddenValue +"</span>";
					}
					html +="</span>";
					$field.after(html);
				//}
				$field.remove();
			});
	};
	$.fn.obpmGridCheckbox = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var name =$field.attr('_name');
			var fieldType=$field.attr('_fieldType');
			var id =$field.attr('_id');
			var classname=$field.attr('classname');
			var cssClass=$field.attr('_class');
			var displayType = $field.attr('_displayType');
			var textType = $field.attr('_textType');
			var isRefreshOnChanged = $field.attr('_isRefreshOnChanged');
			var getLayout= $field.attr('_getLayout');
			isRefreshOnChanged = (isRefreshOnChanged == "true");

			var html="";
			if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				html+="<input type='checkbox' fieldType='" + fieldType + "' id='" + id + "' value='' name='" + name + "' style='display:none' checked />";
				$field.find("span").each(function(){
					var $div = jQuery(this);
					var value = $div.attr('value');
					var text = $div.attr('text');
					var checkedListSize = $div.attr('checkedListSize');
					var isDef = $div.attr('isDef');
					var checkedListContains = $div.attr('checkedListContains');
					var divHtml="";

					divHtml+="<input type='checkbox' value='" + value + "' name='" + name + "' class='" + cssClass + "'";
					divHtml+=" fieldType='" + fieldType + "' id='" + id + "' text='" + text + "'" + otherAttrsHtml;
					if(textType!=null && textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED ||displayType == PermissionType_READONLY){
						divHtml+=" disabled='disabled'";
					}
					if(isRefreshOnChanged){
						divHtml+=" onclick='dy_view_refresh(this.id)'";
					}
					if(checkedListSize >0 && checkedListContains=='true' || isDef =='true'){
						divHtml+=" checked='true'";
					}
					divHtml+=" classname='" + classname + "'";
					divHtml+=">";
					divHtml+="" + text;
					divHtml+="</input>";
					if(getLayout !="" && getLayout.toLowerCase() == "vertical"){
						divHtml +="<br/>";
					}
					html += divHtml;
				});
				$field.after(html);
			}
			$field.remove();
		});
};
})(jQuery);