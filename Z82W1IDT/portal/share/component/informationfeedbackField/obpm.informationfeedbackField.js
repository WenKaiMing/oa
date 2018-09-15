/**
 * 信息反馈控件
 * @author jodg
 */
(function($){
	
	/**
	 * 是否显示提示语
	 */
	var tipShow = true;
	
	/**
	 * json对象转string
	 */
	function stringifyJSON(O) { 
	       //return JSON.stringify(jsonobj); 
	       var S = []; 
	       var J = ""; 
	       if (Object.prototype.toString.apply(O) === '[object Array]') { 
	           for (var i = 0; i < O.length; i++) 
	               S.push(stringifyJSON(O[i])); 
	           J = '[' + S.join(',') + ']'; 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object Date]') { 
	           J = "new Date(" + O.getTime() + ")"; 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object RegExp]' || Object.prototype.toString.apply(O) === '[object Function]') { 
	           J = O.toString(); 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object Object]') { 
	           for (var i in O) { 
	               O[i] = typeof (O[i]) == 'string' ? '"' + O[i] + '"' : (typeof (O[i]) === 'object' ? stringifyJSON(O[i]) : O[i]); 
	               S.push('"' + i + '":' + O[i]); 
	           } 
	           J = '{' + S.join(',') + '}'; 
	       } 

	       return J; 
	}; 

	
	/**
	 * 打开反馈窗口
	 */
	function openFeedback(feedbackFieldName) {
		var docid = $("input[name='content.id']").val();
		var formid = $("input[name='formid']").val();
		var applicationid = $("input[name='application']").val();
		var url = contextPath + "/portal/share/component/informationfeedbackField/informationfeedback.jsp";
		url += "?docid=" + docid;
		url += "&formid=" + formid;
		url += "&fieldname=" + feedbackFieldName;
		url += "&applicationid=" + applicationid;
		OBPM.dialog.show({
			width : 700,
			height : 370,
			url : url,
			isResetSize : false,
			args : {},
			title : '信息反馈',
			close : function(result) {
				if (result && result!='undefined') {
					var $field = $("textarea[moduleType='informationfeedbackField'][name='" +feedbackFieldName+ "']");
					if ($field) {
						$field.text(result);
						$field.obpmInformationfeedbackField();
					}
				}
			}
		});
	}
	
	
	function buildInformationfeedbackHtml($field) {
		var displayType = $field.attr("displayType");
		var areaWidth = $field.attr("width");
		var areaHeight = $field.attr("height");
		var fieldName = $field.attr("name");
		var $html = $("<div name=\"div_" +fieldName+ "\"  style=\"cursor:pointer; width:" +areaWidth+ "; height:"+areaHeight+"; margin:0px; padding:0px;border:1px solid rgb(169, 169, 169);overflow-y:auto;\"></div>");
		var $tips = $("<div style='background-color:yellow;border:0px;display:none;margin:0px;padding:0px;position:absolute;' id='"+fieldName+"_tip'>双击打开信息反馈</div>"); 
		$html.dblclick(function(event) {
			 openFeedback(fieldName);
		 }).hover(function(event){
			 if (!tipShow) {
				 return false;
			 }
			 var $tip = $("<div style='background-color:yellow;border:0px;display:none;margin:0px;padding:0px;position:absolute;' id='"+fieldName+"_tip'>双击打开信息反馈窗口</div>");
			 $("body").append($tip);
			 $tip
			 	.css({"top": (event.clientY+5)+"px", "left": (event.clientX+5)+"px"})
			 	.show("fast");
		 }, function(){
			 if (!tipShow) {
				 return false;
			 }
			 $("#" +fieldName+ "_tip").remove();
		 }).mouseover(function(event) {
			if (!tipShow) {
				 return false;
			 }
			$("#" +fieldName+ "_tip")
		 	.css({"top": (event.clientY+5)+"px", "left": (event.clientX+5)+"px"})
		 	
		}).click(function() {
			tipShow = false;
			$("#" +fieldName+ "_tip").remove();
		});
		if (displayType!=PermissionType_HIDDEN) {
			var content = $field.text();
			if (content && $.trim(content)!='') {
				content = content.replace(/[\r]/g,"");  //替换换行
				content = content.replace(/[\n]/g,"");  //替换回车
				var jsContent = eval('(' + content + ')');
				for (var i=0; i<jsContent.length; i++) {
					var $signature = typeof(jsContent[i].signature)=='undefined'?"":jsContent[i].signature;
					
					var $infWraper = $("<div style=\"width:100%; margin:0px; padding:5px 0px;border-bottom:1px dotted rgb(169, 169, 169);\"></div>");
					var $infContent = $("<div style=\"width:100%; margin:0px; padding:5px 0px;font-size:12px;word-wrap:break-word; word-break:break-all;white-space:pre;\">" +jsContent[i].content+ "</div>");
					var $infAttachment = $("<div style=\"width:100%; margin:0px; padding:0px;font-size:12px;word-wrap:break-word; word-break:break-all;white-space:pre;\"></div>");
					var $spanAttachment = $("<div name='attachment' id='" + fieldName+ "informationfeedback_attachment_" + i + "' class='attachment' moduleType='uploadFile' tagName='AttachmentUploadField' disabled='disabled' maxsize='10240'  discript ='反馈附件' path='ITEM_PATH'  limitNumber ='10' fileType='00' customizeType='' uploadList ='uploadList_" +fieldName+ "_informationfeedback_attachment_" +i+ "_attachment' value='" +stringifyJSON(jsContent[i].attachment)+ "'></div>");
					$spanAttachment.appendTo($infAttachment);
					var $infSignature = $("<div style=\"width:100%;text-align:right; margin:0px; padding:0px;font-size:14px;\">" +$signature+ "</div>");
					if (i==jsContent.length-1) {
						$infWraper.css("border-bottom", "0px");
					}
					$infWraper.append($infContent).append($infAttachment).append($infSignature);
					$html.append($infWraper);
				}
			}
		}
		$field.after($html);
	}
	
	$.fn.obpmInformationfeedbackField = function(){
		return this.each(function(){
			var $field = jQuery(this);
			$("div[name='div_" +$field.attr("name")+ "']").remove();
			buildInformationfeedbackHtml($field);
			$("div[name='attachment'][moduleType='uploadFile']").obpmUploadField();
		});
	};
})(jQuery);
