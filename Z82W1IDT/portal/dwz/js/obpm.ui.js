(function($) {
	$.fn.obpmButton = function() {
		return this
				.each(function() {
					var $btn = jQuery(this);
					var dis = "";
					var icon = "";
					var activityType = $btn.attr("activityType");
					if($btn.attr("iconType") == "custom"){
						icon = contextPath + "/lib/icon/" + $btn.attr("icon");
					}else{
						icon = contextPath + "/portal/share/images/act/act_"
							+ $btn.attr("icon") + ".gif";
					}
					if($btn.attr("disabled") == "disabled") dis = "style = 'color:#aaa;'";
					var onclick = this.onclick;
					$btn
							.replaceWith(jQuery(
									"<div class='actBtn'> <span class='button-document' > <a name='button_act' activityType='"+activityType+"' title='"
											+ $btn.attr("value")
											+ "' " + dis + "> <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
											+ icon
											+ "' />"
											+ $btn.attr("value")
											+ " </span> </a> </span></div> ")
									.click(onclick));
				});
	};
})(jQuery);