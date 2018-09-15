(function($){
	$.fn.obpmSelectAboutField =function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("id");
			var name =$field.attr('name');
			var isRefreshOnChanged = $field.attr("isRefreshOnChanged");
			var displayType=$field.attr("displayType");
			var hiddenValue =  $field.attr("hiddenValue");
			var textType=$field.attr("textType");
			var value = $field.val();
			value = value?value:"";
			isRefreshOnChanged=(isRefreshOnChanged=='true');
			var html = "";
			if(displayType != PermissionType_HIDDEN){
				//刷新重计算时不重构
				if(!$field.attr("isLoaded"))
					$field.attr("isLoaded",true);
				else return;
				
				$field.bind("change",function(){
					if(isRefreshOnChanged){
						//dy_refresh(this.id);刷新方法在jquery.multiselect2side.js调用
					}
				});
				if(displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" || displayType == PermissionType_DISABLED){
					jQuery('#'+id).multiselect2side({selectedPosition: 'right',moveOptions: false,labelsx: '',labeldx: '',readOnly:true});
				}else{
					jQuery('#'+id).multiselect2side({selectedPosition: 'right',moveOptions: false,labelsx: '',labeldx: '',readOnly:false});
				}
			}else{
				html +="<input type='hidden' name='" + name + "' id='" + id + "' value='" + value + "' />";
				html +="<div>" + hiddenValue + "</div>";
				$field.after(html);
				$field.remove();
			}
		});
	};
	
})(jQuery);

//刷新方法，在jquery.multiselect2side.js调用
function callRefresh(el){
	var $field = jQuery(el);
	var isRefreshOnChanged = $field.attr("isRefreshOnChanged");
	isRefreshOnChanged=(isRefreshOnChanged=='true');
	if(isRefreshOnChanged){
		dy_refresh($field.attr("id"));
	}
}