
(function($){
	//表单Baidumap处理
	function FormBaiduMap(FieldID,applicationid,displayType){
		var oField = jQuery("#"+ FieldID);
		var url=contextPath+"/portal/share/component/map/form/baiduMap.jsp?type=dialog&applicationid="+applicationid+"&displayType="+displayType;
		hiddenDocumentFieldIncludeIframe();//in util.js
		OBPM.dialog.show({
			title : title_map,
			url : url,
			args: {"fieldID":FieldID,"mapData":oField.val()},
			width : 1000,
			height : 600,
			close : function(result) {
				showDocumentFieldIncludeIframe();////in util.js
				var rtn = result;
				if (result == null || result == 'undefined') {
					
				} else {
					oField.val(rtn);
				}
			}
	});
	}
	$.fn.obpmMapField= function(){
		return this.each(function(){
			var $field=jQuery(this);
			var id=$field.attr("id");
			var name=$field.attr("name");
			var fieldType=$field.attr("fieldType");
			var value=$field.attr("value");
			var mapLabel=$field.attr("mapLabel");
			var application=$field.attr("application");
			var displayType=$field.attr("displayType");
			var discript = HTMLDencode($field.attr("discript"));
			var srcEnvironment=$field.attr("srcEnvironment");
			var openType=$field.attr("openType");
			
			discript = discript? discript : name;
			var readonly = "";

			if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
				readonly = "readonly";
			}
			var paramname = encodeURI(encodeURI(id)); 
			var iframeH = window.innerHeight/2;
			var data = {
					iframeH : iframeH,
					id : id,
					name : name,
					value : value,
					isReadonly : false,
					openType : openType,
					mapLabel : mapLabel,
					discript : discript,
					readonly : readonly,
					fieldType : fieldType,
					paramname : paramname,
					displayType : displayType,
					application : application,
					srcEnvironment : srcEnvironment
			};
			
			var $html = $(template("map-tmpl", data));
			$html.find("input").click(function(){
				FormBaiduMap(id,application,displayType);
			});
			$field.replaceWith($html);
		});
	};
	
})(jQuery);