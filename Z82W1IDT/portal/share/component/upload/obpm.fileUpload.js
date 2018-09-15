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
			refresh, applicationid,  subGridView, disabled,waterMark,previewEdit,openWaterMark) {
		if (fileFullName == "clear") {
			jQuery("#" + uploadListId).html(''); // 清空显示值
			// map[uploadListId] = "";
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
					.val("");
		} else {
			if (fileFullName != "") {
				var $fileContent = jQuery("#" + uploadListId);
				$fileContent.empty();
				$fileContent.append(getDivContent(fileFullName, uploadListId,
						readonly, refresh, applicationid, 
						subGridView, disabled,waterMark,previewEdit,openWaterMark));
			} else {
				jQuery("#" + uploadListId).html('');
				jQuery(
						"#"
								+ uploadListId.substring(uploadListId
										.indexOf("_") + 1)).val("");
				// map[uploadListId] = '';
			}
		}
		// isNoDeleteFile = true;
		// isReloadFile = false;
	}

	// 文件附件
	function refreshUploadList(fileFullName, uploadListId, readonly, refresh,
			applicationid,  subGridView, disabled, waterMark, previewEdit,openWaterMark) {
		refreshUploadListSub(fileFullName, uploadListId, readonly, refresh,
				applicationid,  subGridView, disabled, waterMark, previewEdit,openWaterMark);
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
		var fileName = _file.realName;
		var fileType = fileName.substr(fileName.lastIndexOf("."));
		switch(fileType){
		case ".doc":case ".docx":case ".xls":case ".xlsx":case ".pdf":
		case ".txt":case ".rtf":case ".et":case ".ppt":case ".pptx":
		case ".dps":case ".pot":case ".pps":case ".wps":case ".html":
		case ".htm":case ".jpg":case ".jpeg":case ".png":case ".gif":
		case ".bmp":
			return true;
		default:
			return false;
		}
	}

	// 获得显示列表
	function getDivContent(fileFullName, uploadListId, readonly, refresh,
			applicationid,  subGridView, disabled,waterMark,previewEdit,openWaterMark) {
		var files = JSON.parse(HTMLDencode(fileFullName));
		var divContent = '';
		divContent += '<div class="hidepic" id="' + uploadListId + 'showFileDiv"' + 'style="background:transparent;width:text-align:left;left:0px;top:17px;"></div>';

		var tohtml = "";
		var filehtml = "";
		for ( var i = 0; i < files.length; i++) {
			var _file = new FMFileInfo(files[i]);
			if(files[i].path == "ERROR"){
				alert(files[i].name);
				continue;
			}
			var isImg = false;
			var imgCss = "";

			var isPreView = false;	// 判断文档是否可预览(OFFIC文档)
			isPreView = isPreViewFile(_file);
			

			// 获取文件类型 根据类型给文件赋予前置图标
			var _id = _file.showName.substring(0,
					_file.showName.lastIndexOf(".")).toLowerCase();
			var fileType = _file.showName.substring(
					_file.showName.lastIndexOf(".")).toLowerCase();
			
			imgCss = fileTypeJudge(fileType);	//根据文件扩展名返回不同的class
			isPreView = (isPreView || imgCss == "img");	//图片可预览
			
			tohtml += '<span class="showOptions btn" isPreView="' + isPreView + '" data-id="' + _id + '" data-webPath="' + _file.webPath 
				+ '" data-showName="' + _file.showName + '" data-realName="' + _file.realName + '"' 
				+ 'data-url="' + _file.url + '" data-extname="' + fileType + '"' 
				+ 'data-url="' + _file.url + '" data-extname="' + fileType + '" style="display:inline-block;position:relative;z-index:1;margin-right:5px;white-space: nowrap;">';
			tohtml += '<a class="pic ' + imgCss + '"></a>';
			var uploadbtnid = "#" + uploadListId.substring(uploadListId.indexOf("_") + 1)+"_upload"
			var limitnumber = $(uploadbtnid).attr("limitnumber");
			if(files.length==limitnumber){
				$(uploadbtnid).attr("disabled",true);
			}else{
				$(uploadbtnid).attr("disabled",false);
			}

			var title = _file.showName;
			var fileType = title.substring(title.lastIndexOf("."))
					.toLowerCase();
			var fileName = title.substring(0, title.lastIndexOf("."));
			if (fileName != null && fileName.length > 8) {
				title = fileName.substring(0, 7) + ".."
						+ fileName.charAt(fileName.length - 1) + fileType;
			}

			tohtml += '<a type="show" style="cursor:pointer;">' + title + '</a>';
			if(!readonly){//只读状态下不显示删除按钮
				tohtml += '<a class="del">x</a>';
			}
			tohtml += '</span>';
		}

		var $fileContent = jQuery("#" + uploadListId).html(divContent);

		$fileContent.find('.hidepic').html(tohtml);

		$fileContent.find(".showOptions").each(function(index) {
			//预览
			$(this).bind("click",function() {
				var $me = $(this);
				var isPreView = $me.attr("isPreView");
				var isPreViewCount = $me.attr("isPreViewCount");
				
				if(isPreViewCount == null || isPreViewCount == ""){
					isPreViewCount = 1 ;
				}else{
					isPreViewCount = parseInt(isPreViewCount);
				}
				
				var file = {
						 webPath : $me.attr("data-webPath"),
						 showName : $me.attr("data-showName"),
						 realName : $me.attr("data-realName")
				};
				
				if(isPreView == "true"){
					var previewEnabled = false ; 
					DWREngine.setAsync(false);
					FormHelper.PreviewEnabled(function(result){
						if(result == true){
							previewEnabled = true ;
						}
					});
					DWREngine.setAsync(true);
					if(!previewEnabled){
						//showMessage("error","服务器转换环境未成功配置，请联系管理员");
						downloadFile(file.showName, file.webPath);
						return;
					}
					
					var _isPreView = false ;
					//判断相应的pdf文件是否转换成功
					DWREngine.setAsync(false);
					if(!isImgFile($me.attr("data-extName"))){
						if($me.attr("data-extName").toUpperCase() == ".PDF"){
							_isPreView = true ;
						}else{
							FormHelper.hasPdfFile(file.webPath, file.realName, function(result) {
								_isPreView = result;
							});
						} 
					}else{
						_isPreView = true ;
					}
					DWREngine.setAsync(true);
					
					//如果为可预览的文件
					if(_isPreView == "true" || _isPreView == true){
						previewFile(file, waterMark, previewEdit, openWaterMark);
					}else{
						if(isPreViewCount < 7){
							isPreViewCount ++ ;
							$me.attr("isPreViewCount",isPreViewCount)
							showMessage("info","预览文件正在转换中，请稍后");
							return;
						}else{
							downloadFile(file.showName, file.webPath);
						}
					}
				}else{
					downloadFile(file.showName, file.webPath);
				}
			});
			//删除文件
			$(this).find(".del").bind("click", function(e){
				e.stopPropagation();
				deleteOneFile(index, uploadListId, refresh,
						applicationid, subGridView, disabled, waterMark, previewEdit,openWaterMark);
			});
			//显示和隐藏删除图标
			$(this).bind("mouseenter", function(){
				$(this).find(".del").show();
			}).bind("mouseleave", function(){
				$(this).find(".del").hide();
			});
		});
	}
	
	function isImgFile(extName){
		switch(extName){
		case ".jpg":case ".jpeg":case ".png":case ".gif":case ".bmp":
			return true;
		default:
			return false;
		}
	}

	/**
	 * 文件预览
	 */
	function previewFile(file,waterMark,previewEdit,openWaterMark) {
		var edit = previewEdit == true ? "edit" : "";
		var url = encodeURI(contextPath
				+ "/portal/share/common/preview/preview.jsp?action=" + edit + "&path="
				+ file.webPath + "&name=" + file.realName+"&showName="+file.showName
				+ "&waterMark=" +waterMark + "&openWaterMark=" + openWaterMark  +"&curEditUserId="+WebUser.id);
		
		var _tmpwin = window.open(url, "_blank");
		_tmpwin.location.href = url;
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
			subGridView, disabled, waterMark, previewEdit,openWaterMark) {
		if (confirm("你确定删除当前文件吗？此操作不可恢复！")) {
			var files = [];
			var filefullname = "";
			var oldstr = jQuery("#" + id.substring(id.indexOf("_") + 1)).val();// 用于恢复数据

			var oField = jQuery("#" + id.substring(id.indexOf("_") + 1));
			files = JSON.parse(oField.val());
			var webpath = files[index].path;
			files.splice(index, 1);
			if (files.length > 0) {
				filefullname = JSON.stringify(files);
			}

			oField.val(filefullname);

			
			var data = jQuery("#document_content").serialize();
			var url = data.indexOf("applicationid") > 0 ? 
						encodeURI(encodeURI(contextPath+ "/portal/upload/deleteOne.action?fileFullName="+ webpath)) :
							encodeURI(encodeURI(contextPath+ "/portal/upload/deleteOne.action?fileFullName="+ webpath+"&applicationid="+applicationid))
			jQuery.ajax( {
						type : 'POST',
						async : false,
						url : url ,
						dataType : 'text',
						data : data ,
						success : function(x) {
							refreshUploadList(filefullname, id, false, refresh,
									applicationid, subGridView, disabled, waterMark, previewEdit,openWaterMark);
							filefullname = "";
						},
						error : function(x) {
							jQuery("#" + id.substring(id.indexOf("_") + 1))
									.val(oldstr);
						}
					});

		}
	}

	function refreshImgListSub(fileFullName, uploadListId, myheigh, mywidth,
			readonly, refresh, applicationid,  subGridView) {
		if (jQuery.trim(fileFullName) != "" && fileFullName != "clear") {
			var image = JSON.parse(fileFullName);
			
			for(var i = 0; i < image.length; i++){
				fileFullName = image[i].path;
				var divContent = '';

				var urlIndex = fileFullName.lastIndexOf("_/uploads");
				var url = fileFullName;
				if (urlIndex >= 0) {
					url = fileFullName.substring(urlIndex + 1);
				}
				
				
				
				divContent += '<div data-name="'+image[i].name+'" style="display: inline-block;position: relative;margin-right:5px">';
				divContent += '<div>';
//				if (opentype == "dialog") {
//					divContent += '<a id="'
//							+ uploadListId
//							+ 'pic0" href="#" class="showhidefilepic" '
//							+ ' rel="lightbox" title="'
//							+ fileFullName
//									.substring(fileFullName.lastIndexOf("/") + 1)
//							+ '; ">';
//				} else {
					divContent += '<a id="'
							+ uploadListId
							+ 'pic0" href="../../..'
							+ url
							+ '"  rel="lightbox" title="'
							+ fileFullName
									.substring(fileFullName.lastIndexOf("/") + 1)
							+ '" target="_blank">';
//				}
				if (fileFullName.indexOf("pdf") == -1) {
					divContent += '<img  src="../../..' + url + '" width='
							+ mywidth + ' height=' + myheigh + ' border="0" '
							+ '/>';
				} else {
					divContent += '<font size=2 color=red>' + fileFullName
							.substring(fileFullName.lastIndexOf("/") + 1) + '</font>';
				}
				divContent += '</a>';
				divContent += '</div>';
				
				divContent += "<div class='upbtns-panel' " +
					"style='display:none;position: absolute;top: 0px;right: 0px;font-size: 16px;font-weight: bold;" +
					"padding: 5px;background: rgb(255, 255, 255);cursor: pointer;'>×</div>";
				divContent += '</div>';

				if(jQuery("#" + uploadListId).find("[data-name='"+image[i].name+"']").size()<=0){
					
					jQuery("#" + uploadListId).append(divContent);
					
					var $divContent = jQuery("#" + uploadListId).find("[data-name='"+image[i].name+"']");
					
					if(!readonly){
						$divContent.on( 'mouseenter', function() {
							$(this).find(".upbtns-panel").show();
					    });
						$divContent.on( 'mouseleave', function() {
							$(this).find(".upbtns-panel").hide();
					    });
					}
					
					$divContent.find(".upbtns-panel").click(function(){
						if(confirm("确定删除？")){
							var _id = $(this).parents(".upload-pic-box").data("id");
							var _name = $(this).parent().data("name");
							var _images = JSON.parse($("#" + _id).val());
							$(this).parent().remove();
							var fileName ;
							for(var i = 0; i < _images.length; i++){
								if(_images[i].name == _name){
									fileName = _images[i].path ;
									_images.splice(i,1)
								}
							}
							
							if(fileName != null){//删除系统中的图片
								deleteImageFile(fileFullName);
							}
							
							$("#" + _id).val(JSON.stringify(_images));
						}
					});

					$divContent.find(".showhidefilepic").click(
							function() {
								showFileDialog(this, fileFullName
										.substring(fileFullName.lastIndexOf("/") + 1),
										url, readonly);
							});

					$divContent.find(".showhidefilepic").each(function() {
						showUploadPic(0, uploadListId, fileFullName, applicationid);
					});
					$divContent.find("#"+uploadListId+"pic0").click(function(){
						var _src = $(this).find("img").attr("src");
						var tmp = "<div id='images-preview-panel' style='position: fixed;width: 100%;top: 0px;bottom: 0px;z-index: 10;display:none'>" +
							"<div class='images-preview-pic' style='position: absolute;width:100%;top:0;bottom:0;z-index: 11;text-align: center;'>" +
							"<img style='display:none;position: absolute;top:50%;left:50%;max-width:90%;max-height:90%;overflow:hidden;' /></div>" +
							"<div class='images-preview-mask' style='position: absolute;width: 100%;top: 0px;bottom: 0px;background-color: rgba(0, 0, 0, 0.6);'></div>" +
							"</div>";
						$("body").append(tmp);
						$("#images-preview-panel").find("img").attr("src",_src);
						$("#images-preview-panel").show();
						var picHeight = $("#images-preview-panel").find("img").height();
						var picWidth = $("#images-preview-panel").find("img").width();
						$("#images-preview-panel").find("img").css({"display":"block","marginTop":-(picHeight/2),"marginLeft":-(picWidth/2)});
						$("#images-preview-panel").on("click",function(){
							$("#images-preview-panel").remove();
						});
						return false;
					});
				}
				
				/*$content = jQuery("#" + uploadListId).html(divContent);
				$content.find(".showhidefilepic").click(
						function() {
							showFileDialog(this, fileFullName
									.substring(fileFullName.lastIndexOf("/") + 1),
									url, readonly);
						});

				$content.find(".showhidefilepic").each(function() {
					showUploadPic(0, uploadListId, fileFullName, applicationid);
				});*/
			}
			
			

		} else {
			jQuery("#" + uploadListId).html('');
		}
	}

	// refresh iamge uploaded list
	function refreshImgList(fileFullName, uploadListId, myheigh, mywidth,
			readonly, refresh, applicationid,  subGridView) {
		refreshImgListSub(fileFullName, uploadListId, myheigh, mywidth,
				readonly, refresh, applicationid,  subGridView);
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
			//url = contextPath + webPath;
			//obj.target = "_blank";
			//obj.href = url;
			//obj.triggerHandler("click");
			$(obj).viewer({
				navbar: false
			}).viewer('show');
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
	 * 前台删除图片文件
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 */
	function deleteImageFile(fileFullName) {
		var url = contextPath + "/portal/upload/delete.action?fileFullName="+ fileFullName;
		jQuery.ajax( {
			type : 'POST',
			async : false,
			url : encodeURI(url),
			dataType : 'text',
			data : jQuery("#document_content").serialize(),
			success : function(x) {
			},
			error : function(x) {
			}
		});
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
			data : jQuery("#document_content").serialize(),
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
			files = JSON.parse(oField.val());
		}
		
		var url = contextPath
				+ '/portal/share/component/upload/upload.jsp?path=' + pathname;
		url = addParameters(pathname, pathFieldId, viewid, allowedTypes,
				maximumSize, fileSaveMode, url);
		url += '&applicationid=' + applicationid;
		url += '&limitNumber=' + (limitNumber-files.length);
		url += '&fileType=' + fileType;
		url += '&customizeType=' + customizeType;
		if(limitNumber-files.length>0){
			OBPM.dialog.show({
				width : 700,
				height : 450,
				url : url,
				args : {
					"webPath" : "aaaaaaaa",
					"readonly" : "222222"
				},
				title : title,
				close : function(result) {
					showDocumentFieldIncludeIframe();// //in util.js
					var oField = jQuery("#" + pathFieldId);
					var rtn = getReturnValue(oField, result);
					// 把上传的文件json格式 [{'name':'aaa.doc','path':'XXX'}] 放进文件上传控件的value
					var files = [];
					if (isReloadFile) {
						var fileStrs = result.split(";");
						if (oField && oField.val() && allowedTypes != 'image') {
							files = JSON.parse(oField.val());
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
					oField.val(rtn);
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
				+ '/portal/share/component/upload/upload.jsp?path=' + pathname
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
			var tagName = $field.attr("tagName");
			var fileType = $field.attr("fileType");
			var customizeType = $field.attr("customizeType");
			var limitType = $field.attr("limitType");
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");

			var imgHeight = $field.attr("imgHeight");
			var imgWidth = $field.attr("imgWidth");
			var openWaterMark = $field.attr("openWaterMark") == "true" ? true : false;
			var waterMark = $field.attr("waterMark");
			var previewEdit = $field.attr("previewEdit") == "true" ? !readonly : false;

			var subGridView = $field.attr("subGridView");
			subGridView = (subGridView == 'true');

			var html = "";
			var $tableHtml = $("<table></table>");
			var $trHtml = $("<tr></tr>");

			// td1
				var $td1Html = $("<td  class='upload-pic-box' data-id='"+id+"' style='border:0;white-space:nowrap' ></td>");

				text = text ? text : "";
				value = value ? value : "";
				if (subGridView) {
					var divHtml = "<div name='" + name + "_gridView' value='"
							+ value + "' fieldType='" + tagName
							+ "' style='display:none;'>" + text + "</div>";
					var $divHtml = $(divHtml);
					$divHtml.appendTo($td1Html);
				}
				// image
				if (limitType == "image") {
					var td2Html = "<div style='border:0' id='" + uploadList
							+ "' GridType='uploadFile'></div>";
					var $td2Html = $(td2Html);
					$td2Html.appendTo($td1Html);
				} else {
					var td2Html = "<td style='border:0'><div  id='"
							+ uploadList
							+ "' GridType='uploadFile'></div></td>";
					var $td2Html = $(td2Html);
					$trHtml.append($td2Html);
				}
				// inputHidden
				var inputHtml = "<input type='hidden' name='" + name
						+ "' value='" + value + "' fieldType='" + tagName
						+ "' id='" + id + "'/>";
				var $inputHtml = $(inputHtml);
				if($field.attr("moduleType") != "uploadFileRefresh"){
					$field.before($inputHtml);
				}
				
				if(!(readonly && readOnlyShowValOnly == "true")){//只读状态下不显示上传和下载按钮
					// uploadinput
					var uploadHtml = "<input class='uploadinput' type='button'  value='"
							+ uploadLabel + "' name='btnSelectDept'";
					if (disabled && disabled != '') {
						uploadHtml += " disabled='" + disabled + "' ";
					}
					uploadHtml += "/>";
					var $uploadHtml = $(uploadHtml);
					$uploadHtml.bind(
							"click",
							function() {
								uploadFrontFile(filelabel + uploadLabel, path, id,
										'_viewid', limitType, maxsize,
										fileSaveMode, _callback, application,
										limitNumber, fileType, customizeType);
							}).appendTo($td1Html);
	
					// deleteinput
//					var delHtml = "<input class='uploaddelete' type='button' name='btnDelete'  value='"
//							+ deleteLabel + "'";
//					if (disabled && disabled != '') {
//						delHtml += " disabled='" + disabled + "' ";
//					}
//					delHtml += "/>";
//					var $delHtml = $(delHtml);
//					$delHtml.bind("click", function() {
//	
//						deleteFrontFile(jQuery("#" + id), uploadList, application);
//					}).appendTo($td1Html);
				}

				// 描述
				$trHtml.append($td1Html).appendTo($tableHtml);
				if($field.attr("moduleType") != "uploadFileRefresh"){
					$field.attr("moduleType","uploadFileRefresh")
						.css("display","none");
				}
				$field.after($tableHtml);

				var _callback = function() {

					if (limitType == 'image') {
						refreshImgList(jQuery("#" + id).val(), uploadList,
								imgHeight, imgWidth, readonly,
								refreshOnChanged, application, 
								subGridView);
					} else {
						refreshUploadList(jQuery("#" + id).val(), uploadList,
								readonly, refreshOnChanged, application,
								 subGridView, disabled,waterMark,previewEdit,openWaterMark);
					}
				}, init = function() {
					if (limitType == 'image') {
						refreshImgListSub(jQuery("#" + id).val(), uploadList,
								imgHeight, imgWidth, readonly,
								refreshOnChanged, application, 
								subGridView);
					} else {
						refreshUploadListSub(jQuery("#" + id).val(),
								uploadList, readonly, refreshOnChanged,
								application,  subGridView, disabled,waterMark,previewEdit,openWaterMark);
					}
				};
				init();
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
							+ "' border='0' src='../../../resource/images/picture_go.png' title='点击查看原图' /></a><div>";
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