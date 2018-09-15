(function($){
	$.fn.obpmPending=function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id = $field.attr("id");
			var formId = $field.attr("formId");
			var summaryCfgId = $field.attr("summaryCfgId");
			var Summary = $field.attr("Summary");
			var isread = $field.attr("isread");
			isread =(isread=="true");
			var html="";
			
			var clsName = "";
			var pngName = "";
			
			if(isread){
				clsName = "pd";
				pngName = "16x16_0700/pencil";
				alt = "己读";
			}else{
				clsName = "pdread";
				pngName = "16x16_0380/email_edit";
				alt = "未读";
			}

			html+="<a title='" + alt + "' class='" + clsName + "' href=\"javaScript:viewDoc('" + id + "', '" + formId + "','" + summaryCfgId + "')\" " +
					"style='background:url(\"../../lib/icon/" + pngName + ".png" + "\") " +
							"no-repeat;display: block;background-position: 0 50%;padding-left: 20px;margin-bottom:5px;'>";
			html+="&nbsp;" + Summary + "&nbsp;";
			html+="</a>";
			jQuery(html).replaceAll($field);
				
		});
	};
})(jQuery);