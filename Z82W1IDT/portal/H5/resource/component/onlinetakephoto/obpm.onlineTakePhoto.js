(function($) {
	
	function onlinetakephoto(id,value){
		var url = contextPath + '/portal/share/component/onlinetakephoto/onlinetakephoto.jsp?id='
		+ id+'&filePath='+value;
		var oField = jQuery("#"+ id);
		var img = jQuery("#"+ id+"_img");
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 455,
			height: 318,
			url: url,
			args: {},
			title: title_onlinetakephoto,
			close: function(result) {
				if (result == null || result == 'undefined' || result =="") {
				} else {
					oField.val(result);
					img.attr("src","../../.."+result);
					//img.parent().attr("href","../../.."+result);
				}
			}
		});
	}
	$.fn.obpmTakePhoto = function() {
		return this.each(function() {
			var $field = jQuery(this);
			var contextPath = $field.attr("contextPath");
			var value = $field.attr("value");
			var id = $field.attr("id");
			var imgw = $field.attr("imgw");
			var imgh = $field.attr("imgh");
			var name = $field.attr("name");
			var _hiddenValue = $field.attr("_hiddenValue");
			var tagName = $field.attr("tagName");
			var disabled = $field.attr("disabled");
			var displayType = $field.attr("displayType");
			var html = "";
			var $html = "";
			if(displayType!=PermissionType_HIDDEN){
				html += "<table style='border:0'><tr><td style='border:0' width='" + imgw + "'> ";
				html += "<div class='onlinePreview'>";
				html += "<img alt='拍照图片' border=0 src='../../.." + value
						+ "' id='" + id + "_img' width='" + imgw + "' height='"
						+ imgh + "' />";
				html += "</div>";
				html += "</td>";
				html += "<td style='border:0;valign:botton'>";
				html += "<input type='hidden' id='" + id + "' name='" + name
						+ "' fieldType='" + tagName + "'" +"  value = '" +value;
				html += "'/>";
				if(displayType != PermissionType_DISABLED && displayType !="1"){
					html += "<input type='button'";
					html += " class='button_searchdel4' />";
				}
				
				html += "</td>";
				html += "</tr>";
				html += "</table>";
				$html = $(html);
				$html.find(".onlinePreview").bind("click",function(){
					//alert(1);
					$(this).viewer({
						navbar : false,
						hidden : function(){
							$(this).viewer('destroy')
						}
						
					}).viewer('show');
					
				});
				$html.find(".button_searchdel4").bind("click",function(){
					onlinetakephoto(id,value);
				}).end().replaceAll($field);
			}else{
				html += '<span>'+_hiddenValue+'</span>';
				$html = $(html);
				$html.replaceAll($field);
			}
			
		});
	};
	$.fn.obpmViewTakePhoto = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var imgw = $field.attr("imgw");
			var imgh = $field.attr("imgh");
			var viewReadOnly = $field.attr("viewReadOnly");
			var docId = $field.attr("docId");
			var docFormid = $field.attr("docFormid");
			var url = $field.attr("url");
			var fileName = $field.attr("fileName");
			
			viewReadOnly = (viewReadOnly=="true")?true:false;
			var imgwHalf = imgh/2;
			var isSubGridView = jQuery("#obpm_subGridView").size()>0?true:false;
			
			var html = "<div  class='takePhotoImg' style='position:relative;max-height:50px;max-width:50px;'>";
			if(viewReadOnly){
				html += "<img alt='" + fileName + "' border='0' style='max-height:50px;max-width:50px;' src='" + url + "' />";
			}else{
				html += "<a ";
				if(!isSubGridView){
					html +=" href=\"javaScript:viewDoc('" + docId + "','" + docFormid + "')\"";
				}
				html +=" title='" + fileName + "'>";
				html += "<img alt='" + fileName + "' border='0' style='max-height:50px;max-width:50px;' src='" + url + "'/>";
				html += "</a>";
			}
			html += "<div  class='takePhotoIcon' style='display:none;position:absolute;right:0px;top:25px;z-index:100;'><a class='imgClick' href='" + url + "' target='blank'>";
			html += "<img alt='" + fileName + "' border='0' src='../../resource/images/picture_go.png' title='点击查看原图' /></a><div>";
			html += "</div>";
			var $html=$(html);
			$html.mouseover(function(event) {
				event.stopPropagation();
				jQuery(this).find(".takePhotoIcon").show();
			}).mouseout(function(event){
				event.stopPropagation();
				jQuery(this).find(".takePhotoIcon").hide();
			});
			$field.replaceWith($html);
		});
	};
})(jQuery);