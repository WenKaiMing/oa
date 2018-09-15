;
/**
 * 微信录音控件
 * @author Happy
 * @param $
 */
(function($){
	
	/**
	 * 显示类型. 分别：1.只读(READONLY)2.修改(MODIFY),3.隐藏(HIDDEN),4.禁用(DISABLED)
	 */
	var DisplayType = {
			READONLY:1,//只读
			MODIFY:2,//修改
			HIDDEN:3,//隐藏
			DISABLED:4 //禁用
	};
	var timer = "";
	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		var name = options.name;
		var layoutType = options._layoutType;
		var discript = options.discript ? options.discript : name;
		var path = "",
			count = 0,
			hasValue = false,
			style = "";
			delStyle = "",
			playStyle = ";display:none;",
			horizontalClass = "",
			isReadonly = false;

		if(layoutType == LayoutType_Horizontal){
			horizontalClass = "flexbox";
		}	
		if(options.displayType ==DisplayType.READONLY || options.displayType ==DisplayType.DISABLED){
			style = ";display:none;";
			delStyle = ";display:none;";
			isReadonly = true;
		}
		if(options.value && options.value.length>0){
			style = ";display:none;";
			playStyle = "";
			hasValue = true;
			var voice = JSON.parse(options.value);
			path = contextPath + voice.path;
			count = voice.count ? voice.count : 0;
		}
		
		var data = {
				id : options.id,
				name : name,
				path : path,
				count : count,
				style : style,
				delStyle : delStyle,
				hasValue : hasValue,
				playStyle : playStyle,
				discript : discript,
				isReadonly : isReadonly,
				horizontalClass : horizontalClass
		};

		var $panel = $(template("recordPanel-tmpl", data));
		$bigRecBox = $(template("recordControl-tmpl", data));
		
		ajaxPage.getCurPage().append($bigRecBox);
		if(hasValue){
			if(isiOS){
				$panel.find("audio").load();
			}
		}
		
		$panel.insertAfter(t);
		
		return $panel;
	}
	
	
	/**
	 * 事件绑定
	 */
    function _bindEvents(t){
        var panel = t.data("weixinRecord").panel;
        var options = _parseOptions(t);
        var $bigRecBox = $("#wxRec_" + t.attr("id"));
        //触发录音
        panel.find(".startRecord").on("click",function(e){
            var options = t.data("weixinRecord").options;

            //判断接口
            var ua = window.navigator.userAgent;
            //indexOf() 方法可返回某个指定的字符串值在字符串中首次出现的位置
            if(ua.indexOf("myApps") >= 0) {
                _uploadRecordWithNative(t);//手机系统原生上传接口
            }else{
                _startRecord(t);//微信选择录音
                $bigRecBox.show();
                setTimeout(function(){
                    $bigRecBox.find(".recording-panel").addClass("active");
                },100);
                $bigRecBox.find(".record-play-ico").addClass("animate-play");
                timer = _getTimer(t);
                _startRecord(t,timer,$bigRecBox);
            }
        });
		
		$bigRecBox.find(".stopRecord").on("click",function(e){
			$bigRecBox.find(".recording-panel").removeClass("active");
			setTimeout(function(){
				$bigRecBox.hide();
			},1000);
			clearInterval(timer);
			t.data("timer",null);
			_stopRecord(t);
		});
		
		panel.find(".sound-play-box").on("click",function(e){
			if($(this).find(".sound-stop").size() > 0){
				_playVoice(t);
			}else if($(this).find(".sound-play").size() > 0){
				_stopVoice(t);
			}
		});

		panel.find(".btn-sound-delete").on("click",function(e){
			panel.find(".sound-delete-box").show().addClass("animated bounceIn");
		});
		panel.find(".btn-delete").on("click",function(e){
			_removeRecord(t);
		});
		panel.find(".btn-cancel").on("click",function(e){
			panel.find(".sound-delete-box").hide();
		});
		
	}
	
	/**
	 * 解析控件参数
	 */
	function _parseOptions(t){
		var options = {};
		options.id = t.attr("id");
		options.name = t.attr("name");
		options.discript = HTMLDencode(t.data("discription"))? HTMLDencode(t.data("discription")):options.name;
		options.value = t.val();
		options.displayType = t.data("displayType");
		options._layoutType = t.attr("_layoutType");
		return options;
	}
	
	/**
	 *	开始微信录音
	 */
	function _startRecord(t,timer,$bigRecBox){
		var _wx = top.wx ? top.wx : wx;
		_wx.startRecord();
		_wx.onVoiceRecordEnd({
			
		    // 录音时间超过一分钟没有停止的时候会执行 complete 回调
		    complete: function (res) {
		    	 var localId = res.localId;
		    	
		    	$bigRecBox.find(".recording-panel").removeClass("active");
				setTimeout(function(){
					$bigRecBox.hide();
				},1000);
				clearInterval(timer);
				t.data("timer",null);
		    	 
			    _uploadVoice(t,_wx,localId);
		    }
		});
	}
	
	/**
	 *	停止微信录音
	 */
	function _stopRecord(t){
		var _wx = top.wx ? top.wx : wx;
		_wx.stopRecord({
		    success: function (res) {
		        var localId = res.localId;
		        _uploadVoice(t,_wx,localId);
		    }
		});
	}
	/**
	 * 上传录音
	 */
	function _uploadVoice(t,_wx,localId){
		 _wx.uploadVoice({
	            localId: localId, // 需要上传的音频的本地ID，由stopRecord接口获得
	            isShowProgressTips: 1,// 默认为1，显示进度提示
	                success: function (res) {
	                var serverId = res.serverId; // 返回音频的服务器端ID
	                $.ajax({
			        	  url:contextPath+"/portal/weixin/jsapi/upload.action",
			        	  async:false,
			        	  type:"get",
			        	  data:{"serverId":serverId,"folder":"voice","fileType":"amr"},
			        	  dataType:"json",
			        	  success:function(result){
				    		  if(result.status==1){
					        	  var $bigRecBox = $("#wxRec_" + t.attr("id"));
					        	  var path = result.data.replace(".amr",".mp3");
					        	  var name = result.data.substring(result.data.lastIndexOf("/")+1,result.data.length);
					        	  var vioceItem = $('<audio><source src="'+contextPath+path+'" type="audio/mpeg" /></audio>');
					        	  t.data("voice",{"localId":localId,"path":path});
					      		  var panel = t.data("weixinRecord").panel;
					        	 panel.append(vioceItem);
					        	 _addRecord(t,{"path":path,"count":$bigRecBox.find(".time-total").text()});
					        	 $bigRecBox.find(".time-total").text(0);
					          }
					       }
			          });
	            },
	            fail: function (res) {
			          alert("网络异常，请再次尝试！");
		        }
	        });
	}

    //手机原生接口
    function _uploadRecordWithNative(t){
        var panel = t.data("weixinRecord").panel;
        var options = t.data("weixinRecord").options;

        var _nativeAPI = top.nativeAPI ? top.nativeAPI : nativeAPI;
        _nativeAPI.startRecord({
            success: function (res) {
                var datas = JSON.parse(res);
                var path = datas.path;//.replace(".amr",".mp3");//音频文件路径
                var size = datas.size;//文件大小
                var length = datas.len;//音频文件时长（秒）
                var $bigRecBox = $("#wxRec_" + t.attr("id"));
                var name = datas.path.substring(datas.path.lastIndexOf("/")+1,datas.path.length);
                var vioceItem = $('<audio><source src="'+contextPath+path+'" type="audio/mpeg" /></audio>');
                var panel = t.data("weixinRecord").panel;
                panel.append(vioceItem);
                _addRecord(t,{"path":path,"count":$bigRecBox.find(".time-total").text()});
                $bigRecBox.find(".time-total").text(0);
            }
        });
    }

	/**
	 * 播放录音
	 */
	function _playVoice(t){
		var panel = t.data("weixinRecord").panel;
		panel.find(".play-ico").removeClass("sound-stop").addClass("sound-play");
		var voice = t.data("voice");
		var count = JSON.parse(t.val()).count;
		if(voice){
			var _wx = top.wx ? top.wx : wx;
			_wx.playVoice({
			    localId: voice.localId // 需要播放的音频的本地ID，由stopRecord接口获得
			});
		}else{
			var panel = t.data("weixinRecord").panel;
			panel.find("audio")[0].play();
			
		}
		setTimeout(function(){
			panel.find(".play-ico").removeClass("sound-play").addClass("sound-stop");
		},count*1000)
	}
	/**
	 * 暂停播放录音
	 */
	function _stopVoice(t){
		var panel = t.data("weixinRecord").panel;
		panel.find(".play-ico").removeClass("sound-play").addClass("sound-stop");
		var voice = t.data("voice");
		if(voice && false){
			var _wx = top.wx ? top.wx : wx;
			_wx.stopVoice({
			    localId: voice.localId // 需要播放的音频的本地ID，由stopRecord接口获得
			});
		}else{
			panel.find("audio")[0].pause();
		}
	}
	
	/**
	 * 添加录音记录
	 */
	function _addRecord(t,data){
		var state = t.data("weixinRecord");
		var options = state.options;
		var panel = state.panel;
		var vf = $("#"+options.id);
		vf.val(JSON.stringify(data));
		var vioceItem = panel.find("audio");
		if(isiOS){
			vioceItem.load();
		}
		vioceItem.on("canplay", function(){
			panel.find(".sound-play-time").text(Math.round(this.duration)+"\"");
		});
		panel.find(".sound-play-time").text(data.count);
		panel.find(".player-panel").show();
		panel.find(".record-panel").hide();
	}
	/**
	 * 删除录音记录
	 */
	function _removeRecord(t){
		var state = t.data("weixinRecord");
		var panel =state.panel;
		var options = state.options;
		var vf = $("#"+options.id);
		vf.val("");
		panel.find(".sound-delete-box").hide();
		panel.find(".player-panel").hide();
		panel.find(".record-panel").show();
	}
	
	/**
	 * 获取录音计时器
	 */
	function _getTimer(t){
		var panel = t.data("weixinRecord").panel;
		var $bigRecBox = $("#wxRec_" + t.attr("id"));
		var timer = setInterval(function(){
				var tl = $bigRecBox.find(".time-total");
				tl.text(parseInt(tl.text())+1);
		},1000);
		return timer;
	} 
	
	$.fn.obpmWeixinRecord = function(options, param){
		
		if(typeof options=="string"){
			return $.fn.obpmWeixinRecord.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("weixinRecord");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('weixinRecord', {
					options: $.extend({}, $.fn.obpmWeixinRecord.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmWeixinRecord.defaults = {
			id:'',
			name:'',
			value:'',
			discription:'',
			displayType:null
	},
	
	$.fn.obpmWeixinRecord.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
			jq.each(function(){
				//nothing
			});
		}
	}
	
})(jQuery);
