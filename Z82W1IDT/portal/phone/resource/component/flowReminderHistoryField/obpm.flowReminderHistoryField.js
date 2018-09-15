;
/**
 * 流程催办历史控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		
		var data = {
				id : options.id,
				name : options.name,
				trLists : []
		};
		data.trLists = _buildHistoryTableHTML(t);
		var $html = $(template("reminderHistory-tmpl", data));
		t.replaceWith($html);
		return $html;
	}
	
	function _buildHistoryTableHTML(t){
		var $field = $(t);
		var name = $field.data("name");
		var discript = $field.data("discription");
		discript = discript? discript : name;

		var trLists = [];
		$field.find("table tr").each(function(i){//行<tr>
			var _trList = {
					i : i,
					tdLists : []
			};
			var $trField = jQuery(this);
			if(i==0){//列头
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					var _tdList = {
							width : $tdField.attr("width"),
							text : $tdField.text()
					};
					_trList.tdLists.push(_tdList);
				});
			}else{
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					var _tdList = {
							text : $tdField.text(),
					};
					_trList.tdLists.push(_tdList);
					
				});
			}
			trLists.push(_trList);
		});
		return trLists;
	}
	
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.name = t.data("name");
		options.discription = t.data("discription");
		return options;
	}
	
	$.fn.obpmFlowReminderHistoryField = function(options, param){
		if(typeof options=="string"){
			return $.fn.obpmFlowReminderHistoryField.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("flowReminderHistoryField");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('flowReminderHistoryField', {
					options: $.extend({}, $.fn.obpmFlowReminderHistoryField.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmFlowReminderHistoryField.defaults = {
			id:'',
			name:undefined,
			discription:''
	},
	
	$.fn.obpmFlowReminderHistoryField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
			jq.each(function(){
				//nothing
			});
		}
	}
	
})(jQuery);
