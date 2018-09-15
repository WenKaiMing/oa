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
	// 文件附件
	function refreshUploadList(fileFullName, uploadListId, readonly, refresh,
			applicationid, opentype) {
		if (fileFullName == "clear") {
			jQuery("#" + uploadListId).html(''); // 清空显示值
			map[uploadListId] = "";
			jQuery("#" + uploadListId.substring(uploadListId.indexOf("_") + 1))
					.val("");
		} else {
			if (jQuery.trim(fileFullName) != "") {
				var tempFileFullName = map[uploadListId] ? map[uploadListId]
						: "";
				if (tempFileFullName !="" && isNoDeleteFile && isReloadFile) {
					fileFullName = tempFileFullName + ";" + fileFullName;
				}
				map[uploadListId] = fileFullName;
				jQuery(
						"#"
								+ uploadListId.substring(uploadListId
										.indexOf("_") + 1)).val(fileFullName);

				var $fileContent = jQuery("#" + uploadListId);

				$fileContent.empty();

				$fileContent.append(getDivContent(fileFullName, uploadListId,
						readonly, refresh, applicationid, opentype));

			} else {
				jQuery("#" + uploadListId).html('');
			}
		}
		isNoDeleteFile = true;
		isReloadFile = false;
		if (refresh != 'false') {
			window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
		}
	}

	// 显示文件列表
	function showUploadPic(index, id, webPath, applicationid) {
		if (jQuery("#" + id + "pic" + index).size() != 0) {
			var url = encodeURI(encodeURI(contextPath
					+ "/portal/upload/fileInfor.action?applicationid="
					+ applicationid + "&fileFullName=" + webPath));
			jQuery.post(url, function(x) {
				// 提交成功回调
					jQuery("#" + id + "pic" + index).html(x);
					jQuery("#" + id + "pic" + index).css("display", "block");
					setTimeout("hiddenUploadPic('" + index + "','" + id + "')",
							5000);
				});
		} else {
			jQuery("#" + id + "pic" + index).css("display", "block");
			setTimeout("hiddenUploadPic('" + index + "','" + id + "')", 5000);
		}
	}
	// 隐藏文件列表
	function hiddenUploadPic(index, id) {
		jQuery("#"+ id + "pic" + index).css("display","none");
	}
	// 获得显示列表
	function getDivContent(fileFullName, uploadListId, readonly, refresh,
			applicationid, opentype) {
		var info1 = new FMFileInfo(fileFullName.split(";")[0]);
		var str = fileFullName.split(";");
		var divContent = '';
		divContent += '<div style="position:relative;width:190px;white-space:nowrap;">';
		if(opentype=="dialog"){
			divContent += '<a href="#" title="'+ info1.showName +'" showName="'+ info1.showName +'" url="' + str[0] + '" class="showpic1" type="showpic" style="float:left;width:116px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;" >' + info1.showName + '</a>';
		}else{
		divContent += '<a title="'+ info1.showName +'" type="showpic" style="float:left;width:116px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;"  href=' + info1.url
				+ ' target="_blank" >' + info1.showName + '</a>';
		}
		divContent += '&nbsp;<a type="deleteOne" href=# index="0" style="width:10px;">';
		if (!readonly) {
			divContent += '<img  border="0" src="../../../resource/image/close.gif"/>';
		}
		divContent += '</a>';

		divContent += '<div id="'
				+ uploadListId
				+ 'pic0" style="background-color: #F4F4F4;display:none;position: absolute;left:0px;top:0px;margin-top:20px;width: 400px;height: 20px;z-index:1000;"></div>';
		
		if (fileFullName.split(";").length > 1) {
			divContent += '<span id="moreFileDiv">(more...)</span>';
		}
		divContent += '<div class="hidepic" id="' + uploadListId + 'showFileDiv"' + 'style="background:#fff;width:150px;text-align:left;display:none;position:absolute;left:0px;top:17px;z-index:100;"></div>';
		
		divContent += '</div>';
		
		var tohtml = "";
		for ( var i = 1; i < str.length; i++) {

			var info2 = new FMFileInfo(str[i]);
			if(opentype=="dialog"){
				tohtml += '<div><a href="#" url='+str[i]+' showName='+ info2.showName + ' class="showpic1" type="showpic" style="float:left;width:116px;*width:113px;margin-top:2px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;text-decoration: none" >'
				+ info2.showName + '</a>'
				+ '&nbsp;<a href=# type="deleteOne" index=' + i + '>';
			}else{
			tohtml += '<div><a href=' + info2.url + ' type="showpic" target="_blank" style="float:left;width:116px;*width:113px;margin-top:2px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;text-decoration: none" >'
					+ info2.showName + '</a>'
					+ '&nbsp;<a href=# type="deleteOne" index=' + i
					+ '>';
			}
			if (!readonly) {
				tohtml += '<img  border="0" src="../../../resource/image/close.gif"/>';
			}
			tohtml += '</a></div>';

			divContent += '<div id="'
					+ uploadListId + 'pic'+ i
					+ '" style="background-color: #F4F4F4;display:none;position: absolute;margin-top:25px;width: 400px;height: 20px;z-index:1000;"></div>';
			
		}

		var $fileContent = jQuery("#" + uploadListId).html(divContent);

		$fileContent.find('.hidepic').html(tohtml);

		$fileContent.find("a[type='deleteOne']").each(function(index) {
			$(this).click(function() {
				deleteOneFile(index, uploadListId, refresh,applicationid, opentype);
			});
		});
		var time2;
		$fileContent.find("a[type='showpic']").each(function(index) {
			$(this).hover(function() {
				showUploadPic(index, uploadListId, str[index],applicationid);
				if (time2) {
					clearTimeout(time2);
					time2=null;
				}
			},function(){
				hiddenUploadPic(index, uploadListId);
				clearTimeout(time2);
				time2 = window.setTimeout(function() {
					hiddenUploadPic(index, uploadListId);
				}, 300);
			});
		});
		//当打开方式为弹出层时
			$fileContent.find(".showpic1").each(function() {
				$(this).click(function(){
					var showName= $(this).attr("showName");
					var url =$(this).attr("url");
					showFileDialog(this,showName,url);
				});
			});

		var time;
		$fileContent.mouseout(function() {
			time = window.setTimeout(function() {
				$fileContent.find(".hidepic").css("display", "none");
			}, 300);
		});

		$fileContent.find("#moreFileDiv").mouseover(function() {
			$fileContent.find(".hidepic").css("display", "block");
			if (time) {
				window.clearTimeout(time);
			}
		});
		
		$fileContent.mouseover(function() {
			if (time) {
				window.clearTimeout(time);
			}
		});

		divContent = "";
	}

	// 删除一个文件
	function deleteOneFile(index, id, refresh, applicationid, opentype) {
		if(confirm("你确定要删除文件吗？")){
			isNoDeleteFile = false;
			isReloadFile = false;
			var webpath = "";
			var str = jQuery("#" + id.substring(id.indexOf("_") + 1)).val().split(
					";");
			var filefullname = "";
			if (str.length != 1) {
				for ( var i = 0; i < str.length; i++) {
					if (i == index) {
						webpath = str[i];
					}
				}
			} else {
				webpath = jQuery("#" + id.substring(id.indexOf("_") + 1)).val();
			}

			var str = jQuery("#" + id.substring(id.indexOf("_") + 1)).val().split(
					";");
			var filefullname = "";
			if (str.length == 1) {
				filefullname = "";
				jQuery("#" + id.substring(id.indexOf("_") + 1)).val("");
			} else {
				if (str && str.length > 0) {
					for ( var i = 0; i < str.length; i++) {
						if (i != index) {
							filefullname += str[i] + ";";
						} else if (str[0] == webpath) {
							filefullname = "";
						}
					}

					filefullname = filefullname.substring(0, filefullname
							.lastIndexOf(";"));
				}
			}
			refreshUploadList(filefullname, id, false, refresh, applicationid,
					opentype);
			filefullname = "";
	     }
	}

	// refresh iamge uploaded list
	function refreshImgList(fileFullName, uploadListId, myheigh, mywidth,
			readonly, refresh, applicationid, opentype) {
		if (fileFullName !="" && fileFullName != "clear") {
			var divContent = '';
			divContent += '<div>';
			if (opentype == "dialog") {
				divContent += '<a href="#" class="showhidefilepic" ' + ' rel="lightbox" title="' + fileFullName
						.substring(fileFullName.lastIndexOf("/") + 1) + '">';
			} else {
				divContent += '<a href="'
						+ contextPath
						+ fileFullName
						+ '"  rel="lightbox" title="'
						+ fileFullName
								.substring(fileFullName.lastIndexOf("/") + 1)
						+ '" target="_blank">';
			}
			if (fileFullName.indexOf("pdf") == -1) {
				divContent += '<img  src="../../..' + fileFullName
						+ '" width=' + mywidth + ' height=' + myheigh
						+ ' border="0" ' + '/>';
			} else {
				divContent += '<font size=2 color=red>' + fileFullName
						.substring(fileFullName.lastIndexOf("/") + 1) + '</font>';
			}
			divContent += '</a>';
			divContent += '&nbsp;&nbsp;';
			divContent += '</div>';
			divContent += '<div id="' + uploadListId + '0" style="background-color: #F4F4F4;display:none;position: absolute;width: 500px;height: 20px;"></div>';

			$content = jQuery("#" + uploadListId).html(divContent);
			$content.find(".showhidefilepic").click(
					function() {
						showFileDialog(this, fileFullName
								.substring(fileFullName.lastIndexOf("/") + 1),
								fileFullName);
					});

			$content.find(".showhidefilepic").mouseover(function() {
				showUploadPic(0, uploadListId, fileFullName, applicationid);
			});
			$content.find(".showhidefilepic").mouseout(function() {
				hiddenUploadPic(0, uploadListId);
			});

		} else {
			jQuery("#" + uploadListId).html('');
		}
		if (refresh != 'false') {
			window.setTimeout("dy_refresh('" + uploadListId.substring(uploadListId.indexOf("_") + 1) + "')",500);
		}
	}
	// 弹出层来加载文件为了处理乱码问题
	function showFileDialog(obj, name, webPath) {
		var url = "";
		var fileType = name.substring(name.lastIndexOf("."));
		if (fileType == ".doc" || fileType == ".docx" || fileType == ".xls"
				|| fileType == ".xlsx") {
			url = contextPath + '/portal/share/component/upload/ntkoofficecontrol.jsp';
			OBPM.dialog.show( {
				opener : window.parent.parent,
				width : 1000,
				height : 550,
				url : url,
				args : {
					"webPath" : contextPath + webPath
				},
				title : name,
				close : function(result) {

				}
			});
		} else {
			url = contextPath + webPath;
			obj.target = "_blank";
			obj.href = url;
		}
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
		if(confirm("你确定删除全部文件吗？")){
		this.url = contextPath + "/portal/upload/delete.action?applicationid="
				+ applicationid + "&fileFullName=" + valueField.val();
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
		jQuery("#" + uploadListId).html(''); // 清空显示值
		valueField.val(''); // 清空值
		map[uploadListId] = "";
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
		var url = contextPath
				+ '/portal/share/component/upload/upload.jsp?path=' + pathname;
		url = addParameters(pathname, pathFieldId, viewid, allowedTypes,
				maximumSize, fileSaveMode, url);
		url += '&applicationid=' + applicationid;
		url += '&limitNumber=' + limitNumber;
		url += '&fileType=' + fileType;
		url += '&customizeType=' + customizeType;
		OBPM.dialog.show({
			width : 700,
			height : 450,
			url : url,
			args : {},
			title : title,
			close : function(result) {
				showDocumentFieldIncludeIframe();// //in util.js
				var oField = jQuery("#" + pathFieldId);
				var rtn = getReturnValue(oField, result);
				oField.val(rtn);
				if (callback && typeof (callback) == "function") {
					callback();
				}
			}
		});
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
			width : 700,
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
			url += '&fileSaveMode=' + 00;
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
			if (oField && oField.val()) {
				isReloadFile = false;
				rtn = oField.val();
			} else {
				rtn = '';
			}
		} else {
			isReloadFile = true;
		}
		return rtn;
	}