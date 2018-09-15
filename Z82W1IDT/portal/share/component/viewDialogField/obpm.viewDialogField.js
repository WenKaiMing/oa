(function($){
	$.fn.obpmViewDialog =function(){
		return this.each(function(){
			var $field =jQuery(this);
			var name=$field.attr("name");
			var allow = $field.attr("allow");
			var mutil = $field.attr("mutil");
			var selectOne=$field.attr("selectOne");
			var parentid=$field.attr("parentid");
			var clsName = $field.attr("clsName");
			var formid = $field.attr("formid");
			var fieldid=$field.attr("fieldid");
			var isEdit=$field.attr("isEdit");
			var viewTitle=$field.attr("viewTitle");
			var dialogView=$field.attr("dialogView");
			var mapping=$field.attr("mapping");
			var openType=$field.attr("openType");
			var viewType=$field.attr("viewType");
			var divWidth=$field.attr("divWidth");
			var divHeight=$field.attr("divHeight");
			var isMaximization=$field.attr("isMaximization");
			var isRefreshOnChanged=$field.attr("isRefreshOnChanged");
			var caption=$field.attr("caption");
			var isDisable=$field.attr("isDisable");
			
			isDisable = (isDisable == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			isMaximization = (isMaximization == "true");
			selectOne = (selectOne == "true");
			mutil = (mutil == "true");
			isEdit = (isEdit == "true");
			
			var html="<input type=";
				html+="'button'";
			
			if(caption && caption.replace(/(^\s*)|(\s*$)/g, "").length > 0)
				html+=" value='" + caption + "'";
			else
				html+=" value='...'";
				
			if (isDisable || !isEdit) {
				html+=" disabled='disabled'";
			}
			
			html+=" />";
			$(html).bind("click",function(){
				ViewHelper.convertValuesMapToPage(dy_getValuesMap(),function(text){
					var params= {
							allow:allow,
							mutil:mutil,
							selectOne:selectOne,
							parentid:parentid,
							className:clsName,
							formid:formid,
							fieldid:fieldid,
							isEdit:isEdit
					};
					var url = contextPath + '/portal/share/dynaform/view/dialogTemp.jsp';
					url += '?_viewid=' + dialogView;
					url += '&datetime=' + new Date().getTime();
					url += '&' + jQuery.param(params,true);
					if(divWidth == null || divWidth == "" && isMaximization == false){
						url += '&_defaultSize=true';//后台显示大小为默认时，允许页面根据内容设置弹出层大小
					}
					var width = 640;
					var height = 400;
					if(divWidth != "" && divWidth.length > 0){
						width = divWidth;
					}
					if(divHeight != "" && divHeight.length > 0){
						height = divHeight;
					}
					OBPM.dialog.show({
								width : width, // 默认宽度
								height : height, // 默认高度
								url : url,
								args : {'html': new String(text), 'parent': window},
								maximization: isMaximization,
								maximized: true, // 是否支持最大化
								title : viewTitle,
								close : function(result) {
									//执行确定回调脚本
									if(!result) return;
									DWREngine.setAsync(false);
									var arr = jQuery("#document_content").serializeArray();
									var _params=new Object;  
						            $.each(arr,function(k,v){  
						            	_params[v.name]=v.value;  
						            });
						            _params = $.extend(_params,result.params? result.params:{});
						            _params["selectedValue"] = result.selectedValue ? result.selectedValue:"";
									ViewHelper.runViewDialogCallbackscript(_params,function(value){});
									DWREngine.setAsync(true);
									//映射字段
									var rtn = result.selectedValue;
									if(params.selectOne=="false"|| params.selectOne==false){
										getDialogValue(mapping, rtn);
									}else{
										getDialogSelectValue(mapping, rtn);
									}
									if(isRefreshOnChanged) {
										//刷新表单
										dy_refresh(name)
										};
								}
							});
				});
			}).replaceAll($field);
		});
	};
	
})(jQuery);