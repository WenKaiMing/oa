;
/**
 * 金格iwebOffice2015控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var options = _parseOptions(t);
		var displayType = options.displayType;
		var v = t.val();
		var panle = "";
		
		var html="";
		var url = contextPath + "/portal/share/component/webofficeField/vendor/content.jsp?jsessionid="+jsessionid+"&FileType=.doc&fullPath="+options.fullPath;
		url+="&id="+options.id;
		url+="&saveable=" + options.saveable + "";
		url+="&applicationId=" + options.applicationId;
		url+="&fileType=" + options.fileType;
		url+="&path=" + options.path;
		url+="&fileName=" + options.fileName;
		url+="&signature=" + options.signature;
		url+="&showTrace=" + options.showTrace;
		url+="&addTemplate=" + options.addTemplate;
		url+="&addWaterMark=" + options.addWaterMark;
		
		if(options.openType=="3"){//弹出层打开
			html+="<button class='button-class' type='button'";
			if(displayType == PermissionType_READONLY){
				html +=" readonly";
			}
			html+=">";
			html+=" <img src='../../share/images/view/word.gif'></img>";
			html+="</button>";
			panel = $(html);
			
			panel.bind("click",function(){
				_open(url);
			})
		}else if(options.openType=="1"){//嵌入表单
			debugger;
			var targetUrl = url;
			if(!_isIE()){
				targetUrl = contextPath + "/portal/share/component/webofficeField/vendor/preview.jsp?jsessionid="+jsessionid+"&FileType=.doc&fullPath="+options.fullPath;
				targetUrl+="&id="+options.id;
				targetUrl+="&saveable=" + options.saveable + "";
				targetUrl+="&applicationId=" + options.applicationId;
				targetUrl+="&fileType=" + options.fileType;
				targetUrl+="&path=" + options.path;
				targetUrl+="&fileName=" + options.fileName;
				targetUrl+="&signature=" + options.signature;
				targetUrl+="&showTrace=" + options.showTrace;
				targetUrl+="&addTemplate=" + options.addTemplate;
				targetUrl+="&addWaterMark=" + options.addWaterMark;
				targetUrl+="&showName=" + options.name;
			}
			html+="<iframe fieldName='" + options.name + "' id='" + options.id + "' ";
			html+=" name='iframe_" + options.name + "' frameborder='0' width='100%' height='645px' scrolling='no' style='overflow:visible;z-index:-1px;' ";
			html+=" src='" + targetUrl+"' ></iframe>";
			panel = $(html);
		}
		panel.insertAfter(t);
		return panel;
	}
	
	function _isIE() { //ie?
		 if(!!window.ActiveXObject || "ActiveXObject" in window){
			 return true;	 
		 }else{
			 return false;
		 }
	 }
	

	/**
	 * 用金格浏览器打开office在线编辑页面
	 * @param aurl
	 * 		文件地址
	 */
	function _open(aurl) {
				$.ajax({
					type: "get",  
					async: false,  
					url: "http://127.0.0.1:9588/LongListen?id=111", 
					jsonp: "hookback",
					dataType: "jsonp",  
					success: function(data){
						//Link(aurl, 4);
						_startBrowser(aurl,1);
					},  
					error: function(){  
						alert('金格浏览器没有安装,请下载安装！');
						window.open(mHttpUrl+contextPath + "/portal/share/component/webofficeField/vendor/KGBrowserV1.0.0.72.msi"); 
					}  
				}); 
				
				// ie 8+, chrome and some other browsers
				var head = document.head || $('head')[0] || document.documentElement;// code from jquery
				var script = $(head).find('script')[0];
				script.onerror = function(evt) 
				{ 
					alert('金格浏览器没有安装,请下载安装！');
					window.open(mHttpUrl+contextPath + "/portal/share/component/webofficeField/vendor/KGBrowserV1.0.0.72.msi"); 
					// do some clean  
					// delete script node  
					if (script.parentNode) 
					{     
						script.parentNode.removeChild(script);
					}
					// delete jsonCallback global function
					var src = script.src || '';  
					var idx = src.indexOf('hookback='); 
					if (idx != -1) 
					{
						var idx2 = src.indexOf('&');
						if (idx2 == -1)
						{     
							idx2 = src.length;
						}      
						var hookback = src.substring(idx + 13, idx2);
						delete window[hookback];
					}
				}; 					
				 
	}
	  
	function _link(url,skin) {
		var  link = "KGBrowser://$link:<%=mHttpUrl%>"+url+"$skin="+skin+"$tabshow=1";   // skin  0灰色 1蓝色 2黄色 3绿色 4红色 
		location.href = link;
		_connect();
	}
	function _startBrowser(weburl, skin){
//		var mHttpUrl = "http://localhost:8080";
		urlString = "http://127.0.0.1:9588/StartBrowser?weburl="+mHttpUrl+weburl+"$skin="+skin+"$tabshow=1";

		$.ajax({  
			type: "get",  
			async: false,  
			url: urlString, 
			jsonp: "hookback",
			dataType: "jsonp",  
			success: function(data){ 
				var jsonobj = eval(data);
				_connect();
			},  
			error: function(){  
			}  
		});  
	}

	/**
	 * 与金格浏览器页面通讯使用
	 */
	function _connect()	{
		$.ajax({
			type: "get",
			async: false,
			url: "http://127.0.0.1:9588/LongListen?id=111", //此代码ip固定，端口号与Edit页面该方法一致，其他固定。
			jsonp: "hookback",
			dataType: "jsonp",
			success: function (data) {
				var jsonobj = eval(data);
				if (jsonobj.ret == "save")
				{ //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
				//	alert("save");
					setTimeout("location.reload();", 100);
				}
				if (jsonobj.ret == "returnlist")
				{ //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
				//alert("returnlist");
					setTimeout("location.reload();", 100);
				} 
				else if (jsonobj.ret == "none") 
				{
					_connect();    //这里一定要调用，不可删除
				}
			},
			error: function (a, b, c) {
			}
		});
	}
	
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		/*var panel = t.data("webOfficeField").panel;		
		panel.on("click",function(e){
			e.preventDefault();
			e.stopPropagation();
		});*/
	}
	
	/**
	 * 解析控件设置参数
	 */
	function _parseOptions(t){
		var options = {}
		options.id= t.attr("id");
		options.name = t.attr("name");
		options.value= t.data("itemValue");
		options.formName = t.data("formName");
		options.docId = t.data("docId");
		options.fieldId = t.data("fieldId");
		options.openType = t.data("openType");
		options.displayType = t.data("displayType");
		options.saveable = t.data("saveable");
		options.applicationId = t.data("application");
		options.path = t.data("path");
		options.fullPath = t.data("fullPath");
		options.fileName = t.data("fileName");
		options.showName = t.data("showName");
		options.fileType = t.data("fileType");
		options.signature = t.data("signature");
		options.showTrace = t.data("showTrace");
		options.addTemplate = t.data("addTemplate");
		options.addWaterMark = t.data("addWaterMark");
		return options;
	}
	
	$.fn.obpmWebOfficeField = function(options, param){
		
		if(typeof options=="string"){
			return $.fn.obpmWebOfficeField.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("webOfficeField");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('webOfficeField', {
					options: $.extend({}, $.fn.obpmWebOfficeField.defaults, _parseOptions(t), options),
					panel: r
				});
				
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmWebOfficeField.defaults = {
			id:'',
			name:undefined
	},
	
	$.fn.obpmWebOfficeField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
		}
	}
	
})(jQuery);
