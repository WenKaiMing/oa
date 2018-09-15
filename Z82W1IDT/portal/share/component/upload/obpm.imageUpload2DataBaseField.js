(function($){
	$.fn.obpmImageUploadToDataBase= function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("id");
			var name=$field.attr("name");
			var fieldType=$field.attr("fieldType");
			var value=$field.attr("value");
			var imgHeight=$field.attr("imgHeight");
			var imgWidth=$field.attr("imgWidth");
			var applicationid=$field.attr("applicationid");
			var uploadList=$field.attr("uploadList");
			var limitNumber=$field.attr("limitNumber");
			var maxsize=$field.attr("maxsize");
			var refreshOnChanged=$field.attr("refreshOnChanged");
			var deleteLabel=$field.attr("deleteLabel");
			var uploadLabel=$field.attr("uploadLabel");
			var value=$field.attr("value");
			var modifyReadonly=$field.attr("modifyReadonly");
			var disabled=$field.attr("disabled");
			var readonly = (disabled == 'disabled');
			var subGridView = $field.attr("subGridView");
			subGridView =(subGridView=='true');
			
			var html="";
				html+="<table><tr><td style='border:0' >";
				html+="<div id='" + uploadList + "' GridType='imageUpload2DataBase' ></div>";
				html+="<input type='hidden' id='" + id + "' name='" + name + "' fieldType='" + fieldType + "' value='" + value + "' />";

			if(modifyReadonly){
				html+="<input  type='button' class='btnSelectDept' value='" + uploadLabel + "' name='btnSelectDept' ";
				if(disabled){
					html+=" disabled='disabled' ";
				};
				html+=" />";
				html+="<input type='button' class='btndelete' name='btnDelete'  value='" + deleteLabel + "' ";
				if(disabled){
					html+=" disabled='disabled' ";
				};
				html+=" />";
			}
			html+="</td>";
			html+="</tr></table>";
			var _callback =function(){
				refreshImgToDataBaseList(document.getElementById(id).value,uploadList,imgHeight,imgWidth,readonly,refreshOnChanged,applicationid,subGridView);
			},
			init =function(){
				refreshImgToDataBaseListSub(document.getElementById(id).value,uploadList,imgHeight,imgWidth,readonly,refreshOnChanged,applicationid);
			};
			var $html = $(html);
			$html.find(".btnSelectDept").click(function(){
				uploadToDataBaseFrontFile(id,maxsize, _callback,applicationid);
			}).end().find(".btndelete").click(function(){
				deleteToDataBaseFile(jQuery("#"+ id), uploadList,applicationid);
			});
			$field.replaceWith($html);
			init();
		});
	};
	$.fn.obpmViewImageUpload2DataBase = function(){
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
			
			var html = "<div  class='bigImg' style='position:relative;width:" + imgw + "; height:" + imgh + "'>";
			if(viewReadOnly){
				html += "<img alt='" + fileName.split("_")[1] + "' border='0' src='" + url + "' width='" + imgw + "' height='" + imgh + "' />";
			}else{
				html += "<a ";
				if(!isSubGridView){
					html +=" href=\"javaScript:viewDoc('" + docId + "','" + docFormid + "')\"";
				}
				html +=" rel='lightbox' title='" + fileName.split("_")[1] + "'>";
				html += "<img alt='" + fileName.split("_")[1] + "' border='0' src='" + url + "' width='" + imgw + "' height='" + imgh + "' />";
				html += "</a>";
			}
			html += "<div  class='smallIcon' style='display:none;position:absolute;right:0px;top:"+imgwHalf+"px;z-index:100;'><a class='imgClick' href='" + url + "' target='blank'>";
			html += "<img alt='" + fileName.split("_")[1] + "' border='0' src='../../../resource/images/picture_go.png' title='点击查看原图' /></a><div>";
			html += "</div>";
			var $html=$(html);
			$html.mouseover(function(event) {
				event.stopPropagation();
				jQuery(this).find(".smallIcon").show();
			}).mouseout(function(event){
				event.stopPropagation();
				jQuery(this).find(".smallIcon").hide();
			});
			$field.replaceWith($html);
		});
	};
})(jQuery);