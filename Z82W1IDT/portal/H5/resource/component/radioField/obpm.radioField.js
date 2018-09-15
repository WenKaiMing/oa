(function($){
	$.fn.obpmRadioField= function(){
		return this.each(function(){
			var $field = jQuery(this);
			var id = $field.attr("_id");
			var name =$field.attr('_name');
			var isRefreshOnChanged=$field.attr('_isRefreshOnChanged');
			var classname=$field.attr('classname');
			var cssClass=$field.attr('_cssClass');
			var fieldType = $field.attr("_fieldType");
			var displayType = $field.attr("_displayType");
			var textType = $field.attr("_textType");
			var valueList = $field.attr("_valueList") == "null" ? null : $field.attr("_valueList");
			var hiddenValue = $field.attr("_hiddenValue");
			var getLayout= $field.attr('_getLayout');
			var discript = $field.attr("_discript");
			discript = discript ? discript : name;
			var isCommonFilter = $field.attr("_isCommonFilter");
			isCommonFilter = (isCommonFilter == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			
			var html="<span id='" + id + "' fieldType='"+fieldType+"' data-label='" + name + "' name='span_" + name + "' discript='"+discript+"' isCommonFilter='"+isCommonFilter+"'>";
			//if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				var defvalue ="";
				$field.find("span").each(function(){
					var $div = jQuery(this);
					var value = $div.attr('value');
					var get0ption = $div.attr('get0ption');
					var getValue = $div.attr('getValue');
					var isDef = $div.attr('isDef');
					isDef = (isDef == "true");
					
					value = value ? value : "";

//					if(textType && textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
//						name += name + "$forshow" ;
//					}
					html+="<label class='radio-inline'><input text='"+get0ption+"' type='radio' id='" + id + "' value=\"" + value + "\" name='" + name + "' class='" + cssClass + "' " + otherAttrsHtml+" style='width:14px;height:14px; ";
					if(displayType == PermissionType_HIDDEN){
						html += "display:none;";
					}
					html += " '";
					if(isRefreshOnChanged){
						html+=" isRefreshOnChanged='true' onclick='dy_refresh(this.id)'";
					}
					if(textType && textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
						html+=" disabled='disabled'";
					}
					if(valueList != null && valueList != "null" ){
						if(valueList.split(";")[0]==getValue){
							defvalue = getValue;
							html+=" checked ='checked' ";
						}
					}else if(isDef){
						defvalue = getValue;
						html+=" checked ='checked' ";
					}
					html+=" classname='" + classname + "'";
					html+=">";
					html+="<span";
					if(displayType == PermissionType_HIDDEN){
						html += " style='display:none;'";
					}else{
						html += " style='display:inline-block;'";
					}
					html+=">" + get0ption + "";
					html+="</span>";
					html+="</label>";
					if(getLayout !="" && getLayout.toLowerCase() == "vertical"){
						html +="<br/>";
					}
				});
				if(displayType == PermissionType_HIDDEN){
					html += "<span>"+ hiddenValue +"</span>";
				}
				html += "</span>";
				$field.after(html);
			//}
			$field.remove();
		});
	};
	
	//网格视图
	$.fn.obpmRadioGridField= function(){
		return this.each(function(){
			var $field = jQuery(this);
			var id=$field.attr('_id');
			var name= $field.attr("_name");
			var isRefreshOnChanged=$field.attr('_isRefreshOnChanged');
			var classname=$field.attr('classname');
			var cssClass=$field.attr('_cssClass');
			var displayType = $field.attr("_displayType");
			var textType = $field.attr("_textType");
			var valueList = $field.attr("_valueList");
			var getLayout= $field.attr('_getLayout');
			
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			
			var html="";
			if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				var defvalue ="";
				$field.find("span").each(function(){
					var $div = jQuery(this);
					var value = $div.attr('value');
					var get0ption = $div.attr('get0ption');
					var getValue = $div.attr('getValue');
					var isDef = $div.attr('isDef');
					isDef = (isDef == "true");

//					if(textType && textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
//						id += id + "$forshow" ;
//					}
					html+="<input type='radio' text='" + get0ption + "' id='" + id + "' value='" + value + "' name='" + id + "' class='" + cssClass + "' " + otherAttrsHtml;
					if(isRefreshOnChanged){
						html+=" isRefreshOnChanged='true' onclick='dy_view_refresh(this.id)'";;
					}
					if(textType && textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
						html+=" disabled='disabled'";
					}
					if(valueList && getValue){
						if(valueList.split(";")[0]==getValue){
							defvalue = getValue;
							html+=" checked ='checked' ";
						}
					}else if(isDef){
						defvalue = getValue;
						html+=" checked ='checked' ";
					}
					html+=" classname='" + classname + "'";
					html+=">";
					html+="<span>";
					html+="" + get0ption + "";
					html+="</span>";
					html+="</input>";
					if(getLayout !="" && getLayout.toLowerCase() == "vertical"){
						html +="<br/>";
					}
				});
				$field.after(html);
			}
			$field.remove();
		});
	};
})(jQuery);