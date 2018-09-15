/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/
/*
 * 文件上传与km连用-----------------------------------
 */
document.write("<script src='http://localhost:8080/obpm/km/script/jquery-ui/js/jquery-1.8.3.js'></script>");
document.write("<script src='http://localhost:8080/obpm/km/script/popup/script/jquery-framedialog.js'></script>");
document.write("<script src='http://localhost:8080/obpm/km/script/popup/script/jquery-ui-1.9.2.custom.dialog.min.js'></script>");
document.write("<script src='http://localhost:8080/obpm/km/script/popup/script/obpm-jquery-bridge.js'></script>");
document.write("<script src='http://localhost:8080/obpm/km/script/popup/script/ui.dialog.maximize.js'></script>");

//---------------------------------------------------

KindEditor.plugin('insertfile', function(K) {
	var self = this, name = 'insertfile',
		allowFileUpload = K.undef(self.allowFileUpload, true),
		allowFileManager = K.undef(self.allowFileManager, false),
		formatUploadUrl = K.undef(self.formatUploadUrl, true),
		uploadJson = K.undef(self.uploadJson, self.basePath + 'php/upload_json.php'),
		extraParams = K.undef(self.extraFileUploadParams, {}),
		filePostName = K.undef(self.filePostName, 'imgFile'),
		lang = self.lang(name + '.');
	self.plugin.fileDialog = function(options) {
		var fileUrl = K.undef(options.fileUrl, 'http://'),
			fileTitle = K.undef(options.fileTitle, ''),
			clickFn = options.clickFn;
		var html = [
			'<div style="padding:20px;">',
			'<div class="ke-dialog-row">',
			'<label for="keUrl" style="width:60px;">' + lang.url + '</label>',
			'<input type="text" id="keUrl" name="url" class="ke-input-text" style="width:160px;" /> &nbsp;',
			'<input type="button" class="ke-upload-button" value="' + lang.upload + '" /> &nbsp;',
			'<span class="ke-button-common ke-button-outer">',
			'<input type="button" class="ke-button-common ke-button" name="viewServer" value="' + lang.viewServer + '" />',
			'</span>',
			'</div>',
			//title
			'<div class="ke-dialog-row">',
			'<label for="keTitle" style="width:60px;">' + lang.title + '</label>',
			'<input type="text" id="keTitle" class="ke-input-text" name="title" value="" style="width:160px;" /></div>',
			'</div>',
			//form end
			'</form>',
			'</div>'
			].join('');
		var dialog = self.createDialog({
			name : name,
			width : 450,
			title : self.lang(name),
			body : html,
			yesBtn : {
				name : self.lang('yes'),
				click : function(e) {
					var url = K.trim(urlBox.val()),
						title = titleBox.val();
					if (url == 'http://' || K.invalidUrl(url)) {
						alert(self.lang('invalidUrl'));
						urlBox[0].focus();
						return;
					}
					if (K.trim(title) === '') {
						title = url;
					}
					clickFn.call(self, url, title);
				}
			}
		}),
		div = dialog.div;

		var urlBox = K('[name="url"]', div),
			viewServerBtn = K('[name="viewServer"]', div),
			titleBox = K('[name="title"]', div);

		if (allowFileUpload) {
			var uploadbutton = K.uploadbutton({
				button : K('.ke-upload-button', div)[0],
				fieldName : filePostName,
				url : K.addParam(uploadJson, 'dir=file'),
				extraParams : extraParams,
				afterUpload : function(data) {
					dialog.hideLoading();
					if (data.error === 0) {
						var url = data.url;
						if (formatUploadUrl) {
							url = K.formatUrl(url, 'absolute');
						}
						urlBox.val(url);
						if (self.afterUpload) {
							self.afterUpload.call(self, url, data, name);
						}
						alert(self.lang('uploadSuccess'));
					} else {
						alert(data.message);
					}
				},
				afterError : function(html) {
					dialog.hideLoading();
					self.errorDialog(html);
				}
			});
			uploadbutton.fileBox.change(function(e) {
				dialog.showLoading(self.lang('uploadLoading'));
				uploadbutton.submit();
			});
		} else {
			K('.ke-upload-button', div).hide();
		}
		if (allowFileManager) {
			viewServerBtn.click(function(e) {
				self.loadPlugin('filemanager', function() {
					self.plugin.filemanagerDialog({
						viewType : 'LIST',
						dirName : 'file',
						clickFn : function(url, title) {
							if (self.dialogs.length > 1) {
								K('[name="url"]', div).val(url);
								if (self.afterSelectFile) {
									self.afterSelectFile.call(self, url);
								}
								self.hideDialog();
							}
						}
					});
				});
			});
		} else {
			viewServerBtn.hide();
		}
		urlBox.val(fileUrl);
		titleBox.val(fileTitle);
		urlBox[0].focus();
		urlBox[0].select();
	};
	self.clickToolbar(name, function() {
		
		/*获取web应用contextPath 并不适用一个服务器多个部署*/
		var pathName = document.location.pathname;
	    var index = pathName.substr(1).indexOf("/");
	    var contextPath = pathName.substr(0,index+1);
	    //var hostName = window.location.host;
	    //var port = window.location.port;
	    //var httpProtocol = window.location.protocol;
	    
	    var jsonUrl =  contextPath + "/km/baike/component/kindeditor/plugins/insertfile/insertToKM.json";
		jQuery.getJSON(
				jsonUrl,
			    function(data) {
			        var url = contextPath + "/km/baike/upload/new.action?_type=2&_nDirId=" + data["nDirId"];
					OBPM.dialog.show({
						width : 800,
						height : 640,
						url : url,
						args : {},
						title : "上传",
						close : function(rtn) {
							//var title = "demo";
							if(rtn){
								//eval() 函数可将字符串转换为代码执行，并返回一个或多个值
								var arrFile = eval("(" + rtn + ")");
								for (var i=0; i<arrFile.length; i++) {
									var jsonFile = arrFile[i];
									var url = contextPath + "/km/disk/file/view.action?id="+jsonFile.id;
									var title = jsonFile.name;
									var html = '<a class="ke-insertfile" href="' + url + '" data-ke-src="' + url + '" target="_blank">' + title + '</a>'+"&nbsp;&nbsp;";
									self.insertHtml(html);
								}
							}
						}
					});
			});

		self.hideDialog().focus();
		
		
/*		self.plugin.fileDialog({
			clickFn : function(url, title) {
				var html = '<a class="ke-insertfile" href="' + url + '" data-ke-src="' + url + '" target="_blank">' + title + '</a>';
				self.insertHtml(html).hideDialog().focus();
			}
		});*/
		
	});
});
