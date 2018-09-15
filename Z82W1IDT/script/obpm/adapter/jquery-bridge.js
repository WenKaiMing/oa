var OBPM = jQuery.noConflict();
(function($) {
	// 使用portal/share/script/jquery-ui/external/jquery-framedialog.js
	//var win = window.top && window.top.OBPM ? window.top : window;
	// 弹出框
	OBPM.dialog = {
		/**
		 * 显示弹出框
		 */
		show : function(options) {
			if(!options.args)options.args = {};
			options.args.isResetSize = options.isResetSize==false?options.isResetSize:true;//窗口是否可以根据内容重置大小
			//初始化时是否最大化
			if(options.maximization == null)options.maximization = false;
			//是否支持最大化
			if(options.maximized == null){options.maximized = true;}

			var win = options.opener ? options.opener: window.top;
			win.jQuery.FrameDialog.create({
						width : options.width,
						height : options.height,
						url : options.url,
						args : options.args,
						title : options.title,
						maximization: options.maximization,//初始化时是否最大化
						maximized: options.maximized, // 是否支持最大化
						position : "center"
						//zIndex: 3000
					}).bind('dialogclose', function(event, ui) {
						if (options.close) {
							options.close(event.result);
						}
					});
		},
		/**
		 * 设置返回值并关闭窗口
		 */
		doReturn : function(result) {
			jQuery.FrameDialog.setResult(result);
			jQuery.FrameDialog.closeDialog();
		},

		doExit : function(result) {
			jQuery.FrameDialog.closeDialog();
		},

		doClear : function() {
			jQuery.FrameDialog.setResult('');
			jQuery.FrameDialog.closeDialog();
		},

		doClearUpload : function() {// 清空文件上传
			jQuery.FrameDialog.setResult('clear');
			jQuery.FrameDialog.closeDialog();
		},

		/**
		 * 获取弹出框参数
		 */
		getArgs : function() {
			return jQuery.FrameDialog.getArguments();
		},

		/**
		 * 调整弹出框高度宽度, 小于等于-1表示不更改
		 */
		resize : function(width, height) {
			var argsObj = this.getArgs();
			if(!argsObj.isResetSize) return;
			//var cWidth = window.top.document.body.scrollWidth ;
			//var cHeight = window.top.document.body.scrollHeight;
			var cWidth ;
			var cHeight ;
			if(jQuery.browser.msie){
				cWidth = window.top.document.body.offsetWidth ;
				cHeight = window.top.document.body.offsetHeight;
			}else{
				cWidth = window.top.document.body.offsetWidth ;
				cHeight = window.top.document.body.offsetHeight;
			}
			if (width <= 0 && width > (cWidth - 20)) {
				width = cWidth - 20;
			}
			if (height <= 0 || height > (cHeight - 20)) {
				height = cHeight - 20;
			}
			var left = parseInt(parseFloat(cWidth - width) / 2);
			var top = parseInt(parseFloat(cHeight - height) / 2)+$(document).scrollTop();
			jQuery.FrameDialog.resize(width, height, left, top);
		}
	};
	
	// 弹出窗口
	OBPM.owindow = {
		/**
		 * 显示弹出窗口
		 */
		show : function(options) {
			win.jQuery.window({
						width : options.width,
						height : options.height,
						url : options.url,
						args : options.args,
						title : options.title,
						onClose : function(result) {
							if (options.close) {
								options.close(result);
							}
						}
					});
		},
		/**
		 * 设置返回值并关闭窗口
		 */
		doReturn : function(result) {
			jQuery.window.setResult(result);
			jQuery.window.closeDialog();
		},

		doExit : function(result) {
			jQuery.window.closeDialog();
		},

		doClear : function() {
			jQuery.window.setResult('');
			jQuery.window.closeDialog();
		},

		doClearUpload : function() {// 清空文件上传
			jQuery.window.setResult('clear');
			jQuery.window.closeDialog();
		},

		/**
		 * 获取弹出框参数
		 */
		getArgs : function() {
			return jQuery.window.getArgs();
		}
	};
})(jQuery);