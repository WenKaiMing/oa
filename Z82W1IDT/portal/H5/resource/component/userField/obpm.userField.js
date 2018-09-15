(function($){
	$.fn.obpmUserfield = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var cssClass=$field.attr("class");
			var value=$field.attr("value");
			var getFieldValue=$field.attr("_getFieldValue");
			var limitSum=$field.attr("_limitSum");
			var isRefreshOnChanged=$field.attr("_isRefreshOnChanged");
			var roleid=$field.attr("_roleid");
			var selectUser=$field.attr("_selectUser");
			var add=$field.attr("_add");
			var clearlabel=$field.attr("_clearlabel");
			var subGridView=$field.attr("_subGridView");
			var selectMode=$field.attr("_selectMode");
			var displayType=$field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType = $field.attr("_textType");
			var hiddenValue = $field.attr("_hiddenValue");
			var discript = $field.attr("_discript");
			discript = discript ? discript : name;
			var isCommonFilter = $field.attr("_isCommonFilter");
			isCommonFilter = (isCommonFilter == "true");
			var style = $field.attr("style");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}

			value = value ? value : "";
			fieldType = fieldType?fieldType:'';
			cssClass = cssClass?cssClass:'';
			value = value?value:'';
			getFieldValue = getFieldValue?getFieldValue:'';
			limitSum = limitSum?limitSum:'';
			isRefreshOnChanged = (isRefreshOnChanged == 'true');
			subGridView = (subGridView == 'true');
			roleid = roleid?roleid:'';
			selectUser = selectUser?selectUser:'';
			add = add?add:'';
			clearlabel = clearlabel?clearlabel:'';
			selectMode = selectMode?selectMode:'';
			displayType = displayType?displayType:'';
			textType = textType?textType:'';
			hiddenValue = hiddenValue?hiddenValue:'';
			//style = "style='vertical-align: bottom;WIDTH: auto;display: inherit;'";
			style = style?"style='"+style+";'":"style='vertical-align: bottom;width: auto;height: 34px;margin-right:4px; display:inline-block;'";
			
			var readonly = false;
			var controlHtml="";
			var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
			
			if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED) {
				readonly= true;
			}
			
			controlHtml +="<input type='hidden' id='" + id + "' isCommonFilter='"+isCommonFilter+"' discript='"+discript+"' name='" + name + "' value='" + getFieldValue + "' fieldType='" + fieldType + "' />";
			if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
				controlHtml+="<input class='form-control' type='hidden'";
			}else{
				controlHtml+="<textarea class='form-control' type='text' readonly ";
			}
			if(readonly){
				controlHtml += " disabled='disabled'";
			}
			controlHtml+=style;
			controlHtml+=" isRefreshOnChanged='" + isRefreshOnChanged + "'";
			controlHtml+=" id='" + id + "_text' class='"+cssClass+"'  filetype='userfield' fieldtype='" + fieldType + "' discript='"+discript+"' name='" + name + "_text' " + otherAttrsHtml;
			if(value){
				controlHtml+=" title='" + bulitTitle(value) + "'";
			}
			controlHtml+=" >"
			if(value && textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
				controlHtml+=value;
			}	
			controlHtml+="</textarea>";

			var controlBtnHtml = ""
			
			if(textType.toLowerCase() != "hidden" && displayType != PermissionType_HIDDEN){
				if(!(readonly && readOnlyShowValOnly == "true")){
					var settings = "{textField:'" + id +
							"_text',valueField:'" + id +
							"',limitSum:'" + limitSum +
							"',selectMode:'" + selectMode +
							"',callback:'" + (isRefreshOnChanged?(subGridView?"dy_view_refresh(\"" + id + "\")":"dy_refresh(\"" + name + "\")"):"") + 
							"',readonly:" + readonly + "}";
					var clearStr = 'jQuery("#' + id + '_text").val("");'
							+ 'jQuery("#' + id + '_text").attr("title","");'
							+ 'jQuery("#' + id + '").attr("value","");'
							+ (isRefreshOnChanged?(subGridView?'dy_view_refresh("'+ id +'")':'dy_refresh("' + name + '")'):'');
					
					controlBtnHtml += "<span class='btn btn-default'";

					if(!readonly){
						controlBtnHtml += " onclick=showUserSelectNoFlow('actionName'," + settings + ",'" + roleid + "')";
					}

					if(!readonly){
						controlBtnHtml += " style='margin-right:4px;'";
					}else{
						controlBtnHtml += " style='color:#ccc;cursor:not-allowed;margin-right:4px;'";
					}
					
					controlBtnHtml += " title='"+selectUser+"'>" + add + " </span>";
					
					controlBtnHtml += "<span class='btn btn-default'";

					if(!readonly){
						controlBtnHtml += " onclick='" + clearStr + "'";
					}

					if(!readonly){
						controlBtnHtml += " style='margin-right:4px;'";
					}else{
						controlBtnHtml += " style='color:#ccc;cursor:not-allowed;margin-right:4px;'";
					}
					controlBtnHtml += " title='"+ clearlabel + "'> " + clearlabel + " </span>";
				}
			}
			if(displayType == PermissionType_HIDDEN){
				controlBtnHtml += "<span>"+ hiddenValue +"</span>";
			}
			
			if(readonly && readOnlyShowValOnly == "true"){
					var controlPanel = "<span style='display:none;'>" + controlHtml + controlBtnHtml + "</span>"
						+ "<span id='" + name + "_show'>" + value + "</span>";
					$field.after(controlPanel);
			}else{
				var controlDiv = "<div style='min-width: 336px;'>" +controlHtml + controlBtnHtml + "</div>"
				$field.after(controlDiv);
			}
			$field.remove();
		});
	};
			
})(jQuery);

function bulitTitle(names){
	if(names != null && names != ''){
		var array = names.split(";");
		var title = '';
		for(var i = 0; i < array.length; i++){
			if(i != 0 && i%10 == 0){
				title += "\n";
			}
			title += array[i] + ";";
		}
		return title == ''?title:title.substring(0,title.length-1);
	}
	return '';
}