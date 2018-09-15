/**
 * PM工具类
 * <p>封装公共组件的调用方法</p>
 * @author Happy
 */
var Utils = {
    /**
	 * 显示消息提示
	 * @param msg
	 * 		消息内容
	 * @param type
	 * 		消息类型（'info','error'）
	 * @param hideAfter
	 * 		延时几秒后关闭消息窗体
	 */
	showMessage : function(msg, type,hideAfter) {
    	if(!msg) return;
	    var type = "undefined" == typeof type ? "info": type,
	    		hideAfter = "undefined" == typeof hideAfter ? 3 : hideAfter;//默认3秒停留时间
	    $._messengerDefaults = {
	        extraClasses: "messenger-fixed messenger-on-top",
	        theme: 'flat',
	        messageDefaults: {
	            showCloseButton: true,
	            hideAfter: hideAfter
	        }
	    },
	    $.globalMessenger().post({
	        message: msg,
	        type: type
	    });
	},
};