(function($) {
	var ALBUM = false;//指定来源不能为相册

    function takePhoto(el){
        var $this = $(el);
        if($this.find(".pan").length>0) return;
        var id = $this.data("id");
        var oField = jQuery("#"+ id);
        var img = jQuery("#"+ id+"_img");

        //判断接口
        var ua = window.navigator.userAgent;
		//indexOf() 方法可返回某个指定的字符串值在字符串中首次出现的位置
        if(ua.indexOf("myApps") >= 0){
            var _nativeAPI = top.nativeAPI ? top.nativeAPI : nativeAPI;
            _nativeAPI.upload({
                fileSaveMode: '00',//存盘模式，默认值‘00’
                path: 'ITEM_PATH',//存盘路径，默认值‘ITEM_PATH’
                fieldId: id,//表单控件 id
                applicationId: appId,//软件应用 id
                count: 1, // 文件数量，默认 9，当文件数量 1 时，仅允许选择一个文件
                sourceType: ['camera'],//['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                success: function (res) {
                    var datas = JSON.parse(res);
                    for (var i=0;i<datas.length;i++) {
                        var path = datas[i].path; // 路径 url
                        var name = datas[i].name; // 文件名称
                        var size = datas[i].size; // 文件大小
                        var type = datas[i].type; // 文件类型（拓展名）

                        oField.val(path);
                        //attr() 方法设置或返回被选元素的属性值。
						img.attr("src",contextPath+path).show();

                    }

                }
            });

        }else{
            var _wx = top.wx ? top.wx : wx;
            _wx.chooseImage({
                count: 1, // 默认9
                sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
                sourceType: ALBUM? ['album','camera']:['camera'], // 可以指定来源是相册还是相机，默认二者都有
                success: function (res) {
                    var localIds = res.localIds;
                    setTimeout(function(){
                        _wx.uploadImage({
                            localId: localIds[0],
                            success: function (res) {
                                var serverId = res.serverId;
                                $.get(contextPath+"/portal/weixin/jsapi/upload.action",{"serverId":serverId},function(result){
                                    if(result.status==1){
                                        //todo 构建json
                                        oField.val(result.data);
                                        img.attr("src",localIds[0]).show();
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

	function previewImage(el){
		var $this = $(el);
		var current = $this.attr("src");
		if(current && current.length>0){
			var _wx = top.wx ? top.wx : wx;
			_wx.previewImage({
			    current: current, // 当前显示图片的http链接
			    urls: [] // 需要预览的图片http链接列表
			});
		}
	}
	$.fn.obpmTakePhoto = function() {
		return this.each(function() {
			
			var $field = jQuery(this);
			var contextPath = $field.attr("contextPath");
			var value = $field.attr("value");
			var id = $field.attr("id");
			var imgw = $field.attr("imgw");
			var imgh = $field.attr("imgh");
			var name = $field.attr("name");
			var tagName = $field.attr("tagName");
			var discript = HTMLDencode($field.attr("discript"));
			var disabled = $field.attr("disabled");
			var displayType = $field.attr("displayType");
			var layoutType = $field.attr("_layoutType");
			var hiddenValue = $field.attr("_hiddenValue");
			
			ALBUM = $field.attr("album")=="true"; 
			
			var hideStyle = "",
				style = "",
				btnHideStyle = "",
				readonly = false,
				disabledClazz = "",
				PhotoIcon = "&#xe60f;",
				horizontalClass = "";
				
			
			discript = discript? discript : name;
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			if(displayType == PermissionType_HIDDEN){
				hideStyle = ";display:none;";
			}else{
				hiddenValue = "";
			}
			if(displayType == PermissionType_DISABLED || displayType == PermissionType_READONLY){
				readonly = true, disabledClazz = "ban", PhotoIcon = "&#xe610;";
				btnHideStyle = ";display:none;";
			}
			
			if(value.indexOf("photo.png")>=0){
				style = ";display:none;";
			}
			
			var data = {
				id : id,
				name : name,
				value : value,
				style : style,
				btnHideStyle : btnHideStyle,
				tagName : tagName,
				discript : discript,
				photoIcon : PhotoIcon,
				hideStyle : hideStyle,
				contextPath : contextPath,
				disabledClazz : disabledClazz,
				horizontalClass : horizontalClass,
				hiddenValue : hiddenValue
			};
			var $html = $(template("takePhoto-tmpl", data));
			if(!readonly){
				$html.find(".btn-photo").bind("click",function(){
					if(displayType != PermissionType_DISABLED && displayType != 1){
						takePhoto(this);
					}
				});
			}
			$html.replaceAll($field);
			$html.find("div.btn-box-pic").each(function () {  				
  				new RTP.PinchZoom($(this));
  			});
		});
	};
})(jQuery);