(function($) {
	var isNoDeleteFile = true;
	var isReloadFile = false;
	map = {};

	function FMFileInfo(fileFullName) {
		var index = fileFullName.lastIndexOf("/");
		var webIndex = fileFullName.lastIndexOf("/");

		this.webPath = fileFullName;
		this.realName = fileFullName.substring(webIndex + 1,
				fileFullName.length);
		this.showName = fileFullName.substring(index + 1, fileFullName.length);
		this.url = contextPath + this.webPath;
	}
	
	function refreshFMFileListSub(fileFullName, uploadListId, readonly, refresh, subGridView){
		if (jQuery.trim(fileFullName) !="" ) {
			var tempFileFullName = map[uploadListId] ? map[uploadListId] : "";
			if (jQuery.trim(tempFileFullName) !="" && isNoDeleteFile && isReloadFile) {
				fileFullName = tempFileFullName + ";" + fileFullName;
			}
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
					.val(fileFullName);
			var divContent = '';
			divContent += '<div class="hidepic" id="' + uploadListId + 'showFileDiv"' + 'style="background:#fff;text-align:left;z-index:100000;"></div>';
			divContent += '</div>';
			var str = fileFullName.split(";");
			var tohtml = "";
			for ( var i = 0; i < str.length; i++) {

				var info2 = new FMFileInfo(str[i]);
				tohtml += '<a title="'+ info2.showName +'" href=' + info2.url + ' target="_blank" style="margin-top:2px;white-space:nowrap;text-decoration: none" >'
						+ info2.showName + '</a>'
						+ '&nbsp;<a href=# type="deleteOne" index=' + i
						+ '>';
				if (!readonly) {
					tohtml += '<img  border="0" src="../../../resource/image/close.gif"/>';
				}
				tohtml += '</a><br/>';
			}

			var $fileContent = jQuery("#" + uploadListId).html(divContent);

			$fileContent.find('.hidepic').html(tohtml);

			$fileContent.find("a[type='deleteOne']").each(function(index) {
				$(this).click(function() {
					deleteOneFMFile(index, uploadListId, readonly, refresh, subGridView);
				});
			});
			
			var time;
			
			$fileContent.mouseover(function() {
				if (time) {
					window.clearTimeout(time);
				}
			});

			divContent = "";
		} else {
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
			.val(fileFullName);
			jQuery("#" + uploadListId).html('');
		}
		isNoDeleteFile = true;
		isReloadFile = false;
	}

	function refreshFMFileList(fileFullName, uploadListId, readonly, refresh, subGridView) {
		refreshFMFileListSub(fileFullName, uploadListId, readonly, refresh, subGridView);
		if (refresh) {
			if(subGridView){
				dy_view_refresh(uploadListId);
			}else{
				window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
			}
		}
	}
	

	function refreshFMImageListSub(fileFullName, uploadListId, myheigh, mywidth, readonly, refresh, subGridView) {
		map[uploadListId + "index"] = 0;
		map[uploadListId + "Imagewidth"] = mywidth;
		map[uploadListId + "Imageheigh"] = myheigh;

		if (jQuery.trim(fileFullName) !="") {
			var tempFileFullName = map[uploadListId] ? map[uploadListId] : "";
			if (jQuery.trim(tempFileFullName) !="" && isNoDeleteFile && isReloadFile) {
				fileFullName = tempFileFullName + ";" + fileFullName;
				map[uploadListId] = fileFullName;
			}
			map[uploadListId] = fileFullName;
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
					.val(fileFullName);
			var divContent = '';
			divContent += '<div class="container1" id="' + uploadListId
					+ 'div" style="width:' + mywidth + ';height:' + myheigh
					+ '">';
			divContent += '<ul class="slider1 slider2 ' + uploadListId + 'idSlider2" id="' + uploadListId + 'idSlider2">';

			var str = fileFullName.split(";");

			map[uploadListId + "maxindex"] = str.length;// map中保存相应图片控件的总数

			for ( var i = 0; i < str.length; i++) {
				var info3 = new FMFileInfo(str[i]);
				divContent += '<li><a href="' + info3.url
						+ '" rel="lightbox" title="' + info3.showName
						+ '" target="_blank">';
				if (str[i].indexOf("pdf") == -1) {
					divContent += '<img src="' + info3.url + '" width='
							+ mywidth + ' height=' + myheigh + ' border="0"/>';
				} else {
					var temp = str[i].lastIndexOf("/");
					var fileName = str[i].substr(temp + 1);
					divContent += '<font size=2 color=red>' + fileName + '</font>';
				}
				divContent += '</a></li>';
			}

			divContent += '</ul>';
			divContent += '<ul class="num">';
			divContent += '<li  title="" id="' + uploadListId
					+ 'showNumber" class="' + uploadListId + 'showNumber" style="width:30">' + 1 + '/' + str.length
					+ '</li>';
			divContent += '<li><img title="" type="previous" src="../../../resource/image/previous.png" '
			+ '/></li>';
			divContent += '<li><img title="" type="next" src="../../../resource/image/next.png"/></li><li>';
			if (!readonly) {
				divContent += '<a href=# type="delete"'
						+ '>' + '<img  border="0" src="../../../resource/image/close.gif"/>' + '</a>';
			}
			divContent += '</li></ul></div>';
			var $imageContent = jQuery("#" + uploadListId).html(divContent);
			$imageContent.find("a[type='delete']").click(function() {
				deleteOneImageFile(uploadListId, readonly, refresh, subGridView);
			});

			$imageContent.find("img[type='previous']").click(function() {
				doPrevious(uploadListId);
			});
			$imageContent.find("img[type='next']").click(function() {
				doNext(uploadListId);
			});

		} else {
			jQuery("#" + uploadListId).html('');
			map[uploadListId] = "";
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1)).val(fileFullName);
		}
		isNoDeleteFile = true;
		isReloadFile = false;
	}

	// 文件管理的图片文件
	function refreshFMImageList(fileFullName, uploadListId, myheigh, mywidth, readonly, refresh, subGridView) {
		refreshFMImageListSub(fileFullName, uploadListId, myheigh, mywidth, readonly, refresh, subGridView);
		if (refresh) {
			if(subGridView){
				dy_view_refresh(uploadListId);
			}else{
				window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
			}
		}
	}

	// 删除一个文件
	function deleteOneFMFile(index, id, readonly, refresh,subGridView) {
			if (!readonly) {
				if(confirm("你确定删除当前文件吗？此操作不可恢复！")){
					isNoDeleteFile = false;
					isReloadFile = false;
					var str = jQuery("#" + id.substring(id.indexOf("_") + 1)).val()
							.split(";");
					var filefullname = "";
					for ( var i = 0; i < str.length; i++) {
						if (i != index) {
							filefullname += str[i] + ";";
						}
					}
					filefullname = filefullname.substring(0, filefullname
							.lastIndexOf(";"));
					var oldstr = jQuery("#" + id.substring(id.indexOf("_") + 1)).val();
					jQuery("#" + id.substring(id.indexOf("_") + 1)).val(filefullname);
					jQuery.ajax({	
						type: 'POST',
						async:false,
						url: encodeURI(encodeURI(contextPath + "/portal/upload/fileManagerdelete.action")),
						dataType : 'text',
						data: jQuery("#document_content").serialize(),
						success:function(x) {
							refreshFMFileList(filefullname, id, readonly, refresh,subGridView);
						},
						error: function(x) {
							jQuery("#"+ id.substring(id.indexOf("_") + 1)).val(oldstr);
						}
					});
					filefullname = "";
				}
		}
	}

	// 删除图片文件
	function deleteOneImageFile(uploadListId, readonly, refresh,subGridView) {
			if (!readonly) {
				if(confirm("你确定删除当前文件吗？此操作不可恢复！")){
					isNoDeleteFile = false;
					isReloadFile = false;
					var filefullName = "";
					var filefullNameArry = jQuery(
							"#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
							.val().split(";");
		
					for ( var i = 0; i < filefullNameArry.length; i++) {
						if (i != map[uploadListId + "index"]) {
							filefullName += filefullNameArry[i] + ";";
						}
					}
					filefullName = filefullName.substring(0, filefullName
							.lastIndexOf(";"));
					var oldstr = jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1)).val();
					jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1)).val(filefullName);
					var myheigh = map[uploadListId + "Imageheigh"];
					var mywidth = map[uploadListId + "Imagewidth"];
					jQuery.ajax({	
						type: 'POST',
						async:false,
						url: encodeURI(encodeURI(contextPath + "/portal/upload/fileManagerdelete.action")),
						dataType : 'text',
						data: jQuery("#document_content").serialize(),
						success:function(x) {
							refreshFMImageList(filefullName, uploadListId, myheigh, mywidth, readonly, refresh,subGridView);
						},
						error: function(x) {
							jQuery("#"+ id.substring(id.indexOf("_") + 1)).val(oldstr);
						}
					});
				}
		}
	}

	// 图片显示效果图
	// 上一张图片
	function doPrevious(uploadListId) {
		if (map[uploadListId + "index"] > 0)
			map[uploadListId + "index"]--;
		showImg2(map[uploadListId + "index"], uploadListId);
		jQuery("." + uploadListId + "showNumber").html(
				(map[uploadListId + "index"] + 1) + "/"
						+ map[uploadListId + "maxindex"]);
	}
	// 下一张图片
	function doNext(uploadListId) {
		if (map[uploadListId + "index"] < map[uploadListId + "maxindex"] - 1)
			map[uploadListId + "index"]++;
		showImg2(map[uploadListId + "index"], uploadListId);
		jQuery("." + uploadListId + "showNumber").html(
				(map[uploadListId + "index"] + 1) + "/"
						+ map[uploadListId + "maxindex"]);
	}

	// 图片移动
	function showImg2(i, uploadListId) {
		jQuery("." + uploadListId + "idSlider2").stop(true, false).animate( {
			left : -(map[uploadListId + "Imagewidth"] * i)
		}, 800);
	}

	/**
	 * 删除文件
	 * 
	 * @param {}
	 *            valueField 文件路径保存字段
	 * @param {}
	 *            uploadListId
	 */
	function FMdeleteFile(valueField, uploadListId) {
		if(confirm("你确定删除全部文件吗？此操作不可恢复！")){
			var uploadListHtml = jQuery("#"+uploadListId).html();
			var uploadListIdValue = jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val();
			jQuery("#" + uploadListId).html('');
			 jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val("");
			jQuery.ajax({	
				type: 'POST',
				async:false,
				url: encodeURI(encodeURI(contextPath + "/portal/upload/fileManagerdelete.action")),
				dataType : 'text',
				data: jQuery("#document_content").serialize(),
				success:function(x) {
				},
				error: function(x) {
					//恢复数据
					jQuery("#" + uploadListId).html(uploadListHtml);
					 jQuery("#"+ uploadListId.substring(uploadListId.indexOf("_") + 1)).val(uploadListIdValue);
				}
			});	
			valueField.value = ''; // 清空值
			map[uploadListId] = "";
			isReUpload = true;
		}
	}

	/**
	 * 文件管理
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
	 *            layer 布局
	 * @param {}
	 *            fileSaveMode 文件保存模式
	 * @return {} 文件网络路径
	 */
	function FileManager(pathname, pathFieldId, viewid, allowedTypes,
			maximumSize, fileSaveMode, callback, applicationid) {
		var url = contextPath
				+ '/portal/share/component/filemanager/filemanager.jsp?path='
				+ pathname;
		var oField = document.getElementById(pathFieldId);

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
			url += '&fileSaveMode=' + 00;
		}
		// 系统
		url += '&applicationid=' + applicationid;

		hiddenDocumentFieldIncludeIframe();// in util.js
		showfrontframe({
			title : 'File Manager',
			url : url,
			w : 1000,
			h : 600,
			callback : function(result) {
				showDocumentFieldIncludeIframe();// //in util.js

				var rtn = result;
				if (result == null || result == 'undefined') {
					if (oField && oField.value) {
						isReloadFile = false;
						rtn = oField.value;
					} else {
						rtn = '';
					}
				} else {
					isReloadFile = true;
				}
				oField.value = rtn;
				if (callback && typeof (callback) == "function") {
					callback();
				}
			}
		});
	}

	$.fn.obpmFileManager = function() {
		return this.each(function() {
			var $field = jQuery(this);
			var id = $field.attr("id");
			var name =$field.attr("name");
			var fieldType =$field.attr("fieldType");
			var value = $field.attr("value");
			var maxsize = $field.attr("maxsize");
			var limitType = $field.attr("limitType");
			var disabled = $field.attr("disabled");
			var path = $field.attr("path");
			var fileSaveMode = $field.attr("fileSaveMode");
			var application = $field.attr("application");
			var readonly = (disabled == 'disabled');
			var imgWidth = $field.attr("imgWidth");
			var imgHeight = $field.attr("imgHeight");
			var uploadList = $field.attr("uploadList");
			var refreshOnChanged = $field.attr("refreshOnChanged");
			var fileManagerLabel = $field.attr("fileManagerLabel");
			var fileRemoveLabel = $field.attr("fileRemoveLabel");
			var subGridView = $field.attr("subGridView");
			subGridView =(subGridView=='true');
			
			var html = "<table><tr>";
				if(limitType == "file"){
					html +="<td style='border:0'>";
					html +="<div id='" + uploadList + "' GridType='fileManager'></div>";
					html +="</td>";
				}
				html +="<td style='border:0'>";
				if(limitType == "image"){
					html +="<div id='" + uploadList + "' GridType='fileManager'></div>";
				}
				html+="<input type='hidden' id='" + id +"' name='" + name + "' fieldType='" + fieldType + "' value='" + value + "' />";
				html += "<input type='button' value='" + fileManagerLabel
					+ "' name='btnFileManager' class='btnFileManager'";

			if (disabled && disabled != '') {
				html += " disabled='" + disabled + "' ";
			}
			var _callback = function() {
				if (limitType == "file") {
					refreshFMFileList(document.getElementById(id).value,
							uploadList, readonly, refreshOnChanged, subGridView);
				} else {
					refreshFMImageList(document.getElementById(id).value,
							uploadList, imgHeight, imgWidth, readonly,
							refreshOnChanged, subGridView);
				}
			},
			init = function(){
				if (limitType == "file") {
					refreshFMFileListSub(document.getElementById(id).value,
							uploadList, readonly, refreshOnChanged, subGridView);
				} else {
					refreshFMImageListSub(document.getElementById(id).value,
							uploadList, imgHeight, imgWidth, readonly,
							refreshOnChanged, subGridView);
				}
			};
			
			html += "/>";
			// 删除
			html += "<input class='FMdeleteFile' type='button' value='"
					+ fileRemoveLabel + "' name='btnDelete'";

			if (disabled && disabled != '') {
				html += " disabled='" + disabled + "' ";
			}

			html += "/>";
			html += "</td>";
			html += "</tr></table>";
			var $html=$(html);
			$html.find(".btnFileManager").click(function() {
					FileManager(path, id, '_viewid', limitType,maxsize, fileSaveMode, _callback,application);
			}).end().find(".FMdeleteFile").click(function() {
						FMdeleteFile(document.getElementById(id), uploadList);
			});
			$field.replaceWith($html);
			init();
		});
	};

	$.fn.obpmViewFileManager = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var imgw = $field.attr("imgw");
			var imgh = $field.attr("imgh");
			var str = $field.attr("str");
			var uploadListId = $field.attr("uploadListId");
			var viewReadOnly = $field.attr("viewReadOnly");
			map[uploadListId + "index"] = 0;
			map[uploadListId + "maxindex"] = str;
			map[uploadListId + "Imagewidth"] = imgw;
			viewReadOnly = (viewReadOnly=="true")?true:false;
			var imgwHalf = imgh/2;
			var isSubGridView = jQuery("#obpm_subGridView").size()>0?true:false;

			var html = "";
			html += "<div class='container1' id='" + uploadListId + "div' style='width:" + imgw + "; height:117px;'>";
			html += "<ul class='slider1 slider2 " + uploadListId + "idSlider2' id='" + uploadListId + "idSlider2'>";
			$field.find("[subType='aField']").each(function(){
				var $a = jQuery(this);
				var docId = $a.attr("docId");
				var docFormid = $a.attr("docFormid");
				var url = $a.attr("url");
				var fileName = $a.attr("fileName");
				html +="<li style='position:relative;' class='imgList'>";
				if(viewReadOnly){
					html += "<img border='0' alt='" + fileName +"'";
					html += " src='" + url + "' width='" + imgw + "' height='" + imgh + "' />";
				}else{
					html +="<a";
					if(!isSubGridView){
						html +=" href='javaScript:viewDoc(\"" + docId + "\",\"" + docFormid + "\")'";
					}
					html += " title='" + fileName + "'><img border='0' alt='" + fileName +"'";
					html += " src='" + url + "' width='" + imgw + "' height='" + imgh + "' /></a>";
				}
				html += "<div class='showImgIcon' style='display:none;position:absolute;right:0px;top:"+imgwHalf+"px;z-index:100;'><a cancelBubble = true;  class='imgClick' href='" + url + "' target='blank'><img alt='" + fileName + "' border='0' src='";
				html += "../../../resource/images/picture_go.png' title='点击查看原图' /></a><div></li>";
			});
			html += "</ul>";
			html += "<ul class='num'>";
			html += "<li  title='' id='" + uploadListId + "showNumber' class='" + uploadListId + "showNumber' style='width:30;'>" + 1 + "/" + str + "</li>";
			html += " <li><img title='' type='previous' src='../../../resource/image/previous.png' /></li>";
			html += " <li><img title='' type='next' src='../../../resource/image/next.png'/></li>";
			html += "</ul></div>";
			var $html=$(html);
			$html.find(".imgList").mouseover(function(event) {
				event.stopPropagation();
				jQuery(this).find(".showImgIcon").show();
			}).mouseout(function(event){
				event.stopPropagation();
				jQuery(this).find(".showImgIcon").hide();
			});
			$html.find("img[type='previous']").click(function(event) {
				event.stopPropagation();
				doPrevious(uploadListId);
			});
			$html.find("img[type='next']").click(function(event) {
				event.stopPropagation();
				doNext(uploadListId);
			});
			$field.replaceWith($html);
		});
	};
})(jQuery);