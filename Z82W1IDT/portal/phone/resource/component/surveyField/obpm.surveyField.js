;
/**
 * 调查问卷控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		
		var v = t.val();
		var questions = options.questions;
		var displayType = options.displayType;
		var disabled = (displayType==4 || displayType==1) ? "disabled" : ""; //只读?
		var data = {
				id : options.id,
				disabled : disabled,
				list : []
			};
		//问题
		for(i in questions){
			var question = questions[i];
			var ques = {
				id : question.id,
				topic : question.topic,
				subList : []
			};

			//问题选项
			for(i in question.options){
				var opt = question.options[i];
				opt.tagName = "input";
				opt.i = i;
				
				if(opt.type == "textarea"){
					opt.tagName = "textarea";
				}
				ques.subList.push(opt);
			}
			data.list.push(ques);
		}
		var $panel = $(template("survey-tmpl", data));
		
		$panel.insertAfter(t);
		return $panel;
	}
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		//var panel = t.data("surveyField").panel;
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.name = t.attr("name");
		options.displayType = t.data("displayType");
		options.discription = t.data("discription");
		options.questions = t.data("questions");
		return options;
	}
	
	/**
	 * 获取答案
	 */
	function _getValue(jq){
		var values =[];
		var state = jq.data("surveyField");
		var options = state.options;
		var panel = state.panel;
		
		var questions = options.questions;
		
		for(i in  questions){
			var question = questions[i];
			var value = {
				question:question.id,
				answers :[]
			}
			
			panel.find("input[name='question-"+question.id+"-answer']:checked").each(function(index){
				var $t = $(this);
				var type = $t.data("type");
				var custom = $t.data("custom");
				var text = $t.data("text");
				var v = custom? $t.parent().find("input[name='"+$t.attr("name")+"-value']").val() :$t.val();
				/**
				switch (type) {
				case "checkbox":
				case "radio":
					
					break;
				default:
					break;
				}
				**/
				var answer ={
						type :type,
						custom :custom,
						text:text,
						value:v
				}
				value.answers.push(answer);
			});
			
			values.push(value);
		}
		jq.val(JSON.stringify(values));
		return values;
		
	}
	
	function _setValue(jq,v){
		if(typeof v == "string" && v.length>0){
			v = $.parseJSON(v);
		}
		var values = v || [];
		var state = jq.data("surveyField");
		var options = state.options;
		var panel = state.panel;
		
		var questions = options.questions;
		
		for(i in  values){
			var value = values[i];
			var questionId = value.question;
			var answers = value.answers;
			
			panel.find("input[name='question-"+questionId+"-answer']").each(function(index){
				var $t = $(this);
				for(k in answers){
					var answer = answers[k];
					if(!answer.custom && answer.value==$t.val()){
						$t.attr("checked",'true');
						break;
					}
					if(answer.custom && $t.data("custom") && answer.text==$t.data("text")){
						$t.attr("checked",'true');
						$t.parent().find("input[name='"+$t.attr("name")+"-value']").val(answer.value);
						break;
					}
				}
			});
		}
	}
	
	$.fn.obpmSurveyField = function(options, param){
		
		if(typeof options=="string"){
			return $.fn.obpmSurveyField.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("surveyField");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('surveyField', {
					options: $.extend({}, $.fn.obpmSurveyField.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
				_setValue(t,t.val());
			}
		});
	},
	
	$.fn.obpmSurveyField.defaults = {
			id:'',
			name:undefined,
			displayType:2,
			discription:'',
			questions:[]
	},
	
	$.fn.obpmSurveyField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
			jq.each(function(){
				_getValue($(this));
			});
		}
	}
	
})(jQuery);
