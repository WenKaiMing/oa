/**
 * 共用JS组件
 * @author Happy
 */
var Components = {
	
	_initialized : false,
		
	UserSelect:{
		
		open : function(settings){
			art.dialog.data("args",{
				success : settings.success,
				selectMode : settings.selectMode
				//size : settings.size
			});
			var size = settings.size? settings.size: {width:'640px',height:'500px'};
			art.dialog.open("/obpm/portal/share/component/public/userselect.jsp",
					{
				width: size.width,
				height: size.height,
				title:"选择用户",
				fixed:true,
				ok:function(){
					var userSelect = art.dialog.data("UserSelect");
					return userSelect.success();
				},
				cancel:true
				/**
				cancel:function(here){
					var userSelect = art.dialog.data("UserSelect");
					return userSelect.cancle();
				}
				**/
			});
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
	$("html").append('<script src="/obpm/portal/share/component/public/artDialog/jquery.artDialog.js?skin=aero"></script>')
		.append('<script src="/obpm/portal/share/component/public/artDialog/artDialog.source.js"></script>')
		.append('<script src="/obpm/portal/share/component/public/artDialog/plugins/iframeTools.source.js"></script>');
	Components._initialized = true;
}