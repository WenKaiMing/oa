(function($) {
	$.fn.obpmButton = function() {
		return this
				.each(function() {
					var $btn = jQuery(this);
					var activityType = $btn.attr("activityType");

					//29:批量签章;43:跳转
					//嵌入视图不使用批量签章和跳转按钮
					if((activityType == "29" || activityType == "43") && typeof DisplayView == 'object' && DisplayView.getTheView(this)){
						$btn.remove();
						return;
					}
					
					if  (activityType != "5") {//当按钮类型为5（流程处理）时，不做处理，具体渲染工作交由flowprcss.jsp完成
						var dis = "";
						var icon = "";
						
						if($btn.attr("iconType") == "custom"){
							try{
								var iconJson = JSON.parse($btn.attr("icon"));
								var _type = iconJson.type;
								var _icon = iconJson.icon;
								if(_type == "img"){
									icon = "<img style='border:0px solid blue;vertical-align:middle;' src='"
										+ "../../../lib/icon/"
										+ $btn.attr("icon") + ".gif"
										+ "' /> ";
								}else if(_type == "font"){
									icon = '<i class="'+_icon+'"></i> ';
								}
							}
							catch(err){
								icon = "<img style='border:0px solid blue;vertical-align:middle;' src='"
									+ "../../../resource/imgv2/front/act/act_"
									+ $btn.attr("icon") + ".gif"
									+ "' /> ";
							}
						}else{
							icon = "<img style='border:0px solid blue;vertical-align:middle;' src='"
								+ "../../../resource/imgv2/front/act/act_"
								+ $btn.attr("icon") + ".gif"
								+ "' /> ";
						}
						if($btn.attr("disabled") == "disabled") dis = "style = 'color:#aaa;'";
						
						var autoBuildStyle = ""
						var autoBuildAttr = " autoBuild='false' "	
						if(activityType == undefined){
							autoBuildStyle = "display:none; ";
							autoBuildAttr = " autoBuild='true' "
						}
						
						var onclick = this.onclick;
						$btn
								.replaceWith(jQuery(
										"<div class='actBtn' style='"+autoBuildStyle+"' "+autoBuildAttr+"> <span class='button-document' > <a name='button_act' activityType='"+activityType+"' title='"
												+ $btn.attr("value")
												+ "' " + dis + "><span>"
												+ icon
												+ $btn.attr("value")
												+ " </span> </a> </span></div> ")
										.click(onclick));
						
					}
					
				});
	};
})(jQuery);