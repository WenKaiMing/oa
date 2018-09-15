/**
 * 共用JS组件
 * @author Happy
 */
var Components = {
	
	_initialized : false,
		
	UserSelect:{
		
		open : function(settings){
			settings = settings || {};
			var successCallback = settings.success;
			var singleSelect = settings.singleSelect || false;
			var options = settings.options || {};
			
			Components.cache.set("success",successCallback);
			Components.cache.set("singleSelect",singleSelect);
			$.mobile.changePage("#selectuser_page",options);
			//$("#userselect_iframe").height($("body").height()-10);
			$("#userselect_iframe").height($(window).height());
			$("#userselect_iframe").attr("src","/obpm/portal/share/component/public/userselect_mobile.jsp");
		},
	},
	
};

/**
 * 缓存
 */
Components.cache = {
	
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
		}
};

if(!Components._initialized){
	$("body").append('<div data-role="page" id="selectuser_page"><iframe id="userselect_iframe" frameborder="0" height="100%" width="100%" style="background: url(\'\') center no-repeat; height: 100%; width: 100%; border: 0px;"></iframe></div>');
	Components._initialized = true;
}