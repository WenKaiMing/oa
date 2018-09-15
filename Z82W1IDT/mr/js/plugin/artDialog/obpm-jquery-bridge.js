var OBPM = jQuery;
(function($) {
	// 弹出框
	OBPM.dialog = {
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
			fixed: false,				// 是否静止定位
			left: '50%',				// X轴坐标
			top: '38.2%',				// Y轴坐标
			zIndex: 1987,				// 对话框叠加高度值(重要：此值不能超过浏览器最大限制)
			resize: true,				// 是否允许用户调节尺寸
			drag: true					// 是否允许用户拖动位置
		},
		/**
		 * 显示弹出框
		 */
		show : function(options) {
			if(!options.args)options.args = {};
			//宽度和高度值处理
			if(options.width && options.width>0){
				options.width = options.width+"";	//转成字符
				options.width = (options.width.indexOf("%")>0 && options.width.indexOf("px")>0)?options.width:(options.width+"px");
			}
			if(options.height && options.height>0){
				options.height = options.height+"";	//转成字符
				options.height = (options.width.indexOf("%")>0 && options.width.indexOf("px")>0)?options.height:(options.height+"px");
			}

			//增加参数
			for (var i in options) {
				this.opts[i] = options[i];
				if(i=='isResetSize'){
					this.opts.resize = options[i];
				}
			};
			
			//设置回调函数
			if (options.close) {
				this.opts.close = options.close;
			}
			//设置args参数
			artDialog.data("args",this.opts.args);

			//打开弹出层
			artDialog.open(this.opts.url,this.opts,false);
		},
		/**
		 * 设置返回值并关闭窗口
		 */
		doReturn : function(result) {
			var winArtDialog = artDialog.getOpenApi();
			winArtDialog.close(result);
		},

		doExit : function(result) {
			var winArtDialog = artDialog.getOpenApi();
			winArtDialog.close();
		},

		doClear : function() {
			var winArtDialog = artDialog.getOpenApi();
			winArtDialog.close('');
		},

		doClearUpload : function() {// 清空文件上传
			var winArtDialog = artDialog.getOpenApi();
			winArtDialog.close('clear');
		},

		/**
		 * 获取弹出框参数
		 */
		getArgs : function() {
			return artDialog.data("args");
		},

		/**
		 * 调整弹出框高度宽度, 小于等于-1表示不更改
		 */
		resize : function(width, height) {
			var winArtDialog = artDialog.getOpenApi();
			if(winArtDialog){
				var resize = winArtDialog.config.resize;
				if(!resize) return;
				var winH = top.window.document.body.clientHeight;
				if((winH-50) < height) height = winH-50;
				winArtDialog.size(width,height);
				winArtDialog._winResize();
			}
		}
	};
})(jQuery);