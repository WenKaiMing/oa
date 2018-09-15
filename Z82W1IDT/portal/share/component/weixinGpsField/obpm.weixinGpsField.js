;
/**
 * 微信gps位置控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	function markerLocation(t){
		var options = _parseOptions(t);
		var location = $.parseJSON(t.val());
		var address = location.address;
		var $weixinGPSField = $('#weixingpsfield_map_container_'+options.id);
		$weixinGPSField.find(".gps_address").html(address);
	}
	
	
	
	/**
	 * gps控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		
		var v = t.val();
		var panle;
		if(v.length<=0){//值为空，且可编辑状态下
			panel = $('<div style="height: 128px;width: 128px;background:url(../../share/component/weixinGpsField/gps.png) 0 0 no-repeat;"></div>');
			panel.insertAfter(t);
		}else{
			panel = $('<div id="weixingpsfield_map_container_'+options.id+'" style="width: 128px;text-align: center;">'
					+'<div><img src="../../share/component/weixinGpsField/gps_ok.png"></div>'
					+'<div class="gps_address"></div>'
					+'</div>');
			panel.insertAfter(t);
			markerLocation(t);
		}
		return panel;
	}
	
	/**
	* 弹出层显示地图详情
	**/
	function showAddressMap(t) {
		var url = contextPath + '/portal/share/component/weixinGpsField/view.jsp';
		OBPM.dialog.show({
			width: 682,
			height: 500,
			url: url,
			args: {
				"location" : JSON.parse(t.val())
			},
			title: "地图"
		});
	}
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var panel = t.data("weixinGpsField").panel;		
		panel.on("click",function(e){
			e.preventDefault();
			e.stopPropagation();
			showAddressMap(t);
		});
	}
	
	/**
	 * 解析gps控件设置参数
	 */
	function _parseOptions(t){
		var options = {}
		options.id = t.attr("id");
		options.name = t.attr("name");
		options.displayType = t.attr("displayType");
		return options;
	}
	
	$.fn.obpmWeixinGpsField = function(options, param){
		
		if(typeof options=="string"){
			return $.fn.obpmWeixinGpsField.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("weixinGpsField");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('weixinGpsField', {
					options: $.extend({}, $.fn.obpmWeixinGpsField.defaults, _parseOptions(t), options),
					panel: r
				});
				
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmWeixinGpsField.defaults = {
			id:'',
			name:undefined
	},
	
	$.fn.obpmWeixinGpsField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
		}
	}
	
})(jQuery);
