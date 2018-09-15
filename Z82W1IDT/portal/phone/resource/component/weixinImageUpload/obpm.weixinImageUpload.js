;
/**
 * 微信端图片上传控件
 * @author Happy
 * @param $
 */
(function($){

	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		options.value = options.value || '';
		
		var images = options.value ? JSON.parse(options.value) :[];
		var showBtn = !(options.readonly && options.readOnlyShowValOnly == "true");
		var layoutType = options._layoutType;
		var horizontalClass = "";
		
		if(layoutType == LayoutType_Horizontal){
			horizontalClass = "flexbox";
		}
		var data = {
				id : options.id,
				discript : options.discript,
				discription : options.discription,
				name : options.name,
				value : options.value,
				readonly : options.readonly,
				showBtn : showBtn,
				contextPath : contextPath,
				list : images,
				horizontalClass : horizontalClass
		};
		
		var $html = $(template("imageUpload-tmpl", data));
		$html.replaceAll(t);
		$("body").append($(template("imageUploadPrev-tmpl", data)));
		return $html;
		
	}
	
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var panel = t.data("weixinImageUpload").panel;
		var options = _parseOptions(t);
		var $bigView = $("body").find(".preview-panel[_pid='"+t.attr("id")+"']");
		if(!(options.readonly)){
			//上传图片
			panel.on("click", ".btn-upload", function(){
				var options = t.data("weixinImageUpload").options;
				var vf = $("#"+options.id);
				var json = vf.val();
				var images = json? JSON.parse(json):[];
				if(images.length>=options.limitnumber){
					alert('最大只能上传'+options.limitnumber+'张图片哦，不能再继续添加啦！');
					return;
				}

                //判断接口
                var ua = window.navigator.userAgent;
//indexOf() 方法可返回某个指定的字符串值在字符串中首次出现的位置
                if(ua.indexOf("myApps") >= 0){
					_uploadImageWithNative(t);//手机系统原生上传接口
				}else{
					_chooseImage(t);//微信选择图片
				}
				
			});
			//删除
			$bigView.on("click", ".btn-delete-popup", function(){
				jQuery.confirm({
					trueCall:function(){
						var name = $bigView.find(".preview-item").data("name");
						_removeImage(t,name);
						$bigView.removeClass("active");
					},
					falseCall:function(){
						
					}
				})
			});
		}

		//预览图片
		panel.on("click", ".image-item", function(){
			var pid = $(this).parent().siblings("input").attr("id");
			var src = $(this).find("img").attr("src");
			var name = $(this).data("name");
			$bigView.find(".preview-item").attr("src",src);
			$bigView.find(".preview-item").data("name",name);
			$bigView.addClass("active");
			$("div.lookImg").each(function () {
  				new RTP.PinchZoom($(this), {});
  			});
		});
		
		//退出预览
		$bigView.on("click", ".btn-close", function(){
			$bigView.removeClass("active");
		});
		
	}
	
	function _onImageItemClick(item){
		var src = item.find("img").attr("src");
		var name = item.data("name");
		panel.find(".preview-item").attr("src",src);
		panel.find(".preview-item").data("name",name);
		panel.find(".preview-panel").addClass("active");
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.name = t.attr("name");
		options.discript = t.attr("discript");
		options.discription = HTMLDencode(t.attr("discript"))? HTMLDencode(t.attr("discript")):options.name;
		options.value = t.attr("value");
		options.limitnumber = parseInt(t.attr("limitNumber"));
		options.maxsize = t.attr("maxsize");
		options.refreshOnChanged = t.attr("refreshOnChanged");
		options.readOnlyShowValOnly = t.attr("readOnlyShowValOnly");
		options.readonly = (t.attr("disabled") == 'disabled');
		options.filesavemode = t.attr("filesavemode");
		options.path = t.attr("path");
		options._layoutType = t.attr("_layoutType");
		return options;
	}
	
	
	function _chooseImage(t){
		var panel = t.data("weixinImageUpload").panel;
		var options = t.data("weixinImageUpload").options;
		
		var vf = $("#"+options.id);
		var json = vf.val();
		var images = json? JSON.parse(json):[];
		var count = options.limitnumber - images.length;
		
		var _wx = top.wx ? top.wx : wx;
		 _wx.chooseImage({
			 count: count,
			 sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			 sourceType: ['album','camera'], // 可以指定来源是相册还是相机，默认二者都有
		     success: function (res) {
		        var localIds = res.localIds;
		        setTimeout(function(){
		        	_uploadImage(t,panel,_wx,localIds);
		        }, 200);
		      }
		    });
	}
	
	function _uploadImage(t,panel,_wx,localIds){
		var options = t.data("weixinImageUpload").options;
		var vf = $("#"+options.id);
		var json = vf.val();
		var images = json? JSON.parse(json):[];
		if(images.length>=options.limitnumber){
			alert('最大只能上传'+options.limitnumber+'张图片哦，不能再继续添加啦！');
			return;
		}
		var localId = localIds.pop();
		 _wx.uploadImage({
		        localId: localId,
		        isShowProgressTips: 1,// 默认为1，显示进度提示
		        success: function (res) {
		          var serverId = res.serverId;
		          var folder = options.filesavemode=="01"? options.path : "";//自定义存储路径
		          $.ajax({
		        	  url:contextPath+"/portal/weixin/jsapi/upload.action",
		        	  async:false,
		        	  type:"get",
		        	  data:{"serverId":serverId,"folder":folder},
		        	  dataType:"json",
		        	  success:function(result){
				          if(result.status==1){
				        	  var path = result.data;
				        	  var name = result.data.substring(result.data.lastIndexOf("/")+1,result.data.length);
				        	  var imageItem = $('<a data-ignore="push" class="image-item" data-name="'+name+'" data-path="'+path+'" ><img src="'+localId+'"/></a>');
				        	  imageItem.on("click",function(){
				        		  	var src = $(this).find("img").attr("src");
				      				var name = $(this).data("name");
					      			panel.find(".preview-item").attr("src",src);
					      			panel.find(".preview-item").data("name",name);
					      			panel.find(".preview-panel").addClass("active");
				        	  });
				        	  panel.find(".btn-upload").before(imageItem);
				        	  try {
				        		  _addImage(t,{name:name,path:path});
				        	  } catch (e) {
				        		  alert(e.stack.toString());
				        	  }
				        	  if(localIds.length>0){
				        		  _uploadImage(t,panel,_wx,localIds);
				        	  }
				          }
				       },
				       error : function (XMLHttpRequest, textStatus, errorThrown) {
				    	    // 通常 textStatus 和 errorThrown 之中
				    	    // 只有一个会包含信息
				    	    //this; // 调用本次AJAX请求时传递的options参数
				    	}
		          });
		        },
		        fail: function (res) {
		          alert("网络异常，请再次尝试！");
		        }
		      });
	}
	
	function _uploadImageWithNative(t){
		var panel = t.data("weixinImageUpload").panel;
		var options = t.data("weixinImageUpload").options;
		
		var vf = $("#"+options.id);
		var json = vf.val();
		var images = json? JSON.parse(json):[];
		var count = options.limitnumber - images.length;
		var appId = $(t).attr("application");

        var _nativeAPI = top.nativeAPI ? top.nativeAPI : nativeAPI;
		_nativeAPI.upload({
			fileSaveMode: '00',//存盘模式，默认值‘00’ 
			path: 'ITEM_PATH',//存盘路径，默认值‘ITEM_PATH’ 
			fieldId: options.id,//表单控件id 
			applicationId: appId,//软件应用id 
			count: count, // 文件数量，默认9，当文件数量1时，仅允许选择一个文件
			sourceType: ['album'],  //['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			success: function (res) {
				var datas = JSON.parse(res);
				for (var i = 0; i < datas.length; i++) { 
					var path = datas[i].path; // 路径url 
					var name = datas[i].name; // 文件名称 
					var size = datas[i].size; // 文件大小
					var type = datas[i].type; // 文件类型（拓展名） 
					var imageItem = $('<a data-ignore="push" class="image-item" data-name="'+name+'" data-path="'+path+'" ><img src="'+ contextPath + path +'"/></a>');
					imageItem.on("click",function(){
						var src = $(this).find("img").attr("src");
						var name = $(this).data("name");
						panel.find(".preview-item").attr("src",src);
						panel.find(".preview-item").data("name",name);
						panel.find(".preview-panel").addClass("active");
					});
					panel.find(".btn-upload").before(imageItem);
					try {
						_addImage(t,{name:name,path:path});
					} catch (e) {
						alert(e.stack.toString());
					}
				} 
			} 
		})
	}
	
	function _addImage(t,data){
		var options = t.data("weixinImageUpload").options;
		var vf = $("#"+options.id);
		var json = vf.val();
		var images = json? JSON.parse(json):[];
		images.push(data);
		vf.val(JSON.stringify(images));
	}
	
	function _removeImage(t,name){
		var state = t.data("weixinImageUpload");
		var panel =state.panel;
		var options = state.options;
		panel.find(".image-item").each(function(){
			var $this = $(this);
			if($this.data("name")==name){
				$this.remove();
				var vf = $("#"+options.id);
				var images = JSON.parse(vf.val());
				for(var i=0;i<images.length;i++){
					if(images[i].name==name){
						images.splice(i,1);
						vf.val(JSON.stringify(images));
						break;
					}
				}
			}
		});
	}
	
	
	
	$.fn.obpmWeixinImageUpload = function(options, param){
		if(typeof options=="string"){
			return $.fn.obpmWeixinImageUpload.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			
			var state = t.data("weixinImageUpload");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('weixinImageUpload', {
					options: $.extend({}, $.fn.obpmWeixinImageUpload.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmWeixinImageUpload.defaults = {
			id:'',
			name:'',
			value:null,
			discription:'',
			limitnumber:10,
			maxsize:10240,
			path:"ITEM_PATH",
			refreshOnChanged:null,
			readonly:false
			
	},
	
	$.fn.obpmWeixinImageUpload.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
			jq.each(function(){
				//nothing
			});
		}
	}
	
})(jQuery);
