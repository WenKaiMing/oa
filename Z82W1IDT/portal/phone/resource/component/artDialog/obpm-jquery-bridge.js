var OBPM = top.jQuery;
(function($) {
	// 弹出框 
	OBPM.dialog = OBPM.dialog ? OBPM.dialog : {
		_allOptions: [],
		opts : {
			args:{},					//弹出层中通过args参数名传过来的参数(兼容原弹出层插件)
			content: '',				// 消息内容
			title: '',					// 标题. 默认'消息'
			button: null,				// 自定义按钮
			ok: null,					// 确定按钮回调函数
			cancel: null,				// 取消按钮回调函数
			init: null,					// 对话框初始化后执行的函数
			close: null,				// 对话框关闭前执行的函数
			okVal: '\u786E\u5B9A',		// 确定按钮文本. 默认'确定'
			cancelVal: '\u53D6\u6D88',	// 取消按钮文本. 默认'取消'
			width: '',					// 内容宽度
			height: '',					// 内容高度
			minWidth: 96,				// 最小宽度限制
			minHeight: 32,				// 最小高度限制
			padding: '20px 25px',		// 内容与边界填充距离
			skin: '',					// 皮肤名(预留接口,尚未实现)
			icon: '',					// 消息图标名称
			time: null,					// 自动关闭时间
			esc: true,					// 是否支持Esc键关闭
			focus: true,				// 是否支持对话框按钮自动聚焦
			show: true,					// 初始化后是否显示对话框
			follow: null,				// 跟随某元素(即让对话框在元素附近弹出)
			path: '',					// artDialog路径
			lock: true,					// 是否锁屏
			background: '#000',			// 遮罩颜色
			opacity: 0.5,				// 遮罩透明度
			duration: 300,				// 遮罩透明度渐变动画速度
			fixed: true,				// 是否静止定位
			left: '0%',				// X轴坐标
			top: '0%',				// Y轴坐标
			zIndex: 1987,				// 对话框叠加高度值(重要：此值不能超过浏览器最大限制)
			resize: true,				// 是否允许用户调节尺寸
			drag: true					// 是否允许用户拖动位置
		},
		/**
		 * 显示弹出框
		 */
		show : function(options) {
			if(!options.args)options.args = {};
			
			//初始化时最大化
			if(options.maximization == true){
				options.height = $(top.window).height()-50;
				options.width = $(top.window).width();
			}
			
			
			//宽度和高度值处理
			if(options.width && options.width>0){
				options.width = options.width+"";	//转成字符
				options.width = (options.width.indexOf("%")>0 && options.width.indexOf("px")>0)?options.width:(options.width+"px");
			}
			if(options.height && options.height>0){
				options.height = options.height+"";	//转成字符
				options.height = (options.width.indexOf("%")>0 && options.width.indexOf("px")>0)?options.height:(options.height+"px");
			}

			//设置args参数
			//artDialog.data("args",options.args);
			
			//打开弹出层
			//artDialog.open(options.url,options,false);
			//this.hideWord();
			var $body = $(top.document).find("body");
			var _index = $body.find(".dialog").size() + 1000 + 1;
			
			this._allOptions[_index] = options;
			
			$body.append("<div id='dlg_"+_index+"' class='modal modal-iframe dialog' style='z-index:"+_index+"'></div>")
			$body.find("#dlg_"+_index).addClass("active");
			$body.find("#dlg_"+_index).append("<header class='bar bar-nav'><span id='close' data-ignore='push' class='icon icon-left-nav pull-left'></span><h1 class='title'>"+options.title+"</h1></header>");
			
			var closeObj = document.getElementById('close');
			closeObj.addEventListener('touchend', function(event) {
				event.preventDefault();
				OBPM.dialog.doExit();
			}, false);
			
			var ts = + new Date;
			if(!options.args.url){
				var ret = options.url.replace(/([?&])_=[^&]*/, "$1_=" + ts );
					url = ret + ((ret === options.url) ? (/\?/.test(options.url) ? "&" : "?") + "_=" + ts : "");
			}else{
				var ret = options.args.url.replace(/([?&])_=[^&]*/, "$1_=" + ts );
					url = ret + ((ret === options.args.url) ? (/\?/.test(options.args.url) ? "&" : "?") + "_=" + ts : "");
			}
			$body.find("#dlg_"+_index).append("<div class='content' " +
					"style=''>" +
					"<iframe src='"+url+"' frameborder='0' allowtransparency='true' " +
							"style='position:absolute;z-index:1;top:0px;width: 100%; height: 100%; border: 0px none;'></iframe>" +
							"</div>");
			var pageYoffset = window.pageYOffset;
			
			$("#document_content").hide();
			$("#myModalexample").hide();
			$("#dlg_"+_index).find(".content").css({"position":"static","height":$(window).height()-44})
			$("#dlg_"+_index).find(".content>iframe").css({"position":"absolute","z-index":"1","top":"44px","height":$(window).height()-44})			
			
			$body.find("#dlg_"+_index).find(">div>iframe").load(function(){
				options._pageYOffset = pageYoffset;
				//window.scrollTo(0,0);
				});
			this.setHash();
		},
		/**
		 * 打开时设置hash
		 */
		setHash : function(){
			ajaxPage.addHashPostfix("popUpLayer");
		},
		/**
		 * 关闭时重置hash
		 */
		resetHash : function(){
			ajaxPage.clearHashPostfix("popUpLayer");
		},
		/**
		 * 打开弹出层时隐藏处于显示状态的word控件
		 */
		hideWord : function(){
			//嵌入表单的word控件
			jQuery("iframe[type=word]").each(function(){
				if(jQuery(this).css("display")!="none"){
					jQuery(this).attr("artDialogHide","true").css("display","none");
				}
			});
			//包含元素中嵌入的word控件
			jQuery("iframe").contents().find("iframe[type=word]").each(function(){
				if(jQuery(this).css("display")!="none"){
					jQuery(this).attr("artDialogHide","true").css("display","none");
				}
			});
			//弹出层显示的word控件中点击印章管理等弹出层时
			jQuery("#editmain_right").attr("artDialogHide","true").css("display","none");
		},
		/**
		 * 设置返回值并关闭窗口
		 */	
		doReturn : function(result) {
			var $body = $(top.document).find("body");
			var _index = $body.find(".dialog").size() + 1000;
			var _options = this._allOptions[_index] ;
			this.doExit(result);
		},

		doExit : function(result) {
			var $body = $(top.document).find("body");
			var _index = $body.find(".dialog").size() + 1000;
			var _options = this._allOptions[_index] ;

			if (_options && _options.close) {
				var fn = _options.close;					
				if (typeof fn === 'function' && fn.call(this, result) === false) {
					return;
				};
			}
			$("#document_content").show();
			$("#myModalexample").show();
			if(_options){
				window.scrollTo(0, _options._pageYOffset);
			}
			
			var $dialog_box = $body.find("#dlg_"+_index);
			$dialog_box.removeClass("active");
			$dialog_box.remove();
			this.resetHash();
		},

		doClear : function(val) {
			if(!val){
				val = "";
			}
			var $body = $(top.document).find("body");
			var _index = $body.find(".dialog").size() + 1000;
			var _options = this._allOptions[_index] ;
			if (_options && _options.close) {
				var fn = _options.close;					
				if (typeof fn === 'function' && fn.call(this, val) === false) {
					return;
				};
			}
			
			this.doExit();
		},

		//doClearUpload : function() {// 清空文件上传
		//	var winArtDialog = artDialog.getOpenApi();
		//	winArtDialog.close('clear');
		//},

		/**
		 * 获取弹出框参数
		 */
		getArgs : function() {
			var $body = $(top.document).find("body");
			var _index = $body.find(".dialog").size() + 1000;
			var _options = this._allOptions[_index] ;
			return _options.args;
		},

		/**
		 * 调整弹出框高度宽度, 小于等于-1表示不更改
		 */
		resize : function(width, height) {
		}
	};
})(jQuery);