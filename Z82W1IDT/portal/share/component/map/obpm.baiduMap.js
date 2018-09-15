
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
			var srcEnvironment=$field.attr("srcEnvironment");
			var openType=$field.attr("openType");
			
			if(displayType != PermissionType_HIDDEN){
				var hiddenHtml = "<input type='hidden' id='" + id + "' name='" + name + "' fieldType='" + fieldType + "'";
				if(value)
					hiddenHtml += " value='" + value + "'";
				
				hiddenHtml += " />";
				$field.after($(hiddenHtml));
				
				if(openType=='dialog'){
						var tableHtml = "<table style='width:100%;height:100%;margin:0px;'>";
						tableHtml+="<tr><td style='border:0'>";
						tableHtml+="<input type='button' value='" + mapLabel + "' name='btnSelectDept'";
						if(displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED){
							tableHtml+=" disabled='disabled' ";
						}
						tableHtml +=" />";
						tableHtml +="</td>";
						
						tableHtml+="</tr></table>";
						var $tablehtml = $(tableHtml);
						$tablehtml.find("input").click(function(){
							FormBaiduMap(id,application,displayType);
						});
						$field.after($tablehtml);
				}else{
					var paramname=encodeURI(encodeURI(id)); 
					var iframeHtml = "<iframe name='baidumap' id='baidumap' style='margin:0px;width:100%;height:550px;'";
					iframeHtml+="frameborder=0 ";
					iframeHtml+=" style=''";
					iframeHtml+="src=" + srcEnvironment + "/portal/share/component/map/form/baiduMap.jsp?type="+openType+"&fieldID="+paramname+"&applicationid="+application+"&displayType=" + displayType + "";
					iframeHtml+=" >";
					iframeHtml+="</iframe>";
					$field.replaceWith($(iframeHtml));
				}
			}
			$field.remove();
		});
	};
	
})(jQuery);