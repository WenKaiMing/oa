(function($){
	$.fn.obpmUserfield = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var cssClass=$field.attr("class");
			var value=$field.attr("value");
			var idValues=$field.attr("_getFieldValue");
			var limitSum=$field.attr("_limitSum");
			var isRefresh=$field.attr("_isRefreshOnChanged");
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
			var layoutType = $field.attr("_layoutType");
			var discript = $field.attr("_discript");
			
			fieldType = fieldType?fieldType:'';
			cssClass = cssClass?cssClass:'';
			idValues = idValues?idValues:'';
			limitSum = limitSum?limitSum:'';
			isRefresh = (isRefresh == 'true');
			subGridView = (subGridView == 'true');
			roleid = roleid?roleid:'';
			selectUser = selectUser?selectUser:'';
			add = add?add:'';
			clearlabel = clearlabel?clearlabel:'';
			selectMode = selectMode?selectMode:'';
			displayType = displayType?displayType:'';
			textType = textType?textType:'';
			hiddenValue = hiddenValue?hiddenValue:'';
			value = value?value:'';
			discript = discript? discript : name;
			readOnlyShowValOnly = (readOnlyShowValOnly == "true");
			
			var readonly = false,
				hideText = "",
				readonly = "",
				discript = discript,
				title = bulitTitle(value),
				style = "",
				isReadOnlyShowValOnly = false,
				horizontalClass = "",
				otherAttrsHtml = getOtherAttrs($field[0]);	//其他属性
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED) {
				readonly = true;
				readonly = "readonly";
				if(readOnlyShowValOnly){
					style += ";display:none;";
					isReadOnlyShowValOnly = true;
				}
			}
			if(textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN){
				hideText = "display:none;";
			}else{	//不是隐藏状态时置空隐藏时显示值
				hiddenValue = '';
			}
			
			var data = {
				id : id,
				name : name,
				title : title,
				value : value,
				style : style,
				discript : discript,
				cssClass : cssClass,
				idValues : idValues,
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
			var $html = $(template("user-tmpl", data));
			var multiple = !(selectMode == "selectOne");
			var $selectBtn = $html.find(".select"),
				$clearBtn = $html.find(".clear");
			
			var $ub = $html.find("input.userField").userbox({
				//属性和事件回调可自定义，无自定义需求可完全不填，具体用法参考说明文档
				id : id,//必须，存放回选的用户value值的input的id
				textId : id+"_text",//必须，存放回选的用户text值的input的id
				isPhone : true,		//是否手机端
				multiple: multiple,//是否多选模式
				limitSum : limitSum,	//可选的最大用户数
				mode: 'all',//simple:精简模式|all:完整模式
				width: 'auto',//宽度
				disabled: readonly,//是否禁用
				readOnlyShowValOnly : readOnlyShowValOnly,//只读是否只显示值
				required: false,//是否必填
				selectUser : selectUser,	//已选择的用户
				selectBtn : $selectBtn,	//选择按钮
				clearBtn : $clearBtn,	//清除按钮
				separator: ';',//多选模式下的分隔符
				onSuccess : function(result, rtnValue, rtnText){
					$("#" + id).val(rtnValue);
					$("#" + (id + "_text")).val(rtnText);
					//回选已选择用户
					if(result.data.length >0){
						$("#" + (id + "_text")).attr("result",rtnText);
					}else{
						$("#" + (id + "_text")).attr("result","");
					}
					if(isRefresh){
						if(subGridView){
							dy_view_refresh(id);
						}else{
							dy_refresh(name);
						}
					}
				},
				onClear : function(){
					jQuery("#" + id).val("");
					jQuery("#" + (id + "_text")).val("");
					jQuery("#" + (id + "_text")).attr("title","");
					jQuery("#" + (id + "_text")).attr("result","");
					if(isRefresh){
						if(subGridView){
							dy_view_refresh(id);
						}else{
							dy_refresh(name);
						}
								
					}
				},
				onOpen : function(){
					showLoadingToast();
				},
				onClose : function(){
				}
			});
			$html.replaceAll($field);
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