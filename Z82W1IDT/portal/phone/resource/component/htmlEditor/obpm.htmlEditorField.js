(function($){
	$.fn.obpmHtmlEditorField=function(){
		return this.each(function() {
			var $field = jQuery(this);
			var displayType = $field.attr("displayType");
			var originalText = URLDecode($field.html());
			var name = $field.attr("name");
			var hiddenValue = $field.attr("_hiddenValue");
			var discript = $field.attr("discript");
			discript = discript? HTMLDencode(discript) : name;
			var style = "",
				isReadonly = false,
				readonly = "";
				html = "";
			
			var $div_text = $("<div></div>");	
			$div_text.html(originalText);
			$div_text.find("img").each(function(){
				var img_src = $(this).attr("src"); 
				if(img_src.indexOf("../../../")>-1) {
					img_src = img_src.replace("../../../","../../");
					$(this).attr("src",img_src);
				}
			});
			var text = $div_text.html();
			
			if (displayType == PermissionType_HIDDEN) {
				style = ";display:none;";
			}else{
				hiddenValue = "";
			}
			
			if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
				isReadonly = true;
				readonly = "readonly";
			}
			
			var data = {
					name : name,
					text : text,
					style : style,
					readonly : readonly,
					discript : discript,
					isReadonly : isReadonly,
					hiddenValue : hiddenValue
			};
			var $html = $(template("html-tmpl", data));
			$field.after($html);
			$field.attr("moduletype","htmlEditorSave");
			if(!isReadonly){
				var doc = $html.find("iframe")[0].contentDocument;
				doc.designMode = "On";
				doc.body.style.fontSize='16px';
				doc.body.setAttribute("_textarea",$field.attr("id"));
				$(doc).on("input",function(){
		               var _textarea_id = $(this).find("body").attr("_textarea");
		               $('#'+_textarea_id, window.parent.document).val($(this).find("body").html());
		        });
				
				if (text != "null" && text != ""){
					setTimeout(function(){
						//doc.write(text);
						doc.body.style.fontSize='16px';
						$(doc).find("body").html(text);
					},15);
				}
			}
		});
	};
})(jQuery);
