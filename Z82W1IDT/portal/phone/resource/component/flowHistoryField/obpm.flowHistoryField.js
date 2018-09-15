/**
 * 流程历史
 */
(function($){
	
	var ShowMode = {
			SHOW_MODE_TEXT : 'text',//只显示文本
			SHOW_MODE_DIAGRAM : 'diagram',//只显示图表
			SHOW_MODE_TEXT_AND_DIAGRAM : 'textAndDiagram'//显示文本与图表
	};
	
	function buildFlowHistoryTextList($field){
		//TODO html中的css样式代码抽离到css文件

		var trLists = [];
		$field.find("table tr").each(function(i){//行<tr>
			var _trList = {
					i : i,
					tdLists : []
			};
			var tdLists = [];
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
							width : $tdField.attr("width"),
							text : $tdField.text(),
							isSign : false,
							type : "",
							_data : ""
					};
					if($tdField.hasClass('attitude') && $tdField.find("span").length==1){
						var data = $tdField.find("span").data("datas");
						_tdList.isSign = true;
						_tdList.type = data['type'];
						_tdList._data = data['data'];
					}
					_trList.tdLists.push(_tdList);
				});
			}
			trLists.push(_trList);
		});
		
		return trLists;
	}
	
	
	$.fn.obpmFlowHistoryField = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var showMode = $field.attr("showMode");
			var flowDiagram = $field.attr("flowDiagram");
			var mobile = $field.attr("mobile");
			var name = $field.attr("_name");
			var discript = $field.attr("_discript");
			discript = discript? HTMLDencode(discript) : name;
			var showText = false,
				showDiagram = false,
				show = false;
			if(showMode == ShowMode.SHOW_MODE_TEXT){
				showText = true;
			}else if(showMode == ShowMode.SHOW_MODE_DIAGRAM){
				showDiagram = true;
			}else if(showMode == ShowMode.SHOW_MODE_TEXT_AND_DIAGRAM){
				showText = true;
				showDiagram = true;
			}
			if(mobile=="true"){
				show = true;
			}
			var data = {
					name : name,
					show : show,
					mobile : mobile,
					showText : showText,
					discript : discript,
					showDiagram : showDiagram,
					flowDiagram : flowDiagram,
					trLists : []
			};
			data.trLists = buildFlowHistoryTextList($field);
			var $html = $(template("history-tmpl", data));
			$field.replaceWith($html);
		});
	};
})(jQuery);

