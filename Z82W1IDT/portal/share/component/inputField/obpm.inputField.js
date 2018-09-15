// 当为数字控件而输入的值不是数字时，重置为上一个值
	var origValue = "";
	function resetWhenNonNumeric(input){
		var re = /^([\-]{1}[0-9]*|[0-9]*)\.?[0-9]*$/;
		//var re = /[^\-\d\.]/g;
		//var re = /^[\-]?[0-9]?\.?[0-9]*$/;
		//input.value = input.value.replace(re, '');

		if (!re.test(input.value)) {
			for(var i =0;i<input.value.length;i++){
				var s = input.value.charAt(i);
				if(isNaN(s)){	
					break;
				}
			}
			input.value = input.value.substring(0,i);
			return false;
		} else {
			origValue = input.value;
		}
	}
	
(function($){
	$.fn.obpmInputField =function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id  = $field.attr("_id");
			var name = $field.attr("_name");
			var textType = $field.attr("_textType");
			var isBlank = $field.attr("_isBlank");
			var isBorderType = $field.attr("_isBorderType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var fieldType = $field.attr("_fieldType");
			var fieldKeyEvent = $field.attr("_fieldKeyEvent");
			var displayType = $field.attr("_displayType");
			var hiddenValue = $field.attr("_hiddenValue");
			var isRefreshOnChanged = $field.attr("_isRefreshOnChanged");
			var cssClass = $field.attr("_cssClass");
			var title = $field.attr("_title");
			var style = $field.attr("style");
			var subGridView = $field.attr("_subGridView");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			var classname = $field.attr("classname");
			var value = $field.attr("value");
			
			if(isBorderType == "true" && readOnlyShowValOnly == undefined){	//旧数据兼容
				readOnlyShowValOnly = isBorderType;
			}
			if(textType.toLowerCase() == "password"){
				readOnlyShowValOnly = false;
			}
			isBlank = (isBlank == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			subGridView = (subGridView == "true");
			var html = "";
			var htmlShow = "";
			var placeholderTip = "";
			if(displayType == PermissionType_HIDDEN || textType.toLowerCase() == "hidden"){
				html="<input type='hidden' name='" + name + "' isRefreshOnChanged='" + isRefreshOnChanged + "' id='" + id + "' value='" + value + "' /><span>"+ hiddenValue +"</span>";
				this.parentNode.innerHTML = html;
			}else{
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性

				if(value && value != ""){
					value = value.replace(/"/g, "&quot;") ;//替换空格符
				}else{
					if(fieldType == "VALUE_TYPE_NUMBER"){
						//value = "0";
						value = "";
						placeholderTip = "0";
					}
				}
				if(!title){
					title = "";
				}else if(title != "")
					title = title.replace(/"/g, "&quot;") ;//替换空格符
				
				html += "<input ";	//文本类型

				if(textType.toLowerCase() == "readonly" || displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
					html+=" readonly ";
					if(readOnlyShowValOnly == "true"){
						style += ";display:none;";
					}
				}
				if(textType == "tel"){
					style+=";background:url(../../phone/resource/main/images/tel.png) no-repeat;background-position:right center; background-size:14px 14px;";
				}
				
				html += " type=";

				if(!isBlank){
					if(textType.toLowerCase() == "password"){
						html+="\"password\"";
					}else if(textType.toLowerCase() == "hidden"){
						html+="\"hidden\"";
					}else{
						html+="\"text\"";
					}
				}else{
					html+="\"text\"";
				}
	
				html += " style=\"";	//style
				if(style) html += style + ";";
				if((textType.toLowerCase() == "readonly" || displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED)
						&& readOnlyShowValOnly == "true"){
					html += "border:0;display:none;";
					htmlShow += "<span id='"+ name +"_show' class='showItem'>" + value + "</span>";
				}
				html += "\"";
	
				html+=" id=\"" + id + "\" name=\"" + name + "\" placeholder =\"" +placeholderTip +"\" classname=\"" + classname + "\" fieldType=\"" + fieldType 
					+  "\" fieldKeyEvent=\"" + fieldKeyEvent + "\"  value=\"" + value + "\" title=\"" + title + "\"";
				html+=" isRefreshOnChanged=\"" + isRefreshOnChanged + "\"" + otherAttrsHtml;

				if(isRefreshOnChanged){
					if(subGridView){
						html += " onchange=\"dy_view_refresh(this.id)\"";
					}else{
						html += " onchange=\"dy_refresh(this.id)\"";
					}
				}
				if(fieldType == "VALUE_TYPE_NUMBER"){	// 类型为数字时
					html += " onkeyup=\"resetWhenNonNumeric(this)\"";
					html += " onkeypress=\"isNumeric(event)\""; //只能输入数字和",.-";
				}
				html += " class=\"" + cssClass + "\""; 
				if(fieldKeyEvent && fieldKeyEvent.toLowerCase() == "enterkey"){
					//html +=" enterIndex";
				}
				html+=" />";
				var spanHtml = "";
				var $spanHtml = jQuery(spanHtml);
				jQuery(this).after($spanHtml);
				$field.after(htmlShow);
				jQuery(html).bind("change",function(){
					if(isRefreshOnChanged){
						if(subGridView){
							dy_view_refresh(this.id);
						}else{
							dy_refresh(this.id);
						}
					}
				}).bind('keydown', function (e) {
	                var key = e.which;
	                if (key == 13) {
						if(fieldKeyEvent && fieldKeyEvent.toLowerCase() == "enterkey"){
							jQuery("input:text:enabled,textarea:enabled").eq((jQuery("input:text:enabled,textarea:enabled").index(this)+1)).focus(); 
						}else{	//视图选择框查询表单多个单行文本时回车无法触发提交表单
							var targetForm = $(e.target).parents("form");
							if(targetForm.attr("name") != "document_content"){
								$(e.target).parents("form").submit();
							}
						}
					}
				}).bind("keyup",function(){
					if(fieldType == "VALUE_TYPE_NUMBER"){
						resetWhenNonNumeric(this);
					}
				}).replaceAll($field);
			}
		});
	};
})(jQuery);