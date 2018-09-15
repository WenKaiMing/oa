(function($) {
	var isNoDeleteFile = true;
	var isReloadFile = false;
	map = {};

	function FMFileInfo(file) {
		var webIndex = file.path.lastIndexOf("/");
		var urlIndex = file.path.lastIndexOf("_/uploads");

		this.webPath = file.path;
		if (urlIndex >= 0) {
			this.webPath = file.path.substring(urlIndex + 1);
		}

		this.realName = file.path.substring(webIndex + 1, file.path.length);
		this.showName = file.name;
		this.url = contextPath + this.webPath;
	}

	function File(name, path) {
		this.name = name;
		this.path = path;
	}

	function refreshUploadListSub(fileFullName, uploadListId, readonly,
			refresh, applicationid, subGridView, disabled) {
		var $uploadList = $("#" + uploadListId);
		$uploadList.html(''); // 清空显示值
		
		switch(fileFullName){
		case "clear":
			//与""相同
		case "":
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1)).val("");
			break;
		default :
			var $html = getDivContent(fileFullName, uploadListId,
					readonly, refresh, applicationid, 
					subGridView, disabled)
					
			$uploadList.append($html);
			$html.find(".fileTitle").each(function(){
				var $title = $(this);
				var titleWidthDefault = $title.width();
				$title.css("display","table");
				var titleWidth = $title.width();
				
				if(titleWidth > titleWidthDefault){
					$title.css("display","block");
				}
			})			
		}
	}

	// 文件附件
	function refreshUploadList(fileFullName, uploadListId, readonly, refresh,
			applicationid, subGridView, disabled) {
		refreshUploadListSub(fileFullName, uploadListId, readonly, refresh,
				applicationid, subGridView, disabled);
		if (refresh != 'false') {
			if (subGridView) {
				dy_view_refresh(uploadListId);
			} else {
				window.setTimeout("dy_refresh('"
						+ uploadListId.substring(uploadListId.indexOf("_") + 1)
						+ "')", 500);
			}
		}
	}

	// 显示文件列表
	function showUploadPic(index, id, webPath, applicationid) {
		var $picDiv = jQuery("#" + id + "pic" + index);
		if ($picDiv.size() != 0) {
			var url = encodeURI(encodeURI(contextPath
					+ "/portal/upload/fileInfor.action?applicationid="
					+ applicationid + "&fileFullName=" + webPath));
			jQuery.post(url, function(x) {
				// 提交成功回调
					var oldTitle = $picDiv.attr("title");
					$picDiv.attr("title", oldTitle + x);
				});
		}
	}
	
	//根据文件扩展名返回不同的class
	function fileTypeJudge(fileType){
		var imgCss = "other";
		
		if (fileType == ".pdf") {
			imgCss = "pdf";
		} else if (fileType == ".doc" || fileType == ".docx") {
			imgCss = "word";
		} else if (fileType == ".xls" || fileType == ".xlsx") {
			imgCss = "excel";
		} else if (fileType == ".txt") {
			imgCss = "txt";
		} else if (fileType == ".mp3" || fileType == ".wav"
				|| fileType == ".wma" || fileType == ".ra"
				|| fileType == ".rm" || fileType == ".cd") {
			imgCss = "audio";
		} else if (fileType == ".avi" || fileType == ".3gp"
				|| fileType == ".mkv" || fileType == ".rmvb"
				|| fileType == ".mp4" || fileType == ".mpg"
				|| fileType == ".swf" || fileType == ".dvd") {
			imgCss = "video";
		} else if (fileType == ".ppt" || fileType == ".pptx") {
			imgCss = "ppt";
		} else if (fileType == ".ipa") {
			imgCss = "ios";
		} else if (fileType == ".apk") {
			imgCss = "android";
		} else if (fileType == ".psd") {
			imgCss = "psd";
		} else if (fileType == ".ai") {
			imgCss = "ai";
		} else if (fileType == ".rar" || fileType == ".zip") {
			imgCss = "rar";
		} else if (fileType == ".jpg" || fileType == ".png"
				|| fileType == ".jpeg" || fileType == ".gif") {
			imgCss = "img";
		}
		return imgCss;
	}

	//是否支持预览
	function isPreViewFile(_file){
		var isPreView = false;
		DWREngine.setAsync(false);
		FormHelper.hasSwfFile(_file.webPath, _file.realName, function(result) {
			isPreView = result;
		});
		DWREngine.setAsync(true);
		return isPreView;
	}
	
	// 获得显示列表
	function getDivContent(fileFullName, uploadListId, readonly, refresh,
			applicationid, subGridView, disabled) {
		
		var data = {
				uploadListId : uploadListId,
				readonly : readonly,
				files : []
		};

		var files = JSON.parse(fileFullName);
		for ( var i = 0; i < files.length; i++) {	//循环文件列表
			var _file = new FMFileInfo(files[i]);
			var isImg = false;
			var imgCss = "";

			var isPreView = false;	// 判断文档是否可预览(OFFIC文档)
			isPreView = isPreViewFile(_file);
			isPreView = (isPreView || imgCss == "img");	//图片可预览

			// 获取文件类型 根据类型给文件赋予前置图标
			var _id = _file.showName.substring(0,
					_file.showName.lastIndexOf(".")).toLowerCase();
			var fileType = _file.showName.substring(
					_file.showName.lastIndexOf(".")).toLowerCase();
			
			imgCss = fileTypeJudge(fileType);	//根据文件扩展名返回不同的class
			
			var title = _file.showName;
			var fileType = title.substring(title.lastIndexOf("."))
					.toLowerCase();
			var fileName = title.substring(0, title.lastIndexOf("."));
			/*if (fileName != null && fileName.length > 8) {
				title = fileName.substring(0, 7) + ".."
						+ fileName.charAt(fileName.length - 1) + fileType;
			}*/
			title = fileName;
			var file = _file;

			file = {
					_id : _id,
					title : title,
					url : _file.url,
					imgCss : imgCss,
					fileType : fileType,
					isPreView : fileTypeJudge(fileType) == "img" ? "true" : isPreView + "",
					webPath : _file.webPath,
					showName : _file.showName,
					realName : _file.realName,
					fileType : fileType
			};
			data.files.push(file);
		}

		var $html = $(template("fileUploadCon-tmpl", data));
		

		$html.find(".fileRow").each(function(index) {
			$(this).bind("click",function() {
				var $me = $(this);
				var isPreView = $me.attr("isPreView");
				var file = {
						 webPath : $me.attr("data-webPath"),
						 showName : $me.attr("data-showName"),
						 realName : $me.attr("data-realName")
				};
				
				if(isPreView == "false" ){
					isPreView = isPreViewFile(file) ? "true" : "false";
					$me.attr("isPreView",isPreView);
				}
				
				if(isPreView == "true"){
					previewFile(file);
				}else{
					downloadFile(file);
				}
			}).find(".del").bind("click", function(){	//删除文件
				deleteOneFile(index,uploadListId,refresh,
						applicationid,subGridView,disabled);
				return false;
			});
		});
		
		return $html;
	}

	/**
	 * 文件预览
	 */
	function previewFile(file) {
		var url = encodeURI(encodeURI(contextPath
				+ "/portal/phone/resource/component/upload/preview.jsp?name="
				+ file.realName + "&path=" + file.webPath + "&showName="+file.showName));
		var fileType = file.realName.substr(file.realName.indexOf(".")).toLowerCase();
		if(
			fileType == ".doc" ||
			fileType == ".docx" ||
			fileType == ".xls" ||
			fileType == ".xlsx" ||
			fileType == ".pdf" ||
			fileType == ".txt" ||
			fileType == ".rtf" ||
			fileType == ".et" ||
			fileType == ".ppt" ||
			fileType == ".pptx" ||
			fileType == ".dps" ||
			fileType == ".pot" ||
			fileType == ".pps" ||
			fileType == ".wps" ||
			fileType == ".html" ||
			fileType == ".htm" 
		){
			if(fileType == ".pdf"){
				window.location.href = contextPath + file.webPath;
			}else{
				window.location.href = contextPath + file.webPath.substr(0,file.webPath.lastIndexOf("/")+1) + 'swf/' + file.realName.substr(0,file.realName.indexOf(".")) + '.pdf'
			}
			
		}else{
			OBPM.dialog.show({
				url : url,
				title : "文件预览",
				close : function(result) {
					
				}
			});
		}
		
		
		
	}

	/**
	 * 文件下载
	 */
	function downloadFile(file) {
		var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ file.realName + "&filepath=" + file.webPath);
		window.open(url,"_blank");
	}
	
	/**
	 * 获取文字长度
	 */
	function GetCurrentStrWidth(text) {
		var currentObj = $('<pre>').hide().appendTo(document.body);
		$(currentObj).html(text);
		var width = currentObj.width();
		currentObj.remove();
		return width;
	}

	// 删除一个文件
	function deleteOneFile(index, id, refresh, applicationid, 
			subGridView, disabled) {
		
		jQuery.confirm({
			trueCall : function(){

				var files = [];
				var filefullname = "";
				var oldstr = jQuery("#" + id.substring(id.indexOf("_") + 1)).val();// 用于恢复数据

				var oField = jQuery("#" + id.substring(id.indexOf("_") + 1));
				if(oField.val() == ""){
					console.error("字段值为空，无法继续删除！")
					return false;
				}
				files = JSON.parse(oField.val());
				var webpath = files[index].path;
				files.splice(index, 1);
				if (files.length > 0) {
					filefullname = JSON.stringify(files);
				}

				oField.val(filefullname);

				jQuery.ajax( {
							type : 'POST',
							async : false,
							url : encodeURI(encodeURI(contextPath
									+ "/portal/upload/deleteOne.action?fileFullName="
									+ webpath)),
							dataType : 'text',
							data : ajaxPage.getParams(),
							success : function(x) {
								refreshUploadList(filefullname, id, false, refresh,
										applicationid, subGridView,
										disabled);
								filefullname = "";
							},
							error : function(x) {
								jQuery("#" + id.substring(id.indexOf("_") + 1))
										.val(oldstr);
							}
						});
			},
			falseCall : function(){
				
			}
		});
	}


	/**
	 * 其他类别显示
	 */
	function showTextDialog(webPath,name) {
		OBPM.dialog.show( {
			opener : window.parent.parent,
			width : 1000,
			height : 580,
			url : webPath,
			args : {},
			title : name,
			close : function(result) {

			}
		});
	}
	
	function previewInNewTab(webPath){
		var _tmpwin = window.open(webPath, "_blank");
		_tmpwin.location.href = webPath;
	}

	// 弹出层来加载文件为了处理乱码问题
	function showFileDialog(obj, name, webPath, readonly) {
		var url = "";
		var fileType = name.substring(name.lastIndexOf(".")).toLowerCase();
		if (fileType == ".doc" || fileType == ".docx" || fileType == ".xls"
				|| fileType == ".xlsx") {
			url = contextPath + '/portal/dynaform/document/doViewWordFile.action';
			OBPM.dialog.show( {
				opener : window.parent.parent,
				width : 1000,
				height : 550,
				url : url,
				args : {
					"webPath" : contextPath + webPath,
					"readonly" : readonly
				},
				title : name,
				close : function(result) {

				}
			});
		} else {
			url = contextPath + webPath;
			obj.target = "_blank";
			obj.href = url;
			obj.triggerHandler("click");
		}
	}

	/**
	 * 图片预览窗口
	 * 
	 * url 图片路径
	 */
	function showImageEffect(url) {
		// 构造外围窗体 将窗体改为隐藏
		$("body").append('<div id="showImageDialog"></div>');
		var $div = $("#showImageDialog");
		$div.css( {
			"display" : "none",
			"position" : "fixed",
			"z-index" : "999",
			"top" : "0px",
			"right" : "0px",
			"bottom" : "0px",
			"left" : "0px"
		});
		$div
				.append('<div style="filter:alpha(opacity=70);-moz-opacity:0.7;-khtml-opacity: 0.7;position: fixed; z-index: 101; top: 0px; right: 0px; bottom: 0px; left: 0px; opacity: 0.7; background-color: rgb(0, 0, 0);"></div>');

		// 添加关闭按钮
		$div
				.append('<div id="imageClose" style="color: rgb(255, 255, 255); padding: 4px 10px ;  background-color: rgb(0, 0, 0);cursor: pointer;right: 0px;position: absolute;z-index:104;font-size:20px;">x</div>');
		// 添加图片外围div
		var imgdiv = '<div style="position: absolute; width: 300%; height: 100%; left: -100%;">';
		// 添加图片
		imgdiv += '<img style="position: absolute; z-index: 102; margin: auto; width: auto; top: 0px; right: 0px; bottom: 0px; left: 0px; display: block; cursor: pointer; max-width: 32%; max-height: 95%;" src="' + url + '"/>';
		imgdiv += "</div>";
		$div.append(imgdiv);

		// 鼠标滑进关闭按钮样式
		$("#imageClose").mouseover(function(e) {
			$("#imageClose").css("background-color", "rgb(55, 55, 55)");
		});
		$("#imageClose").mouseout(function(e) {
			$("#imageClose").css("background-color", "rgb(0, 0, 0)");
		});

		// 点击后淡出然后remove
		$("#imageClose").click(function(e) {
			$("#showImageDialog").fadeOut(50, function() {
				$div.remove();
			});
		});

		// 淡入显示
		$("#showImageDialog").fadeIn(50);
	}

	/**
	 * 前台删除文件
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 */
	function deleteFrontFile(valueField, uploadListId, applicationid) {
		// 删除URL
		if (confirm("你确定删除全部文件吗？此操作不可恢复！")) {
			var fileFullName = "";
			if (valueField.val() != '') {
				var files = JSON.parse(valueField.val());
				for ( var i = 0; i < files.length; i++) {
					fileFullName += files[i].path + ";";
				}
				if (fileFullName.length > 1) {
					fileFullName = fileFullName.substring(0,
							fileFullName.length - 1);
				}
			}
			this.url = contextPath
					+ "/portal/upload/delete.action?fileFullName="
					+ fileFullName;
			fileFullName = "";
			deleteFileCommon(valueField, uploadListId, url);
		}
	}

	/**
	 * 后台删除文件
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 */
	function deleteFile(valueField, uploadListId, applicationid) {
		// 删除URL
		this.url = contextPath + "/core/upload/delete.action?applicationid="
				+ applicationid + "&fileFullName=" + valueField.val();
		deleteFileCommon(valueField, uploadListId, url);
	}

	/**
	 * 前后台共有的删除文件方法
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 * @param {}
	 *            url 删除文件请求的路径
	 */
	function deleteFileCommon(valueField, uploadListId, URL) {
		// 保存原来的值用于删除发生异常时可以恢复数据
		var uploadListIdHTML = jQuery("#" + uploadListId).html();
		var uploadListIdValue = jQuery(
				"#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
				.val();

		jQuery("#" + uploadListId).html(''); // 清空显示值
		jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
				.val("");

		jQuery.ajax( {
			type : 'POST',
			async : false,
			url : encodeURI(url),
			dataType : 'text',
			data : ajaxPage.getParams(),
			success : function(x) {
			},
			error : function(x) {
				// 恢复数据
			jQuery("#" + uploadListId).html(uploadListIdHTML);
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
					.val(uploadListIdValue);
		}
		});
		// jQuery("#" + uploadListId).html(''); // 清空显示值
		// valueField.val(''); // 清空值
		// map[uploadListId] = "";

	}

	/**
	 * 后台文件上传
	 * 
	 * @param {}
	 *            pathname 文件目录
	 * @param {}
	 *            pathFieldId 文件路径域ID
	 * @param {}
	 *            viewid 视图ID
	 * @param {}
	 *            allowedTypes 允许上传的类型
	 * @param {}
	 *            maximumSize 最大值
	 * @param {}
	 *            fileSaveMode 文件保存模式
	 * @return {} 文件网络路径
	 */
	function uploadFile(pathname, pathFieldId, viewid, allowedTypes,
			maximumSize, layer, fileSaveMode, applicationid) {
		var url = contextPath + '/core/upload/upload.jsp?path=' + pathname
				+ "&applicationid=" + applicationid;

		var oField = jQuery("#" + pathFieldId);
		OBPM.dialog.show( {
			opener : window.parent.parent,
			width : 800,
			height : 450,
			url : url,
			args : {},
			title : '文件上传',
			close : function(result) {
				if (result == null || result == undefined
						|| result == "undefined") {

				} else {
					if (oField != null) {
						oField.val(result);
					}
					return resutl;
				}
			}
		});
	}

	/**
	 * 前台文件上传
	 * 
	 * @param {}
	 *            pathname 文件目录
	 * @param {}
	 *            pathFieldId 文件路径域ID
	 * @param {}
	 *            viewid 视图ID
	 * @param {}
	 *            allowedTypes 允许上传的类型
	 * @param {}
	 *            maximumSize 最大值
	 * 
	 * @param {}
	 *            fileSaveMode 文件保存模式
	 * @param {}
	 *            callback 回调函数
	 * @return {} 文件网络路径
	 */
	function uploadFrontFile(title, pathname, pathFieldId, viewid,
			allowedTypes, maximumSize, fileSaveMode, callback, applicationid,
			limitNumber, fileType, customizeType) {
		hiddenDocumentFieldIncludeIframe();// in util.js
		var files = [];
		var oField = jQuery("#" + pathFieldId);
		var ifiles = oField.val();
		if(ifiles!=""){
			files = JSON.parse(ifiles);
		}
		var url = contextPath
				+ '/portal/phone/resource/component/upload/obpm.fileUpload.jsp?path=' + pathname;
		url = addParameters(pathname, pathFieldId, viewid, allowedTypes,
				maximumSize, fileSaveMode, url);
		url += '&applicationid=' + applicationid;
		url += '&limitNumber=' + (limitNumber-files.length);
		url += '&fileType=' + fileType;
		url += '&customizeType=' + customizeType;
		if(limitNumber-files.length>0){
			OBPM.dialog.show( {
				url : url,
				args : {
					"webPath" : "aaaaaaaa",
					"readonly" : "222222"
				},
				title : title,
				close : function(result) {
	//				showDocumentFieldIncludeIframe();//显示被隐藏的iframe，phone中不需要 //in util.js
					var oField = jQuery("#" + pathFieldId);
					var rtn = getReturnValue(oField, result);
					// 把上传的文件json格式 [{'name':'aaa.doc','path':'XXX'}] 放进文件上传控件的value
					var files = [];
					if (isReloadFile) {
						var fileStrs = result.split(";");
						if (oField && oField.attr("value") && allowedTypes != 'image') {
							files = JSON.parse(oField.attr("value"));
						}
						for ( var i = 0; i < fileStrs.length; i++) {
							var fileStr = fileStrs[i].split(",");
							var file = new File(fileStr[0], fileStr[1]);
							files.push(file);
						}
					}
					if (files.length > 0) {
						rtn = JSON.stringify(files);
					}
					oField.attr("value", rtn);
					$("input[name=" + oField.attr("name") + "]").val(rtn);
					if (callback && typeof (callback) == "function") {
						callback();
					}
				}
			});
		} else {
			alert("文件上传超出数量限制。");
		}
	}
	/**
	 * 简单上传
	 * 
	 * @param {}
	 *            pathname 文件存放路径名称
	 * @param {}
	 *            pathFieldId 文件路径域ID
	 * @param {}
	 *            callback 回调函数
	 */
	function uploadFrontSimple(pathname, pathFieldId, applicationid) {
		var url = contextPath
				+ '/portal/phone/resource/component/upload/obpm.fileUpload.jsp?path=' + pathname
				+ '&applicationid=' + applicationid;
		var oField = jQuery("#" + pathFieldId);
		OBPM.dialog.show( {
			opener : window.parent.parent,
			width : 800,
			height : 450,
			url : url,
			args : {},
			title : 'upload',
			close : function(result) {
				if (result == null || result == undefined
						|| result == "undefined" || result == "clear") {
					oField.val('');
				} else {
					oField.val(result);
				}

			}
		});
		/*
		 * showfrontframe({ title : "upload", url : url, w : 650, h : 500,
		 * callback : callback });
		 */
	}

	/**
	 * 为URL添加参数
	 * 
	 * @param {}
	 *            pathname
	 * @param {}
	 *            pathFieldId
	 * @param {}
	 *            viewid
	 * @param {}
	 *            allowedTypes
	 * @param {}
	 *            maximumSize
	 * @param {}
	 *            fileSaveMode
	 * @param {}
	 *            url
	 * @return {}
	 */
	function addParameters(pathname, pathFieldId, viewid, allowedTypes,
			maximumSize, fileSaveMode, url) {
		var oField = jQuery("#" + pathFieldId);
		var oView = jQuery("#" + viewid);

		if (allowedTypes) {
			url += '&allowedTypes=' + allowedTypes;
		}

		if (maximumSize) {
			url += '&maximumSize=' + maximumSize;
		}

		if (fileSaveMode) {
			// 自定义
			url += '&fileSaveMode=' + fileSaveMode;
		} else {
			// 系统
			url += '&fileSaveMode=00';
		}

		return url;
	}

	/**
	 * 获取返回值
	 * 
	 * @param {}
	 *            oField
	 * @return {}
	 */
	function getReturnValue(oField, rtn) {
		if (rtn == null || rtn == 'undefined') {
			isReloadFile = false;
			if (oField && oField.val()) {
				rtn = oField.val();
			} else {
				rtn = '';
			}
		} else {
			isReloadFile = true;
		}
		return rtn;
	}

	$.fn.obpmUploadField = function() {
		return this.each(function() {
			var $field = jQuery(this);
			var tagName = $field.attr("tagName");
			if(tagName=="ImageUploadField"){
				$field.obpmWeixinImageUpload();
				return;
			}
			var id = $field.attr("id");
			var disabled = $field.attr("disabled");
			var readonly = (disabled == 'disabled');
			var callbakFunction = $field.attr("callbakFunction");
			var path = $field.attr("path");
			var fileSaveMode = $field.attr("fileSaveMode");
			var application = $field.attr("application");
			var value = $field.attr("value");
			var name = $field.attr("name");
			var maxsize = $field.attr("maxsize");
			var uploadList = $field.attr("uploadList");
			var text = $field.html();
			var refreshOnChanged = $field.attr("refreshOnChanged");

			var uploadLabel = $field.attr("uploadLabel");
			var filelabel = $field.attr("filelabel");
			var deleteLabel = $field.attr("deleteLabel");
			var limitsize = $field.attr("limitsize");
			var limitNumber = $field.attr("limitNumber");
			
			var fileType = $field.attr("fileType");
			var customizeType = $field.attr("customizeType");
			var limitType = $field.attr("limitType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");

			var imgHeight = $field.attr("imgHeight");
			var imgWidth = $field.attr("imgWidth");
			var layoutType = $field.attr("_layoutType");
			
			var subGridView = $field.attr("subGridView");
			var discript = $field.attr("discript");

			value = value ? value : "";
			subGridView = (subGridView == 'true');
			discript = discript ? HTMLDencode(discript) : name;
			
			text = text ? text : "";
			var horizontalClass = "";
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			var data = {
					id : id,
					name : name,
					tagName : tagName,
					value : value,
					discript : discript,
					uploadList : uploadList,
					uploadLabel : uploadLabel,
					readonly : readonly,
					readOnlyShowValOnly : (readOnlyShowValOnly == "true"),
					horizontalClass : horizontalClass
			};

			var _callback = function() {

				refreshUploadList(jQuery("#" + id).attr("value"), uploadList,
					readonly, refreshOnChanged, application,subGridView, disabled);
			};
			
			var $html = $(template("fileUpload-tmpl", data));
			if(!readonly){

				$html.find(".btnAdd").bind("click", function() {
					uploadFrontFile(filelabel + uploadLabel, path, id,
						'_viewid', limitType, maxsize,fileSaveMode, _callback, 
						application,limitNumber, fileType, customizeType);
				});
			}
			
			$field.before($html);
			// 描述
			if($field.attr("moduleType") != "uploadFileRefresh"){
				$field.attr("moduleType","uploadFileRefresh").css("display","none");
			}
			
			refreshUploadListSub(jQuery("#" + id).attr("value"), uploadList, 
				readonly, refreshOnChanged,
				application, subGridView, disabled);
		});
	};
	$.fn.obpmViewImageUpload = function() {
		return this
				.each(function() {
					var $field = jQuery(this);
					var imgw = $field.attr("imgw");
					var imgh = $field.attr("imgh");
					var viewReadOnly = $field.attr("viewReadOnly");
					var docId = $field.attr("docId");
					var docFormid = $field.attr("docFormid");
					var url = $field.attr("url");
					var fileName = $field.attr("fileName");

					viewReadOnly = (viewReadOnly == "true") ? true : false;
					var imgwHalf = imgh / 2;
					var isSubGridView = jQuery("#obpm_subGridView").size() > 0 ? true
							: false;

					var html = "<div  class='bigImg' style='position:relative;width:"
							+ imgw + "; height:" + imgh + "'>";
					if (viewReadOnly) {
						html += "<img alt='" + fileName + "' border='0' src='"
								+ url + "' width='" + imgw + "' height='"
								+ imgh + "' />";
					} else {
						html += "<a ";
						if (!isSubGridView) {
							html += " href=\"javaScript:viewDoc('" + docId
									+ "','" + docFormid + "')\"";
						}
						html += " title='" + fileName + "'>";
						html += "<img alt='" + fileName + "' border='0' src='"
								+ url + "' width='" + imgw + "' height='"
								+ imgh + "' />";
						html += "</a>";
					}
					html += "<div  class='smallIcon' style='display:none;position:absolute;right:0px;top:"
							+ imgwHalf
							+ "px;z-index:100;'><a class='imgClick' href='"
							+ url + "' target='blank'>";
					html += "<img alt='"
							+ fileName
							+ "' border='0' src='../resource/images/picture_go.png' title='点击查看原图' /></a><div>";
					html += "</div>";
					var $html = $(html);
					$html.mouseover(function(event) {
						event.stopPropagation();
						jQuery(this).find(".smallIcon").show();
					}).mouseout(function(event) {
						event.stopPropagation();
						jQuery(this).find(".smallIcon").hide();
					});
					$field.replaceWith($html);
				});
	};

})(jQuery);