map = {};
function refreshAttachmentUploadToDataBaseListSub(fileFullName, uploadListId, readonly,refresh,applicationid,subGridView){
	if (fileFullName == "clear") {
		jQuery("#"+ uploadListId).html(''); // 清空显示值
		jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val("");
	} else {
		if (jQuery.trim(fileFullName) !="") {
			jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val(fileFullName);
			jQuery("#"+ uploadListId).html(getDivContentAttachment(fileFullName, uploadListId, readonly,refresh,applicationid,subGridView));
		} else {
			jQuery("#"+ uploadListId).html('');
		}
	}
}

// 文件附件
function refreshAttachmentUploadToDataBaseList(fileFullName, uploadListId, readonly,refresh,applicationid,subGridView) {
	refreshAttachmentUploadToDataBaseListSub(fileFullName, uploadListId, readonly,refresh,applicationid,subGridView);
	if(refresh){
		//保存后刷新控件内容时js报未定义此方法的错误
		//设置延迟，等页面加载好方法再调用
		if(subGridView){
			dy_view_refresh(uploadListId);
		}else{
			window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
		}
	}
}

// 获得显示第一个文件
function getDivContentAttachment(fileFullName, uploadListId, readonly,refresh,applicationid,subGridView) {
	var divContent = '';
	divContent += '<div>';
	var str = fileFullName.split(";");
	for (var i = 0; i < str.length; i++) {
			divContent += '<a href="' + contextPath + '/ShowImageServlet?type=file&id='+str[i].split("_")[0] + '&applicationid='+applicationid+'" target="_blank" onmouseover="showUploadPic(' + i + ',\''
			+ uploadListId + '\',\''+ str[i].split("_")[0] + '\',\''+applicationid+'\')"  onmouseout="hiddenUploadPic(' + i + ',\''
			+ uploadListId + '\')">'
					+ str[i].split("_")[1] + '</a>&nbsp;';
			if (!(readonly || readonly == 'true')) {
				divContent += '<a  href="#" onclick="deleteOneFileAttachment(' + i + ',\''
						+ uploadListId + '\','+readonly+','+refresh+',\''+applicationid+'\','+ subGridView +')"><img   border="0" src="'
						+ '../../../resource/image/close.gif"/></a>';
			}
	divContent += '<div id="'+uploadListId+i+'" style="background-color: #F4F4F4;display:none;position: absolute;width: 400px;height: 20px;"></div><br/>';
	}
	divContent += '</div>';
	return divContent;
}


// 删除一个文件
function deleteOneFileAttachment(index, id,readonly,refresh,applicationid,subGridView) {
	if(confirm("你确定删除当前文件吗？此操作不可恢复！")){
		var webpath = "";
		var oldstr = jQuery("#"+ id.substring(id.indexOf("_") + 1)).val();
		var str = jQuery("#"+ id.substring(id.indexOf("_") + 1)).val().split(";");
		var filefullname = "";
		var _docid = document.getElementById("_docid").value;
		if (str.length != 1) {
			for (var i = 0; i < str.length; i++) {
				if (i == index) {
					webpath = str[i];
				}
			}
		} else {
			webpath = jQuery("#"+ id.substring(id.indexOf("_") + 1)).val();
		}
		
		if (str.length == 1) {
			filefullname = "";
			jQuery("#"+ id.substring(id.indexOf("_") + 1)).val("");
		} else {
			if (str && str.length > 0) {
				for (var i = 0; i < str.length; i++) {
					if (i != index) {
						filefullname += str[i] + ";";
					} else if (str[0] == webpath) {
						filefullname = "";
					}
				}
		
				filefullname = filefullname.substring(0,
						filefullname.lastIndexOf(";"));
			}
		}
		
		jQuery("#"+ id.substring(id.indexOf("_") + 1)).val(filefullname);
//		var url = encodeURI(encodeURI(contextPath + "/portal/upload/deleteToDataBaseFile.action?applicationid="+applicationid+"&fileFullName="+ webpath + "&docid=" + _docid + "&" + fieldname + "=" + filefullname));
//		jQuery.post(url, function(x) {
//			refreshAttachmentUploadToDataBaseList(filefullname, id, readonly,refresh,applicationid,subGridView);
//			filefullname = "";
//			});
		// 删除URL
		//var url = encodeURI(encodeURI(contextPath + "/portal/upload/deleteToDataBaseFile.action?applicationid="+applicationid+"&fileFullName="+ webpath + "&docid=" + _docid));
		//jQuery.post(url,
		jQuery.ajax({	
			type: 'POST',
			async:false,
			url: encodeURI(encodeURI(contextPath + "/portal/upload/deleteToDataBaseFile.action?fileFullName="+ webpath)),
			dataType : 'text',
			data: jQuery("#document_content").serialize(),
			success:function(x) {
				refreshAttachmentUploadToDataBaseList(filefullname, id, readonly,refresh,applicationid,subGridView);
				filefullname = "";
			},
			error: function(x) {
				jQuery("#"+ id.substring(id.indexOf("_") + 1)).val(oldstr);
			}
		});
	}
}

function AttachmentUploadToDataBase(pathFieldId,maximumSize, callback,applicationid,limitNumber,fileType,customizeType) {
	var oField =jQuery("#"+ pathFieldId);
	var fieldValue = oField.val();
	var url = contextPath + '/portal/share/component/upload/uploadtodatabase.jsp';
	hiddenDocumentFieldIncludeIframe();//in util.js
	OBPM.dialog.show({
		title : title_upload,
		url : url,
		width : 650,
		height : 500,
		args: {"fieldId":pathFieldId,"fieldValue":fieldValue,"maximumSize":maximumSize,"allowedTypes":"file","applicationid":applicationid,"limitNumber":limitNumber,"fileType":fileType,"customizeType":customizeType},
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

function deleteAttachmentUploadToDataBase(valueField, uploadListId,applicationid){
	if(confirm("你确定删除全陪文件吗？此操作不可恢复！")){
		var url = encodeURI(encodeURI(contextPath + "/portal/upload/deleteToDataBaseFile.action?fileFullName="+valueField.val()));
		
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
	}
}