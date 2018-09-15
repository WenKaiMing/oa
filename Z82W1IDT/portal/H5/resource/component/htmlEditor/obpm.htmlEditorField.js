(function($){
	$.fn.obpmHtmlEditorField=function(){
		return this.each(function(){
			var $field = jQuery(this);
			 var displayType = $field.attr("displayType");
			 var text = URLDecode($field.html());
			 var style = $field.attr("style");
			 var name = $field.attr("name");
			 var hiddenValue = $field.attr("_hiddenValue");
			 var html = "";
			 var styleWidth = "100%";
			 var styleHeight;
			 var styleSub = function(str){
				 return $.trim(str).substring(0,$.trim(str).indexOf("px"));
			 }
			 
			 var styleArr = style.split(/[;]/);
			 $.each(styleArr,function(name, value){
				 var _key = $.trim(value).split(/[:]/)[0];
				 var _value = $.trim(value).split(/[:]/)[1];
				 if(_key.toLowerCase() == "height"){
					 if($.trim(_value).indexOf("%")>=0){
						 styleHeight = _value;
					 }else if($.trim(_value).indexOf("px")>=0){
						 styleHeight = styleSub(_value);
					 }
				 } 
				 if(_key.toLowerCase() == "width"){
					 if($.trim(_value).indexOf("%")>=0){
						 styleWidth = _value;
					 }else if($.trim(_value).indexOf("px")>=0){
						 styleWidth = styleSub(_value);
					 }
				 } 
			 })
			 if(displayType == PermissionType_HIDDEN){
				 html+="<textarea name='" + name + "' style='display:none;'>";
				 if(text != "null") html += text;
			 	 html+="</textarea>";
				 html += "<span>" + hiddenValue + "</span>";
				 $(html).replaceAll($field);
			 }else if(displayType != 2){
				 html+="<div style='font-size:16px;'>";
				 if(text != "null") html += text;
			 	 html+="</div>";
				 html+="<textarea name='" + name + "' style='display:none;'>";
				 if(text != "null") html += text;
			 	 html+="</textarea>";
				 $(html).replaceAll($field);
			 }else{
//				 var id = $field.attr("id");
				 id = name + "_id";
				 var content = $field.text();
				 if($("textarea[name='"+name+"']").size()>1){
					 var ue = UE.getEditor(id);
					 ue.destroy();
					 $("textarea[name='"+name+"']").filter(function(i,item){if($(item).attr("moduletype")!="htmlEditor") return true;}).remove();
				 }
				 html='<script id="'+id+'" name="'+name+'" type="text/plain"></script>';
				 
				 $(html).replaceAll($field);
				 var ue = UE.getEditor(id,{
				        'initialFrameWidth' : styleWidth,
				        'initialFrameHeight': styleHeight
				    });
				 ue.ready(function(){
					 ue.setHeight(styleHeight);
					 ue.setContent(content);
				 });
			 }
		});
	};
})(jQuery);
