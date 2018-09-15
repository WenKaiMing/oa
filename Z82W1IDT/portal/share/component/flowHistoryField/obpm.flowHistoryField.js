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
		var html = [];
		html.push("<table class='component-flowhistory' cellSpacing='0' cellPadding='1' width='100%' align='center' style='border:solid #cccccc;border-width:1px 0px 0px 1px;'><tbody>");
		
		$field.find("table tr").each(function(i){//行<tr>
			var $trField = jQuery(this);
			if(i==0){//列头
				html.push("<thead>");
				html.push("<tr style='line-height:40px;'>");
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					html.push("<th style='font-size: 14px;text-align:center;border:solid #cccccc;border-width:0px 1px 1px 0px;background-color:#EFF0F1;width="+$tdField.attr("width")+"' >");
					html.push($tdField.text()+"</th>");
					
				});
				html.push("</tr></thead>");
			}else{
				html.push("<tr style='line-height:22px;'>");
				$trField.children().each(function(){
					var $tdField = jQuery(this);
					//var textIndent = 30*$tdField.text().split("\\").length-1;
					html.push("<td style='font-size: 14px;border:solid #cccccc;border-width:0px 1px 1px 0px;text-align:center;'>");
					html.push("<div style='margin:0px;padding:0px;border:0px;word-wrap:break-word; word-break:break-all;white-space:pre-wrap;text-align:left;'>");
					html.push($tdField.text()? $tdField.text() : "&nbsp;");
					if($tdField.hasClass('attitude') && $tdField.find("span").length==1){
						var data = $tdField.find("span").data("datas");
						html.push("<a class='signatureImage' data-image='");
						html.push("data:" + data['type'] + "," + data['data']);
						html.push("' title='查看大图' >");
						html.push("<img height='32px' src='");
						html.push("data:" + data['type'] + "," + data['data']);
						html.push("' >");
						html.push("</a>");
					}
					html.push("</div>");
					html.push("</td>");
					
				});
				html.push("</tr>");
			}
		});
		html.push("</tbody></table>");
		
		return html.join('');
	}
	
	
	$.fn.obpmFlowHistoryField = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var showMode = $field.attr("showMode");
			var flowDiagram = $field.attr("flowDiagram");
			var html = [];
			html.push("<div style='list-style-type:none;margin-left: 3px;margin-right: 3px;margin-top: 3px;margin-bottom: 3px;'>");
			if(showMode == ShowMode.SHOW_MODE_TEXT){
				html.push("<li>"+buildFlowHistoryTextList($field)+"</li>");
			}else if(showMode == ShowMode.SHOW_MODE_DIAGRAM){
				html.push("<li><img src='"+flowDiagram+"' /></li>");
			}else if(showMode == ShowMode.SHOW_MODE_TEXT_AND_DIAGRAM){
				html.push("<li><img src='"+flowDiagram+"' /></li>");
				html.push("<li>"+buildFlowHistoryTextList($field)+"</li>");
			}
			html.push("</div>");
			var $html = $(html.join(''));
			$html.find(".signatureImage").on("click",function(){
				var $this = $(this);
				var signatureImage = $this.data("image");
				if($("body").find("#signatureImage-preview").size() <= 0){
					$("body").append("<div id='signatureImage-preview' style='position: fixed;top: 0px;bottom: 0px;left: 0px;right: 0px;z-index: 1000;'>" +
							"<div class='signatureImage-panel' style='display: table;width: 100%;height: 100%;text-align: center;'>" +
							"<div class='signatureImage-pic' style='display: table-cell;vertical-align: middle;'><img title='点击关闭' style='background: #fff;border: 3px solid #ccc'/></div>" +
							"</div>" +
							"</div>");
				}		
				var $signatureImagePreview = $("body").find("#signatureImage-preview");
				$signatureImagePreview.find("img").attr("src",signatureImage);
				$signatureImagePreview.show();
			});
			
			$("body").on("click","#signatureImage-preview",function(){
				var $this = $(this);
				$this.hide();
			});
			
			$field.replaceWith($html);
		});
	};
})(jQuery);

