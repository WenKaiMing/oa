;
/**
 * 微信录音控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	/**
	 * 显示类型. 分别：1.只读(READONLY)2.修改(MODIFY),3.隐藏(HIDDEN),4.禁用(DISABLED)
	 */
	var DisplayType = {
			READONLY:1,//只读
			MODIFY:2,//修改
			HIDDEN:3,//隐藏
			DISABLED:4 //禁用
			

	};
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		var panel = $('<div id="weixinRecord_container_'+options.id+'"></div>');
		var content = $('<div></div>');
		
		
		content.append('<div class="formfield-wrap player-panel" style="display:none;margin-bottom:10px;position: relative;float:left;">'
				+' <div class="record-box">'
				+'  <a class="btn-sound-delete">'
				+'    <span class="icon icon-close">x</span>'
				+'  </a>'
				+'  <div class="sound-delete-box">'
				+'      <div class="header">提示</div>'
				+'      <div class="contenter"><p>确认删除当前？</p></div>'
				+'      <div class="foot">'
				+'        <a class="btn  btn-link red btn-delete" data-ignore="push">删除</a>'
				+'        <a class="btn  btn-link gay btn-cancel">取消</a>'
				+'      </div>'
				+'    </div>'
				+' </div>'
				+'</div>');
		

		if(options.value && options.value.length>0){
			var voice = JSON.parse(options.value);
			var explorer = window.navigator.userAgent ;
			//ie 
			if (explorer.indexOf("MSIE") >= 0) {
					var vioceItem = $('<div style="float:left;"><object type="application/x-shockwave-flash" data="'+contextPath+'/portal/share/component/weixinRecord/audioplayer.swf" width="300" height="36" id="'+options.id+'">'
									+'<param name="movie" value="'+contextPath+'/portal/share/component/weixinRecord/audioplayer.swf" />'
									+'<param name="FlashVars" value="soundFile='+contextPath+voice.path+'" />'
									+'<param name="quality" value="high" />'
									+'<param name="menu" value="false" />'
									+'<param name="wmode" value="transparent" /></object></div>');
			}else{
				var vioceItem = $('<audio style="width:300px;height:30px;float: left;" src="'+contextPath+voice.path+'" controls="controls"></audio>');
			}
			
			panel.append(vioceItem);
			content.find(".player-panel").show();
			if(options.displayType ==DisplayType.READONLY || options.displayType ==DisplayType.DISABLED){
				content.find(".btn-sound-delete").hide();
			}
		}else if(options.displayType ==DisplayType.MODIFY){
				content.find(".record-panel").show();
			}
			
		panel.append(content);
		panel.insertAfter(t);
		
		return panel;
	}
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var panel = t.data("weixinRecord").panel;
		
		panel.find(".btn-sound-delete").on("click",function(e){
			panel.find(".sound-delete-box").show().addClass("animated ");
		});
		panel.find(".btn-delete").on("click",function(e){
			_removeRecord(t);
		});
		panel.find(".btn-cancel").on("click",function(e){
			panel.find(".sound-delete-box").hide();
		});
		
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.name = t.attr("name");
		options.discription = HTMLDencode(t.data("discription"))? HTMLDencode(t.data("discription")):options.name;
		options.value = t.val();
		options.displayType = t.data("displayType");
		return options;
	}
	
	/**
	 * 删除录音记录
	 */
	function _removeRecord(t){
		var state = t.data("weixinRecord");
		var panel =state.panel;
		var options = state.options;
		var vf = $("#"+options.id);
		vf.val("");
		panel.find(".sound-delete-box").hide();
		panel.find(".player-panel").hide();
		panel.find(".record-panel").show();
	}
	$.fn.obpmWeixinRecord = function(options, param){
		
		return this.each(function(){
			var t = $(this);
			var state = t.data("weixinRecord");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('weixinRecord', {
					options: $.extend({}, $.fn.obpmWeixinRecord.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmWeixinRecord.defaults = {
			id:'',
			name:'',
			value:'',
			discription:'',
			displayType:null
	}
})(jQuery);
