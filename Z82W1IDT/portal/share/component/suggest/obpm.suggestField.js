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
			var isRefreshOnChanged = $field.attr("_isRefreshOnChanged");
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
			var isSubGridView = $field.attr("_subGridView");
			var discript = $field.attr("_discript");
			var hiddenValue = $field.attr("_hiddenValue");
			var dataMode = $field.attr("_dataMode");
			var formId = $field.attr("_formid");
			var _fieldId4sych = $field.attr("_fieldId4sych");
			var domainId = $field.attr("_domainId");

			isRefreshOnChanged = (isRefreshOnChanged == "true");
			isSubGridView = (isSubGridView == "true");
			value = value ? value : "";
			discript = discript? discript : name;
			
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			//if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				//span
				var $spanHtml = $("<div class='formfield-wrap suggestField'></div>");
	
				//text input
				if(textType.toLowerCase() != TEXT_TYPE_HIDDEN && displayType != PermissionType_HIDDEN){
					//$spanHtml.append("<label class='field-title contact-name' for='" + name + "'>" + discript + "</label>");
					var inputHtml = "<input type='text' class='form-control' GridType='suggestField' value='" + value + "' id='" + fieldId + "_show'"
						+ " name='" + name + "_show'" + "fieldtype = '" + fieldType + "'" + " autocomplete='off'"
						+ " " + getOtherProps(otherAttrs) + otherAttrsHtml;
					var htmlShow = "";

					if(displayType == PermissionType_READONLY || TEXT_TYPE_READONLY == textType.toLowerCase() 
							|| displayType == PermissionType_DISABLED){
						inputHtml += " disabled ";
					}
						
					inputHtml += " style=\"";	//style
					if(style) inputHtml += style + ";";
					inputHtml +=" z-index:97;";
					
					if(displayType == PermissionType_READONLY || TEXT_TYPE_READONLY == textType.toLowerCase() 
							|| displayType == PermissionType_DISABLED){
						if(readOnlyShowValOnly == "true"){
							inputHtml += " display:none;";
							htmlShow = "<span id='"+ fieldId +"_show1' class='showItem'>" + text + "</span>";
						}
					}
					inputHtml += "\"";
					
					inputHtml += " />";
					var $input = $(inputHtml);
					$spanHtml.append($input);
					$spanHtml.append(htmlShow);
					$input.val(text);
					if(dataMode == "local"){
						var source = eval(json) || [];
						$input.typeahead({
							source:source, 
							autoSelect: true,
							menu: '<ul class="typeahead dropdown-menu" role="listbox"></ul>',
							item: '<li><a href="#" role="option"></a></li>',
							delay: 100,
							afterSelect : function(current){
				                  if (current) {
				                      if (current.id != $("#"+fieldId).val()) {
				                    	  $("#"+fieldId).val(current.id);//设值
				                    	  if(isRefreshOnChanged){
												if(isSubGridView)
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
								var fields = Activity.makeAllFieldAble();
								var params = "";
								if(isSubGridView){//hotfix 兼容网格视图
									var _param = {
											FormID : $("#FormID").val(),
											DocumentID : $("#DocumentID").val()
									}
									params = $.param(_param);
								}else{
									params = jQuery("#document_content").serialize();
								}
								var data = params + "&__keyword="+query;
								Activity.setFieldDisabled(fields);
								$.get(url,data,function(json){
									process(eval(json));
								});
						    }, 
							autoSelect: true,
							menu: '<ul class="typeahead dropdown-menu" role="listbox"></ul>',
							item: '<li><a href="#" role="option"></a></li>',
							delay: 500,
							afterSelect : function(current){
				                  if (current) {
				                      if (current.id != $("#"+fieldId).val()) {
				                    	  $("#"+fieldId).val(current.id);//设值
				                    	  if(isRefreshOnChanged){
												if(isSubGridView)
													dy_view_refresh(fieldId + "_show");
												else
													dy_refresh(fieldId + "_show");
											}
				                      }
				                  }
							}
						}); 
					}
				}
				var discriptHtml="";
				if(displayType == PermissionType_HIDDEN){
					discriptHtml += "<span>"+ hiddenValue +"</span>";
				}
				//hidden input
				var hiddenHtml = "<input type='hidden' value='" + value + "' id='" + fieldId + "' name='" + name + "'" 
					+ "fieldtype = '" + fieldType + "'" + " GridType='suggestField' resetable=true />";
				$spanHtml.append($(hiddenHtml)).append($(discriptHtml)).replaceAll($field);
			//}
		});
	};

})(jQuery);
