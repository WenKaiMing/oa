(function($) {
	$.fn.obpmSuggestField = function() {
		return this.each(function(i) {
			var TEXT_TYPE_HIDDEN = "hidden",
				TEXT_TYPE_READONLY = "readonly",
				TEXT_TYPE_TEXT = "text",
				TEXT_TYPE_PASSWORD = "password";
			
			var $field = jQuery(this);
			var fieldId = $field.attr("_fieldId");
			var name = $field.attr("_name");
			var isRefresh = $field.attr("_isRefreshOnChanged");
			var displayType = $field.attr("_displayType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType = $field.attr("_textType");
			var value = $field.attr("value");
			var text = $field.attr("text");
			if(text == "" || text == null){
				text = value;
			}
			var json = $field.attr("_json")? $field.attr("_json") : '{}';
			var otherAttrs = $field.attr("_otherAttrs");
			var style=$field.attr("style");
			var fieldType = $field.attr("_fieldType");
			var fieldId2 = fieldId.replace(/\-/g, "_");
			var subGridView = $field.attr("_subGridView");
			var discript = $field.attr("_discript");
			var hiddenValue = $field.attr("_hiddenValue");
			var dataMode = $field.attr("_dataMode");
			var formId = $field.attr("_formid");
			var _fieldId4sych = $field.attr("_fieldId4sych");
			var domainId = $field.attr("_domainId");
			var layoutType = $field.attr("_layoutType");
			
			isRefresh = (isRefresh == "true");
			subGridView = (subGridView == "true");
			value = value ? value : "";
			discript = discript? HTMLDencode(discript) : name;
			var style = "z-index:97;",
				hideText = "",
				readonly = "",
				horizontalClass = "",
				isReadOnlyShowValOnly = false;
			
			var otherAttrsHtml = getOtherProps(otherAttrs) + " " + getOtherAttrs($field[0]);	//其他属性
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(textType.toLowerCase() == TEXT_TYPE_HIDDEN || displayType == PermissionType_HIDDEN){
				hideText =  "display:none;";
			}else{	//不是隐藏状态时置空隐藏时显示值
				hiddenValue = '';
			}

			if(displayType == PermissionType_READONLY || TEXT_TYPE_READONLY == textType.toLowerCase() 
					|| displayType == PermissionType_DISABLED){
				readonly = true;
				readonly = "readonly";
				if(readOnlyShowValOnly){
					style += ";display:none;";
					isReadOnlyShowValOnly = true;
				}
			}
			
			var data = {
					id : fieldId,
					name : name,
					text : text,
					value : value,
					style : style,
					discript : discript,
					hideText : hideText,
					readonly : readonly,
					isRefresh : isRefresh,
					fieldType : fieldType,
					subGridView : subGridView,
					otherAttrsHtml : otherAttrsHtml,
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue
			};
			var $html = $(template("suggest-tmpl", data));
			var $input = $html.find("input[type=text]");
			if(dataMode == "local"){
				var source = eval(json) || [];
				$input.typeahead({
					source:source, 
					autoSelect: true,
					menu: '<ul class="typeahead dropdown-menu" style="width:95%" role="listbox"></ul>',
					item: '<li><a href="#" role="option"></a></li>',
					delay: 100,
					afterSelect : function(current){
		                  if (current) {
		                      if (current.id != $("#"+fieldId).val()) {
		                    	  $("#"+fieldId).val(current.id);//设值
		                    	  if(isRefresh){
										if(subGridView)
											dy_view_refresh(fieldId + "_show");
										else
											dy_refresh(fieldId + "_show");
									}
		                      }
		                  }
					}
				}); 
			}else if(dataMode == "remote"){
				var url = contextPath + "/portal/document/suggestfield/query?_formFieldId="+_fieldId4sych;
				$input.typeahead({
					source:function(query,process) {
						var data = ajaxPage.getParams()+"&__keyword="+query;
						$.post(url,data,function(json){
							process(eval(json));
						});
				    }, 
					autoSelect: true,
					menu: '<ul class="typeahead dropdown-menu" style="width:95%" role="listbox"></ul>',
					item: '<li><a href="#" role="option"></a></li>',
					delay: 500,
					afterSelect : function(current){
		                  if (current) {
		                      if (current.id != $("#"+fieldId).val()) {
		                    	  $("#"+fieldId).val(current.id);//设值
		                    	  if(isRefresh){
										if(subGridView)
											dy_view_refresh(fieldId + "_show");
										else
											dy_refresh(fieldId + "_show");
									}
		                      }
		                  }
					}
				}); 
			}
			$html.replaceAll($field);
		});
	};

})(jQuery);
