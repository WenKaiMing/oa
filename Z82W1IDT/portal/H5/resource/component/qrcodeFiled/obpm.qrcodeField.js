;
/**
 * 二维码控件
 * @author Happy
 * @param $
 */
(function($){
	
	/**
	 * 扫码结果处理类型
	 */
	var HandleType={
			HANDLE_TYPE_TEXT : "text",//显示值
			HANDLE_TYPE_LINK : "link",//打开链接
			HANDLE_TYPE_CALLBACK_EVENT : "callback_event"//执行扫码事件回调脚本
	};
	
	
	/**
	 * 控件初始化
	 */
	function _init(t,options){
		var panel = $('<div id="qrcode_container_'+options.id+'"></div>');
		
		var text = "";
		
		switch (options.handleType) {
		case HandleType.HANDLE_TYPE_TEXT:
			text = options.value;
			break;
		case HandleType.HANDLE_TYPE_LINK:
		case HandleType.HANDLE_TYPE_CALLBACK_EVENT:
			var formId = $("input[name='formid']").val();
			if($("input[name='_templateForm']").val().length>0){
				formId = $("input[name='_templateForm']").val();
			}
			var domainId = $("input[name='domain']").val();
			var docId = $("input[name='content.id']").val();
			var fieldId = options.fieldId;
			var applicationId = $("input[name='application']").val();
			var host = options.serverHost.length==0? window.location.protocol+"//"+window.location.host+contextPath : options.serverHost;
			text = host+"/portal/document/qrcodefield/ready?domainId="+domainId+"&formId="+formId+"&docId="+docId+"&fieldId="+fieldId+"&applicationId="+applicationId+"&_randomCode="+options.randomCode;
			break;
		default:
			break;
		}
		
		var opt = {
			    // render method: 'canvas', 'image' or 'div'
			    render: 'canvas',
			    // version range somewhere in 1 .. 40
			    minVersion: 1,
			    maxVersion: 40,
			    // error correction level: 'L', 'M', 'Q' or 'H'
			    ecLevel: 'L',
			    // offset in pixel if drawn onto existing canvas
			    left: 0,
			    top: 0,
			    // size in pixel
			    size: options.size,
			    // code color or image element
			    fill: '#000',
			    // background color or image element, null for transparent background
			    background: null,
			    // content
			    text: text,
			    // corner radius relative to module width: 0.0 .. 0.5
			    radius: 0,
			    // quiet zone in modules
			    quiet: 0,
			    // modes
			    // 0: normal
			    // 1: label strip
			    // 2: label box
			    // 3: image strip
			    // 4: image box
			    mode: 0,
			    mSize: 0.1,
			    mPosX: 0.5,
			    mPosY: 0.5,
			    label: 'no label',
			    fontname: 'sans',
			    fontcolor: '#000',
			    image: null
			};
		panel.insertAfter(t);
		panel.qrcode(opt);
		
		return panel;
	}
	
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var options = t.data("qrcode").options;
		if(options.handleType==HandleType.HANDLE_TYPE_CALLBACK_EVENT){
			_refreshOnCallback(t);
		}
	}
	
	function _refreshOnCallback(t){
		var options = t.data("qrcode").options;
		var docId = $("input[name='content.id']").val();
		var tid = window.setInterval(function(){
			$.get(contextPath + '/portal/document/qrcodefield/handle?action=track&_randomCode='+options.randomCode, function(data){
				  if(data=="success"){
					  window.clearInterval(tid);
					  Activity.refreshForm();
				  }
				});
		}, 5*1000);
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.fieldId = t.data("fieldId");
		options.handleType= t.data("handleType");
		options.serverHost = t.data("serverHost");
		options.name = t.attr("name");
		options.discription = HTMLDencode(t.data("discription"))? HTMLDencode(t.data("discription")):options.name;
		options.value = t.val();
		options.refreshOnChanged = (t.data("refreshOnChanged") ? (t.data("refreshOnChanged") == 'true' || t.data("refreshOnChanged") == true) : undefined),
		options.displayType = t.data("displayType");
		options.size = t.data("size");
		
		var uuid = "";
		var len = 16;
		var chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
		var maxPos = chars.length;
		for (i = 0;i<len;i++){
			uuid+=chars.charAt(Math.floor(Math.random()*maxPos));
		}
		options.randomCode = uuid;
		return options;
	}
	
	$.fn.obpmQRCodeField = function(_options, param){
		
		if(typeof _options=="string"){
			return $.fn.obpmQRCodeField.method[_options](this,param);
		}
		return this.each(function(){
			var options = _options || {};
			var t = $(this);
			var state = t.data("qrcode");
			if(state){
				$.extend(state.options,options);
			}else{
				options = $.extend({}, $.fn.obpmQRCodeField.defaults, _parseOptions(t), options);
				var r =_init(t,options);
				state = t.data('qrcode', {
					options: options,
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	/**
	 * 定义二维码控件默认值
	 */
	$.fn.obpmQRCodeField.defaults = {
			id:'',
			fieldId:'',
			handleType:HandleType.HANDLE_TYPE_TEXT,
			serverHost:'',
			name:'',
			value:'',
			refreshOnChanged:false,
			discription:'',
			displayType:null
	},
	/**
	 * 定义二维码控件方法
	 */
	$.fn.obpmQRCodeField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
			jq.each(function(){
				//nothing
			});
		}
	}
	
})(jQuery);
