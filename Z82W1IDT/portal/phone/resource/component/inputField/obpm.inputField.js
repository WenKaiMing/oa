// 当为数字控件而输入的值不是数字时，重置为上一个值
var origValue = "";
function resetWhenNonNumeric(input){
	var re = /^([\-]{1}[0-9]*|[0-9]*)\.?[0-9]*$/;
	//var re = /[^\-\d\.]/g;
	//var re = /^[\-]?[0-9]?\.?[0-9]*$/;
	//input.value = input.value.replace(re, '');

	if (input.value && !re.test(input.value)) {
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

/**
 *  当输入的内容不是数字0-9和"-,."的时候，不能输入;
 */
function isNumeric(event) {
	var keyCode = event.keyCode?event.keyCode:event.which;
	//当键盘输入的是0-9或",.-",回退键tab键的时候，允许输入
	if((keyCode >= 48 && keyCode <= 57) || (keyCode >= 44 && keyCode <= 46) || keyCode == 8 || keyCode == 9 || keyCode == 118){
		event.returnValue = true;
	}else {
		//!+"\v1"判断是不是ie浏览器
		if(!+"\v1"){
			event.returnValue = false;
		}else{
			event.preventDefault();
		}
	}
}

(function($){
	$.fn.obpmInputField =function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id  = $field.attr("_id");
			var name = $field.attr("_name");
			var value = $field.attr("value");
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
			var subGridView = $field.attr("_subGridView");
			var discript = $field.attr("_discript");
			var layoutType = $field.attr("_layoutType");
			var numberPattern = $field.attr("_numberPattern");
			var style = "",
				placeholderTip = "请输入文本",
				isReadOnly = false,
				isHide = false,
				showTel = false,
				isTel = false,
				isReadOnlyShowValOnly = false,
				type = "text",
				readonly = "",
				horizontalClass = "";
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(isBorderType == "true" && readOnlyShowValOnly == undefined){	//旧数据兼容
				readOnlyShowValOnly = isBorderType;
			}
			
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			
			if(value && value != ""){
				value = value.replace(/"/g, "&quot;") ;	//替换空格符
			}else{
				if(fieldType == "VALUE_TYPE_NUMBER"){	//数字置为0
					//value = "0";
					value = "";
					placeholderTip = "0";
				}else{	//undefined置为空字符
					value = "";
				}
			}
			
			if(!title){
				title = "";
			}else if(title != ""){
				title = title.replace(/"/g, "&quot;") ;//替换空格符
			}

			if(textType == "tel"){
				isTel = true;
			}
			if(textType == "tel" && value.length>0){
				showTel = true;
			}

			if(textType.toLowerCase() == "readonly" || displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
				placeholderTip = "",
				isReadOnly = true;
				if(readOnlyShowValOnly == "true"){
					isReadOnlyShowValOnly = true;
				}
			}

			if(displayType == PermissionType_HIDDEN || textType.toLowerCase() == "hidden"){
				isHide = true;
			}
			
			if(!(isBlank == "true") && textType.toLowerCase() == "password"){
				type = "password";
				isReadOnlyShowValOnly = false;
			}else if(displayType == PermissionType_HIDDEN || textType.toLowerCase() == "hidden" || isReadOnlyShowValOnly){
				type = "hidden";
			}else if(fieldType == "VALUE_TYPE_NUMBER"){		//类型为数字时，不能用number，否则设定格式中带","号时无法显示值
				if(numberPattern && numberPattern != ""){
					type = "number";
				}else{
					type = "text";
				}
			}else{
				type = "text";
			}
			if(isReadOnly){
				cssClass += " readCls";
				readonly = "readonly";
			}

			if(showTel){
				style += ";width: 100%; height: 32px; border: 1px solid rgba(0,0,0,.2); border-radius:3px;";
			}else if(isTel){
				style += ";background:url(../../phone/resource/main/images/tel.png) no-repeat;background-position:right center; background-size:28px 28px;";
			}
			
			var data = {
					id : id,
					name : name,
					type : type,
					isTel : isTel,
					title : title,
					value : value.replace(/(\r)*\n/g,"<br/>").replace(/\s/g,"&nbsp;"),
					placeholderTip:placeholderTip,
					style : style,
					isHide : isHide,
					isBlank : isBlank,
					showTel : showTel,
					textType : textType,
					discript : (discript ? discript : name),
					cssClass : cssClass,
					readonly : readonly,
					displayType : displayType,
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					isRefreshOnChanged : (isRefreshOnChanged + ""),
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue
			};
			
			var html = template("input-tmpl", data);
			var $html = $(html);
			//事件监听
			$html.find("input").bind("change",function(){
				if(isRefreshOnChanged){
					if(subGridView){
						dy_view_refresh(this.id);
					}else{
						dy_refresh(this.id);
					}
				}
			}).bind("keyup",function(){
				if(fieldType == "VALUE_TYPE_NUMBER"){
					resetWhenNonNumeric(this);
				}
			}).bind("keypress",function(){
				if(fieldType == "VALUE_TYPE_NUMBER"){
					isNumeric(event);
				}
			});
			$html.replaceAll($field);//.textinput();
		});
	};
})(jQuery);