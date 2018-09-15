/**
 * phone 皮肤弹出层组件、在页面上已单例的形式存在
 */
var MyPopup = MyPopup || {
	
	_initialized : false,
	
	_modal : undefined,
	
	_callback : undefined,
	
	init : function(){
		//MyPopup.cache.clear();
		this._modal = $("#myModalexample");
		
		$("#myModalexample").on("popup",function(e){
			alert('popup');
		});

		$("#myModalexample").on("close",function(e){
			$(this).removeClass("active");
			if(MyPopup._callback && typeof MyPopup._callback == "function"){
				MyPopup._callback();
			}
		});
		
		
		
	},
		
	open : function(settings){
		settings = settings || {};
		var url = settings.url;
		var title = settings.title;
		var successCallback = settings.success;
		var closeCallback = settings.close;
		var options = settings.options || {};
		MyPopup._callback = successCallback;
		//MyPopup.cache.set("success",successCallback);
		$("#myModalexample .title").html(title);
		$("#myModalexample").find("iframe").attr("src",url);
		$("#myModalexample").addClass("active");
	},
	
	MyPopupClose : function(){
		Activity.closeWindow();
	},
	
};

/**
 * 缓存
 */
MyPopup.cache = {
	
		get:function(key){
			var top = window.top, 
			cache = top['_CACHE'] || {}; 
			top['_CACHE'] = cache;
			return cache[key];
		},
		
		set:function(key,value){
			var top = window.top, 
			cache = top['_CACHE'] || {}; 
			top['_CACHE'] = cache;
			cache[key]=value;
		},
		clear:function(key){
			var top = window.top, 
			cache = top['_CACHE'] || {}; 
			top['_CACHE'] = cache;
			if(cache[key]) delete cache[key];
			if(!key) top['_CACHE'] = {};
		}
};

//if(!MyPopup._initialized){
//	$(document).ready(function(){
//		$("body").append('<div id="myModalexample" class="modal modal-iframe">'+
//				  '<header class="bar bar-nav">'+
//				    '<a class="icon icon-close pull-right" id="btn-modal-close" onclick="MyPopup.MyPopupClose()"></a>'+
//				    '<h1 class="title">创建</h1>'+
//				  '</header>'+
//				  '<div class="content">'+
//				    '<iframe src="about:blank" width="100%" height="100%"></iframe>'+
//				  '</div>'+
//				'</div>');
//		MyPopup.init();
//		MyPopup._initialized = true;
//	});
//	
//}