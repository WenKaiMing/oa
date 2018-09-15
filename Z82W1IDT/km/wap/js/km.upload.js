KM.Upload = {
	//初始化webuploader
	webUploader : function(){
		// 初始化Web Uploader
	    KM.Util.cache.uploader = KM.Util.cache.uploader || WebUploader.create({
		    auto: true,
		    swf: 'webuploader/Uploader.swf',
		    server: contextPath+"/km/servlet/upload",
		    pick: '#filePicker'
		}); 

	    KM.Util.cache.uploader.on('all', function(type, file, data) {
			switch (type) {
			case 'fileQueued'://加入文件
				var upFile = {
					"id":file.id,
					"name":file.name,
					"status":"fileQueued"
				}
				KM.Util.cache.uploadFiles.push(upFile);
				KM.Util.cache.uploader.option( 'formData', {
		    		'nDirId':KM.Util.cache.nDirId
		    	});
				break;
			case 'uploadProgress'://上传文件
				var id = file.id
				for(var i=0;i<KM.Util.cache.uploadFiles.length;i++){
					if(KM.Util.cache.uploadFiles[i].id == id){
						KM.Util.cache.uploadFiles[i].status = "uploadProgress";
					}
				}
				break;
			case 'uploadSuccess'://上传成功
				delete data._raw;
				var fileStr = JSON.stringify(data);
				var params = {
					"file":fileStr,
					"nDiskId":diskIdOfMine
				}
				KM.Service.saveFile(params,function(){
					KM.Core.refreshList();
	            })
	            var id = file.id
				for(var i=0;i<KM.Util.cache.uploadFiles.length;i++){
					if(KM.Util.cache.uploadFiles[i].id == id){
						KM.Util.cache.uploadFiles[i].status = "uploadSuccess";
					}
				}
				break;
			case 'uploadComplete'://上传完成
				var id = file.id
				for(var i=0;i<KM.Util.cache.uploadFiles.length;i++){
					if(KM.Util.cache.uploadFiles[i].id == id){
						KM.Util.cache.uploadFiles[i].status = "uploadComplete";
					}
				}
				break;
			}
	    	KM.Core.upload.refreshUpList(type, file);
		});
	},
	
	takephoto : function(){
		var oField = jQuery("#onlinePhoto")
		var _wx = top.wx ? top.wx : wx;
		 _wx.chooseImage({
			 count: 1, // 默认9
			 sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			 sourceType: ALBUM? ['album','camera']:['camera'],
		     success: function (res) {
		        var localIds = res.localIds;
		        setTimeout(function(){
		            _wx.uploadImage({
				        localId: localIds[0],
				        success: function (res) {
				          var serverId = res.serverId;
							// 本地上传方法
				          $.get(contextPath+"/portal/weixin/jsapi/PMupload.action",{"serverId":serverId,"taskid":$("#form-create-task-id").val()},function(result){
					          if(result.status==1){
							 	$("#tmplUpload").tmpl(result).appendTo(".list");
								$(".list").find(".up-list[name='"+result.data+"']").find("i").hide();
								$(".list").find(".up-list[name='"+result.data+"']").find("img").attr("src",localIds[0]).show();
					          }
					       });
				        },
				        fail: function (res) {
				        	alert("网络异常，请再次尝试！");
				        }
					});
		        }, 100)
		    }
		});
	}
}



