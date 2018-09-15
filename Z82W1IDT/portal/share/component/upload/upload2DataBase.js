function refreshImgToDataBaseListSub(fileFullName, uploadListId, myheigh, mywidth,readonly,refresh,applicationid) {
	if (jQuery.trim(fileFullName) !=""&&fileFullName!='clear') {
		var today=new Date();
		var h=today.getHours();
		var m=today.getMinutes();
		var s=today.getSeconds();
		var t = h + "_" + m + "_" + s;
		var divContent = '';
		divContent += '<div>';
		divContent += '<a href="' + contextPath + '/ShowImageServlet?type=image&id='+fileFullName.split("_")[0] + '&applicationid='+applicationid+'&st='+t+'" rel="lightbox" title="'
		+ fileFullName.split("_")[1] + '" onmouseover="showUploadPic(0,\''
		+ uploadListId + '\',\''+ fileFullName.split("_")[0] + '\',\''+applicationid+'\')"  onmouseout="hiddenUploadPic(0,\''
		+ uploadListId + '\')" target="_blank">';
		divContent += '<img src="' +contextPath + '/ShowImageServlet?type=image&id='+fileFullName.split("_")[0]+'&applicationid='+applicationid+'&st='+t+'" width=' + mywidth
		+ ' height=' + myheigh + ' border="0" alt="'+fileFullName.split("_")[1]+'"/>';
		divContent += '</a>';
		divContent += '</div>';
		divContent += '<div id="'+uploadListId+'0" style="background-color: #F4F4F4;display:none;position: absolute;width: 400px;height: 20px;"></div>';
		jQuery("#"+ uploadListId).html(divContent);
	}else{
		jQuery("#"+ uploadListId).html('');	
	}
}
function refreshImgToDataBaseList(fileFullName, uploadListId, myheigh, mywidth,readonly,refresh,applicationid, subGridView) {
	refreshImgToDataBaseListSub(fileFullName, uploadListId, myheigh, mywidth,readonly,refresh,applicationid);
	if(refresh){
		if(subGridView){
			dy_view_refresh(uploadListId);
		}else{
			window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
		}
	}
}

function uploadToDataBaseFrontFile(pathFieldId,maximumSize, callback,applicationid) {
	var oField = jQuery("#" + pathFieldId);
	var fieldValue = oField.val();
	var url = contextPath + '/portal/share/component/upload/uploadtodatabase.jsp';
	hiddenDocumentFieldIncludeIframe();//in util.js
	OBPM.dialog.show({
		title : title_upload,
		url : url,
		width : 650,
		height : 500,
		args: {"fieldId":pathFieldId,"fieldValue":fieldValue,"maximumSize":maximumSize,"allowedTypes":"image","applicationid":applicationid},
		close : function(result) {
			showDocumentFieldIncludeIframe();////in util.js
		
			var rtn = result;
			if (result == null || result == 'undefined') {
			} else {
				oField.val(rtn);
			}
			
			if (callback && typeof(callback) == "function") {
				callback();
			}
		}
	});
}

function deleteToDataBaseFile(valueField, uploadListId,applicationid){
	if(confirm("你确定删除图片吗？此操作不可恢复！")){
		var url=encodeURI(encodeURI(contextPath + "/portal/upload/deleteToDataBaseFile.action?fileFullName="+valueField.val()));
		//保存原来的值用于删除发生异常时可以恢复数据
		var uploadListIdHTML = jQuery("#"+ uploadListId).html();
		var uploadListIdValue = jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val();
		
		jQuery("#"+ uploadListId).html(''); // 清空显示值
		jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val("");
		
		jQuery.ajax({	
			type: 'POST',
			async:false,
			url: url,
			dataType : 'text',
			data: jQuery("#document_content").serialize(),
			success:function(x) {
			},
			error: function(x) {
				//恢复数据
				jQuery("#"+ uploadListId).html(uploadListIdHTML);
				jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val(uploadListIdValue);
			}
		});
		/*
		jQuery.post(url, function(x) {
			jQuery("#"+ uploadListId).html(''); // 清空显示值
			jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val("");
		});*/
	}

}