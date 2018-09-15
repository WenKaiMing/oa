(function($) {
	var isNoDeleteFile = true;
	var isReloadFile = false;
	var file = {
			"down" : 1,
			"up" : 0
	}
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
			refresh, applicationid, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name) {
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
						subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name));
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
	
	//文件下载
	function _downloadFile(name,path){
		var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ encodeURI(name) + "&filepath=" + path);
		var _tmpwin = window.open(url,"_blank");
		_tmpwin.location.href = url;
	}

	// 文件附件
	function refreshUploadList(fileFullName, uploadListId, readonly, refresh,
			applicationid, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name) {
		refreshUploadListSub(fileFullName, uploadListId, readonly, refresh,
				applicationid, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name);
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
			applicationid, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name) {
		var files = JSON.parse(fileFullName);
		var divContent = '';
		divContent += '<div class="hidepic" id="' + uploadListId + 'showFileDiv"' + 'style="background:transparent;text-align:left;left:0px;top:17px;"></div>';

		var toNewHtml = "";
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
			isPreView = isPreViewFile(_file) ;
			

			// 获取文件类型 根据类型给文件赋予前置图标
			var _id = _file.showName.substring(0,
					_file.showName.lastIndexOf(".")).toLowerCase();
			var fileType = _file.showName.substring(
					_file.showName.lastIndexOf(".")).toLowerCase();
			
			imgCss = fileTypeJudge(fileType);	//根据文件扩展名返回不同的class
			isPreView = (isPreView || imgCss == "img");	//图片可预览
			
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
			var firstUp = false;
			var lastDown = false;
			if(i == 0){
				firstUp = true;
			}
			if(i == files.length-1){
				lastDown = true;
			}
			var data = {
					'isPreView': isPreView+"",
					'_id':_id,
					'webPath': _file.webPath,
					'showName': _file.showName,
					'realName': _file.realName,
					'url': _file.url,
					'extname': fileType,
					'imgCss': imgCss,
					'title' : title,
					'readonly': readonly,
					'supportSorting': supportSorting,
					'firstUp' : firstUp,
					'lastDown' : lastDown
			};
			

		var html = template("fileUpload-tmpl", data);
		toNewHtml += html;
		}
		var $fileContent = jQuery("#" + uploadListId).html(divContent);
		
		$fileContent.find('.hidepic').html(toNewHtml);
		if($fileContent.width() < 400){
			$fileContent.find('.hidepic').find(".showOperate").show();
			$fileContent.find('.operate').addClass("small hide");
		}
		$fileContent.find(".item").each(function(index) {
			$(this).find(".fieldName").bind("click",function() {	//预览或下载文件
				
				var $me = $(this);
				
				var isPreViewCount = $me.attr("isPreViewCount");
				
				if(isPreViewCount == null || isPreViewCount == ""){
					isPreViewCount = 1 ;
				}else{
					isPreViewCount = parseInt(isPreViewCount);
				}
				
				var isPreView = $me.attr("isPreView");
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
						//OBPM.message.showError("服务器转换环境未成功配置，请联系管理员");
						_downloadFile(file.showName, file.webPath);
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
							OBPM.message.showInfo("预览文件正在转换中，请稍后");
							return;
						}else{
							_downloadFile(file.showName, file.webPath);
						}
					}
				}else{
					_downloadFile(file.showName, file.webPath);
				}
				
			});
			$(this).find(".first_delete").bind("click",function(){
				var $item = $(this).parents(".item").siblings().find(".sub_deleteBox").removeClass("show animationsDown").addClass("hide");
				var $deleteBox = $(this).next(".sub_deleteBox");
				if($deleteBox.hasClass("hide")){
					$deleteBox.removeClass("hide").addClass("show animationsDown");
				}else{
					$deleteBox.removeClass("show animationsDown").addClass("hide");
				}
			});
			$(this).find(".sub_cancel").bind("click",function(){
				var $deleteBox = $(this).parents(".sub_deleteBox");
				$deleteBox.removeClass("show animationsDown").addClass("hide");
			});
			$(this).find(".del").bind("click", function(e){	//删除文件
				e.stopPropagation();
				deleteOneFile(index,uploadListId,refresh,
						applicationid,subGridView,disabled, waterMark, previewEdit,openWaterMark,supportSorting,name);
			});
			$(this).find(".fieldload").bind("click", function(e){	//下载文件
				var $me = $(this).parents(".item").find(".fieldName");
				var file = {
						 webPath : $me.attr("data-webPath"),
						 showName : $me.attr("data-showName"),
						 realName : $me.attr("data-realName")
				};
				_downloadFile(file.showName, file.webPath);
			});
			$(this).find(".showOperate").bind("click", function(e){	 //当文件上传控件宽度小于400时，操作隐藏成一个图标点击展开
				$(this).parents(".item").siblings().find(".operate").removeClass("show").addClass("hide")
				var $operation = $(this).parents(".item").find(".operate");
				if($operation.hasClass("hide")){
					$operation.removeClass("hide").addClass("show");
				}else{
					$operation.removeClass("show").addClass("hide");
				}
			});
			$(this).find(".sort>.down").bind("click",function(){	//文件向下排序
				var down = file.down;	//向下
				sortFile(down,index,uploadListId,'false',
						applicationid,subGridView,disabled, waterMark, previewEdit,openWaterMark,supportSorting,name)
			});
			$(this).find(".sort>.up").bind("click",function(){	//文件向上排序
				var up = file.up;	//向上
				sortFile(up,index,uploadListId,'false',
						applicationid,subGridView,disabled, waterMark, previewEdit,openWaterMark,supportSorting,name)
			});
		});
		$("body").bind("click",function(e){
			 var $deleteBox = $("body").find(".hidepic").find(".sub_deleteBox.show");
			 var $firstDelete = $deleteBox.prev(".first_delete");
			//当删除操作面板出现时点击除操作面板以外的地方也隐藏面板
			 if(!$(e.target).closest(".sub_deleteBox").length &&
				!$(e.target).closest(".first_delete").length &&
				$deleteBox.size()>0){//点击class类为pm-proj-list之外的地方触发
					$deleteBox.removeClass("show animationsDown").addClass("hide");
					event.stopPropagation();
			 }
			 var $operatePanel = $("body").find(".hidepic").find(".operate.show");
			 //当文件上传控件宽度小于400时，操作面板出现时点击除操作面板以外的地方也隐藏操作面板
			 if(!$(e.target).closest(".operate.small").length && 
				!$(e.target).closest(".showOperate").length && 
				$operatePanel.size()>0){//点击class类为pm-proj-list之外的地方触发
				 $operatePanel.removeClass("show").addClass("hide");
				 	event.stopPropagation();
				}
		});
	}
	//向下向上排序返回文件字符串
	function swapItems(arr, index1, index2){
		 arr[index1] = arr.splice(index2, 1, arr[index1])[0];
	     return arr;
	} 
	//文件排序
	function sortFile(type,index,uploadListId,refresh,
			applicationid,subGridView,disabled, waterMark, previewEdit,openWaterMark,supportSorting,name){
		var url = contextPath+"/portal/dynaform/document/updateFileSorting.action";
		
		var itemName  = name;
		
		var oldField = jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1));
		oldObj = JSON.parse(oldField.val());
		if(type){
			var newObj = swapItems(oldObj, index, index + 1);
		}else{
			var newObj = swapItems(oldObj, index, index - 1);
		}
		var value = JSON.stringify(newObj);
		var params = {
			"docId" : $("#_docid").val(),
			"formId" : $("#formid").val(),
			"applicationId" : applicationid,
			"itemName" : itemName ,
			"value" : value
		}
		jQuery.ajax( {
			type : 'POST',
			async : false,
			url : url ,
			dataType : 'text',
			data : params ,
			success : function(result) {
				result = JSON.parse(result);
				if(result.status){
					oldField.val(JSON.stringify(result.datas));
					refreshUploadList(JSON.stringify(result.datas), uploadListId, false, refresh,
							applicationid, subGridView,
							disabled,waterMark,previewEdit,openWaterMark,supportSorting,name);
				}else{
					OBPM.message.showError("移动失败");
				}
			}
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
		var _WebUser = {};
		if(typeof WebUser == "undefined" && typeof parent.WebUser == "object"){
			_WebUser = parent.WebUser;
		}else{
			_WebUser = WebUser;
		}
		var url = encodeURI(contextPath
				+ "/portal/share/common/preview/preview.jsp?action=" + edit + "&path="
				+ file.webPath + "&name=" + file.realName+"&showName="+file.showName
				+ "&waterMark=" + waterMark + "&openWaterMark=" + openWaterMark +"&curEditUserId="+_WebUser.id);
		
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
			subGridView, disabled, waterMark, previewEdit,openWaterMark,supportSorting,name) {
				var files = [];
				var filefullname = "";
				var oldstr = jQuery("#" + id.substring(id.indexOf("_") + 1)).val();// 用于恢复数据
				
				var oField = jQuery("#" + id.substring(id.indexOf("_") + 1));
				files = JSON.parse(oField.val());
				var _file = files[index];
				var webpath = "";
				if(_file){
					webpath = files[index].path;
				}
				
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
						$("#"+id).parents(".upload-box").find("input.uploadinput").removeAttr("disabled");
						refreshUploadList(filefullname, id, false, refresh,
								applicationid, subGridView,
								disabled,waterMark,previewEdit,openWaterMark,supportSorting,name);
						filefullname = "";
					},
					error : function(x) {
						jQuery("#" + id.substring(id.indexOf("_") + 1))
						.val(oldstr);
					}
				});
	}

	function refreshImgListSub(fileFullName, uploadListId, myheigh, mywidth,
			readonly, refresh, applicationid, subGridView) {
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
					divContent += '<a data-index="' + i + '" id="'
							+ uploadListId
							+ 'pic0" href="#" href="'
							+ url
							+ '"  rel="lightbox" target="_blank">';
//				}
				if (fileFullName.indexOf("pdf") == -1) {
					divContent += '<img  src="../../..' + url + '" width='
							+ mywidth + ' data-original="' + contextPath + url + '" height=' + myheigh + ' border="0" '
							+ ' />';
				} else {
					divContent += '<font size=2 color=red>' + fileFullName
							.substring(fileFullName.lastIndexOf("/") + 1) + '</font>';
				}
				divContent += '</a>';
				divContent += '</div>';
				
				divContent += "<div class='upbtns-panel' " +
					"style='overflow: hidden;'>" +
					"<span class='upbtn-cancel'>删除</span>" +
					"</div>";
				divContent += '</div>';

				if(jQuery("#" + uploadListId).find("[data-name='"+image[i].name+"']").size()<=0){
					
					jQuery("#" + uploadListId).append(divContent);
					
					var $divContent = jQuery("#" + uploadListId).find("[data-name='"+image[i].name+"']");
					
					if(!readonly){
						$divContent.on( 'mouseenter', function() {
							$(this).find(".upbtns-panel").stop().animate({height: 30});
					    });
						$divContent.on( 'mouseleave', function() {
							$(this).find(".upbtns-panel").stop().animate({height: 0});
					    });
					}
					
					$divContent.find("a").on("click",function(){
						var _index = $(this).attr("data-index");
						jQuery("#" + uploadListId).viewer('destroy').viewer({
							url : 'data-original',
							navbar : false,
							shown : function(){
								$(this).viewer('view', _index);
							}
						}).viewer('show');
						return false;
					});
					
					$divContent.find(".upbtn-cancel").click(function(){
						var _id = $(this).parents(".upload-pic-box").data("id");
						var _name = $(this).parent().parent().data("name");
						var _images = JSON.parse($("#" + _id).val());
						var $picBox = $(this).parent().parent();

						var callback = function(result){
							if(result == true){
								$picBox.remove();
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
						};
						
						if(top.OBPM.message.showConfirm){
							top.OBPM.message.showConfirm("删除","你确定删除当前文件吗？此操作不可恢复！",callback);
						}else{
							OBPM.message.showConfirm("删除","你确定删除当前文件吗？此操作不可恢复！",callback);
						}
					});

					$divContent.find(".showhidefilepic").click(function() {
						showFileDialog(this, fileFullName
								.substring(fileFullName.lastIndexOf("/") + 1),
								url, readonly);
					});

					$divContent.find(".showhidefilepic").each(function() {
						showUploadPic(0, uploadListId, fileFullName, applicationid);
					});
					
				}
				
				

			}
		} else {
			jQuery("#" + uploadListId).html('');
		}
	}

	// refresh iamge uploaded list
	function refreshImgList(fileFullName, uploadListId, myheigh, mywidth,
			readonly, refresh, applicationid, subGridView) {
		refreshImgListSub(fileFullName, uploadListId, myheigh, mywidth,
				readonly, refresh, applicationid, subGridView);
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
			
			$(obj).viewer({
				navbar: false
			}).viewer('show');
			
			//url = contextPath + webPath;
			//showImageEffect(url);
			//obj.target = "_blank";
			//obj.href = url;
			//obj.triggerHandler("click");
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
	 * 前台删除文件()
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 */
	function deleteFrontFile(valueField, uploadListId, applicationid) {
		// 删除URL
		OBPM.message.showConfirm("删除","你确定删除全部文件吗？此操作不可恢复！",function(result){
			if(result == true){
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
		});
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
		jQuery("#" + uploadListId).parents(".upload-box").find("input.uploadinput").removeAttr("disabled");
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
				+ '/portal/H5/resource/component/upload/selectFile/selectFile.jsp?path=' + pathname;
		url = addParameters(pathname, pathFieldId, viewid, allowedTypes,
				maximumSize, fileSaveMode, url);
		url += '&applicationid=' + applicationid;
		url += '&limitNumber=' + (limitNumber-files.length);
		url += '&fileType=' + fileType;
		url += '&customizeType=' + customizeType;
		if(limitNumber-files.length>0){
			OBPM.dialog.show( {
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
				//var rtn = getReturnValue(oField, result);
				var rtn = getReturnValue(oField, result);
				// 把上传的文件json格式 [{'name':'aaa.doc','path':'XXX'}] 放进文件上传控件的value
				var files = [];
				if (isReloadFile) {
					var fileStrs = result.split(";");
					/*if (oField && oField.val() && allowedTypes != 'image') {
						files = JSON.parse(oField.val());
					}*/
					if (oField && oField.val()) {
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
				+ '/portal/H5/resource/component/upload/selectFile/selectFile.jsp?path=' + pathname
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
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");

			var uploadLabel = $field.attr("uploadLabel");
			var filelabel = $field.attr("filelabel");
			var deleteLabel = $field.attr("deleteLabel");
			var limitsize = $field.attr("limitsize");
			var limitNumber = $field.attr("limitNumber");
			var tagName = $field.attr("tagName");
			var fileType = $field.attr("fileType");
			var customizeType = $field.attr("customizeType");
			var limitType = $field.attr("limitType");
			var openWaterMark = $field.attr("openWaterMark") == "true" ? true : false;
			var waterMark = $field.attr("waterMark");
			var previewEdit = $field.attr("previewEdit") == "true" ? !readonly : false;
			var supportSorting = $field.attr("supportSorting") == "true" ? true : false;
			var displayType 

			var imgHeight = $field.attr("imgHeight");
			var imgWidth = $field.attr("imgWidth");

			var subGridView = $field.attr("subGridView");

			value = value ? value : "";
			subGridView = (subGridView == 'true');

			var html = "";
			$field.siblings("div.upload-box").remove();
			var $uploadBox = $("<div class='upload-box'></div>");
			var $btnBox = "";
			// td1
			if (limitType == "image") {
				var _btnBox ="<div class='upload-pic-box' data-id='"+id+"' style='"
				_btnBox += "'></div>";
				$btnBox = $(_btnBox);
				
			}else{
				$btnBox = $("<div style='display: block;' ></div>");
			}
			

			text = text ? text : "";
			value = value ? value : "";
			if (subGridView) {
				var divHtml = "<div name='" + name + "_gridView' value='"
						+ value + "' fieldType='" + tagName
						+ "' style='display:none;'>" + text + "</div>";
				var $divHtml = $(divHtml);
				$divHtml.appendTo($btnBox);
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
				var uploadHtml = "";
				if (limitType == "image") {
					uploadHtml = "<div class='uploadinput' " +
							"style='height:"+imgHeight+"px; width:"+imgWidth+"px; display: table-cell; vertical-align: middle; text-align: center;";
					if(readonly){
						uploadHtml += "cursor: not-allowed;";
					}else{
						uploadHtml += "cursor: pointer;";
					}
					
					uploadHtml += "border: 3px dashed #e6e6e6;color: #e6e6e6;font-size: 24px;'>" +
							"<span class='glyphicon glyphicon-picture' aria-hidden='true'></span>" +
							"</div>";
				}else{
					uploadHtml += "<div class='btn btnAdd'><image src='../../H5/resource/component/upload/images/addTo.png'/>" + uploadLabel + "</div>";
				}
				
				
				var $uploadHtml = $(uploadHtml);
				if(!readonly){
					$uploadHtml.bind("click", function() {
						uploadFrontFile(filelabel + uploadLabel, path, id,
							'_viewid', limitType, maxsize,fileSaveMode, _callback, 
							application,limitNumber, fileType, customizeType);
					});
				}
				
				$uploadHtml.appendTo($btnBox);
			}
			
			
			// image
			if (limitType == "image") {
				var td2Html = "<div style='display: inline-block;position: relative;' id='" + uploadList
						+ "' GridType='uploadFile'></div>";
				var $td2Html = $(td2Html);
				
				
				$td2Html.prependTo($btnBox);

							
			} else {
				var td2Html = "<div style='display: block;'><div  id='"
						+ uploadList
						+ "' GridType='uploadFile'></div></div>";
				var $td2Html = $(td2Html);
				$uploadBox.append($td2Html);
			}
			
			$btnBox.appendTo($uploadBox);
			
			// 描述
			if($field.attr("moduleType") != "uploadFileRefresh"){
				$field.attr("moduleType","uploadFileRefresh").css("display","none");
			}
			$field.after($uploadBox);

			var _callback = function() {
				if (limitType == 'image') {
					if(jQuery("#" + id).val()!=""){

						refreshImgList(jQuery("#" + id).val(), uploadList,
							imgHeight, imgWidth, readonly,refreshOnChanged, 
							application, subGridView);

					}
				} else {
					refreshUploadList(jQuery("#" + id).val(), uploadList,
						readonly, refreshOnChanged, application, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name);
				}
			}, init = function() {
				if (limitType == 'image') {
					refreshImgListSub(jQuery("#" + id).val(), uploadList,
						imgHeight, imgWidth, readonly,refreshOnChanged, 
						application, subGridView);					
					
				} else {
					refreshUploadListSub(jQuery("#" + id).val(),uploadList, 
						readonly, refreshOnChanged,
						application, subGridView, disabled,waterMark,previewEdit,openWaterMark,supportSorting,name);
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
							+ "' border='0' src='../../resource/images/picture_go.png' title='点击查看原图' /></a><div>";
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