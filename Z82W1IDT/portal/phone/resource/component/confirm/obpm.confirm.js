(function($){
	/**
	 * tip : 提示文字
	 * tTitle : trueTitle-确认文字
	 * fTitle : falseTitle-取消文字
	 * tCall : trueCall-确认时执行的回调方法
	 * fCall : falseCall-取消时执行的回调方法
	 */
	$.extend({
		confirm : function(opts){
			var tip = opts.tip,
				tTitle = opts.trueTitle,
				fTitle = opts.falseTitle,
				tCall = opts.trueCall,
				fCall = opts.falseCall,
				returnVal = opts.returnVal;
			
			tip = tip ? tip : "您确认删除吗？";
			tTitle = tTitle ? tTitle : "确认";
			fTitle = fTitle ? fTitle : "取消";
			
			var $conf = $('<div class="confirmPanel" id="confirmPanel">'
						+'	<div class="header">提示</div>'
						+'	<div class="contenter">'
						+'		<p></p>'
						+'	</div>'
						+'	<div class="foot">'
						+'		<a class="btn pull-right  btn-link red btn-delete" data-ignore="push">' + tTitle + '</a>'
						+'		<a class="btn pull-right btn-link gay btn-cancel">' + fTitle + '</a>'
						+'	</div>'
						+'</div>');
			$conf.find(".contenter p").append(tip);
			//确认
			$conf.find(".btn-delete").bind("click", function(){
				var rtn = true;
				if(typeof tCall == "function"){
					if(returnVal){
						tCall($conf.find("textarea").val());
					}else{
						rtn = tCall();
					}
				}
				if(rtn != false){
					if(window.location.hash == "#popUpLayer"){
		        		history.go(-1);
		        	}
					$conf.remove();
				}
			//取消
			}).end().find(".btn-cancel").bind("click", function(){
				var rtn = true;
				if(typeof fCall == "function"){
					rtn = fCall();
				}
				if(rtn != false){
					if(window.location.hash == "#popUpLayer"){
		        		history.go(-1);
		        	}
					$conf.remove();
				}
			}).end().addClass("animated bounceIn").appendTo($("body"));
			location.hash = "#popUpLayer";
		}
	});
}(jQuery));