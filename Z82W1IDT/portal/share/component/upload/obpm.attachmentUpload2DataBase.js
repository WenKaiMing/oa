(function($){
	$.fn.obpmAttachmentUploadToDataBase = function(){
		return this.each(function(){
			var $field =jQuery(this);
			var id=$field.attr("id");
			var name=$field.attr("name");
			var fieldType=$field.attr("fieldType");
			var value=$field.attr("value");
			var applicationid=$field.attr("applicationid");
			var uploadList=$field.attr("uploadList");
			var limitNumber=$field.attr("limitNumber");
			var fileType=$field.attr("fileType");
			var customizeType=$field.attr("customizeType");
			var maxsize=$field.attr("maxsize");
			var refreshOnChanged=$field.attr("refreshOnChanged");
			var deleteLabel=$field.attr("deleteLabel");
			var uploadLabel=$field.attr("uploadLabel");
			var text=$field.attr("text");
			var modifyReadonly=$field.attr("modifyReadonly");
			var disabled=$field.attr("disabled");
			var readonly = (disabled == 'disabled');
			var subGridView = $field.attr("subGridView");
			subGridView =(subGridView=='true');

			var html="";
				html+="<table><tr>";
				html+="<td style='border:0'>";
				html+="<input type='hidden' id='" + id + "' name='" + name + "' fieldType='" + fieldType + "' value='" + value + "' text='" + text + "' />";
				html+="<div id='" + uploadList + "' GridType='AttachmentUploadToDataBase' ></div>";
				html+="</td>";
				html+="<td style='border:0' >";
			if(modifyReadonly){
				html+="<input  type='button' class='imageUpload' value='" + uploadLabel + "' name='btnSelectDept' ";
				if(disabled){
					html+=" disabled='disabled' ";
				};
				html+=" />";
				html+="<input type='button' class='imageDelete' name='btnDelete'  value='" + deleteLabel + "' ";
				if(disabled){
					html+=" disabled='disabled' ";
				};
				html+=" />";
			}
			html+="</td>";
			html+="</tr></table>";
			var _callback =function(){
				refreshAttachmentUploadToDataBaseList(jQuery("#"+ id).val(), uploadList,readonly,refreshOnChanged,applicationid,subGridView);
			},
			init = function(){
				refreshAttachmentUploadToDataBaseListSub(jQuery("#"+ id).val(), uploadList,readonly,refreshOnChanged,applicationid,subGridView);
			};
			var $html = $(html);
			$html.find(".imageUpload").click(function(){
				AttachmentUploadToDataBase(id,maxsize, _callback,applicationid,limitNumber,fileType,customizeType);
			}).end().find(".imageDelete").click(function(){
				deleteAttachmentUploadToDataBase(jQuery("#"+ id), uploadList,applicationid);
			});
			$field.replaceWith($html);
			init();
		});
		};
})(jQuery);