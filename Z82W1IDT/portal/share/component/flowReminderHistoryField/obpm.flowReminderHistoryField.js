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
		
		var panel = $('<div id="flowReminderHistoryField_container_'+options.id+'" style="list-style-type:none;margin-left: 3px;margin-right: 3px;margin-top: 3px;margin-bottom: 3px;"></div>');
		
		var questions = options.questions;
		var displayType = options.displayType;
		//render
		$(_buildHistoryTableHTML(t)).appendTo(panel);
		t.replaceWith(panel);
		
		return panel;
	}
	
	function _buildHistoryTableHTML(t){
		var $field = $(t);
		var html = [];
		html.push("<table cellSpacing='0' cellPadding='1' width='100%' align='center' style='border:solid #cccccc;border-width:1px 0px 0px 1px;'><tbody>");
		
		$field.find("table tr").each(function(i){//行<tr>
			var $trField = jQuery(this);
			if(i==0){//列头
				html.push("<thead>");
				html.push("<tr style='line-height:22px;'>");
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					html.push("<th style='align:center;font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;background-color:#EFF0F1;width="+$tdField.attr("width")+"' >");
					html.push($tdField.text()+"</th>");
					
				});
				html.push("</tr></thead>");
			}else{
				html.push("<tr style='line-height:22px;'>");
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					html.push("<td style='font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;align:center;'>");
					html.push($tdField.text()? $tdField.text() : "&nbsp;");
					html.push("</td>");
					
				});
				html.push("</tr>");
			}
		});
		html.push("</tbody></table>");
		
		return html.join('');
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
		options.name = t.attr("name");
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
