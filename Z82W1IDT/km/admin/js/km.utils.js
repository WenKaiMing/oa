/**
 * KM工具类
 * <p>封装公共组件的调用方法</p>
 * @author Happy
 */
var Utils = {
	//打开遮罩
	showMask : function(){
		$(".mask").fadeIn();
	},
	//隐藏遮罩
	hideMask : function(){
		$(".mask").fadeOut();
	},
	//关闭弹出层
	hidePop: function() {
        $(".popup").hide(),
        $(".mask").fadeOut();
    },
	/**
	 * 弹出窗口居中
	 */
	setPopUpCenter:function(){
		$(".popup").each(function(){
			var h = $(this).height();
			var w = $(this).width();
			$(this).css("margin-left","-"+w/2+"px").css("margin-top","-"+h/2+"px");
		});
		
	},
	/**
	 * 显示消息提示
	 * @param msg
	 * 		消息内容
	 * @param type
	 * 		消息类型（成功"success" 信息"info" 警告"warning" 错误"error"）
	 * @param hideAfter
	 * 		延时几秒后关闭消息窗体
	 */
	showMessage : function(msg, type,hideAfter) {
    	if(!msg) return;
	    var type = "undefined" == typeof type ? "info": type,
	    	hideAfter = "undefined" == typeof hideAfter ? "3000" : hideAfter;//默认3秒停留时间
	    toastr.options.closeButton = true;
	    toastr.options.progressBar = true;
	    toastr.options.timeOut = hideAfter;
	    toastr[type](msg);
	},
};